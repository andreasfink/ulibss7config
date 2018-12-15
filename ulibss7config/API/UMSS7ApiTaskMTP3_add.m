//
//  UMSS7ApiTaskMTP3_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3.h"

@implementation UMSS7ApiTaskMTP3_add

+ (NSString *)apiPath
{
    return @"/api/mtp3-add";
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

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigMTP3 *mtp3 = [cs getMTP3:name];
    if(mtp3!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
		{
			mtp3 = [[UMSS7ConfigMTP3 alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = mtp3.config;
			[_appDelegate addWithConfigMTP3:config.dictionaryCopy];
			[self sendResultObject:config];
		}
        @catch(NSException *e)
        {
			[self sendException:e];
        }
    }
}

@end

