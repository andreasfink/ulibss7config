//
//  UMSS7ConfigHLR.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>


@interface UMSS7ConfigHLR : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSString *_imsiPool;
    NSNumber *_answerTranslationType;
    NSNumber *_defaultCalledTT;
}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *imsiPrefix;
@property(readwrite,strong,atomic)   NSString *msc;
@property(readwrite,strong,atomic)   NSString *timeoutTraceDirectory;
@property(readwrite,strong,atomic)   NSString *fullTraceDirectory;
@property(readwrite,strong,atomic)  NSNumber *answerTranslationType;
@property(readwrite,strong,atomic)  NSNumber *defaultCalledTT;



+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigHLR *)initWithConfig:(NSDictionary *)dict;

@end
