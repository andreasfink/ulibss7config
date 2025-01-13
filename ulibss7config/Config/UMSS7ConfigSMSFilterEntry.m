//
//  UMSS7ConfigSMSFilterEntry.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSFilterEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSMSFilterEntry

+ (NSString *)type
{
    return @"sms-filter-entry";
}
- (NSString *)type
{
    return [UMSS7ConfigSMSFilterEntry type];
}

- (UMSS7ConfigSMSFilterEntry *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"filter",_filter);
    APPEND_CONFIG_STRING(o,@"result",_result);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"filter",_filter);
    APPEND_DICT_STRING(o,@"result",_result);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"filter",_filter);
    SET_DICT_STRING(o,@"result",_result);
}


- (UMSS7ConfigSMSFilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSFilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


