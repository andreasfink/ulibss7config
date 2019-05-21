//
//  UMSS7ApiTaskSCTP_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibsctp/ulibsctp.h>

@implementation UMSS7ApiTaskSCTP_status


+ (NSString *)apiPath
{
    return @"/api/sctp-status";
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

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMLayerSctp *sctp = [_appDelegate getSCTP:name];
    if(sctp)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        switch(sctp.status)
        {
            case SCTP_STATUS_M_FOOS:
                dict[@"status"]=@"forced-out-of-service";
                break;
            case SCTP_STATUS_OFF:
                dict[@"status"]=@"off";
                break;
            case SCTP_STATUS_OOS:
                dict[@"status"]=@"out-of-service";
                break;
            case SCTP_STATUS_IS:
                dict[@"status"]=@"in-service";
                break;
            default:
                dict[@"status"]=[NSString stringWithFormat:@"Unknown-%d",sctp.status];
        }
        dict[@"inbound-bytes"] = [sctp.inboundThroughputBytes getSpeedTripleJson];
        dict[@"inbound-packets"] = [sctp.inboundThroughputPackets getSpeedTripleJson];
        dict[@"outbound-bytes"] = [sctp.outboundThroughputBytes getSpeedTripleJson];
        dict[@"outbound-packets"] = [sctp.outboundThroughputPackets getSpeedTripleJson];
        [self sendResultObject:dict];
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
