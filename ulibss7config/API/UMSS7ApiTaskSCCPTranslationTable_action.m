//
//  UMSS7ApiTaskSCCPTranslationTable_action.m
//  estp
//
//  Created by Andronikos Stathis on 10.09.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCP.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskSCCPTranslationTable_action

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-action";
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
	
    NSString *action = _webRequest.params[@"action"];
    UMLayerSCCP *sccp = [_appDelegate getSCCP:name];
    UMSS7ConfigSCCPTranslationTable *co = [cs getSCCPTranslationTable:name];
    if(sccp != NULL && co != NULL)
    {
        if([action isEqualToString:@"action-list"])
        {
            [self sendResultObject:@[ @"activate", @"deactivate", @"clone"]];
        }
        else if([action isEqualToString:@"activate"])
        {
            UMSynchronizedSortedDictionary *dict = [_appDelegate activateSCCPTranslationTable:name tt:co.tt gti:co.gti np:co.np nai:co.nai on:YES];
			[self sendResultObject:dict];

        }
        else if([action isEqualToString:@"deactivate"])
        {
            UMSynchronizedSortedDictionary *dict = [_appDelegate activateSCCPTranslationTable:name tt:co.tt gti:co.gti np:co.np nai:co.nai on:NO];
			[self sendResultObject:dict];
        }
        else if([action isEqualToString:@"clone"])
        {
			UMSynchronizedSortedDictionary *c = [_appDelegate cloneSCCPTranslationTable:co.config.dictionaryCopy];
			[self sendResultObject:c];
        }
        else
        {
            [self sendErrorUnknownAction];
        }
    }
    else
    {
        [self sendErrorNotFound];
    }
}
@end
