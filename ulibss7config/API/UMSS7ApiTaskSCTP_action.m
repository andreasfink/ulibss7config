//
//  UMSS7ApiTaskSCTP_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibsctp/ulibsctp.h>

@implementation UMSS7ApiTaskSCTP_action

+ (NSString *)apiPath
{
    return @"/api/sctp-action";
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

    NSString *name = _params[@"name"];
    NSString *action = _params[@"action"];
    name = [UMSS7ConfigObject filterName:name];
    UMLayerSctp *sctp = [_appDelegate getSCTP:name];
    if(sctp)
    {
        if([action isEqualToString:@"action-list"])
        {
            if(sctp.status==SCTP_STATUS_IS)
            {
                if([sctp.stopButtonPressed timeIntervalSinceNow] < 15)
                {
                    [self sendResultObject:@[ @"!start", @"!stop in progress"]];
                }
                else
                {
                    [self sendResultObject:@[ @"!start", @"stop"]];
                }
            }
            else
            {
                if([sctp.startButtonPressed timeIntervalSinceNow] < 15)
                {
                    [self sendResultObject:@[ @"!start in progress", @"!stop"]];

                }
                else
                {
                    [self sendResultObject:@[ @"start", @"!stop"]];
                }
            }
        }
        else if([action isEqualToString:@"start"])
        {
            [sctp isFor:NULL];
            [self sendResultOK];

        }
        else if([action isEqualToString:@"stop"])
        {
            [sctp foosFor:NULL];
            [self sendResultOK];
        }
        else
        {
            [self sendErrorUnknownAction];
        }
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
