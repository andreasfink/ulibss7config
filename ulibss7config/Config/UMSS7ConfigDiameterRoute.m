//
//  UMSS7ConfigDiameterRoute.m
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigDiameterRoute

+ (NSString *)type
{
    return @"diameter-route";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterRoute type];
}


- (UMSS7ConfigDiameterRoute *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"router",_router);
    APPEND_CONFIG_STRING(o,@"destination",_destination);
    APPEND_CONFIG_STRING(o,@"hostname",_hostname);
    APPEND_CONFIG_STRING(o,@"realm",_realm);
    APPEND_CONFIG_INTEGER(o,@"application-id",_applicationId);
    APPEND_CONFIG_DOUBLE(o,@"weight",_weight);
    APPEND_CONFIG_DOUBLE(o,@"priority",_priority);
    APPEND_CONFIG_BOOLEAN(o,@"local",_local);
    APPEND_CONFIG_BOOLEAN(o,@"default-route",_defaultRoute);
    APPEND_CONFIG_BOOLEAN(o,@"exact-hostname",_exactHost);
    APPEND_CONFIG_BOOLEAN(o,@"exact-realm",_exactRealm);
    APPEND_CONFIG_INTEGER(o,@"route-selector",_routeSelector);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"router",_router);
    APPEND_DICT_STRING(o,@"destination",_destination);
    APPEND_DICT_STRING(o,@"hostname",_hostname);
    APPEND_DICT_STRING(o,@"realm",_realm);
    APPEND_DICT_INTEGER(o,@"application-id",_applicationId);
    APPEND_DICT_DOUBLE(o,@"weight",_weight);
    APPEND_DICT_DOUBLE(o,@"priority",_priority);
    APPEND_DICT_BOOLEAN(o,@"local",_local);
    APPEND_DICT_BOOLEAN(o,@"default-route",_defaultRoute);
    APPEND_DICT_BOOLEAN(o,@"exact-hostname",_exactHost);
    APPEND_DICT_BOOLEAN(o,@"exact-realm",_exactRealm);
    APPEND_DICT_INTEGER(o,@"route-selector",_routeSelector);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"router",_router);
    SET_DICT_STRING(o,@"destination",_destination);
    SET_DICT_STRING(o,@"hostname",_hostname);
    SET_DICT_STRING(o,@"realm",_realm);
    SET_DICT_INTEGER(o,@"application-id",_applicationId);
    SET_DICT_DOUBLE(o,@"weight",_weight);
    SET_DICT_DOUBLE(o,@"priority",_priority);
    SET_DICT_BOOLEAN(o,@"local",_local);
    SET_DICT_BOOLEAN(o,@"default-route",_defaultRoute);
    SET_DICT_BOOLEAN(o,@"exact-hostname",_exactHost);
    SET_DICT_BOOLEAN(o,@"exact-realm",_exactRealm);
    SET_DICT_INTEGER(o,@"route-selector",_routeSelector);

}

- (UMSS7ConfigDiameterRoute *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterRoute allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"%@/%@/%@/%@",_router,_realm,_hostname,_applicationId];
}

- (void)setName:(NSString *)str
{
}
@end


