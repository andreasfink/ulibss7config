//
//  UMSS7ConfigMtp3Link.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Link.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3Link


+ (NSString *)type
{
    return @"mtp3-link";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3Link type];
}


- (UMSS7ConfigMTP3Link *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"mtp3-linkset",_mtp3LinkSet);
    APPEND_CONFIG_STRING(s,@"m2pa",_m2pa);
    APPEND_CONFIG_INTEGER(s,@"slc",_slc);
    APPEND_CONFIG_DOUBLE(s,@"link-test-time",_linkTestTime);
    APPEND_CONFIG_DOUBLE(s,@"link-test-ack-time",_linkTestAckTime);
    APPEND_CONFIG_DOUBLE(s,@"reopen-timer1",_reopenTimer1);
    APPEND_CONFIG_DOUBLE(s,@"reopen-timer2",_reopenTimer2);

    APPEND_CONFIG_INTEGER(s,@"m2pa-window-size",_m2pa_windowSize);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t1",_m2pa_t1);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t2",_m2pa_t2);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t3",_m2pa_t3);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t4e",_m2pa_t4e);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t4n",_m2pa_t4n);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t5",_m2pa_t5);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t6",_m2pa_t6);
    APPEND_CONFIG_DOUBLE(s,@"m2pa-t7",_m2pa_t7);
    APPEND_CONFIG_STRING(s,@"m2pa-state-machine-log",_m2pa_stateMachineLog);

    APPEND_CONFIG_ARRAY_VERBOSE(s,@"sctp-local-ip",_sctp_localAddresses);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"sctp-remote-ip",_sctp_remoteAddresses);
    APPEND_CONFIG_INTEGER(s,@"sctp-local-port",_sctp_localPort);
    APPEND_CONFIG_INTEGER(s,@"sctp-remote-port",_sctp_remotePort);
    APPEND_CONFIG_BOOLEAN(s,@"sctp-allow-any-remote-port-inbound",_sctp_allowAnyRemotePortIncoming);
    APPEND_CONFIG_BOOLEAN(s,@"sctp-passive",_sctp_passive);
    APPEND_CONFIG_DOUBLE(s,@"sctp-heartbeat",_sctp_heartbeat);
    APPEND_CONFIG_INTEGER(s,@"sctp-mtu",_sctp_mtu);
    APPEND_CONFIG_INTEGER(s,@"sctp-max-init-timeout",_sctp_maxInitTimeout);
    APPEND_CONFIG_INTEGER(s,@"sctp-max-init-attempts",_sctp_maxInitAttempts);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"mtp3-linkset",_mtp3LinkSet);
    APPEND_DICT_STRING(dict,@"m2pa",_m2pa);
    APPEND_DICT_INTEGER(dict,@"slc",_slc);
    APPEND_DICT_DOUBLE(dict,@"link-test-time",_linkTestTime);
    APPEND_DICT_DOUBLE(dict,@"link-test-ack-time",_linkTestAckTime);
    APPEND_DICT_DOUBLE(dict,@"reopen-timer1",_reopenTimer1);
    APPEND_DICT_DOUBLE(dict,@"reopen-timer2",_reopenTimer2);

    APPEND_DICT_INTEGER(dict,@"m2pa-window-size",_m2pa_windowSize);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t1",_m2pa_t1);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t2",_m2pa_t2);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t3",_m2pa_t3);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t4e",_m2pa_t4e);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t4n",_m2pa_t4n);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t5",_m2pa_t5);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t6",_m2pa_t6);
    APPEND_DICT_DOUBLE(dict,@"m2pa-t7",_m2pa_t7);
    APPEND_DICT_STRING(dict,@"m2pa-state-machine-log",_m2pa_stateMachineLog);

    APPEND_DICT_ARRAY(dict,@"sctp-local-ip",_sctp_localAddresses);
    APPEND_DICT_ARRAY(dict,@"sctp-remote-ip",_sctp_remoteAddresses);
    APPEND_DICT_INTEGER(dict,@"sctp-local-port",_sctp_localPort);
    APPEND_DICT_INTEGER(dict,@"sctp-remote-port",_sctp_remotePort);
    APPEND_DICT_BOOLEAN(dict,@"sctp-allow-any-remote-port-inbound",_sctp_allowAnyRemotePortIncoming);
    APPEND_DICT_BOOLEAN(dict,@"sctp-passive",_sctp_passive);
    APPEND_DICT_DOUBLE(dict,@"sctp-heartbeat",_sctp_heartbeat);
    APPEND_DICT_INTEGER(dict,@"sctp-mtu",_sctp_mtu);
    APPEND_DICT_INTEGER(dict,@"sctp-max-init-timeout",_sctp_maxInitTimeout);
    APPEND_DICT_INTEGER(dict,@"sctp-max-init-attempts",_sctp_maxInitAttempts);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"mtp3-linkset",_mtp3LinkSet);
    SET_DICT_STRING(dict,@"m2pa",_m2pa);
    SET_DICT_INTEGER(dict,@"slc",_slc);
    SET_DICT_DOUBLE(dict,@"link-test-time",_linkTestTime);
    SET_DICT_DOUBLE(dict,@"link-test-ack-time",_linkTestAckTime);
    SET_DICT_DOUBLE(dict,@"reopen-timer1",_reopenTimer1);
    SET_DICT_DOUBLE(dict,@"reopen-timer2",_reopenTimer2);

    SET_DICT_INTEGER(dict,@"m2pa-window-size",_m2pa_windowSize);
    SET_DICT_DOUBLE(dict,@"m2pa-t1",_m2pa_t1);
    SET_DICT_DOUBLE(dict,@"m2pa-t2",_m2pa_t2);
    SET_DICT_DOUBLE(dict,@"m2pa-t3",_m2pa_t3);
    SET_DICT_DOUBLE(dict,@"m2pa-t4e",_m2pa_t4e);
    SET_DICT_DOUBLE(dict,@"m2pa-t4n",_m2pa_t4n);
    SET_DICT_DOUBLE(dict,@"m2pa-t5",_m2pa_t5);
    SET_DICT_DOUBLE(dict,@"m2pa-t6",_m2pa_t6);
    SET_DICT_DOUBLE(dict,@"m2pa-t7",_m2pa_t7);
    SET_DICT_STRING(dict,@"m2pa-state-machine-log",_m2pa_stateMachineLog);

    SET_DICT_ARRAY(dict,@"sctp-local-ip",_sctp_localAddresses);
    SET_DICT_ARRAY(dict,@"sctp-remote-ip",_sctp_remoteAddresses);
    SET_DICT_INTEGER(dict,@"sctp-local-port",_sctp_localPort);
    SET_DICT_INTEGER(dict,@"sctp-remote-port",_sctp_remotePort);
    SET_DICT_BOOLEAN(dict,@"sctp-allow-any-remote-port-inbound",_sctp_allowAnyRemotePortIncoming);
    SET_DICT_BOOLEAN(dict,@"sctp-passive",_sctp_passive);
    SET_DICT_DOUBLE(dict,@"sctp-heartbeat",_sctp_heartbeat);
    SET_DICT_INTEGER(dict,@"sctp-mtu",_sctp_mtu);
    SET_DICT_INTEGER(dict,@"sctp-max-init-timeout",_sctp_maxInitTimeout);
    SET_DICT_INTEGER(dict,@"sctp-max-init-attempts",_sctp_maxInitAttempts);
}

- (UMSS7ConfigMTP3Link *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Link allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end
