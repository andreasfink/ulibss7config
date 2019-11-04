//
//  DiameterSessionUser_Data_Request.m
//  ulibss7config
//
//  Created by Andreas Fink on 11.10.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionUser_Data_Request.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation DiameterSessionUser_Data_Request

- (NSString *)webTitle
{
    return @"User-Data-Request";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketUser_Data_Request webJsonDefintion]];
}


- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketUser_Data_Request defaultApplicationId] comment:NULL];
    [UMDiameterPacketUser_Data_Request webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketUser_Data_Request *pkt = [[UMDiameterPacketUser_Data_Request alloc]init];
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

