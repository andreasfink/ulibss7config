//
//  UMSS7ConfigDatabasePool.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigDatabasePool : UMSS7ConfigObject
{
    NSString *_host;
    NSString *_databaseName;
    NSString *_driver;
    NSString *_user;
    NSString *_pass;
    NSNumber *_port;
    NSNumber *_minSessions;
    NSNumber *_maxSessions;
    NSString *_socket;
    NSNumber *_pingIntervall;
    NSString *_storageType;
    NSString *_version;
}

@property(readwrite,strong,atomic)  NSString *host;
@property(readwrite,strong,atomic)  NSString *databaseName;
@property(readwrite,strong,atomic)  NSString *driver;
@property(readwrite,strong,atomic)  NSString *user;
@property(readwrite,strong,atomic)  NSString *pass;
@property(readwrite,strong,atomic)  NSNumber *port;
@property(readwrite,strong,atomic)  NSNumber *minSessions;
@property(readwrite,strong,atomic)  NSNumber *maxSessions;
@property(readwrite,strong,atomic)  NSString *socket;
@property(readwrite,strong,atomic)  NSNumber *pingIntervall;
@property(readwrite,strong,atomic)  NSString *storageType;
@property(readwrite,strong,atomic)  NSString *version;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDatabasePool *)initWithConfig:(NSDictionary *)dict;

@end
