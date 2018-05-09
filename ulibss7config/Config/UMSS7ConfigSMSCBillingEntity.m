//
//  UMSS7ConfigSMSCBillingEntity.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSCBillingEntity.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSCBillingEntity


+ (NSString *)type
{
    return @"billing-entity";
}
- (NSString *)type
{
    return [UMSS7ConfigSMSCBillingEntity type];
}

- (UMSS7ConfigSMSCBillingEntity *)initWithConfig:(NSDictionary *)dict
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

    APPEND_CONFIG_BOOLEAN(s,@"do-bill",_doBill);
    APPEND_CONFIG_BOOLEAN(s,@"credit-enforced",_blockIfOutOfCredit);
    APPEND_CONFIG_DOUBLE(s,@"credit-limit",_creditLimit);
    APPEND_CONFIG_STRING(s,@"price-table",_priceTable);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];


    APPEND_DICT_BOOLEAN(dict,@"do-bill",_doBill);
    APPEND_DICT_BOOLEAN(dict,@"credit-enforced",_blockIfOutOfCredit);
    APPEND_DICT_DOUBLE(dict,@"credit-limit",_creditLimit);
    APPEND_DICT_STRING(dict,@"price-table",_priceTable);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_BOOLEAN(dict,@"do-bill",_doBill);
    SET_DICT_BOOLEAN(dict,@"credit-enforced",_blockIfOutOfCredit);
    SET_DICT_DOUBLE(dict,@"credit-limit",_creditLimit);
    SET_DICT_STRING(dict,@"price-table",_priceTable);
}

- (UMSS7ConfigSMSCBillingEntity *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSCBillingEntity allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
