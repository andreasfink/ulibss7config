//
//  DiameterSession3GPP_ECR.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSession3GPP_ECR.h"

@implementation DiameterSession3GPP_ECR


- (NSString *)webTitle
{
    return @"3GPP-ECR Mobile Equipment Idenity Check Request";
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>not-implemented</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"not-implemented\" type=text placeholder=\"+12345678\">(not-implemented))</td>\n"];
    [s appendString:@"</tr>\n"];
}

@end
