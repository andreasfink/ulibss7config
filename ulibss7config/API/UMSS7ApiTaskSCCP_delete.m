//
//  UMSS7ApiTaskSCCP_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCP.h"

@implementation UMSS7ApiTaskSCCP_delete

+ (NSString *)apiPath
{
    return @"/api/sccp-delete";
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
	
    NSString *name = _params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];

    UMSS7ConfigSCCP *config_object = [cs getSCCP:name];
    UMLayerSCCP *instance = [_appDelegate getSCCP:name];
    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteSCCP:name];
        [_appDelegate deleteSCCP:name];
        [self sendResultOK];
    }
}
@end
