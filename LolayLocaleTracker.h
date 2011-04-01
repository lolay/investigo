//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayBaseTracker.h"

#define LOLAY_LOCALE_TRACKER_DEFAULT @"default"

@interface LolayLocaleTracker : LolayBaseTracker

- (id) initWithTrackersForLocaleIdentifers:(id) firstTracker, ... NS_REQUIRES_NIL_TERMINATION;

@end
