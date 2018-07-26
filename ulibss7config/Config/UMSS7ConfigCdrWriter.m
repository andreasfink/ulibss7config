//
//  UMSS7ConfigCdrWriter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigCdrWriter.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigCdrWriter

+ (NSString *)type
{
    return @"cdr-writer";
}

- (NSString *)type
{
    return [UMSS7ConfigCdrWriter type];
}


- (UMSS7ConfigCdrWriter *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"attach-to",_attachTo);
    APPEND_CONFIG_INTEGER(s,@"cdr-queue-limit",_cdrQueueLimit);
    APPEND_CONFIG_STRING(s,@"cdr-file-prefix",_cdrFilePrefix);
    APPEND_CONFIG_DOUBLE(s,@"reopen-time",_reopenTime);
    APPEND_CONFIG_STRING(s,@"date-format",_dateFormat);
    APPEND_CONFIG_STRING(s,@"time-zone",_timeZone);
    APPEND_CONFIG_STRING(s,@"locale",_locale);
    APPEND_CONFIG_STRING(s,@"table-name",_tableName);
    APPEND_CONFIG_BOOLEAN(s,@"auto-create",_autoCreate);
    APPEND_CONFIG_STRING(s,@"pool-name",_poolName);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_INTEGER(dict,@"cdr-queue-limit",_cdrQueueLimit);
    APPEND_DICT_STRING(dict,@"cdr-file-prefix",_cdrFilePrefix);
    APPEND_DICT_DOUBLE(dict,@"reopen-time",_reopenTime);

    APPEND_DICT_STRING(dict,@"date-format",_dateFormat);
    APPEND_DICT_STRING(dict,@"time-zone",_timeZone);
    APPEND_DICT_STRING(dict,@"locale",_locale);
    APPEND_DICT_STRING(dict,@"table-name",_tableName);
    APPEND_DICT_BOOLEAN(dict,@"auto-create",_autoCreate);
    APPEND_DICT_STRING(dict,@"pool-name",_poolName);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_INTEGER(dict,@"cdr-queue-limit",_cdrQueueLimit);
    SET_DICT_STRING(dict,@"cdr-file-prefix",_cdrFilePrefix);
    SET_DICT_DOUBLE(dict,@"reopen-time",_reopenTime);
    SET_DICT_STRING(dict,@"date-format",_dateFormat);
    SET_DICT_STRING(dict,@"time-zone",_timeZone);
    SET_DICT_STRING(dict,@"locale",_locale);
    SET_DICT_STRING(dict,@"table-name",_tableName);
    SET_DICT_BOOLEAN(dict,@"auto-create",_autoCreate);
    SET_DICT_STRING(dict,@"pool-name",_poolName);

}


- (UMSS7ConfigCdrWriter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigCdrWriter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end




