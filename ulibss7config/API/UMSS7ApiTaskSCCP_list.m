//
//  UMSS7ApiTaskSCCP_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSCCP.h"
#import "UMSS7ApiTaskMacros.h"

@implementation UMSS7ApiTaskSCCP_list
+ (NSString *)apiPath
{
    return @"/api/sccp-list";
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

    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    NSArray *names = [cs getSCCPNames];

     int details = [((NSString *)_params[@"details"]) intValue];
     switch(details)
     {
          case 0:
              [self sendResultObject:names];
              break;
          case 1:
          case 2:
              {
                  NSMutableArray *entries = [[NSMutableArray alloc]init];
                  for(NSString *name in names)
                  {
                      UMSS7ConfigSCCP *obj = [cs getSCCP:name];
                      if(obj)
                      {
                          [entries addObject:obj.config];
                      }
                  }
                  [self sendResultObject:entries];
              }
              break;
     }
}

@end
