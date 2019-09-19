//
//  DiameterSessionLCS_Routing_Info_Request.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.09.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionLCS_Routing_Info_Request.h"

@implementation DiameterSessionLCS_Routing_Info_Request

#import "DiameterSessionReset_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


- (NSString *)webTitle
{
    return @"LCS Routing Info Request";
}


- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketLCSRouting_Info_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketLCSRouting_Info_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketLCSRouting_Info_Request *pkt = [[UMDiameterPacketLCSRouting_Info_Request alloc]init];
        [pkt setDictionaryValue:_req.params];
        self.query = pkt;
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}

@end

