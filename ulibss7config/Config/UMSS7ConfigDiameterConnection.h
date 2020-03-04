//
//  UMSS7ConfigDiameterConnection.h
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigDiameterConnection : UMSS7ConfigObject
{
    NSArray  *_localAddresses;
    NSArray  *_remoteAddresses;
    NSNumber *_localPort;
    NSNumber *_remotePort;
    NSString *_protocol;
    NSString *_router;
    NSNumber *_heartbeat;
    NSNumber *_mtu;
}
@property(readwrite,strong,atomic)  NSArray *localAddresses;
@property(readwrite,strong,atomic)  NSArray *remoteAddresses;
@property(readwrite,strong,atomic)  NSNumber *localPort;
@property(readwrite,strong,atomic)  NSNumber *remotePort;
@property(readwrite,strong,atomic)  NSString *protocol;
@property(readwrite,strong,atomic)  NSString *router;
@property(readwrite,strong,atomic)  NSNumber *heartbeat;
@property(readwrite,strong,atomic)  NSNumber *mtu;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict;

@end

