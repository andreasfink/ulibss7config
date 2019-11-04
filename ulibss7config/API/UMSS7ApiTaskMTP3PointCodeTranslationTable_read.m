//
//  UMSS7ApiTaskMTP3PointCodeTranslationTable_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3PointCodeTranslationTable_read.h"

@implementation UMSS7ApiTaskMTP3PointCodeTranslationTable_read

+ (NSString *)apiPath
{
    return @"/api/mtp3-pointcode-translation-table-read";
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
