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
    NSParameterAssert(identifier != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setIdentifier:identifier];
    }
}

- (void) setVersion:(NSString*) version {
    NSParameterAssert(version != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setVersion:version];
    }    
}

- (void) logRegistration:(NSDictionary*) userData {
    NSParameterAssert(userData != nil);

	for (id<LolayTracker> tracker in self.trackers) {
        [tracker logRegistration:userData];
    }
}

- (void) logPurchase:(NSDictionary*) purchaseData {
    NSParameterAssert(purchaseData != nil);

	for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPurchase:purchaseData];
    }
}

- (void) logIdentity {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logIdentity];
    }
}

- (void) setAge:(NSUInteger) age {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setAge:age];
    }    
}

- (void) setFirstName:(NSString *)firstName {
    NSParameterAssert(firstName != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setFirstName:firstName];
    }
}

- (void) setLastName:(NSString *)lastName {
    NSParameterAssert(lastName != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setLastName:lastName];
    }
}

- (void) setEmail:(NSString *)email {
    NSParameterAssert(email != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setEmail:email];
    }
}

- (void) setCity:(NSString *)city {
    NSParameterAssert(city != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setCity:city];
    }
}

- (void) setState:(NSString *)state {
    NSParameterAssert(state != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setState:state];
    }
}

- (void) setZip:(NSString *)zip {
    NSParameterAssert(zip != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setZip:zip];
    }
}

- (void) setPhone:(NSString *)phone {
    NSParameterAssert(phone != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setPhone:phone];
    }
}

- (void) setGender:(LolayTrackerGender) gender {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGender:gender];
    }
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    NSParameterAssert(globalParameters != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameters:globalParameters];
    }
}

- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key {
    NSParameterAssert(object != nil);
    NSParameterAssert(key != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameter:object forKey:key];
    }
}

- (void) removeGlobalParameterForKey:(NSString*) key {
    NSParameterAssert(key != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker removeGlobalParameterForKey:key];
    }
}

- (void) logEvent:(NSString*) name {
    NSParameterAssert(name != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name];
    }
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    NSParameterAssert(name != nil);
    NSParameterAssert(parameters != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name withDictionary:parameters];
    }
}

- (void) logPage:(NSString*) name {
    NSParameterAssert(name != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name];
    }
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    NSParameterAssert(name != nil);
    NSParameterAssert(parameters != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name withDictionary:parameters];
    }
}

- (void) logException:(NSException*) exception {
    NSParameterAssert(exception != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logException:exception];
    }
}

- (void) logError:(NSError*) error {
    NSParameterAssert(error != nil);

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logError:error];
    }
}

- (void) logTiming:(NSDictionary*)timingData{
    NSParameterAssert(timingData != nil);

	for (id<LolayTracker> tracker in self.trackers) {
		[tracker logTiming:timingData];
	}
}

- (NSString*) trackerIdForType:(Class) clazz {
    NSParameterAssert(clazz != nil);

    for (id<LolayTracker> tracker in self.trackers) {
		NSString* trackerId = [tracker trackerIdForType:clazz];
		if (trackerId) {
			return trackerId;
		}
    }
	return nil;
}

@end
