//
//  UMSS7ConfigGSMMAP.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigGSMMAP.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigGSMMAP


+ (NSString *)type
{
    return @"gsmmap";
}

- (NSString *)type
{
    return [UMSS7ConfigGSMMAP type];
}


- (UMSS7ConfigGSMMAP *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"address",_address);
    APPEND_CONFIG_INTEGER(s,@"nai",_nai);
    APPEND_CONFIG_INTEGER(s,@"npi",_npi);
    APPEND_CONFIG_STRING(s,@"operations",_operations);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"address",_address);
    APPEND_DICT_INTEGER(dict,@"nai",_nai);
    APPEND_DICT_INTEGER(dict,@"npi",_npi);
    APPEND_DICT_STRING(dict,@"operations",_operations);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"address",_address);
    SET_DICT_INTEGER(dict,@"nai",_nai);
    SET_DICT_INTEGER(dict,@"npi",_npi);
    SET_DICT_STRING(dict,@"operations",_operations);
}

- (UMSS7ConfigGSMMAP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigGSMMAP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
