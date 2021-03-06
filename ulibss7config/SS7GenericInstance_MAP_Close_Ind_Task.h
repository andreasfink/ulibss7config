//
//  GenericInstance_MAP_Close_Ind_Task.h
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>

@class SS7GenericInstance;

@interface SS7GenericInstance_MAP_Close_Ind_Task : UMLayerTask
{
    SS7GenericInstance *_inst;
    UMGSMMAP_UserIdentifier *_userIdentifier;
    NSDictionary *_options;
}

- (SS7GenericInstance_MAP_Close_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                          userIdentifier:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                 options:(NSDictionary *)options;
- (void)main;
@end

 
