inherited fmBarCodeManufacturingCustomise: TfmBarCodeManufacturingCustomise
  Left = 659
  Top = 272
  Caption = 'Customise'
  ClientHeight = 324
  ClientWidth = 426
  Position = poScreenCenter
  ExplicitLeft = 659
  ExplicitTop = 272
  ExplicitWidth = 434
  ExplicitHeight = 351
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1300002
  inherited lblSkingroupMsg: TLabel
    Top = 274
    Width = 426
    ExplicitTop = 274
    ExplicitWidth = 426
    HelpContext = 1300003
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 50
    Width = 426
    Height = 224
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    HelpContext = 1300004
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 418
      Height = 19
      Align = alTop
      Caption = 'Choose Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 124
      HelpContext = 1300005
    end
    object Scrollbox: TScrollBox
      AlignWithMargins = True
      Left = 4
      Top = 29
      Width = 418
      Height = 191
      HelpContext = 1300006
      HorzScrollBar.Visible = False
      Align = alClient
      TabOrder = 0
    end
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 426
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    HelpContext = 1300007
    object DNMPanel4: TDNMPanel
      AlignWithMargins = True
      Left = 110
      Top = 5
      Width = 205
      Height = 40
      HelpContext = 1300008
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Shader1: TShader
        Left = 2
        Top = 2
        Width = 201
        Height = 36
        HelpContext = 1300009
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object titleLabel: TLabel
          Left = 0
          Top = 0
          Width = 201
          Height = 36
          HelpContext = 1300010
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Customise'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = -5
          ExplicitWidth = 185
          ExplicitHeight = 43
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 274
    Width = 426
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      426
      50)
    HelpContext = 1300011
    object btnCancel: TDNMSpeedButton
      Left = 264
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1300012
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnSave: TDNMSpeedButton
      Left = 74
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1300013
      Anchors = []
      Caption = 'Ok'
      Default = True
      DisableTransparent = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 169
      Top = 11
      Width = 87
      Height = 27
      Anchors = []
      Caption = 'Select All'
      Default = True
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      OnClick = btnSelectAllClick
      HelpContext = 1300014
    end
  end
end
