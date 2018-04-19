//
//  UMSS7ConfigVLR.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigVLR.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigVLR


+ (NSString *)type
{
    return @"vlr";
}

- (NSString *)type
{
    return [UMSS7ConfigVLR type];
}


- (UMSS7ConfigVLR *)initWithConfig:(NSDictionary *)dict
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

    APPEND_CONFIG_STRING(s,@"status-update-url",_statusUpdateUrl);
    APPEND_CONFIG_STRING(s,@"roaming-number",_roamingNumber);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"number",_attachTo);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    APPEND_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);

    APPEND_DICT_STRING(dict,@"status-update-url",_statusUpdateUrl);
    APPEND_DICT_STRING(dict,@"roaming-number",_roamingNumber);
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

    SET_DICT_STRING(dict,@"status-update-url",_statusUpdateUrl);
    SET_DICT_STRING(dict,@"roaming-number",_roamingNumber);

}


- (UMSS7ConfigVLR *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigVLR allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


