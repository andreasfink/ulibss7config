//
//  UMSS7ApiTaskSS7FilterStagingArea_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_delete.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_delete


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-delete";
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
        
        // 1. Get Staging Area
        UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
        if(stagingArea == NULL)
        {
            [self sendErrorNotFound:@"Staging-Area"];
        }
        else
        {
            @try
            {
                NSString *name = _params[@"name"];
                if([name isEqualToString:@"current"])
                {
                    [self sendError: @"invalid-parameter" reason:@"this name is not allowed"];
                }
                else
                {
                    [_appDelegate deleteSS7FilterStagingArea:name];
                    [self sendResultOK];
                }
            }
            @catch(NSException *e)
            {
                [self sendException:e];
            }
        }
    }
}
@end
