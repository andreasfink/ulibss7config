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
    NSArray<NSString *> *_gta;
    NSString *_sccpDestination;
    NSString *_postTranslation;
    NSString *_gtOwner;
    NSString *_gtUser;
    NSNumber *_tidStart;
    NSNumber *_tidEnd;
    NSString *_tidRange;
    NSString *_ssn;
    NSString *_opcode;
    NSString *_appcontext;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPTranslationTableEntry *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *translationTableName;
@property(readwrite,strong,atomic)  NSString *sccpDestination;
@property(readwrite,strong,atomic)  NSString *postTranslation;
@property(readwrite,strong,atomic)  NSString *gtOwner;
@property(readwrite,strong,atomic)  NSString *gtUser;
@property(readwrite,strong,atomic)  NSNumber *tidStart;
@property(readwrite,strong,atomic)  NSNumber *tidEnd;
@property(readwrite,strong,atomic)  NSString *tidRange;
@property(readwrite,strong,atomic)  NSString *ssn;
@property(readwrite,strong,atomic)  NSString *opcode;
@property(readwrite,strong,atomic)  NSString *appcontext;

//@property(readwrite,strong,atomic)  NSArray<NSString *>* gta;
- (NSArray<NSString *>*)gta;
- (void)setGta:(NSArray<NSString *>*)gta1;

@end
