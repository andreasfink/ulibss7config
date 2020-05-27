//
//  UMSS7ApiTaskSCCP_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCP.h"

@implementation UMSS7ApiTaskSCCP_add

+ (NSString *)apiPath
{
    return @"/api/sccp-add";
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
        UMSS7ConfigSCCP *sccp = [cs getSCCP:name];
        if(sccp!=NULL)
        {
            [self sendErrorAlreadyExisting];
        }
        else
        {
        
            @try
            {
                sccp = [[UMSS7ConfigSCCP alloc]initWithConfig:_params];
                UMSynchronizedSortedDictionary *config = sccp.config;
                [_appDelegate addWithConfigSCCP:config.dictionaryCopy];
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
