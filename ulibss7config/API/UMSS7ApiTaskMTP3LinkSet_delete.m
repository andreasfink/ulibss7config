//
//  UMSS7ApiTaskMTP3LinkSet_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3LinkSet.h"

@implementation UMSS7ApiTaskMTP3LinkSet_delete

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-delete";
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

    UMSS7ConfigMTP3LinkSet *config_object = [cs getMTP3LinkSet:name];
    UMMTP3LinkSet *instance = [_appDelegate getMTP3LinkSet:name];
    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteMTP3LinkSet:name];
        [_appDelegate deleteMTP3LinkSet:name];
        [self sendResultOK];
    }
}
@end
