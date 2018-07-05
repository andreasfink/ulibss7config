//
//  UMSS7ApiTaskMTP3Linkset_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Linkset_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3Link.h"

@implementation UMSS7ApiTaskMTP3Linkset_add

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-add";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigMTP3Linkset *mtp3linkset = [cs getMTP3Linkset:name];
    if(mtp3linkset!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
		{
			mtp3linkset = [[UMSS7ConfigMTP3Linkset alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = mtp3linkset.config;
			[_appDelegate addWithConfigMTP3_LinkSet:config.dictionaryCopy];
			[self sendResultObject:config];
		}
        @catch(NSException *e)
        {
			[self sendException:e];
        }
    }
}

@end


