inherited fmProductFormulaTypes: TfmProductFormulaTypes
  Left = 168
  Top = 193
  Caption = 'Formula Types'
  ClientHeight = 252
  ClientWidth = 603
  ExplicitLeft = 168
  ExplicitTop = 193
  ExplicitWidth = 619
  ExplicitHeight = 291
  DesignSize = (
    603
    252)
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1656002
  inherited lblSkingroupMsg: TLabel
    Top = 202
    Width = 603
    ExplicitTop = 223
    ExplicitWidth = 455
    HelpContext = 1656003
  end
  inherited shapehint: TShape
    Left = 70
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 155
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 603
    Height = 59
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      603
      59)
    HelpContext = 1656004
    object pnlTitle: TDNMPanel
      Left = 110
      Top = 9
      Width = 382
      Height = 39
      HelpContext = 1656005
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 380
        Height = 37
        HelpContext = 1656006
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
          Width = 380
          Height = 37
          HelpContext = 1656007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Formula Types'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 202
    Width = 603
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
      603
      50)
    HelpContext = 1656008
    object cmdClose: TDNMSpeedButton
      Left = 152
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 1656009
      Anchors = []
      Caption = '&Save'
      Default = True
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 358
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 1656010
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdCancelClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 255
      Top = 11
      Width = 93
      Height = 29
      Hint = '"Add A Class"'
      HelpContext = 1656011
      Anchors = []
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = cmdNewClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 59
    Width = 603
    Height = 143
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      603
      143)
    HelpContext = 1656012
    object lblProductPrintName: TLabel
      Left = 31
      Top = 27
      Width = 33
      Height = 15
      HelpContext = 1656013
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 31
      Top = 64
      Width = 139
      Height = 15
      HelpContext = 1656014
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Fields visible for the type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtProductPrintName: TwwDBEdit
      Left = 70
      Top = 23
      Width = 421
      Height = 23
      HelpContext = 1656015
      Anchors = [akTop]
      DataField = 'FormulaType'
      DataSource = dsformula
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkActive: TDBCheckBox
      Left = 507
      Top = 29
      Width = 71
      Height = 17
      HelpContext = 1656016
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akRight]
      Caption = 'Active ? '
      DataField = 'Active'
      DataSource = dsformula
      TabOrder = 1
      ValueChecked = 'T'
      ValueUnchecked = 'F'
    end
    object pnlFormulaTypeFlags: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 82
      Width = 595
      Height = 57
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      HelpContext = 1656017
      object pnlFe1: TDNMPanel
        Left = 0
        Top = 0
        Width = 127
        Height = 53
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 1656018
        object lblfe1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 121
          Height = 29
          HelpContext = 1656019
          Margins.Bottom = 1
          Align = alClient
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlBottom
          ExplicitWidth = 33
          ExplicitHeight = 15
        end
        object chkfe1: TDBCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 121
          Height = 14
          Align = alBottom
          DataField = 'Fe1visible'
          DataSource = dsformula
          TabOrder = 0
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          HelpContext = 1656020
        end
      end
      object pnlFe2: TDNMPanel
        Left = 127
        Top = 0
        Width = 116
        Height = 53
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        HelpContext = 1656021
        object lblfe2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 110
          Height = 29
          HelpContext = 1656022
          Margins.Bottom = 1
          Align = alClient
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlBottom
          ExplicitWidth = 33
          ExplicitHeight = 15
        end
        object chkfe2: TDBCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 110
          Height = 14
          Align = alBottom
          DataField = 'Fe2visible'
          DataSource = dsformula
          TabOrder = 0
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          HelpContext = 1656023
        end
      end
      object pnlFe3: TDNMPanel
        Left = 243
        Top = 0
        Width = 116
        Height = 53
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        HelpContext = 1656024
        object lblfe3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 110
          Height = 29
          HelpContext = 1656025
          Margins.Bottom = 1
          Align = alClient
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlBottom
          ExplicitWidth = 33
          ExplicitHeight = 15
        end
        object chkfe3: TDBCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 110
          Height = 14
          Align = alBottom
          DataField = 'Fe3visible'
          DataSource = dsformula
          TabOrder = 0
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          HelpContext = 1656026
        end
      end
      object pnlFe4: TDNMPanel
        Left = 359
        Top = 0
        Width = 116
        Height = 53
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        HelpContext = 1656027
        object lblfe4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 110
          Height = 29
          HelpContext = 1656028
          Margins.Bottom = 1
          Align = alClient
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlBottom
          ExplicitWidth = 33
          ExplicitHeight = 15
        end
        object chkfe4: TDBCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 110
          Height = 14
          Align = alBottom
          DataField = 'Fe4visible'
          DataSource = dsformula
          TabOrder = 0
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          HelpContext = 1656029
        end
      end
      object pnlFe5: TDNMPanel
        Left = 475
        Top = 0
        Width = 116
        Height = 53
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        HelpContext = 1656030
        object lblfe5: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 110
          Height = 29
          HelpContext = 1656031
          Margins.Bottom = 1
          Align = alClient
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlBottom
          ExplicitWidth = 33
          ExplicitHeight = 15
        end
        object chkfe5: TDBCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 110
          Height = 14
          Align = alBottom
          DataField = 'Fe5visible'
          DataSource = dsformula
          TabOrder = 0
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          HelpContext = 1656032
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 151
    Top = 13
  end
  inherited tmrdelay: TTimer
    Left = 316
    Top = 13
  end
  inherited popSpelling: TPopupMenu
    Left = 118
    Top = 13
  end
  inherited tmrdelayMsg: TTimer
    Left = 472
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 13
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 349
    Top = 13
  end
  inherited MyConnection: TERPConnection
    Left = 448
    Top = 15
  end
  inherited DataState: TDataState
    Left = 250
    Top = 13
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 382
    Top = 13
  end
  inherited imgsort: TImageList
    Left = 283
    Top = 13
    Bitmap = {
      494C010102009400E40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 85
    Top = 13
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 415
    Top = 13
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 217
    Top = 13
  end
  inherited qryMemTrans: TERPQuery
    Left = 52
    Top = 13
  end
  object dsformula: TDataSource
    DataSet = qryfeformulatypes
    Left = 115
    Top = 56
  end
  object qryfeformulatypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblfeformulatypes')
    Left = 115
    Top = 72
    object qryfeformulatypesFormulaTypeId: TIntegerField
      FieldName = 'FormulaTypeId'
    end
    object qryfeformulatypesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryfeformulatypesFormulaType: TWideStringField
      FieldName = 'FormulaType'
      Size = 255
    end
    object qryfeformulatypesFe1visible: TWideStringField
      FieldName = 'Fe1visible'
      FixedChar = True
      Size = 1
    end
    object qryfeformulatypesFe2visible: TWideStringField
      FieldName = 'Fe2visible'
      FixedChar = True
      Size = 1
    end
    object qryfeformulatypesFe3visible: TWideStringField
      FieldName = 'Fe3visible'
      FixedChar = True
      Size = 1
    end
    object qryfeformulatypesFe4visible: TWideStringField
      FieldName = 'Fe4visible'
      FixedChar = True
      Size = 1
    end
    object qryfeformulatypesFe5visible: TWideStringField
      FieldName = 'Fe5visible'
      FixedChar = True
      Size = 1
    end
    object qryfeformulatypesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryfeformulatypesmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
    end
    object qryfeformulatypesmsupdatesiteCode: TWideStringField
      FieldName = 'msupdatesiteCode'
      Size = 3
    end
  end
end
