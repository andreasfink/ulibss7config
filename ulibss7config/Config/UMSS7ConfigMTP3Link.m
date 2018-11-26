//
//  UMSS7ConfigMtp3Link.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Link.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3Link


+ (NSString *)type
{
    return @"mtp3-link";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3Link type];
}


- (UMSS7ConfigMTP3Link *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"mtp3-linkset",_mtp3Linkset);
    APPEND_CONFIG_STRING(s,@"m2pa",_m2pa);
    APPEND_CONFIG_INTEGER(s,@"slc",_slc);
    APPEND_CONFIG_DOUBLE(s,@"link-test-time",_linkTestTime);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"mtp3-linkset",_mtp3Linkset);
    APPEND_DICT_STRING(dict,@"m2pa",_m2pa);
    APPEND_DICT_INTEGER(dict,@"slc",_slc);
    APPEND_DICT_DOUBLE(dict,@"link-test-time",_linkTestTime);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"mtp3-linkset",_mtp3Linkset);
    SET_DICT_STRING(dict,@"m2pa",_m2pa);
    SET_DICT_INTEGER(dict,@"slc",_slc);
    SET_DICT_DOUBLE(dict,@"link-test-time",_linkTestTime);
}

- (UMSS7ConfigMTP3Link *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Link allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end
