//
//  DiameterGenericInstance.h
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibdiameter/ulibdiameter.h>
#import "UMSS7ConfigObject.h"
#import "SS7UserAuthenticateProtocol.h"

@class DiameterGenericSession;

@interface DiameterGenericInstance : UMLayer<UMHTTPServerHttpGetPostDelegate,UMHTTPRequest_TimeoutProtocol,UMDiameterLocalUserProtocol>
{
    NSString                    *_instanceAddress;
    UMSynchronizedDictionary    *_sessions;
    UMDiameterRouter            *_diameterRouter;
    NSTimeInterval              _timeoutInSeconds;
    UMMutex                     *_uidMutex;
    UMMutex                     *_operationMutex;
    NSString                    *_timeoutTraceDirectory;
    NSString                    *_genericTraceDirectory;
    UMTimer                     *_houseKeepingTimer;
    UMMutex                     *_housekeeping_lock;
    UMAtomicDate                *_houseKeepingTimerRun;
    UMHTTPClient                *_webClient;
    id<SS7UserAuthenticateProtocol> _authDelegate;
    NSString                    *_localRealm;
    NSString                    *_localAddress;
}

@property(readwrite,strong) UMDiameterRouter *diameterRouter;
@property(readwrite,strong) NSString *instanceAddress;
@property(readwrite,assign) NSTimeInterval timeoutInSeconds;
@property(readwrite,strong) NSString *timeoutTraceDirectory;
@property(readwrite,strong) NSString *genericTraceDirectory;
@property(readwrite,strong) UMAtomicDate *houseKeepingTimerRun;
@property(readwrite,strong) UMHTTPClient *webClient;
@property(readwrite,strong) id<SS7UserAuthenticateProtocol>    authDelegate;
@property(readwrite,strong) NSString *localRealm;
@property(readwrite,strong) NSString *localAddress;


- (DiameterGenericInstance *)initWithAddress:(NSString *)iAddress;
- (NSString *)status;
- (void) setConfig:(NSDictionary *)cfg applicationContext:(id)appContext;


- (NSString *)getNewUserIdentifier;
- (DiameterGenericSession *)sessionById:(NSString *)userId;
- (void)addSession:(DiameterGenericSession *)t userId:(NSString *)uidstr;
- (void) markSessionForTermination:(DiameterGenericSession *)t;
+ (NSString *)webIndex;

+ (void)webHeader:(NSMutableString *)s title:(NSString *)t;
- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
                                                realm:(NSString **)realm;
- (UMHTTPAuthenticationStatus)authenticateUser:(NSString *)user pass:(NSString *)pass;
- (NSUInteger)sessionsCount;
- (void)housekeeping;
- (void)processIncomingRequestPacket:(UMDiameterPacket *)packet
                              router:(UMDiameterRouter *)router
                                peer:(UMDiameterPeer *)peer;

- (void)processIncomingErrorPacket:(UMDiameterPacket *)packet
                            router:(UMDiameterRouter *)router
                              peer:(UMDiameterPeer *)peer;

- (void)processIncomingResponsePacket:(UMDiameterPacket *)packet
                               router:(UMDiameterRouter *)router
                                 peer:(UMDiameterPeer *)peer;


- (void)sendOutgoingRequestPacket:(UMDiameterPacket *)packet peer:(UMDiameterPeer *)peer;
- (void)sendOutgoingErrorPacket:(UMDiameterPacket *)packet peer:(UMDiameterPeer *)peer;
- (void)sendOutgoingResponsePacket:(UMDiameterPacket *)packet peer:(UMDiameterPeer *)peer;

+ (NSString *)localIdentifierFromEndToEndIdentifier:(uint32_t)e2e;
+ (NSString *)remoteIdentifierFromEndToEndIdentifier:(uint32_t)e2e host:(NSString *)host;

@end
