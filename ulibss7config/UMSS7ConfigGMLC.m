//
//  UMSS7ConfigGMLC.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGMLC.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigGMLC

+ (NSString *)groupName
{
    return @"gmlc";
}

- (NSString *)groupName
{
    return [UMSS7ConfigGMLC groupName];
}


- (UMSS7ConfigGMLC *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGMLC.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGMLC.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigGMLC.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigGMLC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGMLC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


