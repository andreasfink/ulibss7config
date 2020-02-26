//
//  UMSS7ApiTaskM2PA_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibm2pa/ulibm2pa.h>

@implementation UMSS7ApiTaskM2PA_status

+ (NSString *)apiPath
{
    return @"/api/m2pa-status";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMLayerM2PA *m2pa = [_appDelegate getM2PA:name];
    if(m2pa)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

        dict[@"link-state-control"]=m2pa.lscState.description;
        dict[@"initial-alignment-control"]=m2pa.iacState.description;
        dict[@"inbound-bytes"] = [m2pa.inboundThroughputBytes getSpeedTripleJson];
        dict[@"inbound-packets"] = [m2pa.inboundThroughputPackets getSpeedTripleJson];
        dict[@"outbound-bytes"] = [m2pa.outboundThroughputBytes getSpeedTripleJson];
        dict[@"outbound-packets"] = [m2pa.outboundThroughputPackets getSpeedTripleJson];

        switch(m2pa.speed_status)
        {
            case SPEED_WITHIN_LIMIT:
                dict[@"speed-status"] = @"within-limit";
                break;
            case SPEED_EXCEEDED:
                dict[@"speed-status"] = @"within-limit";
                break;
            default:
                dict[@"speed-status"] = @"unknown";
                break;
        }

        switch(m2pa.m2pa_status)
        {
            case  M2PA_STATUS_UNUSED:
                dict[@"m2pa-status"] = @"unused";
                break;
            case M2PA_STATUS_OFF:
                dict[@"m2pa-status"] = @"off";
                break;
            case M2PA_STATUS_OOS:
                dict[@"m2pa-status"] = @"out-of-service";
                break;
            case M2PA_STATUS_INITIAL_ALIGNMENT:
                dict[@"m2pa-status"] = @"initial-alignment";
                break;
            case M2PA_STATUS_ALIGNED_NOT_READY:
                dict[@"m2pa-status"] = @"aligned-not-ready";
                break;
            case M2PA_STATUS_ALIGNED_READY:
                dict[@"m2pa-status"] = @"aligned-ready";
                break;
            case M2PA_STATUS_IS:
                dict[@"m2pa-status"] = @"in-service";
                break;
            default:
                dict[@"m2pa-status"] = @"invalid";
                break;
        }
        switch(m2pa.sctp_status)
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
        [self sendResultObject:dict];
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
