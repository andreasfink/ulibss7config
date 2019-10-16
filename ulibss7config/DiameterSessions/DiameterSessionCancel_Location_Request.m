//
//  DiameterSessionCancel_Location_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.473000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionCancel_Location_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionCancel_Location_Request


- (NSString *)webTitle
{
    return @"Cancel Location Request";
}


- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketCancel_Location_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketCancel_Location_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketCancel_Location_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketCancel_Location_Request *pkt = [[UMDiameterPacketCancel_Location_Request alloc]init];
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

