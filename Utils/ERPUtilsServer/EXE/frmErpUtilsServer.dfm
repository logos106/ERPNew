object fmErpUtilsServer: TfmErpUtilsServer
  Left = 200
  Top = 217
  Caption = 'ERP Utilities Server'
  ClientHeight = 357
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 537
    Height = 357
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object UpdateTimer: TTimer
    Enabled = False
    Left = 40
    Top = 32
  end
end
