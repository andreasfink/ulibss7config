//
//  SS7GenericInstance_MAP_Delimiter_Ind_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Delimiter_Ind_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Delimiter_Ind_Task

- (SS7GenericInstance_MAP_Delimiter_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                      userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                      dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                                              callingAddress:(SccpAddress *)callingAddress
                                               calledAddress:(SccpAddress *)calledAddress
                                             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                                                 transaction:(NSString *)tcapLocalTransactionId
                                           remoteTransaction:(NSString *)tcapRemoteTransactionId
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
        _callingAddress = callingAddress;
        _calledAddress = calledAddress;
        _dialoguePortion = dialoguePortion;
        _tcapLocalTransactionId = tcapLocalTransactionId;
        _tcapRemoteTransactionId = tcapRemoteTransactionId;
        _options = options;
    }
    return self;
}

-(void)main
{
    @autoreleasepool
    {
        [_inst executeMAP_Delimiter_Ind:_userIdentifier
                            dialog:_dialogId
                    callingAddress:_callingAddress
                     calledAddress:_calledAddress
                   dialoguePortion:_dialoguePortion
                     transactionId:_tcapLocalTransactionId
               remoteTransactionId:_tcapRemoteTransactionId
                           options:_options];
    }
}

@end
