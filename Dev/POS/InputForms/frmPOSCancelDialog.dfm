object frmPOSDialog: TfrmPOSDialog
  Left = 524
  Top = 391
  HelpContext = 662000
  BorderIcons = []
  Caption = 'Cancel'
  ClientHeight = 93
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 93
    HelpContext = 662001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 368
    object lblmsg: TLabel
      Left = 0
      Top = 0
      Width = 429
      Height = 38
      HelpContext = 662002
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Do you wish to Cancel?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 368
    end
    object btnYes: TDNMSpeedButton
      Left = 92
      Top = 45
      Width = 100
      Height = 41
      HelpContext = 662003
      Caption = '&Yes'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 6
      ParentFont = False
      TabOrder = 0
    end
    object btnNo: TDNMSpeedButton
      Left = 236
      Top = 45
      Width = 100
      Height = 41
      HelpContext = 662004
      Caption = '&No'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 7
      ParentFont = False
      TabOrder = 1
    end
    object btnOk: TDNMSpeedButton
      Left = 164
      Top = 45
      Width = 100
      Height = 41
      HelpContext = 662005
      Caption = 'OK'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
end
