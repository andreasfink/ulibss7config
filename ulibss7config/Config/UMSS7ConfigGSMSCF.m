//
//  UMSS7ConfigGSMSCF.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMSCF.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMSCF

+ (NSString *)type
{
    return @"gsmscf";
}

- (NSString *)type
{
    return [UMSS7ConfigGSMSCF type];
}


- (UMSS7ConfigGSMSCF *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"number",_attachTo);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);
    APPEND_CONFIG_STRING(s,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_CONFIG_STRING(s,@"full-trace-directory",_fullTraceDirectory);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"number",_attachTo);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    APPEND_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"number",_attachTo);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
    SET_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    SET_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);
}


- (UMSS7ConfigGSMSCF *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMSCF allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


