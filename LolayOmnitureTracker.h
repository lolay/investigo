//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayBaseTracker.h"
#import "LolayOmnitureTrackerDelegate.h"

@class AppMeasurement;

@interface LolayOmnitureTracker : LolayBaseTracker

@property (nonatomic, strong, readonly) AppMeasurement* appMeasurement;

- (id) initWithTrackingServer:(NSString*) trackingServer account:(NSString*) account currencyCode:(NSString*) currencyCode delegate:(id<LolayOmnitureTrackerDelegate>) delegate;

@end
