//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayFlurryTracker.h"
#import "FlurryAPI.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@interface LolayFlurryTracker ()

@property (nonatomic, retain, readwrite) NSDictionary* globalParametersValue;

@end

@implementation LolayFlurryTracker

@synthesize globalParametersValue = globalParametersValue_;

- (id) initWithKey:(NSString*) key {
    self = [super init];
    if (self) {
#ifndef __OPTIMIZE__
        [FlurryAPI setShowErrorInLogEnabled:YES];
#endif        
        [FlurryAPI setAppVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
        [FlurryAPI startSession:key];
    }
    
    return self;
}

- (void) setIdentifier:(NSString*) identifier {
    [FlurryAPI setUserID:identifier];
}

- (void) setAge:(NSUInteger) age {
    [FlurryAPI setAge:age];
}

- (void) setGender:(LolayTrackerGender) gender {
    if (gender == LolayTrackerGenderMale) {
        [FlurryAPI setGender:@"m"];
    } else if (gender == LolayTrackerGenderFemale) {
        [FlurryAPI setGender:@"f"];
    } else {
        [FlurryAPI setGender:nil];
    }
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    self.globalParametersValue = globalParameters;
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
    [flurryParameters setObject:platform forKey:@"platform"];
    [flurryParameters setObject:[[NSLocale currentLocale] localeIdentifier] forKey:@"locale"];
	
	DLog(@"flurryParameters=%@", flurryParameters);
    
    return [flurryParameters autorelease];
}

- (void) logEvent:(NSString*) name {
    [FlurryAPI logEvent:name withParameters:[self buildParameters:nil]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [FlurryAPI logEvent:name withParameters:[self buildParameters:parameters]];
}

- (void) logPage:(NSString*) name {
    [FlurryAPI logEvent:name withParameters:[self buildParameters:nil]];
	[FlurryAPI logPageView];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [FlurryAPI logEvent:name withParameters:[self buildParameters:parameters]];
	[FlurryAPI logPageView];
}

- (void) logException:(NSException*) exception {
    [FlurryAPI logError:exception.name message:exception.reason exception:exception];
}

- (void) logError:(NSError*) error {
    [FlurryAPI logError:[NSString stringWithFormat:@"%@:%i", error.domain, error.code] message:error.localizedDescription error:error];
}

- (void) dealloc {
    self.globalParametersValue = nil;
    
    [super dealloc];
}

@end
