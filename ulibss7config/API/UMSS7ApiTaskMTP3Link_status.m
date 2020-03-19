//
//  UMSS7ApiTaskMTP3Link_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Link_status.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskMTP3Link_status

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-status";
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

    NSString *name = _params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMMTP3Link *mtp3Link = [_appDelegate getMTP3Link:name];
    if(mtp3Link)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        switch(mtp3Link.m2pa.m2pa_status)
        {
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
            case M2PA_STATUS_BUSY:
                dict[@"m2pa-status"] = @"busy";
                break;
            case M2PA_STATUS_PROCESSOR_OUTAGE:
                dict[@"m2pa-status"] = @"processor-outage";
                break;
            default:
                dict[@"m2pa-status"] = @"invalid";
                break;
        }
        switch(mtp3Link.sctp_status)
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
        switch(mtp3Link.attachmentStatus)
        {
            case UMMTP3Link_attachmentStatus_detached:
                dict[@"attachment-status"]=@"detached";
                break;
            case UMMTP3Link_attachmentStatus_attachmentPending:
                dict[@"attachment-status"]=@"attachment-pending";
                break;
            case UMMTP3Link_attachmentStatus_attached:
                dict[@"attachment-status"]=@"attached";
                break;
        }
        if(mtp3Link.attachmentFailureStatus)
        {
            dict[@"attachment-failure-status"]=mtp3Link.attachmentFailureStatus;
        }
        else
        {
            dict[@"attachment-failure-status"]=@"";
        }
        dict[@"congested"]=@(mtp3Link.congested);
        dict[@"processor-outage"]=@(mtp3Link.processorOutage);
        dict[@"speed-limit-reached"]=@(mtp3Link.speedLimitReached);
        [self sendResultObject:dict];
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
