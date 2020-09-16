//
//  UMSS7ApiTaskNamedlist_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_read.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_read


+ (NSString *)apiPath
{
    return @"/api/namedlist-read";
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
            NSString *listName = _params[@"name"];
            listName = [UMSS7ConfigObject filterName:listName];
            if(listName.length==0)
            {
                /* backwards compatibility to old api of SMSProx4 */
                listName = _params[@"list"];
                listName = [UMSS7ConfigObject filterName:listName];
            }

            if(listName.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'list' parameter is not passed"];
            }
            else
            {
                // 2. Read
                NSArray *ls = [_appDelegate namedlistList:listName];
                [self sendResultObject:ls];
            }
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}

@end
