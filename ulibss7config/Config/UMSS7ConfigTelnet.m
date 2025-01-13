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
    APPEND_CONFIG_INTEGER(o,@"port",_port);
    APPEND_CONFIG_STRING(o,@"telnet-user",_telnetUsername);
    APPEND_CONFIG_STRING(o,@"telnet-password",_telnetPassword);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_INTEGER(o,@"port",_port);
    APPEND_DICT_STRING(o,@"telnet-user",_telnetUsername);
    APPEND_DICT_STRING(o,@"telnet-password",_telnetPassword);
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_INTEGER(o,@"port",_port);
    SET_DICT_STRING(o,@"telnet-user",_telnetUsername);
    SET_DICT_STRING(o,@"telnet-password",_telnetPassword);
}

- (UMSS7ConfigTelnet *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTelnet allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
