//
//  UMSS7ConfigM2pa.h
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigM2PA : UMSS7ConfigObject
{
    NSString        *_attachTo; /* sctp object */
    NSNumber        *_windowSize;
    NSNumber        *_speed;
    NSNumber        *_t1;
    NSNumber        *_t2;
    NSNumber        *_t3;
    NSNumber        *_t4e;
    NSNumber        *_t4r;
    NSNumber        *_t4n;
    NSNumber        *_t5;
    NSNumber        *_t6;
    NSNumber        *_t7;
    NSNumber        *_t16;
    NSNumber        *_t17;
    NSNumber        *_t18;
    NSNumber        *_ackTimer;
    NSString        *_stateMachineLog;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigM2PA *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)      NSString        *attachTo;
@property(readwrite,strong,atomic)      NSNumber        *autostart;
@property(readwrite,strong,atomic)      NSNumber        *windowSize;
@property(readwrite,strong,atomic)      NSNumber        *speed;
@property(readwrite,strong,atomic)      NSNumber        *t1;
@property(readwrite,strong,atomic)      NSNumber        *t2;
@property(readwrite,strong,atomic)      NSNumber        *t3;
@property(readwrite,strong,atomic)      NSNumber        *t4e;
@property(readwrite,strong,atomic)      NSNumber        *t4r;
@property(readwrite,strong,atomic)      NSNumber        *t4n;
@property(readwrite,strong,atomic)      NSNumber        *t5;
@property(readwrite,strong,atomic)      NSNumber        *t6;
@property(readwrite,strong,atomic)      NSNumber        *t7;
@property(readwrite,strong,atomic)      NSNumber        *t16;
@property(readwrite,strong,atomic)      NSNumber        *t17;
@property(readwrite,strong,atomic)      NSNumber        *t18;
@property(readwrite,strong,atomic)      NSNumber        *ackTimer;

@end
