#if 0
//
//  UMSS7ConfigGTMapEntry.m
//  ulibss7config
//
//  Created by Andreas Fink on 24.01.2026.
//  Copyright © 2026 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGTMapEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigGTMapEntry

+ (NSString *)groupName
{
    return @"gt-map-entry";
}

- (NSString *)groupName
{
    return [UMSS7ConfigGTMapEntry groupName];
}

- (UMSS7ConfigGTMapEntry *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGTMapEntry.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGTMapEntry.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigGTMapEntry.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigGTMapEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGTMapEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
#endif
