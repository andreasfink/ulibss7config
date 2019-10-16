//
//  DiameterSessionNotify_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.498000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionNotify_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionNotify_Request


- (NSString *)webTitle
{
    return @"Notify Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketNotify_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketNotify_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketNotify_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketNotify_Request *pkt = [[UMDiameterPacketNotify_Request alloc]init];
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

