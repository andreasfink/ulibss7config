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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigCdrWriter.def"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_CONFIG_STRING(o,@"cdr-type",_cdrType);
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_INTEGER(o,@"cdr-queue-limit",_cdrQueueLimit);
    APPEND_CONFIG_STRING(o,@"cdr-file-prefix",_cdrFilePrefix);
    APPEND_CONFIG_DOUBLE(o,@"reopen-time",_reopenTime);
    APPEND_CONFIG_STRING(o,@"date-format",_dateFormat);
    APPEND_CONFIG_STRING(o,@"time-zone",_timeZone);
    APPEND_CONFIG_STRING(o,@"locale",_locale);
    APPEND_CONFIG_STRING(o,@"table-name",_tableName);
    APPEND_CONFIG_BOOLEAN(o,@"auto-create",_autoCreate);
    APPEND_CONFIG_STRING(o,@"pool-name",_poolName);
#endif
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigCdrWriter.def"
#include "UMSS7Config_macroClear.h"
#else

    APPEND_DICT_STRING(o,@"cdr-type",_cdrType);
    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_INTEGER(o,@"cdr-queue-limit",_cdrQueueLimit);
    APPEND_DICT_STRING(o,@"cdr-file-prefix",_cdrFilePrefix);
    APPEND_DICT_DOUBLE(o,@"reopen-time",_reopenTime);

    APPEND_DICT_STRING(o,@"date-format",_dateFormat);
    APPEND_DICT_STRING(o,@"time-zone",_timeZone);
    APPEND_DICT_STRING(o,@"locale",_locale);
    APPEND_DICT_STRING(o,@"table-name",_tableName);
    APPEND_DICT_BOOLEAN(o,@"auto-create",_autoCreate);
    APPEND_DICT_STRING(o,@"pool-name",_poolName);
#endif
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigCdrWriter.def"
#include "UMSS7Config_macroClear.h"
#else
    SET_DICT_STRING(o,@"cdr-type",_cdrType);
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_INTEGER(o,@"cdr-queue-limit",_cdrQueueLimit);
    SET_DICT_STRING(o,@"cdr-file-prefix",_cdrFilePrefix);
    SET_DICT_DOUBLE(o,@"reopen-time",_reopenTime);
    SET_DICT_STRING(o,@"date-format",_dateFormat);
    SET_DICT_STRING(o,@"time-zone",_timeZone);
    SET_DICT_STRING(o,@"locale",_locale);
    SET_DICT_STRING(o,@"table-name",_tableName);
    SET_DICT_BOOLEAN(o,@"auto-create",_autoCreate);
    SET_DICT_STRING(o,@"pool-name",_poolName);
#endif
}


- (UMSS7ConfigCdrWriter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigCdrWriter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end




