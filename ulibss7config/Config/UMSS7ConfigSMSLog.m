//
//  UMSS7ConfigSMSLog.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.04.2024.
//  Copyright © 2024 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSLog.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSLog

+ (NSString *)type
{
   return @"sms-log";
}
- (NSString *)type
{
   return [UMSS7ConfigSMSLog type];
}

- (UMSS7ConfigSMSLog *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"zmq-listener",_zmqListener);
    APPEND_CONFIG_STRING(o,@"database-pool",_dbPool);
    APPEND_CONFIG_STRING(o,@"database-table",_dbTable);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"zmq-listener",_zmqListener);
    APPEND_DICT_STRING(o,@"database-pool",_dbPool);
    APPEND_DICT_STRING(o,@"database-table",_dbTable);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"zmq-listener",_zmqListener);
    SET_DICT_STRING(o,@"database-pool",_dbPool);
    SET_DICT_STRING(o,@"database-table",_dbTable);
}


- (UMSS7ConfigSMSLog *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSLog allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
