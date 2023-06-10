//
//  UMSS7ConfigSCCPTranslationTable.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCPTranslationTable : UMSS7ConfigObject
{
    NSString *_sccp;
    NSNumber *_tt;
    NSNumber *_gti;
    NSNumber *_np;
    NSNumber *_nai;
    NSString *_preTranslation;
    NSString *_postTranslation;
    NSString *_defaultDestination;
    NSString *_translationTableDbPool;
    NSString *_translationTableDbTable;
    NSNumber *_translationTableDbAutocreate;
    NSNumber *_translationTableDbCheckIntervall;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPTranslationTable *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)   NSString *sccp;
@property(readwrite,strong,atomic)   NSNumber *tt;
@property(readwrite,strong,atomic)   NSNumber *gti;
@property(readwrite,strong,atomic)   NSNumber *np;
@property(readwrite,strong,atomic)   NSNumber *nai;
@property(readwrite,strong,atomic)   NSString *preTranslation;
@property(readwrite,strong,atomic)   NSString *postTranslation;
@property(readwrite,strong,atomic)   NSString *defaultDestination;
@property(readwrite,strong,atomic)   NSString *translationTableDbPool;
@property(readwrite,strong,atomic)   NSString *translationTableDbTable;
@property(readwrite,strong,atomic)   NSNumber *translationTableDbAutocreate;
@property(readwrite,strong,atomic)   NSNumber *translationTableDbCheckIntervall;

@end
