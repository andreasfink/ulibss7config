//
//  UMSS7ConfigDiameterConnection.m
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterConnection.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigDiameterConnection

+ (NSString *)type
{
    return @"diameter-connection";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterConnection type];
}


- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigDiameterConnection.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigDiameterConnection.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigDiameterConnection.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSS7ConfigDiameterConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


