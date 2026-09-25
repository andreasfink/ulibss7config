//
//  UMSS7ApiTaskSS7FilterTraceFile_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_list.h"
#import <ulibss7config/UMSS7ConfigObject.h>
#import <ulibss7config/UMSS7ConfigStorage.h>
#import <ulibss7config/UMSS7ConfigAppDelegateProtocol.h>
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterTraceFile_list

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-list";
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
        
        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }
        
        // Return an array
        UMSynchronizedArray *ls = [_appDelegate tracefile_list];
        [self sendResultObject:ls];
    }
}
@end
