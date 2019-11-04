//
//  DiameterSessionRIR.m
//  ulibss7config
//
//  Created by Andreas Fink on 10.09.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionRIR.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation DiameterSessionRIR



- (NSString *)webTitle
{
    return @"RIR";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketLCS_Routing_Info_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketLCS_Routing_Info_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketLCS_Routing_Info_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketLCS_Routing_Info_Request *pkt = [[UMDiameterPacketLCS_Routing_Info_Request alloc]init];
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
