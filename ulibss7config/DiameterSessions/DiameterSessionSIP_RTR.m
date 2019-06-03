//
//  DiameterSessionSIP_RTR.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionSIP_RTR.h"

@implementation DiameterSessionSIP_RTR


- (NSString *)webTitle
{
    return @"SIP-RTR";
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>not-implemented</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"not-implemented\" type=text placeholder=\"+12345678\">(not-implemented))</td>\n"];
    [s appendString:@"</tr>\n"];
}

@end
