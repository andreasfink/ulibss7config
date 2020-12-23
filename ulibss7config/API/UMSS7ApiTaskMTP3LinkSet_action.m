//
//  UMSS7ApiTaskMTP3LinkSet_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_action.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3LinkSet_action

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-action";
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
        int slc = [_params[@"lsc"] intValue];
        name = [UMSS7ConfigObject filterName:name];
        UMMTP3LinkSet *mtp3linkset = [_appDelegate getMTP3LinkSet:name];
        if(mtp3linkset)
        {
            if([action isEqualToString:@"action-list"])
            {
                [self sendResultObject:@[ @"add-link",
                                          @"remove-link",
                                          @"power-on",
                                          @"power-off",
                                          @"forced-power-on",
                                          @"forced-power-off",
                                          @"start-slc",
                                          @"stop-slc",
                                          @"open-mtp3-screening-trace",
                                          @"close-mtp3-screening-trace",
                                          @"open-sccp-screening-trace",
                                          @"close-sccp-screening-trace",
                                          @"set-mtp3-screening-trace-level-none",
                                          @"set-mtp3-screening-trace-level-rejected-only",
                                          @"set-mtp3-screening-trace-level-everything",
                                          @"set-sccp-screening-trace-level-none",
                                          @"set-sccp-screening-trace-level-rejected-only",
                                          @"set-sccp-screening-trace-level-everything",
                                          ]];
            }
            else if([action isEqualToString:@"add-link"])
            {
                [self sendErrorNotImplemented];

            }
            else if([action isEqualToString:@"remove-link"])
            {
                [self sendErrorNotImplemented];
            }
            else if(([action isEqualToString:@"power-on"]) || ([action isEqualToString:@"start"]))

            {
                [mtp3linkset powerOn];
                [self sendResultOK];
            }
            else if(([action isEqualToString:@"power-off"]) || ([action isEqualToString:@"stop"]))
            {
                [mtp3linkset powerOff];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"forced-power-off"])
            {
                [mtp3linkset forcedPowerOff];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"forced-power-on"])
            {
                [mtp3linkset forcedPowerOn];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"open-mtp3-screening-trace"])
            {
                [mtp3linkset openMtp3ScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-mtp3-screening-trace"])
            {
                [mtp3linkset closeMtp3ScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"open-sccp-screening-trace"])
            {
                [mtp3linkset openSccpScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-sccp-screening-trace"])
            {
                [mtp3linkset closeSccpScreeningTraceFile];
                [self sendResultOK];
            }

            else if([action isEqualToString:@"set-mtp3-screening-trace-level-none"])
            {
                mtp3linkset.mtp3ScreeningTraceLevel = UMMTP3ScreeningTraceLevel_none;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-mtp3-screening-trace-level-rejected-only"])
            {
                mtp3linkset.mtp3ScreeningTraceLevel = UMMTP3ScreeningTraceLevel_rejected_only;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-mtp3-screening-trace-level-everything"])
            {
                mtp3linkset.mtp3ScreeningTraceLevel = UMMTP3ScreeningTraceLevel_everything;
                [self sendResultOK];
            }

            
            else if([action isEqualToString:@"set-sccp-screening-trace-level-none"])
            {
                mtp3linkset.sccpScreeningTraceLevel = UMMTP3ScreeningTraceLevel_none;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-sccp-screening-trace-level-rejected-only"])
            {
                mtp3linkset.sccpScreeningTraceLevel = UMMTP3ScreeningTraceLevel_rejected_only;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-sccp-screening-trace-level-everything"])
            {
                mtp3linkset.sccpScreeningTraceLevel = UMMTP3ScreeningTraceLevel_everything;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-mtp3-screening-trace"])
            {
                [mtp3linkset closeMtp3ScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"open-sccp-screening-trace"])
            {
                [mtp3linkset openSccpScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-sccp-screening-trace"])
            {
                [mtp3linkset closeSccpScreeningTraceFile];
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
}

@end
