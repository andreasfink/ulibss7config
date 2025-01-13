//
//  UMSS7ConfigSMSFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSFilter.h"
#import "UMSS7ConfigSMSFilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSFilter

+ (NSString *)type
{
    return @"sms-filter";
}
- (NSString *)type
{
    return [UMSS7ConfigSMSFilter type];
}

- (UMSS7ConfigSMSFilter *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"default-result",_defaultResult);
    for(UMSS7ConfigSMSFilterEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"default-result",_defaultResult);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"default-result",_defaultResult);
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigSMSFilterEntry *entry = [[UMSS7ConfigSMSFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}

- (UMSS7ConfigSMSFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
