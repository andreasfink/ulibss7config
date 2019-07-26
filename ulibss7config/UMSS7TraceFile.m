//
//  UMSS7TraceFile.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7TraceFile.h"


@implementation UMSS7TraceFile

- (UMSS7TraceFile *)initWithSS7Config:(UMSS7ConfigSS7FilterTraceFile *)config defaultPath:(NSString *)path
{
	self = [super init];
	if(self)
	{
		_config = [config copy];
        _pcap =[[UMPCAPFile alloc]init];
        _maxRotations = 100;
        _maxMinutes = 15;
        _maxPackets = 10000;
        _createdTime = [NSDate date];
        _currentPackets = 0;
        _lock = [[UMMutex alloc]init];
        _enabled=YES;
        _isOpen = NO;
        _isDirty = YES;
        if(config.maxRotations)
        {
            _maxRotations = [config.maxRotations intValue];
        }
        if(config.minutes)
        {
            _maxMinutes = [config.minutes intValue];
        }
        if(config.packets)
        {
            _maxPackets = [config.packets intValue];
        }

        NSString *fullPath = [NSString stringWithFormat:@"%@/%@",path, config.filename];
        char resolved[PATH_MAX];
        char *resolvedPath = realpath(fullPath.UTF8String, resolved);

        _fullFilename = @(resolvedPath);
        if(_fullFilename==NULL)
        {
            return NULL;
        }
        _containingDirectory = [_fullFilename stringByDeletingLastPathComponent];
        _relativeFilename = [_fullFilename lastPathComponent];
        _fullFilenameNoExtenion = [_fullFilename stringByDeletingPathExtension];
        _fileExtension = [_fullFilename pathExtension];

        NSFileManager *fm = [NSFileManager defaultManager];
        if([fm fileExistsAtPath:_fullFilename])
        {
            [self rotateFiles];
        }
	}
	return self;
}

- (void)logPacket:(UMSCCP_Packet *)packet
{
    if(_enabled==NO)
    {
        return;
    }

    [_lock lock];
    if(_isOpen==NO)
    {
        [self open];
    }
    NSDate *now = [NSDate date];
    [_pcap writePdu:packet.incomingMtp3Data];
    _currentPackets++;
    if(_currentPackets>=_maxPackets)
    {
        [self rotateFiles];
        _currentPackets=0;
    }
    else if(_currentPackets>0)
    {
        if(_lastPacketTime)
        {
            NSTimeInterval diff = [now timeIntervalSinceDate:_lastPacketTime];
            if((diff/60) > _maxMinutes)
            {
                [self rotateFiles];
            }
        }
    }
    _lastPacketTime = now;
    [_lock unlock];
}

- (void)open
{
    [_pcap openForMtp3];
    _isOpen=YES;
}

- (void)close
{
    [_pcap close];
    _isOpen=NO;
}

- (void)rotate
{
    [_lock lock];
    [_pcap close];
    [self rotateFiles];
    [_pcap openForMtp3];
    [_lock unlock];
}


- (void)enable
{
    [_lock lock];
    _enabled=YES;
    [self open];
    [_lock unlock];
}

- (void)disable
{
    [_lock lock];
    _enabled=NO;
    [self close];
    [_lock unlock];
}

- (void)action:(NSString *)action
{
    if([action isEqualToString:@"rotate"])
    {
        [self rotate];
    }
}

- (void)rotateFiles
{
    [_lock lock];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *s0 = [NSString stringWithFormat:@"%@-%06d.%@",_fullFilenameNoExtenion,_maxRotations,_fileExtension];
    for(int i=_maxRotations-1;i>0;i--)
    {
        NSString *s1;
        if(i>1)
        {
            s1 = [NSString stringWithFormat:@"%@-%06d.%@",_fullFilenameNoExtenion,i,_fileExtension];
        }
        else
        {
            s1 = _fullFilename;
        }
        if([fm fileExistsAtPath:s0])
        {
            NSError *e = NULL;
            [fm removeItemAtPath:s0 error:&e];
            if(e)
            {
                NSLog(@"Error while removing file %@: %@",s0,e);
            }
        }
        if([fm fileExistsAtPath:s1])
        {
            NSError *e = NULL;
            [fm moveItemAtPath:s1 toPath:s0 error:&e];
            if(e)
            {
                NSLog(@"Error while moving file %@ to %@: %@",s1,s0,e);
            }
        }
        s0 = s1;
    }
    [_lock unlock];
}


- (void)writeConfigToDisk
{
    NSString *f = [NSString stringWithFormat:@"%@.conf",_fullFilenameNoExtenion];
    NSString *s = [_config configString];
    NSError *e;
    [s writeToFile:f atomically:YES encoding:NSUTF8StringEncoding error:&e];
    if(e)
    {
        NSLog(@"Error writing tracefile config '%@' to %@\n%@",_config.name,s,e);
    }
}

- (void)deleteConfigOnDisk
{
    NSString *f = [NSString stringWithFormat:@"%@.conf",_fullFilenameNoExtenion];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:f])
    {
        NSError *e = NULL;
        [fm removeItemAtPath:f error:&e];
        if(e)
        {
            NSLog(@"Error while removing file %@: %@",f,e);
        }
    }
}

@end

