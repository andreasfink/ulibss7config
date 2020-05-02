//
//  UMSS7ConfigDiameterRoute.h
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigDiameterRoute : UMSS7ConfigObject
{
    NSString *_router;
    NSString *_destination;
    NSString *_hostname;
    NSString *_realm;
    NSNumber *_applicationId;
    NSNumber *_weight;
    NSNumber *_priority;
    NSNumber *_local;
    NSNumber *_defaultRoute;
    NSNumber *_exactHost;
    NSNumber *_exactRealm;
}

+ (NSString *)type;
- (NSString *)type;

@property(readwrite,strong,atomic)  NSString *router;
@property(readwrite,strong,atomic)  NSString *destination;
@property(readwrite,strong,atomic)  NSString *hostname;
@property(readwrite,strong,atomic)  NSString *realm;
@property(readwrite,strong,atomic)  NSNumber *applicationId;
@property(readwrite,strong,atomic)  NSNumber *weight;
@property(readwrite,strong,atomic)  NSNumber *priority;
@property(readwrite,strong,atomic)  NSNumber *local;
@property(readwrite,strong,atomic)  NSNumber *defaultRoute;
@property(readwrite,strong,atomic)  NSNumber *exactHost;
@property(readwrite,strong,atomic)  NSNumber *exactRealm;

@end

