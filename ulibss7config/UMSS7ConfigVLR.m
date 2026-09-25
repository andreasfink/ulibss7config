//
//  UMSS7ConfigVLR.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigVLR.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigVLR


+ (NSString *)groupName

{
    return @"vlr";
}

- (NSString *)groupName
{
    return [UMSS7ConfigVLR groupName];
}


- (UMSS7ConfigVLR *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigVLR.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigVLR.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigVLR.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigVLR *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigVLR allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


