//
//  UMSS7ApiTaskMTP3_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3_action

+ (NSString *)apiPath
{
    return @"/api/mtp3-action";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _webRequest.params[@"name"];
    NSString *action = _webRequest.params[@"action"];
    name = [UMSS7ConfigObject filterName:name];
    UMLayerMTP3 *mtp3 = [_appDelegate getMTP3:name];
    if(mtp3)
    {
        if([action isEqualToString:@"action-list"])
        {
            [self sendResultObject:@[ @"start", @"stop"]];
        }

        else if([action isEqualToString:@"start"])
        {
            [mtp3 start];
            [self sendResultOK];

        }
        else if([action isEqualToString:@"stop"])
        {
            [mtp3 stop];
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
