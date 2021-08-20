//
//  UMSS7ConfigSMSDeliveryProvider.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.08.21.
//  Copyright © 2021 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSDeliveryProvider.h"
#import "UMSS7ConfigMacros.h"

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


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];

    APPEND_CONFIG_STRING(s,@"protocol",_protocolType);
    APPEND_CONFIG_STRING(s,@"host",_host);
    APPEND_CONFIG_INTEGER(s,@"port",_port);
    APPEND_CONFIG_INTEGER(s,"concurrent-connections",_concurrentConnections);
    APPEND_CONFIG_STRING(s,@"alternate-host",_alternateHost);
    APPEND_CONFIG_INTEGER(s,"alternate-port",_alternatePort);
    APPEND_CONFIG_STRING(s,@"device",_device);
    APPEND_CONFIG_STRING(s,@"phone",_phone);
    APPEND_CONFIG_STRING(s,@"smsc-username",_smsc_username);
    APPEND_CONFIG_STRING(s,@"smsc-password",_smsc_password);
    APPEND_CONFIG_INTEGER(s,@"our-port",_ourPort);
    APPEND_CONFIG_INTEGER(s,@"our-receive-port",_ourReceiverPort);
    APPEND_CONFIG_INTEGER(s,@"receive-port",_ourReceiverPort);
    APPEND_CONFIG_STRING(s,@"connect-allow-ip",_connectAllowIp);
    APPEND_CONFIG_DOUBLE(s,@"idle-timeout",_idleTimeout);
    APPEND_CONFIG_DOUBLE(s,@"keepalive",_keepalive);
    APPEND_CONFIG_DOUBLE(s,@"wait-ack",_wait_ack);
    APPEND_CONFIG_DOUBLE(s,@"wait-ack-expire",_wait_ack_expire);
    APPEND_CONFIG_INTEGER(s,@"flow-control",_flowControl);
    APPEND_CONFIG_INTEGER(s,"window",_window);
    APPEND_CONFIG_STRING(s,@"my-number",_myNumber);
    APPEND_CONFIG_STRING(s,@"alt-charset",_altCharset);
    APPEND_CONFIG_STRING(s,@"alt-addr-charset",_altAddrCharset);
    APPEND_CONFIG_STRING(s,@"notification-pid",_notificationPid);
    APPEND_CONFIG_STRING(s,@"notification-addr",_notificationAddr);
    APPEND_CONFIG_DOUBLE(s,@"reconnect-delay",_reconnectDelay);
    APPEND_CONFIG_BOOLEAN(s,@"transceiver-mode",transceiverMode);
    APPEND_CONFIG_BOOLEAN(s,@"use-ssl",_useSSL);
    APPEND_CONFIG_STRING(s,@"ssl-client-cert-key-file",_sslClientCertKeyFile);
    APPEND_CONFIG_STRING(s,@"system-type",_systemType);
    APPEND_CONFIG_STRING(s,@"service-type",_serviceType);
    APPEND_CONFIG_STRING(s,@"interface-version",_interfaceVersion);
    APPEND_CONFIG_STRING(s,@"address-range",_addressRange);
    APPEND_CONFIG_STRING(s,@"enquire-link-interval",_enquireLinkInterval);
    APPEND_CONFIG_STRING(s,@"max-pending-submits",_max_pending_submits);
    APPEND_CONFIG_INTEGER(s,@"source-addr-ton",_sourceTon);
    APPEND_CONFIG_INTEGER(s,@"source-addr-npi",_sourceNpi);
    APPEND_CONFIG_STRING(s,@"source-address",_sourceAddress);
    APPEND_CONFIG_INTEGER(s,@"dest-addr-ton",_destTon);
    APPEND_CONFIG_INTEGER(s,@"dest-addr-npi",_destNpi);
    APPEND_CONFIG_STRING(s,@"dest-address",_destAddress);
    APPEND_CONFIG_INTEGER(s,@"bind-ton",_bindTon);
    APPEND_CONFIG_INTEGER(s,@"bind-npi",_bindNpi);
    APPEND_CONFIG_STRING(s,@"message-type",_msgIdType);
    APPEND_CONFIG_INTEGER(s,@"retry",_retry);
    APPEND_CONFIG_DOUBLE(s,@"connection-timeout",_connectionTimeout);
    APPEND_CONFIG_INTEGER(s,@"validity-period",_validityPeriod);
    APPEND_CONFIG_INTEGER(s,@"esm-class",_esmClass);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"protocol",_protocolType);
    APPEND_DICT_STRING(dict,@"host",_host);
    APPEND_DICT_INTEGER(dict,@"port",_port);
    APPEND_DICT_INTEGER(dict,"concurrent-connections",_concurrentConnections);
    APPEND_DICT_STRING(dict,@"alternate-host",_alternateHost);
    APPEND_DICT_INTEGER(dict,"alternate-port",_alternatePort);
    APPEND_DICT_STRING(dict,@"device",_device);
    APPEND_DICT_STRING(dict,@"phone",_phone);
    APPEND_DICT_STRING(dict,@"smsc-username",_smsc_username);
    APPEND_DICT_STRING(dict,@"smsc-password",_smsc_password);
    APPEND_DICT_INTEGER(dict,@"our-port",_ourPort);
    APPEND_DICT_INTEGER(dict,@"our-receive-port",_ourReceiverPort);
    APPEND_DICT_INTEGER(dict,@"receive-port",_ourReceiverPort);
    APPEND_DICT_STRING(dict,@"connect-allow-ip",_connectAllowIp);
    APPEND_DICT_DOUBLE(dict,@"idle-timeout",_idleTimeout);
    APPEND_DICT_DOUBLE(dict,@"keepalive",_keepalive);
    APPEND_DICT_DOUBLE(dict,@"wait-ack",_wait_ack);
    APPEND_DICT_DOUBLE(dict,@"wait-ack-expire",_wait_ack_expire);
    APPEND_DICT_INTEGER(dict,@"flow-control",_flowControl);
    APPEND_DICT_INTEGER(dict,"window",_window);
    APPEND_DICT_STRING(dict,@"my-number",_myNumber);
    APPEND_DICT_STRING(dict,@"alt-charset",_altCharset);
    APPEND_DICT_STRING(dict,@"alt-addr-charset",_altAddrCharset);
    APPEND_DICT_STRING(dict,@"notification-pid",_notificationPid);
    APPEND_DICT_STRING(dict,@"notification-addr",_notificationAddr);
    APPEND_DICT_DOUBLE(dict,@"reconnect-delay",_reconnectDelay);
    APPEND_DICT_BOOLEAN(dict,@"transceiver-mode",transceiverMode);
    APPEND_DICT_BOOLEAN(dict,@"use-ssl",_useSSL);
    APPEND_DICT_STRING(dict,@"ssl-client-cert-key-file",_sslClientCertKeyFile);
    APPEND_DICT_STRING(dict,@"system-type",_systemType);
    APPEND_DICT_STRING(dict,@"service-type",_serviceType);
    APPEND_DICT_STRING(dict,@"interface-version",_interfaceVersion);
    APPEND_DICT_STRING(dict,@"address-range",_addressRange);
    APPEND_DICT_STRING(dict,@"enquire-link-interval",_enquireLinkInterval);
    APPEND_DICT_STRING(dict,@"max-pending-submits",_max_pending_submits);
    APPEND_DICT_INTEGER(dict,@"source-addr-ton",_sourceTon);
    APPEND_DICT_INTEGER(dict,@"source-addr-npi",_sourceNpi);
    APPEND_DICT_STRING(dict,@"source-address",_sourceAddress);
    APPEND_DICT_INTEGER(dict,@"dest-addr-ton",_destTon);
    APPEND_DICT_INTEGER(dict,@"dest-addr-npi",_destNpi);
    APPEND_DICT_STRING(dict,@"dest-address",_destAddress);
    APPEND_DICT_INTEGER(dict,@"bind-ton",_bindTon);
    APPEND_DICT_INTEGER(dict,@"bind-npi",_bindNpi);
    APPEND_DICT_STRING(dict,@"message-type",_msgIdType);
    APPEND_DICT_INTEGER(dict,@"retry",_retry);
    APPEND_DICT_DOUBLE(dict,@"connection-timeout",_connectionTimeout);
    APPEND_DICT_INTEGER(dict,@"validity-period",_validityPeriod);
    APPEND_DICT_INTEGER(dict,@"esm-class",_esmClass);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"protocol",_protocolType);
    SET_DICT_STRING(dict,@"host",_host);
    SET_DICT_INTEGER(dict,@"port",_port);
    SET_DICT_INTEGER(dict,"concurrent-connections",_concurrentConnections);
    SET_DICT_STRING(dict,@"alternate-host",_alternateHost);
    SET_DICT_INTEGER(dict,"alternate-port",_alternatePort);
    SET_DICT_STRING(dict,@"device",_device);
    SET_DICT_STRING(dict,@"phone",_phone);
    SET_DICT_STRING(dict,@"smsc-username",_smsc_username);
    SET_DICT_STRING(dict,@"smsc-password",_smsc_password);
    SET_DICT_INTEGER(dict,@"our-port",_ourPort);
    SET_DICT_INTEGER(dict,@"our-receive-port",_ourReceiverPort);
    SET_DICT_INTEGER(dict,@"receive-port",_ourReceiverPort);
    SET_DICT_STRING(dict,@"connect-allow-ip",_connectAllowIp);
    SET_DICT_DOUBLE(dict,@"idle-timeout",_idleTimeout);
    SET_DICT_DOUBLE(dict,@"keepalive",_keepalive);
    SET_DICT_DOUBLE(dict,@"wait-ack",_wait_ack);
    SET_DICT_DOUBLE(dict,@"wait-ack-expire",_wait_ack_expire);
    SET_DICT_INTEGER(dict,@"flow-control",_flowControl);
    SET_DICT_INTEGER(dict,"window",_window);
    SET_DICT_STRING(dict,@"my-number",_myNumber);
    SET_DICT_STRING(dict,@"alt-charset",_altCharset);
    SET_DICT_STRING(dict,@"alt-addr-charset",_altAddrCharset);
    SET_DICT_STRING(dict,@"notification-pid",_notificationPid);
    SET_DICT_STRING(dict,@"notification-addr",_notificationAddr);
    SET_DICT_DOUBLE(dict,@"reconnect-delay",_reconnectDelay);
    SET_DICT_BOOLEAN(dict,@"transceiver-mode",transceiverMode);
    SET_DICT_BOOLEAN(dict,@"use-ssl",_useSSL);
    SET_DICT_STRING(dict,@"ssl-client-cert-key-file",_sslClientCertKeyFile);
    SET_DICT_STRING(dict,@"system-type",_systemType);
    SET_DICT_STRING(dict,@"service-type",_serviceType);
    SET_DICT_STRING(dict,@"interface-version",_interfaceVersion);
    SET_DICT_STRING(dict,@"address-range",_addressRange);
    SET_DICT_STRING(dict,@"enquire-link-interval",_enquireLinkInterval);
    SET_DICT_STRING(dict,@"max-pending-submits",_max_pending_submits);
    SET_DICT_INTEGER(dict,@"source-addr-ton",_sourceTon);
    SET_DICT_INTEGER(dict,@"source-addr-npi",_sourceNpi);
    SET_DICT_STRING(dict,@"source-address",_sourceAddress);
    SET_DICT_INTEGER(dict,@"dest-addr-ton",_destTon);
    SET_DICT_INTEGER(dict,@"dest-addr-npi",_destNpi);
    SET_DICT_STRING(dict,@"dest-address",_destAddress);
    SET_DICT_INTEGER(dict,@"bind-ton",_bindTon);
    SET_DICT_INTEGER(dict,@"bind-npi",_bindNpi);
    SET_DICT_STRING(dict,@"message-type",_msgIdType);
    SET_DICT_INTEGER(dict,@"retry",_retry);
    SET_DICT_DOUBLE(dict,@"connection-timeout",_connectionTimeout);
    SET_DICT_INTEGER(dict,@"validity-period",_validityPeriod);
    SET_DICT_INTEGER(dict,@"esm-class",_esmClass);
}


- (UMSS7ConfigSMSDeliveryProvider *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSDeliveryProvider allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



