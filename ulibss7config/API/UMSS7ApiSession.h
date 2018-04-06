//
//  UMSS7ApiSession.h
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigUser.h"

@interface UMSS7ApiSession : UMObject
{
    NSString *_sessionKey;
    UMSS7ConfigUser *_currentUser;
    NSString *_connectedFromIp;
    UMAtomicDate *_lastUsed;
    NSTimeInterval timeout;
}

@property(readwrite,strong,atomic) NSString *sessionKey;
@property(readwrite,strong,atomic) UMSS7ConfigUser *currentUser;
@property(readwrite,strong,atomic) NSString *connectedFromIp;
@property(readwrite,strong,atomic) UMAtomicDate *lastUsed;

- (UMSS7ApiSession *)initWithHttpRequest:(UMHTTPRequest *)req user:(UMSS7ConfigUser *)user;
- (void)touch;

@end
