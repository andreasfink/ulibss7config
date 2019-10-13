//
//  DiameterSessionSimpleLocation.m
//  ulibss7config
//
//  Created by Andreas Fink on 11.10.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterSessionSimpleLocation.h"
#import "WebMacros.h"
#import <ulibdiameter/ulibdiameter.h>

@implementation DiameterSessionSimpleLocation


- (NSString *)webTitle
{
    return @"SimpleLocation";
}

- (DiameterSessionSimpleLocation *)init
{
    return NULL;
}

-(DiameterSessionSimpleLocation *)initWithHttpReq:(UMHTTPRequest *)xreq
                                         instance:(DiameterGenericInstance *)inst
{
    return [super initWithHttpReq:xreq instance:inst];
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"session-id"         comment:@"" css:@"mandatory"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"origin-host"        comment:@"" css:@"mandatory"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"origin-realm"       comment:@"" css:@"mandatory"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"destination-host"   comment:@"" css:@"optional"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"destination-realm"  comment:@"" css:@"mandatory"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"vendor-id"          comment:@"" css:@"mandatory" value:@"10415"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"auth-app-id"        comment:@"" css:@"mandatory" value:@"16777217"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"session-state"      comment:@"" css:@"mandatory" value:@"1"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"msisdn"             comment:@"" css:@"mandatory"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"data-reference"     comment:@"14=locationInformation"            css:@"mandatory" value:@"14"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"current-location"   comment:@"1=InitiateActiveLocationRetrieval" css:@"mandatory" value:@"1"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"requested-domain"   comment:@"1=PS Domain"                       css:@"mandatory" value:@"1"];
    [UMDiameterAvp appendWebDiameterParameters:s webName:@"requested-nodes"    comment:@"1=MME"                             css:@"mandatory" value:@"1"];
}

- (void)main
{
    @try
    {
        
        NSString *sessionId = _params[@"session-id"];
        NSString *originHost = _params[@"origin-host"];
        NSString *originRealm = _params[@"origin-realm"];
        NSString *destinationHost = _params[@"destination-host"];
        NSString *destinationRealm = _params[@"destination-realm"];
        NSString *vendorId = _params[@"vendor-id"];
        if(vendorId.length == 0)
        {
            vendorId = @"10415";
        }
        NSString *authAppId = _params[@"auth-app-id"];
        if(authAppId.length==0)
        {
            authAppId = @"16777217";
        }
        NSString *sessionState = _params[@"session-state"];
        if(sessionState.length ==0)
        {
            sessionState = @"1";
        }
        NSString *msisdn = _params[@"msisdn"]; /* required */
        NSString *dataReference = _params[@"data-reference"];
        if(dataReference.length == 0)
        {
            dataReference = @"14"; /*locationInformation*/
        }
        NSString *currentLocation = _params[@"current-location"];
        if(currentLocation.length == 0)
        {
            currentLocation = @"1";  /* InitiateActiveLocationRetrieval */
        }
        NSString *requestedDomain = _params[@"requested-domain"];
        if(requestedDomain.length == 0)
        {
            requestedDomain = @"1"; /* PS Domain*/
        }
        NSString *requestedNodes = _params[@"requested-nodes"];
        if(requestedNodes.length == 0)
        {
            requestedNodes = @"1"; /* MME */
        }


        UMDiameterPacketUser_Data_Request *pkt = [[UMDiameterPacketUser_Data_Request alloc]init];
        self.commandCode = [UMDiameterPacketUser_Data_Request commandCode];
        if(sessionId.length > 0)
        {
            pkt.var_session_id = [[UMDiameterAvpSession_Id alloc]initWithString:sessionId];
        }
        if(originHost.length > 0)
        {
            pkt.var_origin_host = [[UMDiameterAvpOrigin_Host alloc]initWithString:originHost];
        }
        if(originRealm.length > 0)
        {
            pkt.var_origin_realm = [[UMDiameterAvpOrigin_Realm alloc]initWithString:originRealm];
        }
        if(destinationHost.length > 0)
        {
            pkt.var_destination_host = [[UMDiameterAvpDestination_Host alloc]initWithString:destinationHost];
        }
        if(destinationRealm.length > 0)
        {
            pkt.var_destination_realm = [[UMDiameterAvpDestination_Realm alloc]initWithString:destinationRealm];
        }
        pkt.var_vendor_specific_application_id = [[UMDiameterAvpVendor_Specific_Application_Id alloc]init];
        if(vendorId.length > 0)
        {
            pkt.var_vendor_specific_application_id.var_vendor_id = [[UMDiameterAvpVendor_Id alloc]initWithString:vendorId];
        }
        if(authAppId.length > 0)
        {
            pkt.var_vendor_specific_application_id.var_auth_application_id = [[UMDiameterAvpAuth_Application_Id alloc]initWithString:authAppId];
        }
        if(sessionState.length > 0)
        {
            pkt.var_auth_session_state =  [[UMDiameterAvpAuth_Session_State alloc]initWithString:sessionState];
        }
        if(msisdn.length > 0)
        {
            pkt.var_user_identity = [[UMDiameterAvpUser_Identity alloc]init];
            pkt.var_user_identity.var_msisdn = [[UMDiameterAvpMSISDN alloc]initWithString:msisdn];
        }
        if(dataReference.length > 0)
        {
            UMDiameterAvpData_Reference *df = [[UMDiameterAvpData_Reference alloc]initWithString:dataReference];
            pkt.var_data_reference = @[ df ];
        }
        if(currentLocation.length > 0)
        {
            pkt.var_current_location = [[UMDiameterAvpCurrent_Location alloc]initWithString:currentLocation];
        }
        if(requestedDomain.length > 0)
        {
            pkt.var_requested_domain = [[UMDiameterAvpRequested_Domain alloc]initWithString:requestedDomain];
        }
        if(requestedNodes.length > 0)
        {
            pkt.var_requested_nodes = [[UMDiameterAvpRequested_Nodes alloc]initWithString:requestedNodes];
        }
        self.query = pkt;
        [self submit];
    }
    @catch(NSException *e)
    {
        [self webException:e];
    }
}

@end

