//
//  UMSS7ApiTaskMTP3_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3.h"

@implementation UMSS7ApiTaskMTP3_delete

+ (NSString *)apiPath
{
    return @"/api/mtp3-delete";
}

- (void)main
{
    @autoreleasepool
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

        UMSS7ConfigMTP3 *config_object = [cs getMTP3:name];
        UMLayerMTP3 *instance = [_appDelegate getMTP3:name];
        if((instance!=NULL) || (config_object==NULL))
        {
            [self sendErrorNotFound];
        }
        else
        {
            [cs deleteMTP3:name];
            [_appDelegate deleteMTP3:name];
            [self sendResultOK];
        }
    }
}
@end
