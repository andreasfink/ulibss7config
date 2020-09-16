//
//  UMSS7ApiTaskNamedlist_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_list


+ (NSString *)apiPath
{
    return @"/api/namedlist-list";
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
        
        @try
        {
            // 1. Get external parameters
            NSString *listName = [_params[@"name"] urldecode];
            listName = [UMSS7ConfigObject filterName:listName];
            if(listName.length==0)
            {
                /* backwards compatibility to old api of SMSProx4 */
                listName = [_params[@"list"] urldecode];
                listName = [UMSS7ConfigObject filterName:listName];
            }
            if(listName.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'list' or 'name' parameter is not passed"];
                return;
            }
            NSArray *items = [_appDelegate namedlistList:listName];
            [self sendResultObject:items];
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}
@end
