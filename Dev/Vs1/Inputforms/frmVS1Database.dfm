inherited fmVS1Database: TfmVS1Database
  Left = 361
  Top = 218
  Caption = 'VS1  Client'
  ClientHeight = 609
  ClientWidth = 732
  Menu = MainMenu1
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
  object Label8: TLabel [5]
    Left = 24
    Top = 159
    Width = 73
    Height = 15
    HelpContext = 355286
    Alignment = taRightJustify
    Caption = 'License Until'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object DNMPanel2: TDNMPanel [6]
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
    DesignSize = (
      732
      59)
    object pnlTitle: TDNMPanel
      Left = 19
      Top = 9
      Width = 686
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
        Width = 684
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
          Width = 684
          Height = 37
          HelpContext = 372082
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'VS1  Database'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 6
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [7]
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
      Left = 319
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 251008
      Anchors = []
      Caption = '&Close'
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
  end
  object DNMPanel1: TDNMPanel [8]
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
    object lblClientPrintNameHeading: TLabel
      Left = 63
      Top = 9
      Width = 33
      Height = 15
      HelpContext = 355286
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
      Left = 40
      Top = 41
      Width = 57
      Height = 15
      HelpContext = 355286
      Alignment = taRightJustify
      Caption = 'Database '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 24
      Top = 74
      Width = 73
      Height = 15
      HelpContext = 355286
      Alignment = taRightJustify
      Caption = 'License Until'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 24
      Top = 106
      Width = 72
      Height = 15
      HelpContext = 355286
      Alignment = taRightJustify
      Caption = 'Accountants'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtPrintName: TDBEdit
      Left = 103
      Top = 6
      Width = 160
      Height = 23
      HelpContext = 355287
      DataField = 'ClientName'
      DataSource = dsvs1_clients
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      Left = 103
      Top = 38
      Width = 160
      Height = 23
      HelpContext = 355287
      DataField = 'Databasename'
      DataSource = dsvs1_clients
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object DNMPanel4: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 346
      Width = 724
      Height = 150
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label3: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 716
        Height = 15
        HelpContext = 355286
        Align = alTop
        Caption = 'Users'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 34
      end
      object grdMain: TwwDBGrid
        AlignWithMargins = True
        Left = 4
        Top = 25
        Width = 716
        Height = 121
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        Selected.Strings = (
          'EmailId'#9'30'#9'Email'
          'Password'#9'30'#9'Password'
          'Phone'#9'20'#9'Phone'
          'Active'#9'1'#9'Active')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        DataSource = dsvs1_clientusers
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        LineColors.GroupingColor = clSilver
        FooterColor = clWhite
        FooterCellColor = clWhite
        ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
        object btnGrid: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          AllowAllUp = True
        end
      end
    end
    object DNMPanel5: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 140
      Width = 724
      Height = 200
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label2: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 716
        Height = 15
        HelpContext = 355286
        Align = alTop
        Caption = 'Modules'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 48
      end
      object wwDBGrid1: TwwDBGrid
        AlignWithMargins = True
        Left = 4
        Top = 25
        Width = 716
        Height = 171
        Selected.Strings = (
          'ModuleName'#9'10'#9'ModuleName'
          'ModuleDesc'#9'1'#9'ModuleDesc'
          'LicenseExtensionDesc'#9'10'#9'Special Extension'
          'RenewDiscountDesc'#9'10'#9'Discount Desc'
          'DateStarted'#9'10'#9'DateStarted'
          'LicenseFrom'#9'10'#9'LicenseFrom'
          'LicenseUntil'#9'10'#9'LicenseUntil'
          'Price'#9'10'#9'Price'
          'DiscountAmt'#9'10'#9'DiscountAmt'
          'DiscountedPrice'#9'10'#9'DiscountedPrice'
          'RenewPrice'#9'10'#9'RenewPrice'
          'RenewDiscountAmt'#9'10'#9'RenewDiscountAmt'
          'RenewDiscountedPrice'#9'10'#9'RenewDiscountedPrice'
          'Active'#9'1'#9'Active'
          'DiscountDesc'#9'255'#9'DiscountDesc')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        DataSource = dsvs1_clientmodules
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        LineColors.GroupingColor = clSilver
        FooterColor = clWhite
        FooterCellColor = clWhite
        ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
        object wwIButton1: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          AllowAllUp = True
        end
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 269
      Top = 1
      Width = 462
      Height = 136
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        462
        136)
      object Label4: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 454
        Height = 15
        HelpContext = 355286
        Align = alTop
        Caption = 'Extend License'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 87
      end
      object Label6: TLabel
        Left = 10
        Top = 37
        Width = 103
        Height = 15
        HelpContext = 355286
        Alignment = taRightJustify
        Caption = 'Extend License To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 24
        Top = 86
        Width = 65
        Height = 15
        HelpContext = 355286
        Alignment = taRightJustify
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object dtExtendLicenseTo: TDateTimePicker
        Left = 128
        Top = 34
        Width = 186
        Height = 23
        Date = 44399.544153425920000000
        Time = 44399.544153425920000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtExtendLicense: TEdit
        Left = 128
        Top = 83
        Width = 193
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'edtExtendLicense'
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 336
        Top = 79
        Width = 116
        Height = 29
        HelpContext = 251008
        Anchors = []
        Caption = 'Extend License'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
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
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
    end
    object DBEdit2: TDBEdit
      Left = 103
      Top = 71
      Width = 160
      Height = 23
      HelpContext = 355287
      DataField = 'LicenseUntil'
      DataSource = dsvs1_clients
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object edtAccountant: TDBEdit
      Left = 103
      Top = 103
      Width = 160
      Height = 23
      HelpContext = 355287
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 191
    Top = 311
  end
  inherited tmrdelay: TTimer
    Left = 398
    Top = 311
  end
  inherited popSpelling: TPopupMenu
    Left = 156
    Top = 311
  end
  inherited tmrdelayMsg: TTimer
    Left = 122
    Top = 311
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 225
    Top = 311
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 432
    Top = 311
  end
  inherited MyConnection: TERPConnection
    Database = 'vs1_sandbox_license'
    Server = 'localhost'
    Connected = True
    Left = 88
    Top = 311
  end
  inherited DataState: TDataState
    Left = 294
    Top = 311
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 467
    Top = 311
  end
  inherited imgsort: TImageList
    Left = 363
    Top = 311
    Bitmap = {
      494C010102009400D40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 333
    Top = 253
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 501
    Top = 311
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 260
    Top = 311
  end
  inherited qryMemTrans: TERPQuery
    Left = 300
    Top = 253
  end
  inherited tmrOnshow: TTimer
    Left = 536
    Top = 311
  end
  object Actionlist: TActionList
    Left = 329
    Top = 311
  end
  object qryvs1_clients: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '* '
      'FROM tblvs1_clients')
    AfterOpen = qryvs1_clientsAfterOpen
    Active = True
    Left = 192
    Top = 248
    object qryvs1_clientsid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'tblvs1_clients.id'
    end
    object qryvs1_clientsClientName: TWideStringField
      FieldName = 'ClientName'
      Origin = 'tblvs1_clients.ClientName'
      Size = 255
    end
    object qryvs1_clientsRegistrationDate: TDateField
      FieldName = 'RegistrationDate'
      Origin = 'tblvs1_clients.RegistrationDate'
    end
    object qryvs1_clientsSoftwareReleaseType: TWideStringField
      FieldName = 'SoftwareReleaseType'
      Origin = 'tblvs1_clients.SoftwareReleaseType'
      Size = 255
    end
    object qryvs1_clientsVS1ClientName: TWideStringField
      FieldName = 'VS1ClientName'
      Origin = 'tblvs1_clients.VS1ClientName'
      Size = 255
    end
    object qryvs1_clientsvs1ClientID: TIntegerField
      FieldName = 'vs1ClientID'
      Origin = 'tblvs1_clients.vs1ClientID'
    end
    object qryvs1_clientsCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Origin = 'tblvs1_clients.CreditCardType'
      Size = 255
    end
    object qryvs1_clientsCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Origin = 'tblvs1_clients.CreditCardCardHolderName'
      Size = 255
    end
    object qryvs1_clientsCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Origin = 'tblvs1_clients.CreditCardNumber'
      Size = 50
    end
    object qryvs1_clientsCreditCardCVC: TWideStringField
      FieldName = 'CreditCardCVC'
      Origin = 'tblvs1_clients.CreditCardCVC'
      Size = 50
    end
    object qryvs1_clientsCreditCardExpiryMonth: TIntegerField
      FieldName = 'CreditCardExpiryMonth'
      Origin = 'tblvs1_clients.CreditCardExpiryMonth'
    end
    object qryvs1_clientsCreditCardExpiryYear: TIntegerField
      FieldName = 'CreditCardExpiryYear'
      Origin = 'tblvs1_clients.CreditCardExpiryYear'
    end
    object qryvs1_clientsCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Origin = 'tblvs1_clients.CreditCardNotes'
      Size = 255
    end
    object qryvs1_clientsEmailVarified: TWideStringField
      FieldName = 'EmailVarified'
      Origin = 'tblvs1_clients.EmailVarified'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientsServerName: TWideStringField
      FieldName = 'ServerName'
      Origin = 'tblvs1_clients.ServerName'
      Size = 255
    end
    object qryvs1_clientsDatabaseID: TIntegerField
      FieldName = 'DatabaseID'
      Origin = 'tblvs1_clients.DatabaseID'
    end
    object qryvs1_clientsDatabasename: TWideStringField
      FieldName = 'Databasename'
      Origin = 'tblvs1_clients.Databasename'
      Size = 255
    end
    object qryvs1_clientsSampleDatabaseID: TIntegerField
      FieldName = 'SampleDatabaseID'
      Origin = 'tblvs1_clients.SampleDatabaseID'
    end
    object qryvs1_clientsSampledatabasename: TWideStringField
      FieldName = 'Sampledatabasename'
      Origin = 'tblvs1_clients.Sampledatabasename'
      Size = 255
    end
    object qryvs1_clientsRegionName: TWideStringField
      FieldName = 'RegionName'
      Origin = 'tblvs1_clients.RegionName'
      Size = 255
    end
    object qryvs1_clientsLicenseFrom: TDateField
      FieldName = 'LicenseFrom'
      Origin = 'tblvs1_clients.LicenseFrom'
    end
    object qryvs1_clientsLicenseUntil: TDateField
      FieldName = 'LicenseUntil'
      Origin = 'tblvs1_clients.LicenseUntil'
    end
    object qryvs1_clientsLicenseLevel: TIntegerField
      FieldName = 'LicenseLevel'
      Origin = 'tblvs1_clients.LicenseLevel'
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
    object qryvs1_clientsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblvs1_clients.Active'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientsAPIPort: TIntegerField
      FieldName = 'APIPort'
      Origin = 'tblvs1_clients.APIPort'
    end
    object qryvs1_clientsIsHttps: TWideStringField
      FieldName = 'IsHttps'
      Origin = 'tblvs1_clients.IsHttps'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblvs1_clients.msTimeStamp'
    end
    object qryvs1_clientsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblvs1_clients.msUpdateSiteCode'
      Size = 3
    end
  end
  object dsvs1_clients: TDataSource
    DataSet = qryvs1_clients
    Left = 192
    Top = 280
  end
  object dsvs1_clientusers: TDataSource
    DataSet = qryvs1_clientusers
    Left = 224
    Top = 280
  end
  object qryvs1_clientusers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '* '
      'FROM tblvs1_clientusers')
    Active = True
    Left = 224
    Top = 248
    object qryvs1_clientusersEmailId: TWideStringField
      DisplayLabel = 'Email'
      DisplayWidth = 30
      FieldName = 'EmailId'
      Origin = 'tblvs1_clientusers.EmailId'
      Size = 40
    end
    object qryvs1_clientusersPassword: TWideStringField
      DisplayWidth = 30
      FieldName = 'Password'
      Origin = 'tblvs1_clientusers.Password'
      Size = 40
    end
    object qryvs1_clientusersPhone: TWideStringField
      DisplayWidth = 20
      FieldName = 'Phone'
      Origin = 'tblvs1_clientusers.Phone'
      Size = 255
    end
    object qryvs1_clientusersActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblvs1_clientusers.Active'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientusersID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblvs1_clientusers.ID'
      Visible = False
    end
    object qryvs1_clientusersClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblvs1_clientusers.ClientID'
      Visible = False
    end
    object qryvs1_clientusersVS1EmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'VS1EmployeeId'
      Origin = 'tblvs1_clientusers.VS1EmployeeId'
      Visible = False
    end
    object qryvs1_clientusersDatabaseName: TWideStringField
      DisplayWidth = 255
      FieldName = 'DatabaseName'
      Origin = 'tblvs1_clientusers.DatabaseName'
      Visible = False
      Size = 255
    end
    object qryvs1_clientusersIsAdminUser: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsAdminUser'
      Origin = 'tblvs1_clientusers.IsAdminUser'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientusersmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblvs1_clientusers.msTimeStamp'
      Visible = False
    end
    object qryvs1_clientusersmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblvs1_clientusers.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object qryvs1_clientmodules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '* '
      'FROM tblvs1_clientmodules')
    Active = True
    Left = 256
    Top = 248
    object qryvs1_clientmodulesModuleName: TWideStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'ModuleName'
      LookupDataSet = tqryvs1_modules
      LookupKeyFields = 'ID'
      LookupResultField = 'ModuleName'
      KeyFields = 'ModuleId'
      Size = 255
      Lookup = True
    end
    object qryvs1_clientmodulesModuleDesc: TWideStringField
      DisplayWidth = 1
      FieldKind = fkLookup
      FieldName = 'ModuleDesc'
      LookupDataSet = tqryvs1_modules
      LookupKeyFields = 'ID'
      LookupResultField = 'Description'
      KeyFields = 'ModuleId'
      Size = 255
      Lookup = True
    end
    object qryvs1_clientmodulesLicenseExtensionDesc: TWideStringField
      DisplayLabel = 'Special Extension'
      DisplayWidth = 10
      FieldName = 'LicenseExtensionDesc'
      Origin = 'tblvs1_clientmodules.LicenseExtensionDesc'
      Size = 255
    end
    object qryvs1_clientmodulesRenewDiscountDesc: TWideStringField
      DisplayLabel = 'Discount Desc'
      DisplayWidth = 10
      FieldName = 'RenewDiscountDesc'
      Origin = 'tblvs1_clientmodules.RenewDiscountDesc'
      Size = 255
    end
    object qryvs1_clientmodulesDateStarted: TDateField
      DisplayWidth = 10
      FieldName = 'DateStarted'
      Origin = 'tblvs1_clientmodules.DateStarted'
    end
    object qryvs1_clientmodulesLicenseFrom: TDateField
      DisplayWidth = 10
      FieldName = 'LicenseFrom'
      Origin = 'tblvs1_clientmodules.LicenseFrom'
    end
    object qryvs1_clientmodulesLicenseUntil: TDateField
      DisplayWidth = 10
      FieldName = 'LicenseUntil'
      Origin = 'tblvs1_clientmodules.LicenseUntil'
    end
    object qryvs1_clientmodulesPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      Origin = 'tblvs1_clientmodules.Price'
      currency = True
    end
    object qryvs1_clientmodulesDiscountAmt: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountAmt'
      Origin = 'tblvs1_clientmodules.DiscountAmt'
      currency = True
    end
    object qryvs1_clientmodulesDiscountedPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountedPrice'
      Origin = 'tblvs1_clientmodules.DiscountedPrice'
      currency = True
    end
    object qryvs1_clientmodulesRenewPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'RenewPrice'
      Origin = 'tblvs1_clientmodules.RenewPrice'
      currency = True
    end
    object qryvs1_clientmodulesRenewDiscountAmt: TFloatField
      DisplayWidth = 10
      FieldName = 'RenewDiscountAmt'
      Origin = 'tblvs1_clientmodules.RenewDiscountAmt'
      currency = True
    end
    object qryvs1_clientmodulesRenewDiscountedPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'RenewDiscountedPrice'
      Origin = 'tblvs1_clientmodules.RenewDiscountedPrice'
      currency = True
    end
    object qryvs1_clientmodulesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblvs1_clientmodules.Active'
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientmodulesDiscountDesc: TWideStringField
      DisplayWidth = 255
      FieldName = 'DiscountDesc'
      Origin = 'tblvs1_clientmodules.DiscountDesc'
      Size = 255
    end
    object qryvs1_clientmodulesLicenseRenewDuration: TIntegerField
      DisplayWidth = 10
      FieldName = 'LicenseRenewDuration'
      Origin = 'tblvs1_clientmodules.LicenseRenewDuration'
      Visible = False
    end
    object qryvs1_clientmodulesLicenseLevel: TIntegerField
      DisplayWidth = 10
      FieldName = 'LicenseLevel'
      Origin = 'tblvs1_clientmodules.LicenseLevel'
      Visible = False
    end
    object qryvs1_clientmodulesLicenseRenewDurationType: TWideStringField
      DisplayWidth = 1
      FieldName = 'LicenseRenewDurationType'
      Origin = 'tblvs1_clientmodules.LicenseRenewDurationType'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryvs1_clientmodulesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblvs1_clientmodules.ID'
      Visible = False
    end
    object qryvs1_clientmodulesClientId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientId'
      Origin = 'tblvs1_clientmodules.ClientId'
      Visible = False
    end
    object qryvs1_clientmodulesModuleId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ModuleId'
      Origin = 'tblvs1_clientmodules.ModuleId'
      Visible = False
    end
    object qryvs1_clientmodulesModulePriceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ModulePriceID'
      Origin = 'tblvs1_clientmodules.ModulePriceID'
      Visible = False
    end
    object qryvs1_clientmodulesmoduleDiscountId: TIntegerField
      DisplayWidth = 10
      FieldName = 'moduleDiscountId'
      Origin = 'tblvs1_clientmodules.moduleDiscountId'
      Visible = False
    end
    object qryvs1_clientmodulesDatePaid: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DatePaid'
      Origin = 'tblvs1_clientmodules.DatePaid'
      Visible = False
    end
    object qryvs1_clientmodulesClientPaymentId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientPaymentId'
      Origin = 'tblvs1_clientmodules.ClientPaymentId'
      Visible = False
    end
    object qryvs1_clientmodulesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblvs1_clientmodules.msTimeStamp'
      Visible = False
    end
    object qryvs1_clientmodulesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblvs1_clientmodules.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsvs1_clientmodules: TDataSource
    DataSet = qryvs1_clientmodules
    Left = 256
    Top = 280
  end
  object tqryvs1_modules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'tblvs1_modules')
    Options.LongStrings = False
    Active = True
    Left = 389
    Top = 261
    object tqryvs1_modulesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblvs1_modules.ID'
    end
    object tqryvs1_modulesModuleName: TWideStringField
      FieldName = 'ModuleName'
      Origin = 'tblvs1_modules.ModuleName'
      Size = 255
    end
    object tqryvs1_modulesDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblvs1_modules.Description'
      Size = 100
    end
  end
  object MainMenu1: TMainMenu
    Left = 640
    Top = 64
  end
end
