//
//  UMSS7ApiTask.h
//  estp
//
//  Created by Andreas Fink on 12.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>

#import "UMSS7ConfigAppDelegateProtocol.h"
@class UMSS7ApiSession;
@interface UMSS7ApiTask : UMTask
{
    UMHTTPRequest   *_webRequest;
    id<UMSS7ConfigAppDelegateProtocol> _appDelegate;
    UMSS7ApiSession      *_apiSession;
}

- (UMSS7ApiTask *)initWithWebRequest:(UMHTTPRequest *)webRequest appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad;
+ (NSString *)apiPath;
- (void)main;
+ (UMSS7ApiTask *)apiFactory:(UMHTTPRequest *)req appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad;
+ (NSArray *)apiPathList;

- (void)sendErrorNotFound;
- (void)sendErrorAlreadyExisting;
- (void)sendErrorNotImplemented;
- (void)sendErrorUnknownAction;
- (void)sendResultOK;
- (void)sendResultObject:(id)result;
- (void)sendErrorNotAuthenticated;
- (void)sendErrorNotAuthorized;
- (BOOL) isAuthenticated;
- (BOOL) isAuthorized;
- (void)sendException:(NSException *)e;

@end
