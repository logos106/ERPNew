inherited fmSvcGuiConfig: TfmSvcGuiConfig
  Left = 483
  Top = 222
  BorderStyle = bsDialog
  Caption = 'Client Config'
  ClientHeight = 148
  ClientWidth = 414
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TDNMPanel
    Left = 0
    Top = 107
    Width = 414
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      414
      41)
    object btnOk: TDNMSpeedButton
      Left = 95
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
      Left = 218
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
  object DNMPanel1: TDNMPanel
    Left = 8
    Top = 16
    Width = 393
    Height = 73
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 77
      Height = 13
      Caption = 'Control Client'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 160
      Top = 13
      Width = 35
      Height = 15
      Caption = 'Server'
      Transparent = True
    end
    object Label6: TLabel
      Left = 160
      Top = 42
      Width = 22
      Height = 15
      Caption = 'Port'
      Transparent = True
    end
    object chkMinimizeOnClose: TwwCheckBox
      Left = 16
      Top = 40
      Width = 129
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
      Caption = 'Minimize On Close'
      TabOrder = 0
    end
    object edtControlPort: TAdvEdit
      Left = 204
      Top = 38
      Width = 73
      Height = 21
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
    object edtControlServer: TEdit
      Left = 204
      Top = 8
      Width = 177
      Height = 23
      TabOrder = 2
    end
  end
end
