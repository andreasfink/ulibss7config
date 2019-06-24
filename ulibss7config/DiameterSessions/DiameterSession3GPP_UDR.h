//
//  DiameterSession3GPP_UDR.h
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterGenericSession.h"

/*
< User-Data -Request> ::= < Diameter Header: 306, REQ, PXY, 16777217 > < Session-Id >
    [ DRMP ]
    { Vendor-Specific-Application-Id }
    { Auth-Session-State }
    { Origin-Host }
    { Origin-Realm }
    [ Destination-Host ]
    { Destination-Realm }
    *[ Supported-Features ]
    { User-Identity }
    [ Wildcarded-Public-Identity ]
    [ Wildcarded-IMPU ]
    [ Server-Name ]
    *[ Service-Indication ]
    *{ Data-Reference }
    *[ Identity-Set ]
    [ Requested-Domain ]
    [ Current-Location ]
 *[ DSAI-Tag ]
 [ Session-Priority ]
 [ User-Name ]
 [ Requested-Nodes ]
 [ Serving-Node-Indication ]
 [ Pre-paging-Supported ]
 [ Local-Time-Zone-Indication ] [ UDR-Flags ]
 [ Call-Reference-Info ]
 [ OC-Supported-Features ]
 *[ AVP ]
 *[ Proxy-Info ]
 *[ Route-Record ]

*/
@interface DiameterSession3GPP_UDR : DiameterGenericSession
{
    NSString *_drmp;
    NSString *_vendor_specific_application_id;
    NSString *_auth_session_state;
    NSString *_origin_host;
    NSString *_origin_realm;
    NSString *_destination_host;
    NSString *_destination_realm;
    NSArray  *_supported_features;
    NSString *_user_identity;
    NSString *_wildcarded_public_identity;
    NSString *_wildcarded_impu;
    NSString *_server_name;
    NSArray *_service_indication;
    NSArray *_data_reference;
    NSArray *_identity_set;
    NSString *_requested_domain;
    NSString *_current_location;
    NSArray *_dsai_tag;
    NSString *_session_priority;
    NSString *_user_name;
    NSString *_requested_nodes;
    NSString *_serving_node_indication;
    NSString *_pre_paging_supported;
    NSString *_local_time_zone_indication;
    NSString *_udr_flags;
    NSString *_call_reference_info;
    NSString *_oc_supported_features;
    NSArray *_additional_avp;
    NSArray *_proxy_info;
    NSArray *_route_record;
}

@property(readwrite,strong,atomic)  NSString *drmp;
@property(readwrite,strong,atomic)  NSString *vendor_specific_application_id;
@property(readwrite,strong,atomic)  NSString *auth_session_state;
@property(readwrite,strong,atomic)  NSString *origin_host;
@property(readwrite,strong,atomic)  NSString *origin_realm;
@property(readwrite,strong,atomic)  NSString *destination_host;
@property(readwrite,strong,atomic)  NSString *destination_realm;
@property(readwrite,strong,atomic)  NSArray  *supported_features;
@property(readwrite,strong,atomic)  NSString *user_identity;
@property(readwrite,strong,atomic)  NSString *wildcarded_public_identity;
@property(readwrite,strong,atomic)  NSString *wildcarded_impu;
@property(readwrite,strong,atomic)  NSString *server_name;
@property(readwrite,strong,atomic)  NSArray *service_indication;
@property(readwrite,strong,atomic)  NSArray *data_reference;
@property(readwrite,strong,atomic)  NSArray *identity_set;
@property(readwrite,strong,atomic)  NSString *requested_domain;
@property(readwrite,strong,atomic)  NSString *current_location;

@property(readwrite,strong,atomic)  NSArray *dsai_tag;
@property(readwrite,strong,atomic)  NSString *session_priority;
@property(readwrite,strong,atomic)  NSString *user_name;
@property(readwrite,strong,atomic)  NSString *requested_nodes;
@property(readwrite,strong,atomic)  NSString *serving_node_indication;
@property(readwrite,strong,atomic)  NSString *pre_paging_supported;
@property(readwrite,strong,atomic)  NSString *local_time_zone_indication;
@property(readwrite,strong,atomic)  NSString *udr_flags;
@property(readwrite,strong,atomic)  NSString *call_reference_info;
@property(readwrite,strong,atomic)  NSString *oc_supported_features;
@property(readwrite,strong,atomic)  NSArray *additional_avp;
@property(readwrite,strong,atomic)  NSArray *proxy_info;
@property(readwrite,strong,atomic)  NSArray *route_record;

@end


