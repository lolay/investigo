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
