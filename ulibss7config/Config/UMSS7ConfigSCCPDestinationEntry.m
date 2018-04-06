//
//  UMSS7ConfigSCCPDestinationGroupEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPDestinationEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCCPDestinationEntry


+ (NSString *)type
{
    return @"sccp-destination-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPDestinationEntry type];
}


- (UMSS7ConfigSCCPDestinationEntry *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"destination",_destination);
    APPEND_CONFIG_STRING(s,@"dpc",_dpc);
    APPEND_CONFIG_STRING(s,@"application-server",_applicationServer);
    APPEND_CONFIG_INTEGER(s,@"priority",_priority);
    APPEND_CONFIG_INTEGER(s,@"subsystem",_subsystem);
    APPEND_CONFIG_INTEGER(s,@"ntt",_ntt);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"destination",_destination);
    APPEND_DICT_STRING(dict,@"dpc",_dpc);
    APPEND_DICT_STRING(dict,@"application-server",_applicationServer);
    APPEND_DICT_INTEGER(dict,@"priority",_priority);
    APPEND_DICT_INTEGER(dict,@"subsystem",_subsystem);
    APPEND_DICT_INTEGER(dict,@"ntt",_ntt);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"destination",_destination);
    SET_DICT_STRING(dict,@"dpc",_dpc);
    SET_DICT_STRING(dict,@"application-server",_applicationServer);
    SET_DICT_INTEGER(dict,@"priority",_priority);
    SET_DICT_INTEGER(dict,@"subsystem",_subsystem);
    SET_DICT_INTEGER(dict,@"ntt",_ntt);
}

- (UMSS7ConfigSCCPDestinationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestinationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
