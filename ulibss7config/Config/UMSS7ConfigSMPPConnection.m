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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"host",_host);
    APPEND_CONFIG_INTEGER(o,@"port",_port);
    APPEND_CONFIG_BOOLEAN(o,@"use-ssl",_useSSL);
    APPEND_CONFIG_STRING(o,@"ssl-client-cert-key-file",_sslClientCertkeyFile);
    APPEND_CONFIG_BOOLEAN(o,@"transceiver-mode",_transceiverMode);
    APPEND_CONFIG_STRING(o,@"smsc-username",_smscUsername);
    APPEND_CONFIG_STRING(o,@"smsc-password",_smscPassword);
    APPEND_CONFIG_STRING(o,@"system-type",_systemType);
    APPEND_CONFIG_STRING(o,@"service-type",_serviceType);
    APPEND_CONFIG_STRING(o,@"interface-version",_interfaceVersion);
    APPEND_CONFIG_STRING(o,@"address-range",_addressRange);
    APPEND_CONFIG_STRING(o,@"my-number",_myNumber);
    APPEND_CONFIG_INTEGER(o,@"enquire-link-interval",_enquireLinkIntervall);
    APPEND_CONFIG_INTEGER(o,@"max-pending-submits",_maxPendingSubmits);
    APPEND_CONFIG_INTEGER(o,@"reconnect-delay",_reconnectDelay);
    APPEND_CONFIG_INTEGER(o,@"source-addr-ton",_sourceAddrTon);
    APPEND_CONFIG_INTEGER(o,@"source-addr-npi",_sourceAddrNpi);
    APPEND_CONFIG_INTEGER(o,@"destination-addr-ton",_destinationAddrTon);
    APPEND_CONFIG_INTEGER(o,@"destination-addr-npi",_destinationAddrNpi);
    APPEND_CONFIG_INTEGER(o,@"bind-addr-ton",_bindAddrTon);
    APPEND_CONFIG_INTEGER(o,@"bind-addr-npi",_bindAddrNpi);
    APPEND_CONFIG_INTEGER(o,@"message-id-type",_messageIdType);
    APPEND_CONFIG_STRING(o,@"alt-charset",_altCharset);
    APPEND_CONFIG_STRING(o,@"alt-addr-charset",_altAddrCharset);
    APPEND_CONFIG_BOOLEAN(o,@"retry",_retry);
    APPEND_CONFIG_INTEGER(o,@"connection-timeout",_connectionTimeout);
    APPEND_CONFIG_INTEGER(o,@"wait-ack-seconds",_waitAckSeconds);
    APPEND_CONFIG_STRING(o,@"wait-ack-expire",_waitAckExpire);
    APPEND_CONFIG_INTEGER(o,@"default-validity-period",_defaultValidityPeriod);
    APPEND_CONFIG_INTEGER(o,@"esm-class",_esmClass);
    APPEND_CONFIG_BOOLEAN(o,@"supoprt-long-sms",_supportLongSMS);
    APPEND_CONFIG_STRING(o,@"zmq-socket",_zmqSocket);
    APPEND_CONFIG_STRING(o,@"router",_router);
    APPEND_CONFIG_STRING(o,@"storage-server",_storageServer);
    APPEND_CONFIG_STRING(o,@"cdr-server",_cdrServer);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
    APPEND_DICT_STRING(o,@"host",_host);
    APPEND_DICT_INTEGER(o,@"port",_port);
    APPEND_DICT_BOOLEAN(o,@"use-ssl",_useSSL);
    APPEND_DICT_STRING(o,@"ssl-client-cert-key-file",_sslClientCertkeyFile);
    APPEND_DICT_BOOLEAN(o,@"transceiver-mode",_transceiverMode);
    APPEND_DICT_STRING(o,@"smsc-username",_smscUsername);
    APPEND_DICT_STRING(o,@"smsc-password",_smscPassword);
    APPEND_DICT_STRING(o,@"system-type",_systemType);
    APPEND_DICT_STRING(o,@"service-type",_serviceType);
    APPEND_DICT_STRING(o,@"interface-version",_interfaceVersion);
    APPEND_DICT_STRING(o,@"address-range",_addressRange);
    APPEND_DICT_STRING(o,@"my-number",_myNumber);
    APPEND_DICT_INTEGER(o,@"enquire-link-interval",_enquireLinkIntervall);
    APPEND_DICT_INTEGER(o,@"max-pending-submits",_maxPendingSubmits);
    APPEND_DICT_INTEGER(o,@"reconnect-delay",_reconnectDelay);
    APPEND_DICT_INTEGER(o,@"source-addr-ton",_sourceAddrTon);
    APPEND_DICT_INTEGER(o,@"source-addr-npi",_sourceAddrNpi);
    APPEND_DICT_INTEGER(o,@"destination-addr-ton",_destinationAddrTon);
    APPEND_DICT_INTEGER(o,@"destination-addr-npi",_destinationAddrNpi);
    APPEND_DICT_INTEGER(o,@"bind-addr-ton",_bindAddrTon);
    APPEND_DICT_INTEGER(o,@"bind-addr-npi",_bindAddrNpi);
    APPEND_DICT_INTEGER(o,@"message-id-type",_messageIdType);
    APPEND_DICT_STRING(o,@"alt-charset",_altCharset);
    APPEND_DICT_STRING(o,@"alt-addr-charset",_altAddrCharset);
    APPEND_DICT_BOOLEAN(o,@"retry",_retry);
    APPEND_DICT_INTEGER(o,@"connection-timeout",_connectionTimeout);
    APPEND_DICT_INTEGER(o,@"wait-ack-seconds",_waitAckSeconds);
    APPEND_DICT_STRING(o,@"wait-ack-expire",_waitAckExpire);
    APPEND_DICT_INTEGER(o,@"default-validity-period",_defaultValidityPeriod);
    APPEND_DICT_INTEGER(o,@"esm-class",_esmClass);
    APPEND_DICT_BOOLEAN(o,@"supoprt-long-sms",_supportLongSMS);
    APPEND_DICT_STRING(o,@"zmq-socket",_zmqSocket);
    APPEND_DICT_STRING(o,@"router",_router);
    APPEND_DICT_STRING(o,@"storage-server",_storageServer);
    APPEND_DICT_STRING(o,@"cdr-server",_cdrServer);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_STRING(o,@"host",_host);
    SET_DICT_INTEGER(o,@"port",_port);
    SET_DICT_BOOLEAN(o,@"use-ssl",_useSSL);
    SET_DICT_STRING(o,@"ssl-client-cert-key-file",_sslClientCertkeyFile);
    SET_DICT_BOOLEAN(o,@"transceiver-mode",_transceiverMode);
    SET_DICT_STRING(o,@"smsc-username",_smscUsername);
    SET_DICT_STRING(o,@"smsc-password",_smscPassword);
    SET_DICT_STRING(o,@"system-type",_systemType);
    SET_DICT_STRING(o,@"service-type",_serviceType);
    SET_DICT_STRING(o,@"interface-version",_interfaceVersion);
    SET_DICT_STRING(o,@"address-range",_addressRange);
    SET_DICT_STRING(o,@"my-number",_myNumber);
    SET_DICT_INTEGER(o,@"enquire-link-interval",_enquireLinkIntervall);
    SET_DICT_INTEGER(o,@"max-pending-submits",_maxPendingSubmits);
    SET_DICT_INTEGER(o,@"reconnect-delay",_reconnectDelay);
    SET_DICT_INTEGER(o,@"source-addr-ton",_sourceAddrTon);
    SET_DICT_INTEGER(o,@"source-addr-npi",_sourceAddrNpi);
    SET_DICT_INTEGER(o,@"destination-addr-ton",_destinationAddrTon);
    SET_DICT_INTEGER(o,@"destination-addr-npi",_destinationAddrNpi);
    SET_DICT_INTEGER(o,@"bind-addr-ton",_bindAddrTon);
    SET_DICT_INTEGER(o,@"bind-addr-npi",_bindAddrNpi);
    SET_DICT_INTEGER(o,@"message-id-type",_messageIdType);
    SET_DICT_STRING(o,@"alt-charset",_altCharset);
    SET_DICT_STRING(o,@"alt-addr-charset",_altAddrCharset);
    SET_DICT_BOOLEAN(o,@"retry",_retry);
    SET_DICT_INTEGER(o,@"connection-timeout",_connectionTimeout);
    SET_DICT_INTEGER(o,@"wait-ack-seconds",_waitAckSeconds);
    SET_DICT_STRING(o,@"wait-ack-expire",_waitAckExpire);
    SET_DICT_INTEGER(o,@"default-validity-period",_defaultValidityPeriod);
    SET_DICT_INTEGER(o,@"esm-class",_esmClass);
    SET_DICT_BOOLEAN(o,@"supoprt-long-sms",_supportLongSMS);
    SET_DICT_STRING(o,@"zmq-socket",_zmqSocket);
    SET_DICT_STRING(o,@"router",_router);
    SET_DICT_STRING(o,@"storage-server",_storageServer);
    SET_DICT_STRING(o,@"cdr-server",_cdrServer);
}

- (UMSS7ConfigSMPPConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMPPConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
