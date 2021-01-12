//
//  UMSS7ConfigMTP3PointCodeTranslationTable.h
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//


#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3remoteNi : UMSS7ConfigObject
{
    NSNumber    *_localNi;
    NSNumber    *_remoteNi;
    NSString    *_defaultLocalPc;
    NSString    *_defaultRemotePc;
    NSArray<NSString *>*_pcmap;
}


@property(readwrite,strong,atomic)  NSNumber    *localNi;
@property(readwrite,strong,atomic)  NSNumber    *remoteNi;
@property(readwrite,strong,atomic)  NSString    *defaultLocalPc;
@property(readwrite,strong,atomic)  NSString    *defaultRemotePc;
@property(readwrite,strong,atomic)  NSArray<NSString *>*pcmap;


+ (NSString *)type;
- (NSString *)type;

@end

