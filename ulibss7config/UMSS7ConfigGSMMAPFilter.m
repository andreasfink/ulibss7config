//
//  UMSS7ConfigGSMMAPFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMMAPFilter.h"
#import "UMSS7ConfigGSMMAPFilterEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigGSMMAPFilter

+ (NSString *)groupName
{
    return @"gsmmap-filter";
}
- (NSString *)groupName
{
    return [UMSS7ConfigGSMMAPFilter groupName];
}

- (UMSS7ConfigGSMMAPFilter *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigGSMMAPFilter.def.h"
#include "UMSS7Config_macroClear.h"
    for(UMSS7ConfigGSMMAPFilterEntry *e in _subEntries)
    {
        [o appendString:@"\n"];
        [e appendConfigToString:o];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGSMMAPFilter.def.h"
#include "UMSS7Config_macroClear.h"
    return 0;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigGSMMAPFilter.def.h"
#include "UMSS7Config_macroClear.h"
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigGSMMAPFilterEntry *entry = [[UMSS7ConfigGSMMAPFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}


- (UMSS7ConfigGSMMAPFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMMAPFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
