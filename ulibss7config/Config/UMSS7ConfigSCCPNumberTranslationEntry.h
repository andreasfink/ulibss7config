//
//  UMSS7ConfigSCCPNumberTranslationEntry.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCPNumberTranslationEntry : UMSS7ConfigObject
{
    NSString *_sccpNumberTranslation;
    NSString *_inAddress;
    NSString *_outAddress;
    NSNumber *_replacementNAI;
    NSNumber *_replacementNP;
    NSNumber *_removeDigits;
    NSString *_appendDigits;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPNumberTranslationEntry *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *sccpNumberTranslation;
@property(readwrite,strong,atomic)  NSString *inAddress;
@property(readwrite,strong,atomic)  NSString *outAddress;
@property(readwrite,strong,atomic)  NSNumber *replacementNAI;
@property(readwrite,strong,atomic)  NSNumber *replacementNP;
@property(readwrite,strong,atomic)  NSNumber *removeDigits;
@property(readwrite,strong,atomic)  NSString *appendDigits;

@end
