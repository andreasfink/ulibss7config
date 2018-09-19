//
//  UMSS7ApiTaskSCCPTranslationTable_add.m
//  estp
//
//  Created by Andronikos Stathis on 05.09.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCP.h"
#import "UMSS7ConfigSCCPTranslationTable.h"

@implementation UMSS7ApiTaskSCCPTranslationTable_add

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-add";
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
	
    UMLayerSCCP *sccp = [_appDelegate getSCCP:name];
    if(sccp != NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
        {
			UMSS7ConfigSCCPTranslationTable *co = [[UMSS7ConfigSCCPTranslationTable alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = co.config;
            //[_appDelegate addSCCPTranslationTable:config.dictionaryCopy];
            [cs addSCCPTranslationTable:config.dictionaryCopy];
			[self sendResultObject:config];
		}
        @catch(NSException *e)
        {
			[self sendException:e];
        }
    }
}

@end
