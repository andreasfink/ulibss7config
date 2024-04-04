//
//  UMSS7ApiTaskSS7FilterTraceFile_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_delete.h"
#import <ulibss7config/UMSS7ConfigObject.h>
#import "UMSS7ConfigStorage.h"
#import <ulibss7config/UMSS7ConfigAppDelegateProtocol.h>
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterTraceFile_delete

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-remove";
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
        
        @try
        {
            // 1. Get external parameters
            NSString *name = _params[@"name"];
            if(name.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'name' parameter is not passed"];
            }
            else
            {
                // 2. Remove
                [_appDelegate tracefile_remove:name];
                [self sendResultOK];
            }
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}

@end
