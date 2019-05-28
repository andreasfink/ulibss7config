//
//  UMSS7ApiTaskList.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskList.h"

@implementation UMSS7ApiTaskList


+ (NSString *)apiPath
{
    return @"/api/list";
}

- (void)main
{
    /*
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
     */
    [self sendResultObject:[UMSS7ApiTask apiPathList]];
}

@end
