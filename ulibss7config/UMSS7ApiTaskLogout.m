//
//  UMSS7ApiTaskLogout.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskLogout.h"

@implementation UMSS7ApiTaskLogout


+ (NSString *)apiPath
{
    return @"/api/logout";
}

- (void)main
{
    @autoreleasepool
    {

        if([self isAuthenticated])
        {
			NSString *session_key = _params[@"session-key"];
			if(session_key.length > 0)
			{
				[_appDelegate removeApiSession:session_key];
				[self sendResultOK];
				return;
			}
        }
        [self sendErrorNotAuthenticated];
    }
}

@end
