//
//  DiameterSessionRAR.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.557000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionRAR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionRAR


- (NSString *)webTitle
{
    return @"RAR";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketRAR webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketRAR defaultApplicationId] comment:NULL];
    [UMDiameterPacketRAR webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketRAR *pkt = [[UMDiameterPacketRAR alloc]init];
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

