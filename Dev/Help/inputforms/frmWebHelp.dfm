inherited fmWebHelp: TfmWebHelp
  Left = 183
  Top = 196
  Caption = 'ERP Help'
  KeyPreview = True
  ExplicitLeft = 183
  ExplicitTop = 196
  PixelsPerInch = 96
  TextHeight = 13
  object lblurl: TLabel [2]
    Left = 0
    Top = 0
    Width = 950
    Height = 20
    Align = alTop
    Alignment = taCenter
    Caption = 'lblurl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Visible = False
    ExplicitWidth = 32
  end
  inherited WebBrowser: TWebBrowser
    Top = 20
    Height = 460
    ExplicitTop = 8
    ExplicitHeight = 514
    ControlData = {
      4C0000002F620000C73600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 480
    Width = 950
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      950
      50)
    object lblMsg: TLabel
      Left = 115
      Top = 19
      Width = 712
      Height = 16
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Help Context not Found'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object btnEdit: TDNMSpeedButton
      Left = 848
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 372069
      Anchors = [akTop, akRight]
      Caption = 'Edit'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btnEditClick
    end
    object btnBack: TDNMSpeedButton
      Left = 10
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 372068
      Anchors = [akTop, akRight]
      Caption = 'Back'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
      Visible = False
      OnClick = btnBackClick
    end
  end
end
