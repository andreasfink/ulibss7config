//
//  UMSS7ConfigSctp.h
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCTP : UMSS7ConfigObject
{
    NSArray<NSString *> *_localAddresses;
    NSArray<NSString *> *_remoteAddresses;
    NSNumber            *_localPort;
    NSNumber            *_remotePort;
    NSNumber            *_allowAnyRemotePortIncoming;
    NSNumber            *_passive;
    NSNumber            *_heartbeat; /* in seconds */
    NSNumber            *_mtu;
    NSNumber            *_maxInitTimeout;
    NSNumber            *_maxInitAttempts;
    NSNumber            *_tcpListener;
    NSNumber            *_tcpClient;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCTP *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)      NSArray<NSString *> *localAddresses;
@property(readwrite,strong,atomic)      NSArray<NSString *> *remoteAddresses;
@property(readwrite,strong,atomic)      NSNumber            *localPort;
@property(readwrite,strong,atomic)      NSNumber            *remotePort;
@property(readwrite,strong,atomic)      NSNumber            *allowAnyRemotePortIncoming;
@property(readwrite,strong,atomic)      NSNumber            *passive;
@property(readwrite,strong,atomic)      NSNumber            *heartbeat; /* in seconds */
@property(readwrite,strong,atomic)      NSNumber            *mtu;
@property(readwrite,strong,atomic)      NSNumber            *maxInitTimeout;
@property(readwrite,strong,atomic)      NSNumber            *maxInitAttempts;
@property(readwrite,strong,atomic)      NSNumber            *tcpListener;
@property(readwrite,strong,atomic)      NSNumber            *tcpClient;

@end

