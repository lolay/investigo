//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayMultipleTracker.h"

@interface LolayMultipleTracker ()

@property (nonatomic, strong, readwrite) NSArray* trackers;

@end

@implementation LolayMultipleTracker

@synthesize trackers = trackers_;

- (id) initWithTrackers:(id<LolayTracker>) firstTracker, ... {
    self = [super init];
    
    if (self) {
        NSMutableArray* tmpTrackers = [[NSMutableArray alloc] init];
        
        if (firstTracker) {
            va_list trackerArguments;
            id<LolayTracker> tracker = nil;
            
            va_start(trackerArguments, firstTracker);
            
            for (tracker = firstTracker; tracker != nil; tracker = va_arg(trackerArguments, id<LolayTracker>)) {
                [tmpTrackers addObject:tracker];
            }
            va_end(trackerArguments);
        }
        
        self.trackers = tmpTrackers;
    }
    
    return self;
}

- (void) setIdentifier:(NSString*) identifier {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setIdentifier:identifier];
    }
}

- (void) setVersion:(NSString*) version {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setVersion:version];
    }    
}

- (void) setAge:(NSUInteger) age {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setAge:age];
    }    
}

- (void) setGender:(LolayTrackerGender) gender {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGender:gender];
    }
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameters:globalParameters];
    }
}

- (void) setGlobalParameterValue:(NSString*) value forKey:(NSString*) key {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameterValue:value forKey:key];
    }
}

- (void) logEvent:(NSString*) name {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name];
    }
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name withDictionary:parameters];
    }
}

- (void) logPage:(NSString*) name {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name];
    }
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name withDictionary:parameters];
    }
}

- (void) logException:(NSException*) exception {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logException:exception];
    }
}

- (void) logError:(NSError*) error {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logError:error];
    }
}

- (NSString*) trackerIdForType:(Class) clazz {
    for (id<LolayTracker> tracker in self.trackers) {
		NSString* trackerId = [tracker trackerIdForType:clazz];
		if (trackerId) {
			return trackerId;
		}
    }
	return nil;
}

@end
