//
//  SS7TemporaryImsiPool.h
//  ulibss7config
//
//  Created by Andreas Fink on 14.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>
#import <ulibsccp/ulibsccp.h>

@interface SS7TemporaryImsiPool : UMObject
{
    NSString *_name;
    UMPool *_unusedTemporaryImsis;
    NSMutableDictionary *_usedTemporaryImsis;
    NSMutableDictionary *_usedTemporaryImsisByMSISDN;
    UMMutex *_temporaryImsiLock;
    NSInteger _usedImsiCount;
    NSTimeInterval _imsiCacheTimer;
    UMTimer *_houseKeepingTimer;
    UMPool *_mscPool;
}

- (SS7TemporaryImsiPool *)initWithConfig:(NSDictionary *)config;
- (void)fillPoolWithPrefix:(NSString *)s;

@property(readwrite,atomic,strong)  NSString *name;
@property(readwrite,atomic,strong)  UMPool *unusedTemporaryImsis;
@property(readwrite,atomic,strong)  NSMutableDictionary *usedTemporaryImsis;
@property(readwrite,atomic,strong)  NSMutableDictionary *usedTemporaryImsisByMSISDN;
@property(readwrite,atomic,strong)  UMMutex *temporaryImsiLock;
@property(readwrite,atomic,assign)  NSInteger usedImsiCount;
@property(readwrite,atomic,assign)  NSTimeInterval imsiCacheTimer;

- (NSString *)getTemporaryImsiForMsisdn:(NSString *)msisdn
                         callingAddress:(SccpAddress *)incomingCallingAddress;
- (NSString *)getMsisdnForImsi:(NSString *)imsi;

- (NSString *)getMscNumber;
- (void)registerMscNumber:(NSString *)msc;
- (void)unregisterMscNumber:(NSString *)msc;

@end
