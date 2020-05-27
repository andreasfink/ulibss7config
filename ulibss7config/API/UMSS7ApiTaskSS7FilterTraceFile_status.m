//
//  UMSS7ApiTaskSS7FilterTraceFile_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_status.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterTraceFile_status

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-status";
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
        
        @try
        {
            // 1. Get external parameters
            NSString *name = _params[@"name"];
            if(name.length==0)
            {
                [self sendError:@"missing-parameter" reason: @"the name parameter is not passed"];
            }
            else
            {
                // 2. Status ?
                //[_appDelegate logfile_getstatus:name];
                [self sendErrorNotImplemented];
            }
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}

@end
