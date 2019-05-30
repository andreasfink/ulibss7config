//
//  DiameterSession3GPP_ULR.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSession3GPP_ULR.h"

@implementation DiameterSession3GPP_ULR


- (NSString *)webTitle
{
    return @"3GPP-ULR Update Location Request";
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>origin-host</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"origin-host\" value=\"default\">(local host name)</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>origin-realm</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"origin-realm\" value=\"default\">(local domain)</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>destination-host</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"destination-host\" value=\"default\">(remote host name)</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>destination-realm</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"destination-realm\" value=\"default\">(remote domain)</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>user-name</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"user-name\" type=text placeholder=\"001011234567890\">(IMSI))</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>rat-type</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"rat-type\"></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>ulr-flags</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"ulr-flags\"></td>\n"];
    [s appendString:@"</tr>\n"];


    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>visited-plmn-id</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"visited-plmn-id\"></td>\n"];
    [s appendString:@"</tr>\n"];


    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>features-flags</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"features-flags\"></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>terminal-information-imei</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"terminal-information-imei\"></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>terminal-information-software-version</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"terminal-information-software-version\"></td>\n"];
    [s appendString:@"</tr>\n"];
}

@end
