//
//  UMSS7ConfigM3UAAS.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigM3UAAS : UMSS7ConfigObject
{
    NSString *_mtp3;
    NSNumber *_routingContext;
    NSString *_apc;
    NSString *_trafficMode;
    NSString *_overrideNetworkIndicator;
    NSArray *_inbound_filter_rulesets;
    NSArray *_outbound_filter_rulesets;
    NSString *_pctrans;
    NSString *_pctransIn;
    NSString *_pctransOut;
    NSNumber *_disableRouteAdvertizement;
    NSString *_ttmap_in;
    NSString *_ttmap_out;

}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigM3UAAS *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3;
@property(readwrite,strong,atomic)  NSNumber *routingContext;
@property(readwrite,strong,atomic)  NSString *apc;
@property(readwrite,strong,atomic)  NSString *trafficMode;
@property(readwrite,strong,atomic)  NSString *overrideNetworkIndicator;
@property(readwrite,strong,atomic)  NSArray *inbound_filter_rulesets;
@property(readwrite,strong,atomic)  NSArray *outbound_filter_rulesets;
@property(readwrite,strong,atomic)  NSString *pctrans;
@property(readwrite,strong,atomic)  NSString *pctransIn;
@property(readwrite,strong,atomic)  NSString *pctransOut;
@property(readwrite,strong,atomic)  NSNumber *disableRouteAdvertizement;
@property(readwrite,strong,atomic)  NSString *ttmap_in;
@property(readwrite,strong,atomic)  NSString *ttmap_out;


@end
