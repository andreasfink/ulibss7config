//
//  UMSS7ApiTaskSS7FilterActionList_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterActionList_delete


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-delete";
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
                if(name.length==0)
                {
                    [self sendError:@"missing-parameter"  reason:@"'name' parameter is not passed"];
                }
                else if(stagingArea.filter_action_list_dict[name]== 0)
                {
                    [self sendErrorNotFound:name];
                }
                else
                {
                    [stagingArea.filter_action_list_dict removeObjectForKey:name];
                    [self sendResultOK];
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
