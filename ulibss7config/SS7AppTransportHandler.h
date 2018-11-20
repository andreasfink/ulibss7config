//
//  SS7AppTransportHandler.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibtransport/ulibtransport.h>

@class SS7AppDelegate;

@interface SS7AppTransportHandler : UMObject<UMTransportUserProtocol>
{
    SS7AppDelegate *_appDelegate;
    UMMutex     *_uidMutex;
    UMTransportService *_transportService;
    UMSynchronizedDictionary *_tansportSessionsByUserId;
    UMSynchronizedDictionary *_tansportSessionsByTcapId;
}

@property(readwrite,strong,atomic)      SS7AppDelegate *appDelegate;
@property(readwrite,strong,atomic)      UMTransportService *transportService;

@end
