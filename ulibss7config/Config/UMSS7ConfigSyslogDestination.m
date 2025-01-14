//
//  UMSS7ConfigSyslogDestination.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSyslogDestination.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSyslogDestination

+ (NSString *)type
{
    return @"syslog-destination";
}
- (NSString *)type
{
    return [UMSS7ConfigSyslogDestination type];
}

- (UMSS7ConfigSyslogDestination *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSyslogDestination.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSyslogDestination.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];

#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSyslogDestination.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSyslogDestination*)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSyslogDestination allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

