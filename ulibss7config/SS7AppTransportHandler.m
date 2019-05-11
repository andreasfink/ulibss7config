//
//  SS7AppTransportHandler.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7AppTransportHandler.h"
#import "SS7AppDelegate.h"
#import <ulibgt/ulibgt.h>
#import <ulibsccp/ulibsccp.h>
#import <ulibtcap/ulibtcap.h>
#import <ulibtransport/ulibtransport.h>
#import "SS7AppTransportSession.h"

@implementation SS7AppTransportHandler

- (SS7AppTransportHandler *)init
{
    self = [super init];
    if(self)
    {
        _uidMutex = [[UMMutex alloc]initWithName:@"SS7AppTransportHandler_uidMutex"];
        int concurrentThreads = ulib_cpu_count() * 2;
        UMTaskQueueMulti *tq = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentThreads
                                                                           name:@"app-transport-queue"
                                                                  enableLogging:NO
                                                                 numberOfQueues:UMLAYER_QUEUE_COUNT];
        _transportService = [[UMTransportService alloc]initWithTaskQueueMulti:tq];
        _transportService.delegate = self;
        _tansportSessionsByUserId = [[UMSynchronizedDictionary alloc]init];
        _tansportSessionsByTcapId = [[UMSynchronizedDictionary alloc]init];
    }
    return self;
}

/* the UMTransportService tells us about a new dialog connecting to us */
- (void)umtransportOpenIndication:(UMTransportOpen *)pdu
                    userReference:(NSString *)userDialogRef
                         dialogId:(UMTCAP_UserDialogIdentifier *)tcapUserId
                    remoteAddress:(SccpAddress *)address
{
    NSLog(@"umtransportOpenIndication");

    SS7AppTransportSession *ats = _tansportSessionsByUserId[userDialogRef];
    ats.tcapUserId = tcapUserId;
    _tansportSessionsByTcapId[ats.tcapUserId.dialogId] = ats;

    [ats umtransportOpenIndication:pdu
                     remoteAddress:address];
}

- (void)umtransportCloseConfirmation:(UMTransportCloseAccept *)pdu
                            dialogId:(UMTCAP_UserDialogIdentifier *)tcapUserId
                            invokeId:(int64_t)invokeId
{
    SS7AppTransportSession *ats = _tansportSessionsByTcapId[tcapUserId.dialogId];

    [ats umtransportCloseConfirmation:pdu
                             invokeId:invokeId];
}


- (void)umtransportCloseIndication:(UMTransportClose *)pdu
                     userReference:(NSString *)userDialogRef
                          dialogId:(UMTCAP_UserDialogIdentifier *)tcapUserId
{
    SS7AppTransportSession *ats = _tansportSessionsByTcapId[tcapUserId.dialogId];
    [ats umtransportCloseIndication:pdu];
}


- (NSString *)umtransportGetNewUserReference
{
    NSString *uidstr;
    int64_t uid;
    static int64_t lastUserId = 1;

    [_uidMutex lock];
    lastUserId = (lastUserId + 1 ) % 0x7FFFFFFF;
    uid = lastUserId;
    [_uidMutex unlock];
    uidstr =  [NSString stringWithFormat:@"AT%08llX",(long long)uid];

    SS7AppTransportSession *ats = [[SS7AppTransportSession alloc]init];
    ats.sessionId = uidstr;
    _tansportSessionsByUserId[uidstr] = ats;
    return  uidstr;
}

- (void)umtransportOpenConfirmation:(UMTransportOpenAccept *)pdu
                           dialogId:(UMTCAP_UserDialogIdentifier *)tcapUserId
                           invokeId:(int64_t)invokeId
{
    SS7AppTransportSession *ats = _tansportSessionsByTcapId[tcapUserId.dialogId];
    [ats umtransportOpenConfirmation:pdu
                            invokeId:invokeId];

}

- (void)umtransportTransportConfirmation:(UMTransportResponse *)pdu
                           userReference:(NSString *)userDialogRef
                                dialogId:(UMTCAP_UserDialogIdentifier *)tcapUserId
                                invokeId:(int64_t)invokeId
{
    SS7AppTransportSession *ats = _tansportSessionsByTcapId[tcapUserId.dialogId];
    [ats umtransportTransportConfirmation:pdu
                                 invokeId:invokeId];
}


- (void)umtransportTransportIndication:(UMTransportRequest *)pdu
                         userReference:(NSString *)userDialogRef
                              dialogId:(UMTCAP_UserDialogIdentifier *)tcapUserId
                              invokeId:(int64_t)invokeId
{
    SS7AppTransportSession *ats = _tansportSessionsByTcapId[tcapUserId.dialogId];
    [ats umtransportTransportIndication:pdu
                               invokeId:invokeId];
}


@end
