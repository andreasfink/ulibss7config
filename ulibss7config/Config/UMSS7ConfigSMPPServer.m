//
//  UMSS7ConfigSMPPServer.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMPPServer.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMPPServer


+ (NSString *)type
{
   return @"smpp-server";
}
- (NSString *)type
{
   return [UMSS7ConfigSMPPServer type];
}

- (UMSS7ConfigSMPPServer *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSMPPServer.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSMPPServer.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSMPPServer.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSMPPServer *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMPPServer allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
