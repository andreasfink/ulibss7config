//
//  UMSS7ConfigCdrWriter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigCdrWriter.h"
#import "UMSS7ConfigMacroHelper.h"

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
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigCdrWriter.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigCdrWriter.def.h"
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
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigCdrWriter.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSS7ConfigCdrWriter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigCdrWriter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end




