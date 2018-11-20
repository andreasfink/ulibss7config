//
//  SS7ConfigurationSession.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7ConfigurationSession.h"

@implementation SS7ConfigurationSession

- (SS7ConfigurationSession *)initWithSyntax:(UMSyntaxToken *)syntax
{
    self = [super init];
    if(self)
    {
        _root = syntax;
        _subsection = NULL;
    }
    return self;
}

- (BOOL)processLine:(NSString *)s
{
    UMScanner *scanner = [[UMScanner alloc]init];
    UMTokenizer *tokenizer = [[UMTokenizer alloc]init];
    UMSyntaxContext *context = [[UMSyntaxContext alloc]init];

    NSArray *chars = [scanner scanString:s];
    NSArray *tokens = [tokenizer tokensFromChars:chars];
    /* tokens is an array of lines of an array of tokens*/
    /* we only process line 0 */
    if(_subsection)
    {
        @try
        {
            [_subsection executeLines:tokens usingContext:context];
        }
        @catch(NSException *e)
        {
            @try
            {
                [_root executeLines:tokens usingContext:context];
            }
            @catch(NSException *e)
            {
                @throw(e);
            }
        }
    }
    @try
    {
        [_root executeLines:tokens usingContext:context];
    }
    @catch(NSException *e)
    {
        @throw(e);
    }
    if([context[@"doQuit"] boolValue]==YES)
    {
        return YES;
    }
    return NO;
}


- (NSString *)autocompleteLine:(NSString *)s
{
    UMScanner *scanner          = [[UMScanner alloc]init];
    UMTokenizer *tokenizer      = [[UMTokenizer alloc]init];
    UMSyntaxContext *context    = [[UMSyntaxContext alloc]init];


    NSArray *chars = [scanner scanString:s];
    if(chars.count == 0)
    {
        return @"";
    }
    NSArray *tokens = [tokenizer tokensFromChars:chars];
    NSArray *tokens0 = tokens[0];
    NSString *autocompleteString = NULL;;

    if(_subsection)
    {
        @try
        {
            autocompleteString = [_subsection autocompleteWords:tokens0 usingContext:context currentWord:@""];
        }
        @catch(NSException *e)
        {
            @try
            {
                autocompleteString = [_root autocompleteWords:tokens0 usingContext:context currentWord:@""];
            }
            @catch(NSException *e)
            {
                @throw(e);
            }
        }
    }
    @try
    {
        autocompleteString = [_root autocompleteWords:tokens0 usingContext:context currentWord:@""];
    }
    @catch(NSException *e)
    {
        @throw(e);
    }
    return autocompleteString;
}


- (NSString *)helpLine:(NSString *)s
{
    int sub = 0;
    NSString *fullLine = [self autocompleteLine:s];
    if(fullLine.length > 0)
    {
        unichar c = [fullLine characterAtIndex:fullLine.length-1];
        if(c == ' ')
        {
            sub=1;
        }
    }
    UMScanner *scanner          = [[UMScanner alloc]init];
    UMTokenizer *tokenizer      = [[UMTokenizer alloc]init];
    NSArray *chars = [scanner scanString:fullLine];
    NSArray *tokens = [tokenizer tokensFromChars:chars];
    if(tokens.count > 0)
    {
        NSArray *tokens0 = tokens[0];
        NSMutableString *result = [[NSMutableString alloc]init];
        NSArray *a = [_root lastTokens:tokens0];
        if(sub)
        {
            for(UMSyntaxToken *t in a)
            {
                UMSynchronizedSortedDictionary *subtokens = t.subtokens;
                NSArray *keys = subtokens.allKeys;
                for(NSString *key in keys)
                {
                    UMSyntaxToken *t2 = subtokens[key];
                    [result appendFormat:@"%@\t%@\r\n",t2.string,t2.help];
                }
            }

        }
        else
        {
            for(UMSyntaxToken *t in a)
            {
                [result appendFormat:@"%@\t%@\r\n",t.string,t.help];
            }
        }
        return result;
    }
    return @"";
}


- (void)commandPreAction:(NSString *)actionName value:(NSString *)value context:(UMSyntaxContext *)context
{

}

- (void)commandAction:(NSString *)actionName value:(NSString *)value context:(UMSyntaxContext *)context
{
    if([actionName isEqualToString:@"quit"])
    {
        context[@"doQuit"]=@(YES);
    }
    if([actionName isEqualToString:@"exit"])
    {
        context[@"doQuit"]=@(YES);
    }
}

- (void)commandPostAction:(NSString *)actionName value:(NSString *)value context:(UMSyntaxContext *)context
{

}
@end
