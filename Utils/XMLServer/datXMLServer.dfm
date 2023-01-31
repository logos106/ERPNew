object dmXMLServer: TdmXMLServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 421
  Top = 457
  Height = 229
  Width = 192
  object TCPServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = TCPServerConnect
    OnExecute = TCPServerExecute
    OnDisconnect = TCPServerDisconnect
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 40
    Top = 24
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 104
    Top = 16
  end
  object IoHandlerSSL: TIdServerIOHandlerSSL
    SSLOptions.Method = sslvTLSv1
    SSLOptions.Mode = sslmServer
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 39
    Top = 95
  end
end
