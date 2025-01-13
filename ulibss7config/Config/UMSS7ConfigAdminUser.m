//
//  UMSS7ConfigAdminUser.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigAdminUser.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigAdminUser

+ (NSString *)type
{
    return @"admin-user";
}
- (NSString *)type
{
    return [UMSS7ConfigAdminUser type];
}

- (UMSS7ConfigAdminUser *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"password",_password);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"no-auth-ip",_withoutAuthenticationIp);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"password",_password);
    APPEND_DICT_ARRAY(dict,@"no-auth-ip",_withoutAuthenticationIp);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_STRING(o,@"password",_password);
    SET_DICT_ARRAY(dict,@"no-auth-ip",_withoutAuthenticationIp);
}

- (UMSS7ConfigAdminUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigAdminUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

- (BOOL)matchesIpAddress:(NSString *)ip
{
    /* FIXME */
    return NO;
}

@end

