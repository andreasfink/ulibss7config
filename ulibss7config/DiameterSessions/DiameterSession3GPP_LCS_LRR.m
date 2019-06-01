//
//  DiameterSession3GPP_LCS_LRR.m
//  ulibss7config
//
//  Created by Andreas Fink on 30.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSession3GPP_LCS_LRR.h"

@implementation DiameterSession3GPP_LCS_LRR


- (NSString *)webTitle
{
    return @"3GPP-LCS-LRR";
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>not-implemented</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"not-implemented\" type=text placeholder=\"+12345678\">(not-implemented))</td>\n"];
    [s appendString:@"</tr>\n"];
}
@end
