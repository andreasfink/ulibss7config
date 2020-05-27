//
//  DiameterSessionReset_Request.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.486000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionReset_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionReset_Request


- (NSString *)webTitle
{
    return @"Reset Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketReset_Request webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketReset_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketReset_Request webDiameterParameters:s];
}

- (void)main
{
    @autoreleasepool
    {
        @try
        {
            UMDiameterPacketReset_Request *pkt = [[UMDiameterPacketReset_Request alloc]init];
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

