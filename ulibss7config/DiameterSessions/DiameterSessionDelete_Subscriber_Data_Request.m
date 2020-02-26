//
//  DiameterSessionDelete_Subscriber_Data_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.461000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionDelete_Subscriber_Data_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionDelete_Subscriber_Data_Request


- (NSString *)webTitle
{
    return @"Delete Subscriber Data Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketDelete_Subscriber_Data_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketDelete_Subscriber_Data_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketDelete_Subscriber_Data_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketDelete_Subscriber_Data_Request *pkt = [[UMDiameterPacketDelete_Subscriber_Data_Request alloc]init];
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

