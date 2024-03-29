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
    NSString *_cga_number_translation_in;
    NSString *_cga_number_translation_out;
    NSString *_cda_number_translation_in;
    NSString *_cda_number_translation_out;

    NSString *_screeningMtp3PluginName;
    NSString *_screeningMtp3PluginConfigFile;
    NSString *_screeningMtp3PluginTraceFile;
    NSString *_screeningSccpPluginName;
    NSString *_screeningSccpPluginConfigFile;
    NSString *_screeningSccpPluginTraceFile;
    NSArray<NSString *> *_routingUpdateAllow;
    NSArray<NSString *> *_routingUpdateDeny;
    NSArray<NSString *> *_routingAdvertisementAllow;
    NSArray<NSString *> *_routingAdvertisementDeny;
    NSNumber *_send_aspup;
    NSNumber *_send_aspac;
    NSString *_mode;
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

@property(readwrite,strong,atomic)  NSString *ttmap_in;
@property(readwrite,strong,atomic)  NSString *ttmap_out;
@property(readwrite,strong,atomic)  NSString *cga_number_translation_in;
@property(readwrite,strong,atomic)  NSString *cga_number_translation_out;
@property(readwrite,strong,atomic)  NSString *cda_number_translation_in;
@property(readwrite,strong,atomic)  NSString *cda_number_translation_out;

@property(readwrite,strong,atomic)  NSString *pctrans;
@property(readwrite,strong,atomic)  NSString *pctransIn;
@property(readwrite,strong,atomic)  NSString *pctransOut;
@property(readwrite,strong,atomic)  NSNumber *disableRouteAdvertizement;
@property(readwrite,strong,atomic)  NSString *screeningMtp3PluginName;
@property(readwrite,strong,atomic)  NSString *screeningMtp3PluginConfig;
@property(readwrite,strong,atomic)  NSString *screeningMtp3PluginTraceFile;
@property(readwrite,strong,atomic)  NSString *screeningMtp3SccpPluginName;
@property(readwrite,strong,atomic)  NSString *screeningMtp3SccpPluginConfigFile;
@property(readwrite,strong,atomic)  NSString *screeningMtp3SccpPluginTraceFile;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingUpdateAllow;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingUpdateDeny;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingAdvertisementAllow;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingAdvertisementDeny;
@property(readwrite,strong,atomic)  NSNumber *send_aspup;
@property(readwrite,strong,atomic)  NSNumber *send_aspac;
@property(readwrite,strong,atomic)  NSString *mode;

@end
