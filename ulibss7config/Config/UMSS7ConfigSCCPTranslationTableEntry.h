//
//  UMSS7ConfigSCCPTranslationTableEntry.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCPTranslationTableEntry : UMSS7ConfigObject
{
    NSString *_translationTableName;
    NSString *_gta;
    NSString *_sccpDestination;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPTranslationTableEntry *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *translationTableName;
@property(readwrite,strong,atomic)  NSString *gta;
@property(readwrite,strong,atomic)  NSString *sccpDestination;

@end
