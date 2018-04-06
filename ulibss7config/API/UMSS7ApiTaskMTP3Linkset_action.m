//
//  UMSS7ApiTaskMTP3Linkset_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Linkset_action.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3Linkset_action

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-action";
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
    int slc = [_webRequest.params[@"lsc"] intValue];
    name = [UMSS7ConfigObject filterName:name];
    UMMTP3LinkSet *mtp3linkset = [_appDelegate getMTP3_LinkSet:name];
    if(mtp3linkset)
    {
        if([action isEqualToString:@"action-list"])
        {
            [self sendResultObject:@[ @"add-link", @"remove-link", @"power-on", @"power-off",@"start-slc",@"stop-slc"]];
        }

        else if([action isEqualToString:@"add-link"])
        {
            [self sendErrorNotImplemented];

        }
        else if([action isEqualToString:@"remove-link"])
        {
            [self sendErrorNotImplemented];
        }
        else if([action isEqualToString:@"power-on"])
        {
            [mtp3linkset powerOn];
            [self sendResultOK];

        }
        else if([action isEqualToString:@"power-off"])
        {
            [mtp3linkset powerOff];
            [self sendResultOK];
        }
        else if([action isEqualToString:@"start-slc"])
        {
            [mtp3linkset start:slc];
            [self sendResultOK];

        }
        else if([action isEqualToString:@"stop-slc"])
        {
            [mtp3linkset stop:slc];
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
