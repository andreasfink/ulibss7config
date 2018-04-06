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
/*
- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    for(UMSS7ConfigSCCPDestinationEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }
}

*/


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

- (UMSS7ConfigSCCPDestination *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestination allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
