//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayTrackerGender.h"

@class LolayOmnitureTracker;

@protocol LolayOmnitureTrackerDelegate <NSObject>

@optional

- (void) omnitureTracker:(LolayOmnitureTracker*) tracker setVersion:(NSString*) version;
- (void) omnitureTracker:(LolayOmnitureTracker*) tracker setAge:(NSUInteger) age;
- (void) omnitureTracker:(LolayOmnitureTracker*) tracker setGender:(LolayTrackerGender) gender;

- (void) omnitureTracker:(LolayOmnitureTracker*) tracker identifierWasSet:(NSString*) identifier;
- (void) omnitureTracker:(LolayOmnitureTracker*) tracker stateWasSet:(NSString*) state;
- (void) omnitureTracker:(LolayOmnitureTracker*) tracker zipWasSet:(NSString*) zip;
- (void) omnitureTracker:(LolayOmnitureTracker*) tracker campaignWasSet:(NSString*) campaign;
- (void) omnitureTracker:(LolayOmnitureTracker*) tracker channelWasSet:(NSString*) channel;

- (void) omnitureTracker:(LolayOmnitureTracker*) tracker globalParametersWasSet:(NSDictionary*) paramaters;

@end
