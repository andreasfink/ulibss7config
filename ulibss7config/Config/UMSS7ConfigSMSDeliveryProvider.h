//
//  UMSS7ConfigSMSDeliveryProvider.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.08.21.
//  Copyright © 2021 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigSMSDeliveryProvider : UMSS7ConfigObject
{
    NSString    *_protocolType;
    NSString    *_host;
    NSNumber    *_port;
    NSNumber    *_concurrentConnections;
    NSString    *_alternateHost;
    NSNumber    *_alternatePort;
    NSString    *_device;
    NSString    *_phone;
    NSString    *_smsc_username;
    NSString    *_smsc_password;
    NSNumber    *_ourPort;
    NSNumber    *_ourReceiverPort;
    NSNumber    *_receivePort;
    NSString    *_connectAllowIp;
    NSNumber    *_idleTimeout;
    NSNumber    *_keepalive;
    NSNumber    *_wait_ack;
    NSNumber    *_wait_ack_expire;
    NSNumber    *_flowControl;
    NSNumber    *_window;
    NSString    *_myNumber;
    NSString    *_altCharset;
    NSString    *_altAddrCharset;
    NSString    *_notificationPid;
    NSString    *_notificationAddr;
    NSNumber    *_reconnectDelay;
    NSNumber    *_transceiverMode;
    NSNumber    *_useSSL;
    NSString    *_sslClientCertKeyFile;
    NSString    *_systemType;
    NSString    *_serviceType;
    NSString    *_interfaceVersion;
    NSString    *_addressRange;
    NSString    *_enquireLinkInterval;
    NSString    *_max_pending_submits;
    NSNumber    *_sourceTon;
    NSNumber    *_sourceNpi;
    NSString    *_sourceAddress;
    NSNumber    *_destTon;
    NSNumber    *_destNpi;
    NSString    *_destAddress;
    NSNumber    *_bindTon;
    NSNumber    *_bindNpi;
    NSString    *_msgIdType;
    NSNumber    *_retry;
    NSNumber    *_connectionTimeout;
    NSNumber    *_validityPeriod;
    NSNumber    *_esmClass;
}


@property(readwrite,strong,atomic)  NSString    *protocolType;
@property(readwrite,strong,atomic)  NSString    *host;
@property(readwrite,strong,atomic)  NSNumber    *port;
@property(readwrite,strong,atomic)  NSString    *alternateHost;
@property(readwrite,strong,atomic)  NSNumber    *alternatePort;
@property(readwrite,strong,atomic)  NSString    *device;
@property(readwrite,strong,atomic)  NSString    *phone;
@property(readwrite,strong,atomic)  NSString    *smsc_username;
@property(readwrite,strong,atomic)  NSString    *smsc_password;
@property(readwrite,strong,atomic)  NSNumber    *ourPort;
@property(readwrite,strong,atomic)  NSNumber    *ourReceiverPort;
@property(readwrite,strong,atomic)  NSNumber    *receivePort;
@property(readwrite,strong,atomic)  NSString    *connectAllowIp;
@property(readwrite,strong,atomic)  NSNumber    *idleTimeout;
@property(readwrite,strong,atomic)  NSNumber    *keepalive;
@property(readwrite,strong,atomic)  NSNumber    *wait_ack;
@property(readwrite,strong,atomic)  NSNumber    *wait_ack_expire;
@property(readwrite,strong,atomic)  NSNumber    *flowControl;
@property(readwrite,strong,atomic)  NSNumber    *window;
@property(readwrite,strong,atomic)  NSString    *myNumber;
@property(readwrite,strong,atomic)  NSString    *altCharset;
@property(readwrite,strong,atomic)  NSString    *altAddrCharset;
@property(readwrite,strong,atomic)  NSString    *notificationPid;
@property(readwrite,strong,atomic)  NSString    *notificationAddr;
@property(readwrite,strong,atomic)  NSString    *reconnectDelay;
@property(readwrite,strong,atomic)  NSNumber    *transceiverMode;
@property(readwrite,strong,atomic)  NSNumber    *useSSL;
@property(readwrite,strong,atomic)  NSString    *sslClientCertKeyFile;
@property(readwrite,strong,atomic)  NSString    *systemType;
@property(readwrite,strong,atomic)  NSString    *serviceType;
@property(readwrite,strong,atomic)  NSString    *interfaceVersion;
@property(readwrite,strong,atomic)  NSString    *addressRange;
@property(readwrite,strong,atomic)  NSString    *enquireLinkInterval;
@property(readwrite,strong,atomic)  NSString    *max_pending_submits;
@property(readwrite,strong,atomic)  NSNumber    *sourceTon;
@property(readwrite,strong,atomic)  NSNumber    *sourceNpi;
@property(readwrite,strong,atomic)  NSString    *sourceAddress;
@property(readwrite,strong,atomic)  NSNumber    *destTon;
@property(readwrite,strong,atomic)  NSNumber    *destNpi;
@property(readwrite,strong,atomic)  NSString    *destAddress;
@property(readwrite,strong,atomic)  NSNumber    *bindTon;
@property(readwrite,strong,atomic)  NSNumber    *bindNpi;
@property(readwrite,strong,atomic)  NSString    *msgIdType;
@property(readwrite,strong,atomic)  NSNumber    *retry;
@property(readwrite,strong,atomic)  NSNumber    *connectionTimeout;
@property(readwrite,strong,atomic)  NSNumber    *validityPeriod;
@property(readwrite,strong,atomic)  NSNumber    *esmClass;

@end
