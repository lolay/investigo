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

@property (nonatomic, strong, readwrite) NSString* identifer;
@property (nonatomic, strong, readwrite) Analytics* analytics;

@end

@implementation LolayAnalyticsTracker

- (id) initWithSecret:(NSString*) secret debug:(BOOL) debug {
	self = [super init];
	if (self) {
		[Analytics debug:debug];
		[Analytics initializeWithSecret:secret];
		self.analytics = [Analytics sharedAnalytics];
	}
	return self;
}

- (id) initWithSecret:(NSString*) secret {
	self = [self initWithSecret:secret debug:NO];
	return self;
}

- (void) setIdentifier:(NSString*) identifier {
	self.identifer = identifier;
	[self.analytics identify:identifier];
}

- (void) setAge:(NSUInteger) age {
	NSString* ageString = [NSString stringWithFormat:@"%li", (long) age];
	[self.analytics identify:self.identifer traits:@{@"age": ageString}];
}

- (void) setGender:(LolayTrackerGender) gender {
	NSString* genderString = nil;
    if (gender == LolayTrackerGenderMale) {
		genderString = @"m";
    } else if (gender == LolayTrackerGenderFemale) {
		genderString = @"f";
    } else {
		genderString = @"none";
    }
	
	[self.analytics identify:self.identifer traits:@{@"gender": genderString}];
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
	[self.analytics track:name];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self.analytics track:name properties:parameters];
}

- (void) logPage:(NSString*) name {
	[self.analytics screen:name];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self.analytics screen:name properties:parameters];
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
	[self.analytics registerPushDeviceToken:deviceToken];
}

@end
