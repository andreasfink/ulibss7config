//
//  DiameterSessionACR.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.569000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionACR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionACR


- (NSString *)webTitle
{
    return @"ACR";
}


- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketACR defaultApplicationId] comment:NULL];
    [UMDiameterPacketACR webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketACR *pkt = [[UMDiameterPacketACR alloc]init];
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

