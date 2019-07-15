//
//  UMSS7FilterRule.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterRule.h"
#import "UMSS7ConfigFilterRule.h"

@implementation UMSS7FilterRule

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet
{
    return [engine filterInbound:packet];
}


@end
