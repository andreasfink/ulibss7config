//
//  UMSS7ConfigAuthServer.h
//  ulibss7config
//
//  Created by Andreas Fink on 08.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibss7config/UMSS7ConfigObject.h>


@interface UMSS7ConfigAuthServer : UMSS7ConfigObject
{
    NSString *              _zmqListener;
    NSString *              _dbPool;
}

@property(readwrite,strong,atomic) NSString * zmqListener;
@property(readwrite,strong,atomic) NSString * dbPool;


@end

