//
//  UMSS7ApiTaskDiameterRoute_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.05.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskDiameterRoute_list.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation UMSS7ApiTaskDiameterRoute_list



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

        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }
        NSString *routerName = [_webRequest.params[@"router"] urldecode];
        UMDiameterRouter *router = [_appDelegate getDiameterRouter:routerName];
        if(router == NULL)
        {
            [self sendErrorNotFound:routerName];
            return;
        }
        [self sendResultObject:[router.routes allKeys]];
    }
}

@end
