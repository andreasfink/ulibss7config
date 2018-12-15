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

    NSString *name = _webRequest.params[@"name"];
	name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
	
    UMLayerSCCP *instance = [_appDelegate getSCCP:name];
    UMSS7ConfigSCCPTranslationTable *co = [cs getSCCPTranslationTable:name];
	if(co==NULL || instance==NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
		// Find sccp layer by name and then return RoutingTable  by _gti, _np, _nai, _tt
		UMSynchronizedSortedDictionary *dict = [_appDelegate readSCCPTranslationTable:name tt:co.tt gti:co.gti np:co.np nai:co.nai];
		[self sendResultObject:dict];
    }
}

@end


