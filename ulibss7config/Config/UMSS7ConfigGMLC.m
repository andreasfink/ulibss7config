//
//  UMSS7ConfigGMLC.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGMLC.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigGMLC

+ (NSString *)type
{
    return @"gmlc";
}

- (NSString *)type
{
    return [UMSS7ConfigGMLC type];
}


- (UMSS7ConfigGMLC *)initWithConfig:(NSDictionary *)dict
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
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_STRING(o,@"full-trace-directory",_fullTraceDirectory);
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
}


- (UMSS7ConfigGMLC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGMLC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


