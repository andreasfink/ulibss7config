//
//  UMSS7ApiTaskSS7FilterActionList_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterActionList_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-modify";
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
        
        // 1. Get Staging Area
        UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
        if(stagingArea == NULL)
        {
            [self sendErrorNotFound:@"staging-area"];
        }
        else
        {
            @try
            {
                NSString *name = _params[@"name"];
                UMSS7ConfigSS7FilterActionList *ls = stagingArea.filter_action_list_dict[name];
                if(ls == NULL)
                {
                    [self sendErrorNotFound:name];
                }
                else
                {
                    [ls setConfig:_params];
                    [stagingArea setDirty:YES];
                    [self sendResultObject:ls.config];
                }
            }
            @catch(NSException *e)
            {
                [self sendException:e];
            }
        }
    }
}

@end
