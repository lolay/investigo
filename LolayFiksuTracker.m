//
//  LolayFiksuTracker.m
//  11Main
//
//  Created by Patrick Ortiz on 1/7/14.
//  Copyright (c) 2014 Vendio Services, Inc. All rights reserved.
//

#import "LolayFiksuTracker.h"
#import <FiksuSDK/FiksuSDK.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation LolayFiksuTracker

- (id) initWithLaunchOptions:(NSDictionary*) launchOptions{
	if (self = [super init]){
		[FiksuTrackingManager applicationDidFinishLaunching:launchOptions];
	}
	return self;
}

- (void) setIdentifier:(NSString*) identifier {
    [FiksuTrackingManager setClientID:identifier];
}

- (void) setVersion:(NSString*) version {
	[FiksuTrackingManager setVersion:[version intValue]];
}

- (void) setAge:(NSUInteger) age {
    
}

- (void) setGender:(LolayTrackerGender) gender {
    
}

- (void) setState:(NSString*) state {
    
}

- (void) setZip:(NSString*) zip {
    
}

- (void) setCampaign:(NSString*) campaign {
    
}

- (void) setChannel:(NSString*) channel {
	
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    
}

- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key {
	
}

- (void) removeGlobalParameterForKey:(NSString*) key {
	
}

- (void) logPurchase:(NSDictionary *)purchaseData{
	[FiksuTrackingManager uploadPurchaseEvent:[purchaseData objectForKey:@"productId"]
										price:[[purchaseData objectForKey:@"price"] doubleValue]
										currency:[purchaseData objectForKey:@"currency"]];
}

- (void) logRegistration:(NSDictionary *)userData{
	[FiksuTrackingManager uploadRegistrationEvent:[userData objectForKey:@"userName"]];
}

- (void) logEvent:(NSString*) name {
    [FiksuTrackingManager uploadEvent:name withInfo:@{}];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
		[FiksuTrackingManager uploadEvent:name withInfo:parameters];
}

- (void) logEvent:(NSString*) name withObjectsAndKeys:(id) firstObject, ... {
    va_list args;
    va_start(args, firstObject);
    id object;
    id key;
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    for (object = firstObject; object != nil; object = va_arg(args, id)) {
        key = va_arg(args, id);
        if (key != nil) {
            [parameters setObject:object forKey:key];
        }
    }
    
    va_end(args);
    
    [self logEvent:name withDictionary:parameters];
}

- (void) logPage:(NSString*) name {

}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    
}

- (void) logPage:(NSString*) name withObjectsAndKeys:(id) firstObject, ... {
    va_list args;
    va_start(args, firstObject);
    id object;
    id key;
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    for (object = firstObject; object != nil; object = va_arg(args, id)) {
        key = va_arg(args, id);
        if (key != nil) {
            [parameters setObject:object forKey:key];
        }
    }
    
    [self logPage:name withDictionary:parameters];
}

- (void) logException:(NSException*) exception {
    
}

- (void) logError:(NSError*) error {
    
}

- (NSString*) trackerId {
	return nil;
}

- (NSString*) trackerIdForType:(Class) clazz {
	if ([self isKindOfClass:clazz]) {
		return [self trackerId];
	}
	return nil;
}

@end
