//
//  UMSS7ApiTaskSS7FilterEngine_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_action.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskSS7FilterEngine_action

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-action";
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
        
        NSString *action = _params[@"action"];
        NSString *name = [UMSS7ConfigObject filterName:_params[@"name"]];
        if([action isEqualToString:@"action-list"])
        {
            [self sendResultObject:@[ @"reload"]];
        }
        else if([action isEqualToString:@"reload"])
        {
            UMPluginHandler *plugin = [_appDelegate getSS7FilterEngineHandler:name];
            if(plugin==NULL)
            {
                [self sendErrorNotFound:name];
            }
            else
            {
                NSString *s = [plugin reload];
                if(s.length==0)
                {
                    [self sendResultOK];
                }
                else
                {
                    [self sendError:s];
                }
            }
        }
        else
        {
            [self sendErrorUnknownAction];
        }
    }
}

@end
