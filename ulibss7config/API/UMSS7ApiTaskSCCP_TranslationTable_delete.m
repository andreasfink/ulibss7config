//
//  UMSS7ApiTaskSCCP_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_TranslationTable_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTable.h"

@implementation UMSS7ApiTaskSCCP_TranslationTable_delete

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-delete";
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

    UMSS7ConfigSCCPTranslationTable *co = [cs getSCCPTranslationTable:name];
    if(co==NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteSCCPTranslationTable:name];
        [self sendResultOK];
    }
}
@end
