//
//  UMSS7ConfigSctp.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCTP.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSCTP

+ (NSString *)type
{
    return @"sctp";
}


- (UMSS7ConfigSCTP *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}

- (NSString *)type
{
    return [UMSS7ConfigSCTP type];
}

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigSCTP.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCTP.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCTP.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSCTP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCTP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

