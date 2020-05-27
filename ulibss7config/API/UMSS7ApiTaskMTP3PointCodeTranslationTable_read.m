//
//  UMSS7ApiTaskMTP3PointCodeTranslationTable_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3PointCodeTranslationTable_read.h"
#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskMTP3PointCodeTranslationTable_read

+ (NSString *)apiPath
{
    return @"/api/mtp3-pointcode-translation-table-read";
}

- (void)main
{
    @autoreleasepool
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

        NSString *name = _params[@"name"];
        name = [UMSS7ConfigObject filterName:name];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigMTP3PointCodeTranslationTable *pctt = [cs getPointcodeTranslationTable:name];
        if(pctt)
        {
            [self sendResultObject:pctt.config];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}

@end
