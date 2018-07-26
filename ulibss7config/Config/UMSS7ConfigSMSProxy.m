//
//  UMSS7ConfigSMSProxy.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSProxy.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSProxy


+ (NSString *)type
{
    return @"smsproxy";
}

- (NSString *)type
{
    return [UMSS7ConfigSMSProxy type];
}


- (UMSS7ConfigSMSProxy *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_STRING(s,@"sccp",_sccp);
    APPEND_CONFIG_STRING(s,@"license-directory",_licenseDirectory);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_STRING(dict,@"sccp",_sccp);
    APPEND_DICT_STRING(dict,@"license-directory",_licenseDirectory);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_STRING(dict,@"sccp",_sccp);
    SET_DICT_STRING(dict,@"license-directory",_licenseDirectory);
}


- (UMSS7ConfigSMSProxy *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSProxy allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



