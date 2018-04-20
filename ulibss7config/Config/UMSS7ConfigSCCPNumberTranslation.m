//
//  UMSS7ConfigSCCPNumberTranslation.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPNumberTranslation.h"
#import "UMSS7ConfigMacros.h"
#import "UMSS7ConfigSCCPNumberTranslationEntry.h"

@implementation UMSS7ConfigSCCPNumberTranslation


+ (NSString *)type
{
    return @"sccp-number-translation";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPNumberTranslation type];
}


- (UMSS7ConfigSCCPNumberTranslation *)initWithConfig:(NSDictionary *)dict
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
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
}

- (UMSS7ConfigSCCPNumberTranslation *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPNumberTranslation allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
