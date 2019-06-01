//
//  UMSS7ConfigDiameterRouter.m
//  ulibss7config
//
//  Created by Andreas Fink on 27.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterRouter.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDiameterRouter

+ (NSString *)type
{
    return @"diameter-router";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterRouter type];
}


- (UMSS7ConfigDiameterRouter *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"local-hostname",_localHostName);
    APPEND_CONFIG_STRING(s,@"local-realm",_localRealm);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"local-hostname",_localHostName);
    APPEND_DICT_STRING(dict,@"local-realm",_localRealm);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"local-hostname",_localHostName);
    SET_DICT_STRING(dict,@"local-realm",_localRealm);


}

- (UMSS7ConfigDiameterRouter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterRouter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


