//
//  DiameterSessionAuthentication_Information_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.421000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionAuthentication_Information_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionAuthentication_Information_Request


- (NSString *)webTitle
{
    return @"Authentication Information Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketAuthentication_Information_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketAuthentication_Information_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketAuthentication_Information_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketAuthentication_Information_Request *pkt = [[UMDiameterPacketAuthentication_Information_Request alloc]init];
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

