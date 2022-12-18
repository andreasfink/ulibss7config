//
//  UMSS7ApiTask.h
//  estp
//
//  Created by Andreas Fink on 12.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>
#import <ulibgt/ulibgt.h>
#import <ulibsccp/ulibsccp.h>

#import "UMSS7ConfigAppDelegateProtocol.h"
@class UMSS7ApiSession;
@interface UMSS7ApiTask : UMTaskQueueTask
{
    UMHTTPRequest                       *_webRequest;
    NSDictionary                        *_params;
    id<UMSS7ConfigAppDelegateProtocol>  _appDelegate;
    UMSS7ApiSession                     *_apiSession;
    UMHistoryLog                        *_history;
}

- (UMSS7ApiTask *)initWithWebRequest:(UMHTTPRequest *)webRequest appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad;
+ (NSString *)apiPath;
+ (BOOL)doNotList;
- (void)main;
+ (UMSS7ApiTask *)apiFactory:(UMHTTPRequest *)req appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad;
+ (NSArray *)apiPathList;

- (void)sendResultHtml:(NSString *)html;
- (void)sendError:(NSString *)err;
- (void)sendError:(NSString *)err reason:(NSString *)reason;
- (void)sendErrorNotFound;
- (void)sendErrorNotFound:(NSString *)param;
- (void)sendErrorAlreadyExisting;
- (void)sendErrorNotImplemented;
- (void)sendErrorSessionExpired;
- (void)sendErrorUnknownAction;
- (void)sendResultOK;
- (void)sendResultObject:(id)result;
- (void)sendErrorNotAuthenticated;
- (void)sendErrorNotAuthorised;
- (void)sendErrorMissingParameter:(NSString *)param;
- (BOOL) isAuthenticated;
- (BOOL) isAuthorised;
- (void)sendException:(NSException *)e;
- (SccpGttSelector *)getGttSelector;
- (SccpGttRoutingTable *)getRoutingTable;
- (SccpGttRoutingTableEntry *)getRoutingTableEntryByDigits;
- (SccpGttRoutingTableEntry *)getRoutingTableEntryByName;

@end
