//
//  SS7GenericInstance_MAP_Open_Resp_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Open_Resp_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Open_Resp_Task

- (SS7GenericInstance_MAP_Open_Resp_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                  userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                  dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                                             transaction:(NSString *)tcapLocalTransactionId
                                       remoteTransaction:(NSString *)tcapRemoteTransactionId
                                                     map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                                                 variant:(UMTCAP_Variant)variant
                                          callingAddress:(SccpAddress *)callingAddress
                                           calledAddress:(SccpAddress *)calledAddress
                                         dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                                                 options:(NSDictionary *)options
{
    self = [super initWithName:[[self class]description]
                      receiver:inst
                        sender:NULL];
    if(self)
    {
        _inst = inst;
        _userIdentifier = userIdentifier;
        _dialogId = dialogId;
        _tcapLocalTransactionId = tcapLocalTransactionId;
        _tcapRemoteTransactionId = tcapRemoteTransactionId;
        _map = map;
        _variant = variant;
        _callingAddress = callingAddress;
        _calledAddress = calledAddress;
        _dialoguePortion = dialoguePortion;
        _options = options;
    }
    return self;
}

-(void)main
{
    [_inst executeMAP_Open_Resp:_userIdentifier
                    dialog:_dialogId
               transaction:_tcapLocalTransactionId
         remoteTransaction:_tcapRemoteTransactionId
                       map:_map
                   variant:_variant
            callingAddress:_callingAddress
             calledAddress:_calledAddress
           dialoguePortion:_dialoguePortion
                   options:_options];
}
@end

