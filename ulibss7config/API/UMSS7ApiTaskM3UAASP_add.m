//
//  UMSS7ApiTaskM3UAASP_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM3UAASP.h"

@implementation UMSS7ApiTaskM3UAASP_add

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-add";
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
        UMSS7ConfigM3UAASP *m3uaasp = [cs getM3UAASP:name];
        if(m3uaasp!=NULL)
        {
            [self sendErrorAlreadyExisting];
        }
        else
        {
            @try
            {
                m3uaasp = [[UMSS7ConfigM3UAASP alloc]initWithConfig:_params];
                UMSynchronizedSortedDictionary *config = m3uaasp.config;
                [_appDelegate addWithConfigM3UAASP:config.dictionaryCopy];
                [self sendResultObject:config];
            }
            @catch(NSException *e)
            {
                [self sendException:e];
            }
        }
    }
}

@end
