//
//  UMSS7ApiTaskM3UAAS_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAAS_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskM3UAAS_action

+ (NSString *)apiPath
{
    return @"/api/m3ua-as-action";
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
        NSString *name = _params[@"name"];
        NSString *action = _params[@"action"];
        name = [UMSS7ConfigObject filterName:name];
        UMM3UAApplicationServer *m3ua_as = [_appDelegate getM3UAAS:name];
        if(m3ua_as)
        {
            if([action isEqualToString:@"action-list"])
            {
                [self sendResultObject:@[ @"activate",
                                          @"deactivate",
                                          @"start",
                                          @"stop",
                                          @"forced-power-on",
                                          @"forced-power-off",
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
                                          ]];          }

            else if([action isEqualToString:@"activate"])
            {
                [m3ua_as activate];
                [self sendResultOK];

            }
            else if([action isEqualToString:@"deactivate"])
            {
                [m3ua_as deactivate];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"start"])
            {
                [m3ua_as aspUp:NULL reason:@"api-start"];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"stop"])
            {
                [m3ua_as aspDown:NULL reason:@"api-stop"];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"forced-power-on"])
            {
                [m3ua_as forcedPowerOn];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"forced-power-off"])
            {
                [m3ua_as forcedPowerOff];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"open-mtp3-screening-trace"])
            {
                [m3ua_as openMtp3ScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-mtp3-screening-trace"])
            {
                [m3ua_as closeMtp3ScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"open-sccp-screening-trace"])
            {
                [m3ua_as openSccpScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-sccp-screening-trace"])
            {
                [m3ua_as closeSccpScreeningTraceFile];
                [self sendResultOK];
            }

            else if([action isEqualToString:@"set-mtp3-screening-trace-level-none"])
            {
                m3ua_as.mtp3ScreeningTraceLevel = UMMTP3ScreeningTraceLevel_none;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-mtp3-screening-trace-level-rejected-only"])
            {
                m3ua_as.mtp3ScreeningTraceLevel = UMMTP3ScreeningTraceLevel_rejected_only;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-mtp3-screening-trace-level-everything"])
            {
                m3ua_as.mtp3ScreeningTraceLevel = UMMTP3ScreeningTraceLevel_everything;
                [self sendResultOK];
            }

            
            else if([action isEqualToString:@"set-sccp-screening-trace-level-none"])
            {
                m3ua_as.sccpScreeningTraceLevel = UMMTP3ScreeningTraceLevel_none;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-sccp-screening-trace-level-rejected-only"])
            {
                m3ua_as.sccpScreeningTraceLevel = UMMTP3ScreeningTraceLevel_rejected_only;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"set-sccp-screening-trace-level-everything"])
            {
                m3ua_as.sccpScreeningTraceLevel = UMMTP3ScreeningTraceLevel_everything;
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-mtp3-screening-trace"])
            {
                [m3ua_as closeMtp3ScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"open-sccp-screening-trace"])
            {
                [m3ua_as openSccpScreeningTraceFile];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"close-sccp-screening-trace"])
            {
                [m3ua_as closeSccpScreeningTraceFile];
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

