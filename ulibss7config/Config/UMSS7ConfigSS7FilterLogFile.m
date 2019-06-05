//
//  UMSS7ConfigSS7FilterLogFile.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterLogFile.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterLogFile


+ (NSString *)type
{
    return @"ss7-filter-logfile";
}

- (NSString *)type
{
    return [UMSS7ConfigSS7FilterLogFile type];
}


- (UMSS7ConfigSS7FilterLogFile *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"filename",_filename);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"filename",_filename);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"filename",_filename);
}

- (UMSS7ConfigSS7FilterLogFile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSS7FilterLogFile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
