//
//  UMSS7ConfigSMSDeliveryProvider.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.08.21.
//  Copyright © 2021 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSDeliveryProvider.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMSDeliveryProvider


+ (NSString *)type
{
    return @"sms-delivery-provider";
}

- (NSString *)type
{
    return [UMSS7ConfigSMSDeliveryProvider type];
}


- (UMSS7ConfigSMSDeliveryProvider *)initWithConfig:(NSDictionary *)dict
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

    APPEND_CONFIG_STRING(o,@"protocol",_protocolType);
    APPEND_CONFIG_STRING(o,@"host",_host);
    APPEND_CONFIG_INTEGER(o,@"port",_port);
    APPEND_CONFIG_INTEGER(o,@"concurrent-connections",_concurrentConnections);
    APPEND_CONFIG_STRING(o,@"alternate-host",_alternateHost);
    APPEND_CONFIG_INTEGER(o,@"alternate-port",_alternatePort);
    APPEND_CONFIG_STRING(o,@"device",_device);
    APPEND_CONFIG_STRING(o,@"phone",_phone);
    APPEND_CONFIG_STRING(o,@"smsc-username",_smsc_username);
    APPEND_CONFIG_STRING(o,@"smsc-password",_smsc_password);
    APPEND_CONFIG_INTEGER(o,@"our-port",_ourPort);
    APPEND_CONFIG_INTEGER(o,@"our-receive-port",_ourReceiverPort);
    APPEND_CONFIG_INTEGER(o,@"receive-port",_ourReceiverPort);
    APPEND_CONFIG_STRING(o,@"connect-allow-ip",_connectAllowIp);
    APPEND_CONFIG_DOUBLE(o,@"idle-timeout",_idleTimeout);
    APPEND_CONFIG_DOUBLE(o,@"keepalive",_keepalive);
    APPEND_CONFIG_DOUBLE(o,@"wait-ack",_wait_ack);
    APPEND_CONFIG_DOUBLE(o,@"wait-ack-expire",_wait_ack_expire);
    APPEND_CONFIG_INTEGER(o,@"flow-control",_flowControl);
    APPEND_CONFIG_INTEGER(o,@"window",_window);
    APPEND_CONFIG_STRING(o,@"my-number",_myNumber);
    APPEND_CONFIG_STRING(o,@"alt-charset",_altCharset);
    APPEND_CONFIG_STRING(o,@"alt-addr-charset",_altAddrCharset);
    APPEND_CONFIG_STRING(o,@"notification-pid",_notificationPid);
    APPEND_CONFIG_STRING(o,@"notification-addr",_notificationAddr);
    APPEND_CONFIG_DOUBLE(o,@"reconnect-delay",_reconnectDelay);
    APPEND_CONFIG_BOOLEAN(o,@"transceiver-mode",_transceiverMode);
    APPEND_CONFIG_BOOLEAN(o,@"use-ssl",_useSSL);
    APPEND_CONFIG_STRING(o,@"ssl-client-cert-key-file",_sslClientCertKeyFile);
    APPEND_CONFIG_STRING(o,@"system-type",_systemType);
    APPEND_CONFIG_STRING(o,@"service-type",_serviceType);
    APPEND_CONFIG_STRING(o,@"interface-version",_interfaceVersion);
    APPEND_CONFIG_STRING(o,@"address-range",_addressRange);
    APPEND_CONFIG_STRING(o,@"enquire-link-interval",_enquireLinkInterval);
    APPEND_CONFIG_STRING(o,@"max-pending-submits",_max_pending_submits);
    APPEND_CONFIG_INTEGER(o,@"source-addr-ton",_sourceTon);
    APPEND_CONFIG_INTEGER(o,@"source-addr-npi",_sourceNpi);
    APPEND_CONFIG_STRING(o,@"source-address",_sourceAddress);
    APPEND_CONFIG_INTEGER(o,@"dest-addr-ton",_destTon);
    APPEND_CONFIG_INTEGER(o,@"dest-addr-npi",_destNpi);
    APPEND_CONFIG_STRING(o,@"dest-address",_destAddress);
    APPEND_CONFIG_INTEGER(o,@"bind-ton",_bindTon);
    APPEND_CONFIG_INTEGER(o,@"bind-npi",_bindNpi);
    APPEND_CONFIG_STRING(o,@"message-type",_msgIdType);
    APPEND_CONFIG_INTEGER(o,@"retry",_retry);
    APPEND_CONFIG_DOUBLE(o,@"connection-timeout",_connectionTimeout);
    APPEND_CONFIG_INTEGER(o,@"validity-period",_validityPeriod);
    APPEND_CONFIG_INTEGER(o,@"esm-class",_esmClass);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"protocol",_protocolType);
    APPEND_DICT_STRING(o,@"host",_host);
    APPEND_DICT_INTEGER(o,@"port",_port);
    APPEND_DICT_INTEGER(o,@"concurrent-connections",_concurrentConnections);
    APPEND_DICT_STRING(o,@"alternate-host",_alternateHost);
    APPEND_DICT_INTEGER(o,@"alternate-port",_alternatePort);
    APPEND_DICT_STRING(o,@"device",_device);
    APPEND_DICT_STRING(o,@"phone",_phone);
    APPEND_DICT_STRING(o,@"smsc-username",_smsc_username);
    APPEND_DICT_STRING(o,@"smsc-password",_smsc_password);
    APPEND_DICT_INTEGER(o,@"our-port",_ourPort);
    APPEND_DICT_INTEGER(o,@"our-receive-port",_ourReceiverPort);
    APPEND_DICT_INTEGER(o,@"receive-port",_ourReceiverPort);
    APPEND_DICT_STRING(o,@"connect-allow-ip",_connectAllowIp);
    APPEND_DICT_DOUBLE(o,@"idle-timeout",_idleTimeout);
    APPEND_DICT_DOUBLE(o,@"keepalive",_keepalive);
    APPEND_DICT_DOUBLE(o,@"wait-ack",_wait_ack);
    APPEND_DICT_DOUBLE(o,@"wait-ack-expire",_wait_ack_expire);
    APPEND_DICT_INTEGER(o,@"flow-control",_flowControl);
    APPEND_DICT_INTEGER(o,@"window",_window);
    APPEND_DICT_STRING(o,@"my-number",_myNumber);
    APPEND_DICT_STRING(o,@"alt-charset",_altCharset);
    APPEND_DICT_STRING(o,@"alt-addr-charset",_altAddrCharset);
    APPEND_DICT_STRING(o,@"notification-pid",_notificationPid);
    APPEND_DICT_STRING(o,@"notification-addr",_notificationAddr);
    APPEND_DICT_DOUBLE(o,@"reconnect-delay",_reconnectDelay);
    APPEND_DICT_BOOLEAN(o,@"transceiver-mode",_transceiverMode);
    APPEND_DICT_BOOLEAN(o,@"use-ssl",_useSSL);
    APPEND_DICT_STRING(o,@"ssl-client-cert-key-file",_sslClientCertKeyFile);
    APPEND_DICT_STRING(o,@"system-type",_systemType);
    APPEND_DICT_STRING(o,@"service-type",_serviceType);
    APPEND_DICT_STRING(o,@"interface-version",_interfaceVersion);
    APPEND_DICT_STRING(o,@"address-range",_addressRange);
    APPEND_DICT_STRING(o,@"enquire-link-interval",_enquireLinkInterval);
    APPEND_DICT_STRING(o,@"max-pending-submits",_max_pending_submits);
    APPEND_DICT_INTEGER(o,@"source-addr-ton",_sourceTon);
    APPEND_DICT_INTEGER(o,@"source-addr-npi",_sourceNpi);
    APPEND_DICT_STRING(o,@"source-address",_sourceAddress);
    APPEND_DICT_INTEGER(o,@"dest-addr-ton",_destTon);
    APPEND_DICT_INTEGER(o,@"dest-addr-npi",_destNpi);
    APPEND_DICT_STRING(o,@"dest-address",_destAddress);
    APPEND_DICT_INTEGER(o,@"bind-ton",_bindTon);
    APPEND_DICT_INTEGER(o,@"bind-npi",_bindNpi);
    APPEND_DICT_STRING(o,@"message-type",_msgIdType);
    APPEND_DICT_INTEGER(o,@"retry",_retry);
    APPEND_DICT_DOUBLE(o,@"connection-timeout",_connectionTimeout);
    APPEND_DICT_INTEGER(o,@"validity-period",_validityPeriod);
    APPEND_DICT_INTEGER(o,@"esm-class",_esmClass);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"protocol",_protocolType);
    SET_DICT_STRING(o,@"host",_host);
    SET_DICT_INTEGER(o,@"port",_port);
    SET_DICT_INTEGER(o,@"concurrent-connections",_concurrentConnections);
    SET_DICT_STRING(o,@"alternate-host",_alternateHost);
    SET_DICT_INTEGER(o,@"alternate-port",_alternatePort);
    SET_DICT_STRING(o,@"device",_device);
    SET_DICT_STRING(o,@"phone",_phone);
    SET_DICT_STRING(o,@"smsc-username",_smsc_username);
    SET_DICT_STRING(o,@"smsc-password",_smsc_password);
    SET_DICT_INTEGER(o,@"our-port",_ourPort);
    SET_DICT_INTEGER(o,@"our-receive-port",_ourReceiverPort);
    SET_DICT_INTEGER(o,@"receive-port",_ourReceiverPort);
    SET_DICT_STRING(o,@"connect-allow-ip",_connectAllowIp);
    SET_DICT_DOUBLE(o,@"idle-timeout",_idleTimeout);
    SET_DICT_DOUBLE(o,@"keepalive",_keepalive);
    SET_DICT_DOUBLE(o,@"wait-ack",_wait_ack);
    SET_DICT_DOUBLE(o,@"wait-ack-expire",_wait_ack_expire);
    SET_DICT_INTEGER(o,@"flow-control",_flowControl);
    SET_DICT_INTEGER(o,@"window",_window);
    SET_DICT_STRING(o,@"my-number",_myNumber);
    SET_DICT_STRING(o,@"alt-charset",_altCharset);
    SET_DICT_STRING(o,@"alt-addr-charset",_altAddrCharset);
    SET_DICT_STRING(o,@"notification-pid",_notificationPid);
    SET_DICT_STRING(o,@"notification-addr",_notificationAddr);
    SET_DICT_DOUBLE(o,@"reconnect-delay",_reconnectDelay);
    SET_DICT_BOOLEAN(o,@"transceiver-mode",_transceiverMode);
    SET_DICT_BOOLEAN(o,@"use-ssl",_useSSL);
    SET_DICT_STRING(o,@"ssl-client-cert-key-file",_sslClientCertKeyFile);
    SET_DICT_STRING(o,@"system-type",_systemType);
    SET_DICT_STRING(o,@"service-type",_serviceType);
    SET_DICT_STRING(o,@"interface-version",_interfaceVersion);
    SET_DICT_STRING(o,@"address-range",_addressRange);
    SET_DICT_STRING(o,@"enquire-link-interval",_enquireLinkInterval);
    SET_DICT_STRING(o,@"max-pending-submits",_max_pending_submits);
    SET_DICT_INTEGER(o,@"source-addr-ton",_sourceTon);
    SET_DICT_INTEGER(o,@"source-addr-npi",_sourceNpi);
    SET_DICT_STRING(o,@"source-address",_sourceAddress);
    SET_DICT_INTEGER(o,@"dest-addr-ton",_destTon);
    SET_DICT_INTEGER(o,@"dest-addr-npi",_destNpi);
    SET_DICT_STRING(o,@"dest-address",_destAddress);
    SET_DICT_INTEGER(o,@"bind-ton",_bindTon);
    SET_DICT_INTEGER(o,@"bind-npi",_bindNpi);
    SET_DICT_STRING(o,@"message-type",_msgIdType);
    SET_DICT_INTEGER(o,@"retry",_retry);
    SET_DICT_DOUBLE(o,@"connection-timeout",_connectionTimeout);
    SET_DICT_INTEGER(o,@"validity-period",_validityPeriod);
    SET_DICT_INTEGER(o,@"esm-class",_esmClass);
}


- (UMSS7ConfigSMSDeliveryProvider *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSDeliveryProvider allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



