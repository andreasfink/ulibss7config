//
//  UMSS7ConfigEIR.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigEIR.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigEIR


+ (NSString *)type
{
    return @"eir";
}

- (NSString *)type
{
    return [UMSS7ConfigEIR type];
}


- (UMSS7ConfigEIR *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(o,@"number",_number);
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);
    APPEND_CONFIG_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_CONFIG_STRING(o,@"full-trace-directory",_fullTraceDirectory);
    APPEND_CONFIG_STRING(o,@"eir-request-url",_eirRequestUrl);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_STRING(o,@"full-trace-directory",_fullTraceDirectory);
    APPEND_DICT_STRING(o,@"eir-request-url",_eirRequestUrl);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    SET_DICT_STRING(o,@"full-trace-directory",_fullTraceDirectory);
    SET_DICT_STRING(o,@"eir-request-url",_eirRequestUrl);
}


- (UMSS7ConfigEIR *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigEIR allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


