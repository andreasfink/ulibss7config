//
//  UMSS7ApiSession.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiSession.h"

@implementation UMSS7ApiSession

-(UMSS7ApiSession *)initWithHttpRequest:(UMHTTPRequest *)req user:(UMSS7ConfigApiUser *)user
{
    self = [super init];
    if(self)
    {
        _sessionKey = [UMUUID UUID];
        _currentUser = user;
        _connectedFromIp = req.connection.socket.connectedRemoteAddress;
        _lastUsed = [[UMAtomicDate alloc]init];
    }
    return self;
}


- (void)touch
{
    [_lastUsed touch];
}

@end

