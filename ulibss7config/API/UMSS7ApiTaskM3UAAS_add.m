//
//  UMSS7ApiTaskM3UAAS_add.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAAS_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM3UAAS.h"

@implementation UMSS7ApiTaskM3UAAS_add

+ (NSString *)apiPath
{
    return @"/api/m3ua-as-add";
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
    UMSS7ConfigM3UAAS *m3uaas = [cs getM3UAAS:name];
    if(m3uaas!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
		{
			m3uaas = [[UMSS7ConfigM3UAAS alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = m3uaas.config;
			[_appDelegate addWithConfigM3UA_AS:config.dictionaryCopy];
			[self sendResultObject:config];
		}
        @catch(NSException *e)
        {
			[self sendException:e];
        }
    }
}

@end


