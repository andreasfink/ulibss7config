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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"router",_router);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"local-ip",_localAddresses);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"remote-ip",_remoteAddresses);
    APPEND_CONFIG_INTEGER(o,@"local-port",_localPort);
    APPEND_CONFIG_INTEGER(o,@"remote-port",_remotePort);
    APPEND_CONFIG_STRING(o,@"protocol",_protocol);
    APPEND_CONFIG_DOUBLE(o,@"heartbeat",_heartbeat);
    APPEND_CONFIG_INTEGER(o,@"mtu",_mtu);
    APPEND_CONFIG_STRING(o,@"local-hostname",_localHostName);
    APPEND_CONFIG_STRING(o,@"local-realm",_localRealm);
    APPEND_CONFIG_STRING(o,@"peer-hostname",_peerHostName);
    APPEND_CONFIG_STRING(o,@"peer-realm",_peerRealm);
    APPEND_CONFIG_BOOLEAN(o,@"reverse-cer",_sendReverseCER);
    APPEND_CONFIG_BOOLEAN(o,@"send-cur",_sendCUR);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"router",_router);
    APPEND_DICT_ARRAY(dict,@"local-ip",_localAddresses);
    APPEND_DICT_ARRAY(dict,@"remote-ip",_remoteAddresses);
    APPEND_DICT_INTEGER(o,@"local-port",_localPort);
    APPEND_DICT_INTEGER(o,@"remote-port",_remotePort);
    APPEND_DICT_STRING(o,@"protocol",_protocol);
    APPEND_DICT_DOUBLE(o,@"heartbeat",_heartbeat);
    APPEND_DICT_INTEGER(o,@"mtu",_mtu);
    APPEND_DICT_STRING(o,@"local-hostname",_localHostName);
    APPEND_DICT_STRING(o,@"local-realm",_localRealm);
    APPEND_DICT_STRING(o,@"peer-hostname",_peerHostName);
    APPEND_DICT_STRING(o,@"peer-realm",_peerRealm);
    APPEND_DICT_BOOLEAN(o,@"reverse-cer",_sendReverseCER);
    APPEND_DICT_BOOLEAN(o,@"send-cur",_sendCUR);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"router",_router);
    SET_DICT_ARRAY(dict,@"local-ip",_localAddresses);
    SET_DICT_ARRAY(dict,@"remote-ip",_remoteAddresses);
    SET_DICT_INTEGER(o,@"local-port",_localPort);
    SET_DICT_INTEGER(o,@"remote-port",_remotePort);
    SET_DICT_STRING(o,@"protocol",_protocol);
    SET_DICT_DOUBLE(o,@"heartbeat",_heartbeat);
    SET_DICT_INTEGER(o,@"mtu",_mtu);
    SET_DICT_STRING(o,@"local-hostname",_localHostName);
    SET_DICT_STRING(o,@"local-realm",_localRealm);
    SET_DICT_STRING(o,@"peer-hostname",_peerHostName);
    SET_DICT_STRING(o,@"peer-realm",_peerRealm);
    SET_DICT_BOOLEAN(o,@"reverse-cer",_sendReverseCER);
    SET_DICT_BOOLEAN(o,@"send-cur",_sendCUR);
}

- (UMSS7ConfigDiameterConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


