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

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    if(![_pluginFileName isEqualTo:_defaultFileNameilename])
    {
        APPEND_CONFIG_STRING(s,@"path",_pluginFileName);
    }
    APPEND_CONFIG_STRING(s,@"config-file",_configFile);
    APPEND_CONFIG_STRING(s,@"config-string",_configString);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    if(![_pluginFileName isEqualTo:_defaultFileNameilename])
    {
        APPEND_DICT_STRING(dict,@"path",_pluginFileName);
    }
    APPEND_DICT_STRING(dict,@"config-file",_configFile);
    APPEND_DICT_STRING(dict,@"config-string",_configString);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"path",_pluginFileName);
    SET_DICT_STRING(dict,@"config-file",_configFile);
    SET_DICT_STRING(dict,@"config-string",_configString);
}

@end
