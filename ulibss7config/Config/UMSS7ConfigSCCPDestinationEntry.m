//
//  UMSS7ConfigSCCPDestinationGroupEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPDestinationEntry.h"
#import "UMSS7ConfigMacroHelper.h"
@implementation UMSS7ConfigSCCPDestinationEntry


+ (NSString *)type
{
    return @"sccp-destination-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPDestinationEntry type];
}


- (UMSS7ConfigSCCPDestinationEntry *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSCCPDestinationEntry.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPDestinationEntry.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPDestinationEntry.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSS7ConfigSCCPDestinationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestinationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
