//
//  UMSS7ConfigEIR.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigEIR.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigEIR


+ (NSString *)groupName
{
    return @"eir";
}

- (NSString *)groupName
{
    return [UMSS7ConfigEIR groupName];
}


- (UMSS7ConfigEIR *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigEIR.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigEIR.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigEIR.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSS7ConfigEIR *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigEIR allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


