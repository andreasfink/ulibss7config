//
//  DiameterSessionLCS_Routing_Info_Request.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.09.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionLCS_Routing_Info_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation DiameterSessionLCS_Routing_Info_Request


- (NSString *)webTitle
{
    return @"LCS Routing Info Request";
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
    @autoreleasepool
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
}

@end

