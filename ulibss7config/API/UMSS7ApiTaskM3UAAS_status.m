//
//  UMSS7ApiTaskM3UAAS_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAAS_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskM3UAAS_status

+ (NSString *)apiPath
{
    return @"/api/m3ua-as-status";
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
        name = [UMSS7ConfigObject filterName:name];
        UMM3UAApplicationServer *m3ua_as = [_appDelegate getM3UAAS:name];
        if(m3ua_as)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            switch(m3ua_as.m3ua_status)
            {

                case M3UA_STATUS_OFF:
                    dict[@"m3ua-as-status"] = @"off";
                    break;
                case M3UA_STATUS_OOS:
                    dict[@"m3ua-as-status"] = @"out-of-service";
                    break;
                case M3UA_STATUS_BUSY:
                    dict[@"m3ua-as-status"] = @"busy";
                    break;
                case M3UA_STATUS_INACTIVE:
                    dict[@"m3ua-as-status"] = @"inactive";
                    break;
                case M3UA_STATUS_IS:
                    dict[@"m3ua-as-status"] = @"in-service";
                    break;
                case  M3UA_STATUS_UNUSED:
                default:
                    dict[@"m3ua-as-status"] = @"undefined";
                    break;
            }
            dict[@"congestion-level"] = @(m3ua_as.congestionLevel);
            dict[@"configured-speed"] = @(m3ua_as.speed);
            if(m3ua_as.speedometerRx)
            {
                dict[@"current-rx-speed"] = [m3ua_as.speedometerRx getSpeedTripleJson];
            }
            if(m3ua_as.speedometerTx)
            {
                dict[@"current-tx-speed"] = [m3ua_as.speedometerTx  getSpeedTripleJson];
            }
            [self sendResultObject:dict];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}
@end
