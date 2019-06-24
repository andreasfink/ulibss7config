//
//  DiameterSession3GPP_UDR.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSession3GPP_UDR.h"

@implementation DiameterSession3GPP_UDR


- (NSString *)webTitle
{
    return @"3GPP-UDR User Data Request";
}

- (void)webDiameterOptionalParameter:(NSMutableString *)s name:(NSString *)name
{
    [s appendString:@"<tr>\n"];
    [s appendFormat:@"    <td class=optional>%@</td>\n",name];
    [s appendFormat:@"    <td class=optional><input name=\"%@\" value=\"\"></td>\n",name];
    [s appendString:@"</tr>\n"];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [self webDiameterOptionalParameter:s name:@"drmp"];
    [self webDiameterOptionalParameter:s name:@"vendor-specific-application-id"];
    [self webDiameterOptionalParameter:s name:@"auth-session-state"];
    [self webDiameterOptionalParameter:s name:@"origin-host"];
    [self webDiameterOptionalParameter:s name:@"origin-realm"];
    [self webDiameterOptionalParameter:s name:@"destination-host"];
    [self webDiameterOptionalParameter:s name:@"destination-realm"];
    [self webDiameterOptionalParameter:s name:@"supported-features"];
    [self webDiameterOptionalParameter:s name:@"user-identity"];
    [self webDiameterOptionalParameter:s name:@"wildcarded-public-identity"];
    [self webDiameterOptionalParameter:s name:@"wildcarded-impu"];
    [self webDiameterOptionalParameter:s name:@"server-name"];
    [self webDiameterOptionalParameter:s name:@"service-indication"];
    [self webDiameterOptionalParameter:s name:@"data-reference"];
    [self webDiameterOptionalParameter:s name:@"identity-set"];
    [self webDiameterOptionalParameter:s name:@"requested-domain"];
    [self webDiameterOptionalParameter:s name:@"current-location"];
    [self webDiameterOptionalParameter:s name:@"dsai-tag"];
    [self webDiameterOptionalParameter:s name:@"session-priority"];
    [self webDiameterOptionalParameter:s name:@"user-name"];
    [self webDiameterOptionalParameter:s name:@"requested-nodes"];
    [self webDiameterOptionalParameter:s name:@"serving-node-indication"];
    [self webDiameterOptionalParameter:s name:@"pre-paging-supported"];
    [self webDiameterOptionalParameter:s name:@"local-time-zone-indication"];
    [self webDiameterOptionalParameter:s name:@"udr-flags"];
    [self webDiameterOptionalParameter:s name:@"call-reference-info"];
    [self webDiameterOptionalParameter:s name:@"oc-supported-features"];
    [self webDiameterOptionalParameter:s name:@"additional-avp"];
    [self webDiameterOptionalParameter:s name:@"proxy-info"];
    [self webDiameterOptionalParameter:s name:@"route-record"];

}

- (void)main
{
    @try
    {
        NSDictionary *p = _req.params;

        SET_OPTIONAL_CLEAN_PARAMETER(p,_drmp,@"drmp");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_vendor_specific_application_id,@"vendor-specific-application-id");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_auth_session_state,@"auth-session-state");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_origin_host,@"origin-host");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_origin_realm,@"origin-realm");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_destination_host,@"destination-host");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_destination_realm,@"destination-realm");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_supported_features,@"supported-features");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_user_identity,@"user-identity");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_wildcarded_public_identity,@"wildcarded-public-identity");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_wildcarded_impu,@"wildcarded-impu");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_server_name,@"server-name");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_service_indication,@"service-indication");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_data_reference,@"data-reference");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_identity_set,@"identity-set");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_requested_domain,@"requested-domain");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_current_location,@"current-location");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_dsai_tag,@"dsai-tag");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_session_priority,@"session-priority");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_user_name,@"user-name");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_requested_nodes,@"requested-nodes");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_serving_node_indication,@"serving-node-indication");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_pre_paging_supported,@"pre-paging-supported");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_local_time_zone_indication,@"local-time-zone-indication");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_udr_flags,@"udr-flags");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_call_reference_info,@"call-reference-info");
        SET_OPTIONAL_CLEAN_PARAMETER(p,_oc_supported_features,@"oc-supported-features");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_additional_avp,@"additional-avp");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_proxy_info,@"proxy-info");
        SET_OPTIONAL_CLEAN_PARAMETERS(p,_route_record,@"route-record");

        //  < Send-Routing-Info-for-SM-Request > ::= < Diameter Header: 8388647, REQ, PXY, 16777312 >
        UMDiameterPacket3GPP_UDR *pkt = [[UMDiameterPacket3GPP_UDR alloc]init];
        pkt.drmp = _drmp;
        pkt.vendor_specific_application_id = _vendor_specific_application_id;
        pkt.auth_session_state = _auth_session_state;
        pkt.origin_host = _origin_host;
        pkt.origin_realm = _origin_realm;
        pkt.destination_host = _destination_host;
        pkt.destination_realm = _destination_realm;
        pkt.supported_features = _supported_features;
        pkt.user_identity = _user_identity;
        pkt.wildcarded_public_identity = _wildcarded_public_identity;
        pkt.wildcarded_impu = _wildcarded_impu;
        pkt.server_name = _server_name;
        pkt.service_indication = _service_indication;
        pkt.data_reference = _data_reference;
        pkt.identity_set = _identity_set;
        pkt.requested_domain = _requested_domain;
        pkt.current_location = _current_location;
        pkt.dsai_tag = _dsai_tag;
        pkt.session_priority = _session_priority;
        pkt.user_name = _user_name;
        pkt.requested_nodes = _requested_nodes;
        pkt.serving_node_indication = _serving_node_indication;
        pkt.pre_paging_supported = _pre_paging_supported;
        pkt.local_time_zone_indication = _local_time_zone_indication;
        pkt.udr_flags = _udr_flags;
        pkt.call_reference_info = _call_reference_info;
        pkt.oc_supported_features = _oc_supported_features;
        pkt.additional_avp = _additional_avp;
        pkt.proxy_info = _proxy_info;
        pkt.route_record = _route_record;
        self.query = pkt;
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}
@end
