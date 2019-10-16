//
//  DiameterSessionPurge_UE_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.510000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionPurge_UE_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionPurge_UE_Request


- (NSString *)webTitle
{
    return @"Purge UE Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketPurge_UE_Request webJsonDefintion]];
}


- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketPurge_UE_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketPurge_UE_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketPurge_UE_Request *pkt = [[UMDiameterPacketPurge_UE_Request alloc]init];
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

