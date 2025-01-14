//
//  UMSS7ConfigSMSDeliveryProvider.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.08.21.
//  Copyright © 2021 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSDeliveryProvider.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMSDeliveryProvider


+ (NSString *)type
{
    return @"sms-delivery-provider";
}

- (NSString *)type
{
    return [UMSS7ConfigSMSDeliveryProvider type];
}


- (UMSS7ConfigSMSDeliveryProvider *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSMSDeliveryProvider.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSMSDeliveryProvider.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSMSDeliveryProvider.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigSMSDeliveryProvider *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSDeliveryProvider allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



