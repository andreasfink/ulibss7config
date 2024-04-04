//
//  UMSS7ApiTaskSS7FilterEngine_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_add.h"

#import <ulibss7config/UMSS7ConfigAppDelegateProtocol.h>
#import "UMSS7ConfigStorage.h"
#import <ulibss7config/UMSS7ConfigObject.h>

@implementation UMSS7ApiTaskSS7FilterEngine_add

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-add";
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

        NSString *name = _params[@"file"];
        name = [UMSS7ConfigObject filterName:name];

        @try
        {
            if(name.length==0)
            {
                [self sendError:@"missing-parameter" reason:@"the 'file' parameter is not passed"];
            }
            else
            {
                [_appDelegate addWithConfigSS7FilterEngine:_params];
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
