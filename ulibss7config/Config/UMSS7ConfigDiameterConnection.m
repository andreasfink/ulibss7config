//
//  UMSS7ConfigDiameterConnection.m
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterConnection.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDiameterConnection

+ (NSString *)type
{
    return @"diameter-connection";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterConnection type];
}


- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"router",_router);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"local-ip",_localAddresses);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"remote-ip",_remoteAddresses);
    APPEND_CONFIG_INTEGER(s,@"local-port",_localPort);
    APPEND_CONFIG_INTEGER(s,@"remote-port",_remotePort);
    APPEND_CONFIG_STRING(s,@"protocol",_protocol);
    APPEND_CONFIG_DOUBLE(s,@"heartbeat",_heartbeat);
    APPEND_CONFIG_INTEGER(s,@"mtu",_mtu);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"router",_router);
    APPEND_DICT_ARRAY(dict,@"local-ip",_localAddresses);
    APPEND_DICT_ARRAY(dict,@"remote-ip",_remoteAddresses);
    APPEND_DICT_INTEGER(dict,@"local-port",_localPort);
    APPEND_DICT_INTEGER(dict,@"remote-port",_remotePort);
    APPEND_DICT_STRING(dict,@"protocol",_protocol);
    APPEND_DICT_DOUBLE(dict,@"heartbeat",_heartbeat);
    APPEND_DICT_INTEGER(dict,@"mtu",_mtu);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"router",_router);
    SET_DICT_ARRAY(dict,@"local-ip",_localAddresses);
    SET_DICT_ARRAY(dict,@"remote-ip",_remoteAddresses);
    SET_DICT_INTEGER(dict,@"local-port",_localPort);
    SET_DICT_INTEGER(dict,@"remote-port",_remotePort);
    SET_DICT_STRING(dict,@"protocol",_protocol);
    SET_DICT_DOUBLE(dict,@"heartbeat",_heartbeat);
    SET_DICT_INTEGER(dict,@"mtu",_mtu);
}

- (UMSS7ConfigDiameterConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


