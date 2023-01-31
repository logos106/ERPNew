inherited fmComboInput: TfmComboInput
  HelpContext = 922001
  Caption = 'fmComboInput'
  ClientHeight = 94
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poMainFormCenter
  ExplicitHeight = 121
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 94
  end
  object lblMsg: TLabel [3]
    Left = 8
    Top = 8
    Width = 37
    Height = 15
    HelpContext = 922002
    Caption = 'lblMsg'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cboInput: TComboBox [4]
    Left = 8
    Top = 29
    Width = 283
    Height = 23
    HelpContext = 922003
    TabOrder = 0
    Text = 'cboInput'
  end
  object cmdPrint: TDNMSpeedButton [5]
    Left = 36
    Top = 59
    Width = 87
    Height = 27
    Hint = '"Print The List"'
    HelpContext = 922004
    Anchors = [akBottom]
    Caption = 'Ok'
    Default = True
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
    ModalResult = 1
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TabStop = False
  end
  object cmdClose: TDNMSpeedButton [6]
    Left = 145
    Top = 59
    Width = 87
    Height = 27
    Hint = '"Close The List"'
    HelpContext = 922005
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
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
    ModalResult = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TabStop = False
  end
end
