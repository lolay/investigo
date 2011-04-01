//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayNSLogTracker.h"

@implementation LolayNSLogTracker

- (void) logEvent:(NSString*) name {
    NSLog(@"event=%@", name);
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    NSLog(@"event=%@ parameters=%@", name, parameters);
}

- (void) logPage:(NSString*) name {
    NSLog(@"page=%@", name);
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    NSLog(@"page=%@ parameters=%@", name, parameters);
}

- (void) logException:(NSException*) exception {
    NSLog(@"exception=%@", exception);
}

- (void) logError:(NSError*) error {
    NSLog(@"error=%@", error);
}

@end
