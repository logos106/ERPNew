inherited fmCrossStockCompanies: TfmCrossStockCompanies
  HelpContext = 1444002
  Caption = 'Cross Stock Companies'
  ClientWidth = 777
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 783
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 482
    Width = 777
    HelpContext = 1444003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 76
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
    Left = 165
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 777
    Height = 59
    HelpContext = 1444004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      777
      59)
    object pnlTitle: TDNMPanel
      Left = 202
      Top = 10
      Width = 373
      Height = 39
      HelpContext = 1444005
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
        Width = 371
        Height = 37
        HelpContext = 1444006
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
          Width = 371
          Height = 37
          HelpContext = 1444007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Cross Stock Companies'
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
    Top = 482
    Width = 777
    Height = 50
    HelpContext = 1444008
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      777
      50)
    object cmdClose: TDNMSpeedButton
      Left = 232
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1444009
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 451
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1444010
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdCancelClick
    end
  end
  object pnlDatabases: TDNMPanel [7]
    Left = 0
    Top = 59
    Width = 284
    Height = 423
    HelpContext = 1444011
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 282
      Height = 19
      HelpContext = 1444012
      Align = alTop
      Alignment = taCenter
      Caption = 'Choose Companies'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 151
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 23
      Width = 276
      Height = 15
      HelpContext = 1444013
      Align = alTop
      Alignment = taCenter
      Caption = 'Double click to Choose and add Company'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 233
    end
    object grdDbs: TwwDBGrid
      AlignWithMargins = True
      Left = 46
      Top = 44
      Width = 234
      Height = 375
      HelpContext = 1444014
      Margins.Left = 45
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'DBName'#9'28'#9'Company'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsERPDatabases
      KeyOptions = []
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdDbsDblClick
      FooterColor = clWhite
    end
  end
  object pnlOptions: TDNMPanel [8]
    Left = 284
    Top = 59
    Width = 45
    Height = 423
    HelpContext = 1444015
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object btnemoveAll: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 255
      Width = 37
      Height = 23
      HelpContext = 1444016
      Margins.Bottom = 144
      Align = alBottom
      Caption = '<<'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
      OnClick = btnemoveAllClick
    end
    object btnRemove: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 226
      Width = 37
      Height = 23
      HelpContext = 1444017
      Align = alBottom
      Caption = '<'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      OnClick = btnRemoveClick
    end
    object btnChooseAll: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 174
      Width = 37
      Height = 23
      HelpContext = 1444018
      Align = alTop
      Caption = '>>'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      OnClick = btnChooseAllClick
    end
    object btnChoose: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 145
      Width = 37
      Height = 23
      HelpContext = 1444019
      Margins.Top = 144
      Align = alTop
      Caption = '>'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      OnClick = btnChooseClick
    end
  end
  object DNMPanel4: TDNMPanel [9]
    Left = 732
    Top = 59
    Width = 45
    Height = 423
    HelpContext = 1444020
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object btnMoveItemUp: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 145
      Width = 37
      Height = 41
      HelpContext = 1444021
      Margins.Top = 144
      Align = alTop
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        333333777777777F33333330B00000003333337F7777777F3333333000000000
        333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
        333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
        03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
        03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
        3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
        333333333377F7F33333333333330F03333333333337F7F33333333333330B03
        3333333333373733333333333333303333333333333373333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnMoveItemUpClick
    end
    object btnMoveItemDown: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 237
      Width = 37
      Height = 41
      HelpContext = 1444022
      Margins.Bottom = 144
      Align = alBottom
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        33333333373F33333333333330B03333333333337F7F33333333333330F03333
        333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
        333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
        333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
        3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
        33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
        33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
        03333337777777F7F33333330000000003333337777777773333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnMoveItemDownClick
    end
  end
  object DNMPanel1: TDNMPanel [10]
    Left = 329
    Top = 59
    Width = 403
    Height = 423
    HelpContext = 1444023
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 401
      Height = 19
      HelpContext = 1444024
      Align = alTop
      Alignment = taCenter
      Caption = 'Selected Companies'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 157
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 23
      Width = 395
      Height = 15
      HelpContext = 1444025
      Align = alTop
      Alignment = taCenter
      Caption = 'Stock to be taken in this Order'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 172
    end
    object grdCrossStockCompanies: TwwDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 44
      Width = 395
      Height = 375
      HelpContext = 1444026
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'Logon_Name;CustomEdit;cboLogon_Name;F')
      Selected.Strings = (
        'DBName'#9'28'#9'Company'#9'F'
        'Logon_Name'#9'15'#9'User'
        'Active'#9'6'#9'Active ?')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsCrossStockCompanies
      KeyOptions = []
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdCrossStockCompaniesDblClick
      OnEnter = grdCrossStockCompaniesEnter
      FooterColor = clWhite
    end
    object cboLogon_Name: TwwDBLookupCombo
      Left = 232
      Top = 128
      Width = 121
      Height = 23
      HelpContext = 1444027
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Logon_Name'#9'25'#9'User'#9'F')
      DataField = 'Logon_Name'
      DataSource = dsCrossStockCompanies
      LookupTable = qryUsernames
      LookupField = 'Logon_Name'
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 124
    Top = 117
  end
  inherited tmrdelay: TTimer
    Left = 157
    Top = 117
  end
  inherited popSpelling: TPopupMenu
    Left = 92
    Top = 117
  end
  inherited tmrdelayMsg: TTimer
    Left = 189
    Top = 117
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 221
    Top = 117
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 350
    Top = 117
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Left = 24
    Top = 79
  end
  inherited DataState: TDataState
    Left = 286
    Top = 117
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 382
    Top = 117
  end
  inherited imgsort: TImageList
    Left = 318
    Top = 117
    Bitmap = {
      494C010102009400EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 60
    Top = 117
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 415
    Top = 117
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 253
    Top = 117
  end
  inherited qryMemTrans: TERPQuery
    Left = 28
    Top = 117
  end
  object QryCrossStockCompanies: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblCrossStockCompanies')
    Left = 32
    Top = 155
    object QryCrossStockCompaniesDBName: TWideStringField
      DisplayLabel = 'Company'
      DisplayWidth = 28
      FieldName = 'DBName'
      Origin = 'tblcrossstockcompanies.DBName'
      Size = 255
    end
    object QryCrossStockCompaniesLogon_Name: TWideStringField
      DisplayLabel = 'User'
      DisplayWidth = 15
      FieldName = 'Logon_Name'
      Origin = 'tblcrossstockcompanies.Logon_Name'
      Size = 25
    end
    object QryCrossStockCompaniesActive: TWideStringField
      DisplayLabel = 'Active ?'
      DisplayWidth = 6
      FieldName = 'Active'
      Origin = 'tblcrossstockcompanies.Active'
      FixedChar = True
      Size = 1
    end
    object QryCrossStockCompaniesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblcrossstockcompanies.ID'
      Visible = False
    end
    object QryCrossStockCompaniesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcrossstockcompanies.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryCrossStockCompaniesCheckOrder: TIntegerField
      FieldName = 'CheckOrder'
      Origin = 'tblcrossstockcompanies.CheckOrder'
      Visible = False
    end
    object QryCrossStockCompaniesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblcrossstockcompanies.msTimeStamp'
      Visible = False
    end
    object QryCrossStockCompaniesmsupdateSitecode: TWideStringField
      FieldName = 'msupdateSitecode'
      Origin = 'tblcrossstockcompanies.msupdateSitecode'
      Visible = False
      Size = 3
    end
  end
  object QryERPDatabases: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select * from (Select "" as DBName ) as DBs where DBName not in ' +
        '(Select DBName from tblCrossStockCompanies)'
      'Order by DBName')
    Left = 64
    Top = 155
    object QryERPDatabasesDBName: TWideStringField
      DisplayLabel = 'Company'
      DisplayWidth = 28
      FieldName = 'DBName'
      Origin = 'DBs.DBName'
      FixedChar = True
      Size = 65530
    end
  end
  object dsCrossStockCompanies: TDataSource
    DataSet = QryCrossStockCompanies
    Left = 32
    Top = 187
  end
  object dsERPDatabases: TDataSource
    DataSet = QryERPDatabases
    Left = 64
    Top = 187
  end
  object qryUsernames: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select database() dbname, Logon_Name from tblpassword where ifnu' +
        'll(EmployeeId ,0)<> 0 order by Logon_Name')
    Left = 96
    Top = 155
    object qryUsernamesLogon_Name: TWideStringField
      DisplayLabel = 'User'
      DisplayWidth = 25
      FieldName = 'Logon_Name'
      Origin = 'tblpassword.Logon_Name'
      Size = 25
    end
    object qryUsernamesdbname: TWideStringField
      FieldName = 'dbname'
      Origin = 'dbname'
      Visible = False
      Size = 34
    end
  end
end
