//
//  DiameterSessionDWR.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.533000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionDWR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionDWR


- (NSString *)webTitle
{
    return @"DWR";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketDWR webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketDWR defaultApplicationId] comment:NULL];
    [UMDiameterPacketDWR webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketDWR *pkt = [[UMDiameterPacketDWR alloc]init];
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

