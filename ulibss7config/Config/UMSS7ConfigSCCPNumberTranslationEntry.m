//
//  UMSS7ConfigSCCPNumberTranslationEntry.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPNumberTranslationEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSCCPNumberTranslationEntry

+ (NSString *)type
{
    return @"sccp-number-translation-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPNumberTranslationEntry type];
}

- (UMSS7ConfigSCCPNumberTranslationEntry *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigSCCPNumberTranslationEntry.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPNumberTranslationEntry.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPNumberTranslationEntry.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSCCPNumberTranslationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPNumberTranslationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
