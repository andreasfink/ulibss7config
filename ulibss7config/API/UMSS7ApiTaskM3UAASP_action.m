//
//  UMSS7ApiTaskM3UAASP_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskM3UAASP_action

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-action";
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

        NSString *name = _params[@"name"];
        NSString *action = _params[@"action"];
        name = [UMSS7ConfigObject filterName:name];
        UMM3UAApplicationServerProcess *m3ua_asp = [_appDelegate getM3UAASP:name];
        if(m3ua_asp)
        {
        
            if([action isEqualToString:@"action-list"])
            {
                [self sendResultObject:@[ @"activate", @"deactivate", @"start",@"stop"]];
            }

            else if([action isEqualToString:@"activate"])
            {
                [m3ua_asp goActive];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"deactivate"])
            {
                [m3ua_asp goInactive];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"start"])
            {
                [m3ua_asp start];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"stop"])
            {
                [m3ua_asp stop];
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
