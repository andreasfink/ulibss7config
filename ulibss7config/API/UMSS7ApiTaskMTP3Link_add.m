//
//  UMSS7ApiTaskMTP3Link_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Link_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3Link.h"

@implementation UMSS7ApiTaskMTP3Link_add

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-add";
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
        UMSS7ConfigMTP3Link *mtp3link = [cs getMTP3Link:name];
        if(mtp3link!=NULL)
        {
            [self sendErrorAlreadyExisting];
        }
        else
        {
            @try
            {
                mtp3link = [[UMSS7ConfigMTP3Link alloc]initWithConfig:_params];
                UMSynchronizedSortedDictionary *config = mtp3link.config;
                [_appDelegate addWithConfigMTP3Link:config.dictionaryCopy];
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

