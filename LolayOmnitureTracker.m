//
//  Created by Lolay, Inc.
//  Copyright 2011 Lolay, Inc. All rights reserved.
//
#import "LolayOmnitureTracker.h"
#import "AppMeasurement.h"

@interface LolayOmnitureTracker ()

@property (nonatomic, strong, readwrite) NSDictionary* globalParametersValue;
@property (nonatomic, strong, readwrite) NSString* account;
@property (nonatomic, strong, readwrite) NSString* trackingServer;
@property (nonatomic, strong, readwrite) NSString* currencyCode;
@property (nonatomic, unsafe_unretained, readwrite) id<LolayOmnitureTrackerDelegate> delegate;

@end

@implementation LolayOmnitureTracker

@dynamic appMeasurement;
@synthesize globalParametersValue = globalParametersValue_;
@synthesize account = account_;
@synthesize trackingServer = trackingServer_;
@synthesize currencyCode = currencyCode_;
@synthesize delegate = delegate_;

- (id) initWithTrackingServer:(NSString*) trackingServer account:(NSString*) account currencyCode:(NSString*) currencyCode delegate:(id<LolayOmnitureTrackerDelegate>) delegate {
    self = [super init];
    
    if (self) {
		self.trackingServer = trackingServer;
		self.account = account;
		self.currencyCode = currencyCode;
		self.delegate = delegate;
    }
    
    return self;
}

- (AppMeasurement*) appMeasurement {
	return [AppMeasurement getInstance];
}

- (void) setTracking {
	AppMeasurement* omniture = [AppMeasurement getInstance];
	
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

- (void) setIdentifier:(NSString*) identifier {
	[AppMeasurement getInstance].visitorID = identifier;
	if (self.delegate) {
		[self.delegate omnitureTracker:self identifierWasSet:identifier];
	}
}

- (void) setVersion:(NSString*) version {
	if (self.delegate) {
		[self.delegate omnitureTracker:self setVersion:version];
	}
}

- (void) setAge:(NSUInteger) age {
	if (self.delegate) {
		[self.delegate omnitureTracker:self setAge:age];
	}
}

- (void) setGender:(LolayTrackerGender) gender {
	if (self.delegate) {
		[self.delegate omnitureTracker:self setGender:gender];
	}
}

- (void) setState:(NSString*) state {
    [AppMeasurement getInstance].state = state;
	if (self.delegate) {
		[self.delegate omnitureTracker:self stateWasSet:state];
	}
}

- (void) setZip:(NSString*) zip {
    [AppMeasurement getInstance].zip = zip;
	if (self.delegate) {
		[self.delegate omnitureTracker:self zipWasSet:zip];
	}
}

- (void) setCampaign:(NSString*) campaign {
    [AppMeasurement getInstance].campaign = campaign;
	if (self.delegate) {
		[self.delegate omnitureTracker:self campaignWasSet:campaign];
	}
}

- (void) setChannel:(NSString*) channel {
	[AppMeasurement getInstance].channel = channel;
	if (self.delegate) {
		[self.delegate omnitureTracker:self channelWasSet:channel];
	}
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    self.globalParametersValue = globalParameters;
	if (self.delegate) {
		[self.delegate omnitureTracker:self globalParametersWasSet:globalParameters];
	}
}

- (void) setGlobalParameterValue:(NSString*) value forKey:(NSString*) key {
	if (self.globalParametersValue == nil) {
		self.globalParametersValue = [NSMutableDictionary dictionary];
	}
	[self.globalParametersValue setValue:value forKey:key];
	if (self.delegate) {
		[self.delegate omnitureTracker:self globalParametersWasSet:self.globalParametersValue];
	}
}

- (NSDictionary*) buildParameters:(NSDictionary*) parameters withPageName:(NSString*) pageName {
    NSMutableDictionary* omnitureParameters;
    
    if (parameters == nil) {
        omnitureParameters = [[NSMutableDictionary alloc] initWithCapacity:self.globalParametersValue.count];
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
    [[AppMeasurement getInstance] track:[self buildParameters:nil withPageName:name]];
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self setTracking];
    [[AppMeasurement getInstance] track:[self buildParameters:parameters withPageName:name]];
}

- (void) logPage:(NSString*) name {
	[self setTracking];
    [[AppMeasurement getInstance] track:[self buildParameters:nil withPageName:name]];
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
	[self setTracking];
    [[AppMeasurement getInstance] track:[self buildParameters:parameters withPageName:name]];
}

- (NSString*) trackerId {
	return [AppMeasurement getInstance].visitorID;
}

@end
