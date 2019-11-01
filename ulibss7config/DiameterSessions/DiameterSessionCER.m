//
//  DiameterSessionCER.m
//  ulibss7config
//
//  Created by afink on 2019-07-10 02:01:33.522000
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionCER.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSessionCER


- (NSString *)webTitle
{
    return @"CER";
}

- (NSString *)webScript
{
    return [NSString stringWithFormat:@"    <script>const vars = %@</script>\n" , [UMDiameterPacketCER webJsonDefintion]];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webApplicationParameters:s defaultApplicationId:[UMDiameterPacketCER defaultApplicationId] comment:NULL];
    [UMDiameterPacketCER webDiameterParameters:s];
}

- (void)main
{
    @try
    {
        UMDiameterPacketCER *pkt = [[UMDiameterPacketCER alloc]init];
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

