//
//  UMSS7ConfigM3UAASP.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigM3UAASP : UMSS7ConfigObject

{
    NSString *_m3ua_as;
    NSString *_attachTo;
    NSNumber *_reopenTimer1;
    NSNumber *_reopenTimer2;
    NSNumber *_linktestTimer;
    NSNumber *_beatTimer;
    NSNumber *_beatMaxOutstanding;

    /* implicit sctp object */
    NSArray<NSString *> *_sctp_localAddresses;
    NSArray<NSString *> *_sctp_remoteAddresses;
    NSNumber            *_sctp_localPort;
    NSNumber            *_sctp_remotePort;
    NSNumber            *_sctp_allowAnyRemotePortIncoming;
    NSNumber            *_sctp_passive;
    NSNumber            *_sctp_heartbeat; /* in seconds */
    NSNumber            *_sctp_mtu;
    NSNumber            *_sctp_maxInitTimeout;
    NSNumber            *_sctp_maxInitAttempts;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigM3UAASP *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *m3ua_as;
@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer1;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer2;
@property(readwrite,strong,atomic)  NSNumber *linktestTimer;
@property(readwrite,strong,atomic)  NSNumber *beatTimer;
@property(readwrite,strong,atomic)  NSNumber *beatMaxOutstanding;

@property(readwrite,strong,atomic)  NSArray<NSString *> *sctp_localAddresses;
@property(readwrite,strong,atomic)  NSArray<NSString *> *sctp_remoteAddresses;
@property(readwrite,strong,atomic)  NSNumber            *sctp_localPort;
@property(readwrite,strong,atomic)  NSNumber            *sctp_remotePort;
@property(readwrite,strong,atomic)  NSNumber            *sctp_allowAnyRemotePortIncoming;
@property(readwrite,strong,atomic)  NSNumber            *sctp_passive;
@property(readwrite,strong,atomic)  NSNumber            *sctp_heartbeat; /* in seconds */
@property(readwrite,strong,atomic)  NSNumber            *sctp_mtu;
@property(readwrite,strong,atomic)  NSNumber            *sctp_maxInitTimeout;
@property(readwrite,strong,atomic)  NSNumber            *sctp_maxInitAttempts;



@end
