inherited FmInputText: TFmInputText
  Caption = 'FmInputText'
  ClientHeight = 236
  Position = poScreenCenter
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    ExplicitTop = 186
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 299
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object pnlTitle: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 291
      Height = 42
      HelpContext = 796020
      Align = alClient
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 287
        Height = 38
        HelpContext = 796021
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
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 287
          Height = 38
          HelpContext = 796022
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Language Translation'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 285
          ExplicitHeight = 41
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 186
    Width = 299
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object btnOk: TDNMSpeedButton
      Left = 40
      Top = 10
      Width = 106
      Height = 30
      HelpContext = 639003
      Caption = 'OK'
      Color = clWhite
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 0
      AutoDisableParentOnclick = True
    end
    object btnCancel: TDNMSpeedButton
      Left = 152
      Top = 10
      Width = 106
      Height = 30
      HelpContext = 639004
      Cancel = True
      Caption = 'Cancel'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 1
      AutoDisableParentOnclick = True
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 50
    Width = 299
    Height = 105
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      299
      105)
    object lblPrompt: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 291
      Height = 15
      HelpContext = 639001
      Align = alTop
      Caption = 'lblPrompt'
      Transparent = True
      WordWrap = True
      ExplicitWidth = 55
    end
    object lblFooter: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 86
      Width = 291
      Height = 15
      HelpContext = 639001
      Align = alBottom
      Caption = 'lblPrompt'
      Transparent = True
      WordWrap = True
      ExplicitWidth = 55
    end
    object lblFilter: TLabel
      Left = 2
      Top = 82
      Width = 65
      Height = 15
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'New Value :'
      Color = 13487565
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitTop = 113
    end
    object memInput: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 25
      Width = 291
      Height = 55
      Align = alClient
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      ParentColor = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object lstInput: TListBox
      Left = 1
      Top = 22
      Width = 297
      Height = 61
      Align = alClient
      ItemHeight = 15
      TabOrder = 1
      OnClick = lstInputClick
      OnDblClick = lstInputDblClick
    end
    object edtValue: TEdit
      AlignWithMargins = True
      Left = 67
      Top = 78
      Width = 228
      Height = 23
      Margins.Left = 66
      Anchors = [akLeft, akBottom]
      TabOrder = 2
      Text = 'edtValue'
      OnDblClick = edtValueDblClick
    end
  end
  object dtPanel: TDNMPanel [7]
    Left = 0
    Top = 155
    Width = 299
    Height = 31
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnDblClick = dtPanelDblClick
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 65
      Height = 23
      Align = alLeft
      Caption = 'New Value :'
      Color = 13487565
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitHeight = 15
    end
    object dtInput: TDateTimePicker
      AlignWithMargins = True
      Left = 75
      Top = 4
      Width = 186
      Height = 23
      Align = alLeft
      Date = 44111.519410173610000000
      Time = 44111.519410173610000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 88
      ExplicitTop = 8
    end
  end
end
