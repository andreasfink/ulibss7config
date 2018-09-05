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


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"host",_host);
    APPEND_CONFIG_STRING(s,@"database-name",_databaseName);
    APPEND_CONFIG_STRING(s,@"driver",_driver);
    APPEND_CONFIG_STRING(s,@"user",_user);
    APPEND_CONFIG_STRING(s,@"pass",_pass);
    APPEND_CONFIG_INTEGER(s,@"port",_port);
    APPEND_CONFIG_INTEGER(s,@"min-sessions",_minSessions);
    APPEND_CONFIG_INTEGER(s,@"max-sessions",_maxSessions);
    APPEND_CONFIG_STRING(s,@"socket",_socket);
    APPEND_CONFIG_DOUBLE(s,@"ping-intervall",_pingIntervall);

    APPEND_CONFIG_STRING(s,@"storage-type",_storageType);
    APPEND_CONFIG_STRING(s,@"version",_version);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"host",_host);
    APPEND_DICT_STRING(dict,@"database-name",_databaseName);
    APPEND_DICT_STRING(dict,@"driver",_driver);
    APPEND_DICT_STRING(dict,@"user",_user);
    APPEND_DICT_STRING(dict,@"pass",_pass);
    APPEND_DICT_INTEGER(dict,@"port",_port);
    APPEND_DICT_INTEGER(dict,@"min-sessions",_minSessions);
    APPEND_DICT_INTEGER(dict,@"max-sessions",_maxSessions);
    APPEND_DICT_STRING(dict,@"socket",_socket);
    APPEND_DICT_DOUBLE(dict,@"ping-intervall",_pingIntervall);
    APPEND_DICT_STRING(dict,@"storage-type",_storageType);
    APPEND_DICT_STRING(dict,@"version",_version);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"host",_host);
    SET_DICT_STRING(dict,@"database-name",_databaseName);
    SET_DICT_STRING(dict,@"driver",_driver);
    SET_DICT_STRING(dict,@"user",_user);
    SET_DICT_STRING(dict,@"pass",_pass);
    SET_DICT_INTEGER(dict,@"port",_port);
    SET_DICT_INTEGER(dict,@"min-sessions",_minSessions);
    SET_DICT_INTEGER(dict,@"max-sessions",_maxSessions);
    SET_DICT_STRING(dict,@"socket",_socket);
    SET_DICT_DOUBLE(dict,@"ping-intervall",_pingIntervall);
    SET_DICT_STRING(dict,@"storage-type",_storageType);
    SET_DICT_STRING(dict,@"version",_version);

}


- (UMSS7ConfigDatabasePool *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDatabasePool allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



