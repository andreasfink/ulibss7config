//
//  SS7TelnetSocketHelperProtocol.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>

@protocol SS7TelnetSocketHelperProtocol<NSObject>

- (BOOL) isAddressWhitelisted:(NSString *)ipAddress;

@end
