//
//  UMSS7SConfigServiceUser.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigServiceUser

+ (NSString *)groupName
{
    return @"service-user";
}
- (NSString *)groupName
{
    return [UMSS7ConfigServiceUser groupName];
}

- (UMSS7ConfigServiceUser *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigServiceUser.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigServiceUser.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigServiceUser.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigServiceUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigServiceUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
