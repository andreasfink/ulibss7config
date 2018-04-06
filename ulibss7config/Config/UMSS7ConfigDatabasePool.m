//
//  UMSS7ConfigDatabasePool.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDatabasePool.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDatabasePool

+ (NSString *)type
{
    return @"database-pool";
}

- (NSString *)type
{
    return [UMSS7ConfigDatabasePool type];
}


- (UMSS7ConfigDatabasePool *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"attach-to",_attachTo);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
}


- (UMSS7ConfigDatabasePool *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDatabasePool allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



