object SvcControlClient: TSvcControlClient
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 276
  Top = 501
  Height = 150
  Width = 215
  object TCPClient: TIdTCPClient
    MaxLineAction = maException
    OnDisconnected = TCPClientDisconnected
    OnConnected = TCPClientConnected
    Port = 0
    Left = 24
    Top = 16
  end
  object Timer: TTimer
    Enabled = False
    Interval = 20
    OnTimer = TimerTimer
    Left = 144
    Top = 16
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 96
    Top = 16
  end
end
