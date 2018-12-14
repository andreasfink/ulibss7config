//
//  SS7TemporaryImsiPool.m
//  ulibss7config
//
//  Created by Andreas Fink on 14.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7TemporaryImsiPool.h"
#import "SS7TemporaryImsiEntry.h"

@implementation SS7TemporaryImsiPool

- (SS7TemporaryImsiPool *)init
{
    return [self initWithConfig:NULL];
}

- (SS7TemporaryImsiPool *)initWithConfig:(NSDictionary *)config
{
    self = [super init];
    if(self)
    {
        _unusedTemporaryImsis = [[UMPool alloc]init];
        _usedTemporaryImsis   = [[NSMutableDictionary alloc]init];
        _usedTemporaryImsisByMSISDN   = [[NSMutableDictionary alloc]init];
        _usedImsiCount = 0;
        _mscPool = [[UMPool alloc]init];
        _temporaryImsiLock = [[UMMutex alloc]initWithName:@"temporary-imsi-lock"];
        if(config)
        {
            _name = config[@"name"];
            if(config[@"cache-timer"])
            {
                _imsiCacheTimer = [config[@"cache-timer"] doubleValue];
            }
            [self fillPoolWithPrefix:config[@"imsi-prefix"]];
            _houseKeepingTimer = [[UMTimer alloc]initWithTarget:self
                                                       selector:@selector(housekeeping)
                                                         object:NULL
                                                        seconds:1.1
                                                           name:@"housekeeping"
                                                        repeats:YES];
            [_houseKeepingTimer start];

        }
    }
    return self;
}

#define CONFIG_ERROR(s)     [NSException exceptionWithName:[NSString stringWithFormat:@"CONFIG_ERROR FILE %s line:%ld",__FILE__,(long)__LINE__] reason:s userInfo:@{@"backtrace": UMBacktrace(NULL,0) }]

- (void)fillPoolWithPrefix:(NSString *)s
{
    if(s.length == 0)
    {
        for(int i=0;i<1000000;i++)
        {
            [_unusedTemporaryImsis append:[NSString stringWithFormat:@"00101999%07d",i]];
        }
    }
    else if((s.length < 7) || (s.length >10))
    {
        @throw(CONFIG_ERROR(@"imsi-prefix should be 7 to 10 digits"));
    }
    else
    {
        int max;
        int remaining_digits = 15 - (int)s.length; // 15-7 = 8
        NSString *format;

        /* we dont generate more than one milliong entries  as it would be an overkill */
        /* so we either generate 100k or 1 million imsis */
        switch(remaining_digits)
        {
            case 1:
                max = 1;
                format = @"%@%01d";
                break;
            case 2:
                max = 10;
                format = @"%@%02d";
                break;
            case 3:
                max = 1000;
                format = @"%@%03d";
                break;
            case 4:
                max = 10000;
                format = @"%@%04d";
                break;
            case 5:
                max = 100000;
                format = @"%@%05d";
                break;
            case 6:
                max = 1000000;
                format = @"%@%06d";
                break;
            case 7:
                max = 1000000;
                format = [NSString stringWithFormat:@"%%@%01d%%06d", (int)[UMUtil random:9] ];
                break;
            case 8:
                max = 1000000;
                format = [NSString stringWithFormat:@"%%@%02d%%06d", (int)[UMUtil random:99] ];
                break;
            case 9:
                max = 1000000;
                format = [NSString stringWithFormat:@"%%@%03d%%06d", (int)[UMUtil random:999] ];
                break;
            case 10:
                max = 1000000;
                format = [NSString stringWithFormat:@"%%@%04d%%06d", (int)[UMUtil random:9999] ];
                break;
            default:
                max = 1000000;
                format = [NSString stringWithFormat:@"%%@%05d%%06d", (int)[UMUtil random:99999] ];
                break;
        }
        for(int i=0;i<max;i++)
        {
            [_unusedTemporaryImsis append:[NSString stringWithFormat:format,s,i]];
        }
    }
}

- (NSString *)getTemporaryImsiForMsisdn:(NSString *)msisdn
                         callingAddress:(SccpAddress *)incomingCallingAddress
{
    NSString *temporaryImsi = NULL;

    [_temporaryImsiLock lock];
    SS7TemporaryImsiEntry *ti = _usedTemporaryImsisByMSISDN[msisdn];
    if(ti)
    {
        ti.lastUsed = [NSDate date];
        temporaryImsi = ti.imsi;
    }
    if(temporaryImsi==NULL)
    {
        temporaryImsi = [_unusedTemporaryImsis getAny];
        if(temporaryImsi)
        {
            SS7TemporaryImsiEntry *ti = _usedTemporaryImsis[temporaryImsi];
            if(ti==NULL)
            {
                ti = [[SS7TemporaryImsiEntry alloc]init];
                ti.msisdn = msisdn;
                ti.sccpCallingAddress = incomingCallingAddress;
                ti.imsi = temporaryImsi;
                ti.create = [NSDate date];
            }
            ti.lastUsed = [NSDate date];
            _usedTemporaryImsis[temporaryImsi] = ti;
        }
    }
    [_temporaryImsiLock unlock];
    return temporaryImsi;
}

- (NSString *)getMsisdnForImsi:(NSString *)imsi
{
    [_temporaryImsiLock lock];
    SS7TemporaryImsiEntry *ti = _usedTemporaryImsis[imsi];
    [_temporaryImsiLock unlock];
    return ti.msisdn;
}

-(NSInteger)unusedImsiCount
{
    [_temporaryImsiLock lock];
    NSInteger count =  _unusedTemporaryImsis.count;
    [_temporaryImsiLock unlock];
    return count;

}

- (void)purgeUnusedTemporaryImsis
{
    [_temporaryImsiLock lock];
    NSArray *allImsis = [_usedTemporaryImsis allKeys];
    [_temporaryImsiLock unlock];
    for(NSString *temporaryImsi in allImsis)
    {
        [_temporaryImsiLock lock];
        SS7TemporaryImsiEntry *ti = _usedTemporaryImsis[temporaryImsi];
        [_temporaryImsiLock unlock];
        if(ti)
        {
            if(-([ti.lastUsed timeIntervalSinceNow]) > _imsiCacheTimer)
            {
                [_temporaryImsiLock lock];
                [_usedTemporaryImsis removeObjectForKey:ti.imsi];
                [_usedTemporaryImsisByMSISDN removeObjectForKey:ti.msisdn];
                _usedImsiCount = _usedImsiCount - 1;
                [_temporaryImsiLock unlock];
                [_unusedTemporaryImsis append:ti.imsi];
            }
        }
    }
}

- (NSString *)getMscNumber
{
    NSString *msc = [_mscPool getAny];
    return msc;
}

- (void)registerMscNumber:(NSString *)msc
{
    [_mscPool append:msc];
}

- (void)unregisterMscNumber:(NSString *)msc
{
    [_mscPool removeObjectIdenticalTo:msc];
}


- (void)housekeeping
{
    [self purgeUnusedTemporaryImsis];
}
@end
