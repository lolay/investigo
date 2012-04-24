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

#import "LolayInvestigoGlobals.h"
#import <CommonCrypto/CommonDigest.h>
#import "LolayAdMobTracking.h"

#define ADMOB_NAME @"AdMobGreatSuccess"
#define ADMOB_URL @"http://a.admob.com/f0?isu=%@&md5=1&app_id=%@"

@implementation LolayAdMobTracking

#pragma mark -
#pragma mark Helpers
- (NSString*) hashedISU {
	NSString* result = nil;
	NSString* isu = [UIDevice currentDevice].uniqueIdentifier;
	
	if(isu) {
		unsigned char digest[16];
		NSData* data = [isu dataUsingEncoding:NSASCIIStringEncoding];
		CC_MD5([data bytes], [data length], digest);
		
		result = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				  digest[0], digest[1], 
				  digest[2], digest[3],
				  digest[4], digest[5],
				  digest[6], digest[7],
				  digest[8], digest[9],
				  digest[10], digest[11],
				  digest[12], digest[13],
				  digest[14], digest[15]];
		result = [result uppercaseString];
	}
	return result;
}

#pragma mark -
#pragma mark -
#pragma mark Report Method
- (void) report:(NSString*) iTunesId {
	if(! [[NSUserDefaults standardUserDefaults] boolForKey:ADMOB_NAME]) {
		DLog(@"Reporting to admob");
		NSString* appOpenEndpoint = [NSString stringWithFormat:ADMOB_URL, [self hashedISU], iTunesId];
		NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:appOpenEndpoint]];
		NSURLResponse* response = nil;
		NSError* error = nil;
		NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		
		if ((! error) && ([(NSHTTPURLResponse*) response statusCode] == 200) && ([responseData length] > 0)) {
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:ADMOB_NAME];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	} else {
		DLog(@"Already reported to admob, skipping");
	}
}

@end
