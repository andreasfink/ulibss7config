//
//  SS7UserAuthenticateProtocol.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>

@protocol SS7UserAuthenticateProtocol<NSObject>
- (UMHTTPAuthenticationStatus)authenticateUser:(NSString *)user pass:(NSString *)pass;
@end
