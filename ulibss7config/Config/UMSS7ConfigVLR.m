//
//  UMSS7ConfigVLR.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigVLR.h"
#import "UMSS7ConfigMacroHelper.h"

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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigVLR.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_STRING(o,@"full-trace-directory",_fullTraceDirectory);

    APPEND_DICT_STRING(o,@"status-update-url",_statusUpdateUrl);
    APPEND_DICT_STRING(o,@"roaming-number",_roamingNumber);
    APPEND_DICT_STRING(o,@"roaming-number-url",_roamingNumberUrl);
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

    SET_DICT_STRING(o,@"status-update-url",_statusUpdateUrl);
    SET_DICT_STRING(o,@"roaming-number",_roamingNumber);
    SET_DICT_STRING(o,@"roaming-number-url",_roamingNumberUrl);

}


- (UMSS7ConfigVLR *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigVLR allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


