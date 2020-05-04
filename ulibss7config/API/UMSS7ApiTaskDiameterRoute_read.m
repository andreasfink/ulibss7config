//
//  UMSS7ApiTaskDiameterRoute_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.05.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskDiameterRoute_read.h"
#import <ulibdiameter/ulibdiameter.h>
#import "UMSS7ApiTaskMacros.h"
#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskDiameterRoute_read

+ (NSString *)apiPath
{
    return @"/api/diameter-route-read";
}

- (void)main
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
    
    [self sendResultObject:router.routes[name]];
}
@end
