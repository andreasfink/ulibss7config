//
//  UMSS7ApiTaskNamedlist_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_add


+ (NSString *)apiPath
{
    return @"/api/namedlist-add";
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
        NSString *listName = [_params[@"name"] urldecode];
		NSString *value = [_params[@"value"] urldecode];
		if(listName.length==0)
		{
            listName = [_params[@"list"] urldecode];
            if(listName.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'name' parameter is not passed"];
                return;
            }
		}
		
        if(value.length==0)
		{
            [self sendError:@"missing-parameter" reason:@"the 'value' parameter is not passed"];
            return;
		}
        [_appDelegate namedlistAdd:listName value:value];
        [self sendResultOK];
    }
	@catch(NSException *e)
	{
		[self sendException:e];
	}
}
@end
