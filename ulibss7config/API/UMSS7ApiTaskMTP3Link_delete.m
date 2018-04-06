//
//  UMSS7ApiTaskMTP3Link_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Link_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3Link.h"

@implementation UMSS7ApiTaskMTP3Link_delete

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-delete";
}


- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];

    UMSS7ConfigMTP3Link *config_object = [cs getMTP3Link:name];
    UMMTP3Link *instance = [_appDelegate getMTP3_Link:name];
    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteMTP3Link:name];
        [_appDelegate deleteMTP3Link:name];
        [self sendResultOK];
    }
}
@end
