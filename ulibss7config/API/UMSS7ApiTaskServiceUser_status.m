//
//  UMSS7ApiTaskServiceUser_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskServiceUser_status.h"
#import <ulibss7config/UMSS7ConfigObject.h>
#import "UMSS7ConfigServiceUser.h"
#import <ulibss7config/UMSS7ConfigStorage.h>

@implementation UMSS7ApiTaskServiceUser_status

+ (NSString *)apiPath
{
    return @"/api/serviceuser-status";
}

@end
