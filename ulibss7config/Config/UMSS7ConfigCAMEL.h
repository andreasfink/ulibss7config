//
//  UMSS7ConfigCAMEL.h
//  ulibss7config
//
//  Created by Andreas Fink on 09.03.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>


@interface UMSS7ConfigCAMEL : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSString *_address;
    NSString *_ssn;
    NSNumber *_timeout;
    NSNumber *_defaultCalledTT;
}


@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *address;
@property(readwrite,strong,atomic)  NSString *ssn;
@property(readwrite,strong,atomic)  NSNumber *timeout;
@property(readwrite,strong,atomic)  NSNumber *defaultCalledTT;

+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigCAMEL *)initWithConfig:(NSDictionary *)dict;


@end


