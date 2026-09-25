//
//  UMSS7ConfigSMSFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSFilter.h"
#import "UMSS7ConfigSMSFilterEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMSFilter

+ (NSString *)groupName
{
    return @"sms-filter";
}
- (NSString *)groupName
{
    return [UMSS7ConfigSMSFilter groupName];
}

- (UMSS7ConfigSMSFilter *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSMSFilter.def.h"
#include "UMSS7Config_macroClear.h"
    for(UMSS7ConfigSMSFilterEntry *e in _subEntries)
    {
        [o appendString:@"\n"];
        [e appendConfigToString:o];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSMSFilter.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSMSFilter.def.h"
#include "UMSS7Config_macroClear.h"
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigSMSFilterEntry *entry = [[UMSS7ConfigSMSFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}

- (UMSS7ConfigSMSFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
