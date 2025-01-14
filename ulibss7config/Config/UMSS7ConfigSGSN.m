//
//  UMSS7ConfigSGSN.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.06.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSGSN.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSGSN


+ (NSString *)type
{
    return @"sgsn";
}

- (NSString *)type
{
    return [UMSS7ConfigSGSN type];
}


- (UMSS7ConfigSGSN *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSGSN.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
}

- (UMSS7ConfigSGSN *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSGSN allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


