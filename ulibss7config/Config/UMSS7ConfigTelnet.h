//
//  UMSS7ConfigTelnet.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigTelnet : UMSS7ConfigObject
{
    NSNumber *_port;
    NSString *_telnetUsername;
    NSString *_telnetPassword;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigTelnet *)initWithConfig:(NSDictionary *)dict;


@property(readwrite,strong,atomic)  NSNumber *port;
@property(readwrite,strong,atomic)  NSString *telnetUsername;
@property(readwrite,strong,atomic)  NSString *telnetPassword;

@end
