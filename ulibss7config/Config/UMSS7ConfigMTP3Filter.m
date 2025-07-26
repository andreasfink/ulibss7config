//
//  UMSS7ConfigMTP3Filter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Filter.h"
#import "UMSS7ConfigMTP3FilterEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMTP3Filter

+ (NSString *)groupName
{
    return @"mtp3-filter";
}
- (NSString *)groupName
{
    return [UMSS7ConfigMTP3Filter groupName];
}

- (UMSS7ConfigMTP3Filter *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMTP3Filter.def.h"
#include "UMSS7Config_macroClear.h"

    for(UMSS7ConfigMTP3FilterEntry *e in _subEntries)
    {
        [o appendString:@"\n"];
        [e appendConfigToString:o];
    }

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMTP3Filter.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMTP3Filter.def.h"
#include "UMSS7Config_macroClear.h"
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigMTP3FilterEntry *entry = [[UMSS7ConfigMTP3FilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}

- (UMSS7ConfigMTP3Filter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Filter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end
