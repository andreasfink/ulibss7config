//
//  UMSS7ConfigWebserver.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigWebserver.h"
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


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_INTEGER(s,@"port",_port);
    APPEND_CONFIG_BOOLEAN(s,@"https",_https);
    APPEND_CONFIG_STRING(s,@"https-key-file",_httpsKeyFile);
    APPEND_CONFIG_STRING(s,@"https-cert-file",_httpsCertFile);
    APPEND_CONFIG_STRING(s,@"document-root",_documentRoot);
    APPEND_CONFIG_STRING(s,@"ip-version",_ipVersion);
    APPEND_CONFIG_STRING(s,@"transport-protocol",_transportProtocol);
    APPEND_CONFIG_BOOLEAN(s,@"disable-authentication",_disableAuthentication);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_INTEGER(dict,@"port",_port);
    APPEND_DICT_BOOLEAN(dict,@"https",_https);
    APPEND_DICT_STRING(dict,@"https-key-file",_httpsKeyFile);
    APPEND_DICT_STRING(dict,@"https-cert-file",_httpsCertFile);
    APPEND_DICT_STRING(dict,@"document-root",_documentRoot);
    APPEND_DICT_STRING(dict,@"ip-version",_ipVersion);
    APPEND_DICT_STRING(dict,@"transport-protocol",_transportProtocol);
    APPEND_DICT_BOOLEAN(dict,@"disable-authentication",_disableAuthentication);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_INTEGER(dict,@"port",_port);
    SET_DICT_BOOLEAN(dict,@"https",_https);
    SET_DICT_STRING(dict,@"https-key-file",_httpsKeyFile);
    SET_DICT_STRING(dict,@"https-cert-file",_httpsCertFile);
    SET_DICT_STRING(dict,@"document-root",_documentRoot);
    SET_DICT_STRING(dict,@"ip-version",_ipVersion);
    SET_DICT_STRING(dict,@"transport-protocol",_transportProtocol);
    SET_DICT_BOOLEAN(dict,@"disable-authentication",_disableAuthentication);
}

- (UMSS7ConfigWebserver *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigWebserver allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

