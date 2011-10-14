//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayOmnitureTracker.h"
#import "OMAppMeasurement.h"

@interface LolayOmnitureTracker ()

@property (nonatomic, retain, readwrite) NSDictionary* globalParametersValue;
@property (nonatomic, retain, readwrite) NSString* account;
@property (nonatomic, retain, readwrite) NSString* trackingServer;
@property (nonatomic, retain, readwrite) NSString* currencyCode;

@end

@implementation LolayOmnitureTracker

@synthesize globalParametersValue = globalParametersValue_;
@synthesize account = account_;
@synthesize trackingServer = trackingServer_;
@synthesize currencyCode = currencyCode_;

- (id) initWithTrackingServer:(NSString*) trackingServer account:(NSString*) account currencyCode:(NSString*) currencyCode {
    self = [super init];
    
    if (self) {
		self.trackingServer = trackingServer;
		self.account = account;
		self.currencyCode = currencyCode;
    }
    
    return self;
}

- (void) setTracking {
	OMAppMeasurement* omniture = [OMAppMeasurement getInstance];
	
	if (! [omniture.trackingServer isEqualToString:self.trackingServer] ||
		! [omniture.account isEqualToString:self.account] ||
		! [omniture.currencyCode isEqualToString:self.currencyCode]) {
		
		omniture.trackingServer = self.trackingServer;
		omniture.account = self.account;
		omniture.currencyCode = self.currencyCode;
#ifndef __OPTIMIZE__
		omniture.debugTracking = YES;
#endif
	}
}

- (void) setState:(NSString*) state {
    [OMAppMeasurement getInstance].state = state;
}

- (void) setZip:(NSString*) zip {
    [OMAppMeasurement getInstance].zip = zip;
}

- (void) setCampaign:(NSString*) campaign {
    [OMAppMeasurement getInstance].campaign = campaign;
}

- (NSDictionary*) buildParameters:(NSDictionary*) parameters withPageName:(NSString*) pageName {
    NSMutableDictionary* omnitureParameters;
    
    if (parameters == nil) {
        omnitureParameters = [[NSMutableDictionary alloc] initWithCapacity:0 + self.globalParametersValue.count];
    } else {
        omnitureParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    }
    
    if (self.globalParametersValue) {
        [omnitureParameters addEntriesFromDictionary:self.globalParametersValue];
    }
    
    [omnitureParameters setObject:pageName forKey:@"pageName"];
    
    return omnitureParameters;
}

- (void) logEvent:(NSString*) name {
	[self setTracking];
    [[OMAppMeasurement getInstance] track:[self buildParameters:nil withPageName:name]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self setTracking];
    [[OMAppMeasurement getInstance] track:[self buildParameters:parameters withPageName:name]];
}

- (void) logPage:(NSString*) name {
	[self setTracking];
    [[OMAppMeasurement getInstance] track:[self buildParameters:nil withPageName:name]];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self setTracking];
    [[OMAppMeasurement getInstance] track:[self buildParameters:parameters withPageName:name]];
}

@end
