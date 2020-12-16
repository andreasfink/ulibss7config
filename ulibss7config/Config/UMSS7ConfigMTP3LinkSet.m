//
//  UMSS7ConfigMtp3LinkSet.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3LinkSet.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3LinkSet

+ (NSString *)type
{
    return @"mtp3-linkset";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3LinkSet type];
}


- (UMSS7ConfigMTP3LinkSet *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"opc",_opc);
    APPEND_CONFIG_DOUBLE(s,@"speed",_speed);
    APPEND_CONFIG_STRING(s,@"override-network-indicator",_overrideNetworkIndicator);
    APPEND_CONFIG_STRING(s,@"tt-map-in",_ttmap_in);
    APPEND_CONFIG_STRING(s,@"tt-map-out",_ttmap_out);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"map-tt-inbound",_map_tt_in);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"map-tt-outbound",_map_tt_out);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"inbound-filter",_inbound_filter_rulesets);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"outbound-filter",_outbound_filter_rulesets);
    APPEND_CONFIG_STRING(s,@"pointcode-translation-table",_pctrans);
    APPEND_CONFIG_STRING(s,@"pointcode-translation-table-in",_pctransIn);
    APPEND_CONFIG_STRING(s,@"pointcode-translation-table-out",_pctransOut);
    APPEND_CONFIG_BOOLEAN(s,@"disable-route-advertizement",_disableRouteAdvertizement);
    APPEND_CONFIG_STRING(s,@"screening-mtp3-plugin-name",_screeningMtp3PluginName);
    APPEND_CONFIG_STRING(s,@"screening-mtp3-plugin-config-file",_screeningMtp3PluginConfigFile);
    APPEND_CONFIG_STRING(s,@"screening-mtp3-plugin-trace-file",_screeningMtp3PluginTraceFile);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
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
    APPEND_DICT_STRING(dict,@"opc",_opc);
    APPEND_DICT_DOUBLE(dict,@"speed",_speed);
    APPEND_DICT_STRING(dict,@"override-network-indicator",_overrideNetworkIndicator);
    APPEND_DICT_STRING(dict,@"tt-map-in",_ttmap_in);
    APPEND_DICT_STRING(dict,@"tt-map-out",_ttmap_out);
    APPEND_DICT_ARRAY(dict,@"map-tt-inbound",_map_tt_in);
    APPEND_DICT_ARRAY(dict,@"map-tt-outbound",_map_tt_out);
    APPEND_DICT_ARRAY(dict,@"inbound-filter",_inbound_filter_rulesets);
    APPEND_DICT_ARRAY(dict,@"outbound-filter",_outbound_filter_rulesets);
    APPEND_DICT_STRING(dict,@"pointcode-translation-table",_pctrans);
    APPEND_DICT_STRING(dict,@"pointcode-translation-table-in",_pctransIn);
    APPEND_DICT_STRING(dict,@"pointcode-translation-table-out",_pctransOut);
    APPEND_DICT_BOOLEAN(dict,@"disable-route-advertizement",_disableRouteAdvertizement);
    APPEND_DICT_STRING(dict,@"screening-mtp3-plugin-name",_screeningMtp3PluginName);
    APPEND_DICT_STRING(dict,@"screening-mtp3-plugin-config-file",_screeningMtp3PluginConfigFile);
    APPEND_DICT_STRING(dict,@"screening-mtp3-plugin-trace-file",_screeningMtp3PluginConfigTrace);
    APPEND_DICT_STRING(dict,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    APPEND_DICT_STRING(dict,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    APPEND_DICT_STRING(dict,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    APPEND_DICT_ARRAY(dict,@"routing-update-allow",_routingUpdateAllow);
    APPEND_DICT_ARRAY(dict,@"routing-update-deny",_routingUpdateDeny);
    APPEND_DICT_ARRAY(dict,@"routing-advertisement-allow",_routingAdvertisementAllow);
    APPEND_DICT_ARRAY(dict,@"routing-advertisement-deny",_routingAdvertisementDeny);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"mtp3",_mtp3);
    SET_DICT_STRING(dict,@"apc",_apc);
    SET_DICT_STRING(dict,@"opc",_opc);
    SET_DICT_DOUBLE(dict,@"speed",_speed);
    SET_DICT_STRING(dict,@"override-network-indicator",_overrideNetworkIndicator);
    SET_DICT_STRING(dict,@"tt-map-in",_ttmap_in);
    SET_DICT_STRING(dict,@"tt-map-out",_ttmap_out);
    SET_DICT_ARRAY(dict,@"map-tt-inbound",_map_tt_in);
    SET_DICT_ARRAY(dict,@"map-tt-outbound",_map_tt_out);
    SET_DICT_ARRAY(dict,@"inbound-filter",_inbound_filter_rulesets);
    SET_DICT_ARRAY(dict,@"outbound-filter",_outbound_filter_rulesets);
    SET_DICT_STRING(dict,@"pointcode-translation-table",_pctrans);
    SET_DICT_STRING(dict,@"pointcode-translation-table-in",_pctransIn);
    SET_DICT_STRING(dict,@"pointcode-translation-table-out",_pctransOut);
    SET_DICT_BOOLEAN(dict,@"disable-route-advertizement",_disableRouteAdvertizement);
    SET_DICT_STRING(dict,@"screening-mtp3-plugin-name",_screeningMtp3PluginName);
    SET_DICT_STRING(dict,@"screening-mtp3-plugin-config-file",_screeningMtp3PluginConfigFile);
    SET_DICT_STRING(dict,@"screening-mtp3-plugin-trace-file",_screeningMtp3PluginTraceFile);
    SET_DICT_STRING(dict,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    SET_DICT_STRING(dict,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    SET_DICT_STRING(dict,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    SET_DICT_ARRAY(dict,@"routing-update-allow",_routingUpdateAllow);
    SET_DICT_ARRAY(dict,@"routing-update-deny",_routingUpdateDeny);
    SET_DICT_ARRAY(dict,@"routing-advertisement-allow",_routingAdvertisementAllow);
    SET_DICT_ARRAY(dict,@"routing-advertisement-deny",_routingAdvertisementDeny);

}

- (UMSS7ConfigMTP3LinkSet *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3LinkSet allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end
