inherited fmVs1Client: TfmVs1Client
  Left = 160
  Top = 133
  Caption = 'VS1 Client'
  ClientHeight = 609
  ClientWidth = 732
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 738
  ExplicitHeight = 638
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 559
    Width = 732
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 89
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
    Left = 192
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 732
    Height = 59
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = -1
    ExplicitTop = -5
    DesignSize = (
      732
      59)
    object pnlTitle: TDNMPanel
      Left = 213
      Top = 9
      Width = 307
      Height = 39
      HelpContext = 372080
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
        Width = 305
        Height = 37
        HelpContext = 372081
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
          Width = 305
          Height = 37
          HelpContext = 372082
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'VS1 Client'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 6
          ExplicitWidth = 684
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 559
    Width = 732
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
      732
      50)
    object cmdClose: TDNMSpeedButton
      Left = 192
      Top = 6
      Width = 93
      Height = 29
      HelpContext = 251008
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
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 444
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 251005
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
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 59
    Width = 732
    Height = 500
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlclient: TDNMPanel
      Left = 1
      Top = 1
      Width = 730
      Height = 152
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnEnter = pnlclientEnter
      object lblClientPrintNameHeading: TLabel
        AlignWithMargins = True
        Left = 71
        Top = 16
        Width = 33
        Height = 15
        HelpContext = 254556
        Alignment = taRightJustify
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
        AlignWithMargins = True
        Left = 6
        Top = 53
        Width = 98
        Height = 15
        HelpContext = 254556
        Alignment = taRightJustify
        Caption = 'Registration Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 397
        Top = 53
        Width = 39
        Height = 15
        HelpContext = 254556
        Alignment = taRightJustify
        Caption = 'Region'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        AlignWithMargins = True
        Left = 383
        Top = 16
        Width = 54
        Height = 15
        HelpContext = 254556
        Alignment = taRightJustify
        Caption = 'Database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 54
        Top = 98
        Width = 45
        Height = 15
        HelpContext = 254556
        Alignment = taRightJustify
        Caption = 'License'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtClientName: TDBEdit
        Left = 112
        Top = 14
        Width = 245
        Height = 23
        HelpContext = 254558
        DataField = 'ClientName'
        DataSource = dsvs1_clients
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtRegistrationDate: TwwDBDateTimePicker
        Left = 112
        Top = 49
        Width = 121
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'RegistrationDate'
        DataSource = dsvs1_clients
        Date = 44076.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowButton = True
        TabOrder = 1
      end
      object edtRegionName: TDBEdit
        Left = 445
        Top = 49
        Width = 245
        Height = 23
        HelpContext = 254558
        DataField = 'RegionName'
        DataSource = dsvs1_clients
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object edtDatabasename: TDBEdit
        Left = 445
        Top = 14
        Width = 245
        Height = 23
        HelpContext = 254558
        DataField = 'Databasename'
        DataSource = dsvs1_clients
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object grdclientLicense: TwwDBGrid
        Left = 112
        Top = 78
        Width = 578
        Height = 50
        Selected.Strings = (
          'RegionName'#9'255'#9'RegionName'#9#9
          'Databasename'#9'255'#9'Databasename'#9#9
          'ClientName'#9'255'#9'ClientName'#9#9
          'LicenseLevel'#9'10'#9'LicenseLevel'#9#9
          'ServerName'#9'255'#9'ServerName'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = False
        ShowVertScrollBar = False
        DataSource = dsvs1_clients
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        ParentFont = False
        TabOrder = 4
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grdvs1_clientmodulesCalcCellColors
        OnDblClick = grdvs1_clientmodulesDblClick
        FooterColor = clWhite
        object grdclientLicenseIButton: TwwIButton
          Left = 0
          Top = 0
          Width = 0
          Height = 22
          AllowAllUp = True
        end
      end
      object cboLicenseLevel: TwwDBLookupCombo
        Left = 579
        Top = 112
        Width = 121
        Height = 23
        DropDownAlignment = taLeftJustify
        DataSource = dsvs1_clients
        LookupTable = qryvs1_LicenseLevels
        TabOrder = 5
        Visible = False
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboLicenseLevelCloseUp
      end
    end
    object pnlclientModules: TDNMPanel
      Left = 1
      Top = 153
      Width = 730
      Height = 346
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object FilterLabel: TLabel
        Left = 1
        Top = 330
        Width = 728
        Height = 15
        Align = alBottom
        Alignment = taCenter
        Caption = 'Double Click on the Module to Renew'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitWidth = 208
      end
      object grdvs1_clientmodules: TwwDBGrid
        Left = 1
        Top = 128
        Width = 728
        Height = 202
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        Selected.Strings = (
          'LicenseLevel'#9'20'#9'LicenseLevel'#9'F'
          'ModuleName'#9'20'#9'ModuleName'#9'F'
          'Active'#9'1'#9'Active'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alBottom
        DataSource = dsvs1_clientmodules
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grdvs1_clientmodulesCalcCellColors
        OnDblClick = grdvs1_clientmodulesDblClick
        FooterColor = clWhite
      end
      object grdDatabases: TwwDBGrid
        Left = 1
        Top = -74
        Width = 728
        Height = 179
        ControlType.Strings = (
          'Active;CheckBox;T;F'
          'IsHttps;CheckBox;T;F')
        Selected.Strings = (
          'DatabaseName'#9'50'#9'DatabaseName'#9'F'
          'ServerName'#9'30'#9'ServerName'#9'F'
          'APIPort'#9'10'#9'APIPort'#9'F'
          'IsHttps'#9'5'#9'IsHttps'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alCustom
        DataSource = dsDAtabases
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grdvs1_clientmodulesCalcCellColors
        OnDblClick = grdvs1_clientmodulesDblClick
        FooterColor = clWhite
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 64
    Top = 301
  end
  inherited tmrdelay: TTimer
    Left = 97
    Top = 301
  end
  inherited popSpelling: TPopupMenu
    Left = 162
    Top = 301
  end
  inherited tmrdelayMsg: TTimer
    Left = 32
    Top = 301
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 188
    Top = 341
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 437
    Top = 293
  end
  inherited MyConnection: TERPConnection
    Database = 'vs1_sandbox_license'
    Server = 'localhost'
    Connected = True
    Left = 32
    Top = 335
  end
  inherited DataState: TDataState
    Left = 614
    Top = 341
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 227
    Top = 301
  end
  inherited imgsort: TImageList
    Left = 581
    Top = 293
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
    Left = 77
    Top = 413
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 423
    Top = 301
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 194
    Top = 301
  end
  inherited qryMemTrans: TERPQuery
    Left = 548
    Top = 317
  end
  inherited tmrOnshow: TTimer
    Left = 129
    Top = 301
  end
  object Actionlist: TActionList
    Left = 148
    Top = 285
  end
  object qryvs1_clients: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'tblVS1_clients')
    Options.LongStrings = False
    Left = 349
    Top = 445
    object qryvs1_clientsRegionName: TWideStringField
      FieldName = 'RegionName'
      Origin = 'tblvs1_clients.RegionName'
      Size = 255
    end
    object qryvs1_clientsDatabasename: TWideStringField
      FieldName = 'Databasename'
      Origin = 'tblvs1_clients.Databasename'
      Size = 255
    end
    object qryvs1_clientsClientName: TWideStringField
      FieldName = 'ClientName'
      Origin = 'tblvs1_clients.ClientName'
      Size = 255
    end
    object qryvs1_clientsLicenseLevel: TIntegerField
      FieldName = 'LicenseLevel'
      Origin = 'tblvs1_clients.LicenseLevel'
    end
    object qryvs1_clientsServerName: TWideStringField
      FieldName = 'ServerName'
      Origin = 'tblvs1_clients.ServerName'
      Size = 255
    end
    object qryvs1_clientsLicenseRenewDurationType: TWideStringField
      FieldName = 'LicenseRenewDurationType'
      Origin = 'tblvs1_clients.LicenseRenewDurationType'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientsLicenseRenewDuration: TIntegerField
      FieldName = 'LicenseRenewDuration'
      Origin = 'tblvs1_clients.LicenseRenewDuration'
    end
    object qryvs1_clientsRegistrationDate: TDateField
      FieldName = 'RegistrationDate'
      Origin = 'tblvs1_clients.RegistrationDate'
    end
    object qryvs1_clientsid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'tblvs1_clients.id'
    end
  end
  object qryvs1_modules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'L.ID AS LicenseLevelID,'
      'L.LicenseOrder, '
      'L.Description,'
      'M.Id AS ModuleId, '
      'M.*'
      'FROM'
      
        'tblVS1_modules M LEFT JOIN tblVS1_licenselevels L ON M.LicenseLe' +
        'vel = L.ID'
      'WHERE m.active ="T" AND L.active ="T"'
      'Order by L.LicenseOrder, M.ModuleName')
    Options.LongStrings = False
    Active = True
    Left = 229
    Top = 405
    object qryvs1_modulesDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'L.Description'
      Size = 255
    end
    object qryvs1_modulesModuleName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ModuleName'
      Origin = 'M.ModuleName'
      Size = 255
    end
    object qryvs1_modulesLicenseLevelID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LicenseLevelID'
      Origin = 'L.ID'
      Visible = False
    end
    object qryvs1_modulesLicenseOrder: TIntegerField
      DisplayWidth = 10
      FieldName = 'LicenseOrder'
      Origin = 'L.LicenseOrder'
      Visible = False
    end
    object qryvs1_modulesModuleId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ModuleId'
      Origin = 'M.ID'
      Visible = False
    end
    object qryvs1_modulesLicenseLevel: TIntegerField
      DisplayWidth = 10
      FieldName = 'LicenseLevel'
      Origin = 'M.LicenseLevel'
      Visible = False
    end
    object qryvs1_modulesIsExtra: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsExtra'
      Origin = 'M.IsExtra'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryvs1_modulesRequiredLevel: TIntegerField
      DisplayWidth = 10
      FieldName = 'RequiredLevel'
      Origin = 'M.RequiredLevel'
      Visible = False
    end
    object qryvs1_modulesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'M.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsvs1_clients: TDataSource
    DataSet = qryvs1_clients
    Left = 365
    Top = 489
  end
  object dsvs1_clientmodules: TDataSource
    DataSet = qryvs1_clientmodules
    Left = 485
    Top = 441
  end
  object qryvs1_clientmodules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT l.Description AS LicenseLevel, m.ModuleName, cm.Active, c' +
        'm.ModuleID '
      'FROM tblvs1_clientmodules cm '
      #9'LEFT JOIN tblvs1_modules m ON cm.ModuleId=m.ID'
      #9'LEFT JOIN tblvs1_licenselevels l ON cm.LicenseLevel=l.ID'
      'WHERE cm.ModuleID > 0 AND cm.ClientID=:cid')
    BeforeOpen = qryvs1_clientmodulesBeforeOpen
    Options.LongStrings = False
    Left = 493
    Top = 389
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cid'
      end>
    object qryvs1_clientmodulesLicenseLevel: TWideStringField
      FieldName = 'LicenseLevel'
      Origin = 'l.Description'
      Size = 255
    end
    object qryvs1_clientmodulesModuleName: TWideStringField
      FieldName = 'ModuleName'
      Origin = 'm.ModuleName'
      Size = 255
    end
    object qryvs1_clientmodulesActive: TWideStringField
      FieldName = 'Active'
      Origin = 'cm.Active'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientmodulesModuleID: TIntegerField
      FieldName = 'ModuleID'
      Origin = 'cm.ModuleId'
    end
  end
  object qryvs1_LicenseLevels: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'tblVS1_LicenseLevels')
    Options.LongStrings = False
    Left = 309
    Top = 365
    object qryvs1_LicenseLevelsID: TIntegerField
      FieldName = 'ID'
    end
    object qryvs1_LicenseLevelsLicenseOrder: TIntegerField
      FieldName = 'LicenseOrder'
    end
    object qryvs1_LicenseLevelsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object qryDatabases: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblVS1_Databases')
    Left = 440
    Top = 216
    object qryDatabasesDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Origin = 'tblvs1_databases.DatabaseName'
      Size = 255
    end
    object qryDatabasesServerName: TWideStringField
      FieldName = 'ServerName'
      Origin = 'tblvs1_databases.ServerName'
      Size = 255
    end
    object qryDatabasesAPIPort: TIntegerField
      FieldName = 'APIPort'
      Origin = 'tblvs1_databases.APIPort'
    end
    object qryDatabasesIsHttps: TWideStringField
      FieldName = 'IsHttps'
      Origin = 'tblvs1_databases.IsHttps'
      FixedChar = True
      Size = 1
    end
  end
  object dsDAtabases: TDataSource
    DataSet = qryDatabases
    Left = 512
    Top = 232
  end
end
