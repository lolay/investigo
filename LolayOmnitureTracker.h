//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayBaseTracker.h"

@interface LolayOmnitureTracker : LolayBaseTracker

- (id) initWithTrackingServer:(NSString*) trackingServer account:(NSString*) account currencyCode:(NSString*) currencyCode;

@end
