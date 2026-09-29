//
//  UMSS7ConfigMTP3.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMTP3


+ (NSString *)groupName
{
    return @"mtp3";
}

- (NSString *)groupName
{
    return [UMSS7ConfigMTP3 groupName];
}

- (UMSS7ConfigMTP3 *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMTP3.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMTP3.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMTP3.def.h"
#include "UMSS7Config_macroClear.h"


}

- (UMSS7ConfigMTP3 *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3 allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
