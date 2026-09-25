//
//  UMSS7ConfigAdminUser.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigAdminUser.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigAdminUser

+ (NSString *)groupName
{
    return @"admin-user";
}
- (NSString *)groupName
{
    return [UMSS7ConfigAdminUser groupName];
}

- (UMSS7ConfigAdminUser *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigAdminUser.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigAdminUser.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigAdminUser.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigAdminUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigAdminUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

- (BOOL)matchesIpAddress:(NSString *)ip
{
    /* FIXME */
    return NO;
}

@end

