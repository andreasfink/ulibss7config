//
//  UMSS7ConfigMtp3Link.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3LinkSet.h"

@interface UMSS7ConfigMTP3Link : UMSS7ConfigObject
{
    NSString *_mtp3LinkSet;
    NSString *_m2pa;
    NSNumber *_slc;
    NSNumber *_linkTestTime;
    NSNumber *_linkTestAckTime;
    NSNumber *_reopenTimer1;
    NSNumber *_reopenTimer2;

    /* implicit m2pa object */
    NSNumber        *_m2pa_windowSize;
    NSNumber        *_m2pa_speed;
    NSNumber        *_m2pa_t1;
    NSNumber        *_m2pa_t2;
    NSNumber        *_m2pa_t3;
    NSNumber        *_m2pa_t4e;
    NSNumber        *_m2pa_t4r;
    NSNumber        *_m2pa_t4n;
    NSNumber        *_m2pa_t5;
    NSNumber        *_m2pa_t6;
    NSNumber        *_m2pa_t7;
    NSString        *_m2pa_stateMachineLog;

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
- (UMSS7ConfigMTP3Link *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3LinkSet;
@property(readwrite,strong,atomic)  NSString *m2pa;
@property(readwrite,strong,atomic)  NSNumber *slc;
@property(readwrite,strong,atomic)  NSNumber *linkTestTime;
@property(readwrite,strong,atomic)  NSNumber *linkTestAckTime;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer1;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer2;

@property(readwrite,strong,atomic)  NSNumber        *m2pa_windowSize;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_speed;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t1;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t2;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t3;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t4e;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t4r;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t4n;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t5;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t6;
@property(readwrite,strong,atomic)  NSNumber        *m2pa_t7;
@property(readwrite,strong,atomic)  NSString        *m2pa_stateMachineLog;

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
