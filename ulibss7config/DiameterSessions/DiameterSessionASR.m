//
//  DiameterSessionASR.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.592000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionASR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionASR


- (NSString *)webTitle
{
    return @"ASR";
}


- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketASR defaultApplicationId] comment:NULL];
    [UMDiameterPacketASR webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketASR *pkt = [[UMDiameterPacketASR alloc]init];
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

