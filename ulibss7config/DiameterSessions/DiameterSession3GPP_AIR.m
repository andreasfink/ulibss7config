//
//  DiameterSession3GPP_AIR.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSession3GPP_AIR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>


@implementation DiameterSession3GPP_AIR


- (NSString *)webTitle
{
    return @"3GPP-AIR  Authentication Information Request";
}


- (void)webDiameterParameters:(NSMutableString *)s
{

    [self webApplicationParameters:s defaultApplicationId:UMDiameterApplicationId_3GPP_S6a_S6d comment:@"3GPP S6a/S6d"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=mandatory>imsi</td>\n"];
    [s appendString:@"    <td class=mandatory><input name=\"imsi\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>supported-features</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"supported-features\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=conditional>requested-eutran-authentication-info</td>\n"];
    [s appendString:@"    <td class=conditional><input name=\"requested-eutran-authentication-info\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=conditional>requested-utran-geran-authentication-info</td>\n"];
    [s appendString:@"    <td class=conditional><input name=\"requested-utran-geran-authentication-info\"></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=mandatory>visited-plmn-id</td>\n"];
    [s appendString:@"    <td class=mandatory><input name=\"visited-plmn-id\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>air-flags</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"air-flags\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>sm-rp-mti</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"sm-rp-mti\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>sm-rp-smea</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"sm-rp-smea\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>srr-flags</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"srr-flags\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>sm-delivery-not-intended</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"sm-delivery-not-intended\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>supported-features</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"supported-features\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];
}

- (void)main
{
    @try
    {
        NSDictionary *p = _req.params;

        NSString *imsi;
        NSString *supported_features;
        NSString *requested_eutran_authentication_info;
        NSString *requested_utran_geran_authentication_info;
        NSString *visited_plmn_id;
        NSString *air_flags;

        SET_MANDATORY_CLEAN_PARAMETER(p,imsi,@"imsi");
        SET_OPTIONAL_CLEAN_PARAMETER(p,supported_features,@"supported_features");
        SET_OPTIONAL_CLEAN_PARAMETER(p,requested_eutran_authentication_info,@"requested-eutran-authentication");
        SET_OPTIONAL_CLEAN_PARAMETER(p,requested_utran_geran_authentication_info,@"requested-utran-geran-authentication-info");
        SET_OPTIONAL_CLEAN_PARAMETER(p,visited_plmn_id,@"visited-plmn-id");
        SET_OPTIONAL_CLEAN_PARAMETER(p,air_flags,@"air-flags");

#if 0
        //  < Send-Routing-Info-for-SM-Request > ::= < Diameter Header: 8388647, REQ, PXY, 16777312 >
        UMDiameterPacket3GPP_AIR *pkt = [[UMDiameterPacket3GPP_AIR alloc]init];
        pkt.commandCode = _commandCode = UMDiameterCommandCode_3GPP_Authentication_Information;
        pkt.commandFlags = DIAMETER_COMMAND_FLAG_REQUEST | DIAMETER_COMMAND_FLAG_PROXIABLE;


        [self setSessionId:pkt fromParams:p];
        [self setApplicationId:pkt default:UMDiameterApplicationId_3GPP_S6a_S6d];
        [self setHostAndRealms:pkt fromParams:p];

        pkt.imsi = imsi;
        pkt.supported_features = supported_features;
        pkt.requested_eutran_authentication_info = requested_eutran_authentication_info;
        pkt. requested_utran_geran_authentication_info = requested_utran_geran_authentication_info;
        pkt.visited_plmn_id = visited_plmn_id;
        pkt.air_flags = air_flags;

        self.query = pkt;
#endif
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}
@end
