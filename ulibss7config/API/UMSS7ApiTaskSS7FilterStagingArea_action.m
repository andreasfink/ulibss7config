//
//  UMSS7ApiTaskSS7FilterStagingArea_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-action";
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
    
    @try
    {
        
        NSString *action = _params[@"action"];
        NSString *name = _params[@"name"];
        NSDictionary *d = [NSDictionary dictionary];
        if(name.length==0)
        {
            d = @{@"error" : @"missing-parameter", @"reason" :@"the 'name' parameter is not passed"};
            [self sendError:[d jsonString]];
        }
        else if([action isEqualToString:@"copy"])
        {
            NSString *new_name = _params[@"destination"];
            UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
            if(stagingArea == NULL)
            {
                [self sendErrorNotFound:@"Staging-Area"];
            }
            else
            {
                [stagingArea setConfig:_params];
                [_appDelegate copySS7FilterStagingArea:name toNewName:new_name];
                [self sendResultOK];
            }

        }
        else if([action isEqualToString:@"activate"])
        {
            UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
            if(stagingArea == NULL)
            {
                [self sendErrorNotFound:@"Staging-Area"];
            }
            else
            {
                [_appDelegate makeStagingAreaCurrent:name];
                [stagingArea setConfig:_params];
                [self sendResultOK];
            }
        }
        else if([action isEqualToString:@"select"])
        {
           
            [_appDelegate selectSS7FilterStagingArea:name forSession:_apiSession];
            [self sendResultOK];
        }
        else
        {
            d = @{@"error" : @"not-supported-value", @"reason" :@"the 'action' must have known value (e.g. select)!"};
            [self sendError:[d jsonString]];
            
        }
        
    }
    @catch(NSException *e)
    {
        [self sendException:e];
    }
    
}
@end
