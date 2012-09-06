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

#import "LolayBangoTracker.h"
#import <Bango/BGOAnalyticsConstants.h>
#import <Bango/BGOAnalyticsManager.h>
#import <Bango/BangoConfigConstants.h>
#import <Bango/BGOTransmissionModeConstants.h>
#include <sys/sysctl.h>

@interface LolayBangoTracker ()

@property (nonatomic, strong, readwrite) NSMutableDictionary* globalParametersValue;

@end

@implementation LolayBangoTracker

@synthesize globalParametersValue = globalParametersValue_;

- (id) initWithApplicationId:(NSString*) applicationId applicationType:(NSString*) applicationType channel:(NSString*) channel {
    if ((self = [super init])) {
        BGOAnalyticsManager *analytics = [BGOAnalyticsManager sharedManager];
        // config options here
        analytics.findLocation = NO;
        analytics.debugLog = YES;
        analytics.applicationChannel = channel;
        analytics.applicationType = applicationType;
        analytics.continueSessionSeconds = 10;
        analytics.postUrl = BGO_SETTING_POST_URL_DEBUG;
        // enable / disable event logging
        analytics.logEnabled = YES;
        // set transmission to automatic
        analytics.automaticDataTransmission = YES;
        // start the session
        [analytics onStartSessionWithApplicationId:applicationId];
    }
    return self;
}

- (void) setIdentifier:(NSString*) identifier {
    [[BGOAnalyticsManager sharedManager] onStartSessionWithApplicationId:identifier];
}

- (void) setVersion:(NSString*) version {
    [BGOAnalyticsManager sharedManager].applicationVersion = version;
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
    NSMutableDictionary* bangoParameters;
    
    if (parameters == nil) {
        bangoParameters = [[NSMutableDictionary alloc] initWithCapacity:4 + self.globalParametersValue.count];
    } else {
        bangoParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    }
    
    if (self.globalParametersValue) {
        [bangoParameters addEntriesFromDictionary:self.globalParametersValue];
    }
    
    NSString* machine = [self machine];
    NSString* model = [[UIDevice currentDevice] model];
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString* systemName = [[UIDevice currentDevice] systemName];
	NSString* platform = [NSString stringWithFormat:@"%@ (%@): %@ %@", model, machine, systemName, systemVersion];
    [bangoParameters setObject:platform forKey:@"bgo_custom8"];
    [bangoParameters setObject:[[NSLocale currentLocale] localeIdentifier] forKey:@"bgo_custom9"];
	
	DLog(@"bangoParameters=%@", bangoParameters);
    
    return bangoParameters;
}

- (void) logEvent:(NSString*) name {
    [[BGOAnalyticsManager sharedManager] onEvent:name eventDetail:nil eventValue:nil eventParameters:[self buildParameters:nil]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [[BGOAnalyticsManager sharedManager] onEvent:name eventDetail:nil eventValue:nil eventParameters:[self buildParameters:parameters]];
}

- (void) logPage:(NSString*) name {
    [self logEvent:name];
    [[BGOAnalyticsManager sharedManager] onPageViewWithEventParameters:[self buildParameters:nil] eventDetail:name eventValue:nil];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [self logEvent:name withDictionary:parameters];
    [[BGOAnalyticsManager sharedManager] onPageViewWithEventParameters:[self buildParameters:parameters] eventDetail:name eventValue:nil];
}

- (void) logException:(NSException*) exception {
    [[BGOAnalyticsManager sharedManager] onErrorWithEventParameters:[self buildParameters:nil] message:exception.reason eventClass:@"Exception" eventErrorLevel:[NSNumber numberWithInt:BGO_ERROR_INTERNAL_CRITICAL] eventErrorId:exception.name];
}

- (void) logError:(NSError*) error {
    [[BGOAnalyticsManager sharedManager] onErrorWithEventParameters:[self buildParameters:nil] message:error.localizedDescription eventClass:@"Error" eventErrorLevel:[NSNumber numberWithInt:BGO_ERROR_INTERNAL_CRITICAL] eventErrorId:[NSString stringWithFormat:@"%@:%i", error.domain, error.code]];
}

- (void) onResume {
    [[BGOAnalyticsManager sharedManager] onResumeWithEventParameters:[self buildParameters:nil] eventDetail:@"onResume" eventValue:nil];
}

- (void) onTerminate {
    [[BGOAnalyticsManager sharedManager] onEndSessionWithEventParameters:[self buildParameters:nil] eventDetail:@"onTerminate" eventValue:nil];
}

@end
