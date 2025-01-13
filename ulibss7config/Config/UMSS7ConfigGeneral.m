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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigGeneral.def.h"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_CONFIG_STRING(o,@"hostname",_hostname);
    APPEND_CONFIG_STRING(o,@"log-directory",_logDirectory);
    APPEND_CONFIG_INTEGER(o,@"log-rotations",_logRotations);
    APPEND_CONFIG_STRING(o,@"config-store",_configStore);
    APPEND_CONFIG_INTEGER(o,@"concurrent-tasks",_concurrentTasks);
    APPEND_CONFIG_INTEGER(o,@"queue-hard-limit",_queueHardLimit);
    APPEND_CONFIG_INTEGER(o,@"transaction-id-range",_transactionIdRange);
    APPEND_CONFIG_BOOLEAN(o,@"send-sctp-aborts",_sendSctpAborts);
    APPEND_CONFIG_STRING(o,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_CONFIG_STRING(o,@"zmq-socket",_zmqSocket);
    APPEND_CONFIG_STRING(o,@"gui",_gui);
#endif

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigGeneral.def.h"
#include "UMSS7Config_macroClear.h"
#else

    

    APPEND_DICT_STRING(o,@"hostname",_hostname);
    APPEND_DICT_STRING(o,@"log-directory",_logDirectory);
    APPEND_DICT_INTEGER(o,@"log-rotations",_logRotations);
    APPEND_DICT_STRING(o,@"config-store",_configStore);
    APPEND_DICT_INTEGER(o,@"concurrent-tasks",_concurrentTasks);
    APPEND_DICT_INTEGER(o,@"queue-hard-limit",_queueHardLimit);
    APPEND_DICT_STRING(o,@"transaction-id-range",_transactionIdRange);
    APPEND_DICT_BOOLEAN(o,@"send-sctp-aborts",_sendSctpAborts);
    APPEND_DICT_STRING(o,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_DICT_STRING(o,@"zmq-socket",_zmqSocket);
    APPEND_DICT_STRING(o,@"gui",_gui);
#endif
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigGeneral.def.h"
#include "UMSS7Config_macroClear.h"
#else
    SET_DICT_STRING(o,@"hostname",_hostname);
    SET_DICT_STRING(o,@"log-directory",_logDirectory);
    SET_DICT_INTEGER(o,@"log-rotations",_logRotations);
    SET_DICT_STRING(o,@"config-store",_configStore);
    SET_DICT_INTEGER(o,@"concurrent-tasks",_concurrentTasks);
    SET_DICT_INTEGER(o,@"queue-hard-limit",_queueHardLimit);
    SET_DICT_STRING(o,@"transaction-id-range",_transactionIdRange);
    SET_DICT_BOOLEAN(o,@"send-sctp-aborts",_sendSctpAborts);
    SET_DICT_STRING(o,@"filter-engine-directory",_filterEngineDirectory);
    SET_DICT_STRING(o,@"zmq-socket",_zmqSocket);
    SET_DICT_STRING(o,@"gui",_gui);
#endif
}

- (UMSS7ConfigGeneral *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGeneral allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
