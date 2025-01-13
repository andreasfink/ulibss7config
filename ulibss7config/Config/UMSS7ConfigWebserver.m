//
//  UMSS7ConfigWebserver.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigWebserver.h>
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigWebserver

+ (NSString *)type
{
    return @"webserver";
}
- (NSString *)type
{
    return [UMSS7ConfigWebserver type];
}

- (UMSS7ConfigWebserver *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_BOOLEAN(o,@"https",_https);
    APPEND_CONFIG_STRING(o,@"https-key-file",_httpsKeyFile);
    APPEND_CONFIG_STRING(o,@"https-cert-file",_httpsCertFile);
    APPEND_CONFIG_STRING(o,@"document-root",_documentRoot);
    APPEND_CONFIG_STRING(o,@"ip-version",_ipVersion);
    APPEND_CONFIG_STRING(o,@"transport-protocol",_transportProtocol);
    APPEND_CONFIG_BOOLEAN(o,@"disable-authentication",_disableAuthentication);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_INTEGER(o,@"port",_port);
    APPEND_DICT_BOOLEAN(o,@"https",_https);
    APPEND_DICT_STRING(o,@"https-key-file",_httpsKeyFile);
    APPEND_DICT_STRING(o,@"https-cert-file",_httpsCertFile);
    APPEND_DICT_STRING(o,@"document-root",_documentRoot);
    APPEND_DICT_STRING(o,@"ip-version",_ipVersion);
    APPEND_DICT_STRING(o,@"transport-protocol",_transportProtocol);
    APPEND_DICT_BOOLEAN(o,@"disable-authentication",_disableAuthentication);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_INTEGER(o,@"port",_port);
    SET_DICT_BOOLEAN(o,@"https",_https);
    SET_DICT_STRING(o,@"https-key-file",_httpsKeyFile);
    SET_DICT_STRING(o,@"https-cert-file",_httpsCertFile);
    SET_DICT_STRING(o,@"document-root",_documentRoot);
    SET_DICT_STRING(o,@"ip-version",_ipVersion);
    SET_DICT_STRING(o,@"transport-protocol",_transportProtocol);
    SET_DICT_BOOLEAN(o,@"disable-authentication",_disableAuthentication);
}

- (UMSS7ConfigWebserver *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigWebserver allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

