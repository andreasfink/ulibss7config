//
//  UMSS7ApiTaskM3UAASP_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskM3UAASP_status

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-status";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMM3UAApplicationServerProcess *asp = [_appDelegate getM3UA_ASP:name];
    if(asp)
    {


        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

        switch(asp.sctp_status)
        {
            case SCTP_STATUS_M_FOOS:
                dict[@"sctp-status"]=@"forced-out-of-service";
                break;
            case SCTP_STATUS_OFF:
                dict[@"sctp-status"]=@"off";
                break;
            case SCTP_STATUS_OOS:
                dict[@"status"]=@"out-of-service";
                break;
            case SCTP_STATUS_IS:
                dict[@"sctp-status"]=@"in-service";
                break;
            default:
                dict[@"sctp-status"]=@"invalid";
                break;
        }
        dict[@"sctp-connecting"]=@(asp.sctp_connecting);
        dict[@"sctp-up"]=@(asp.sctp_up);
        dict[@"m3ua-asp-up"]=@(asp.up);
        dict[@"m3ua-asp-active"]=@(asp.active);
        [self sendResultObject:dict];
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
