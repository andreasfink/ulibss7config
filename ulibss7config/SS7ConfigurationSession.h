//
//  SS7ConfigurationSession.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>


@interface SS7ConfigurationSession : UMObject<UMCommandActionProtocol>
{
    UMSyntaxToken   *_root;
    UMSyntaxToken   *_subsection;
}


- (SS7ConfigurationSession *)initWithSyntax:(UMSyntaxToken *)syntax;
- (BOOL)processLine:(NSString *)s; /* throws exception in case of errors. If YES is returned, the session ends */

- (NSString *)helpLine:(NSString *)s;
- (NSString *)autocompleteLine:(NSString *)s;

@end
