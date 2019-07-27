//
//  UMSS7ApiTaskSCCPTranslationTable_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskSCCPTranslationTable_list



+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-list";
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

    NSString *sccp_name = _params[@"sccp"];
    sccp_name = [UMSS7ConfigObject filterName:sccp_name];

    NSArray *sccp_names;
    if(sccp_name.length == 0)
    {
        sccp_names = [_appDelegate getSCCPNames];
    }
    else
    {
        sccp_names = @[sccp_name];
    }

    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    for(sccp_name in sccp_names)
    {
        UMLayerSCCP *instance = [_appDelegate getSCCP:sccp_name];
        dict[sccp_name] = [instance.gttSelectorRegistry listSelectorNames];
    }
    [self sendResultObject:dict];
}

@end

