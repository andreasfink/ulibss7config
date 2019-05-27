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
    NSString *_attachTo;
    NSString *_diameterRouter;
//	NSString *_tcpRemoteHost;
//	NSNumber *_tcpRemotePort;
}
@property(readwrite,strong,atomic)      NSString *attachTo;
@property(readwrite,strong,atomic)      NSString *diameterRouter;
// @property(readwrite,strong,atomic)      NSString *tcpRemoteHost;
// @property(readwrite,strong,atomic)      NSNumber *tcpRemotePort;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict;

@end

