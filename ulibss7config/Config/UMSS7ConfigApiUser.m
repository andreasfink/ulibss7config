//
//  UMSS7ConfigApiUser.m
//  ulibss7config
//
//  Created by Andreas Fink on 01.01.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigApiUser.h>
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigApiUser

+ (NSString *)type
{
    return @"api-user";
}
- (NSString *)type
{
    return [UMSS7ConfigApiUser type];
}

- (UMSS7ConfigApiUser *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigApiUser.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigApiUser.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigApiUser.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigApiUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigApiUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

