//
//  UMSS7ConfigUser.h
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigUser : UMSS7ConfigObject
{
    NSString *_password;
    NSString *_userProfile;
    NSString *_billingEntity;
}

@property(readwrite,strong,atomic)      NSString *password;
@property(readwrite,strong,atomic)      NSString *userProfile;
@property(readwrite,strong,atomic)      NSString *billingEntity;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigUser *)initWithConfig:(NSDictionary *)dict;

@end
