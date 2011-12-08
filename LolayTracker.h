//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayTrackerGender.h"

@protocol LolayTracker <NSObject>

- (void) setIdentifier:(NSString*) identifier;
- (void) setVersion:(NSString*) version;
- (void) setAge:(NSUInteger) age;
- (void) setGender:(LolayTrackerGender) gender;
- (void) setState:(NSString*) state;
- (void) setZip:(NSString*) zip;
- (void) setCampaign:(NSString*) campaign;
- (void) setChannel:(NSString*) channel;
- (void) setGlobalParameters:(NSDictionary*) globalParameters;
- (void) setGlobalParameterValue:(NSString*) value forKey:(NSString*) key;
- (void) logEvent:(NSString*) name;
- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters;
- (void) logEvent:(NSString*) name withObjectsAndKeys:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void) logPage:(NSString*) name;
- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters;
- (void) logPage:(NSString*) name withObjectsAndKeys:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void) logException:(NSException*) exception;
- (void) logError:(NSError*) error;
- (NSString*) trackerId;
- (NSString*) trackerIdForType:(Class) clazz;

@end
