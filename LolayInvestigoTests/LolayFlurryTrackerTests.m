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
#import "LolayFlurryTracker.h"
#import "Flurry.h"
#import "OCMock.h"

@interface LolayFlurryTrackerTests : XCTestCase

@end

@implementation LolayFlurryTrackerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void) testConstruction {
//[Flurry class];
//	id flurryMock = [OCMockObject mockForClass:[Flurry class]];
//	[flurryMock stub];
//	LolayFlurryTracker* tracker1 = [[LolayFlurryTracker alloc] initWithKey:@"TEST"];
//	XCTAssertNotNil(tracker1, @"Construction with key is nil");
	
//	LolayFlurryTracker* tracker2 = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1"];
//	XCTAssertNotNil(tracker2, @"Construction with key and version is nil");

//	LolayFlurryTracker* tracker3 = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1" crashReportingEnabled:YES];
//	XCTAssertNotNil(tracker3, @"Construction with key, version and crashReportingEnabled is nil");
}
/*
- (void) testGlobals {
	LolayFlurryTracker* tracker = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1" crashReportingEnabled:NO];
	[tracker setGlobalParameters:@{@"1": @"a"}];
	[tracker setGlobalParameter:@"b" forKey:@"2"];
	
	NSMutableDictionary* globals = [tracker valueForKey:@"globalParametersValue"];
	XCTAssertNotNil(globals, @"Globals is nil");
	XCTAssertEqualObjects(@"a", [globals objectForKey:@"1"], @"Setting via dictionary didn't find parameter.");
	XCTAssertEqualObjects(@"b", [globals objectForKey:@"2"], @"Setting via method didn't find parameter.");
}

- (void) testAttributes {
	// FIXME, mock the Flurry static methods and verify
	
	LolayFlurryTracker* tracker = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1" crashReportingEnabled:NO];
	[tracker setGender:LolayTrackerGenderMale];
	[tracker setGender:LolayTrackerGenderFemale];
	[tracker setGender:LolayTrackerGenderUnknown];
	[tracker setGender:-1];
	[tracker setIdentifier:@"identifier"];
	[tracker setVersion:@"version"];
	[tracker setAge:21];
}

- (void) testLogEvents {
	// FIXME, mock the Flurry static methods and verify
	
	LolayFlurryTracker* tracker = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1" crashReportingEnabled:NO];
	[tracker logEvent:@"foo"];
	[tracker logEvent:@"foo" withDictionary:nil];
	[tracker logEvent:@"foo" withDictionary:@{@"1": @"b"}];
	[tracker logEvent:@"foo" withObjectsAndKeys:nil];
	[tracker logEvent:@"foo" withObjectsAndKeys:@"b", @"1", nil];
}

- (void) testLogPages {
	// FIXME, mock the Flurry static methods and verify
	
	LolayFlurryTracker* tracker = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1" crashReportingEnabled:NO];
	[tracker logPage:@"foo"];
	[tracker logPage:@"foo" withDictionary:nil];
	[tracker logPage:@"foo" withDictionary:@{@"1": @"b"}];
	[tracker logPage:@"foo" withObjectsAndKeys:nil];
	[tracker logPage:@"foo" withObjectsAndKeys:@"b", @"1", nil];
}

- (void) testLogErrorAndException {
	// FIXME, mock the Flurry static methods and verify
	
	LolayFlurryTracker* tracker = [[LolayFlurryTracker alloc] initWithKey:@"TEST" version:@"1" crashReportingEnabled:NO];
	NSError* error = [[NSError alloc] initWithDomain:@"foo" code:0 userInfo:@{@"1": @"a"}];
	[tracker logError:error];
	
	NSException* exception = [[NSException alloc] initWithName:@"foo" reason:@"bar" userInfo:@{@"1": @"a"}];
	[tracker logException:exception];
}
*/
@end
