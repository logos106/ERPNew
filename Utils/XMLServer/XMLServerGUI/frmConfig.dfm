inherited fmConfig: TfmConfig
  Left = 244
  Top = 199
  BorderStyle = bsDialog
  Caption = 'Config'
  ClientHeight = 377
  ClientWidth = 447
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 16
    Top = 8
    Width = 417
    Height = 313
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      417
      313)
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 38
      Height = 13
      Caption = 'Server'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 24
      Top = 44
      Width = 86
      Height = 15
      Caption = 'XML Server Port'
      Transparent = True
    end
    object Label7: TLabel
      Left = 24
      Top = 67
      Width = 115
      Height = 15
      Caption = 'Server Max Sessions'
      Transparent = True
    end
    object Label9: TLabel
      Left = 248
      Top = 67
      Width = 109
      Height = 15
      Caption = '(Set to 0 for no limit)'
      Transparent = True
    end
    object Label5: TLabel
      Left = 24
      Top = 92
      Width = 134
      Height = 15
      Caption = 'Idle Connection Timeout'
      Transparent = True
    end
    object Label6: TLabel
      Left = 248
      Top = 91
      Width = 148
      Height = 15
      Caption = 'Seconds  (0 for no timeout)'
      Transparent = True
    end
    object Label1: TLabel
      Left = 8
      Top = 128
      Width = 87
      Height = 13
      Caption = 'Server Logging'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 24
      Top = 184
      Width = 90
      Height = 15
      Caption = 'Message Types '
      Transparent = True
    end
    object Label4: TLabel
      Left = 192
      Top = 184
      Width = 124
      Height = 15
      Caption = 'Message Types to Log'
      Transparent = True
    end
    object chkUseSSL: TwwCheckBox
      Left = 168
      Top = 16
      Width = 89
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.NonFocusBorders = []
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Use SSL'
      TabOrder = 0
    end
    object edtXMLServerPort: TAdvEdit
      Left = 168
      Top = 40
      Width = 73
      Height = 23
      EditType = etNumeric
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      TabOrder = 1
      Text = '0'
      Visible = True
      Version = '2.7.5.0'
    end
    object edtMaxSessionCount: TAdvEdit
      Left = 168
      Top = 64
      Width = 73
      Height = 23
      EditType = etNumeric
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      TabOrder = 2
      Text = '0'
      Visible = True
      Version = '2.7.5.0'
    end
    object edtSessionTimeoutSecondes: TAdvEdit
      Left = 168
      Top = 88
      Width = 73
      Height = 23
      EditType = etNumeric
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      TabOrder = 3
      Text = '0'
      Visible = True
      Version = '2.7.5.0'
    end
    object chkLogToFile: TwwCheckBox
      Left = 24
      Top = 152
      Width = 89
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.NonFocusBorders = []
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Log To File'
      TabOrder = 4
    end
    object chkLogToEvent: TwwCheckBox
      Left = 120
      Top = 152
      Width = 145
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.NonFocusBorders = []
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Remote Logging'
      TabOrder = 5
    end
    object lstMessageTypes: TListBox
      Left = 24
      Top = 200
      Width = 121
      Height = 97
      ItemHeight = 15
      TabOrder = 6
    end
    object lstMessageTypesToLog: TListBox
      Left = 192
      Top = 200
      Width = 121
      Height = 97
      ItemHeight = 15
      TabOrder = 9
    end
    object btnAdd: TDNMSpeedButton
      Left = 155
      Top = 218
      Width = 27
      Height = 27
      HelpContext = 174037
      Anchors = [akBottom]
      Caption = '>'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 7
      OnClick = btnAddClick
    end
    object btnRemove: TDNMSpeedButton
      Left = 155
      Top = 250
      Width = 27
      Height = 27
      HelpContext = 174037
      Anchors = [akBottom]
      Caption = '<'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 8
      OnClick = btnRemoveClick
    end
  end
  object pnlBottom: TDNMPanel
    Left = 0
    Top = 336
    Width = 447
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      447
      41)
    object btnOk: TDNMSpeedButton
      Left = 107
      Top = 2
      Width = 100
      Height = 27
      HelpContext = 174037
      Anchors = [akBottom]
      Caption = '&Save'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
    end
    object cmdClose: TDNMSpeedButton
      Left = 239
      Top = 2
      Width = 100
      Height = 27
      HelpContext = 174038
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
    end
  end
end
