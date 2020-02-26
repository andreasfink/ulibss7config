//
//  UMSS7ApiSession.h
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigApiUser.h"

@interface UMSS7ApiSession : UMObject
{
    NSString *_sessionKey;
    UMSS7ConfigApiUser *_currentUser;
    NSString *_connectedFromIp;
    UMAtomicDate *_firstUsed;
    UMAtomicDate *_lastUsed;
    NSTimeInterval _timeout;
	NSString *_currentStorageAreaName;
}

@property(readwrite,strong,atomic) NSString *sessionKey;
@property(readwrite,strong,atomic) UMSS7ConfigApiUser *currentUser;
@property(readwrite,strong,atomic) NSString *connectedFromIp;
@property(readwrite,strong,atomic) UMAtomicDate *firstUsed;
@property(readwrite,strong,atomic) UMAtomicDate *lastUsed;
@property(readwrite,assign,atomic) NSTimeInterval timeout;
@property(readwrite,strong,atomic) NSString 		*currentStorageAreaName;

- (UMSS7ApiSession *)initWithHttpRequest:(UMHTTPRequest *)req user:(UMSS7ConfigApiUser *)user;
- (void)touch;

@end
