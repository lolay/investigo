//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayBaseTracker.h"

@implementation LolayBaseTracker

- (void) setIdentifier:(NSString*) identifier {
    
}

- (void) setVersion:(NSString*) version {
	
}

- (void) setAge:(NSUInteger) age {
    
}

- (void) setGender:(LolayTrackerGender) gender {
    
}

- (void) setState:(NSString*) state {
    
}

- (void) setZip:(NSString*) zip {
    
}

- (void) setCampaign:(NSString*) campaign {
    
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    
}

- (void) logEvent:(NSString*) name {
    
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    
}

- (void) logEvent:(NSString*) name withObjectsAndKeys:(id) firstObject, ... {
    va_list args;
    va_start(args, firstObject);
    id object;
    id key;
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    for (object = firstObject; object != nil; object = va_arg(args, id)) {
        key = va_arg(args, id);
        if (key != nil) {
            [parameters setObject:object forKey:key];
        }
    }
    
    va_end(args);
    
    [self logEvent:name withDictionary:parameters];
    [parameters release];
}

- (void) logPage:(NSString*) name {
    
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    
}

- (void) logPage:(NSString*) name withObjectsAndKeys:(id) firstObject, ... {
    va_list args;
    va_start(args, firstObject);
    id object;
    id key;
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    for (object = firstObject; object != nil; object = va_arg(args, id)) {
        key = va_arg(args, id);
        if (key != nil) {
            [parameters setObject:object forKey:key];
        }
    }
    
    [self logPage:name withDictionary:parameters];
    [parameters release];
}

- (void) logException:(NSException*) exception {
    
}

- (void) logError:(NSError*) error {
    
}

@end
