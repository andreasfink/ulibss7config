//
//  DiameterSessionSTR.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.545000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionSTR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionSTR


- (NSString *)webTitle
{
    return @"STR";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketSTR webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketSTR defaultApplicationId] comment:NULL];
    [UMDiameterPacketSTR webDiameterParameters:s];
}

- (void)main
{
    @autoreleasepool
    {
        @try
        {
            UMDiameterPacketSTR *pkt = [[UMDiameterPacketSTR alloc]init];
            [pkt setDictionaryValue:_req.params];        [pkt setDictionaryValueFromWeb:_req.params];
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

