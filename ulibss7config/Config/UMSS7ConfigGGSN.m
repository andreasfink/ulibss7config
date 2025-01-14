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
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigGGSN.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGGSN.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigGGSN.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigGGSN *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGGSN allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


