//
//  UMSS7ConfigSMPPConnection.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMPPConnection.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMPPConnection


+ (NSString *)groupName
{
   return @"smpp-connection";
}
- (NSString *)groupName
{
   return [UMSS7ConfigSMPPConnection groupName];
}

- (UMSS7ConfigSMPPConnection *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigSMPPConnection.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSMPPConnection.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSMPPConnection.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigSMPPConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMPPConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}



@end
