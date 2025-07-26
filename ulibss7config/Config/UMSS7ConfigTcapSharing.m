//
//  UMSS7ConfigTcapSharing.m
//  ulibss7config
//
//  Created by Andreas Fink on 11.07.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigTcapSharing.h>
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigTcapSharing

+ (NSString *)groupName
{
    return @"tcap-sharing";
}

- (NSString *)groupName
{
    return [UMSS7ConfigTcapSharing groupName];
}

- (UMSS7ConfigTcapSharing *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigTcapSharing.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigTcapSharing.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigTcapSharing.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigTcapSharing *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTcapSharing allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
