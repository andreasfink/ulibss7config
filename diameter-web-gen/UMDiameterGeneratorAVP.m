//
//  UMDiameterGeneratorAVP.m
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMDiameterGeneratorAVP.h"

@implementation UMDiameterGeneratorAVP


- (UMDiameterGeneratorAVP *)initWithString:(NSString *)s
{
    self = [super init];
    if(self)
    {
        if([self parseString:s]==NO)
        {
            return NULL;
        }
    }
    return self;
}

- (BOOL)parseString:(NSString *)s
{
    s = [s trim];
    NSInteger count = [s length];
    if(count==0)
    {
        return NO;
    }
    NSInteger currentSection = 0;
    /* 0 = between start and * */
    /* 1 = between * and { or < or [ */
    /* 2 = between {[<   and >]} */
    /* 3 = after  >]}  and // */
    /* 4 = after ;   */
    NSInteger currentInt = 0;
    BOOL hasMin = NO;
    BOOL hasMax = NO;
    NSMutableString *currentName = [[NSMutableString alloc]init];
    NSMutableString *currentComment = NULL;
    for(NSInteger idx=0;idx<count;idx++)
    {
        unichar c = [s characterAtIndex:idx];
        switch(currentSection)
        {
            case 0:      /* 0 = between start and * */
            {
                if((c=='\n') || (c=='\r'))
                {
                    break;
                }
                else if((c>='0') && (c<='9'))
                {
                    currentInt = currentInt * 10 + c-'0';
                    hasMin=YES;
                }
                else if(c=='*')
                {
                    _multiple = YES;
                    if(hasMin)
                    {
                        _minimumCount = @(currentInt);
                        currentInt = 0;
                    }
                    currentSection = 1;
                    continue;
                }
                else if (c=='<')
                {
                    currentSection = 2;
                    _fixedPosition = YES;
                    continue;
                }
                else if (c=='[')
                {
                    currentSection = 2;
                    continue;
                }
                else if (c=='{')
                {
                    _mandatory = YES;
                    currentSection = 2;
                    continue;
                }
                else
                {
                    /* should only be ignored whitespace */
                }
                break;
            }
            case 1:
            {
                if((c=='\n') || (c=='\r'))
                {
                    break;
                }
                /* between * and <[{ */
                else if((c>='0') && (c<='9'))
                {
                    currentInt = currentInt * 10 + c-'0';
                    hasMax=YES;
                }
                else if(c=='*')
                {
                    _multiple = YES;
                    if(hasMax)
                    {
                        _maximumCount = @(currentInt);
                        currentInt = 0;
                    }
                    currentSection = 1;
                    continue;
                }
                else if (c=='<')
                {
                    if(hasMax)
                    {
                        _maximumCount = @(currentInt);
                        currentInt = 0;
                    }
                    currentSection = 2;
                    _fixedPosition = YES;
                    continue;
                }
                else if (c=='[')
                {
                    if(hasMax)
                    {
                        _maximumCount = @(currentInt);
                        currentInt = 0;
                    }
                    currentSection = 2;
                    continue;
                }
                else if (c=='{')
                {
                    if(hasMax)
                    {
                        _maximumCount = @(currentInt);
                        currentInt = 0;
                    }
                    _mandatory = YES;
                    currentSection = 2;
                    continue;
                }
                break;

            }
            case 2:
            {
                /* between <[{ and  >]} */
                if((c=='\n') || (c=='\r'))
                {
                    break;
                }
                else if((c=='>') || (c=='}') || (c==']'))
                {
                    _standardsName = currentName;
                    currentInt = 0;
                    currentSection = 3;
                }
                else if( ((c>='A') && (c<='Z')) ||
                        ((c>='a') && (c<='z')) ||
                        ((c>='0') && (c<='9')) ||
                        (c=='-'))
                {
                    [currentName appendFormat:@"%C", c];
                }
            }
            case 3:
            {
                if((c=='\n') || (c=='\r'))
                {
                    break;
                }
                /* between  >]}  and ; */
                else if(c==';')
                {
                    currentSection = 4;
                    currentComment = [[NSMutableString alloc]init];
                }
            }
            case 4:
            {
                if((c=='\n') || (c=='\r'))
                {
                    break;
                }
                else
                {
                    [currentComment appendFormat:@"%C", c];
                }
            }
        }
    }
    [self convertNames];
    _comment = currentComment;
    return YES;
}

- (void)convertNames
{
    _standardsName = [_standardsName trim];
    NSInteger count = [_standardsName length];

    NSMutableString *wname = [[NSMutableString alloc]init];
    NSMutableString *vname = [[NSMutableString alloc]init];
    NSMutableString *pname = [[NSMutableString alloc]init];
    NSMutableString *oname = [[NSMutableString alloc]init];
    [vname appendString:@"_var"];

    for(NSInteger idx=0;idx<count;idx++)
    {
        unichar c = [_standardsName characterAtIndex:idx];
        unichar lowerC;
        if((c>='A') && (c<='Z'))
        {
            lowerC = c - 'A' + 'a';
        }
        else
        {
            lowerC = c;
        }
        if(c=='-')
        {
            [wname appendString:@"-"];
            [vname appendString:@"_"];
            [pname appendString:@"_"];
            [oname appendString:@"_"];
        }
        else
        {
            [wname appendFormat:@"%C",lowerC];
            [vname appendFormat:@"%C",lowerC];
            [pname appendFormat:@"%C",lowerC];
            [oname appendFormat:@"%C",c];
        }
    }
    _webName = wname;
    _variableName = vname;
    _propertyName = pname;
    _objectName = oname;
}

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"    "];
    if(_multiple)
    {
        if(_minimumCount)
        {
            [s appendString:@"%3d"];
        }
        else
        {
            [s appendString:@"   "];
        }
        [s appendString:@"*"];
        if(_maximumCount)
        {
            [s appendString:@"%3d"];
        }
        else
        {
            [s appendString:@"   "];
        }
    }
    else
    {
        [s appendString:@"       "];
    }
    if(_fixedPosition)
    {
        [s appendString:@"< "];
    }
    else if(_mandatory)
    {
        [s appendString:@"{ "];
    }
    else
    {
        [s appendString:@"[ "];
    }

    [s appendString:_standardsName];
    if(_fixedPosition)
    {
        [s appendString:@" >"];
    }
    else if(_mandatory)
    {
        [s appendString:@" }"];
    }
    else
    {
        [s appendString:@" ]"];
    }
    if(_comment)
    {
        [s appendFormat:@" ; %@",_comment];
    }
    return s;
}
@end
