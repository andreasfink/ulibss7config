//
//  UMSS7ConfigAuthServer.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigAuthServer.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigAuthServer

+ (NSString *)type
{
   return @"auth-server";
}
- (NSString *)type
{
   return [UMSS7ConfigAuthServer type];
}

- (UMSS7ConfigAuthServer *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"zmq-listener",_zmqListener);
    APPEND_CONFIG_STRING(s,@"db-pool",_dbPool);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    
    APPEND_DICT_STRING(dict,@"zmq-listener",_zmqListener);
    APPEND_DICT_STRING(dict,@"db-pool",_dbPool);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"zmq-listener",_zmqListener);
    SET_DICT_STRING(dict,@"db-pool",_dbPool);
}

- (UMSS7ConfigAuthServer *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigAuthServer allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
