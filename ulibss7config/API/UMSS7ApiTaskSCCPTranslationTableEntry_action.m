//
//  UMSS7ApiTaskSCCPTranslationTableEntry_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_action.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_action

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-action";
}


- (SccpGttRoutingTableEntry *)getRoutingTableEntryByDigits
{
    SccpGttRoutingTable *rt = [self getRoutingTable];
    if(rt==NULL)
    {
        [self sendErrorNotFound:@"routing-table"];
        return NULL;
    }

    NSString *digits     = _webRequest.params[@"digits"];
    if(digits.length==0)
    {
        [self sendErrorNotFound:@"digits"];
        return NULL;
    }

    SccpGttRoutingTableEntry *rte = [rt findEntryByDigits:digits];
    return rte;
}

@end
