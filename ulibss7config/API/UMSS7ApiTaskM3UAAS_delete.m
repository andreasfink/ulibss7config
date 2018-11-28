//
//  UMSS7ApiTaskM3UAAS_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAAS_delete.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM3UAAS.h"

@implementation UMSS7ApiTaskM3UAAS_delete
+ (NSString *)apiPath
{
    return @"/api/m3ua-as-delete";
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

    UMSS7ConfigM3UAAS *config_object = [cs getM3UAAS:name];
    UMM3UAApplicationServer *instance = [_appDelegate getM3UAAS:name];
    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteM3UAAS:name];
        [_appDelegate deleteM3UAAS:name];
        [self sendResultOK];
    }
}
@end
