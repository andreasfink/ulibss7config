//
//  UMSS7ConfigSMPPPlugin.m
//  ulibss7config
//
//  Created by Andreas Fink on 11.04.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMPPPlugin.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMPPPlugin

+ (NSString *)type
{
    return @"smpp-plugin";
}
- (NSString *)type
{
    return [UMSS7ConfigSMPPPlugin type];
}

- (UMSS7ConfigSMPPPlugin *)initWithConfig:(NSDictionary *)dict directory:(NSString *)dir
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
        UMAssert(_name.length > 0,@"Name must exist for plugin");
        _defaultFileName = [NSString stringWithFormat:@"%@/%@",dir,_name.urlencode];
        if(dict[@"path"])
        {
            _pluginFileName = dict[@"path"];
        }
        else
        {
            _pluginFileName = _defaultFileName;
        }
    }
    return self;
}

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigSMPPPlugin.def.h"
#include "UMSS7Config_macroClear.h"

/*
    if(![_pluginFileName isEqualToString:_defaultFileName])
    {
        APPEND_CONFIG_STRING(o,@"path",_pluginFileName);
    }
    APPEND_CONFIG_STRING(o,@"config-file",_configFile);
    APPEND_CONFIG_STRING(o,@"config-string",_configString);
*/
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSMPPPlugin.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSMPPPlugin.def.h"
#include "UMSS7Config_macroClear.h"
}

@end
