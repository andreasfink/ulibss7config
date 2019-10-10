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
        if(listName.length==0)
        {
            /* backwards compatibility to old api of SMSProx4 */
            listName = _params[@"list"];
        }
		if(listName.length==0)
		{
            [self sendError:@"missing-parameter" reason:@"the 'list' parameter is not passed"];
		}
		else
		{
			// 2. list namedlists
 			UMSynchronizedArray *names = [_appDelegate namedlist_lists];
			NSArray *list = [names arrayCopy];
			BOOL ok = NO;
			for(NSString *ls in list)
			{
				if([ls isEqualToString:listName] )
				{
					ok = YES;
					break;
				}
			}
			
			if(ok)
			{
				[self sendResultObject:listName];
			}
			else
			{
				[self sendErrorNotFound:listName];
			}
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}
@end
