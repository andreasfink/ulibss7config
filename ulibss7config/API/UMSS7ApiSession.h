//
//  UMSS7ApiSession.h
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigAdminUser.h"

@interface UMSS7ApiSession : UMObject
{
    NSString *_sessionKey;
    UMSS7ConfigAdminUser *_currentUser;
    NSString *_connectedFromIp;
    UMAtomicDate *_lastUsed;
    NSTimeInterval timeout;
}

@property(readwrite,strong,atomic) NSString *sessionKey;
@property(readwrite,strong,atomic) UMSS7ConfigAdminUser *currentUser;
@property(readwrite,strong,atomic) NSString *connectedFromIp;
@property(readwrite,strong,atomic) UMAtomicDate *lastUsed;

- (UMSS7ApiSession *)initWithHttpRequest:(UMHTTPRequest *)req user:(UMSS7ConfigAdminUser *)user;
- (void)touch;

@end
