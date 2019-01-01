//
//  UMSS7ApiTaskSCCP_read.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCP.h"

@implementation UMSS7ApiTaskSCCPTranslationTable_read

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-read";
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

    NSString *sccp_name = _webRequest.params[@"sccp"];
	sccp_name = [UMSS7ConfigObject filterName:sccp_name];

    NSString *selector_name = _webRequest.params[@"name"];
    selector_name = [UMSS7ConfigObject filterName:selector_name];

    if(sccp_name.length ==0)
    {
        [self sendErrorMissingParameter:@"sccp"];
    }
    if(selector_name.length ==0)
    {
        [self sendErrorMissingParameter:@"name"];
    }

    UMLayerSCCP *instance = [_appDelegate getSCCP:sccp_name];
	if(instance==NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
        UMSynchronizedSortedDictionary *config = [instance.gttSelectorRegistry config];
        if(config==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
            UMSynchronizedSortedDictionary *dict = config[selector_name];
            if(dict ==NULL)
            {
                [self sendErrorNotFound];
            }
            else
            {
                [self sendResultObject:dict];
            }
        }
    }
}

@end


