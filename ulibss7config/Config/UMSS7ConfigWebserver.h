//
//  UMSS7ConfigWebserver.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigWebserver : UMSS7ConfigObject
{
    NSNumber            *_port;
    NSNumber            *_https;
    NSString            *_httpsKeyFile;
    NSString            *_httpsCertFile;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigWebserver *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)      NSNumber            *port;
@property(readwrite,strong,atomic)      NSString            *httpUser;
@property(readwrite,strong,atomic)      NSString            *httpPassword;
@property(readwrite,strong,atomic)      NSNumber            *https;
@property(readwrite,strong,atomic)      NSString            *httpsKeyFile;
@property(readwrite,strong,atomic)      NSString            *httpsCertFile;

@end


