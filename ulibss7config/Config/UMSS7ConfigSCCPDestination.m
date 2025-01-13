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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"sccp",_sccp);
    APPEND_CONFIG_STRING(o,@"post-translation",_postTranslation);
    APPEND_CONFIG_STRING(o,@"distribution-method",_distributionMethod);


}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"sccp",_sccp);
    APPEND_DICT_STRING(o,@"post-translation",_postTranslation);
    APPEND_DICT_STRING(o,@"distribution-method",_distributionMethod);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"sccp",_sccp);
    SET_DICT_STRING(o,@"post-translation",_postTranslation);
    SET_DICT_STRING(o,@"distribution-method",_distributionMethod);
}

- (UMSS7ConfigSCCPDestination *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestination allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
