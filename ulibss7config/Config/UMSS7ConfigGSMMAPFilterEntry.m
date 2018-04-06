//
//  UMSS7ConfigGSMMAPFilterEntry.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMMAPFilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMMAPFilterEntry

+ (NSString *)type
{
    return @"gsmmap-filter-entry";
}
- (NSString *)type
{
    return [UMSS7ConfigGSMMAPFilterEntry type];
}

- (UMSS7ConfigGSMMAPFilterEntry *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"filter",_filter);
    APPEND_CONFIG_STRING(s,@"result",_result);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"filter",_filter);
    APPEND_DICT_STRING(dict,@"result",_result);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"filter",_filter);
    SET_DICT_STRING(dict,@"result",_result);
}

- (UMSS7ConfigGSMMAPFilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMMAPFilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


