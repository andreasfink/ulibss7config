//
//  UMSS7ConfigSCCPNumberTranslation.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPNumberTranslation.h"
#import "UMSS7ConfigMacroHelper.h"
#import "UMSS7ConfigSCCPNumberTranslationEntry.h"

@implementation UMSS7ConfigSCCPNumberTranslation


+ (NSString *)type
{
    return @"sccp-number-translation";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPNumberTranslation type];
}


- (UMSS7ConfigSCCPNumberTranslation *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPNumberTranslation.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPNumberTranslation.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
}

- (UMSS7ConfigSCCPNumberTranslation *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPNumberTranslation allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
