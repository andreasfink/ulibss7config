//
//  UMSS7Filter.M
//  estp
//
//  Created by Andreas Fink on 20.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibcamel/ulibcamel.h>
#import <ulibtcap/ulibtcap.h>

#import "UMSS7Filter.h"

int         plugin_init(void);
int         plugin_exit(void);
NSString *  plugin_name(void);
UMPlugin *  plugin_create(void);
NSDictionary *plugin_info(void);

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

- (void)activate
{
    _isActive = YES;
}

- (void)deactivate
{
    _isActive = NO;
}

- (BOOL)isActive
{
    return _isActive;
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

- (UMSCCP_FilterMatchResult) matchesPacket:(UMSCCP_Packet *)packet
{
    return UMSCCP_FilterMatchResult_untested;
}

static UMLayerTCAP *tcapCamelDecodeInstance;
static UMLayerTCAP *tcapGsmmapDecodeInstance;
static UMLayerCamel *camelDecodeInstance;
static UMLayerGSMMAP *gsmmapDecodeInstance;

+ (void) sccpDecodeTcapGsmmap:(UMSCCP_Packet *)packet;
{
    UMTCAP_sccpNUnitdata *task;
    UMLayerTCAP *tcap;
    BOOL isCamel;
    
    if(tcapCamelDecodeInstance == NULL)
    {
        tcapCamelDecodeInstance = [[UMLayerTCAP alloc]initWithoutExecutionQueue:@"tcap-decode-camel"];
    }
    if(tcapGsmmapDecodeInstance == NULL)
    {
        tcapGsmmapDecodeInstance = [[UMLayerTCAP alloc]initWithoutExecutionQueue:@"tcap-decode-gsmmap"];
    }
    if(camelDecodeInstance == NULL)
    {
        camelDecodeInstance = [[UMLayerCamel alloc]initWithoutExecutionQueue:@"camel-decode"];
        tcapCamelDecodeInstance.tcapDefaultUser = camelDecodeInstance;
    }
    if(gsmmapDecodeInstance)
    {
        gsmmapDecodeInstance = [[UMLayerGSMMAP alloc]initWithoutExecutionQueue:@"gsmmap-decode"];
        tcapGsmmapDecodeInstance.tcapDefaultUser = gsmmapDecodeInstance;
    }
    
    if((packet.incomingCalledPartyAddress.ssn.ssn == SCCP_SSN_CAP) || (packet.incomingCallingPartyAddress.ssn.ssn == SCCP_SSN_CAP))
    {
        tcap = tcapCamelDecodeInstance;
        isCamel = YES;
    }
    else
    {
        tcap = tcapGsmmapDecodeInstance;
        isCamel = NO;
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
        @autoreleasepool
        {
            [task main];
        }
        UMASN1Object *asn1 = task.asn1;
        packet.incomingTcapAsn1 = asn1;
        if([asn1 isKindOfClass:[UMTCAP_itu_asn1_begin class]])
        {
            packet.incomingTcapBegin = (UMTCAP_itu_asn1_begin *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_BEGIN;
            packet.incoming_tcap_otid = packet.incomingTcapBegin.otid.asn1_data.hexString;
            if(!isCamel)
            {
                packet.incomingGsmMapOperations = packet.incomingTcapBegin.componentPortion.arrayOfOperationCodes;
            }
            else
            {
                /* FIXME: what to decode for camel? */
            }
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_continue class]])
        {
            packet.incomingTcapContinue = (UMTCAP_itu_asn1_continue *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_CONTINUE;
            packet.incoming_tcap_otid = packet.incomingTcapContinue.otid.asn1_data.hexString;
            packet.incoming_tcap_dtid = packet.incomingTcapContinue.dtid.asn1_data.hexString;
            if(!isCamel)
            {
                packet.incomingGsmMapOperations = packet.incomingTcapBegin.componentPortion.arrayOfOperationCodes;
            }
            else
            {
                /* FIXME: what to decode for camel? */
            }
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_end class]])
        {
            packet.incomingTcapEnd = (UMTCAP_itu_asn1_end *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_END;
            packet.incoming_tcap_dtid = packet.incomingTcapEnd.dtid.asn1_data.hexString;
            if(!isCamel)
            {
                packet.incomingGsmMapOperations = packet.incomingTcapBegin.componentPortion.arrayOfOperationCodes;
            }
            else
            {
                /* FIXME: what to decode for camel? */
            }
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_abort class]])
        {
            packet.incomingTcapAbort = (UMTCAP_itu_asn1_abort *)asn1;
            packet.incoming_tcap_dtid = packet.incomingTcapAbort.dtid.asn1_data.hexString;
            packet.incomingTcapCommand = TCAP_TAG_ITU_ABORT;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_unidirectional class]])
        {
            packet.incomingTcapUnidirectional = (UMTCAP_itu_asn1_unidirectional *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_UNIDIRECTIONAL;
        }
        packet.incomingLocalTransactionId   = task.currentLocalTransactionId;
        packet.incomingRemoteTransactionId  = task.currentRemoteTransactionId;
    }
    @catch(NSException *e)
    {
        packet.canNotDecode = YES;
    }
}

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;
{
    int filterResult = UMSCCP_FILTER_RESULT_UNMODIFIED;

    UMTCAP_sccpNUnitdata *task;
    UMLayerTCAP *tcap;
    if((packet.incomingCalledPartyAddress.ssn.ssn == SCCP_SSN_CAP) || (packet.incomingCallingPartyAddress.ssn.ssn == SCCP_SSN_CAP))
    {
        if(_tcap_camel == NULL)
        {
            _tcap_camel = [[UMLayerTCAP alloc]initWithoutExecutionQueue:@"tcap-camel"];
            if(_camel == NULL)
            {
                _camel =[[UMLayerCamel alloc]initWithoutExecutionQueue:@"camel"];
            }
            _tcap_camel.tcapDefaultUser = _camel;
        }
        tcap = _tcap_camel;
    }
    else
    {
        if(_tcap_gsmmap == NULL)
        {
            _tcap_gsmmap = [[UMLayerTCAP alloc]initWithoutExecutionQueue:@"tcap-gsmmap"];
            if(_gsmmap == NULL)
            {
                _gsmmap = [[UMLayerGSMMAP alloc]initWithoutExecutionQueue:@"gsmmap"];
            }
            _tcap_gsmmap.tcapDefaultUser = _gsmmap;
        }
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
        @autoreleasepool
        {
            [task main];
        }
        UMASN1Object *asn1 = task.asn1;
        packet.incomingTcapAsn1 = asn1;
        if([asn1 isKindOfClass:[UMTCAP_itu_asn1_begin class]])
        {
            packet.incomingTcapBegin = (UMTCAP_itu_asn1_begin *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_BEGIN;
            packet.incoming_tcap_otid = packet.incomingTcapBegin.otid.asn1_data.hexString;
            packet.incomingGsmMapOperations = packet.incomingTcapBegin.componentPortion.arrayOfOperationCodes;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_continue class]])
        {
            packet.incomingTcapContinue = (UMTCAP_itu_asn1_continue *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_CONTINUE;
            packet.incoming_tcap_otid = packet.incomingTcapContinue.otid.asn1_data.hexString;
            packet.incoming_tcap_dtid = packet.incomingTcapContinue.dtid.asn1_data.hexString;
            packet.incomingGsmMapOperations = packet.incomingTcapBegin.componentPortion.arrayOfOperationCodes;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_end class]])
        {
            packet.incomingTcapEnd = (UMTCAP_itu_asn1_end *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_END;
            packet.incoming_tcap_dtid = packet.incomingTcapEnd.dtid.asn1_data.hexString;
            packet.incomingGsmMapOperations = packet.incomingTcapBegin.componentPortion.arrayOfOperationCodes;
        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_abort class]])
        {
            packet.incomingTcapAbort = (UMTCAP_itu_asn1_abort *)asn1;
            packet.incoming_tcap_dtid = packet.incomingTcapAbort.dtid.asn1_data.hexString;
            packet.incomingTcapCommand = TCAP_TAG_ITU_ABORT;

        }
        else if([asn1 isKindOfClass:[UMTCAP_itu_asn1_unidirectional class]])
        {
            packet.incomingTcapUnidirectional = (UMTCAP_itu_asn1_unidirectional *)asn1;
            packet.incomingTcapCommand = TCAP_TAG_ITU_UNIDIRECTIONAL;

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

- (BOOL)processConfig:(NSString *)jsonString error:(NSError**)eptr
{
    BOOL returnValue = NO;
    if(eptr)
    {
        *eptr = NULL;
    }
    UMJsonParser *parser = [[UMJsonParser alloc]init];
    id jsonObject = [parser objectWithString:jsonString error:eptr];

    if(![jsonObject isKindOfClass:[NSDictionary class]])
    {
        if(eptr)
        {
            *eptr = [[NSError alloc]initWithDomain:@"PARSING" code:105 userInfo:@{@"reason":@"json object is not dictionary" }];
            returnValue = YES;
        }
    }
    else
    {
        NSDictionary *dict = (NSDictionary *)jsonObject;
        returnValue = [self processConfigDict:dict error:eptr];
    }
    return returnValue;
}

- (BOOL)processConfigDict:(NSDictionary *)dict error:(NSError**)eptr
{
    BOOL returnValue = NO;
    if(eptr)
    {
        *eptr = NULL;
    }
    return returnValue;
    /* this should be overwritten */
}

- (void)refreshConfig /* this is called if a namedlist is updated so the engines can readjust its internal structures if needed */
{
    /* this can be overwritten */
}

- (void)processConfig
{
}

- (NSString *)filterName
{
    return @"undefined";
}

- (NSString *)filterDescription
{
    return @"undefined";
}


- (UMSCCP_FilterResult) filterOutbound:(UMSCCP_Packet *)packet;
{
    return UMSCCP_FILTER_RESULT_UNMODIFIED;
}

- (UMSCCP_FilterResult) filterFromLocalSubsystem:(UMSCCP_Packet *)packet
{
    return UMSCCP_FILTER_RESULT_UNMODIFIED;
}
- (UMSCCP_FilterResult) filterToLocalSubsystem:(UMSCCP_Packet *)packet
{
    return UMSCCP_FILTER_RESULT_UNMODIFIED;
}

- (void)filterActivate
{
    _isActive = YES;
}


- (void)filterDeactivate
{
    _isActive=NO;
}


- (BOOL)isFilterActive
{
    return _isActive;
}


@end


int         plugin_init(void)
{
    return 0;
}

int         plugin_exit(void)
{
    return 0;
}

NSString *  plugin_name(void)
{
    return @"ss7-filter";
}

UMPlugin *  plugin_create(void)
{
    UMPlugin *plugin = [[UMSS7Filter alloc]init];
    return plugin;
}

NSDictionary *plugin_info(void)
{
    return @{ @"name" : @"ss7-filter" };
}




