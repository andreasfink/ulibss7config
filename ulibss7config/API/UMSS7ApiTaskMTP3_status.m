//
//  UMSS7ApiTaskMTP3_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3_status

+ (NSString *)apiPath
{
    return @"/api/mtp3-status";
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
        UMLayerMTP3 *mtp3 = [_appDelegate getMTP3:name];
        if(mtp3)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict[@"started"] = @(mtp3.isStarted);
            if(mtp3.ready)
            {
                dict[@"status"] = @"ready";
            }
            else
            {
                dict[@"status"] = @"unknown";
            }
            dict[@"routes"] = mtp3.routeStatus;
            [self sendResultObject:dict];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}
@end
