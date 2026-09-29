//
//  UMSS7ConfigGGSN.h
//  ulibss7config
//
//  Created by Andreas Fink on 24.09.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>

@interface UMSS7ConfigGGSN : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSNumber *_answerTranslationType;
    NSNumber *_defaultCalledTT;
}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSNumber *answerTranslationType;
@property(readwrite,strong,atomic)  NSNumber *defaultCalledTT;

+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigGGSN *)initWithConfig:(NSDictionary *)dict;
@end


