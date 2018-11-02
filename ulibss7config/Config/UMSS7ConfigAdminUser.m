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
    return [UMSS7ConfigUser type];
}

- (UMSS7ConfigUser *)initWithConfig:(NSDictionary *)dict
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
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"password",_password);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"password",_password);
}

- (UMSS7ConfigUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

