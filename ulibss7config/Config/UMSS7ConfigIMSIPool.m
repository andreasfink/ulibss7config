//
//  UMSS7ConfigIMSIPool.m
//  ulibss7config
//
//  Created by Andreas Fink on 16.07.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigIMSIPool.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigIMSIPool

+ (NSString *)type
{
    return @"imsi-pool";
}

- (NSString *)type
{
    return [UMSS7ConfigIMSIPool type];
}


- (UMSS7ConfigIMSIPool *)initWithConfig:(NSDictionary *)dict
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
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigIMSIPool.def.h"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_CONFIG_STRING(o,@"imsi-prefix",_imsiPrefix);
    APPEND_CONFIG_DOUBLE(o,@"cache-timer",_cacheTimer);
#endif
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigIMSIPool.def.h"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_DICT_STRING(o,@"imsi-prefix",_imsiPrefix);
    APPEND_DICT_DOUBLE(o,@"cache-timer",_cacheTimer);
#endif
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigIMSIPool.def.h"
#include "UMSS7Config_macroClear.h"
#else
    SET_DICT_STRING(o,@"imsi-prefix",_imsiPrefix);
    SET_DICT_DOUBLE(o,@"cache-cache",_cacheTimer);
#endif
}


- (UMSS7ConfigIMSIPool *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigIMSIPool allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

