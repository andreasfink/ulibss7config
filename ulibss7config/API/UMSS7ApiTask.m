//
//  UMSS7ApiTask.m
//  estp
//
//  Created by Andreas Fink on 12.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTask.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiTaskAll.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTask

- (UMSS7ApiTask *)initWithWebRequest:(UMHTTPRequest *)webRequest appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad
{
    NSString *apiName = [[self class]description];
    self = [super initWithName:apiName];
    if(self)
    {
        _webRequest = webRequest;
        _appDelegate = ad;
        [_webRequest makeAsync];
    }
    return self;
}

+ (NSString *)apiPath
{
    return @"/api";
}

- (void)main 
{
    [self sendErrorNotImplemented];
}

+ (UMSS7ApiTask *)apiFactory:(UMHTTPRequest *)req appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad
{
    NSString *path = req.url.relativePath;

#define API(APICLASS) \
    if([path isEqualTo:[APICLASS apiPath]]) \
    { \
        return [[APICLASS alloc]initWithWebRequest:req appDelegate:ad]; \
    }
#include "UMSS7ApiTaskAll.txt"
#undef API

    /* if all fails, the superclass will get caled and return "not implemented" */
    return [[UMSS7ApiTask alloc]initWithWebRequest:req appDelegate:ad];
}

+ (NSArray *)apiPathList
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
#define API(APICLASS)  [a addObject:[APICLASS apiPath]];
#include "UMSS7ApiTaskAll.txt"
#undef API
    return a;
}


- (void)sendErrorNotFound
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"not-found" }];
    [_webRequest resumePendingRequest];
}

- (void)sendErrorUnknownAction
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"unkown-action" }];
    [_webRequest resumePendingRequest];
}

- (void)sendErrorAlreadyExisting
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"already-existing" }];
    [_webRequest resumePendingRequest];
}

-(void)sendResultOK
{
    [_webRequest setResponseJsonObject:@{ @"result" : @"ok" }];
    [_webRequest resumePendingRequest];
}

-(void)sendResultObject:(id)result
{
    [_webRequest setResponseJsonObject:@{ @"result" : result }];
    [_webRequest resumePendingRequest];
}

- (void)sendErrorNotImplemented
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"not-implemented" }];
    [_webRequest resumePendingRequest];
}

- (void)sendErrorNotAuthenticated
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"not-authenticated" }];
    [_webRequest resumePendingRequest];
}

- (BOOL)isAuthenticated
{
    NSString *session_key = _webRequest.params[@"session-key"];
    _apiSession = [_appDelegate getApiSession:session_key];
    if(_apiSession)
    {
        [_apiSession touch];
        return YES;
    }
    return NO;
}
@end

