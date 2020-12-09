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
                [self sendResultObject:@[ @"activate", @"deactivate", @"start",@"stop",@"forced-power-off",@"forced-power-on"]];
            }

            else if([action isEqualToString:@"activate"])
            {
                //[m3ua_as activate];
                //[self sendResultOK];
                [self sendErrorNotImplemented];

            }
            else if([action isEqualToString:@"deactivate"])
            {
                //[m3ua_as deactivate];
                //[self sendResultOK];
                [self sendErrorNotImplemented];
            }
            else if([action isEqualToString:@"start"])
            {
                [m3ua_as aspUp:NULL];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"stop"])
            {
                [m3ua_as aspDown:NULL];
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

