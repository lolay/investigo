//
//  Copyright 2012 Lolay, Inc. All rights reserved.
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

#import "LolayLocaleTracker.h"

@interface LolayLocaleTracker ()

@property (nonatomic, strong, readwrite) NSDictionary* trackers;

@end

@implementation LolayLocaleTracker

@synthesize trackers = trackers_;

- (id) initWithTrackersForLocaleIdentifers:(id<LolayTracker>) firstTracker, ... {
    self = [super init];
    
    if (self) {
        NSMutableDictionary* localeTrackers = [[NSMutableDictionary alloc] init];
        
        if (firstTracker) {
            va_list args;
            id<LolayTracker> tracker = nil;
            NSString* localeIdentifier = nil;
            
            va_start(args, firstTracker);
            
            for (tracker = firstTracker; tracker != nil; tracker = va_arg(args, id<LolayTracker>)) {
                localeIdentifier = va_arg(args, NSString*);
				DLog(@"localeIdentifier=%@", localeIdentifier);
                if (localeIdentifier != nil) {
                    [localeTrackers setObject:tracker forKey:localeIdentifier];
				}
            }
            
            va_end(args);
        }
        
        self.trackers = localeTrackers;
    }
    
    return self;
}

- (id<LolayTracker>) trackerForCurrentLocale {
    id<LolayTracker> tracker = [self.trackers objectForKey:[[NSLocale currentLocale] localeIdentifier]];
    if (tracker == nil) {
        tracker = [self.trackers objectForKey:LOLAY_LOCALE_TRACKER_DEFAULT];
    }
    return tracker;
}

- (void) setIdentifier:(NSString*) identifier {
    [[self trackerForCurrentLocale] setIdentifier:identifier];
}

- (void) setVersion:(NSString*) version {
	[[self trackerForCurrentLocale] setVersion:version];
}

- (void) setAge:(NSUInteger) age {
    [[self trackerForCurrentLocale] setAge:age];
}

- (void) setGender:(LolayTrackerGender) gender {
    [[self trackerForCurrentLocale] setGender:gender];
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    [[self trackerForCurrentLocale] setGlobalParameters:globalParameters];
}



- (void) logEvent:(NSString*) name {
    [[self trackerForCurrentLocale] logEvent:name];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [[self trackerForCurrentLocale] logEvent:name withDictionary:parameters];
}

- (void) logPage:(NSString*) name {
    [[self trackerForCurrentLocale] logPage:name];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [[self trackerForCurrentLocale] logPage:name withDictionary:parameters];
}

- (void) logException:(NSException*) exception {
    [[self trackerForCurrentLocale] logException:exception];
}

- (void) logError:(NSError*) error {
    [[self trackerForCurrentLocale] logError:error];
}

@end
