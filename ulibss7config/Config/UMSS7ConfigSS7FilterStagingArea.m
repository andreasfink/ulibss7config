//
//  UMSS7ConfigSS7FilterStagingArea.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterStagingArea



+ (NSString *)type
{
    return @"staging-area";
}
- (NSString *)type
{
    return [UMSS7ConfigSS7FilterStagingArea type];
}

- (UMSS7ConfigSS7FilterStagingArea *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_DATE(s,@"created-timestamp",_createdTimestamp );
    APPEND_CONFIG_DATE(s,@"modified-timestamp",_modifiedTimestamp);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    APPEND_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    SET_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);

}

- (UMSS7ConfigSS7FilterStagingArea *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSS7FilterStagingArea allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

