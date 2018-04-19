//
//  UMSS7ConfigGSMSCF.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMSCF.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMSCF

+ (NSString *)type
{
    return @"gsmscf";
}

- (NSString *)type
{
    return [UMSS7ConfigGSMSCF type];
}


- (UMSS7ConfigGSMSCF *)initWithConfig:(NSDictionary *)dict
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


- (UMSS7ConfigGSMSCF *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMSCF allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


