//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "LolayAdMobTracking.h"

#define ADMOB_FILE_NAME @"AdMobGreatSuccess"
#define ADMOB_URL @"http://a.admob.com/f0?isu=%@&md5=1&app_id=%@"

@interface LolayAdMobTracking ()

@property (nonatomic, retain, readwrite) NSMutableData* receivedData;
@property (nonatomic, retain, readwrite) NSHTTPURLResponse * lastResponse;

@end

@implementation LolayAdMobTracking

#pragma mark -
#pragma mark Init
- (id) init {
	if (self = [super init] ) {
		self.receivedData = [[NSMutableData data] retain];
		self.lastResponse = nil;
	}
	return self;	
}

#pragma mark -
#pragma mark Helpers
- (NSString *)hashedISU {
	NSString *result = nil;
	NSString *isu = [UIDevice currentDevice].uniqueIdentifier;
	
	if(isu) {
		unsigned char digest[16];
		NSData *data = [isu dataUsingEncoding:NSASCIIStringEncoding];
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

- (NSString*) adMobFilePath {
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	NSString *appOpenPath = [documentsDirectory stringByAppendingPathComponent:ADMOB_FILE_NAME];
	return appOpenPath;
}

- (BOOL) adMobFileExists {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:[self adMobFilePath]]) {
		return YES;
	}
	return NO;
}

- (void) writeAdMobFile {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager createFileAtPath:[self adMobFilePath] contents:nil attributes:nil];
}

#pragma mark -
#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
	if (self.lastResponse != nil) {
		[self.lastResponse release];
	}
	
	self.lastResponse = [response retain];
}

- (void)connection:(NSURLConnection *)connectiondidFailWithError:(NSError *)error {
	NSLog(@"[LolayAdMobTracking connectiondidFailWithError] error=%@",[error localizedDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if (self.lastResponse && [self.lastResponse statusCode] == 200 && ([self.receivedData length] > 0)) {
		[self writeAdMobFile];
	}
}

#pragma mark -
#pragma mark Report Method
- (void) report:(NSString*)iTunesId {
	if(![self adMobFileExists]) {
		NSString *appOpenEndpoint = [NSString stringWithFormat:ADMOB_URL, [self hashedISU], iTunesId];
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appOpenEndpoint]];
		NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
		[connection release];
	}
}

- (void) dealloc {
	self.receivedData = nil;
	self.lastResponse = nil;
	
	[super dealloc];
}

@end
