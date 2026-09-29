//
//  UMSS7ConfigMnpDatabase.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.06.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMnpDatabase.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMnpDatabase

+ (NSString *)groupName
{
    return @"mnp-database";
}

- (NSString *)groupName
{
    return [UMSS7ConfigMnpDatabase groupName];
}

- (UMSS7ConfigMnpDatabase *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMnpDatabase.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMnpDatabase.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMnpDatabase.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigMnpDatabase *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMnpDatabase allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


