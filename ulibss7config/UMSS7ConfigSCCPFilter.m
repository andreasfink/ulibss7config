//
//  UMSS7ConfigSCCPFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPFilter.h"
//#import "UMSS7ConfigSCCPFilterEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSCCPFilter

+ (NSString *)groupName
{
    return @"sccp-filter";
}
- (NSString *)groupName
{
    return [UMSS7ConfigSCCPFilter groupName];
}

- (UMSS7ConfigSCCPFilter *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSCCPFilter.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPFilter.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPFilter.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSCCPFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

