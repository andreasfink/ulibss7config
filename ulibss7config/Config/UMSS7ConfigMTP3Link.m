//
//  UMSS7ConfigMtp3Link.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Link.h"
#import "UMSS7ConfigMacroHelper.h"

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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMTP3Link.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"mtp3-linkset",_mtp3LinkSet);
    APPEND_DICT_STRING(o,@"m2pa",_m2pa);
    APPEND_DICT_INTEGER(o,@"slc",_slc);
    APPEND_DICT_DOUBLE(o,@"link-test-time",_linkTestTime);
    APPEND_DICT_DOUBLE(o,@"link-test-ack-time",_linkTestAckTime);
    APPEND_DICT_DOUBLE(o,@"reopen-timer1",_reopenTimer1);
    APPEND_DICT_DOUBLE(o,@"reopen-timer2",_reopenTimer2);

    APPEND_DICT_INTEGER(o,@"m2pa-window-size",_m2pa_windowSize);
    APPEND_DICT_DOUBLE(o,@"m2pa-t1",_m2pa_t1);
    APPEND_DICT_DOUBLE(o,@"m2pa-t2",_m2pa_t2);
    APPEND_DICT_DOUBLE(o,@"m2pa-t3",_m2pa_t3);
    APPEND_DICT_DOUBLE(o,@"m2pa-t4e",_m2pa_t4e);
    APPEND_DICT_DOUBLE(o,@"m2pa-t4n",_m2pa_t4n);
    APPEND_DICT_DOUBLE(o,@"m2pa-t5",_m2pa_t5);
    APPEND_DICT_DOUBLE(o,@"m2pa-t6",_m2pa_t6);
    APPEND_DICT_DOUBLE(o,@"m2pa-t7",_m2pa_t7);
    APPEND_DICT_STRING(o,@"m2pa-state-machine-log",_m2pa_stateMachineLog);

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
    SET_DICT_FILTERED_STRING(dict,@"mtp3-linkset",_mtp3LinkSet);
    SET_DICT_STRING(o,@"m2pa",_m2pa);
    SET_DICT_INTEGER(o,@"slc",_slc);
    SET_DICT_DOUBLE(o,@"link-test-time",_linkTestTime);
    SET_DICT_DOUBLE(o,@"link-test-ack-time",_linkTestAckTime);
    SET_DICT_DOUBLE(o,@"reopen-timer1",_reopenTimer1);
    SET_DICT_DOUBLE(o,@"reopen-timer2",_reopenTimer2);

    SET_DICT_INTEGER(o,@"m2pa-window-size",_m2pa_windowSize);
    SET_DICT_DOUBLE(o,@"m2pa-t1",_m2pa_t1);
    SET_DICT_DOUBLE(o,@"m2pa-t2",_m2pa_t2);
    SET_DICT_DOUBLE(o,@"m2pa-t3",_m2pa_t3);
    SET_DICT_DOUBLE(o,@"m2pa-t4e",_m2pa_t4e);
    SET_DICT_DOUBLE(o,@"m2pa-t4n",_m2pa_t4n);
    SET_DICT_DOUBLE(o,@"m2pa-t5",_m2pa_t5);
    SET_DICT_DOUBLE(o,@"m2pa-t6",_m2pa_t6);
    SET_DICT_DOUBLE(o,@"m2pa-t7",_m2pa_t7);
    SET_DICT_STRING(o,@"m2pa-state-machine-log",_m2pa_stateMachineLog);

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

- (UMSS7ConfigMTP3Link *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Link allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end
