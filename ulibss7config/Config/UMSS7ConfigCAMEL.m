//
//  UMSS7ConfigCAMEL.m
//  ulibss7config
//
//  Created by Andreas Fink on 09.03.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigCAMEL.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigCAMEL


+ (NSString *)type
{
    return @"camel";
}

- (NSString *)type
{
    return [UMSS7ConfigCAMEL type];
}


- (UMSS7ConfigCAMEL *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigCAMEL.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigCAMEL.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigCAMEL.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigCAMEL *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigCAMEL allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
