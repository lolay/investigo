//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayBaseTracker.h"

@interface LolayMultipleTracker : LolayBaseTracker

- (id) initWithTrackers:(id<LolayTracker>) firstTracker, ... NS_REQUIRES_NIL_TERMINATION;

@end
