//
//  SS7GenericInstance_MAP_U_Abort_Req_Task.h
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//
#if 0
#import <ulibgsmmap/ulibgsmmap.h>
@class SS7GenericInstance;

@interface SS7GenericInstance_MAP_U_Abort_Req_Task : UMLayerTask
{
    SS7GenericInstance *_inst;
    UMGSMMAP_UserIdentifier *_userIdentifier;
    NSDictionary *_options;
}

- (SS7GenericInstance_MAP_U_Abort_Req_Task *)initWithInstance:(SS7GenericInstance *)inst
                                          userIdentifier:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                 options:(NSDictionary *)options;
- (void)main;
@end

#endif
