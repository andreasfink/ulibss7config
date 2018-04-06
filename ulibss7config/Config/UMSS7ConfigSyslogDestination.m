//
//  UMSS7ConfigSyslogDestination.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSyslogDestination.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSyslogDestination

+ (NSString *)type
{
    return @"syslog-destination";
}
- (NSString *)type
{
    return [UMSS7ConfigSyslogDestination type];
}

- (UMSS7ConfigSyslogDestination *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"host",_host);
    APPEND_CONFIG_INTEGER(s,@"port",_port);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"host",_host);
    APPEND_DICT_INTEGER(dict,@"port",_port);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"host",_host);
    SET_DICT_INTEGER(dict,@"port",_port);
}

- (UMSS7ConfigSyslogDestination*)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSyslogDestination allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

