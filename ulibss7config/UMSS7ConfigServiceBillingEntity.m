//
//  UMSS7ConfigServiceBillingEntity.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigServiceBillingEntity.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigServiceBillingEntity


+ (NSString *)groupName
{
    return @"service-billing-entity";
}
- (NSString *)groupName
{
    return [UMSS7ConfigServiceBillingEntity groupName];
}

- (UMSS7ConfigServiceBillingEntity *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigServiceBillingEntity.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigServiceBillingEntity.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigServiceBillingEntity.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigServiceBillingEntity *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigServiceBillingEntity allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
