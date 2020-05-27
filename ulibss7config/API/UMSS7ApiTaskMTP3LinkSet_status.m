//
//  UMSS7ApiTaskMTP3LinkSet_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_status.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3LinkSet_status

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-status";
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
        UMMTP3LinkSet *mtp3LinkSet = [_appDelegate getMTP3LinkSet:name];
        if(mtp3LinkSet)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict[@"active-links"] = @(mtp3LinkSet.activeLinks);
            dict[@"inactive-links"] = @(mtp3LinkSet.inactiveLinks);
            dict[@"ready-links"] = @(mtp3LinkSet.readyLinks);
            dict[@"total-links"] = @(mtp3LinkSet.totalLinks);
            dict[@"congestion-level"] = @(mtp3LinkSet.congestionLevel);
            dict[@"speed"] = @(mtp3LinkSet.speed);
            dict[@"trw-received"] = @(mtp3LinkSet.trw_received);
            dict[@"tra-sent"] = @(mtp3LinkSet.tra_sent);

            [self sendResultObject:dict];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}
@end
