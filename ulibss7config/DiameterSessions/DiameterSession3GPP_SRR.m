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

    [self webApplicationParameters:s defaultApplicationId:UMDiameterApplicationId_3GPP_S6a_S6d comment:@"3GPP S6a/S6d"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>session-id</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"session-id\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>drmp-id</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"drmp\" type=text></td>\n"];
    [s appendString:@"</tr>\n"];

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

        NSString *drmp;
        NSString *msisdn;
        NSString *userName;
        NSString *smsmi_correlation_id;
        NSString *smsc;
        NSString *sm_rp_mti;
        NSString *sm_rp_smea;
        NSString *srr_flags;
        NSString *sm_delivery_not_intended;
        NSString *supported_features;

        SET_OPTIONAL_CLEAN_PARAMETER(p,drmp,@"drmp");
        SET_OPTIONAL_CLEAN_PARAMETER(p,msisdn,@"msisdn");
        SET_OPTIONAL_CLEAN_PARAMETER(p,userName,@"user-name");
        SET_OPTIONAL_CLEAN_PARAMETER(p,smsmi_correlation_id,@"smsmi-correlation-id");
        SET_OPTIONAL_CLEAN_PARAMETER(p,smsc,@"smsc");
        SET_OPTIONAL_CLEAN_PARAMETER(p,sm_rp_mti,@"sm-rp-mti");
        SET_OPTIONAL_CLEAN_PARAMETER(p,sm_rp_smea,@"sm-rp-smea");
        SET_OPTIONAL_CLEAN_PARAMETER(p,srr_flags,@"srr-flags");
        SET_OPTIONAL_CLEAN_PARAMETER(p,sm_delivery_not_intended,@"sm-delivery-not-intended");
        SET_OPTIONAL_CLEAN_PARAMETER(p,supported_features,@"supported-features");

        VERIFY_EITHER_OR(userName,msisdn);

        //  < Send-Routing-Info-for-SM-Request > ::= < Diameter Header: 8388647, REQ, PXY, 16777312 >
        UMDiameterPacket *pkt = [[UMDiameterPacket alloc]init];
        pkt.commandCode = _commandCode = UMDiameterCommandCode_3GPP_TS_29_338_SR;
        pkt.commandFlags = DIAMETER_COMMAND_FLAG_REQUEST | DIAMETER_COMMAND_FLAG_PROXIABLE;

        [self setSessionId:pkt fromParams:p];
        [self setApplicationId:pkt default:UMDiameterApplicationId_3GPP_S6a_S6d];
        [self setHostAndRealms:pkt fromParams:p];

        // [ DRMP ]

/* FIXME */
#if 0
        // [ MSISDN ]
        if(msisdn.length > 0)
        {
            // < Session-Id >
            UMDiameterAvpMSISDN *avp = [[UMDiameterAvpMSISDN alloc]init];
            [avp setFlagMandatory:YES];
            [avp setValue:msisdn];
            [pkt appendAvp:avp];
        }
#endif
        // [ User-Name ]
        if(userName.length > 0)
        {
            UMDiameterAvpUser_Name *avp = [[UMDiameterAvpUser_Name alloc]init];
            [avp setFlagMandatory:YES];
            avp.value = userName;
            [pkt appendAvp:avp];
        }

        //  [ SMSMI-Correlation-ID ]
        if(smsmi_correlation_id.length > 0)
        {
            UMDiameterAvpSession_Id *avp = [[UMDiameterAvpSession_Id alloc]init];
            [avp setFlagMandatory:YES];
            avp.value = msisdn;
            [pkt appendAvp:avp];
        }

        // *[ Supported-Features ]
        // [ SC-Address ]
        /*
        if(smsc.length > 0)
        {
            // < Session-Id >
            UMDiameterAvpSCAddress *avp = [[UMDiameterAvpSCAddress alloc]init];
            [avp setFlagMandatory:YES];
            [avp setValue:msisdn];
            [pkt appendAvp:avp];
        }
         */
        // [ SM-RP-MTI ]
        // [ SM-RP-SMEA ]
        // [ SRR-Flags ]
        // [ SM-Delivery-Not-Intended ]
        // *[ AVP ]
        // *[ Proxy-Info ]
        // *[ Route-Record ]
        self.query = pkt;
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}
@end
