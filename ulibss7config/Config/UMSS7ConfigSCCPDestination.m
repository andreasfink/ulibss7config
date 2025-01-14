//
//  UMSS7ConfigSCCPDestination.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPDestination.h"
#import "UMSS7ConfigMacroHelper.h"
#import "UMSS7ConfigSCCPDestinationEntry.h"

@implementation UMSS7ConfigSCCPDestination

+ (NSString *)type
{
    return @"sccp-destination";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPDestination type];
}


- (UMSS7ConfigSCCPDestination *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSCCPDestination.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPDestination.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPDestination.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigSCCPDestination *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestination allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
