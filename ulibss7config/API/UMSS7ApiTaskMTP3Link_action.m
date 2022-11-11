//
//  UMSS7ApiTaskMTP3Link_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Link_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3Link_action

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-action";
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
        NSString *action = _params[@"action"];
        name = [UMSS7ConfigObject filterName:name];
        UMMTP3Link *mtp3link = [_appDelegate getMTP3Link:name];
        if(mtp3link)
        {
            if([action isEqualToString:@"action-list"])
            {
                [self sendResultObject:@[ @"start", @"stop"]];
            }

            else if([action isEqualToString:@"start"])
            {
                [mtp3link start];
                [self sendResultOK];

            }
            else if([action isEqualToString:@"stop"])
            {
                [mtp3link stop];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"power-on"])
            {
                [mtp3link powerOn:@"api-action"];
                [self sendResultOK];

            }
            else if([action isEqualToString:@"power-off"])
            {
                [mtp3link powerOff:@"api-action"];
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
}
@end
