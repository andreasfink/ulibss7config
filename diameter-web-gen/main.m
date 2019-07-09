//
//  main.m
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "../version.h"
#import "UMDiameterGeneratorCMD.h"


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
    NSString *headerFileName;
    NSString *methodFileName;

    @autoreleasepool
    {
        NSDictionary *appDefinition = @
        {
            @"version" : @(VERSION),
            @"executable" : @"avp-src-gen",
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
                                               @"name"  : @"definition",
                                               @"short" : @"-d",
                                               @"long"  : @"--definition",
                                               @"argument" : @"filename",
                                               @"help"  : @"reads the definition of a command from a file",
                                               },
                                           @{
                                               @"name"  : @"write-command-header",
                                               @"long"  : @"--write-command-header",
                                               @"argument" : @"filename",
                                               @"help"  : @"writes a command parser to the file",
                                               },
                                           @{
                                               @"name"  : @"write-command-method",
                                               @"long"  : @"--write-command-method",
                                               @"argument" : @"filename",
                                               @"help"  : @"writes a command parser to the file",
                                               },
                                           @{
                                               @"name"  : @"write-web",
                                               @"short" : @"-W",
                                               @"long"  : @"--write-web",
                                               @"argument" : @"filename",
                                               @"help"  : @"writes a web parser to the file",
                                               },
                                           @{
                                               @"name"  : @"name",
                                               @"short" : @"-n",
                                               @"long"  : @"--name",
                                               @"argument" : @"avp-name",
                                               @"help"  : @"The attribute name",
                                               },
                                           @{
                                               @"name"  : @"code",
                                               @"short" : @"-c",
                                               @"long"  : @"--code",
                                               @"argument" : @"avp-code",
                                               @"help"  : @"The AVP code",
                                               },
                                           @{
                                               @"name"  : @"vendor",
                                               @"short" : @"-E",
                                               @"long"  : @"--vendor",
                                               @"argument" : @"vendor-id",
                                               @"help"  : @"The Vendor ID to use (sets V flag)"
                                               },
                                           @{
                                               @"name"  : @"mandatory",
                                               @"short" : @"-m",
                                               @"long"  : @"--mandatory",
                                               @"help"  : @"Enables the mandatory flag"
                                               },
                                           @{
                                               @"name"  : @"type",
                                               @"short" : @"-t",
                                               @"long"  : @"--type",
                                               @"help"  : @"Base type"
                                               },
                                           @{
                                               @"name"  : @"prefix",
                                               @"short" : @"-p",
                                               @"long"  : @"--prefix",
                                               @"help"  : @"prefix for object names"
                                               },
                                           @{
                                               @"name"  : @"overwrite",
                                               @"short" : @"-o",
                                               @"long"  : @"--overwrite",
                                               @"help"  : @"overwrite existing files"
                                               },
                                           @{
                                               @"name"  : @"filename",
                                               @"short" : @"-f",
                                               @"long"  : @"--file",
                                               @"help"  : @"filename (without .h .m)"
                                               },
                                           @{
                                               @"name"  : @"dir",
                                               @"short" : @"-d",
                                               @"long"  : @"--directory",
                                               @"help"  : @"directory to look for files/write files"
                                               }];


        UMCommandLine *_commandLine = [[UMCommandLine alloc]initWithCommandLineDefintion:commandLineDefinition
                                                                           appDefinition:appDefinition
                                                                                    argc:argc
                                                                                    argv:argv];
        [_commandLine handleStandardArguments];
        NSDictionary *params = _commandLine.params;

        NSString *user = @(getenv("USER"));
        NSString *date = [[NSDate date]stringValue];

        BOOL doOverwrite = NO;
        BOOL mandatoryFlag = NO;
        BOOL vendorFlag = NO;
        NSString *vendorId;
        NSString *prefix = @"UMDiameterAvp";
        NSString *baseType = @"UMDiameterAvpOctetString";
        NSString *code;
        NSString *name;
        BOOL verbose = NO;
        NSString *filename;
        NSString *definitionFilename;
        NSString *definitionString;
        NSString *dir;
        NSString *s = getFirst(params[@"prefix"]);
        if(s)
        {
            prefix = s;
        }

        s = getFirst(params[@"overwrite"]);
        if(s)
        {
            doOverwrite = YES;
        }

        s = getFirst(params[@"type"]);
        if(s)
        {
            baseType = s;
        }

        s = getFirst(params[@"mandatory"]);
        if(s)
        {
            mandatoryFlag = YES;
        }

        s = getFirst(params[@"vendor"]);
        if(s)
        {
            if([s isEqualToString:@"3GPP"])
            {
                prefix = @"UMDiameterAvp3GPP_";
                vendorId = @"UMDiameterApplicationId_3GPP";
                vendorFlag = YES;
            }
            else
            {
                vendorId = s;
                vendorFlag = YES;
            }
        }

        s = getFirst(params[@"code"]);
        if(s)
        {
            code = s;
        }

        s = getFirst(params[@"dir"]);
        if(s)
        {
            dir = s;
        }

        s = getFirst(params[@"name"]);
        if(s)
        {
            name = s;
        }
        s = getFirst(params[@"verbose"]);
        if(s)
        {
            verbose = YES;
        }

        s = getFirst(params[@"file"]);
        if(s)
        {
            filename = s;
        }
        else
        {
            filename = [NSString stringWithFormat:@"%@%@",prefix,name];
        }

        UMDiameterGeneratorCMD *cmd;
        s = getFirst(params[@"definition"]);
        if(s)
        {
            definitionFilename = s;
            NSError *e = NULL;
            definitionString = [NSString stringWithContentsOfFile:definitionFilename encoding:NSUTF8StringEncoding error:&e];
            if(e)
            {
                NSLog(@"%@",e);
                exit(-1);
            }

            cmd = [[UMDiameterGeneratorCMD alloc]initWithString:definitionString error:&e];
            if(cmd==NULL)
            {
                NSLog(@"can not parse %@ because of %@",s,e);
            }
        }

        s = getFirst(params[@"write-command-header"]);
        {
            if(s.length>0)
            {
                headerFileName = s;
                NSString *content = [cmd headerFileWithPrefix:@"UMDiameterPacket"
                                                    avpPrefix:@"UMDiameterAvp"
                                                         user:user
                                                         date:date];
                NSError *e = NULL;
                if(verbose)
                {
                    fprintf(stderr,"writing header to %s\n",headerFileName.UTF8String);
                    fflush(stderr);
                }
                [content writeToFile:headerFileName atomically:YES encoding:NSUTF8StringEncoding error:&e];
                if(e)
                {
                    NSLog(@"Error: %@",e);
                }
            }
        }

        s = getFirst(params[@"write-command-method"]);
        {
            if(s.length>0)
            {
                methodFileName = s;

                NSString *content = [cmd methodFileWithPrefix:@"UMDiameterPacket"
                                                    avpPrefix:@"UMDiameterAvp"
                                                         user:user
                                                         date:date];
                NSError *e = NULL;
                if(verbose)
                {
                    fprintf(stdout,"writing methods to %s\n",methodFileName.UTF8String);
                    fflush(stdout);
                }
                [content writeToFile:methodFileName atomically:YES encoding:NSUTF8StringEncoding error:&e];
                if(e)
                {
                    NSLog(@"Error: %@",e);
                }
            }
        }
    }
    return 0;
}

