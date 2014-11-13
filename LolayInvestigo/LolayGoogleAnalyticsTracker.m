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

#import "LolayGoogleAnalyticsTracker.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <GAI.h>
#import <GAIFields.h>
#import <GAIDictionaryBuilder.h>
@implementation LolayGoogleAnalyticsTracker
- (id) initWithLaunchOptions:(NSDictionary*) launchOptions trackingId:(NSString*) trackingId trackUncaughtExceptions:(BOOL) trackUncaughtExceptions {
	if (self = [super init]){
	 
  // Optional: automatically send uncaught exceptions to Google Analytics.
  [GAI sharedInstance].trackUncaughtExceptions = trackUncaughtExceptions;
		
  // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
  //[GAI sharedInstance].dispatchInterval = 20;
		
  // Optional: set Logger to VERBOSE for debug information.
  //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
		
  // Initialize tracker. Replace with your tracking ID.
 [[GAI sharedInstance] trackerWithName: @"lolaygoogletracker"
								trackingId: trackingId];

	}
	return self;
}

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

- (void) setChannel:(NSString*) channel {
	
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
	
}

- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key {
	
}

- (void) removeGlobalParameterForKey:(NSString*) key {
	
}

- (void) logPurchase:(NSDictionary *)purchaseData{
	id tracker = [[GAI sharedInstance] defaultTracker];

	[tracker send:[[GAIDictionaryBuilder createItemWithTransactionId:[purchaseData objectForKey:@"transactionId"]
																name:[purchaseData objectForKey:@"productName"]
																 sku:[purchaseData objectForKey:@"productId"]
															category:[purchaseData objectForKey:@"categoryName"]
															   price:[purchaseData objectForKey:@"price"]
															quantity:[purchaseData objectForKey:@"quantity"]
														currencyCode:[purchaseData objectForKey:@"currency"] ] build]];
}

- (void) logRegistration:(NSDictionary *)userData{
	id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	
	// You only need to set User ID on a tracker once. By setting it on the tracker, the ID will be
	// sent with all subsequent hits.
	[tracker set:@"&uid"
		   value:[userData objectForKey:@"userName" ]];
	
	// This hit will be sent with the User ID value and be visible in User-ID-enabled views (profiles).
	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"            // Event category (required)
														  action:@"User Register"  // Event action (required)
														   label:nil              // Event label
														   value:nil] build]];    // Event value

}

- (void) logEvent:(NSString*) name {
	id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	
	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"events"     // Event category (required)
														  action:name  // Event action (required)
														   label:nil         // Event label
														   value:nil] build]];    // Event value

}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
	id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	
	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"events"     // Event category (required)
														  action:name  // Event action (required)
														   label:[parameters objectForKey:@"label"]         // Event label
														   value:[parameters objectForKey:@"value"]] build]];    // Event value
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
}

- (void) logPage:(NSString*) name {
	id tracker = [[GAI sharedInstance] defaultTracker];
	[tracker set:kGAIScreenName
		   value:name];
	
	[tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self logPage:name];
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
}

- (void) logException:(NSException*) exception {
	
}

- (void) logError:(NSError*) error {
	
}

- (NSString*) trackerId {
	return nil;
}

- (NSString*) trackerIdForType:(Class) clazz {
	if ([self isKindOfClass:clazz]) {
		return [self trackerId];
	}
	return nil;
}
@end
