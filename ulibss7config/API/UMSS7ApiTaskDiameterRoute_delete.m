//
//  UMSS7ApiTaskDiameterRoute_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.05.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskDiameterRoute_delete.h"
#import <ulibdiameter/ulibdiameter.h>
#import "UMSS7ApiTaskMacros.h"
#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskDiameterRoute_delete


+ (NSString *)apiPath
{
    return @"/api/diameter-route-delete";
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
        NSString *name       = [_webRequest.params[@"name"] urldecode];
        
        UMDiameterRouter *router = [_appDelegate getDiameterRouter:routerName];
        if(router == NULL)
        {
            [self sendErrorNotFound:routerName];
            return;
        }
        
        UMDiameterRoute *route = router.routes[name];
        if(route == NULL)
        {
            [self sendErrorNotFound:name];
            return;
        }
        /* FIXME: delete runningConfig and route object in parallel here */
        [self sendErrorNotImplemented];
    }
}
@end
