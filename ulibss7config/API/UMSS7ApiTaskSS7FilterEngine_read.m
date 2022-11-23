//
//  UMSS7ApiTaskSS7FilterEngine_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_read.h"

@implementation UMSS7ApiTaskSS7FilterEngine_read


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-read";
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

        NSString *name = _params[@"name"];
        UMPluginHandler *plugin = [_appDelegate getSS7FilterEngineHandler:name];

        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        NSDictionary *info = plugin.info;

        dict[@"name"] = plugin.name;
        dict[@"filename"] = plugin.filename;
        if(info[@"version"])
        {
            dict[@"version"] = info[@"version"];
        }
        if(info[@"type"])
        {
            dict[@"type"] = info[@"type"];
        }
        [self sendResultObject:dict];
    }
}

@end
