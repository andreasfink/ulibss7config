//
//  UMSS7ConfigAppDelegateProtocol.h
//  ulibss7config
//
//  Created by Andreas Fink on 06.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibgsmmap/ulibgsmmap.h>

@class UMSS7ConfigStorage;
@class UMSS7ApiSession;

@protocol UMSS7ConfigAppDelegateProtocol<NSObject,
    UMLayerSctpApplicationContextProtocol,
    UMLayerM2PAApplicationContextProtocol,
    UMLayerMTP3ApplicationContextProtocol,
    UMLayerSCCPApplicationContextProtocol>

@property(readwrite,strong,atomic)  UMSS7ConfigStorage *runningConfig;
@property(readwrite,strong,atomic)  UMSS7ConfigStorage *startupConfig;
@property(readwrite,strong,atomic)  UMCommandLine *commandLine;
- (void)applicationGoToHot;
- (void)applicationGoToStandby;

- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
realm:(NSString **)realm;

- (UMLayerSctp *)getSCTP:(NSString *)name;
- (void)addWithConfigSCTP:(NSDictionary *)config;
- (void)deleteSCTP:(NSString *)name;
- (void)renameSCTP:(NSString *)old to:(NSString *)new;

- (UMLayerM2PA *)getM2PA:(NSString *)name;
- (void)addWithConfigM2PA:(NSDictionary *)config;
- (void)deleteM2PA:(NSString *)name;
- (void)renameM2PA:(NSString *)old to:(NSString *)new;

- (UMLayerMTP3 *)getMTP3:(NSString *)name;
- (void)addWithConfigMTP3:(NSDictionary *)config;
- (void)deleteMTP3:(NSString *)name;
- (void)renameMTP3:(NSString *)old to:(NSString *)new;

- (UMMTP3Link *)getMTP3_Link:(NSString *)name;
- (void)addWithConfigMTP3_Link:(NSDictionary *)config;
- (void)deleteMTP3Link:(NSString *)name;
- (void)renameMTP3Link:(NSString *)old to:(NSString *)new;

- (UMMTP3LinkSet *)getMTP3_LinkSet:(NSString *)name;
- (void)addWithConfigMTP3_LinkSet:(NSDictionary *)config;
- (void)deleteMTP3Linkset:(NSString *)name;
- (void)renameMTP3Linkset:(NSString *)old to:(NSString *)new;

- (UMM3UAApplicationServer *)getM3UA_AS:(NSString *)name;
- (void)addWithConfigM3UA_AS:(NSDictionary *)config;
- (void)deleteM3UAAS:(NSString *)name;
- (void)renameM3UAAS:(NSString *)old to:(NSString *)new;

- (UMM3UAApplicationServerProcess *)getM3UA_ASP:(NSString *)name;
- (void)addWithConfigM3UA_ASP:(NSDictionary *)config;
- (void)deleteM3UAASP:(NSString *)name;
- (void)renameM3UAASP:(NSString *)old to:(NSString *)new;

- (UMLayerSCCP *)getSCCP:(NSString *)name;
- (void)addWithConfigSCCP:(NSDictionary *)config;
- (void)deleteSCCP:(NSString *)name;
- (void)renameSCCP:(NSString *)old to:(NSString *)new;

- (void)addApiSession:(UMSS7ApiSession *)session;
- (void)removeApiSession:(NSString *)sessionKey;
- (UMSS7ApiSession *)getApiSession:(NSString *)sessionKey;


@optional
- (UMLayerSCCP *)getTCAP:(NSString *)name;
- (void)addWithConfigTCAP:(NSDictionary *)config;
- (void)deleteTCAP:(NSString *)name;
- (void)renameTCAP:(NSString *)old to:(NSString *)new;

- (UMLayerSCCP *)getGSMMAP:(NSString *)name;
- (void)addWithConfigGSMMAP:(NSDictionary *)config;
- (void)deleteGSMMAP:(NSString *)name;
- (void)renameGSMMAP:(NSString *)old to:(NSString *)new;

@end
