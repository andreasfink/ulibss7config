//
//  UMSS7ApiTaskM3UAASP_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM3UAASP.h"

@implementation UMSS7ApiTaskM3UAASP_delete

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-delete";
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
        
        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }
        
        NSString *name = _params[@"name"];
        name = [UMSS7ConfigObject filterName:name];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];

        UMSS7ConfigM3UAASP *config_object = [cs getM3UAASP:name];
        UMM3UAApplicationServerProcess *instance = [_appDelegate getM3UAASP:name];
        if((instance!=NULL) || (config_object==NULL))
        {
            [self sendErrorNotFound];
        }
        else
        {
            [cs deleteM3UAASP:name];
            [_appDelegate deleteM3UAASP:name];
            [self sendResultOK];
        }
    }
}
@end
