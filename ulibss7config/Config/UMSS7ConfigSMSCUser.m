//
//  UMSS7ConfigSMSCUser.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSCUser.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSCUser

+ (NSString *)type
{
    return @"smsc-user";
}
- (NSString *)type
{
    return [UMSS7ConfigSMSCUser type];
}

- (UMSS7ConfigSMSCUser *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"profile",_userProfile);
    APPEND_CONFIG_STRING(s,@"billing-entity",_billingEntity);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"password",_password);
    APPEND_DICT_STRING(dict,@"profile",_userProfile);
    APPEND_DICT_STRING(dict,@"billing-entity",_billingEntity);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"password",_password);
    SET_DICT_STRING(dict,@"profile",_userProfile);
    SET_DICT_STRING(dict,@"billing-entity",_billingEntity);
}

- (UMSS7ConfigSMSCUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSCUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
