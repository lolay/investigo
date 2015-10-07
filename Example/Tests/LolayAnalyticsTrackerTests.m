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

#import <XCTest/XCTest.h>
#import "LolayAnalyticsTracker.h"
#import <Analytics/Analytics.h>

#define SECRET @"ssshh"

@interface LolayAnalyticsTrackerTests : XCTestCase

@property (nonatomic, strong, readwrite) LolayAnalyticsTracker* tracker;

@end

@implementation LolayAnalyticsTrackerTests

- (void) setUp {
    [super setUp];
	self.tracker = [[LolayAnalyticsTracker alloc] initWithSecret:SECRET];
}

- (void) tearDown {
	self.tracker = nil;
    [super tearDown];
}

- (void) testCreation {
	XCTAssertNotNil(self.tracker, @"tracker wasn't created");
	XCTAssertEqualObjects(SECRET, [[[SEGAnalytics sharedAnalytics] configuration] writeKey], @"The given secret wasn't set in Analytics");
}

- (void) testIdentifier {
	LolayAnalyticsTracker* tracker = self.tracker;
	NSString* identifier = @"me";
	[tracker setIdentifier:identifier];
}

- (void) testGlobals {
	LolayAnalyticsTracker* tracker = self.tracker;
	[tracker setGlobalParameters:@{@"1": @"a"}];
	[tracker setGlobalParameter:@"b" forKey:@"2"];
}

- (void) testAttributes {
	LolayAnalyticsTracker* tracker = self.tracker;
	[tracker setGender:LolayTrackerGenderMale];
	[tracker setGender:LolayTrackerGenderFemale];
	[tracker setGender:LolayTrackerGenderUnknown];
	[tracker setGender:-1];
	[tracker setIdentifier:@"identifier"];
	[tracker setVersion:@"version"];
	[tracker setAge:21];
}

- (void) testLogEvents {
	LolayAnalyticsTracker* tracker = self.tracker;
	[tracker logEvent:@"foo"];
	[tracker logEvent:@"foo" withDictionary:nil];
	[tracker logEvent:@"foo" withDictionary:@{@"1": @"b"}];
	[tracker logEvent:@"foo" withObjectsAndKeys:nil];
	[tracker logEvent:@"foo" withObjectsAndKeys:@"b", @"1", nil];
}

- (void) testLogPages {
	LolayAnalyticsTracker* tracker = self.tracker;
	[tracker logPage:@"foo"];
	[tracker logPage:@"foo" withDictionary:nil];
	[tracker logPage:@"foo" withDictionary:@{@"1": @"b"}];
	[tracker logPage:@"foo" withObjectsAndKeys:nil];
	[tracker logPage:@"foo" withObjectsAndKeys:@"b", @"1", nil];
}

- (void) testLogErrorAndException {
	LolayAnalyticsTracker* tracker = self.tracker;
	NSError* error = [[NSError alloc] initWithDomain:@"foo" code:0 userInfo:@{@"1": @"a"}];
	[tracker logError:error];
	
	NSException* exception = [[NSException alloc] initWithName:@"foo" reason:@"bar" userInfo:@{@"1": @"a"}];
	[tracker logException:exception];
}

- (void) testRegisterDeviceToken {
	LolayAnalyticsTracker* tracker = self.tracker;
	[tracker registerDeviceToken:[@"1234567890" dataUsingEncoding:NSASCIIStringEncoding]];
}

@end
