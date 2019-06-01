//
//  UMSS7ConfigCdrWriter.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigCdrWriter : UMSS7ConfigObject
{
    NSString *_dateFormat;
    NSString *_timeZone;
    NSString *_locale;
    NSString *_tableName;
    NSNumber *_autoCreate;
    NSString *_poolName;
    NSNumber *_reopenTime;
    NSNumber *_cdrQueueLimit;
    NSString *_cdrFilePrefix;
}

@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *dateFormat;
@property(readwrite,strong,atomic)  NSString *timeZone;
@property(readwrite,strong,atomic)  NSString *locale;
@property(readwrite,strong,atomic)  NSString *tableName;
@property(readwrite,strong,atomic)  NSNumber *autoCreate;
@property(readwrite,strong,atomic)  NSString *poolName;
@property(readwrite,strong,atomic)  NSNumber *reopenTime;
@property(readwrite,strong,atomic)  NSNumber *cdrQueueLimit;
@property(readwrite,strong,atomic)  NSString *cdrFilePrefix;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigCdrWriter *)initWithConfig:(NSDictionary *)dict;

@end

