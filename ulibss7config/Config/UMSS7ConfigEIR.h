//
//  UMSS7ConfigEIR.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>

@interface UMSS7ConfigEIR : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSString *_timeoutTraceDirectory;
    NSString *_fullTraceDirectory;
    NSString *_eirRequestUrl;
}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *timeoutTraceDirectory;
@property(readwrite,strong,atomic)   NSString *fullTraceDirectory;
@property(readwrite,strong,atomic)   NSString *eirRequestUrl;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigEIR *)initWithConfig:(NSDictionary *)dict;
@end

