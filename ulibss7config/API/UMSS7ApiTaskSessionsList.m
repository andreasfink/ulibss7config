//
//  UMSS7ApiTaskSessionsList.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSessionsList.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAdminUser.h"

#import "UMSS7ApiSession.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigApiUser.h"

@implementation UMSS7ApiTaskSessionsList



+ (NSString *)apiPath
{
    return @"/api/sessions-list";
}

+ (BOOL)doNotList
{
    return YES;
}

- (void)main
{
    @autoreleasepool
    {

        NSString *username = _params[@"username"];
        NSString *password = _params[@"password"];
        UMSS7ConfigApiUser *user = [_appDelegate.runningConfig getApiUser:username];
        if(user)
        {
            if([password isEqualToString:user.password])
            {
                UMSynchronizedDictionary *sessions = [_appDelegate getAllSessionsSessions];
                NSArray *sessionNames = [sessions allKeys];
                UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
                for(NSString *sessionName in sessionNames)
                {
                    UMSS7ApiSession *session = sessions[sessionName];
                    UMSynchronizedSortedDictionary *entry = [[UMSynchronizedSortedDictionary alloc]init];
                    entry[@"key"] = session.sessionKey;
                    entry[@"user"] = session.currentUser.name;
                    entry[@"ip"] = session.connectedFromIp;
                    entry[@"first-used"] = session.firstUsed;
                    entry[@"last-used"] = session.lastUsed;
                    entry[@"expires"] = [NSDate dateWithTimeInterval:session.timeout sinceDate:session.lastUsed.date];
                    entry[@"timeout"] = @(session.timeout);
                    entry[@"current-storage-area-name"] = session.currentStorageAreaName ? session.currentStorageAreaName : @"" ;
                    dict[session.sessionKey] = entry;
                }
                [self sendResultObject:dict];
            }
            else
            {
                [self sendErrorNotAuthenticated];
            }
        }
        else
        {
            [self sendErrorNotAuthenticated];
        }
    }
}

@end

