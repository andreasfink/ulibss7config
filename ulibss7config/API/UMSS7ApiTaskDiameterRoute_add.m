//
//  UMSS7ApiTaskDiameterRoute_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.05.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskDiameterRoute_add.h"
#import <ulibdiameter/ulibdiameter.h>
#import "UMSS7ApiTaskMacros.h"
#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskDiameterRoute_add


+ (NSString *)apiPath
{
    return @"/api/diameter-route-add";
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
        UMSS7ConfigDiameterRoute *routeconfig = [[UMSS7ConfigDiameterRoute alloc]initWithConfig:_params];
        [_appDelegate.runningConfig addDiameterRoute:routeconfig];
        UMSynchronizedSortedDictionary *d = [routeconfig config];
        NSDictionary *dict = [d dictionaryCopy];
        [router addRouteFromConfig:dict];
        [self sendResultObject:routeconfig];
    }
}

@end
