//
//  SS7GenericInstance_MAP_ReturnResult_Resp_Task.h
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>

@class SS7GenericInstance;

@interface SS7GenericInstance_MAP_ReturnResult_Resp_Task : UMLayerTask
{
    SS7GenericInstance *_inst;
    UMASN1Object *_param;
    UMGSMMAP_UserIdentifier *_userIdentifier;
    UMGSMMAP_DialogIdentifier *_dialogId;
    NSString *_transactionId;
    UMLayerGSMMAP_OpCode *_opcode;
    int64_t _invokeId;
    int64_t _linkedId;
    BOOL    _last;
    NSDictionary *_options;
}

- (SS7GenericInstance_MAP_ReturnResult_Resp_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                              param:(UMASN1Object *)param
                                                             userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                             dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                                                        transaction:(NSString *)transactionId
                                                             opCode:(UMLayerGSMMAP_OpCode *)opcode
                                                           invokeId:(int64_t)invokeId
                                                           linkedId:(int64_t)linkedId
                                                               last:(BOOL)xlast
                                                            options:(NSDictionary *)options;
- (void)main;

@end
