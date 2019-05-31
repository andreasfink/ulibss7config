//
//  DiameterSessionCER.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionCER.h"

@implementation DiameterSessionCER


- (NSString *)webTitle
{
    return @"CER";
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>asr-not-implemented</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"not-implemented\" type=text placeholder=\"+12345678\">(not-implemented))</td>\n"];
    [s appendString:@"</tr>\n"];
}

@end
