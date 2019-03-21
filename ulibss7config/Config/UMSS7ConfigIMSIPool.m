//
//  UMSS7ConfigIMSIPool.m
//  ulibss7config
//
//  Created by Andreas Fink on 16.07.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigIMSIPool.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigIMSIPool

+ (NSString *)type
{
    return @"imsi-pool";
}

- (NSString *)type
{
    return [UMSS7ConfigIMSIPool type];
}


- (UMSS7ConfigIMSIPool *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"imsi-prefix",_imsiPrefix);
    APPEND_CONFIG_DOUBLE(s,@"cache-timer",_cacheTimer);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    
    APPEND_DICT_STRING(dict,@"imsi-prefix",_imsiPrefix);
    APPEND_DICT_DOUBLE(dict,@"cache-timer",_cacheTimer);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"imsi-prefix",_imsiPrefix);
    SET_DICT_DOUBLE(dict,@"cache-cache",_cacheTimer);
}


- (UMSS7ConfigIMSIPool *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigIMSIPool allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

