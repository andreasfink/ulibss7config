//
//  UMTTask.m
//  ulibss7config
//
//  Created by Andreas Fink on 26.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMTTask.h"
#import "SS7AppDelegate.h"

@implementation UMTTask


-(UMTransportDialogState) dialogState
{
    _dialogId =  [_transportService dialogIdentifierForDestination:_remoteAddr];
    UMTransportDialog *dialog =  [_transportService dialogById:_dialogId];
    return dialog.dialogState;
}


- (void)main
{
    @autoreleasepool
    {
        _dialogId =  [_transportService dialogIdentifierForDestination:_remoteAddr];
        UMTransportDialog *dialog =   [_transportService dialogById:_dialogId];
        if(dialog.dialogState == UMTransportDialogState_closed)
        {
            UMTransportOpen *openPdu = [[UMTransportOpen alloc]init];
            openPdu.version = 1;
            UMTCAP_UserDialogIdentifier *newDialogId;
            int64_t newInvokeId;
            [_transportService umtransportOpenRequest:openPdu
                                        userReference:_userRef
                                             dialogId:&newDialogId
                                             invokeId:&newInvokeId
                                        remoteAddress:_remoteAddr];
        }
        else if (dialog.dialogState == UMTransportDialogState_open)
        {
            [self executeWhenOpen];
        }
    }
}

- (void)openConfirmation:(UMTransportOpenAccept *)pdu
{
    [self executeWhenOpen];
}

- (void)closeConfirmation:(UMTransportCloseAccept *)pdu
{
    if(_req)
    {
        [_req setResponsePlainText:@"connection-closed"];
        [_req resumePendingRequest];
    }
    _req = NULL;
}

- (void)executeWhenOpen
{
    NSAssert(0,@"this method should be overwritten");
}
    
- (void)processResponse:(UMTransportResponse *)resp
{
    NSAssert(0,@"this method should be overwritten");
}
@end
