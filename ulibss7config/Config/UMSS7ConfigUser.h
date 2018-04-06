//
//  UMSS7ConfigUser.h
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigUser : UMSS7ConfigObject
{
    NSString *_password;
}

@property(readwrite,strong,atomic)      NSString *password;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigUser *)initWithConfig:(NSDictionary *)dict;

@end

