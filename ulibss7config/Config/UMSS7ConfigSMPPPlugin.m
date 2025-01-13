//
//  UMSS7ConfigSMPPPlugin.m
//  ulibss7config
//
//  Created by Andreas Fink on 11.04.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMPPPlugin.h"
#import "UMSS7ConfigMacros.h"

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
        _defaultFileNameilename = [NSString stringWithFormat:@"%@/%@",dir,_name.urlencode];
        if(dict[@"path"])
        {
            _pluginFileName = dict[@"path"];
        }
        else
        {
            _pluginFileName = _defaultFileNameilename;
        }
    }
    return self;
}

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    if(![_pluginFileName isEqualToString:_defaultFileNameilename])
    {
        APPEND_CONFIG_STRING(o,@"path",_pluginFileName);
    }
    APPEND_CONFIG_STRING(o,@"config-file",_configFile);
    APPEND_CONFIG_STRING(o,@"config-string",_configString);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    if(![_pluginFileName isEqualToString:_defaultFileNameilename])
    {
        APPEND_DICT_STRING(o,@"path",_pluginFileName);
    }
    APPEND_DICT_STRING(o,@"config-file",_configFile);
    APPEND_DICT_STRING(o,@"config-string",_configString);
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"path",_pluginFileName);
    SET_DICT_STRING(o,@"config-file",_configFile);
    SET_DICT_STRING(o,@"config-string",_configString);
}

@end
