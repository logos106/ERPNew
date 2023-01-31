inherited fmBaseListDateSelectionOptions: TfmBaseListDateSelectionOptions
  Caption = 'fmBaseListDateSelectionOptions'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1626002
  object pnlMain: TDNMPanel [4]
    Left = 0
    Top = 14
    Width = 280
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      280
      27)
    HelpContext = 1626003
    object DNMSpeedButton1: TDNMSpeedButton
      AlignWithMargins = True
      Left = 5
      Top = 1
      Width = 47
      Height = 25
      Anchors = [akLeft]
      Caption = '< <'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 0
      OnClick = DNMSpeedButton1Click
      HelpContext = 1626004
    end
    object DNMSpeedButton2: TDNMSpeedButton
      AlignWithMargins = True
      Left = 229
      Top = 0
      Width = 47
      Height = 25
      Anchors = [akRight]
      Caption = '> >'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 1
      OnClick = DNMSpeedButton2Click
      HelpContext = 1626005
    end
    object edt: TSpinEdit
      Left = 53
      Top = 1
      Width = 64
      Height = 24
      Anchors = [akLeft]
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      HelpContext = 1626006
    end
    object cbo: TComboBox
      AlignWithMargins = True
      Left = 119
      Top = 0
      Width = 107
      Height = 23
      Margins.Top = 0
      Margins.Bottom = 0
      Anchors = [akRight]
      TabOrder = 3
      Text = 'Days'
      Items.Strings = (
        'Days'
        'Weeks'
        'Month'
        'Year')
      HelpContext = 1626007
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 89
    Top = 128
  end
  inherited tmrdelay: TTimer
    Left = 156
    Top = 128
  end
  inherited popSpelling: TPopupMenu
    Left = 224
    Top = 128
  end
  inherited tmrdelayMsg: TTimer
    Left = 190
    Top = 128
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 122
    Top = 128
  end
end
