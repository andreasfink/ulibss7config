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
    APPEND_CONFIG_INTEGER(s,@"ntt",_ntt);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"gt-file",_gtFiles);
    APPEND_CONFIG_STRING(s,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    APPEND_CONFIG_STRING(s,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    APPEND_CONFIG_BOOLEAN(s,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"variant",_variant);
    APPEND_DICT_STRING(dict,@"mode",_mode);
    APPEND_DICT_ARRAY(dict,@"next-pc",_next_pc);
    APPEND_DICT_INTEGER(dict,@"ntt",_ntt);
    APPEND_DICT_ARRAY(dict,@"gt-file",_gtFiles);
    APPEND_DICT_STRING(dict,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    APPEND_DICT_STRING(dict,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    APPEND_DICT_BOOLEAN(dict,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"variant",_variant);
    SET_DICT_STRING(dict,@"mode",_mode);
    SET_DICT_ARRAY(dict,@"next-pc",_next_pc);
    SET_DICT_INTEGER(dict,@"ntt",_ntt);
    SET_DICT_ARRAY(dict,@"gt-file",_gtFiles);
    SET_DICT_STRING(dict,@"problematic-packets-trace-file",_problematicPacketsTraceFile);
    SET_DICT_STRING(dict,@"unrouteable-packets-trace-file",_unrouteablePacketsTraceFile);
    SET_DICT_BOOLEAN(dict,@"route-errors-back-to-originating-pointcode",_routeErrorsBackToOriginatingPointCode);
}

- (UMSS7ConfigSCCP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
