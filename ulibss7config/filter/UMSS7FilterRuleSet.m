//
//  UMSS7FilterRuleSet.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterRuleSet.h"

@implementation UMSS7FilterRuleSet

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;
{
    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;

    for (UMSS7FilterRule *rule in _entries)
    {
        result = result | [rule filterInbound:packet];
        if(result | UMSCCP_FILTER_RESULT_DROP )
        {
            break;
        }
        if(result | UMSCCP_FILTER_RESULT_STATUS )
        {
            break;
        }
        if(result | UMSCCP_FILTER_RESULT_CAN_NOT_DECODE )
        {
            break;
        }
    }
    return result;
}


@end
