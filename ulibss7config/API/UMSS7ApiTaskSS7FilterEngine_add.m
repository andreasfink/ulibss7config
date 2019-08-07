//
//  UMSS7ApiTaskSS7FilterEngine_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_add.h"

#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskSS7FilterEngine_add

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-add";
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

    NSString *name = _params[@"file"];
    name = [UMSS7ConfigObject filterName:name];

    @try
    {
        NSDictionary *d = [NSDictionary dictionary];
        if(name.length==0)
        {
            d = @{@"error" : @"missing-parameter", @"reason" :@"the 'file' parameter is not passed"};
            [self sendError:[d jsonString]];
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

@end
