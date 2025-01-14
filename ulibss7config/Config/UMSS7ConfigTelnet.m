//
//  UMSS7ConfigTelnet.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigTelnet.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigTelnet

+ (NSString *)type
{
    return @"telnet";
}
- (NSString *)type
{
    return [UMSS7ConfigTelnet type];
}

- (UMSS7ConfigTelnet *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigTelnet.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigTelnet.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigTelnet.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigTelnet *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTelnet allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
