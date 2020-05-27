//
//  UMSS7ApiTaskApiUser_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskApiUser_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskApiUser_action



+ (NSString *)apiPath
{
    return @"/api/apiuser-action";
}

- (void)main
{
    @autoreleasepool
    {
        if(![self isAuthenticated])
        {
            [self sendErrorNotAuthenticated];
            return;
        }
        if(![self isAuthorized])
        {
            [self sendErrorNotAuthorized];
            return;
        }

        NSString *name = _params[@"name"];
        name = [UMSS7ConfigObject filterName:name];
        //UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        //UMSS7ConfigServiceUser *obj = [cs getServiceUser:name];
        [self sendErrorNotImplemented];
    }
}


@end
