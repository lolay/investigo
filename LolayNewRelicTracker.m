//
//  Copyright 2014 Lolay, Inc.
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

#import "LolayNewRelicTracker.h"
#import <NewRelicAgent/NewRelic.h>

@implementation LolayNewRelicTracker

- (id) initWithApplicationToken:(NSString*) applicationToken {
    self = [super init];
    if (self) {
        [NewRelicAgent startWithApplicationToken:applicationToken];
    }
    
    return self;
}

- (void) logEvent:(NSString*) name {
    [NewRelicAgent recordMetricWithName:[self convertMetricName:name] category:@"Event"];
}

- (void) logPage:(NSString*) name {
    [NewRelicAgent recordMetricWithName:[self convertMetricName:name] category:@"Page"];
}

- (void) logError:(NSError*) error {
    [NewRelicAgent recordMetricWithName:[self convertMetricName:[NSString stringWithFormat:@"%@_%d", [error.domain stringByReplacingOccurrencesOfString:@"." withString:@"_"], (int) error.code]] category:@"Error"];
}

#pragma mark - Private methods

- (NSString*) convertMetricName:(NSString*) name {
    
    NSString* convertedName = name;
    
    NSError* error = nil;
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"[^a-zA-Z0-9_]+" options:nil error:&error];
    if (error == nil) {
        convertedName = [regex stringByReplacingMatchesInString:name options:nil range:NSMakeRange(0, name.length) withTemplate:@""];
    }
    
    return convertedName;
}

@end
