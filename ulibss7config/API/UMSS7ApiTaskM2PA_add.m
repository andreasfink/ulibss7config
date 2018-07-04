//
//  UMSS7ApiTaskM2PA_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM2PA.h"

@implementation UMSS7ApiTaskM2PA_add

+ (NSString *)apiPath
{
    return @"/api/m2pa-add";
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
    UMSS7ConfigM2PA *m2pa = [cs getM2PA:name];
    if(m2pa!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
		{
			m2pa = [[UMSS7ConfigM2PA alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = m2pa.config;
			[_appDelegate addWithConfigM2PA:config.dictionaryCopy];
			[self sendResultObject:config];
		}
        @catch(NSException *e)
        {
			[self sendException:e];
        }
    }
}

@end
