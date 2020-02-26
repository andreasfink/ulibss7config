//
//  UMSS7ApiTaskMTP3PointCodeTranslationTable_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3PointCodeTranslationTable_list.h"
#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ApiTaskMacros.h"

@implementation UMSS7ApiTaskMTP3PointCodeTranslationTable_list

+ (NSString *)apiPath
{
    return @"/api/mtp3-pointcode-translation-table-list";
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

    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    NSArray *names = [cs getPointcodeTranslationTables];

    int details = [((NSString *)_params[@"details"]) intValue];
    switch(details)
    {
         case 0:
         default:
            [self sendResultObject:names];
             break;
         case 1:
         case 2:
             {
                 NSMutableArray *entries = [[NSMutableArray alloc]init];
                 for(NSString *name in names)
                 {
                     UMSS7ConfigMTP3PointCodeTranslationTable *obj = [cs getPointcodeTranslationTable:name];
                     if(obj)
                     {
                         [entries addObject:obj.config];
                     }
                 }
                 [self sendResultObject:entries];
             }
             break;
    }
}

@end
