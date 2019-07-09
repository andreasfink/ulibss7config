//
//  UMDiameterGeneratorAVP.h
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>

@interface UMDiameterGeneratorAVP : UMObject
{
    NSString *_standardsName;   /* something like Origin-Realm */
    NSString *_objectName;      /* something like Origin_Realm */
    NSString *_webName;         /* origin-realm */
    NSString *_variableName;    /* _origin_realm */
    NSString *_propertyName;    /* origin_realm */

    NSString *_comment;
    BOOL    _mandatory;
    BOOL    _fixedPosition;
    BOOL    _multiple;
    NSNumber  *_minimumCount;
    NSNumber  *_maximumCount;
}

@property(readwrite,strong,atomic)  NSString *standardsName;   /* something like Origin-Realm */
@property(readwrite,strong,atomic)  NSString *objectName;   /* something like Origin_Realm */
@property(readwrite,strong,atomic)  NSString *webName;         /* origin-realm */
@property(readwrite,strong,atomic)  NSString *variableName;    /* _origin_realm */
@property(readwrite,strong,atomic)  NSString *propertyName;    /* origin_realm */
@property(readwrite,strong,atomic)  NSString *comment;
@property(readwrite,assign,atomic)  BOOL    mandatory;
@property(readwrite,assign,atomic)  BOOL    fixedPosition;
@property(readwrite,assign,atomic)  BOOL    multiple;
@property(readwrite,strong,atomic)  NSNumber  *minimumCount;
@property(readwrite,strong,atomic)  NSNumber  *maximumCount;

- (UMDiameterGeneratorAVP *)initWithString:(NSString *)s;
- (BOOL)parseString:(NSString *)s; /* returns yes on success */

@end
