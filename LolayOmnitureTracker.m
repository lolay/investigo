//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayOmnitureTracker.h"
#import "OMAppMeasurement.h"

@interface LolayOmnitureTracker ()

@property (nonatomic, retain, readwrite) NSDictionary* globalParametersValue;

@end

@implementation LolayOmnitureTracker

@synthesize globalParametersValue = globalParametersValue_;

- (id) initWithTrackingServer:(NSString*) trackingServer account:(NSString*) account currencyCode:(NSString*) currencyCode {
    self = [super init];
    
    if (self) {
        OMAppMeasurement* omniture = [[OMAppMeasurement getInstance] retain];
        
        omniture.trackingServer = trackingServer;
        omniture.account = account;
        omniture.currencyCode = currencyCode;
#ifndef __OPTIMIZE__
        omniture.debugTracking = YES;
#endif        
        [omniture release];
    }
    
    return self;
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
    
    return [omnitureParameters autorelease];
}

- (void) logEvent:(NSString*) name {
    [[OMAppMeasurement getInstance] track:[self buildParameters:nil withPageName:name]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [[OMAppMeasurement getInstance] track:[self buildParameters:parameters withPageName:name]];
}

- (void) logPage:(NSString*) name {
    [[OMAppMeasurement getInstance] track:[self buildParameters:nil withPageName:name]];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    [[OMAppMeasurement getInstance] track:[self buildParameters:parameters withPageName:name]];
}

@end
