//
//  UMSS7ConfigGSMSCF.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMSCF.h"
#import "UMSS7ConfigMacroHelper.h"

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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGSMSCF.def.h"
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
    return dict;
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


- (UMSS7ConfigGSMSCF *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMSCF allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


