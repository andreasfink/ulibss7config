//
//  UMSS7ConfigApiUser.h
//  ulibss7config
//
//  Created by Andreas Fink on 01.01.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigApiUser : UMSS7ConfigObject
{
    NSString *_password;
    NSString *_profile;
    NSArray<NSString *>*_allowedAddresses;
    
}

@property(readwrite,strong,atomic)      NSString *password;
@property(readwrite,strong,atomic)      NSString *profile;
@property(readwrite,strong,atomic)      NSArray<NSString *>*allowedAddresses;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigApiUser *)initWithConfig:(NSDictionary *)dict;

@end

