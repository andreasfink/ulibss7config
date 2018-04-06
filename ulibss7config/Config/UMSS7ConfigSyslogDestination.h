//
//  UMSS7ConfigSyslogDestination.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSyslogDestination : UMSS7ConfigObject
{
    NSString *_host;
    NSNumber *_port;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSyslogDestination *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *host;
@property(readwrite,strong,atomic)  NSNumber *port;

@end
