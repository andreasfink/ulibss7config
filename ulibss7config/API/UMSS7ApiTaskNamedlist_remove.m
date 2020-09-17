//
//  UMSS7ApiTaskNamedlist_remove.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_remove.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

//#define DEBUG 1

@implementation UMSS7ApiTaskNamedlist_remove


+ (NSString *)apiPath
{
    return @"/api/namedlist-remove";
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
            NSString *value = [_params[@"value"] urldecode];

            if(listName.length==0)
            {
                /* backwards compatibility to old api of SMSProx4 */
                listName = [_params[@"list"] urldecode];
                listName = [UMSS7ConfigObject filterName:listName];
            }
            if(listName.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'list' parameter is not passed"];
                return;
            }

            if(value.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'value' parameter is not passed"];
                return;
            }
            if([value isEqualToString:@"_dirty"])
            {
                [self sendError:@"invalid-parameter" reason:@"the value '_dirty' is a reserved value"];
                return;
            }
            
            // 2. Remove if value is contained in list
            if(_appDelegate==NULL)
            {
                [self sendError:@"internal-error" reason:@"app-delegate is NULL"];
                return;
            }
#ifdef  DEBUG
            NSLog(@"calling [_appDelegate namedlistRemove:%@ value:%@]",listName,value);
#endif
            [_appDelegate namedlistRemove:listName value:value];
            [self sendResultOK];
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}
@end
