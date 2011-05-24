//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LolayBaseTracker.h"

@interface LolayFlurryTracker : LolayBaseTracker

- (id) initWithKey:(NSString*) key;
- (id) initWithKey:(NSString*) key version:(NSString*) version;

@end
