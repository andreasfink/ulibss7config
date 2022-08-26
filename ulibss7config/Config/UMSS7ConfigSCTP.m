//
//  UMSS7ConfigSctp.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCTP.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCTP

+ (NSString *)type
{
    return @"sctp";
}


- (UMSS7ConfigSCTP *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}

- (NSString *)type
{
    return [UMSS7ConfigSCTP type];
}

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"local-ip",_localAddresses);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"remote-ip",_remoteAddresses);
    APPEND_CONFIG_INTEGER(s,@"local-port",_localPort);
    APPEND_CONFIG_INTEGER(s,@"remote-port",_remotePort);
    APPEND_CONFIG_BOOLEAN(s,@"sctp-over-tcp",_sctpOverTcp);
    APPEND_CONFIG_STRING(s,@"sctp-over-tcp-session-key",_sctpOverTcpSessionKey);
    APPEND_CONFIG_BOOLEAN(s,@"allow-any-remote-port-inbound",_allowAnyRemotePortIncoming);
    APPEND_CONFIG_BOOLEAN(s,@"passive",_passive);
    APPEND_CONFIG_DOUBLE(s,@"heartbeat",_heartbeat);
    APPEND_CONFIG_INTEGER(s,@"mtu",_mtu);
    APPEND_CONFIG_INTEGER(s,@"max-init-timeout",_maxInitTimeout);
    APPEND_CONFIG_INTEGER(s,@"max-init-attempts",_maxInitAttempts);
    APPEND_CONFIG_INTEGER(s,@"min-receive-buffer-size",_minReceiveBufferSize);
    APPEND_CONFIG_INTEGER(s,@"min-send-buffer-size",_minSendBufferSize);
    APPEND_CONFIG_STRING(s,@"dscp",_dscp);
    APPEND_CONFIG_BOOLEAN(s,@"use-peeloff",_usePeelOff);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_ARRAY(dict,@"local-ip",_localAddresses);
    APPEND_DICT_ARRAY(dict,@"remote-ip",_remoteAddresses);
    APPEND_DICT_INTEGER(dict,@"local-port",_localPort);
    APPEND_DICT_INTEGER(dict,@"remote-port",_remotePort);
    APPEND_DICT_BOOLEAN(dict,@"sctp-over-tcp",_sctpOverTcp);
    APPEND_DICT_STRING(dict,@"sctp-over-tcp-session-key",_sctpOverTcpSessionKey);
    APPEND_DICT_BOOLEAN(dict,@"allow-any-remote-port-inbound",_allowAnyRemotePortIncoming);
    APPEND_DICT_BOOLEAN(dict,@"passive",_passive);
    APPEND_DICT_DOUBLE(dict,@"heartbeat",_heartbeat);
    APPEND_DICT_INTEGER(dict,@"mtu",_mtu);
    APPEND_DICT_INTEGER(dict,@"max-init-timeout",_maxInitTimeout);
    APPEND_DICT_INTEGER(dict,@"max-init-attempts",_maxInitAttempts);
    APPEND_DICT_INTEGER(dict,@"min-receive-buffer-size",_minReceiveBufferSize);
    APPEND_DICT_INTEGER(dict,@"min-send-buffer-size",_minSendBufferSize);
    APPEND_DICT_STRING(dict,@"dscp",_dscp);
    APPEND_DICT_STRING(dict,@"use-peeloff",_usePeelOff);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_ARRAY(dict,@"local-ip",_localAddresses);
    SET_DICT_ARRAY(dict,@"remote-ip",_remoteAddresses);
    SET_DICT_INTEGER(dict,@"local-port",_localPort);
    SET_DICT_INTEGER(dict,@"remote-port",_remotePort);
    SET_DICT_BOOLEAN(dict,@"sctp-over-tcp",_sctpOverTcp);
    SET_DICT_STRING(dict,@"sctp-over-tcp-session-key",_sctpOverTcpSessionKey);
    SET_DICT_BOOLEAN(dict,@"allow-any-remote-port-inbound",_allowAnyRemotePortIncoming);
    SET_DICT_BOOLEAN(dict,@"passive",_passive);
    SET_DICT_DOUBLE(dict,@"heartbeat",_heartbeat);
    SET_DICT_INTEGER(dict,@"mtu",_mtu);
    SET_DICT_INTEGER(dict,@"max-init-timeout",_maxInitTimeout);
    SET_DICT_INTEGER(dict,@"max-init-attempts",_maxInitAttempts);
    SET_DICT_INTEGER(dict,@"min-receive-buffer-size",_minReceiveBufferSize);
    SET_DICT_INTEGER(dict,@"min-send-buffer-size",_minSendBufferSize);
    SET_DICT_STRING(dict,@"dscp",_dscp);
    SET_DICT_STRING(dict,@"use-peeloff",_usePeelOff);
}

- (UMSS7ConfigSCTP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCTP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

