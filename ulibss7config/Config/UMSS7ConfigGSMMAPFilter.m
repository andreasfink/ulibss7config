//
//  UMSS7ConfigGSMMAPFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMMAPFilter.h"
#import "UMSS7ConfigGSMMAPFilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMMAPFilter

+ (NSString *)type
{
    return @"gsmmap-filter";
}
- (NSString *)type
{
    return [UMSS7ConfigGSMMAPFilter type];
}

- (UMSS7ConfigGSMMAPFilter *)initWithConfig:(NSDictionary *)dict
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
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigGSMMAPFilter.def"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_CONFIG_STRING(s,@"default-result",_defaultResult);
#endif
    for(UMSS7ConfigGSMMAPFilterEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGSMMAPFilter.def"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_DICT_STRING(dict,@"default-result",_defaultResult);
#endif
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigGSMMAPFilter.def"
#include "UMSS7Config_macroClear.h"
#else
    SET_DICT_STRING(dict,@"default-result",_defaultResult);
#endif
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigGSMMAPFilterEntry *entry = [[UMSS7ConfigGSMMAPFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}


- (UMSS7ConfigGSMMAPFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMMAPFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
