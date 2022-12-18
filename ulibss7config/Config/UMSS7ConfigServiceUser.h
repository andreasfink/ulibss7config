//
//  UMSS7ConfigServiceUser.h
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigServiceUser : UMSS7ConfigObject
{
    NSString *_password;
    NSString *_useroptions;
    NSString *_groupname;
    NSString *_shortId;
    NSNumber *_speedLimit;
    NSString *_billingEntity;
}

@property(readwrite,strong,atomic)      NSString *password;
@property(readwrite,strong,atomic)      NSString *useroptions;
@property(readwrite,strong,atomic)      NSString *groupname;
@property(readwrite,strong,atomic)      NSNumber *speedLimit;
@property(readwrite,strong,atomic)      NSString *billingEntity;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigServiceUser *)initWithConfig:(NSDictionary *)dict;

@end
