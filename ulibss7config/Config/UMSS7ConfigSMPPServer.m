//
//  UMSS7ConfigSMPPServer.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMPPServer.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMPPServer


+ (NSString *)type
{
   return @"smpp-server";
}
- (NSString *)type
{
   return [UMSS7ConfigSMPPServer type];
}

- (UMSS7ConfigSMPPServer *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_INTEGER(o,@"port",_port);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"ip-authorisation-plugin",_ipAuthorisationPlugins);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"user-authorisation-plugin",_userAuthorisationPlugins);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"submission-authorisation-plugin",_submissionAuthorisationPlugins);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"characterisation-plugin",_characterisationPlugins);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"modification-plugin",_modificationPlugins);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"prerouting-plugin",_preroutingPlugins);
    APPEND_CONFIG_STRING(o,@"routing-plugin",_routingPlugin);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"billing-plugin",_billingPlugins);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"dlr-plugin",_dlrPlugins);
    APPEND_CONFIG_STRING(o,@"storage-plugin",_storagePlugin);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"cdr-plugin",_cdrPlugins);
    APPEND_CONFIG_STRING(o,@"auth-server",_authServer);
    APPEND_CONFIG_STRING(o,@"router",_router);
    APPEND_CONFIG_STRING(o,@"storage-server",_storageServer);
    APPEND_CONFIG_STRING(o,@"cdr-server",_cdrServer);
    APPEND_CONFIG_STRING(o,@"zmq-socket",_zmqSocket);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
    APPEND_DICT_INTEGER(o,@"port",_port);
    APPEND_DICT_ARRAY(dict,@"ip-authorisation-plugin",_ipAuthorisationPlugins);
    APPEND_DICT_ARRAY(dict,@"user-authorisation-plugin",_userAuthorisationPlugins);
    APPEND_DICT_ARRAY(dict,@"submission-authorisation-plugin",_submissionAuthorisationPlugins);
    APPEND_DICT_ARRAY(dict,@"characterisation-plugin",_characterisationPlugins);
    APPEND_DICT_ARRAY(dict,@"modification-plugin",_modificationPlugins);
    APPEND_DICT_ARRAY(dict,@"prerouting-plugin",_preroutingPlugins);
    APPEND_DICT_STRING(o,@"routing-plugin",_routingPlugin);
    APPEND_DICT_ARRAY(dict,@"billing-plugin",_billingPlugins);
    APPEND_DICT_ARRAY(dict,@"dlr-plugin",_dlrPlugins);
    APPEND_DICT_STRING(o,@"storage-plugin",_storagePlugin);
    APPEND_DICT_ARRAY(dict,@"cdr-plugin",_cdrPlugins);
    APPEND_DICT_STRING(o,@"auth-server",_authServer);
    APPEND_DICT_STRING(o,@"router",_router);
    APPEND_DICT_STRING(o,@"storage-server",_storageServer);
    APPEND_DICT_STRING(o,@"cdr-server",_cdrServer);
    APPEND_DICT_STRING(o,@"zmq-socket",_zmqSocket);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_INTEGER(o,@"port",_port);
    SET_DICT_ARRAY(dict,@"ip-authorisation-plugin",_ipAuthorisationPlugins)
    SET_DICT_ARRAY(dict,@"user-authorisation-plugin",_userAuthorisationPlugins);
    SET_DICT_ARRAY(dict,@"submission-authorisation-plugin",_submissionAuthorisationPlugins);
    SET_DICT_ARRAY(dict,@"characterisation-plugin",_characterisationPlugins);
    SET_DICT_ARRAY(dict,@"modification-plugin",_modificationPlugins);
    SET_DICT_ARRAY(dict,@"prerouting-plugin",_preroutingPlugins);
    SET_DICT_STRING(o,@"routing-plugin",_routingPlugin);
    SET_DICT_ARRAY(dict,@"billing-plugin",_billingPlugins);
    SET_DICT_ARRAY(dict,@"dlr-plugin",_dlrPlugins);
    SET_DICT_STRING(o,@"storage-plugin",_storagePlugin);
    SET_DICT_ARRAY(dict,@"cdr-plugin",_cdrPlugins);
    SET_DICT_STRING(o,@"auth-server",_authServer);
    SET_DICT_STRING(o,@"router",_router);
    SET_DICT_STRING(o,@"storage-server",_storageServer);
    SET_DICT_STRING(o,@"cdr-server",_cdrServer);
    SET_DICT_STRING(o,@"zmq-socket",_zmqSocket);
}

- (UMSS7ConfigSMPPServer *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMPPServer allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
