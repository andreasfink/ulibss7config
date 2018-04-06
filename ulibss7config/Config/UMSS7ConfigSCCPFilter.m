//
//  UMSS7ConfigSCCPFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPFilter.h"
#import "UMSS7ConfigSCCPFilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCCPFilter

+ (NSString *)type
{
    return @"sccp-filter";
}
- (NSString *)type
{
    return [UMSS7ConfigSCCPFilter type];
}

- (UMSS7ConfigSCCPFilter *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"default-result",_defaultResult);
    for(UMSS7ConfigSCCPFilterEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"default-result",_defaultResult);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"default-result",_defaultResult);
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigSCCPFilterEntry *entry = [[UMSS7ConfigSCCPFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}


- (UMSS7ConfigSCCPFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

