//
//  UMSS7ConfigDiameterConnection.m
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterConnection.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDiameterConnection

+ (NSString *)type
{
    return @"diameter-connection";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterConnection type];
}


- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"diameter-router",_diameterRouter);
//	APPEND_CONFIG_STRING(s,@"tcp-remote-host",_tcpRemoteHost);
//	APPEND_CONFIG_INTEGER(s,@"tcp-remote-port",_tcpRemotePort);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"diameter-router",_diameterRouter);
//	APPEND_DICT_STRING(dict,@"tcp-remote-host",_tcpRemoteHost);
//	APPEND_DICT_INTEGER(dict,@"tcp-remote-port",_tcpRemotePort);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"diameter-router",_diameterRouter);
//	SET_DICT_STRING(dict,@"tcp-remote-host",_tcpRemoteHost);
//	SET_DICT_INTEGER(dict,@"tcp-remote-port",_tcpRemotePort);

}

- (UMSS7ConfigDiameterConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


