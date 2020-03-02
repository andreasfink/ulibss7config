//
//  UMSS7ApiTaskConfig_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 02.03.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskConfig_action.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskConfig_action


+ (NSString *)apiPath
{
    return @"/api/config-action";
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

    NSString *action = _params[@"action"];
    if([action isEqualToString:@"action-list"])
    {
        [self sendResultObject:@[ @"save"]];
    }
    else if([action isEqualToString:@"save"])
    {
        NSString *s = [_appDelegate writeCurrentConfigurationToStartup];
        if(s==NULL)
        {
            [self sendResultOK];
        }
        else
        {
            [self sendError:s];
        }
    }
    else
    {
        [self sendErrorUnknownAction];
    }
}
@end

