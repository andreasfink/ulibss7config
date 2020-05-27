//
//  SS7GenericInstance_MAP_Unidirectional_Ind_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Unidirectional_Ind_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Unidirectional_Ind_Task

- (SS7GenericInstance_MAP_Unidirectional_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
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
        _callingAddress = callingAddress;
        _calledAddress = calledAddress;
        _dialoguePortion = dialoguePortion;
        _tcapLocalTransactionId = tcapLocalTransactionId;
        _tcapRemoteTransactionId = tcapRemoteTransactionId;
        _options = options;
    }
    return self;
}

- (void)main
{
    @autoreleasepool
    {
        [_inst executeMAP_Unidirectional_Ind:_options
                         callingAddress:_callingAddress
                          calledAddress:_calledAddress
                        dialoguePortion:_dialoguePortion
                          transactionId:_tcapLocalTransactionId
                    remoteTransactionId:_tcapRemoteTransactionId];
    }
}

@end
