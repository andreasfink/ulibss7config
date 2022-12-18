//
//  UMSS7ApiTaskNamedlist_contains.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_contains.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_contains


+ (NSString *)apiPath
{
    return @"/api/namedlist-contains";
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

            NSString *value = [_params[@"value"] urldecode];
            if(listName.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'list' parameter is not passed"];
            }
            else if(value.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'value' parameter is not passed"];
            }
            else if([value isEqualToString:@"_dirty"])
            {
                [self sendError:@"invalid-parameter" reason:@"the value '_dirty' is a reserved value"];
            }
            else
            {
                // 2. Checking if value is contained in list
                BOOL ok = [_appDelegate namedlistContains:listName value:value];
                NSString *reply = ok ? @"YES" : @"NO";
                [self sendResultObject:reply];
            }
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}
@end
