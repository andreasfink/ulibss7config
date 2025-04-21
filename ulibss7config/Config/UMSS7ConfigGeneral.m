//
//  UMSS7ConfigGeneral.m
//  estp
//
//  Created by Andreas Fink on 09.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGeneral.h"
#import "UMSS7ConfigMacroHelper.h"
#define USE_NEW_SS7CONFIG_MACROS    1

@implementation UMSS7ConfigGeneral

+ (NSString *)type
{
    return @"general";
}

- (NSString *)type
{
    return [UMSS7ConfigGeneral type];
}

- (UMSS7ConfigGeneral *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGeneral.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];    
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGeneral.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigGeneral.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigGeneral *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGeneral allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
