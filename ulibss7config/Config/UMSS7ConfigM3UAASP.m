//
//  UMSS7ConfigM3UAASP.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM3UAASP.h"
#import "UMSS7ConfigMacroHelper.h"
@implementation UMSS7ConfigM3UAASP

+ (NSString *)groupName
{
    return @"m3ua-asp";
}

- (NSString *)groupName
{
    return [UMSS7ConfigM3UAASP groupName];
}


- (UMSS7ConfigM3UAASP *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigM3UAASP.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigM3UAASP.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigM3UAASP.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigM3UAASP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM3UAASP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

