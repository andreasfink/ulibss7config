//
//  DiameterSessionUpdate_Location_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.436000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionUpdate_Location_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionUpdate_Location_Request


- (NSString *)webTitle
{
    return @"Update Location Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketUpdate_Location_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketUpdate_Location_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketUpdate_Location_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketUpdate_Location_Request *pkt = [[UMDiameterPacketUpdate_Location_Request alloc]init];
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

