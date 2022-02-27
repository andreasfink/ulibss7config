//
//  UMSS7ConfigSCCPDestination.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPDestination.h"
#import "UMSS7ConfigMacros.h"
#import "UMSS7ConfigSCCPDestinationEntry.h"

@implementation UMSS7ConfigSCCPDestination

+ (NSString *)type
{
    return @"sccp-destination";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPDestination type];
}


- (UMSS7ConfigSCCPDestination *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"sccp",_sccp);
    APPEND_CONFIG_STRING(s,@"post-translation",_postTranslation);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"sccp",_sccp);
    APPEND_DICT_STRING(dict,@"post-translation",_postTranslation);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"sccp",_sccp);
    SET_DICT_STRING(dict,@"post-translation",_postTranslation);
}

- (UMSS7ConfigSCCPDestination *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestination allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
