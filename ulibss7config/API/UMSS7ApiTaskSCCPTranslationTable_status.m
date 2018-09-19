//
//  UMSS7ApiTaskSCCPTranslationTable_status.m
//  estp
//
//  Created by Andronikos Stathis on 6.09.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCP.h"
#import <ulibsccp/ulibsccp.h>

@implementation UMSS7ApiTaskSCCPTranslationTable_status

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-status";
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
    UMSS7ConfigSCCPTranslationTable *co = [cs getSCCPTranslationTable:name];
	
	if(sccp)
	{
		UMSynchronizedSortedDictionary *dict = [_appDelegate statusSCCPTranslationTable:name tt:co.tt gti:co.gti np:co.np nai:co.nai];
		[self sendResultObject:dict];
	}
	else
	{
		[self sendErrorNotFound];
	}
}
@end
