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

#import <Foundation/Foundation.h>
#import "LolayTrackerGender.h"

@protocol LolayTracker <NSObject>

- (void) setIdentifier:(NSString*) identifier;
- (void) setVersion:(NSString*) version;
- (void) setFirstName: (NSString *) firstName;
- (void) setLastName: (NSString *) lastName;
- (void) setEmail: (NSString *) email;
- (void) setCity: (NSString *) city;
- (void) setState: (NSString *) state;
- (void) setZip: (NSString *) zip;
- (void) setPhone: (NSString *) phone;
- (void) setAge:(NSUInteger) age;
- (void) setGender:(LolayTrackerGender) gender;
- (void) setState:(NSString*) state;
- (void) setZip:(NSString*) zip;
- (void) setCampaign:(NSString*) campaign;
- (void) setChannel:(NSString*) channel;
- (void) setGlobalParameters:(NSDictionary*) globalParameters;
- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key;
- (void) removeGlobalParameterForKey:(NSString*) key;
- (void) logEvent:(NSString*) name;
- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters;
- (void) logEvent:(NSString*) name withObjectsAndKeys:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void) logPage:(NSString*) name;
- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters;
- (void) logPage:(NSString*) name withObjectsAndKeys:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (void) logException:(NSException*) exception;
- (void) logError:(NSError*) error;
- (void) logRegistration:(NSDictionary*) userData;
- (void) logPurchase:(NSDictionary*) purchaseData;
- (NSString*) trackerId;
- (NSString*) trackerIdForType:(Class) clazz;
- (void) registerDeviceToken:(NSData*) deviceToken;

@end
