//
//  UMSS7ConfigM3UAASP.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM3UAASP.h"
#import "UMSS7ConfigMacros.h"
@implementation UMSS7ConfigM3UAASP

+ (NSString *)type
{
    return @"m3ua-asp";
}

- (NSString *)type
{
    return [UMSS7ConfigM3UAASP type];
}


- (UMSS7ConfigM3UAASP *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"m3ua-as",_m3ua_as);
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_DOUBLE(o,@"reopen-timer1",_reopenTimer1);
    APPEND_CONFIG_DOUBLE(o,@"reopen-timer2",_reopenTimer2);
    APPEND_CONFIG_DOUBLE(o,@"linktest-timer",_linktestTimer);
    APPEND_CONFIG_DOUBLE(o,@"beat-timer",_beatTimer);
    APPEND_CONFIG_INTEGER(o,@"beat-max-outstanding",_beatMaxOutstanding);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"sctp-local-ip",_sctp_localAddresses);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"sctp-remote-ip",_sctp_remoteAddresses);
    APPEND_CONFIG_INTEGER(o,@"sctp-local-port",_sctp_localPort);
    APPEND_CONFIG_INTEGER(o,@"sctp-remote-port",_sctp_remotePort);
    APPEND_CONFIG_BOOLEAN(o,@"sctp-allow-any-remote-port-inbound",_sctp_allowAnyRemotePortIncoming);
    APPEND_CONFIG_BOOLEAN(o,@"sctp-passive",_sctp_passive);
    APPEND_CONFIG_DOUBLE(o,@"sctp-heartbeat",_sctp_heartbeat);
    APPEND_CONFIG_INTEGER(o,@"sctp-mtu",_sctp_mtu);
    APPEND_CONFIG_INTEGER(o,@"sctp-max-init-timeout",_sctp_maxInitTimeout);
    APPEND_CONFIG_INTEGER(o,@"sctp-max-init-attempts",_sctp_maxInitAttempts);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"m3ua-as",_m3ua_as);
    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_DOUBLE(o,@"reopen-timer1",_reopenTimer1);
    APPEND_DICT_DOUBLE(o,@"reopen-timer2",_reopenTimer2);
    APPEND_DICT_DOUBLE(o,@"linktest-timer",_linktestTimer);
    APPEND_DICT_DOUBLE(o,@"beat-timer",_beatTimer);
    APPEND_DICT_INTEGER(o,@"beat-max-outstanding",_beatMaxOutstanding);
    APPEND_DICT_ARRAY(dict,@"sctp-local-ip",_sctp_localAddresses);
    APPEND_DICT_ARRAY(dict,@"sctp-remote-ip",_sctp_remoteAddresses);
    APPEND_DICT_INTEGER(o,@"sctp-local-port",_sctp_localPort);
    APPEND_DICT_INTEGER(o,@"sctp-remote-port",_sctp_remotePort);
    APPEND_DICT_BOOLEAN(o,@"sctp-allow-any-remote-port-inbound",_sctp_allowAnyRemotePortIncoming);
    APPEND_DICT_BOOLEAN(o,@"sctp-passive",_sctp_passive);
    APPEND_DICT_DOUBLE(o,@"sctp-heartbeat",_sctp_heartbeat);
    APPEND_DICT_INTEGER(o,@"sctp-mtu",_sctp_mtu);
    APPEND_DICT_INTEGER(o,@"sctp-max-init-timeout",_sctp_maxInitTimeout);
    APPEND_DICT_INTEGER(o,@"sctp-max-init-attempts",_sctp_maxInitAttempts);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"m3ua-as",_m3ua_as);
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_DOUBLE(o,@"reopen-timer1",_reopenTimer1);
    SET_DICT_DOUBLE(o,@"reopen-timer2",_reopenTimer2);
    SET_DICT_DOUBLE(o,@"linktest-timer",_linktestTimer);
    SET_DICT_DOUBLE(o,@"beat-timer",_beatTimer);
    SET_DICT_INTEGER(o,@"beat-max-outstanding",_beatMaxOutstanding);
    SET_DICT_ARRAY(dict,@"sctp-local-ip",_sctp_localAddresses);
    SET_DICT_ARRAY(dict,@"sctp-remote-ip",_sctp_remoteAddresses);
    SET_DICT_INTEGER(o,@"sctp-local-port",_sctp_localPort);
    SET_DICT_INTEGER(o,@"sctp-remote-port",_sctp_remotePort);
    SET_DICT_BOOLEAN(o,@"sctp-allow-any-remote-port-inbound",_sctp_allowAnyRemotePortIncoming);
    SET_DICT_BOOLEAN(o,@"sctp-passive",_sctp_passive);
    SET_DICT_DOUBLE(o,@"sctp-heartbeat",_sctp_heartbeat);
    SET_DICT_INTEGER(o,@"sctp-mtu",_sctp_mtu);
    SET_DICT_INTEGER(o,@"sctp-max-init-timeout",_sctp_maxInitTimeout);
    SET_DICT_INTEGER(o,@"sctp-max-init-attempts",_sctp_maxInitAttempts);
}

- (UMSS7ConfigM3UAASP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM3UAASP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

