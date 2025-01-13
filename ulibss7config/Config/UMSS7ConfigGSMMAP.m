//
//  UMSS7ConfigGSMMAP.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMMAP.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMMAP


+ (NSString *)type
{
    return @"gsmmap";
}

- (NSString *)type
{
    return [UMSS7ConfigGSMMAP type];
}


- (UMSS7ConfigGSMMAP *)initWithConfig:(NSDictionary *)dict
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

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigGSMMAP.def"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(o,@"address",_address);
    APPEND_CONFIG_STRING(o,@"ssn",_ssn);
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);
    APPEND_CONFIG_STRING(o,@"operations",_operations);
#endif
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGSMMAP.def"
#include "UMSS7Config_macroClear.h"
#else

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"address",_address);
    APPEND_DICT_STRING(o,@"ssn",_ssn);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_STRING(o,@"operations",_operations);
#endif
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigGSMMAP.def"
#include "UMSS7Config_macroClear.h"
#else

    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"address",_address);
    SET_DICT_STRING(o,@"ssn",_ssn);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_STRING(o,@"operations",_operations);
#endif
}

- (UMSS7ConfigGSMMAP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMMAP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
