//
//  UMSS7ApiTaskSCTP_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCTP.h"

@implementation UMSS7ApiTaskSCTP_delete

+ (NSString *)apiPath
{
    return @"/api/sctp-delete";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    if(![self isAuthorized])
    {
        [self sendErrorNotAuthorized];
        return;
    }

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];

    UMSS7ConfigSCTP *config_object = [cs getSCTP:name];
    UMLayerSctp *instance = [_appDelegate getSCTP:name];
    if((instance==NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteSCTP:name];
        [_appDelegate deleteSCTP:name];
        [self sendResultOK];
    }
}

@end
