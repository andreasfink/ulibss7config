//
//  UMSS7ApiTaskSS7FilterStagingArea_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_list


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-list";
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
            // Just whatever there is into list because _apiSession.currentStorageAreaName may be NULL
            NSArray<NSString *> *areas = [_appDelegate getSS7FilterStagingAreaNames];
            [self sendResultObject:areas];
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}
@end
