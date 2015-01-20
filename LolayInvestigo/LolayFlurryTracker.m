//
//  Copyright 2012-2014 Lolay, Inc.
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
#import "Flurry.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "LolayInvestigoGlobals.h"

@interface LolayFlurryTracker ()

@property (nonatomic, strong, readwrite) NSMutableDictionary* globalParametersValue;

@end

@implementation LolayFlurryTracker

@synthesize globalParametersValue = globalParametersValue_;

- (id) initWithKey:(NSString*) key version:(NSString*) version crashReportingEnabled:(BOOL) crashReportingEnabled debug:(BOOL) debug {
    self = [super init];
    if (self) {
        [Flurry setShowErrorInLogEnabled:debug];
		[Flurry setDebugLogEnabled:debug];
        [Flurry setAppVersion:version];
		[Flurry setCrashReportingEnabled:crashReportingEnabled];
        [Flurry startSession:key];
    }
    
    return self;
}

- (id) initWithKey:(NSString*) key version:(NSString*) version crashReportingEnabled:(BOOL) crashReportingEnabled {
    self = [self initWithKey:key version:version crashReportingEnabled:crashReportingEnabled debug:NO];
    return self;
}

- (id) initWithKey:(NSString*) key version:(NSString*) version {
    self = [self initWithKey:key version:version crashReportingEnabled:YES debug:NO];
    return self;
}

- (id) initWithKey:(NSString*) key {
	NSString* version = [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleVersion"];
    self = [self initWithKey:key version:version crashReportingEnabled:YES debug:NO];
    return self;
}

- (void) setIdentifier:(NSString*) identifier {
    [Flurry setUserID:identifier];
}

- (void) setVersion:(NSString*) version {
	[Flurry setAppVersion:version];
}

- (void) logPurchase:(NSDictionary *)purchaseData{
	
}

- (void) logRegistration:(NSDictionary *)userData{
	
}

- (void) setAge:(NSUInteger) age {
    [Flurry setAge:(int) age];
}

- (void) setGender:(LolayTrackerGender) gender {
    if (gender == LolayTrackerGenderMale) {
        [Flurry setGender:@"m"];
    } else if (gender == LolayTrackerGenderFemale) {
        [Flurry setGender:@"f"];
    } else {
        [Flurry setGender:nil];
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
    NSMutableDictionary* flurryParameters;
    
    if (parameters == nil) {
        flurryParameters = [[NSMutableDictionary alloc] initWithCapacity:4 + self.globalParametersValue.count];
    } else {
        flurryParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    }
    
    if (self.globalParametersValue) {
        [flurryParameters addEntriesFromDictionary:self.globalParametersValue];
    }
    
    NSString* machine = [self machine];
    NSString* model = [[UIDevice currentDevice] model];
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString* systemName = [[UIDevice currentDevice] systemName];
	NSString* platform = [NSString stringWithFormat:@"%@ (%@): %@ %@", model, machine, systemName, systemVersion];
	NSString* locale = [[NSLocale currentLocale] localeIdentifier];
	NSString* language = [[NSLocale preferredLanguages] objectAtIndex:0];
    [flurryParameters setObject:platform forKey:@"platform"];
    [flurryParameters setObject:locale forKey:@"locale"];
    [flurryParameters setObject:language forKey:@"language"];
	
	DLog(@"flurryParameters=%@", flurryParameters);
    
    return flurryParameters;
}

- (void) logEvent:(NSString*) name {
    [Flurry logEvent:name withParameters:[self buildParameters:nil]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [Flurry logEvent:name withParameters:[self buildParameters:parameters]];
}

- (void) logPage:(NSString*) name {
    [Flurry logEvent:name withParameters:[self buildParameters:nil]];
	[Flurry logPageView];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [Flurry logEvent:name withParameters:[self buildParameters:parameters]];
	[Flurry logPageView];
}

- (void) logException:(NSException*) exception {
    [Flurry logError:exception.name message:exception.reason exception:exception];
}

- (void) logError:(NSError*) error {
    [Flurry logError:[NSString stringWithFormat:@"%@:%li", error.domain, (long) error.code] message:error.localizedDescription error:error];
}

- (void) logTiming:(NSDictionary*)timingData{
	
}

- (void) registerDeviceToken:(NSData*) deviceToken {
	NSString* token = [deviceToken description];
	token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
	token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
	token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
	token = [token uppercaseString];
	[Flurry setPushToken:token];
}

@end
