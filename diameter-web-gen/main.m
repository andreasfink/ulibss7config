//
//  main.m
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "../version.h"
#import "UMDiameterGeneratorWeb.h"


NSString *getFirst(id param)
{
    if([param isKindOfClass:[NSString class]])
    {
        return (NSString *)param;
    }
    if([param isKindOfClass:[NSNumber class]])
    {
        return [((NSNumber *)param) stringValue];
    }
    if([param isKindOfClass:[NSArray class]])
    {
        NSArray *a = (NSArray *)param;
        if(a.count == 0)
        {
            return NULL;
        }
        id b = a[0];
        return getFirst(b);
    }
    return NULL;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSDictionary *appDefinition = @
        {
            @"version" : @(VERSION),
            @"executable" : @"diameter-web-gen",
            @"run-as" : @(argv[0]),
            @"copyright" : @"© 2019 Andreas Fink",
        };

        NSArray *commandLineDefinition = @[
                                           @{
                                               @"name"  : @"version",
                                               @"short" : @"-V",
                                               @"long"  : @"--version",
                                               @"help"  : @"shows the software version"
                                               },
                                           @{
                                               @"name"  : @"verbose",
                                               @"short" : @"-v",
                                               @"long"  : @"--verbose",
                                               @"help"  : @"enables verbose mode"
                                               },
                                           @{
                                               @"name"  : @"help",
                                               @"short" : @"-h",
                                               @"long" : @"--help",
                                               @"help"  : @"shows the help screen",
                                               },
                                          @{
                                               @"name"  : @"prefix",
                                               @"short" : @"-p",
                                               @"long"  : @"--prefix",
                                               @"argument" : @"prefix",
                                               @"help"  : @"prefix for objects and filename",
                                               },
                                           @{
                                               @"name"  : @"name",
                                               @"short" : @"-n",
                                               @"long"  : @"--name",
                                               @"argument" : @"name",
                                               @"help"  : @"The name of the command with underscores",
                                               },

                                           @{
                                               @"name"  : @"human",
                                               @"short" : @"-H",
                                               @"long"  : @"--human",
                                               @"argument" : @"string",
                                               @"help"  : @"the name displayed in the webform title"
                                               },
                                           @{
                                               @"name"  : @"file",
                                               @"short" : @"-f",
                                               @"long"  : @"--file",
                                               @"help"  : @"filename (without .h .m)"
                                               },
                                           @{
                                               @"name"  : @"packet",
                                               @"short" : @"-P",
                                               @"long"  : @"--packet",
                                               @"argument" : @"string",
                                               @"help"  : @"name of UMDiameterPacket"
                                               }];

        UMCommandLine *_commandLine = [[UMCommandLine alloc]initWithCommandLineDefintion:commandLineDefinition
                                                                           appDefinition:appDefinition
                                                                                    argc:argc
                                                                                    argv:argv];
        [_commandLine handleStandardArguments];
        NSDictionary *params = _commandLine.params;

        NSString *user = @(getenv("USER"));
        NSString *date = [[NSDate date]stringValue];


        NSString *prefix = @"DiameterSession";
        NSString *name;
        NSString *human;
        NSString *packet;
        NSString *file;


        NSString *s = getFirst(params[@"prefix"]);
        if(s)
        {
            prefix = s;
        }
        s = getFirst(params[@"name"]);
        if(s)
        {
            name = s;
        }
        s = getFirst(params[@"human"]);
        if(s)
        {
            human = s;
        }

        s = getFirst(params[@"packet"]);
        if(s)
        {
            packet = s;
        }

        s = getFirst(params[@"file"]);
        if(s)
        {
            file = s;
        }

        if(file==NULL)
        {
            file = [NSString stringWithFormat:@"%@%@",prefix,name];
        }
        if(packet==NULL)
        {
            packet = [NSString stringWithFormat:@"UMDiameterPacket%@",name];
        }
        if(human==NULL)
        {
            human = [name stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        }


        UMDiameterGeneratorWeb *w = [[UMDiameterGeneratorWeb alloc]init];
        w.prefix = prefix;
        w.packet = packet;
        w.name = name;
        w.human = human;
        w.user = user;
        w.date = date;


        NSString *headerFileName = [NSString stringWithFormat:@"%@.h",file];
        NSString *methodFileName = [NSString stringWithFormat:@"%@.m",file];


        NSString *content_h = [w headerFile];
        NSString *content_m = [w methodFile];

        NSError *e = NULL;
        [content_h writeToFile:headerFileName atomically:YES encoding:NSUTF8StringEncoding error:&e];
        if(e)
        {
            NSLog(@"Error: %@",e);
        }
        e = NULL;
        [content_m writeToFile:methodFileName atomically:YES encoding:NSUTF8StringEncoding error:&e];
        if(e)
        {
            NSLog(@"Error: %@",e);
        }
    }
    return 0;
}

