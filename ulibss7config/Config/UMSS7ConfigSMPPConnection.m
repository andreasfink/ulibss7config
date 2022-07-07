//
//  UMSS7ConfigSMPPConnection.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMPPConnection.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMPPConnection


+ (NSString *)type
{
   return @"smpp-connection";
}
- (NSString *)type
{
   return [UMSS7ConfigSMPPConnection type];
}

- (UMSS7ConfigSMPPConnection *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"host",_host);
    APPEND_CONFIG_INTEGER(s,@"port",_port);
    APPEND_CONFIG_BOOLEAN(s,@"use-ssl",_useSSL);
    APPEND_CONFIG_STRING(s,@"ssl-client-cert-key-file",_sslClientCertkeyFile);
    APPEND_CONFIG_BOOLEAN(s,@"transceiver-mode",_transceiverMode);
    APPEND_CONFIG_STRING(s,@"smsc-username",_smscUsername);
    APPEND_CONFIG_STRING(s,@"smsc-password",_smscPassword);
    APPEND_CONFIG_STRING(s,@"system-type",_systemType);
    APPEND_CONFIG_STRING(s,@"service-type",_serviceType);
    APPEND_CONFIG_STRING(s,@"interface-version",_interfaceVersion);
    APPEND_CONFIG_STRING(s,@"address-range",_addressRange);
    APPEND_CONFIG_STRING(s,@"my-number",_myNumber);
    APPEND_CONFIG_INTEGER(s,@"enquire-link-interval",_enquireLinkIntervall);
    APPEND_CONFIG_INTEGER(s,@"max-pending-submits",_maxPendingSubmits);
    APPEND_CONFIG_INTEGER(s,@"reconnect-delay",_reconnectDelay);
    APPEND_CONFIG_INTEGER(s,@"source-addr-ton",_sourceAddrTon);
    APPEND_CONFIG_INTEGER(s,@"source-addr-npi",_sourceAddrNpi);
    APPEND_CONFIG_INTEGER(s,@"destination-addr-ton",_destinationAddrTon);
    APPEND_CONFIG_INTEGER(s,@"destination-addr-npi",_destinationAddrNpi);
    APPEND_CONFIG_INTEGER(s,@"bind-addr-ton",_bindAddrTon);
    APPEND_CONFIG_INTEGER(s,@"bind-addr-npi",_bindAddrNpi);
    APPEND_CONFIG_INTEGER(s,@"message-id-type",_messageIdType);
    APPEND_CONFIG_STRING(s,@"alt-charset",_altCharset);
    APPEND_CONFIG_STRING(s,@"alt-addr-charset",_altAddrCharset);
    APPEND_CONFIG_BOOLEAN(s,@"retry",_retry);
    APPEND_CONFIG_INTEGER(s,@"connection-timeout",_connectionTimeout);
    APPEND_CONFIG_INTEGER(s,@"wait-ack-seconds",_waitAckSeconds);
    APPEND_CONFIG_STRING(s,@"wait-ack-expire",_waitAckExpire);
    APPEND_CONFIG_INTEGER(s,@"default-validity-period",_defaultValidityPeriod);
    APPEND_CONFIG_INTEGER(s,@"esm-class",_esmClass);
    APPEND_CONFIG_BOOLEAN(s,@"supoprt-long-sms",_supportLongSMS);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    
    APPEND_DICT_STRING(dict,@"host",_host);
    APPEND_DICT_INTEGER(dict,@"port",_port);
    APPEND_DICT_BOOLEAN(dict,@"use-ssl",_useSSL);
    APPEND_DICT_STRING(dict,@"ssl-client-cert-key-file",_sslClientCertkeyFile);
    APPEND_DICT_BOOLEAN(dict,@"transceiver-mode",_transceiverMode);
    APPEND_DICT_STRING(dict,@"smsc-username",_smscUsername);
    APPEND_DICT_STRING(dict,@"smsc-password",_smscPassword);
    APPEND_DICT_STRING(dict,@"system-type",_systemType);
    APPEND_DICT_STRING(dict,@"service-type",_serviceType);
    APPEND_DICT_STRING(dict,@"interface-version",_interfaceVersion);
    APPEND_DICT_STRING(dict,@"address-range",_addressRange);
    APPEND_DICT_STRING(dict,@"my-number",_myNumber);
    APPEND_DICT_INTEGER(dict,@"enquire-link-interval",_enquireLinkIntervall);
    APPEND_DICT_INTEGER(dict,@"max-pending-submits",_maxPendingSubmits);
    APPEND_DICT_INTEGER(dict,@"reconnect-delay",_reconnectDelay);
    APPEND_DICT_INTEGER(dict,@"source-addr-ton",_sourceAddrTon);
    APPEND_DICT_INTEGER(dict,@"source-addr-npi",_sourceAddrNpi);
    APPEND_DICT_INTEGER(dict,@"destination-addr-ton",_destinationAddrTon);
    APPEND_DICT_INTEGER(dict,@"destination-addr-npi",_destinationAddrNpi);
    APPEND_DICT_INTEGER(dict,@"bind-addr-ton",_bindAddrTon);
    APPEND_DICT_INTEGER(dict,@"bind-addr-npi",_bindAddrNpi);
    APPEND_DICT_INTEGER(dict,@"message-id-type",_messageIdType);
    APPEND_DICT_STRING(dict,@"alt-charset",_altCharset);
    APPEND_DICT_STRING(dict,@"alt-addr-charset",_altAddrCharset);
    APPEND_DICT_BOOLEAN(dict,@"retry",_retry);
    APPEND_DICT_INTEGER(dict,@"connection-timeout",_connectionTimeout);
    APPEND_DICT_INTEGER(dict,@"wait-ack-seconds",_waitAckSeconds);
    APPEND_DICT_STRING(dict,@"wait-ack-expire",_waitAckExpire);
    APPEND_DICT_INTEGER(dict,@"default-validity-period",_defaultValidityPeriod);
    APPEND_DICT_INTEGER(dict,@"esm-class",_esmClass);
    APPEND_DICT_BOOLEAN(dict,@"supoprt-long-sms",_supportLongSMS);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"host",_host);
    SET_DICT_INTEGER(dict,@"port",_port);
    SET_DICT_BOOLEAN(dict,@"use-ssl",_useSSL);
    SET_DICT_STRING(dict,@"ssl-client-cert-key-file",_sslClientCertkeyFile);
    SET_DICT_BOOLEAN(dict,@"transceiver-mode",_transceiverMode);
    SET_DICT_STRING(dict,@"smsc-username",_smscUsername);
    SET_DICT_STRING(dict,@"smsc-password",_smscPassword);
    SET_DICT_STRING(dict,@"system-type",_systemType);
    SET_DICT_STRING(dict,@"service-type",_serviceType);
    SET_DICT_STRING(dict,@"interface-version",_interfaceVersion);
    SET_DICT_STRING(dict,@"address-range",_addressRange);
    SET_DICT_STRING(dict,@"my-number",_myNumber);
    SET_DICT_INTEGER(dict,@"enquire-link-interval",_enquireLinkIntervall);
    SET_DICT_INTEGER(dict,@"max-pending-submits",_maxPendingSubmits);
    SET_DICT_INTEGER(dict,@"reconnect-delay",_reconnectDelay);
    SET_DICT_INTEGER(dict,@"source-addr-ton",_sourceAddrTon);
    SET_DICT_INTEGER(dict,@"source-addr-npi",_sourceAddrNpi);
    SET_DICT_INTEGER(dict,@"destination-addr-ton",_destinationAddrTon);
    SET_DICT_INTEGER(dict,@"destination-addr-npi",_destinationAddrNpi);
    SET_DICT_INTEGER(dict,@"bind-addr-ton",_bindAddrTon);
    SET_DICT_INTEGER(dict,@"bind-addr-npi",_bindAddrNpi);
    SET_DICT_INTEGER(dict,@"message-id-type",_messageIdType);
    SET_DICT_STRING(dict,@"alt-charset",_altCharset);
    SET_DICT_STRING(dict,@"alt-addr-charset",_altAddrCharset);
    SET_DICT_BOOLEAN(dict,@"retry",_retry);
    SET_DICT_INTEGER(dict,@"connection-timeout",_connectionTimeout);
    SET_DICT_INTEGER(dict,@"wait-ack-seconds",_waitAckSeconds);
    SET_DICT_STRING(dict,@"wait-ack-expire",_waitAckExpire);
    SET_DICT_INTEGER(dict,@"default-validity-period",_defaultValidityPeriod);
    SET_DICT_INTEGER(dict,@"esm-class",_esmClass);
    SET_DICT_BOOLEAN(dict,@"supoprt-long-sms",_supportLongSMS);
}

- (UMSS7ConfigSMPPConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMPPConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
