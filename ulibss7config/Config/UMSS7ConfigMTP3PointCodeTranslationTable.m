//
//  UMSS7ConfigMTP3PointCodeTranslationTable.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMTP3PointCodeTranslationTable


+ (NSString *)type
{
    return @"mtp3-pointcode-translation";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3PointCodeTranslationTable type];
}

- (UMSS7ConfigMTP3PointCodeTranslationTable *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMTP3PointCodeTranslationTable.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMTP3PointCodeTranslationTable.def.h"
#include "UMSS7Config_macroClear.h"
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMTP3PointCodeTranslationTable.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSS7ConfigMTP3PointCodeTranslationTable *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3PointCodeTranslationTable allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
