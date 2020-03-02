//
//  UMSS7ConfigDiameterConnection.m
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterConnection.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDiameterConnection

+ (NSString *)type
{
    return @"diameter-connection";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterConnection type];
}


- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"attach-initiator-to",_attachInitiatorTo);
    APPEND_CONFIG_STRING(s,@"attach-responder-to",_attachResponderTo);
    APPEND_CONFIG_STRING(s,@"router",_router);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"attach-initiator-to",_attachInitiatorTo);
    APPEND_DICT_STRING(dict,@"attach-responder-to",_attachResponderTo);
    APPEND_DICT_STRING(dict,@"router",_router);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-initiator-to",_attachInitiatorTo);
    SET_DICT_STRING(dict,@"attach-responder-to",_attachResponderTo);
    SET_DICT_STRING(dict,@"router",_router);
}

- (UMSS7ConfigDiameterConnection *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterConnection allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


