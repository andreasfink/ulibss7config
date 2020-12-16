//
//  UMSS7ConfigM3UAAS.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM3UAAS.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigM3UAAS

+ (NSString *)type
{
    return @"m3ua-as";
}

- (NSString *)type
{
    return [UMSS7ConfigM3UAAS type];
}


- (UMSS7ConfigM3UAAS *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"mtp3",_mtp3);
    APPEND_CONFIG_STRING(s,@"apc",_apc);
    APPEND_CONFIG_INTEGER(s,@"routing-context",_routingContext);
    APPEND_CONFIG_STRING(s,@"traffic-mode",_trafficMode);
    APPEND_CONFIG_STRING(s,@"override-network-indicator",_overrideNetworkIndicator);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"inbound-filter",_inbound_filter_rulesets);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"outbound-filter",_outbound_filter_rulesets);
    APPEND_CONFIG_STRING(s,@"pointcode-translation-table",_pctrans);
    APPEND_CONFIG_STRING(s,@"pointcode-translation-table-in",_pctransIn);
    APPEND_CONFIG_STRING(s,@"pointcode-translation-table-out",_pctransOut);
    APPEND_CONFIG_BOOLEAN(s,@"disable-route-advertizement",_disableRouteAdvertizement);
    APPEND_CONFIG_STRING(s,@"tt-map-in",_ttmap_in);
    APPEND_CONFIG_STRING(s,@"tt-map-out",_ttmap_out);
    APPEND_CONFIG_STRING(s,@"screening-plugin-name",_screeningPluginName);
    APPEND_CONFIG_STRING(s,@"screening-plugin-config-file",_screeningPluginConfig);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"routing-update-allow",_routingUpdateAllow);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"routing-update-deny",_routingUpdateDeny);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"routing-advertisement-allow",_routingAdvertisementAllow);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"routing-advertisement-deny",_routingAdvertisementDeny);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"mtp3",_mtp3);
    APPEND_DICT_STRING(dict,@"apc",_apc);
    APPEND_DICT_INTEGER(dict,@"routing-context",_routingContext);
    APPEND_DICT_STRING(dict,@"traffic-mode",_trafficMode);
    APPEND_DICT_STRING(dict,@"override-network-indicator",_overrideNetworkIndicator);
    APPEND_DICT_ARRAY(dict,@"inbound-filter",_inbound_filter_rulesets);
    APPEND_DICT_ARRAY(dict,@"outbound-filter",_outbound_filter_rulesets);
    APPEND_DICT_STRING(dict,@"pointcode-translation-table",_pctrans);
    APPEND_DICT_STRING(dict,@"pointcode-translation-table-in",_pctransIn);
    APPEND_DICT_STRING(dict,@"pointcode-translation-table-out",_pctransOut);
    APPEND_DICT_BOOLEAN(dict,@"disable-route-advertizement",_disableRouteAdvertizement);
    APPEND_DICT_STRING(dict,@"tt-map-in",_ttmap_in);
    APPEND_DICT_STRING(dict,@"tt-map-out",_ttmap_out);
    APPEND_DICT_STRING(dict,@"screening-plugin-name",_screeningPluginName);
    APPEND_DICT_STRING(dict,@"screening-plugin-config-file",_screeningPluginConfig);
    APPEND_DICT_ARRAY(dict,@"routing-update-allow",_routingUpdateAllow);
    APPEND_DICT_ARRAY(dict,@"routing-update-deny",_routingUpdateDeny);
    APPEND_DICT_ARRAY(dict,@"routing-advertisement-allow",_routingAdvertisementAllow);
    APPEND_DICT_ARRAY(dict,@"routing-advertisement-deny",_routingAdvertisementDeny);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"mtp3",_mtp3);
    SET_DICT_STRING(dict,@"apc",_apc);
    SET_DICT_INTEGER(dict,@"routing-key",_routingContext); /* backwards compatibility */
    SET_DICT_INTEGER(dict,@"routing-context",_routingContext);
    SET_DICT_STRING(dict,@"traffic-mode",_trafficMode);
    SET_DICT_STRING(dict,@"override-network-indicator",_overrideNetworkIndicator);
    SET_DICT_ARRAY(dict,@"inbound-filter",_inbound_filter_rulesets);
    SET_DICT_ARRAY(dict,@"outbound-filter",_outbound_filter_rulesets);
    SET_DICT_STRING(dict,@"pointcode-translation-table",_pctrans);
    SET_DICT_STRING(dict,@"pointcode-translation-table-in",_pctransIn);
    SET_DICT_STRING(dict,@"pointcode-translation-table-out",_pctransOut);
    SET_DICT_BOOLEAN(dict,@"disable-route-advertizement",_disableRouteAdvertizement);
    SET_DICT_STRING(dict,@"tt-map-in",_ttmap_in);
    SET_DICT_STRING(dict,@"tt-map-out",_ttmap_out);
    SET_DICT_STRING(dict,@"screening-plugin-name",_screeningPluginName);
    SET_DICT_STRING(dict,@"screening-plugin-config-file",_screeningPluginConfig);
    SET_DICT_ARRAY(dict,@"routing-update-allow",_routingUpdateAllow);
    SET_DICT_ARRAY(dict,@"routing-update-deny",_routingUpdateDeny);
    SET_DICT_ARRAY(dict,@"routing-advertisement-allow",_routingAdvertisementAllow);
    SET_DICT_ARRAY(dict,@"routing-advertisement-deny",_routingAdvertisementDeny);
}

- (UMSS7ConfigM3UAAS *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM3UAAS allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
