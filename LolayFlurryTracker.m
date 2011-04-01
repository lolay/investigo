//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayFlurryTracker.h"
#import "FlurryAPI.h"

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
    
    NSString* model = [[UIDevice currentDevice] model];
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    [flurryParameters setObject:systemVersion forKey:@"systemVersion"];
    [flurryParameters setObject:model forKey:@"model"];
    [flurryParameters setObject:[NSString stringWithFormat:@"%@-%@", model, systemVersion] forKey:@"model-systemVersion"];
    [flurryParameters setObject:[NSLocale currentLocale] forKey:@"locale"];
    
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
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [FlurryAPI logEvent:name withParameters:[self buildParameters:parameters]];
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
