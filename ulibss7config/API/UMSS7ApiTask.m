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
#import "ulibgt/ulibgt.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTask

- (UMSS7ApiTask *)initWithWebRequest:(UMHTTPRequest *)webRequest appDelegate:(id<UMSS7ConfigAppDelegateProtocol>)ad
{
    NSString *apiName = [[self class]description];
    self = [super initWithName:apiName];
    if(self)
    {
        _webRequest = webRequest;
        _params = [_webRequest.params urldecodeStringValues];
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


    /*
        backwards compatibility. In old SMSProxy4 the API calls things where named with an underscore
        ex /api/namedlist_add instead of /api/namedlist-add
        So we rename calls to old API with new API name
     */

    if([path hasPrefix:@"/api/namedlist_"])
    {
        path = [NSString stringWithFormat:@"/api/namedlist-%@", [path substringFromIndex:15]];
    }

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
#define API(APICLASS) {\
     NSString *s = [APICLASS apiPath]; \
    if([s isEqualToString:@"/api"]) \
    {\
NSLog(@"%s is not returning an apiPath!",#APICLASS); \
    } \
    else \
    {\
        [a addObject:[APICLASS apiPath]];\
    }\
}

#include "UMSS7ApiTaskAll.txt"
#undef API
    return a;
}


- (void)sendError:(NSString *)err
{
    [_webRequest setResponseJsonObject:@{ @"error" : err }];
    [_webRequest resumePendingRequest];
}

- (void)sendErrorNotFound
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"not-found" }];
    [_webRequest resumePendingRequest];
}

- (void)sendErrorNotFound:(NSString *)param
{
    if(param.length > 0)
    {
        [_webRequest setResponseJsonObject:@{ @"error" : @"not-found", @"parameter" : param }];
    }
    else
    {
        [_webRequest setResponseJsonObject:@{ @"error" : @"not-found" }];
    }
    [_webRequest resumePendingRequest];
}

- (void)sendErrorMissingParameter:(NSString *)param
{
    if(param)
    {
        [_webRequest setResponseJsonObject:@{ @"error" : @"missing-parameter", @"parameter" : param }];
    }
    else
    {
        [_webRequest setResponseJsonObject:@{ @"error" : @"missing-parameter" }];
    }
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

- (void)sendErrorNotAuthorized
{
    [_webRequest setResponseJsonObject:@{ @"error" : @"not-authorized" }];
    [_webRequest resumePendingRequest];
}

- (BOOL)isAuthenticated
{
    NSString *username = _params[@"username"];
    NSString *password = _params[@"password"];
    NSString *session_key = _params[@"session-key"];
    if(session_key.length > 0)
    {
        _apiSession = [_appDelegate getApiSession:session_key];
    }
    else if((session_key.length == 0)  && (username.length > 0) && (password.length > 0))
    {
        UMSS7ConfigApiUser *user = [_appDelegate.runningConfig getApiUser:username];
        if(user)
        {
            if([password isEqualToString:user.password])
            {
                _apiSession = [[UMSS7ApiSession alloc]initWithHttpRequest:_webRequest user:user];
                [_appDelegate addApiSession:_apiSession];
            }
        }
    }
    if(_apiSession)
    {
        [_apiSession touch];
        return YES;
    }
    return NO;
}

- (BOOL)isAuthorized
{
    /* this will be expanded in the future to more fine grained user authorisation method. For now a user can do all or nothing */
    return YES;
}

-(void)sendException:(NSException *)e
{
	NSMutableDictionary *d1 = [[NSMutableDictionary alloc]init];
	if(e.name)
	{
		d1[@"name"] = e.name;
	}
	if(e.reason)
	{
		d1[@"reason"] = e.reason;
	}
	if(e.userInfo)
	{
		d1[@"user-info"] = e.userInfo;
	}
	
	NSDictionary *d =   @{ @"error" : @{ @"exception": d1 } };
	
    [_webRequest setResponseJsonObject:@{ @"exception" : d }];
    [_webRequest resumePendingRequest];
}



- (SccpGttSelector *)getGttSelector
{
    NSString *sccp_name     = _params[@"sccp"];
    if(sccp_name.length==0)
    {
        [self sendErrorMissingParameter:@"sccp"];
        return NULL;
    }

    UMLayerSCCP *sccp_instance = [_appDelegate getSCCP:sccp_name];
    if(sccp_instance==NULL)
    {
        [self sendErrorNotFound:@"sccp"];
        return NULL;
    }
    NSString *table_name    = _params[@"translation-table"];
    if(table_name.length==0)
    {
        [self sendErrorMissingParameter:@"translation-table"];
        return NULL;
    }

    SccpGttSelector *selector = [sccp_instance.gttSelectorRegistry getSelectorByName:table_name];
    if(selector==NULL)
    {
        [self sendErrorNotFound:@"translation-table"];
        return NULL;
    }
    return selector;
}

- (SccpGttRoutingTable *)getRoutingTable
{
    SccpGttSelector *selector = [self getGttSelector];
    if(selector==NULL)
    {
        return NULL;
    }
    SccpGttRoutingTable *rt = selector.routingTable;
    if(rt==NULL)
    {
        [self sendErrorNotFound:@"translation-table.routing-table"];
        return NULL;
    }
    return rt;
}

- (SccpGttRoutingTableEntry *)getRoutingTableEntryByDigits
{
    SccpGttRoutingTable *rt = [self getRoutingTable];
    if(rt==NULL)
    {
        return NULL;
    }

    NSString *digits     = _params[@"digits"];
    if(digits.length==0)
    {
        [self sendErrorNotFound:@"digits"];
        return NULL;
    }
    SccpGttRoutingTableEntry *rte = [rt findEntryByDigits:digits];
    return rte;
}


- (SccpGttRoutingTableEntry *)getRoutingTableEntryByName
{
    SccpGttRoutingTable *rt = [self getRoutingTable];
    if(rt==NULL)
    {
        return NULL;
    }

    NSString *name     = _params[@"name"];
    if(name.length==0)
    {
        [self sendErrorNotFound:@"name"];
        return NULL;
    }
    SccpGttRoutingTableEntry *rte = [rt findEntryByName:name];
    return rte;
}

@end

