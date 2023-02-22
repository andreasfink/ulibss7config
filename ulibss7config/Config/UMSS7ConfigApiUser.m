//
//  UMSS7ConfigApiUser.m
//  ulibss7config
//
//  Created by Andreas Fink on 01.01.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigApiUser

+ (NSString *)type
{
    return @"api-user";
}
- (NSString *)type
{
    return [UMSS7ConfigApiUser type];
}

- (UMSS7ConfigApiUser *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"password",_password);
    APPEND_CONFIG_STRING(s,@"profile",_profile);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"allowed-address",_allowedAddresses); /* this will write multipe permitted-address=.. lines */
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"password",_password);
    APPEND_DICT_STRING(dict,@"profile",_profile);
    APPEND_DICT_ARRAY(dict,@"allowed-address",_allowedAddresses);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"password",_password);
    SET_DICT_STRING(dict,@"profile",_profile);
    SET_DICT_ARRAY(dict,@"allowed-address",_allowedAddresses);
}

- (UMSS7ConfigApiUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigApiUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

