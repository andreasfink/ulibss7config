//
//  UMSS7ApiTaskSCCPTranslationTableEntry_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_list.h"


#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_list



+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-list";
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

    SccpGttRoutingTable *rt = [self getRoutingTable];
    if(rt==NULL)
    {
        return;
    }
    NSArray *a = rt.list.allKeys;
    [self sendResultObject:a];
}

@end

