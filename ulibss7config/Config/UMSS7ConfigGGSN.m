//
//  UMSS7ConfigGGSN.m
//  ulibss7config
//
//  Created by Andreas Fink on 24.09.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGGSN.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigGGSN

+ (NSString *)type
{
    return @"ggsn";
}

- (NSString *)type
{
    return [UMSS7ConfigGGSN type];
}


- (UMSS7ConfigGGSN *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGGSN.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
}

- (UMSS7ConfigGGSN *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGGSN allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


