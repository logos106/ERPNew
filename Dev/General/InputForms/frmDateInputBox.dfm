object fmDateInputBox: TfmDateInputBox
  Left = 416
  Top = 207
  HelpContext = 1194002
  BorderStyle = bsDialog
  Caption = 'fmDateInputBox'
  ClientHeight = 146
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object lblPrompt: TLabel
    Left = 14
    Top = 24
    Width = 321
    Height = 15
    HelpContext = 1194003
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblPrompt'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtDate: TDateTimePicker
    Left = 94
    Top = 56
    Width = 161
    Height = 23
    HelpContext = 1194006
    Date = 41793.415997858800000000
    Time = 41793.415997858800000000
    TabOrder = 0
  end
  object DNMPanel1: TDNMPanel
    Left = 20
    Top = 88
    Width = 321
    Height = 50
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      321
      50)
    HelpContext = 1194007
    object btnOk: TDNMSpeedButton
      Left = 57
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 1194004
      Anchors = [akTop, akRight]
      Caption = 'OK'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      Style = bsModern
      TabOrder = 0
    end
    object btnCancel: TDNMSpeedButton
      Left = 177
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 1194005
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      Style = bsModern
      TabOrder = 1
    end
  end
end
