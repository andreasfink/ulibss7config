//
//  UMSS7ConfigMirrorPort.m
//  ulibss7config
//
//  Created by Andreas Fink on 09.05.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMirrorPort.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMirrorPort

+ (NSString *)type
{
    return @"mirror-port";
}

- (NSString *)type
{
    return [UMSS7ConfigMirrorPort type];
}

- (UMSS7ConfigMirrorPort *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMirrorPort.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMirrorPort.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMirrorPort.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigMirrorPort *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMirrorPort allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


