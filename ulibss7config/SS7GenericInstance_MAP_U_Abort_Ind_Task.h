//
//  SS7GenericInstance_MAP_U_Abort_Ind_Task.h
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>
@class SS7GenericInstance;

@interface SS7GenericInstance_MAP_U_Abort_Ind_Task : UMLayerTask
{
    SS7GenericInstance *_inst;
    UMGSMMAP_UserIdentifier *_userIdentifier;
    SccpAddress *_callingAddress;
    SccpAddress *_calledAddress;
    UMTCAP_asn1_dialoguePortion *_dialoguePortion;
    NSString *_tcapLocalTransactionId;
    NSString *_tcapRemoteTransactionId;
    NSDictionary *_options;
}

- (SS7GenericInstance_MAP_U_Abort_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                            userIdentifier:(UMGSMMAP_UserIdentifier *)userIdentifier
                                            callingAddress:(SccpAddress *)callingAddress
                                             calledAddress:(SccpAddress *)calledAddress
                                           dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                                               transaction:(NSString *)tcapLocalTransactionId
                                         remoteTransaction:(NSString *)tcapRemoteTransactionId
                                                   options:(NSDictionary *)options;
-(void)main;

@end
