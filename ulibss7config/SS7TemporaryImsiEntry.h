//
//  SS7TemporaryImsiEntry.h
//  ulibss7config
//
//  Created by Andreas Fink on 14.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>
#import <ulibsccp/ulibsccp.h>
@interface SS7TemporaryImsiEntry : UMObject

{
    NSString *_msisdn;
    SccpAddress *_sccpCallingAddress;
    NSString *_imsi;
    NSDate *_create;
    NSDate *_lastUsed;
}
@property(readwrite,strong,atomic) NSString *msisdn;
@property(readwrite,strong,atomic) SccpAddress *sccpCallingAddress;
@property(readwrite,strong,atomic) NSString *imsi;
@property(readwrite,strong,atomic) NSDate *create;
@property(readwrite,strong,atomic) NSDate *lastUsed;

@end
