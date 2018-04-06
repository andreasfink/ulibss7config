//
//  UMSS7ApiTaskMTP3Linkset_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Linkset_status.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3Linkset_status

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-status";
}


- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMMTP3LinkSet *mtp3Linkset = [_appDelegate getMTP3_LinkSet:name];
    if(mtp3Linkset)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict[@"active-links"] = @(mtp3Linkset.activeLinks);
        dict[@"inactive-links"] = @(mtp3Linkset.inactiveLinks);
        dict[@"ready-links"] = @(mtp3Linkset.readyLinks);
        dict[@"total-links"] = @(mtp3Linkset.totalLinks);
        dict[@"congestion-level"] = @(mtp3Linkset.congestionLevel);
        dict[@"speed"] = @(mtp3Linkset.speed);
        dict[@"trw-received"] = @(mtp3Linkset.trw_received);
        dict[@"tra-sent"] = @(mtp3Linkset.tra_sent);

        [self sendResultObject:dict];
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
