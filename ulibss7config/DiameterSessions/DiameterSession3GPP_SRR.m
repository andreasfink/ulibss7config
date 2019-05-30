//
//  DiameterSession3GPP_SRR.m
//  ulibss7config
//
//  Created by Andreas Fink on 30.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSession3GPP_SRR.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation DiameterSession3GPP_SRR


- (NSString *)webTitle
{
    return @"3GPP-SRR Send RoutinInfoFor SM Request";
}

- (void)webDiameterParameters:(NSMutableString *)s
{

    [self webApplicationParameters:s defaultApplicationId:UMDiameterApplicationId_3GPP_S6c comment:@"3GPP S6c"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>msisdn</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"msisdn\" type=text placeholder=\"+12345678\">(E,164 number)</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>imsi</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"imsi\" type=text placeholder=\"001011234567890\">(E.212 number)</td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>smsmi-correlation-id</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"smsmi-correlation-id\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=mandatory>smsc</td>\n"];
    [s appendString:@"    <td class=mandatory><input name=\"smsc\" type=text></td>\n"];
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
        NSString *application_id;
        NSString *msisdn;
        NSString *imsi;
        NSString *smsmi_correlation_id;
        NSString *smsc;
        NSString *sm_rp_mti;
        NSString *sm_rp_smea;
        NSString *srr_flags;
        NSString *sm_delivery_not_intended;
        NSString *supported_features;

        SET_OPTIONAL_CLEAN_PARAMETER(p,application_id,@"application-id");
        SET_OPTIONAL_CLEAN_PARAMETER(p,msisdn,@"msisdn");
        SET_OPTIONAL_CLEAN_PARAMETER(p,imsi,@"imsi");
        SET_OPTIONAL_CLEAN_PARAMETER(p,smsmi_correlation_id,@"smsmi-correlation-id");
        SET_OPTIONAL_CLEAN_PARAMETER(p,smsc,@"smsc");
        SET_OPTIONAL_CLEAN_PARAMETER(p,sm_rp_mti,@"sm-rp-mti");
        SET_OPTIONAL_CLEAN_PARAMETER(p,sm_rp_smea,@"sm-rp-smea");
        SET_OPTIONAL_CLEAN_PARAMETER(p,srr_flags,@"srr-flags");
        SET_OPTIONAL_CLEAN_PARAMETER(p,sm_delivery_not_intended,@"sm-delivery-not-intended");
        SET_OPTIONAL_CLEAN_PARAMETER(p,supported_features,@"supported-features");

        VERIFY_EITHER_OR(imsi,msisdn);

        UMDiameterPacket *pkt = [[UMDiameterPacket alloc]init];
        pkt.commandCode = UMDiameterCommandCode_3GPP_TS_29_338_SR;
        pkt.commandFlags = 0;

        [self setApplicationId:pkt default:UMDiameterApplicationId_3GPP_S6c];
        self.query = pkt;
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}
@end
