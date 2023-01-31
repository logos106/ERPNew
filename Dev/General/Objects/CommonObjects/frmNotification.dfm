object fmNotification: TfmNotification
  Left = 0
  Top = 0
  Caption = 'fmNotification'
  ClientHeight = 86
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1020002
  object tmrFade: TTimer
    Enabled = False
    Interval = 1
    Left = 32
    Top = 16
  end
end
