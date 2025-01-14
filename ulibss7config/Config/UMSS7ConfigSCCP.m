//
//  UMSS7ConfigSccp.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCP.h"
#import "UMSS7ConfigMacroHelper.h"

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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCP.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"variant",_variant);
    APPEND_DICT_STRING(o,@"mode",_mode);
    APPEND_DICT_ARRAY(dict,@"next-pc",_next_pc);
    //APPEND_DICT_INTEGER(o,@"ntt",_overrideCalledTT);
    APPEND_DICT_INTEGER(o,@"set-called-tt",_overrideCalledTT);
    APPEND_DICT_INTEGER(o,@"set-calling-tt",_overrideCallingTT);
    APPEND_DICT_ARRAY(dict,@"gt-file",_gtFiles);
    APPEND_DICT_STRING(o,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    APPEND_DICT_STRING(o,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    APPEND_DICT_BOOLEAN(o,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);
    APPEND_DICT_STRING(o,@"statistic-db-pool",_statisticDbPool);
    APPEND_DICT_STRING(o,@"statistic-db-table",_statisticDbTable);
    APPEND_DICT_STRING(o,@"statistic-db-instance",_statisticDbInstance);
    APPEND_DICT_BOOLEAN(o,@"statistic-db-autocreate",_statisticDbAutocreate);
    APPEND_DICT_BOOLEAN(o,@"automatic-ansi-itu-conversion",_automaticAnsiItuConversion);
    APPEND_DICT_INTEGER(o,@"ansi-tt-e164",_ansi_tt_e164);
    APPEND_DICT_INTEGER(o,@"ansi-tt-e212",_ansi_tt_e212);
    APPEND_DICT_STRING(o,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    APPEND_DICT_STRING(o,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    APPEND_DICT_STRING(o,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    APPEND_DICT_INTEGER(o,@"screening-sccp-plugin-trace-level",_screeningSccpPluginTraceLevel);
    APPEND_DICT_STRING(o,@"sms-log-server-zmq-in",_smsLogServerZmqIn);
    APPEND_DICT_STRING(o,@"sms-log-server-zmq-out",_smsLogServerZmqOut);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_FILTERED_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"variant",_variant);
    SET_DICT_STRING(o,@"mode",_mode);
    SET_DICT_ARRAY(dict,@"next-pc",_next_pc);
    SET_DICT_INTEGER(o,@"ntt",_overrideCalledTT);
    SET_DICT_INTEGER(o,@"set-called-tt",_overrideCalledTT); /* new name for ntt */
    SET_DICT_INTEGER(o,@"set-calling-tt",_overrideCallingTT);
    SET_DICT_ARRAY(dict,@"gt-file",_gtFiles);
    SET_DICT_STRING(o,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    SET_DICT_STRING(o,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    SET_DICT_BOOLEAN(o,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);
    SET_DICT_STRING(o,@"statistic-db-pool",_statisticDbPool);
    SET_DICT_STRING(o,@"statistic-db-table",_statisticDbTable);
    SET_DICT_STRING(o,@"statistic-db-instance",_statisticDbInstance);
    SET_DICT_BOOLEAN(o,@"statistic-db-autocreate",_statisticDbAutocreate);
    SET_DICT_BOOLEAN(o,@"automatic-ansi-itu-conversion",_automaticAnsiItuConversion);
    SET_DICT_INTEGER(o,@"ansi-tt-e164",_ansi_tt_e164);
    SET_DICT_INTEGER(o,@"ansi-tt-e212",_ansi_tt_e212);
    SET_DICT_STRING(o,@"screening-sccp-plugin-name",_screeningSccpPluginName);
    SET_DICT_STRING(o,@"screening-sccp-plugin-config-file",_screeningSccpPluginConfigFile);
    SET_DICT_STRING(o,@"screening-sccp-plugin-trace-file",_screeningSccpPluginTraceFile);
    SET_DICT_INTEGER(o,@"screening-sccp-plugin-trace-level",_screeningSccpPluginTraceLevel);
    SET_DICT_STRING(o,@"sms-log-server-in-zmq",_smsLogServerZmqIn);
    SET_DICT_STRING(o,@"sms-log-server-out-zmq",_smsLogServerZmqOut);
}

- (UMSS7ConfigSCCP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
