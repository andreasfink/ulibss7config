//
//  UMSS7ConfigMSC.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMSC.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMSC

+ (NSString *)type
{
    return @"msc";
}

- (NSString *)type
{
    return [UMSS7ConfigMSC type];
}


- (UMSS7ConfigMSC *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);
    APPEND_CONFIG_STRING(s,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_CONFIG_STRING(s,@"full-trace-directory",_fullTraceDirectory);
    APPEND_CONFIG_STRING(s,@"sms-forward-url",_smsForwardUrl);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    APPEND_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);
    APPEND_DICT_STRING(dict,@"sms-forward-url",_smsForwardUrl);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
    SET_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    SET_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);
    SET_DICT_STRING(dict,@"sms-forward-url",_smsForwardUrl);
}

- (UMSS7ConfigMSC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMSC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


