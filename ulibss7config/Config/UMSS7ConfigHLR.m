//
//  UMSS7ConfigHLR.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigHLR.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigHLR

+ (NSString *)type
{
    return @"hlr";
}

- (NSString *)type
{
    return [UMSS7ConfigHLR type];
}


- (UMSS7ConfigHLR *)initWithConfig:(NSDictionary *)dict
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
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigHLR.def.h"
#include "UMSS7Config_macroClear.h"
#else
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(o,@"number",_number);
    APPEND_CONFIG_STRING(o,@"imsi-pool",_imsiPool);
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);
    APPEND_CONFIG_INTEGER(o,@"answer-translation-type",_answerTranslationType);
#endif
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigHLR.def.h"
#include "UMSS7Config_macroClear.h"
#else

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_STRING(o,@"imsi-pool",_imsiPool);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
    
#endif


    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigHLR.def.h"
#include "UMSS7Config_macroClear.h"
#else
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_STRING(o,@"imsi-pool",_imsiPool);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
#endif
}


- (UMSS7ConfigHLR *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigHLR allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

