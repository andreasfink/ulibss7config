//
//  SS7GenericInstance_MAP_Continue_Ind_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Continue_Ind_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Continue_Ind_Task

- (SS7GenericInstance_MAP_Continue_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                      userId:(UMGSMMAP_UserIdentifier *)userIdentifier
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
    [_inst executeMAP_Continue_Ind:_userIdentifier
               callingAddress:_callingAddress
                calledAddress:_calledAddress
              dialoguePortion:_dialoguePortion
                transactionId:_tcapLocalTransactionId
          remoteTransactionId:_tcapRemoteTransactionId
                      options:_options];
}

@end

