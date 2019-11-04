//
//  UMSS7ApiTaskMTP3PointCodeTranslationTable_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3PointCodeTranslationTable_list.h"

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
    [self sendErrorNotImplemented];
}

@end
