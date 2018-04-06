//
//  UMSS7ConfigTelnet.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigTelnet.h"
#import "UMSS7ConfigMacros.h"

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


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_INTEGER(s,@"port",_port);
    APPEND_CONFIG_STRING(s,@"telnet-user",_telnetUsername);
    APPEND_CONFIG_STRING(s,@"telnet-password",_telnetPassword);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_INTEGER(dict,@"port",_port);
    APPEND_DICT_STRING(dict,@"telnet-user",_telnetUsername);
    APPEND_DICT_STRING(dict,@"telnet-password",_telnetPassword);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_INTEGER(dict,@"port",_port);
    SET_DICT_STRING(dict,@"telnet-user",_telnetUsername);
    SET_DICT_STRING(dict,@"telnet-password",_telnetPassword);
}

- (UMSS7ConfigTelnet *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTelnet allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
