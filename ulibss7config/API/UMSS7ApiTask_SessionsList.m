//
//  UMSS7ApiTask_SessionsList.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTask_SessionsList.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAdminUser.h"

#import "UMSS7ApiSession.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigApiUser.h"

@implementation UMSS7ApiTask_SessionsList



+ (NSString *)apiPath
{
    return @"/api/.sessions/";
}

+ (BOOL)doNotList
{
    return YES;
}

- (void)main
{
    NSString *username = _params[@"username"];
    NSString *password = _params[@"password"];
    UMSS7ConfigApiUser *user = [_appDelegate.runningConfig getApiUser:username];
    if(user)
    {
        if([password isEqualToString:user.password])
        {
            NSArray *sessions = [_appDelegate getAllSessionsSessions];
            UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
            for(UMSS7ApiSession *session in sessions)
            {
                UMSynchronizedSortedDictionary *entry = [[UMSynchronizedSortedDictionary alloc]init];
                entry[@"key"] = session.sessionKey;
                entry[@"user"] = session.currentUser.name;
                entry[@"ip"] = session.connectedFromIp;
                entry[@"last-used"] = session.lastUsed;
                entry[@"timeout"] = @(session.timeout);
                entry[@"current-storage-area-name"] = session.currentStorageAreaName;
                dict[session.sessionKey] = session;
            }
            return [self sendResultObject:dict];

        }
        else
        {
            return [self sendErrorNotAuthenticated];
        }
    }
    else
    {
        return [self sendErrorNotAuthenticated];
    }
}

@end

