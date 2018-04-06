//
//  UMSS7ConfigSCCPDestinationGroup.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"
@class UMSS7ConfigSCCPDestinationEntry;

@interface UMSS7ConfigSCCPDestination : UMSS7ConfigObject
{
}

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigSCCPDestination *)initWithConfig:(NSDictionary *)dict;

@end
