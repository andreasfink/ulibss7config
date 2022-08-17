//
//  UMSS7ApiTaskM2PA_action.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_action.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibm2pa/ulibm2pa.h>

@implementation UMSS7ApiTaskM2PA_action

+ (NSString *)apiPath
{
    return @"/api/m2pa-action";
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
        UMLayerM2PA *m2pa = [_appDelegate getM2PA:name];
        if(m2pa)
        {
            if([action isEqualToString:@"action-list"])
            {
                [self sendResultObject:@[ @"power-on", @"power-off", @"emergency-on", @"emergency-of", @"start", @"stop"]];
            }
            else if([action isEqualToString:@"power-on"])
            {
                [m2pa powerOnFor:NULL forced:NO reason:@"api-action power-on"];
                [self sendResultOK];

            }
            else if([action isEqualToString:@"power-off"])
            {
                [m2pa.stateMachineLogFeed debugText:@"api requesting power-off"];
                [m2pa powerOffFor:NULL forced:NO reason:@"api-action power-off"];
                [self sendResultOK];
            }

            else if([action isEqualToString:@"emergency-on"])
            {
                [m2pa emergencyFor:NULL];
                [self sendResultOK];

            }
            else if([action isEqualToString:@"emergency-off"])
            {
                [m2pa emergencyCheasesFor:NULL];
                [self sendResultOK];
            }
            else if([action isEqualToString:@"start"])
            {
                [m2pa startFor:NULL forced:NO reason:@"api-action start"];
                [self sendResultOK];

            }
            else if([action isEqualToString:@"stop"])
            {
                [m2pa stopFor:NULL forced:NO reason:@"api-action stop"];
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
