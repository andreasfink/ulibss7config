//
//  SS7TelnetSocket.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>
#import "SS7TelnetSocketHelperProtocol.h"

#define TELNET_CHAR_NUL    '\0'
#define TELNET_CHAR_CR      '\r'
#define TELNET_CHAR_LF      '\n'
#define TELNET_CHAR_BEL     '\x07'
#define TELNET_CHAR_BS      '\x08'
#define TELNET_CHAR_HT      '\x09'
#define TELNET_CHAR_VT      '\x0B'
#define TELNET_CHAR_FF      '\x0C'
#define TELNET_CHAR_DEL     '\x7F'
#define TELNET_CHAR_IAC      '\xFF'

typedef enum TelnetOption
{
    TelnetOption_Echo               = 0x01,
    TelnetOption_SuppressGoAhead    = 0x03,
    TelnetOption_Status             = 0x05,
    TelnetOption_TerminalType       = 0x18,
    TelnetOption_XDisplayLocation   = 0x23,
    TelnetOption_Authenticate       = 0x25,
    TelnetOption_WindowSize         = 0x1f,
    TelnetOption_TerminalSpeed      = 0x20,
    TelnetOption_RemoteFlowControl  = 0x21,
    TelnetOption_LineMode           = 0x22,
    TelnetOption_NewEnvironment     = 0x27,
} TelnetOption;

typedef enum TelnetCommands
{
    TelnetSignal_SE               = 240,
    TelnetSignal_Break            = 243,
    TelnetSignal_InterruptProcess = 244,
    TelnetSignal_AbortOutput      = 245,
    TelnetSignal_AreYouThere      = 246,
    TelnetSignal_EraseCharacter   = 247,
    TelnetSignal_EraseLine        = 248,
    TelnetSignal_GoAhead          = 249 ,
    TelnetSignal_SB               = 250,
    TelnetSignal_WILL             = 251,
    TelnetSignal_WONT             = 252,
    TelnetSignal_DO               = 253,
    TelnetSignal_DONT             = 254,
    TelnetSignal_IAC              = 255,
}TelnetCommands;

typedef enum TelnetState
{
    TelnetState_idle,
    TelnetState_IAC,
    TelnetState_SB,
    TelnetState_SB_IAC,
    TelnetState_WILL,
    TelnetState_WONT,
    TelnetState_DO,
    TelnetState_DONT,
} TelnetState;

@class SS7ConfigurationSession;

typedef enum ConfigurationSocketIncomingStatus
{
    CS_STATUS_INCOMING_OFF          = 0,
    CS_STATUS_INCOMING_HAS_SOCKET   = 1,
    CS_STATUS_INCOMING_BOUND        = 2,
    CS_STATUS_INCOMING_LISTENING    = 3,
    CS_STATUS_INCOMING_LOGIN        = 4,
    CS_STATUS_INCOMING_PASSWORD     = 5,
    CS_STATUS_INCOMING_ACTIVE       = 6,/* correctly logged in            */
    CS_STATUS_INCOMING_CONNECT_RETRY_TIMER      = 7,
    CS_STATUS_INCOMING_BIND_RETRY_TIMER         = 8,
    CS_STATUS_INCOMING_LOGIN_WAIT_TIMER         = 9,
    CS_STATUS_INCOMING_LISTEN_WAIT_TIMER        = 10,
    CS_STATUS_INCOMING_MAJOR_FAILURE            = 11,
    CS_STATUS_LISTENER_MAJOR_FAILURE_RESTART_TIMER    = 12,

} ConfigurationSocketIncomingStatus;

@interface SS7TelnetSocket : UMObject
{
    BOOL _endThisConnection;
    BOOL _endPermanently;
    BOOL _isListener;
    int  _localPort;
    int  _remotePort;
    UMHost *_localHost;
    UMHost *_remoteHost;
    UMSocket *_sock;
    ConfigurationSocketIncomingStatus   _incomingStatus;
    NSString *_advertizeName;

    int _receivePollTimeoutMs;
    id<SS7TelnetSocketHelperProtocol>  _delegate; /* will be asked for isAddressWhitelisted: */
    NSDate *_lastActivity;
    UMSleeper *_txSleeper;

    TelnetState _telnetState;

    BOOL _crReceived;
    BOOL _lfReceived;
    BOOL _nulReceived;
    BOOL _iacReceived;
    SS7ConfigurationSession *_config_session;
    NSMutableString *_incomingBuffer;
    NSMutableString *_processLine;
    BOOL _fullLineReceived;
    BOOL _doEcho;
    NSMutableData *_sb_buffer;
    int _failedLoginCount;
    BOOL _inEscape;
    char _escapes[12];
    int _escapeLen;
    NSMutableDictionary *_escapeDictionary;
    NSInteger _cursor;
}

@property(readwrite,assign,atomic)  BOOL endThisConnection;
@property(readwrite,assign,atomic)  BOOL endPermanently;
@property(readwrite,assign,atomic)  BOOL isListener;
@property(readwrite,assign,atomic)  int localPort;
@property(readwrite,assign,atomic)  int remotePort;
@property(readwrite,strong,atomic)  UMHost *localHost;
@property(readwrite,strong,atomic)  UMHost *remoteHost;
@property(readwrite,strong,atomic)  NSString *advertizeName;
@property(readwrite,strong,atomic)  id<SS7TelnetSocketHelperProtocol>  delegate;
@property(readwrite,strong,atomic)  UMSocket *sock;
@property(readwrite,assign,atomic)  ConfigurationSocketIncomingStatus incomingStatus;
@property(readwrite,strong,atomic)  NSDate *lastActivity;

- (void)startListener;


@end
