inherited fmAreaCode: TfmAreaCode
  Left = 424
  Top = 207
  HelpContext = 1066002
  Caption = 'Area Code'
  ClientHeight = 508
  ClientWidth = 452
  ExplicitLeft = 424
  ExplicitTop = 207
  ExplicitWidth = 468
  ExplicitHeight = 547
  DesignSize = (
    452
    508)
  PixelsPerInch = 96
  TextHeight = 15
  object Box20: TBevel [0]
    Left = 13
    Top = 49
    Width = 427
    Height = 88
    HelpContext = 1066003
  end
  inherited lblSkingroupMsg: TLabel
    Top = 508
    Width = 452
    HelpContext = 1066004
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 49
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
    Left = 112
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object Label1: TLabel [5]
    Left = 29
    Top = 67
    Width = 59
    Height = 15
    HelpContext = 1066005
    Caption = 'Area Code'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [6]
    Left = 213
    Top = 66
    Width = 33
    Height = 15
    HelpContext = 1066006
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel [7]
    Left = 24
    Top = 105
    Width = 65
    Height = 15
    HelpContext = 1066007
    Caption = 'Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmdClose: TDNMSpeedButton [9]
    Left = 95
    Top = 458
    Width = 93
    Height = 29
    HelpContext = 1066011
    Anchors = [akBottom]
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
    TabOrder = 3
    OnClick = cmdCloseClick
  end
  object cmdCancel: TDNMSpeedButton [10]
    Left = 249
    Top = 458
    Width = 93
    Height = 29
    HelpContext = 1066012
    Anchors = [akBottom]
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
    TabOrder = 4
    OnClick = cmdCancelClick
  end
  object edtprocessStep: TwwDBEdit [11]
    Left = 94
    Top = 63
    Width = 95
    Height = 23
    HelpContext = 1066013
    DataField = 'Areacode'
    DataSource = dsAreaCode
    Font.Charset = DEFAULT_CHARSET
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
  object wwDBEdit1: TwwDBEdit [12]
    Left = 251
    Top = 63
    Width = 183
    Height = 23
    HelpContext = 1066014
    DataField = 'AreaName'
    DataSource = dsAreaCode
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit2: TwwDBEdit [13]
    Left = 94
    Top = 101
    Width = 340
    Height = 23
    HelpContext = 1066015
    DataField = 'Description'
    DataSource = dsAreaCode
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object PageControl1: TPageControl [14]
    Left = 13
    Top = 144
    Width = 427
    Height = 306
    HelpContext = 1066016
    ActivePage = TabSheet1
    TabOrder = 6
    TabWidth = 106
    object TabSheet1: TTabSheet
      HelpContext = 1066017
      Caption = 'Employees'
      DesignSize = (
        419
        276)
      object grdEmployees: TwwDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 413
        Height = 228
        HelpContext = 1066018
        Selected.Strings = (
          'Employeename'#9'54'#9'Name')
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alTop
        Color = clWhite
        DataSource = dsEmployees
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
          HelpContext = 1066019
          AllowAllUp = True
        end
      end
      object btnAssignEmployee: TDNMSpeedButton
        Left = 247
        Top = 240
        Width = 169
        Height = 27
        Hint = 'Open the Employee List to to the Area code'
        HelpContext = 1066020
        Anchors = [akBottom]
        Caption = 'Assign Employees to Area'
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
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = btnAssignEmployeeClick
      end
    end
    object TabSheet2: TTabSheet
      HelpContext = 1066021
      Caption = 'Customers'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        419
        276)
      object grdcustomers: TwwDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 413
        Height = 228
        HelpContext = 1066022
        Selected.Strings = (
          'company'#9'54'#9'Name')
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alTop
        Color = clWhite
        DataSource = dsCustomers
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
          HelpContext = 1066023
          AllowAllUp = True
        end
      end
      object btnAssignCustomer: TDNMSpeedButton
        Left = 247
        Top = 240
        Width = 169
        Height = 27
        Hint = 'Open the Customer List to to the Area code'
        HelpContext = 1066024
        Anchors = [akBottom]
        Caption = 'Assign Customers to Area'
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
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = btnAssignCustomerClick
      end
    end
    object TabSheet3: TTabSheet
      HelpContext = 1066025
      Caption = 'Suppliers'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        419
        276)
      object grdsuppliers: TwwDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 413
        Height = 228
        HelpContext = 1066026
        Selected.Strings = (
          'company'#9'54'#9'Name')
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alTop
        Color = clWhite
        DataSource = dsSuppliers
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
        object wwIButton2: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          HelpContext = 1066027
          AllowAllUp = True
        end
      end
      object btnAssignSupplier: TDNMSpeedButton
        Left = 247
        Top = 240
        Width = 169
        Height = 27
        Hint = 'Open the Supplier List to to the Area code'
        HelpContext = 1066028
        Anchors = [akBottom]
        Caption = 'Assign Suppliers to Area'
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
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = btnAssignSupplierClick
      end
    end
    object TabSheet4: TTabSheet
      HelpContext = 1066029
      Caption = 'Products'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        419
        276)
      object grdProducts: TwwDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 413
        Height = 228
        HelpContext = 1066030
        Selected.Strings = (
          'PartName'#9'54'#9'Name')
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alTop
        Color = clWhite
        DataSource = dsProducts
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
        object wwIButton3: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          HelpContext = 1066031
          AllowAllUp = True
        end
      end
      object btnAssignProducts: TDNMSpeedButton
        Left = 247
        Top = 240
        Width = 169
        Height = 27
        Hint = 'Open the Product List to to the Area code'
        HelpContext = 1066032
        Anchors = [akBottom]
        Caption = 'Assign Products to Area'
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
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = btnAssignProductsClick
      end
    end
  end
  object pnlTitle: TDNMPanel [15]
    Left = 103
    Top = 4
    Width = 257
    Height = 39
    HelpContext = 1066008
    Anchors = []
    
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 255
      Height = 37
      HelpContext = 1066009
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
        Width = 255
        Height = 37
        HelpContext = 1066010
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Area Code'
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
  inherited tmrProcessMessage: TTimer
    Left = 96
    Top = 79
  end
  inherited tmrdelay: TTimer
    Left = 242
    Top = 79
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 133
    Top = 79
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 278
    Top = 79
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 315
    Top = 79
  end
  inherited DataState: TDataState
    Left = 169
    Top = 79
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 351
    Top = 79
  end
  inherited imgsort: TImageList
    Left = 206
    Top = 79
    Bitmap = {
      494C010102008800900010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 79
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 388
    Top = 79
  end
  object QryAreacode: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblAreaCodes')
    Left = 24
    Top = 79
    object QryAreacodeID: TIntegerField
      FieldName = 'ID'
    end
    object QryAreacodeGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object QryAreacodeAreacode: TWideStringField
      FieldName = 'Areacode'
      Size = 50
    end
    object QryAreacodeAreaName: TWideStringField
      FieldName = 'AreaName'
      Size = 100
    end
    object QryAreacodeDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object QryAreacodeActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryAreacodemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryAreacodemsUpdateSitecode: TWideStringField
      FieldName = 'msUpdateSitecode'
      Size = 3
    end
  end
  object dsAreaCode: TDataSource
    DataSet = QryAreacode
    Left = 24
    Top = 107
  end
  object QryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select EmployeeID, Employeename from tblEmployees Where area =:A' +
        'reaCode and ifnull(area ,'#39#39')<> '#39#39)
    Left = 48
    Top = 247
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AreaCode'
      end>
    object QryEmployeesEmployeename: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 54
      FieldName = 'Employeename'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
    object QryEmployeesEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
      Visible = False
    end
  end
  object dsEmployees: TDataSource
    DataSet = QryEmployees
    Left = 48
    Top = 275
  end
  object dsCustomers: TDataSource
    DataSet = QryCustomers
    Left = 96
    Top = 275
  end
  object QryCustomers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT clientId, company from tblclients Where area =:AreaCode a' +
        'nd Customer="T" and ifnull(area ,'#39#39')<> '#39#39)
    Left = 96
    Top = 247
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AreaCode'
      end>
    object QryCustomerscompany: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 54
      FieldName = 'company'
      Origin = 'tblclients.Company'
      Size = 160
    end
    object QryCustomersclientId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'clientId'
      Origin = 'tblclients.ClientID'
      Visible = False
    end
  end
  object dsSuppliers: TDataSource
    DataSet = QrySuppliers
    Left = 136
    Top = 275
  end
  object QrySuppliers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT clientId, company from tblclients Where area =:AreaCode a' +
        'nd Supplier="T" and ifnull(area ,'#39#39')<> '#39#39)
    Left = 136
    Top = 247
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AreaCode'
      end>
    object QrySupplierscompany: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 54
      FieldName = 'company'
      Origin = 'tblclients.Company'
      Size = 160
    end
    object QrySuppliersclientId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'clientId'
      Origin = 'tblclients.ClientID'
      Visible = False
    end
  end
  object dsProducts: TDataSource
    DataSet = QryProducts
    Left = 176
    Top = 275
  end
  object QryProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select PartsId, PartName from tblParts Where area =:AreaCode and' +
        ' ifnull(area ,'#39#39')<> '#39#39)
    Left = 176
    Top = 247
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AreaCode'
      end>
    object QryProductsPartName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 54
      FieldName = 'PartName'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object QryProductsPartsId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'tblparts.PARTSID'
      Visible = False
    end
  end
end
