//
//  UMTTask.h
//  ulibss7config
//
//  Created by Andreas Fink on 26.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibtcap/ulibtcap.h>
#import <ulibtransport/ulibtransport.h>

@class SS7AppDelegate;

@interface UMTTask : UMTask
{
    UMHTTPRequest               *_req;
    SccpAddress                 *_remoteAddr;
    UMTransportService          *_transportService;
    UMTCAP_UserDialogIdentifier *_dialogId;
    NSString                    *_userRef;
    SS7AppDelegate              *_appDelegate;
    int64_t                     _invokeId;
}

@property (readwrite,strong) UMHTTPRequest      *req;
@property (readwrite,strong) SccpAddress        *remoteAddr;
@property (readwrite,strong) UMTransportService *transportService;
@property (readwrite,strong) NSString           *userRef;
@property (readwrite,strong) SS7AppDelegate		*appDelegate;

- (void)processResponse:(UMTransportResponse *)resp;
- (UMTransportDialogState)dialogState;
- (void)executeWhenOpen;
- (void)openConfirmation:(UMTransportOpenAccept *)pdu;
- (void)closeConfirmation:(UMTransportCloseAccept *)pdu;

@end
