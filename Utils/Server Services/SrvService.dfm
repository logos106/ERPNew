object SrvServices: TSrvServices
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  AllowPause = False
  DisplayName = 'Server Services'
  ErrorSeverity = esIgnore
  Interactive = True
  WaitHint = 10000
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  AfterUninstall = ServiceAfterUninstall
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 505
  Top = 274
  Height = 138
  Width = 153
  object TCPServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    CommandHandlersEnabled = False
    DefaultPort = 0
    Greeting.NumericCode = 0
    ListenQueue = 1
    MaxConnectionReply.NumericCode = 0
    OnExecute = TCPServerExecute
    OnDisconnect = TCPServerDisconnect
    OnException = TCPServerException
    OnListenException = TCPServerListenException
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    ReuseSocket = rsTrue
    TerminateWaitTime = 500
    ThreadMgr = ThreadMgr
    Left = 18
    Top = 2
  end
  object ThreadMgr: TIdThreadMgrPool
    Left = 91
    Top = 2
  end
  object AntiFreeze: TIdAntiFreeze
    Left = 14
    Top = 54
  end
end
