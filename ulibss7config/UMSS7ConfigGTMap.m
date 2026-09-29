#if 0
//
//  UMSS7ConfigGTMap.m
//  ulibss7config
//
//  Created by Andreas Fink on 24.01.2026.
//  Copyright © 2026 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGTMap.h"
#import "UMSS7ConfigMacroHelper.h"
#import "UMSS7ConfigGTMapEntry.h"

@implementation UMSS7ConfigGTMap

+ (NSString *)groupName
{
    return @"gt-map";
}

- (NSString *)groupName
{
    return [UMSS7ConfigGTMap groupName];
}


- (UMSS7ConfigGTMap *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGTMap.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigGTMap.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
}

- (UMSS7ConfigGTMap *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGTMap allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
#endif
