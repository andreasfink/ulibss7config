//
//  UMSS7ConfigDatabasePool.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDatabasePool.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDatabasePool

+ (NSString *)type
{
    return @"database-pool";
}

- (NSString *)type
{
    return [UMSS7ConfigDatabasePool type];
}


- (UMSS7ConfigDatabasePool *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigDatabasePool.def"
#include "UMSS7Config_macroClear.h"
#else
    APPEND_CONFIG_STRING(o,@"host",_host);
    APPEND_CONFIG_STRING(o,@"database-name",_databaseName);
    APPEND_CONFIG_STRING(o,@"driver",_driver);
    APPEND_CONFIG_STRING(o,@"user",_user);
    APPEND_CONFIG_STRING(o,@"pass",_pass);
    APPEND_CONFIG_INTEGER(o,@"port",_port);
    APPEND_CONFIG_INTEGER(o,@"min-sessions",_minSessions);
    APPEND_CONFIG_INTEGER(o,@"max-sessions",_maxSessions);
    APPEND_CONFIG_STRING(o,@"socket",_socket);
    APPEND_CONFIG_DOUBLE(o,@"ping-intervall",_pingIntervall);
    APPEND_CONFIG_STRING(o,@"storage-type",_storageType);
    APPEND_CONFIG_STRING(o,@"version",_version);
#endif

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigDatabasePool.def"
#include "UMSS7Config_macroClear.h"
#else

    APPEND_DICT_STRING(o,@"host",_host);
    APPEND_DICT_STRING(o,@"database-name",_databaseName);
    APPEND_DICT_STRING(o,@"driver",_driver);
    APPEND_DICT_STRING(o,@"user",_user);
    APPEND_DICT_STRING(o,@"pass",_pass);
    APPEND_DICT_INTEGER(o,@"port",_port);
    APPEND_DICT_INTEGER(o,@"min-sessions",_minSessions);
    APPEND_DICT_INTEGER(o,@"max-sessions",_maxSessions);
    APPEND_DICT_STRING(o,@"socket",_socket);
    APPEND_DICT_DOUBLE(o,@"ping-intervall",_pingIntervall);
    APPEND_DICT_STRING(o,@"storage-type",_storageType);
    APPEND_DICT_STRING(o,@"version",_version);
#endif
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    
#if(USE_NEW_SS7CONFIG_MACROS)
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigDatabasePool.def"
#include "UMSS7Config_macroClear.h"
#else

    SET_DICT_STRING(o,@"host",_host);
    SET_DICT_STRING(o,@"database-name",_databaseName);
    SET_DICT_STRING(o,@"driver",_driver);
    SET_DICT_STRING(o,@"user",_user);
    SET_DICT_STRING(o,@"pass",_pass);
    SET_DICT_INTEGER(o,@"port",_port);
    SET_DICT_INTEGER(o,@"min-sessions",_minSessions);
    SET_DICT_INTEGER(o,@"max-sessions",_maxSessions);
    SET_DICT_STRING(o,@"socket",_socket);
    SET_DICT_DOUBLE(o,@"ping-intervall",_pingIntervall);
    SET_DICT_STRING(o,@"storage-type",_storageType);
    SET_DICT_STRING(o,@"version",_version);
#endif
}


- (UMSS7ConfigDatabasePool *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDatabasePool allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



