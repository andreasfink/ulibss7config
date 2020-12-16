//
//  UMSS7ConfigMTP3LinkSet.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3LinkSet : UMSS7ConfigObject
{
    NSString *_mtp3;
    NSString *_apc;
    NSString *_opc;
    NSNumber *_speed;
    NSString *_overrideNetworkIndicator;
    NSString *_ttmap_in;
    NSString *_ttmap_out;
    NSArray<NSString *> *_map_tt_in;
    NSArray<NSString *> *_map_tt_out;
    NSArray *_inbound_filter_rulesets;
    NSArray *_outbound_filter_rulesets;
    NSString *_pctrans;
    NSString *_pctransIn;
    NSString *_pctransOut;
    NSNumber *_disableRouteAdvertizement;
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
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3LinkSet *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3;
@property(readwrite,strong,atomic)  NSString *apc;
@property(readwrite,strong,atomic)  NSString *opc;
@property(readwrite,strong,atomic)  NSNumber *speed;
@property(readwrite,strong,atomic)  NSString *overrideNetworkIndicator;
@property(readwrite,strong,atomic)  NSString *ttmap_in;
@property(readwrite,strong,atomic)  NSString *ttmap_out;
@property(readwrite,strong,atomic)  NSArray<NSString *> *map_tt_in;
@property(readwrite,strong,atomic)  NSArray<NSString *> *map_tt_out;
@property(readwrite,strong,atomic)  NSArray<NSString *> *inbound_filter_rulesets;
@property(readwrite,strong,atomic)  NSArray<NSString *> *outbound_filter_rulesets;
@property(readwrite,strong,atomic)  NSString *pctrans;
@property(readwrite,strong,atomic)  NSString *pctransIn;
@property(readwrite,strong,atomic)  NSString *pctransOut;
@property(readwrite,strong,atomic)  NSNumber *disableRouteAdvertizement;
@property(readwrite,strong,atomic)  NSString *screeningMtp3PluginName;
@property(readwrite,strong,atomic)  NSString *screeningMtp3PluginConfigFile;
@property(readwrite,strong,atomic)  NSString *screeningMtp3PluginConfigTrace;
@property(readwrite,strong,atomic)  NSString *screeningSccpPluginName;
@property(readwrite,strong,atomic)  NSString *screeningSccpPluginConfigFile;
@property(readwrite,strong,atomic)  NSString *screeningSccpPluginTraceFile;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingUpdateAllow;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingUpdateDeny;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingAdvertisementAllow;
@property(readwrite,strong,atomic)  NSArray<NSString *> *routingAdvertisementDeny;

@end
