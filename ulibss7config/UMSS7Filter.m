//
//  UMSS7Filter.M
//  estp
//
//  Created by Andreas Fink on 20.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7Filter.h"
#import <ulibtcap/ulibtcap.h>

@implementation UMSS7Filter


- (void)genericInitialisation
{
    _tags = [[UMSynchronizedDictionary alloc] init];
}

- (UMSS7Filter *)init
{
    self = [super init];
    if(self)
    {
        [self genericInitialisation];
    }
    return self;
}

- (UMSS7Filter *)initWithConfigFile:(NSString *)configFile
{
    self = [super initWithConfigFile:configFile];
    if(self)
    {
        [self genericInitialisation];
        [self loadConfigFromFile:configFile];
    }
    return self;
}


- (void)addTag:(NSString *)tag
{
    _tags[tag]=tag;
}

- (void)clearTag:(NSString *)tag
{
    [_tags removeObjectForKey:tag];
}

- (BOOL) hasTag:(NSString *)tag
{
    if(_tags[tag])
    {
        return YES;
    }
    return NO;
}

- (void)clearAllTags
{
    _tags = [[UMSynchronizedDictionary alloc] init];
}


- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;
{
    int filterResult = UMSCCP_FILTER_RESULT_UNMODIFIED;

    UMTCAP_sccpNUnitdata *task;
    UMLayerTCAP *tcap;
    if((packet.incomingCalledPartyAddress.ssn.ssn == SCCP_SSN_CAP) || (packet.incomingCallingPartyAddress.ssn.ssn == SCCP_SSN_CAP))
    {
        tcap = _tcap_camel;
    }
    else
    {
        tcap = _tcap_gsmmap;
    }
    @try
    {
        task = [[UMTCAP_sccpNUnitdata alloc]initForTcap:tcap
                                                   sccp:packet.sccp
                                               userData:packet.incomingSccpData
                                                calling:packet.incomingCallingPartyAddress
                                                 called:packet.incomingCalledPartyAddress
                                       qualityOfService:0
                                                options:@{ @"decode-only" : @YES }];
        [task main];
        UMASN1Object *asn1 = task.asn1;
        packet.incomingTcapAsn1 = asn1;
        if([asn1 isKindOfClass:[UMTCAP_itu_asn1_begin class]])
        {
            packet.incomingTcapBegin = (UMTCAP_itu_asn1_begin *)asn1;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_continue class]])
        {
            packet.incomingTcapContinue = (UMTCAP_itu_asn1_continue *)asn1;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_end class]])
        {
            packet.incomingTcapEnd = (UMTCAP_itu_asn1_end *)asn1;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_abort class]])
        {
            packet.incomingTcapAbort = (UMTCAP_itu_asn1_abort *)asn1;
        }
        packet.incomingLocalTransactionId   = task.currentLocalTransactionId;
        packet.incomingRemoteTransactionId  = task.currentRemoteTransactionId;
    }
    @catch(NSException *e)
    {
        packet.canNotDecode = YES;
        filterResult |=  UMSCCP_FILTER_RESULT_CAN_NOT_DECODE | UMSCCP_FILTER_RESULT_ADD_TO_TRACEFILE_CAN_NOT_DECODE;
    }
    return filterResult;
}

- (void)loadConfigFromFile:(NSString *)filename
{
    NSError *e = NULL;
    NSString *jsonString = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&e];
    if(e)
    {
        NSLog(@"Can not read config from file %@. Error %@",filename,e);
    }
    [self processConfig:jsonString];
}


- (void)processConfig:(NSString *)jsonString
{
    /* this should be overwritten */
}

@end
