//
//  DiameterSession_Send_Routing_Info_for_SM_Request.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.04.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "DiameterSession_Send_Routing_Info_for_SM_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation DiameterSession_Send_Routing_Info_for_SM_Request

- (NSString *)webTitle
{
    return @"Send-Routing-Info-for-SM-Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketSend_Routing_Info_for_SM_Request webJsonDefintion]];
}


- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketSend_Routing_Info_for_SM_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketUser_Data_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketSend_Routing_Info_for_SM_Request *pkt = [[UMDiameterPacketSend_Routing_Info_for_SM_Request alloc]init];
        [pkt setDictionaryValueFromWeb:_req.params];
        self.query = pkt;
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}

@end

