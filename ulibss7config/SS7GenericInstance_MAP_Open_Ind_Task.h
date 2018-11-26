//
//  SS7GenericInstance_MAP_Open_Ind_Task.h
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>
@class SS7GenericInstance;

@interface SS7GenericInstance_MAP_Open_Ind_Task : UMLayerTask
{
    SS7GenericInstance *_inst;
    UMGSMMAP_UserIdentifier *_userIdentifier;
    UMGSMMAP_DialogIdentifier *_dialogId;
    NSString *_tcapLocalTransactionId;
    NSString *_tcapRemoteTransactionId;
    id<UMLayerGSMMAP_ProviderProtocol>  _map;
    UMTCAP_Variant   _variant;
    SccpAddress *_callingAddress;
    SccpAddress *_calledAddress;
    UMTCAP_asn1_dialoguePortion *_dialoguePortion;
    NSDictionary *_options;
}


- (SS7GenericInstance_MAP_Open_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                 userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                 dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                                            transaction:(NSString *)tcapTransactionId
                                      remoteTransaction:(NSString *)tcapRemoteTransactionId
                                                    map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                                                variant:(UMTCAP_Variant)xvariant
                                         callingAddress:(SccpAddress *)src
                                          calledAddress:(SccpAddress *)dst
                                        dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                                                options:(NSDictionary *)options;

@end
