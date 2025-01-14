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
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigIMSIPool.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigIMSIPool.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigIMSIPool.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigIMSIPool *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigIMSIPool allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

