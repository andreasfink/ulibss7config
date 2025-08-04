//
//  UMSS7ConfigMTP3FilterEntry.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3FilterEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMTP3FilterEntry

+ (NSString *)groupName
{
    return @"mtp3-filter-entry";
}

- (NSString *)groupName
{
    return [UMSS7ConfigMTP3FilterEntry groupName];
}

- (UMSS7ConfigMTP3FilterEntry *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMTP3FilterEntry.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMTP3FilterEntry.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMTP3FilterEntry.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigMTP3FilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3FilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end


