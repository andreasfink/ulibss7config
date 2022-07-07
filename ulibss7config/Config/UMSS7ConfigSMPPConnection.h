//
//  UMSS7ConfigSMPPConnection.h
//  ulibss7config
//
//  Created by Andreas Fink on 07.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigSMPPConnection : UMSS7ConfigObject
{
    NSString *              _host;
    NSNumber *              _port;
    NSNumber *              _useSSL;
    NSString *              _sslClientCertkeyFile;
    NSNumber *              _transceiverMode;
    NSString *              _receiveHost;
    NSNumber *              _receivePort;
    NSString *              _smscUsername;
    NSString *              _smscPassword;
    NSString *              _systemType;
    NSString *              _serviceType;
    NSString *              _interfaceVersion;
    NSString *              _addressRange;
    NSString *              _myNumber;
    NSNumber *              _enquireLinkIntervall;
    NSNumber *              _maxPendingSubmits;
    NSNumber *              _reconnectDelay;
    NSNumber *              _sourceAddrTon;
    NSNumber *              _sourceAddrNpi;
    NSNumber *              _destinationAddrTon;
    NSNumber *              _destinationAddrNpi;
    NSNumber *              _bindAddrTon;
    NSNumber *              _bindAddrNpi;
    NSNumber *              _messageIdType;
    NSString *              _altCharset;
    NSString *              _altAddrCharset;
    NSNumber *              _retry;
    NSNumber *              _connectionTimeout;
    NSNumber *              _waitAckSeconds;
    NSString *              _waitAckExpire;
    NSNumber *              _defaultValidityPeriod;
    NSNumber *              _esmClass;
    NSNumber *              _supportLongSMS;
}

@property(readwrite,strong,atomic) NSString * host;
@property(readwrite,strong,atomic) NSNumber * port;
@property(readwrite,strong,atomic) NSNumber * useSSL;
@property(readwrite,strong,atomic) NSString * sslClientCertkeyFile;
@property(readwrite,strong,atomic) NSNumber * transceiverMode;
@property(readwrite,strong,atomic) NSNumber * receivePort;
@property(readwrite,strong,atomic) NSString * smscUsername;
@property(readwrite,strong,atomic) NSString * smscPassword;
@property(readwrite,strong,atomic) NSString * systemType;
@property(readwrite,strong,atomic) NSString * serviceType;
@property(readwrite,strong,atomic) NSString * interfaceVersion;
@property(readwrite,strong,atomic) NSString * addressRange;
@property(readwrite,strong,atomic) NSString * myNumber;
@property(readwrite,strong,atomic) NSNumber * enquireLinkIntervall;
@property(readwrite,strong,atomic) NSNumber * maxPendingSubmits;
@property(readwrite,strong,atomic) NSNumber * reconnectDelay;
@property(readwrite,strong,atomic) NSNumber * sourceAddrTon;
@property(readwrite,strong,atomic) NSNumber * sourceAddrNpi;
@property(readwrite,strong,atomic) NSNumber * destinationAddrTon;
@property(readwrite,strong,atomic) NSNumber * destinationAddrNpi;
@property(readwrite,strong,atomic) NSNumber * bindAddrTon;
@property(readwrite,strong,atomic) NSNumber * bindAddrNpi;
@property(readwrite,strong,atomic) NSNumber * messageIdType;
@property(readwrite,strong,atomic) NSString * altCharset;
@property(readwrite,strong,atomic) NSString * altAddrCharset;
@property(readwrite,strong,atomic) NSNumber * retry;
@property(readwrite,strong,atomic) NSNumber * connectionTimeout;
@property(readwrite,strong,atomic) NSNumber * waitAckSeconds;
@property(readwrite,strong,atomic) NSString * waitAckExpire;
@property(readwrite,strong,atomic) NSNumber * defaultValidityPeriod;
@property(readwrite,strong,atomic) NSNumber * esmClass;
@property(readwrite,strong,atomic) NSNumber * supportLongSMS;
@end

