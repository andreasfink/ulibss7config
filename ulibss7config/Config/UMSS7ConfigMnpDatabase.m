//
//  UMSS7ConfigMnpDatabase.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.06.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMnpDatabase.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMnpDatabase

+ (NSString *)type
{
    return @"mnp-database";
}

- (NSString *)type
{
    return [UMSS7ConfigMnpDatabase type];
}

- (UMSS7ConfigMnpDatabase *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"database-pool",_dbPool);
    APPEND_CONFIG_STRING(s,@"database-table",_dbTable);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"database-pool",_dbPool);
    APPEND_DICT_STRING(dict,@"database-table",_dbTable);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"database-pool",_dbPool);
    SET_DICT_STRING(dict,@"database-table",_dbTable);


}

- (UMSS7ConfigMnpDatabase *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMnpDatabase allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


