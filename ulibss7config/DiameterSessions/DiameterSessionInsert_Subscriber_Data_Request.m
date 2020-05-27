//
//  DiameterSessionInsert_Subscriber_Data_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.449000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionInsert_Subscriber_Data_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionInsert_Subscriber_Data_Request


- (NSString *)webTitle
{
    return @"Insert Subscriber Data Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketInsert_Subscriber_Data_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketInsert_Subscriber_Data_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketInsert_Subscriber_Data_Request webDiameterParameters:s];
}

- (void)main
{
    @autoreleasepool
    {
        @try
        {
            UMDiameterPacketInsert_Subscriber_Data_Request *pkt = [[UMDiameterPacketInsert_Subscriber_Data_Request alloc]init];
            [pkt setDictionaryValueFromWeb:_req.params];
            self.query = pkt;
            [self submit];
        }
        @catch(NSException *e)
        {
            [self webException:e];
        }
    }
}

@end

