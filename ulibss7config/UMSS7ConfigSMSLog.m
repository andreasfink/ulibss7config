//
//  UMSS7ConfigSMSLog.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.04.2024.
//  Copyright © 2024 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSLog.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMSLog

+ (NSString *)groupName
{
   return @"sms-log";
}

- (NSString *)groupName
{
   return [UMSS7ConfigSMSLog groupName];
}

- (UMSS7ConfigSMSLog *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSMSLog.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSMSLog.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSMSLog.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigSMSLog *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSLog allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
