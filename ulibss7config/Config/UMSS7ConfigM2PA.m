//
//  UMSS7ConfigM2PA.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM2PA.h"
#import "UMSS7ConfigMacroHelper.h"
@implementation UMSS7ConfigM2PA

+ (NSString *)type
{
    return @"m2pa";
}

- (NSString *)type
{
    return [UMSS7ConfigM2PA type];
}


- (UMSS7ConfigM2PA *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigM2PA.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigM2PA.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigM2PA.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSS7ConfigM2PA *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM2PA allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

