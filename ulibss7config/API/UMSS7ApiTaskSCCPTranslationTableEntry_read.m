//
//  UMSS7ApiTaskSCCPTranslationTableEntry_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_read.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_read

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-read";
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

    NSString *sccp_name     = _webRequest.params[@"sccp"];
    if(sccp_name.length==0)
    {
        [self sendErrorMissingParameter:@"sccp"];
        return;
    }
    NSString *table_name    = _webRequest.params[@"translation-table"];
    if(table_name.length==0)
    {
        [self sendErrorMissingParameter:@"translation-table"];
    }

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigSCCPTranslationTableEntry *entry = [cs getSCCPTranslationTableEntry:name];
    if(entry==NULL)
    {
        [self sendErrorNotFound];
        return;
    }
    [self sendResultObject:entry.config];
}

@end
