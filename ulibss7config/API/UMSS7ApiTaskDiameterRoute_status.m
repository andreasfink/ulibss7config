//
//  UMSS7ApiTaskDiameterRoute_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.05.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskDiameterRoute_status.h"
#import <ulibdiameter/ulibdiameter.h>
@implementation UMSS7ApiTaskDiameterRoute_status


+ (NSString *)apiPath
{
    return @"/api/diameter-route-list";
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
        NSString *routerName = [_webRequest.params[@"router"] urldecode];
        UMDiameterRouter *router = [_appDelegate getDiameterRouter:routerName];
        if(router == NULL)
        {
            [self sendErrorNotFound:routerName];
            return;
        }
        [self sendErrorNotImplemented];
    }
}

@end
