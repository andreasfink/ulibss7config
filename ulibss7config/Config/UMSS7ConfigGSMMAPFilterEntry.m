//
//  UMSS7ConfigGSMMAPFilterEntry.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMMAPFilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMMAPFilterEntry

+ (NSString *)type
{
    return @"gsmmap-filter-entry";
}
- (NSString *)type
{
    return [UMSS7ConfigGSMMAPFilterEntry type];
}

- (UMSS7ConfigGSMMAPFilterEntry *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGSMMAPFilterEntry.def.h"
#include "UMSS7Config_macroClear.h"
#else

    APPEND_CONFIG_STRING(o,@"filter",_filter);
    APPEND_CONFIG_STRING(o,@"result",_result);
#endif
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGSMMAPFilterEntry.def.h"
#include "UMSS7Config_macroClear.h"
#else

    APPEND_DICT_STRING(o,@"filter",_filter);
    APPEND_DICT_STRING(o,@"result",_result);
#endif
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigGSMMAPFilterEntry.def.h"
#include "UMSS7Config_macroClear.h"
#else
    SET_DICT_STRING(o,@"filter",_filter);
    SET_DICT_STRING(o,@"result",_result);
#endif
}

- (UMSS7ConfigGSMMAPFilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMMAPFilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


