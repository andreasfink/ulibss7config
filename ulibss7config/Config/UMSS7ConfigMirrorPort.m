//
//  UMSS7ConfigMirrorPort.m
//  ulibss7config
//
//  Created by Andreas Fink on 09.05.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMirrorPort.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMirrorPort

+ (NSString *)type
{
    return @"mirror-port";
}

- (NSString *)type
{
    return [UMSS7ConfigMirrorPort type];
}

- (UMSS7ConfigMirrorPort *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"interface-name",_interfaceName);
    APPEND_CONFIG_STRING(o,@"local-mac-address",_localMacAddress);
    APPEND_CONFIG_STRING(o,@"remote-mac-address",_remoteMacAddress);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"interface-name",_interfaceName);
    APPEND_DICT_STRING(o,@"local-mac-address",_localMacAddress);
    APPEND_DICT_STRING(o,@"remote-mac-address",_remoteMacAddress);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"interface-name",_interfaceName);
    SET_DICT_STRING(o,@"local-mac-address",_localMacAddress);
    SET_DICT_STRING(o,@"remote-mac-address",_remoteMacAddress);
}

- (UMSS7ConfigMirrorPort *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMirrorPort allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


