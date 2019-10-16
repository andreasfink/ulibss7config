//
//  DiameterSessionDPR.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.581000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionDPR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionDPR


- (NSString *)webTitle
{
    return @"DPR";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketDPR webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketDPR defaultApplicationId] comment:NULL];
    [UMDiameterPacketDPR webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketDPR *pkt = [[UMDiameterPacketDPR alloc]init];
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

