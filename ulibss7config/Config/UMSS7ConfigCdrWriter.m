//
//  UMSS7ConfigCdrWriter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigCdrWriter.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigCdrWriter

+ (NSString *)groupName
{
    return @"cdr-writer";
}

- (NSString *)groupName
{
    return [UMSS7ConfigCdrWriter groupName];
}


- (UMSS7ConfigCdrWriter *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigCdrWriter.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigCdrWriter.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigCdrWriter.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigCdrWriter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigCdrWriter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end




