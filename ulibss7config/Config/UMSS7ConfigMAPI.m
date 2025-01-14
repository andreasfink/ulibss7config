//
//  UMSS7ConfigMAPI.m
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMAPI.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMAPI


+ (NSString *)type
{
    return @"mapi";
}

- (NSString *)type
{
    return [UMSS7ConfigMAPI type];
}


- (UMSS7ConfigMAPI *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMAPI.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMAPI.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMAPI.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSS7ConfigMAPI *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMAPI allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


