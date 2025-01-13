//
//  UMSS7ConfigSS7FilterTraceFile.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterTraceFile.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSS7FilterTraceFile


+ (NSString *)type
{
    return @"ss7-filter-tracefile";
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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"filename",_filename);
    APPEND_CONFIG_STRING(o,@"format",_format);
    APPEND_CONFIG_INTEGER(o,@"minutes",_minutes);
    APPEND_CONFIG_INTEGER(o,@"packets",_packets);
    APPEND_CONFIG_INTEGER(o,@"max-rotations",_maxRotations);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"filename",_filename);
    APPEND_DICT_STRING(o,@"format",_format);
    
    APPEND_DICT_INTEGER(o,@"minutes",_minutes);
    APPEND_DICT_INTEGER(o,@"packets",_packets);
    APPEND_DICT_INTEGER(o,@"max-rotations",_maxRotations);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"filename",_filename);
    SET_DICT_STRING(o,@"format",_format);
    SET_DICT_INTEGER(o,@"minutes",_minutes);
    SET_DICT_INTEGER(o,@"packets",_packets);
    SET_DICT_INTEGER(o,@"max-rotations",_maxRotations);

}

- (UMSS7ConfigSS7FilterTraceFile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSS7FilterTraceFile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
