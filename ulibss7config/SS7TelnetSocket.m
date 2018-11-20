//
//  SS7TelnetSocket.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//
#import "SS7TelnetSocket.h"
#import "SS7ConfigurationSession.h"
#include <unistd.h>

@implementation SS7TelnetSocket

#pragma mark Thread handling

- (SS7TelnetSocket *)init
{
    self = [super init];
    if(self)
    {
        _txSleeper = [[UMSleeper alloc]init];
    }
    return self;
}
- (void)startListener
{
    self.endThisConnection = NO;
    self.endPermanently = NO;

    [self runSelectorInBackground:@selector(inboundListener)];
}

- (void)stopListener
{
    self.endThisConnection = YES;
    self.endPermanently = YES;
}


- (void)incomingBreak
{
    [_sock sendString:@"*break*"];
}

- (void) incomingInterruptProcess
{
    [_sock sendString:@"*interrupt-process*"];
}

- (void)incomingAbortOutput
{
    [_sock sendString:@"*abort-output*"];

}

- (void)incomingAreYouThere
{
    [_sock sendString:@"*are-you-there*"];
}

- (void)incomingEraseCharacter
{
    [_sock sendString:@"*incoming-erase-character*"];
}

- (void)incomingEraseLine
{
    [_sock sendString:@"*incoming-erase-line*"];
}

- (void)incomingGoAhead
{
    [_sock sendString:@"*incoming-go-ahead*"];
}

- (void)incomingWILL:(int)v
{
}

-(void) incomingWONT:(int)v
{
}

-(void) incomingDO:(int)v
{
    if(v == TelnetOption_Echo)
    {
        _doEcho = YES;
    }
}

- (void)incomingDONT:(int)v
{
    if(v == TelnetOption_Echo)
    {
        _doEcho = NO;
    }
}

- (void) sendWILL:(int)v
{
    unsigned char buf[3];
    buf[0] = TelnetSignal_IAC;
    buf[1] = TelnetSignal_WILL;
    buf[2] = v;
    [_sock sendBytes:&buf length:3];

}

- (void) sendWONT:(int)v
{
    unsigned char buf[3];
    buf[0] = TelnetSignal_IAC;
    buf[1] = TelnetSignal_WONT;
    buf[2] = v;
    [_sock sendBytes:&buf length:3];

}

- (void) sendDO:(int)v
{
    unsigned char buf[3];
    buf[0] = TelnetSignal_IAC;
    buf[1] = TelnetSignal_DO;
    buf[2] = v;
    [_sock sendBytes:&buf length:3];
}

- (void) sendDONT:(int)v
{
    unsigned char buf[3];
    buf[0] = TelnetSignal_IAC;
    buf[1] = TelnetSignal_DONT;
    buf[2] = v;
    [_sock sendBytes:&buf length:3];
}

- (void)processSB:(NSData *)d
{
    /* example: 1f00ea00 17 */
    NSLog(@"SB=%@",d);
}

- (void)incomingCharacterProcessing:(unsigned char)c
{
    int v = c;
    if(_telnetState == TelnetState_idle)
    {
        switch(v)
        {
            case TelnetSignal_IAC:
                _telnetState = TelnetState_IAC;
                break;
            default:
                [self incomingCharacterProcessing2:c];
                break;
        }
    }
    else if(_telnetState == TelnetState_IAC)
    {
        switch(v)
        {
            case TelnetSignal_Break:
                [self incomingBreak];
                _telnetState = TelnetState_idle;
                break;
            case TelnetSignal_InterruptProcess:
                [self incomingInterruptProcess];
                _telnetState = TelnetState_idle;
                break;

            case TelnetSignal_AbortOutput:
                [self incomingAbortOutput];
                _telnetState = TelnetState_idle;
                break;
            case TelnetSignal_AreYouThere:
                [self incomingAreYouThere];
                _telnetState = TelnetState_idle;
                break;

            case TelnetSignal_EraseCharacter:
                [self incomingEraseCharacter];
                _telnetState = TelnetState_idle;
                break;

            case TelnetSignal_EraseLine:
                [self incomingEraseLine];
                _telnetState = TelnetState_idle;
                break;

            case TelnetSignal_GoAhead:
                [self incomingGoAhead];
                _telnetState = TelnetState_idle;
                break;

            case TelnetSignal_SB:
                _telnetState = TelnetState_SB;
                _sb_buffer = [[NSMutableData alloc]init];
                break;
            case TelnetSignal_SE:
                _telnetState = TelnetState_idle;
                break;
            case TelnetSignal_WILL:
                _telnetState = TelnetState_WILL;
                break;

            case TelnetSignal_WONT:
                _telnetState = TelnetState_WONT;
                break;

            case TelnetSignal_DO:
                _telnetState = TelnetState_DO;
                break;

            case TelnetSignal_DONT:
                _telnetState = TelnetState_DONT;
                break;

        }
    }
    else if(_telnetState == TelnetState_WILL)
    {
        [self incomingWILL:v];
        _telnetState = TelnetState_idle;
    }
    else if(_telnetState == TelnetState_DO)
    {
        [self incomingDO:v];
        _telnetState = TelnetState_idle;
    }
    else if(_telnetState == TelnetState_WONT)
    {
        [self incomingWONT:v];
        _telnetState = TelnetState_idle;
    }
    else if(_telnetState == TelnetState_DONT)
    {
        [self incomingDONT:v];
        _telnetState = TelnetState_idle;
    }
    else if(_telnetState == TelnetState_SB)
    {
        switch(v)
        {
            case TelnetSignal_IAC:
                _telnetState = TelnetState_SB_IAC;
                break;
            default:
                [_sb_buffer appendByte:v];
                _telnetState = TelnetState_SB;
        }
    }
    else if(_telnetState == TelnetState_SB_IAC)
    {
        switch(v)
        {
            case TelnetSignal_SE:
                _telnetState = TelnetState_idle;
                [self processSB:_sb_buffer];
                _sb_buffer = NULL;
                break;
            default:
                [_sb_buffer appendByte:TelnetSignal_IAC];
                [_sb_buffer appendByte:v];
                _telnetState = TelnetState_SB;
        }
    }
}

-(void) cursorUp
{
    [_sock sendString:@"<up>"];
}

-(void) cursorDown
{
    [_sock sendString:@"<down>"];

}

-(void) cursorLeft
{
    if(_cursor > 0)
    {
        _cursor--;
        if(_doEcho)
        {
            [_sock sendString:@"\x1B[D"];
        }
    }
}

-(void) cursorRight
{
    if(_cursor < _incomingBuffer.length)
    {
        _cursor++;
        if(_doEcho)
        {
            [_sock sendString:@"\x1B[C"];
        }
    }
}

-(void) keyF1
{
    [_sock sendString:@"<F1>"];
}

-(void) keyF2
{
    [_sock sendString:@"<F2>"];
}

-(void) keyF3
{
    [_sock sendString:@"<F3>"];
}

- (BOOL)processEscape
{
    switch(_escapes[0])
    {
        case '\0':
            return NO;

        case'O':
        {
            switch(_escapes[1])
            {        case '\0':
                    return NO;
                case 'P':
                {
                    [self keyF1];
                    return YES;
                }
                case 'Q':
                {
                    [self keyF2];
                    return YES;
                }
                case 'R':
                {
                    [self keyF3];
                    return YES;
                }
                default:
                    return YES;
            }
            break;
        }
        case'[':
        {
            switch(_escapes[1])
            {
                case '\0':
                    return NO;
                case 'A':
                {
                    [self cursorUp];
                    return YES;
                }
                case 'B':
                {
                    [self cursorDown];
                    return YES;
                }
                case 'C':
                {
                    [self cursorRight];
                    return YES;
                }
                case 'D':
                {
                    [self cursorLeft];
                    return YES;
                }
                default:
                    return YES;
            }
            break;
        }
        default:
            return YES;
    }
    return YES;
}

- (void)redrawLine
{
    /* we redraw the full line */
    [_sock sendString:@"\x1B[2K"]; /* clear line */

    if(self.incomingStatus == CS_STATUS_INCOMING_PASSWORD)
    {
        for(NSInteger i=0;i<_incomingBuffer.length;i++)
        {
            [_sock writeSingleChar:'*'];
        }
    }
    else
    {
        [_sock sendString:_incomingBuffer];
    }
    NSInteger i;
    /* move cursor to correct position */
    for(i=_incomingBuffer.length;i>_cursor;i++)
    {
        [_sock sendString:@"\x1B[D"];
    }
}

- (void)incomingCharacterProcessing2:(unsigned char)c
{
    if(_inEscape)
    {
        if(_escapeLen < sizeof(_escapes))
        {
            _escapes[_escapeLen++] = c;
        }
        BOOL complete = [self processEscape];
        if(complete)
        {
            _inEscape=NO;
        }
    }
    else
    {
        if((c == TELNET_CHAR_BS) || (c==TELNET_CHAR_DEL)) /* backspace */
        {
            if(_cursor >0)
            {
                /* remove previous char */
                [_incomingBuffer replaceCharactersInRange:NSMakeRange(_cursor-1,1) withString:@""];
                _cursor--;
                if(_doEcho)
                {
                    if(_cursor == _incomingBuffer.length)
                    {
                        /* we are at the end of the line */
                        [_sock writeSingleChar:TELNET_CHAR_BS];
                        [_sock writeSingleChar:' '];
                        [_sock writeSingleChar:TELNET_CHAR_BS];
                    }
                    else
                    {
                        /* we are somewhere in the middle */
                        [self redrawLine];
                    }
                }
            }
            return;
        }
        else if(c == TELNET_CHAR_CR) /* carriage return */
        {
            _crReceived = YES;
            return;
        }
        else if(c == TELNET_CHAR_NUL) /* linefeed */
        {
            if(_crReceived)
            {
                if(_doEcho)
                {
                    [_sock sendString:@"\r\n"];
                }
                _fullLineReceived  = YES;
                _cursor=0;
            }
            _crReceived = NO;
        }
        else if(c == TELNET_CHAR_LF) /* linefeed */
        {
            if(_crReceived)
            {
                if(_doEcho)
                {
                    [_sock sendString:@"\r\n"];
                }
                _fullLineReceived  = YES;
                _cursor=0;
            }
            _crReceived = NO;
        }
        else if(c == 3) /* control-C */
        {
            if(_doEcho)
            {
                [_sock writeSingleChar:'^'];
                [_sock writeSingleChar:'C'];
                [_sock writeSingleChar:'\r'];
                [_sock writeSingleChar:'\n'];
            }
            _incomingBuffer = [[NSMutableString alloc]init];
            _cursor = 0;
            if(self.incomingStatus == CS_STATUS_INCOMING_LOGIN)
            {
                [self sendLoginPrompt];
            }
            else if(self.incomingStatus == CS_STATUS_INCOMING_PASSWORD)
            {
                [self sendPasswordPrompt];
            }
            else
            {
                [self sendPrompt];
            }
            return;
        }
        else if(c==18) /* control R for redraw */
        {
            [self redrawLine];
        }
        else if (c=='?')
        {
            if(_doEcho)
            {
                [_sock writeSingleChar:c];
            }
            [self sendSyntaxHelp];
        }
        else if (c=='\t')
        {
            [self autocomplete];
        }
        else if (c==0x1B) /* escape */
        {
            _inEscape = YES;
            _escapeLen = 0;
            memset(_escapes,0x00,sizeof(_escapes));
        }
        else
        {
            if(_cursor == _incomingBuffer.length)
            {
                if(_doEcho)
                {
                    if(self.incomingStatus == CS_STATUS_INCOMING_PASSWORD)
                    {
                        [_sock writeSingleChar:'*'];
                    }
                    else
                    {
                        [_sock writeSingleChar:c];
                    }
                }
                [_incomingBuffer appendFormat:@"%c",c];
                _cursor++;
            }
            else
            {
                NSString *chr = [NSString stringWithFormat:@"%c",c];
                [_incomingBuffer insertString:chr atIndex:_cursor];
                _cursor++;
                [self redrawLine];
            }

        }
        if(_fullLineReceived)
        {
            _processLine = _incomingBuffer;
            _incomingBuffer = [[NSMutableString alloc]init];
            _cursor = 0;
            _fullLineReceived = NO;
        }
    }
}

- (void) inboundListener
{
    UMSocket    *newUc;

    self.isListener = YES;
    ulib_set_thread_name(@"CS Listener");

    UMSocketError    err;
    NSDate *retryTime = nil;
    //NSTimeInterval bindDelay = 30;
    NSTimeInterval retryDelay = 10;

    _receivePollTimeoutMs = 100;

    [logFeed info:0 withText:[NSString stringWithFormat:@"ConfigurationSocketListener listening on port %d\r\n",self.localPort]];

    while (!self.endThisConnection)
    {
        switch(_incomingStatus)
        {
            case CS_STATUS_INCOMING_OFF:
                _sock = [[UMSocket alloc] initWithType:UMSOCKET_TYPE_TCP4ONLY];
                [_sock setLocalHost:self.localHost];
                [_sock setLocalPort:self.localPort];
                _incomingStatus = CS_STATUS_INCOMING_HAS_SOCKET;
                break;

            case CS_STATUS_INCOMING_HAS_SOCKET:
                err = [_sock bind];
                if (![_sock isBound] )
                {
                    [logFeed majorError:err withText:@"bind failed\r\n"];
                    //retryTime = [[NSDate alloc]initWithTimeIntervalSinceNow:bindDelay];
                    _incomingStatus = CS_STATUS_INCOMING_BIND_RETRY_TIMER;
                }
                else
                {
                    TRACK_FILE_ADD_COMMENT_FOR_FDES([_sock sock],@"bound");
                    _incomingStatus = CS_STATUS_INCOMING_BOUND;
                    retryDelay = 10;
                }
                break;

            case CS_STATUS_INCOMING_BOUND:
                if(self.advertizeName)
                {
                    _sock.advertizeName = self.advertizeName;
                    _sock.advertizeDomain = @"";
                    _sock.advertizeType = @"_telnet._tcp";
                }
                err = [_sock listen];
                if (![_sock isListening] )
                {
                    [logFeed majorError:err withText:@"listen failed\r\n"];
                    //retryTime = [[NSDate alloc]initWithTimeIntervalSinceNow:retryDelay];
                    retryDelay = retryDelay * 2;
                    if(retryDelay > 600)
                        retryDelay = 600; /* try max every 10 minutes */
                    _incomingStatus = CS_STATUS_INCOMING_LISTEN_WAIT_TIMER;
                }
                else
                {
                    TRACK_FILE_ADD_COMMENT_FOR_FDES([_sock sock],@"listening");
                    _incomingStatus = CS_STATUS_INCOMING_LISTENING;
                    [logFeed debug:0 withText:@"Listening...\r\n"];
                }
                break;
            case CS_STATUS_INCOMING_LISTENING:
                err = [_sock dataIsAvailable:_receivePollTimeoutMs];
                if(err == UMSocketError_has_data)
                {
                    UMSocketError ret;
                    newUc = [_sock accept:&ret];
                    if(newUc)
                    {
                        TRACK_FILE_ADD_COMMENT_FOR_FDES([_sock sock],@"accept");
                        BOOL doAccept = YES;
                        if([_delegate respondsToSelector:@selector(isAddressWhitelisted:)])
                        {
                            doAccept = [_delegate isAddressWhitelisted:newUc.connectedRemoteAddress];
                        }
                        if(doAccept)
                        {
                            SS7TelnetSocket *e = [[SS7TelnetSocket alloc] init];
                            [e setSock: newUc];
                            [e setDelegate: _delegate];
                            [e setLocalHost: [newUc localHost]];
                            [e setLocalPort: [newUc connectedLocalPort]];
                            [e setRemoteHost: [[UMHost alloc]initWithAddress:newUc.connectedRemoteAddress]];
                            [e setRemotePort: [newUc connectedRemotePort]];
                            [e setIncomingStatus: CS_STATUS_INCOMING_LOGIN];
                            [e setIsListener: NO];
                            [e setLastActivity:[NSDate date]];
                            [e setLogFeed:logFeed];
                            [logFeed debug:0 withText:[NSString stringWithFormat:@"accepting new connection from %@\r\n",newUc.remoteHost.description]];
                            [e runSelectorInBackground:@selector(inbound)];
                        }
                        else
                        {
                            TRACK_FILE_ADD_COMMENT_FOR_FDES([_sock sock],@"failed whitelist");
                            [logFeed debug:0 withText:[NSString stringWithFormat:@"rejected new connection from %@\r\n",newUc.remoteHost.description]];
                            [newUc close];
                            newUc=NULL;
                        }
                    }
                    else
                    {
                        [_txSleeper sleep:100000]; /* check again in 100ms */
                    }
                }
                self.incomingStatus = CS_STATUS_INCOMING_LISTENING;
                break;
            default:
                break;
        }
    }

    [logFeed info:0 withText:[NSString stringWithFormat:@"ConfigurationSocket on port %d shutting down\r\n",_localPort]];
    [_sock close];
    _sock = nil;
    retryTime = nil;
}


- (void)sendPrompt
{
    [_sock sendString:@"stp# "];

}

- (void)sendGoodbye
{
    [_sock sendString:@"\r\nGoodbye\r\n"];
}

- (void) sendLoginBanner
{
    [_sock sendString:@"\r\n\r\nUser Access Verification\r\n"];
}

- (void) sendLoginSuccess
{
    [_sock sendString:@"\r\nWelcome to UniversalSS7 STP!\r\n"];
}

- (void) sendLoginFailed
{
    [_sock sendString:@"\r\nUsername/Password mismatch\r\n"];
}

- (void) sendLoginPrompt
{
    [_sock sendString:@"\r\nUsername: "];
}

- (void) sendPasswordPrompt
{
    [_sock sendString:@"Password: "];
}

- (void)sendTimeoutMessage
{
    [_sock sendString:@"\r\n*timeout*\r\n"];
}

- (void)processLine:(NSString *)incomingBuffer
{
    @try
    {
        BOOL mustQuit = [_config_session processLine:incomingBuffer];
        if(mustQuit)
        {
            self.endThisConnection = YES;
            [self sendGoodbye];
            return;
        }
    }
    @catch(NSException *e)
    {
        NSString *s = [e description];
        [_sock sendString:s];
        [_sock sendString:@"\r\n"];
    }
    [self sendPrompt];
}

- (void) autocomplete
{
    NSString *autocomplete = @"";
    @try
    {
        autocomplete = [_config_session autocompleteLine:_incomingBuffer];
    }
    @catch(NSException *e)
    {
        NSString *s = [e description];
        [_sock sendString:s];
        [_sock sendString:@"\r\n"];
    }
    if(autocomplete.length > 0)
    {
        _incomingBuffer = [autocomplete mutableCopy];
    }
    [_sock sendString:@"\r\n"];
    [self sendPrompt];
    [_sock sendString:_incomingBuffer];
    _cursor = _incomingBuffer.length;
}

- (void)sendSyntaxHelp
{
    NSString *help = @"";
    @try
    {
        help = [_config_session helpLine:_incomingBuffer];
    }
    @catch(NSException *e)
    {
        NSString *s = [e description];
        [_sock sendString:s];
        [_sock sendString:@"\r\n"];
    }
    [_sock sendString:@"\r\n"];
    [_sock sendString:help];
    [self sendPrompt];
    [_sock sendString:_incomingBuffer];
    _cursor = _incomingBuffer.length;
}

- (BOOL)telnetAuthenticateUser:(NSString *)username password:(NSString *)pw
{
    if(([username isEqualToString:@"a"])
       && ([pw isEqualToString:@"b"]))
    {
        return YES;
    }
    return NO;
}

- (void) inbound
{
    ulib_set_thread_name([NSString stringWithFormat:@"ConfigurationSocket:%@",_sock.description]);
    TRACK_FILE_ADD_COMMENT_FOR_FDES(_sock.sock,@"inbound");

    [logFeed info:0 inSubsection:@"init" withText:@"ConfigurationSocket inbound starting\r\n"];

    NSDate *loginPromptExpires = NULL;//[[NSDate alloc]initWithTimeIntervalSinceNow:30]; /* we want to see authentication being passed within 30 seconds */

    NSString *username;
    NSString *password;

    _config_session = [[SS7ConfigurationSession alloc]init];
    [self sendWILL:TelnetOption_Echo];
    [self sendWILL:TelnetOption_SuppressGoAhead];
    [self sendDO:TelnetOption_TerminalType];
    [self sendDO:TelnetOption_WindowSize];
    [self sendLoginBanner];
    [self sendLoginPrompt];
    _incomingBuffer = [[NSMutableString alloc]init];
    _cursor = 0;

    while ((!self.endThisConnection) &&
           ((self.incomingStatus ==CS_STATUS_INCOMING_LOGIN) ||
            (self.incomingStatus ==  CS_STATUS_INCOMING_PASSWORD) ||
            (self.incomingStatus ==  CS_STATUS_INCOMING_ACTIVE)))
    {
        /* read input and process it */
        unsigned char c;
        UMSocketError err = [_sock receiveSingleChar:&c];
        if(err<0)
        {
            [_txSleeper sleep:10000]; /* check again in 10 ms */
            continue;
        }
        [self incomingCharacterProcessing:c];


        switch(self.incomingStatus)
        {
            case CS_STATUS_INCOMING_LOGIN:
            {
                if(_processLine)
                {
                    username = _processLine;
                    _processLine = NULL;
                    self.incomingStatus = CS_STATUS_INCOMING_PASSWORD;
                    [self sendPasswordPrompt];
                }
                break;
            }
            case CS_STATUS_INCOMING_PASSWORD:
            {
                if(_processLine)
                {
                    password = _processLine;
                    _processLine = NULL;
                    if([self telnetAuthenticateUser:username password:password]==YES)
                    {
                        self.incomingStatus = CS_STATUS_INCOMING_ACTIVE;
                        [self sendLoginSuccess];
                        [self sendPrompt];

                    }
                    else
                    {
                        _failedLoginCount++;
                        [self sendLoginFailed];
                        if(_failedLoginCount < 3)
                        {
                            [self sendLoginPrompt];
                            self.incomingStatus = CS_STATUS_INCOMING_LOGIN;
                        }
                        else
                        {
                            self.incomingStatus = CS_STATUS_INCOMING_OFF;
                            break;
                        }

                    }
                    loginPromptExpires = NULL;
                }
                break;
            }
            default:
                if(_processLine)
                {
                    [self processLine:_processLine];
                    _processLine = NULL;
                }
        }

        if(loginPromptExpires != NULL)
        {
            if([loginPromptExpires  timeIntervalSinceNow] < 0)
            {
                loginPromptExpires = NULL;
                [self sendTimeoutMessage];
                self.incomingStatus = CS_STATUS_INCOMING_MAJOR_FAILURE;
                sleep(1); /* we wait one second before the connection closes */
            }
        }
    }
    [_sock close];
    _sock = NULL;
    _config_session = NULL;
    NSString *msg = [NSString stringWithFormat:@"ConfigurationSocket terminate"];
    [logFeed info:0 inSubsection:@"shutdown" withText:msg];
}

@end
