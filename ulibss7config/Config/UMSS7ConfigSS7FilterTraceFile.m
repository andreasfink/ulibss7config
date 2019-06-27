//
//  UMSS7ConfigSS7FilterTraceFile.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterTraceFile.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterTraceFile


+ (NSString *)type
{
    return @"ss7-filter-logfile";
}

- (NSString *)type
{
    return [UMSS7ConfigSS7FilterTraceFile type];
}


- (UMSS7ConfigSS7FilterTraceFile *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"format",_format);
    APPEND_CONFIG_INTEGER(s,@"minutes",_minutes);
    APPEND_CONFIG_INTEGER(s,@"packets",_packets);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"filename",_filename);
    APPEND_DICT_STRING(dict,@"format",_format);
    
    APPEND_DICT_INTEGER(dict,@"minutes",_minutes);
    APPEND_DICT_INTEGER(dict,@"packets",_packets);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"filename",_filename);
    SET_DICT_STRING(dict,@"format",_format);
    SET_DICT_INTEGER(dict,@"minutes",_minutes);
    SET_DICT_INTEGER(dict,@"packets",_packets);
    
}

- (UMSS7ConfigSS7FilterTraceFile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSS7FilterTraceFile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
