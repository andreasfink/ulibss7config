//
//  UMSS7ConfigDiameterRoute.m
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigMacros.h"

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

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"router",_router);
    APPEND_CONFIG_STRING(s,@"destination",_destination);
    APPEND_CONFIG_STRING(s,@"hostname",_hostname);
    APPEND_CONFIG_STRING(s,@"realm",_realm);
    APPEND_CONFIG_INTEGER(s,@"application-id",_applicationId);
    APPEND_CONFIG_DOUBLE(s,@"weight",_weight);
    APPEND_CONFIG_DOUBLE(s,@"priority",_priority);
    APPEND_CONFIG_BOOLEAN(s,@"local",_local);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"router",_router);
    APPEND_DICT_STRING(dict,@"destination",_destination);
    APPEND_DICT_STRING(dict,@"hostname",_hostname);
    APPEND_DICT_STRING(dict,@"realm",_realm);
    APPEND_DICT_INTEGER(dict,@"application-id",_applicationId);
    APPEND_DICT_DOUBLE(dict,@"weight",_weight);
    APPEND_DICT_DOUBLE(dict,@"priority",_priority);
    APPEND_DICT_BOOLEAN(dict,@"local",_local);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"router",_router);
    SET_DICT_STRING(dict,@"destination",_destination);
    SET_DICT_STRING(dict,@"hostname",_hostname);
    SET_DICT_STRING(dict,@"realm",_realm);
    SET_DICT_INTEGER(dict,@"application-id",_applicationId);
    SET_DICT_DOUBLE(dict,@"weight",_weight);
    SET_DICT_DOUBLE(dict,@"priority",_priority);
    SET_DICT_BOOLEAN(dict,@"local",_local);

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


