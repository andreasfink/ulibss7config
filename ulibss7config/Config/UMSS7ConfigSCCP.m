//
//  UMSS7ConfigSccp.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCP.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCCP


+ (NSString *)type
{
    return @"sccp";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCP type];
}


- (UMSS7ConfigSCCP *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(s,@"variant",_variant);
    APPEND_CONFIG_STRING(s,@"mode",_mode);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"next-pc",_next_pc);
    //APPEND_CONFIG_INTEGER(s,@"ntt",_overrideCalledTT);
    APPEND_CONFIG_INTEGER(s,@"set-called-tt",_overrideCalledTT);
    APPEND_CONFIG_INTEGER(s,@"set-calling-tt",_overrideCallingTT);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"gt-file",_gtFiles);
    APPEND_CONFIG_STRING(s,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    APPEND_CONFIG_STRING(s,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    APPEND_CONFIG_BOOLEAN(s,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);
    APPEND_CONFIG_STRING(s,@"statistic-db-pool",_statisticDbPool);
    APPEND_CONFIG_STRING(s,@"statistic-db-table",_statisticDbTable);
    APPEND_CONFIG_STRING(s,@"statistic-db-instance",_statisticDbInstance);
    APPEND_CONFIG_BOOLEAN(s,@"statistic-db-autocreate",_statisticDbAutocreate);
    APPEND_CONFIG_BOOLEAN(s,@"automatic-ansi-itu-conversion",_automaticAnsiItuConversion);
    APPEND_CONFIG_INTEGER(s,@"ansi-tt-e164",_ansi_tt_e164);
    APPEND_CONFIG_INTEGER(s,@"ansi-tt-e212",_ansi_tt_e212);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    APPEND_CONFIG_INTEGER(s,@"screening-sccp-plugin-trace-level",_screeningSccpPluginTraceLevel);
    
    APPEND_CONFIG_STRING(s,@"translation-tables-db-pool",_translationTablesDbPool);
    APPEND_CONFIG_STRING(s,@"translation-tables-db-table",_translationTablesDbTable);
    APPEND_CONFIG_BOOLEAN(s,@"translation-tables-db-autocreate",_translationTablesDbAutocreate);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"variant",_variant);
    APPEND_DICT_STRING(dict,@"mode",_mode);
    APPEND_DICT_ARRAY(dict,@"next-pc",_next_pc);
    //APPEND_DICT_INTEGER(dict,@"ntt",_overrideCalledTT);
    APPEND_DICT_INTEGER(dict,@"set-called-tt",_overrideCalledTT);
    APPEND_DICT_INTEGER(dict,@"set-calling-tt",_overrideCallingTT);
    APPEND_DICT_ARRAY(dict,@"gt-file",_gtFiles);
    APPEND_DICT_STRING(dict,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    APPEND_DICT_STRING(dict,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    APPEND_DICT_BOOLEAN(dict,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);
    APPEND_DICT_STRING(dict,@"statistic-db-pool",_statisticDbPool);
    APPEND_DICT_STRING(dict,@"statistic-db-table",_statisticDbTable);
    APPEND_DICT_STRING(dict,@"statistic-db-instance",_statisticDbInstance);
    APPEND_DICT_BOOLEAN(dict,@"statistic-db-autocreate",_statisticDbAutocreate);
    APPEND_DICT_BOOLEAN(dict,@"automatic-ansi-itu-conversion",_automaticAnsiItuConversion);
    APPEND_DICT_INTEGER(dict,@"ansi-tt-e164",_ansi_tt_e164);
    APPEND_DICT_INTEGER(dict,@"ansi-tt-e212",_ansi_tt_e212);
    APPEND_DICT_STRING(dict,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    APPEND_DICT_STRING(dict,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    APPEND_DICT_STRING(dict,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    APPEND_DICT_INTEGER(dict,@"screening-sccp-plugin-trace-level",_screeningSccpPluginTraceLevel);

    APPEND_DICT_STRING(dict,@"translation-tables-db-pool",_translationTablesDbPool);
    APPEND_DICT_STRING(dict,@"translation-tables-db-table",_translationTablesDbTable);
    APPEND_DICT_BOOLEAN(dict,@"translation-tables-db-autocreate",_translationTablesDbAutocreate);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"variant",_variant);
    SET_DICT_STRING(dict,@"mode",_mode);
    SET_DICT_ARRAY(dict,@"next-pc",_next_pc);
    SET_DICT_INTEGER(dict,@"ntt",_overrideCalledTT);
    SET_DICT_INTEGER(dict,@"set-called-tt",_overrideCalledTT); /* new name for ntt */
    SET_DICT_INTEGER(dict,@"set-calling-tt",_overrideCallingTT);
    SET_DICT_ARRAY(dict,@"gt-file",_gtFiles);
    SET_DICT_STRING(dict,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    SET_DICT_STRING(dict,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    SET_DICT_BOOLEAN(dict,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);
    SET_DICT_STRING(dict,@"statistic-db-pool",_statisticDbPool);
    SET_DICT_STRING(dict,@"statistic-db-table",_statisticDbTable);
    SET_DICT_STRING(dict,@"statistic-db-instance",_statisticDbInstance);
    SET_DICT_BOOLEAN(dict,@"statistic-db-autocreate",_statisticDbAutocreate);
    SET_DICT_BOOLEAN(dict,@"automatic-ansi-itu-conversion",_automaticAnsiItuConversion);
    SET_DICT_INTEGER(dict,@"ansi-tt-e164",_ansi_tt_e164);
    SET_DICT_INTEGER(dict,@"ansi-tt-e212",_ansi_tt_e212);
    SET_DICT_STRING(dict,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    SET_DICT_STRING(dict,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    SET_DICT_STRING(dict,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    SET_DICT_INTEGER(dict,@"screening-sccp-plugin-trace-level",_screeningSccpPluginTraceLevel);
    
    SET_DICT_STRING(dict,@"translation-tables-db-pool",_translationTablesDbPool);
    SET_DICT_STRING(dict,@"translation-tables-db-table",_translationTablesDbTable);
    SET_DICT_BOOLEAN(dict,@"translation-tables-db-autocreate",_translationTablesDbAutocreate);
}

- (UMSS7ConfigSCCP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
