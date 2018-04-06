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
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
   NSString *name = _webRequest.params[@"name"];
    NSString *action = _webRequest.params[@"action"];
    name = [UMSS7ConfigObject filterName:name];
    UMM3UAApplicationServer *m3ua_as = [_appDelegate getM3UA_AS:name];
    if(m3ua_as)
    {
        if([action isEqualToString:@"action-list"])
        {
            [self sendResultObject:@[ @"activate", @"deactivate", @"start",@"stop"]];
        }

        else if([action isEqualToString:@"activate"])
        {
            [self sendErrorNotImplemented];

        }
        else if([action isEqualToString:@"deactivate"])
        {
            [self sendErrorNotImplemented];
        }
        else if([action isEqualToString:@"start"])
        {
            [self sendErrorNotImplemented];
        }
        else if([action isEqualToString:@"stop"])
        {
            [self sendErrorNotImplemented];
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
