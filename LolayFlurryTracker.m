//
//  Copyright 2012 Lolay, Inc.
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

#import "LolayFlurryTracker.h"
#import "FlurryAnalytics.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@interface LolayFlurryTracker ()

@property (nonatomic, strong, readwrite) NSMutableDictionary* globalParametersValue;

@end

@implementation LolayFlurryTracker

@synthesize globalParametersValue = globalParametersValue_;

- (id) initWithKey:(NSString*) key {
    self = [super init];
    if (self) {
#ifndef __OPTIMIZE__
        [FlurryAnalytics setShowErrorInLogEnabled:YES];
#endif        
        [FlurryAnalytics setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
        [FlurryAnalytics startSession:key];
    }
    
    return self;
}

- (id) initWithKey:(NSString*) key version:(NSString*) version {
    self = [super init];
    if (self) {
#ifndef __OPTIMIZE__
        [FlurryAnalytics setShowErrorInLogEnabled:YES];
#endif        
        [FlurryAnalytics setAppVersion:version];
        [FlurryAnalytics startSession:key];
    }
    
    return self;
}

- (void) setIdentifier:(NSString*) identifier {
    [FlurryAnalytics setUserID:identifier];
}

- (void) setVersion:(NSString*) version {
	[FlurryAnalytics setAppVersion:version];
}

- (void) setAge:(NSUInteger) age {
    [FlurryAnalytics setAge:age];
}

- (void) setGender:(LolayTrackerGender) gender {
    if (gender == LolayTrackerGenderMale) {
        [FlurryAnalytics setGender:@"m"];
    } else if (gender == LolayTrackerGenderFemale) {
        [FlurryAnalytics setGender:@"f"];
    } else {
        [FlurryAnalytics setGender:nil];
    }
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    self.globalParametersValue = [NSMutableDictionary dictionaryWithDictionary:globalParameters];
}

- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key {
	if (self.globalParametersValue == nil) {
		self.globalParametersValue = [NSMutableDictionary dictionary];
	}
	[self.globalParametersValue setObject:object forKey:key];
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

- (NSDictionary*) buildParameters:(NSDictionary*) parameters {
    NSMutableDictionary* FlurryAnalyticsParameters;
    
    if (parameters == nil) {
        FlurryAnalyticsParameters = [[NSMutableDictionary alloc] initWithCapacity:4 + self.globalParametersValue.count];
    } else {
        FlurryAnalyticsParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    }
    
    if (self.globalParametersValue) {
        [FlurryAnalyticsParameters addEntriesFromDictionary:self.globalParametersValue];
    }
    
    NSString* machine = [self machine];
    NSString* model = [[UIDevice currentDevice] model];
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString* systemName = [[UIDevice currentDevice] systemName];
	NSString* platform = [NSString stringWithFormat:@"%@ (%@): %@ %@", model, machine, systemName, systemVersion];
    [FlurryAnalyticsParameters setObject:platform forKey:@"platform"];
    [FlurryAnalyticsParameters setObject:[[NSLocale currentLocale] localeIdentifier] forKey:@"locale"];
	
	DLog(@"FlurryAnalyticsParameters=%@", FlurryAnalyticsParameters);
    
    return FlurryAnalyticsParameters;
}

- (void) logEvent:(NSString*) name {
    [FlurryAnalytics logEvent:name withParameters:[self buildParameters:nil]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [FlurryAnalytics logEvent:name withParameters:[self buildParameters:parameters]];
}

- (void) logPage:(NSString*) name {
    [FlurryAnalytics logEvent:name withParameters:[self buildParameters:nil]];
	[FlurryAnalytics logPageView];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [FlurryAnalytics logEvent:name withParameters:[self buildParameters:parameters]];
	[FlurryAnalytics logPageView];
}

- (void) logException:(NSException*) exception {
    [FlurryAnalytics logError:exception.name message:exception.reason exception:exception];
}

- (void) logError:(NSError*) error {
    [FlurryAnalytics logError:[NSString stringWithFormat:@"%@:%i", error.domain, error.code] message:error.localizedDescription error:error];
}

@end
