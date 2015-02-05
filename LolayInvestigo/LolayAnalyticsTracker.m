//
//  Copyright 2014 Lolay, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "LolayAnalyticsTracker.h"
#import <Analytics/Analytics.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <UIKit/UIKit.h>

@interface LolayAnalyticsTracker ()

@property (nonatomic, strong, readwrite) SEGAnalytics* analytics;
@property (nonatomic, strong, readwrite) NSString* identifer;
@property (nonatomic) NSUInteger age;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *phone;
@property (nonatomic) LolayTrackerGender gender;
@property (strong, nonatomic) NSMutableDictionary *mutableGlobalParameters;

@end

@implementation LolayAnalyticsTracker

- (id) initWithSecret:(NSString*) secret debug:(BOOL) debug {
	self = [super init];
	if (self) {
		[SEGAnalytics debug:debug];
        [SEGAnalytics setupWithConfiguration:[SEGAnalyticsConfiguration configurationWithWriteKey:secret]];
        self.analytics = [SEGAnalytics sharedAnalytics];
	}
	return self;
}

- (id) initWithSecret:(NSString*) secret {
	self = [self initWithSecret:secret debug:NO];
	return self;
}

- (instancetype)initWithSecret:(NSString *)secret trackLocation:(BOOL)trackLocation debug:(BOOL)debug
{
    if (self = [super init]) {
        [SEGAnalytics debug:debug];
        SEGAnalyticsConfiguration *configuration = [SEGAnalyticsConfiguration configurationWithWriteKey:secret];
        configuration.shouldUseLocationServices = trackLocation;
        [SEGAnalytics setupWithConfiguration:configuration];
        self.analytics = [SEGAnalytics sharedAnalytics];
    }
    
    return self;
}

#pragma mark - Custom accessors

- (void) setIdentifier:(NSString*) identifier {
    _identifer = identifier;
}

- (void) setFirstName: (NSString *) firstName {
    _firstName = firstName;
}

- (void) setLastName: (NSString *) lastName {
    _lastName = lastName;
}

- (void) setEmail: (NSString *) email {
    _email = email;
}

- (void) setCity: (NSString *) city {
    _city = city;
}

- (void) setState: (NSString *) state {
    _state = state;
}

- (void) setZip: (NSString *) zip {
    _zip = zip;
}

- (void) setPhone: (NSString *) phone {
    _phone = phone;
}

- (void) setAge:(NSUInteger) age {
    _age = age;
}

- (void) setGender:(LolayTrackerGender) gender {
    _gender = gender;
}

- (NSMutableDictionary *)mutableGlobalParameters {
    if (!_mutableGlobalParameters) _mutableGlobalParameters = [NSMutableDictionary new];
    return _mutableGlobalParameters;
}

- (void)setGlobalParameters:(NSDictionary *)globalParameters {
    self.mutableGlobalParameters = [NSMutableDictionary dictionaryWithDictionary:globalParameters];
}

#pragma mark - Public methods

- (void)setGlobalParameter:(NSString *)object forKey:(NSString *)key {
    self.mutableGlobalParameters[key] = object;
}

- (void) logIdentity
{
    NSMutableDictionary *traits = [NSMutableDictionary dictionary];
    if (self.age) traits[@"age"] = [NSString stringWithFormat:@"%ld", (long)self.age];
    if (self.firstName) traits[@"firstName"] = self.firstName;
    if (self.lastName) traits[@"lastName"] = self.lastName;
    if (self.email) traits[@"email"] = self.email;
    if (self.city) traits[@"city"] = self.city;
    if (self.state) traits[@"state"] = self.state;
    if (self.zip) traits[@"zip"] = self.zip;
    if (self.phone) traits[@"phone"] = self.phone;
    if (self.gender == LolayTrackerGenderMale) {
        traits[@"gender"] = @"m";
    } else if (self.gender == LolayTrackerGenderFemale) {
        traits[@"gender"] = @"f";
    } else {
        traits[@"gender"] = @"unknown";
    }
    
    [self.analytics identify:self.identifer traits:traits];
}

- (NSString*) machine {
	size_t size;
	int mib[2] = {CTL_HW, HW_MACHINE};
	sysctl(mib, 2, NULL, &size, NULL, 0);
	char* machine = malloc(size);
	sysctl(mib, 2, machine, &size, NULL, 0);
	NSString* machineString = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
	free(machine);
	return machineString;
}

- (void) logEvent:(NSString*) name {
	[self.analytics track:name properties:[self aggregatedParametersWithParameters:nil]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self.analytics track:name properties:[self aggregatedParametersWithParameters:parameters]];
}

- (void) logPage:(NSString*) name {
	[self.analytics screen:name properties:[self aggregatedParametersWithParameters:nil]];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self.analytics screen:name properties:[self aggregatedParametersWithParameters:parameters]];
}

- (NSString*) valueOrNone:(NSString*) value {
	if (value.length == 0) {
		return @"none";
	} else {
		return value;
	}
}

- (void) logException:(NSException*) exception {
	NSString* name = [self valueOrNone:exception.name];
	NSString* reason = [self valueOrNone:exception.reason];
	[self logEvent:@"exception" withDictionary:@{@"name": name, @"reason": reason}];
}

- (void) logError:(NSError*) error {
	NSString* domain = [self valueOrNone:error.domain];
	NSString* code = [NSString stringWithFormat:@"%li", (long) error.code];
	NSString* localizedDescription = [self valueOrNone:error.localizedDescription];
	NSString* localizedFailureReason = [self valueOrNone:error.localizedFailureReason];
	NSString* localizedRecoverySuggestion = [self valueOrNone:error.localizedRecoverySuggestion];
	[self logEvent:@"error" withDictionary:@{@"domain": domain, @"code": code, @"localizedDescription": localizedDescription, @"localizedFailureReason": localizedFailureReason, @"localizedRecoverySuggestion": localizedRecoverySuggestion}];
}

- (void) registerDeviceToken:(NSData*) deviceToken {
    // We pass an options dictionary to explicitly disallow sending the
    // registerDeviceToken event for Flurry integrations. This is due to a bug
    // in the Flurry SDK that causes the app to crash.
    //
    // See https://github.com/segmentio/analytics-ios/issues/159
    //
    [self.analytics registerForRemoteNotificationsWithDeviceToken:deviceToken options:@{ @"integrations": @{ @"Flurry" : @(NO) } }];
}

#pragma mark - Private methods

// Convenience method to provide an aggregation of a dictionary of parameters
// (i.e. properties) with the global parameters
- (NSDictionary *)aggregatedParametersWithParameters:(NSDictionary *)parameters {
    if (self.mutableGlobalParameters.count > 0) {
        NSMutableDictionary *mutableParameters = [self.mutableGlobalParameters mutableCopy];
        [mutableParameters addEntriesFromDictionary:parameters];
        parameters = [mutableParameters copy];
    }
    return parameters;
}

@end
