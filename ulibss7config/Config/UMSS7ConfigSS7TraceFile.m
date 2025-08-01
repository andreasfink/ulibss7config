//
//  UMSS7ConfigSS7FilterTraceFile.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7TraceFile.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSS7TraceFile


+ (NSString *)groupName
{
    return @"ss7-tracefile";
}

- (NSString *)groupName
{
    return [UMSS7ConfigSS7TraceFile groupName];
}

- (UMSS7ConfigSS7TraceFile *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSS7TraceFile.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSS7TraceFile.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSS7TraceFile.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSS7TraceFile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSS7TraceFile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
