//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum {
	LolayTrackerGenderUnknown = 0,
	LolayTrackerGenderMale = 1,
	LolayTrackerGenderFemale = 2
} LolayTrackerGender;

@protocol LolayTracker <NSObject>

- (void) setIdentifier:(NSString*) identifier;
- (void) setAge:(NSUInteger) age;
- (void) setGender:(LolayTrackerGender) gender;
- (void) setState:(NSString*) state;
- (void) setZip:(NSString*) zip;
- (void) setCampaign:(NSString*) campaign;
- (void) setGlobalParameters:(NSDictionary*) globalParameters;
- (void) logEvent:(NSString*) name;
- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters;
- (void) logEvent:(NSString*) name withObjectsAndKeys:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void) logPage:(NSString*) name;
- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters;
- (void) logPage:(NSString*) name withObjectsAndKeys:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void) logException:(NSException*) exception;
- (void) logError:(NSError*) error;

@end
