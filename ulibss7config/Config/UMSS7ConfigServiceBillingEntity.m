//
//  UMSS7ConfigServiceBillingEntity.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigServiceBillingEntity.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigServiceBillingEntity


+ (NSString *)type
{
    return @"service-billing-entity";
}
- (NSString *)type
{
    return [UMSS7ConfigServiceBillingEntity type];
}

- (UMSS7ConfigServiceBillingEntity *)initWithConfig:(NSDictionary *)dict
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

    APPEND_CONFIG_BOOLEAN(o,@"do-bill",_doBill);
    APPEND_CONFIG_BOOLEAN(o,@"credit-enforced",_blockIfOutOfCredit);
    APPEND_CONFIG_DOUBLE(o,@"credit-limit",_creditLimit);
    APPEND_CONFIG_STRING(o,@"price-table",_priceTable);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];


    APPEND_DICT_BOOLEAN(o,@"do-bill",_doBill);
    APPEND_DICT_BOOLEAN(o,@"credit-enforced",_blockIfOutOfCredit);
    APPEND_DICT_DOUBLE(o,@"credit-limit",_creditLimit);
    APPEND_DICT_STRING(o,@"price-table",_priceTable);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_BOOLEAN(o,@"do-bill",_doBill);
    SET_DICT_BOOLEAN(o,@"credit-enforced",_blockIfOutOfCredit);
    SET_DICT_DOUBLE(o,@"credit-limit",_creditLimit);
    SET_DICT_STRING(o,@"price-table",_priceTable);
}

- (UMSS7ConfigServiceBillingEntity *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigServiceBillingEntity allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end
