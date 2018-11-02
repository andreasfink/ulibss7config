//
//  UMSS7ConfigBillingEntity.h
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigBillingEntity : UMSS7ConfigObject
{
    NSNumber *_doBill;
    NSNumber *_blockIfOutOfCredit;
    NSNumber *_creditLimit;;
    NSString *_priceTable;
}

@property(readwrite,strong,atomic)      NSNumber *doBill;
@property(readwrite,strong,atomic)      NSNumber *blockIfOutOfCredit;
@property(readwrite,strong,atomic)      NSNumber *creditLimit;;
@property(readwrite,strong,atomic)      NSString *priceTable;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigBillingEntity *)initWithConfig:(NSDictionary *)dict;

@end
