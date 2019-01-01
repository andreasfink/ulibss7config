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

- (UMSS7ConfigApiUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigApiUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

