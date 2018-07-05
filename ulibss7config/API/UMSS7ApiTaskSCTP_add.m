//
//  UMSS7ApiTaskSCTP_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCTP.h"

@implementation UMSS7ApiTaskSCTP_add


+ (NSString *)apiPath
{
    return @"/api/sctp-add";
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
    UMSS7ConfigSCTP *sctp = [cs getSCTP:name];
    if(sctp!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
		{
			sctp = [[UMSS7ConfigSCTP alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = sctp.config;
			[_appDelegate addWithConfigSCTP:config.dictionaryCopy];
			[self sendResultObject:config];
		}
        @catch(NSException *e)
        {
			[self sendException:e];
        }
    }
}

@end
