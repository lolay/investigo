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

#import "LolayMultipleTracker.h"

@interface LolayMultipleTracker ()

@property (nonatomic, strong, readwrite) NSArray* trackers;

@end

@implementation LolayMultipleTracker

@synthesize trackers = trackers_;

- (id) initWithTrackerArray:(NSArray*) trackers {
    self = [super init];
    
    self.trackingEnabled = true;
    
    if (self) {
        self.trackers = trackers;
    }
    
    return self;
}

- (id) initWithTrackers:(id<LolayTracker>) firstTracker, ... {
    self = [super init];
    
    self.trackingEnabled = true;

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
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setIdentifier:identifier];
    }
}

- (void) setVersion:(NSString*) version {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setVersion:version];
    }    
}

- (void) setAge:(NSUInteger) age {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setAge:age];
    }    
}

- (void) setGender:(LolayTrackerGender) gender {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGender:gender];
    }
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameters:globalParameters];
    }
}

- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameter:object forKey:key];
    }
}

- (void) removeGlobalParameterForKey:(NSString*) key {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker removeGlobalParameterForKey:key];
    }
}

- (void) logEvent:(NSString*) name {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name];
    }
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name withDictionary:parameters];
    }
}

- (void) logPage:(NSString*) name {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name];
    }
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name withDictionary:parameters];
    }
}

- (void) logException:(NSException*) exception {
    if (!self.trackingEnabled) return;
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logException:exception];
    }
}

- (void) logError:(NSError*) error {
    if (!self.trackingEnabled) return;
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
