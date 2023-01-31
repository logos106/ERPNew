object SvcControlServer: TSvcControlServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 275
  Top = 346
  Height = 150
  Width = 215
  object TCPServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = TCPServerExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 32
    Top = 32
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 112
    Top = 40
  end
end
