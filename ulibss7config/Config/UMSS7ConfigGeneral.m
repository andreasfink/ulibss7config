//
//  UMSS7ConfigGeneral.m
//  estp
//
//  Created by Andreas Fink on 09.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGeneral.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGeneral

+ (NSString *)type
{
    return @"general";
}

- (NSString *)type
{
    return [UMSS7ConfigGeneral type];
}

- (UMSS7ConfigGeneral *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"hostname",_hostname);
    APPEND_CONFIG_STRING(s,@"log-directory",_logDirectory);
    APPEND_CONFIG_INTEGER(s,@"log-rotations",_logRotations);
    APPEND_CONFIG_STRING(s,@"config-store",_configStore);
    APPEND_CONFIG_INTEGER(s,@"concurrent-tasks",_concurrentTasks);
    APPEND_CONFIG_INTEGER(s,@"queue-hard-limit",_queueHardLimit);
    APPEND_CONFIG_INTEGER(s,@"transaction-id-range",_transactionIdRange);
    APPEND_CONFIG_BOOLEAN(s,@"send-sctp-aborts",_sendSctpAborts);
    APPEND_CONFIG_STRING(s,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_CONFIG_STRING(s,@"zmq-socket",_zmqSocket);
    APPEND_CONFIG_STRING(s,@"gui",_gui);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"hostname",_hostname);
    APPEND_DICT_STRING(dict,@"log-directory",_logDirectory);
    APPEND_DICT_INTEGER(dict,@"log-rotations",_logRotations);
    APPEND_DICT_STRING(dict,@"config-store",_configStore);
    APPEND_DICT_INTEGER(dict,@"concurrent-tasks",_concurrentTasks);
    APPEND_DICT_INTEGER(dict,@"queue-hard-limit",_queueHardLimit);
    APPEND_DICT_STRING(dict,@"transaction-id-range",_transactionIdRange);
    APPEND_DICT_BOOLEAN(dict,@"send-sctp-aborts",_sendSctpAborts);
    APPEND_DICT_STRING(dict,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_DICT_STRING(dict,@"zmq-socket",_zmqSocket);
    APPEND_DICT_STRING(dict,@"gui",_gui);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"hostname",_hostname);
    SET_DICT_STRING(dict,@"log-directory",_logDirectory);
    SET_DICT_INTEGER(dict,@"log-rotations",_logRotations);
    SET_DICT_STRING(dict,@"config-store",_configStore);
    SET_DICT_INTEGER(dict,@"concurrent-tasks",_concurrentTasks);
    SET_DICT_INTEGER(dict,@"queue-hard-limit",_queueHardLimit);
    SET_DICT_STRING(dict,@"transaction-id-range",_transactionIdRange);
    SET_DICT_BOOLEAN(dict,@"send-sctp-aborts",_sendSctpAborts);
    SET_DICT_STRING(dict,@"filter-engine-directory",_filterEngineDirectory);
    SET_DICT_STRING(dict,@"zmq-socket",_zmqSocket);
    SET_DICT_STRING(dict,@"gui",_gui);
}

- (UMSS7ConfigGeneral *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGeneral allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
