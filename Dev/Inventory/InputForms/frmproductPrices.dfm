inherited fmproductPrices: TfmproductPrices
  Left = 237
  Top = 181
  HelpContext = 810001
  Caption = 'Product Prices'
  ClientHeight = 571
  ClientWidth = 1000
  ExplicitLeft = 237
  ExplicitTop = 181
  ExplicitWidth = 1016
  ExplicitHeight = 610
  DesignSize = (
    1000
    571)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 571
    Width = 1000
    ExplicitTop = 571
    ExplicitWidth = 978
    HelpContext = 810066
  end
  inherited shapehint: TShape
    Left = 13
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 55
  end
  object Panel4: TPanel [5]
    Left = 4
    Top = 94
    Width = 253
    Height = 139
    HelpContext = 810008
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    object DBText1: TDBText
      Left = 2
      Top = 60
      Width = 65
      Height = 17
      HelpContext = 810009
      Alignment = taRightJustify
      DataField = 'SellQTY1'
      DataSource = dsbaseprice
    end
    object DBText2: TDBText
      Left = 2
      Top = 87
      Width = 65
      Height = 17
      HelpContext = 810010
      Alignment = taRightJustify
      DataField = 'SellQTY2'
      DataSource = dsbaseprice
    end
    object DBText3: TDBText
      Left = 2
      Top = 114
      Width = 65
      Height = 17
      HelpContext = 810011
      Alignment = taRightJustify
      DataField = 'SellQTY3'
      DataSource = dsbaseprice
    end
    object Label13: TLabel
      Left = 20
      Top = 33
      Width = 47
      Height = 15
      HelpContext = 810012
      Alignment = taCenter
      Caption = 'Quantity'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Price: TLabel
      Left = 105
      Top = 33
      Width = 55
      Height = 15
      HelpContext = 810013
      Alignment = taCenter
      Caption = 'Price (Ex)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 190
      Top = 33
      Width = 58
      Height = 15
      HelpContext = 810014
      Alignment = taCenter
      Caption = 'Price (Inc)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 51
      Width = 423
      Height = 1
      HelpContext = 810015
      Shape = bsBottomLine
    end
    object Label3: TLabel
      Left = 6
      Top = 10
      Width = 69
      Height = 15
      HelpContext = 810016
      Alignment = taCenter
      Caption = 'Base Prices'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblBOMPrice: TLabel
      AlignWithMargins = True
      Left = 100
      Top = 10
      Width = 60
      Height = 15
      HelpContext = 810047
      Margins.Top = 0
      Caption = 'BOM Price'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtPrice1: TDBEdit
      Left = 79
      Top = 57
      Width = 81
      Height = 23
      HelpContext = 810017
      DataField = 'price1'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtPrice2: TDBEdit
      Left = 79
      Top = 84
      Width = 81
      Height = 23
      HelpContext = 810018
      DataField = 'price2'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtPrice3: TDBEdit
      Left = 79
      Top = 111
      Width = 81
      Height = 23
      HelpContext = 810019
      DataField = 'price3'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtPrice1inc: TDBEdit
      Left = 167
      Top = 57
      Width = 81
      Height = 23
      HelpContext = 810020
      DataField = 'priceinc1'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtPrice3inc: TDBEdit
      Left = 167
      Top = 111
      Width = 81
      Height = 23
      HelpContext = 810021
      DataField = 'priceinc3'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object edtPrice2inc: TDBEdit
      Left = 167
      Top = 84
      Width = 81
      Height = 23
      HelpContext = 810022
      DataField = 'priceinc2'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object edtBOMPrice: TDBEdit
      AlignWithMargins = True
      Left = 167
      Top = 6
      Width = 81
      Height = 23
      HelpContext = 810049
      Margins.Top = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
  end
  object Panel5: TPanel [6]
    Left = 655
    Top = 94
    Width = 341
    Height = 139
    HelpContext = 810023
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 4
    object Label4: TLabel
      Left = 6
      Top = 3
      Width = 116
      Height = 15
      HelpContext = 810024
      Alignment = taCenter
      Caption = 'Customer Discounts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object grdCustomerlines: TwwDBGrid
      Left = 2
      Top = 25
      Width = 337
      Height = 112
      HelpContext = 810025
      Selected.Strings = (
        'Company'#9'32'#9'Company'#9'F'
        'Lineprice'#9'10'#9'Lineprice')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alBottom
      DataSource = dsCustomerSpecialPrice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdCustomerlinesCalcCellColors
      FooterColor = clWhite
    end
  end
  object Panel9: TPanel [7]
    Left = 360
    Top = 94
    Width = 293
    Height = 139
    HelpContext = 810042
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 6
    object Label12: TLabel
      Left = 6
      Top = 1
      Width = 69
      Height = 15
      HelpContext = 810043
      Alignment = taCenter
      Caption = 'Price Matrix'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object grdPriceMatrix: TwwDBGrid
      Left = 2
      Top = 20
      Width = 289
      Height = 117
      HelpContext = 810044
      Selected.Strings = (
        'EntryValueDesc'#9'25'#9'Entry Value Desc'
        'Price'#9'10'#9'Price')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alBottom
      DataSource = dsPriceMatrix
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdPriceMatrixCalcCellColors
      FooterColor = clWhite
    end
  end
  object Panel10: TPanel [8]
    Left = 258
    Top = 95
    Width = 101
    Height = 139
    HelpContext = 810045
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 5
    object Label15: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 33
      Width = 91
      Height = 15
      HelpContext = 810046
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Tax Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 52
    end
    object Label16: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 89
      Width = 91
      Height = 15
      HelpContext = 810067
      Align = alBottom
      Caption = 'Tax Rate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 49
    end
    object DBEdit9: TDBEdit
      AlignWithMargins = True
      Left = 5
      Top = 57
      Width = 91
      Height = 23
      HelpContext = 810048
      Margins.Bottom = 6
      Align = alBottom
      DataField = 'TAXCODE'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      AlignWithMargins = True
      Left = 5
      Top = 110
      Width = 91
      Height = 23
      HelpContext = 810068
      Margins.Bottom = 4
      Align = alBottom
      DataField = 'salesrate'
      DataSource = dsbaseprice
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object Panel11: TPanel [9]
    Left = 584
    Top = 49
    Width = 411
    Height = 45
    HelpContext = 810050
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object Label17: TLabel
      Left = 8
      Top = 15
      Width = 73
      Height = 15
      HelpContext = 810051
      Alignment = taCenter
      Caption = 'Price For Qty'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 178
      Top = 15
      Width = 7
      Height = 15
      HelpContext = 810052
      Alignment = taCenter
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdtQty: TEdit
      Left = 89
      Top = 11
      Width = 82
      Height = 23
      HelpContext = 810053
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyDown = EdtQtyKeyDown
    end
    object edtPrice: TEdit
      Left = 191
      Top = 11
      Width = 104
      Height = 23
      HelpContext = 810054
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0'
    end
    object edtPriceinc: TEdit
      Left = 301
      Top = 11
      Width = 104
      Height = 23
      HelpContext = 810055
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0'
    end
  end
  object DNMSpeedButton1: TDNMSpeedButton [10]
    Left = 816
    Top = 16
    Width = 100
    Height = 23
    Hint = 'F5 to Recalculate'
    HelpContext = 810059
    Caption = 'Calculate'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    AutoDisableParentOnclick = True
    OnClick = DNMSpeedButton1Click
  end
  object pnlTitle: TDNMPanel [11]
    Left = 223
    Top = 3
    Width = 549
    Height = 40
    HelpContext = 810063
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 545
      Height = 36
      HelpContext = 810064
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
        Width = 545
        Height = 36
        HelpContext = 810065
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Product Prices'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 494
      end
    end
  end
  object Panel1: TPanel [12]
    Left = 4
    Top = 49
    Width = 286
    Height = 45
    HelpContext = 810002
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object lblClassTitle: TLabel
      Left = 6
      Top = 15
      Width = 45
      Height = 15
      HelpContext = 810003
      Alignment = taCenter
      Caption = 'Product'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cboPart: TwwDBLookupCombo
      Left = 62
      Top = 11
      Width = 218
      Height = 23
      HelpContext = 810004
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'PartsID'
      LookupTable = cboPartsQry
      LookupField = 'PartName'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object Panel2: TPanel [13]
    Left = 290
    Top = 49
    Width = 293
    Height = 45
    HelpContext = 810005
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 15
      Width = 56
      Height = 15
      HelpContext = 810006
      Alignment = taCenter
      Caption = 'Customer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cboCustomer: TwwDBLookupCombo
      Left = 79
      Top = 11
      Width = 197
      Height = 23
      HelpContext = 810007
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'ClientID'
      LookupTable = QryCustomer
      LookupField = 'Company'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboCustomerChange
    end
  end
  object DNMPanel1: TDNMPanel [14]
    Left = 4
    Top = 234
    Width = 453
    Height = 333
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    HelpContext = 810069
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 453
      Height = 130
      HelpContext = 810029
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object Label2: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 335
        Height = 15
        HelpContext = 810030
        Margins.Right = 111
        Align = alTop
        Caption = 'Customer Group Discount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 146
      end
      object grdGroupdiscount: TwwDBGrid
        Left = 2
        Top = 23
        Width = 449
        Height = 105
        HelpContext = 810031
        Selected.Strings = (
          'col1'#9'16'#9'col1'
          'col2'#9'15'#9'col2'
          'col3'#9'15'#9'col3'
          'discount'#9'10'#9'discount')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsprodgroupdiscs
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = grdGroupdiscountCalcCellColors
        FooterColor = clWhite
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 130
      Width = 453
      Height = 130
      HelpContext = 810056
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object Label6: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 335
        Height = 15
        HelpContext = 810057
        Margins.Right = 111
        Align = alTop
        Caption = 'Unit of Measures'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 96
      end
      object grduom: TwwDBGrid
        Left = 2
        Top = 23
        Width = 449
        Height = 105
        HelpContext = 810058
        Selected.Strings = (
          'UnitName'#9'15'#9'Unit Name'#9'F'
          'Multiplier'#9'10'#9'Multiplier'#9#9
          'Price1'#9'10'#9'Price1'#9'F'
          'Price2'#9'10'#9'Price2'#9'F'
          'Price3'#9'10'#9'Price3'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsUnitOfMeasure
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grduomCalcCellColors
        FooterColor = clWhite
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 260
      Width = 453
      Height = 73
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      HelpContext = 810070
      object Label10: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 337
        Height = 15
        HelpContext = 810071
        Margins.Right = 111
        Align = alTop
        Caption = 'Product Price From Excel Sheet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 180
      end
      object lblExcelPriceMsg: TLabel
        AlignWithMargins = True
        Left = 45
        Top = 22
        Width = 363
        Height = 50
        HelpContext = 810072
        Margins.Left = 44
        Margins.Top = 0
        Margins.Right = 44
        Margins.Bottom = 0
        Align = alClient
        Alignment = taCenter
        Color = clMaroon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 1
        ExplicitWidth = 3
        ExplicitHeight = 15
      end
      object grdExcelPrices: TwwDBGrid
        Left = 1
        Top = 22
        Width = 451
        Height = 50
        HelpContext = 810073
        ControlType.Strings = (
          'Ovirrides;CheckBox;T;F')
        Selected.Strings = (
          'Price'#9'10'#9'Price From Excel Sheet'#9'F'
          'Ovirrides'#9'10'#9'Excel Sheet Price Overrides Other Discounts ?'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dspartsforexcelprice
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grduomCalcCellColors
        FooterColor = clWhite
      end
    end
  end
  object DNMPanel2: TDNMPanel [15]
    Left = 463
    Top = 234
    Width = 531
    Height = 333
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    HelpContext = 810074
    object Panel6: TPanel
      Left = 0
      Top = 204
      Width = 531
      Height = 129
      HelpContext = 810060
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object lblclientDiscount: TLabel
        Left = 2
        Top = 2
        Width = 527
        Height = 15
        HelpContext = 810061
        Align = alTop
        Alignment = taCenter
        Caption = 'result'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitWidth = 33
      end
      object lblMsg: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 109
        Width = 413
        Height = 15
        HelpContext = 810075
        Margins.Right = 111
        Align = alBottom
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 3
      end
      object memresult: TMemo
        Left = 2
        Top = 17
        Width = 527
        Height = 89
        HelpContext = 810062
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        WantReturns = False
        WordWrap = False
        ExplicitHeight = 110
      end
    end
    object pnlExtraSellPrice: TPanel
      Left = 0
      Top = 80
      Width = 531
      Height = 124
      HelpContext = 810026
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object Label5: TLabel
        Left = 6
        Top = 3
        Width = 87
        Height = 15
        HelpContext = 810027
        Alignment = taCenter
        Caption = 'Extra Sell Price'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object grdExtraSellPrice: TwwDBGrid
        Left = 2
        Top = 23
        Width = 527
        Height = 99
        HelpContext = 810028
        Selected.Strings = (
          'Terms'#9'8'#9'Terms'#9#9
          'TypeName'#9'10'#9'Customer type'#9#9
          'DateFrom'#9'10'#9'Date From'#9#9
          'DateTo'#9'10'#9'Date To'#9#9
          'UOM'#9'9'#9'UOM'#9'F'#9
          'QtyPercent1'#9'8'#9'Discount %'#9#9
          'Price1'#9'8'#9'Price'#9#9
          'AvgCost'#9'10'#9'Avg Cost'#9'F'
          'LatestCost'#9'10'#9'Latest Cost'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alBottom
        DataSource = dsExtraSellPrice
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = grdExtraSellPriceCalcCellColors
        FooterColor = clWhite
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 0
      Width = 531
      Height = 80
      HelpContext = 810032
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 2
      ExplicitLeft = -7
      ExplicitTop = -11
      ExplicitWidth = 529
      object Label8: TLabel
        Left = 49
        Top = 29
        Width = 50
        Height = 15
        HelpContext = 810033
        Alignment = taCenter
        Caption = 'Discount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 5
        Top = 56
        Width = 95
        Height = 15
        HelpContext = 810034
        Alignment = taCenter
        Caption = 'Special Discount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 6
        Top = 3
        Width = 119
        Height = 15
        HelpContext = 810037
        Alignment = taCenter
        Caption = 'Customer'#39's Discount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object edtPermanenntdiscount: TDBEdit
        Left = 105
        Top = 25
        Width = 121
        Height = 23
        HelpContext = 810038
        DataField = 'Discount'
        DataSource = dscustomerDiscount
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtSpecialdiscount: TDBEdit
        Left = 106
        Top = 52
        Width = 121
        Height = 23
        HelpContext = 810039
        DataField = 'SpecialDiscount'
        DataSource = dscustomerDiscount
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object chkgroupdiscount: TwwCheckBox
        Left = 279
        Top = 28
        Width = 250
        Height = 16
        HelpContext = 810040
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Group Discount Overrides All Discounts'
        DataField = 'GroupDiscountOverridesAll'
        TabOrder = 2
        ReadOnly = True
      end
      object chksplPrductdiscount: TwwCheckBox
        Left = 243
        Top = 55
        Width = 287
        Height = 16
        HelpContext = 810041
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Special Product Price Overrides All Discounts'
        DataField = 'SpecialProductPriceOverridesAll'
        TabOrder = 3
        ReadOnly = True
      end
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'Localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102008000B40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object cboPartsQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID, PartName'
      'FROM tblparts '
      'WHERE Active='#39'T'#39' AND PartName Is Not Null'
      'ORDER BY PartName;')
    FetchRows = 1
    Left = 200
    Top = 56
    object cboPartsQryPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object cboPartsQryPartName: TWideStringField
      FieldName = 'PartName'
      Size = 60
    end
  end
  object QryCustomer: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT clientID, company'
      'FROM tblclients'
      'WHERE Active='#39'T'#39' AND (Customer = '#39'T'#39'  or isjob = '#39'T'#39')'
      'ORDER BY company')
    FetchRows = 1
    Left = 920
    Top = 80
    object QryCustomerclientID: TIntegerField
      FieldName = 'clientID'
    end
    object QryCustomercompany: TWideStringField
      FieldName = 'company'
      Size = 160
    end
  end
  object Qrybaseprice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select P.SellQTY1, P.price1, P.priceinc1 , '
      'P.SellQTY2, P.price2, P.priceinc2 ,'
      'P.SellQTY3, P.price3, P.priceinc3  , '
      'pt.Rate as purchaserate, '
      'st.Rate as salesrate , '
      'P.PURCHTAXCODE , P.TAXCODE'
      'from tblparts P'
      
        'Left join tbltaxcodes  pt on P.PURCHTAXCODE = pt.name  AND  pt.R' +
        'egionID= :xRegionID'
      
        'Left join tbltaxcodes st on P.TAXCODE = st.name  AND  st.RegionI' +
        'D= :xRegionID'
      'Where P.PartsId = :ProductId')
    FetchRows = 1
    Left = 176
    Top = 116
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end
      item
        DataType = ftUnknown
        Name = 'ProductId'
      end>
    object QrybasepriceSellQTY1: TIntegerField
      FieldName = 'SellQTY1'
      Origin = 'P.SellQTY1'
    end
    object Qrybasepriceprice1: TFloatField
      FieldName = 'price1'
      Origin = 'P.price1'
      currency = True
    end
    object Qrybasepricepriceinc1: TFloatField
      FieldName = 'priceinc1'
      Origin = 'P.priceinc1'
      currency = True
    end
    object QrybasepriceSellQTY2: TIntegerField
      FieldName = 'SellQTY2'
      Origin = 'P.SellQTY2'
    end
    object Qrybasepriceprice2: TFloatField
      FieldName = 'price2'
      Origin = 'P.price2'
      currency = True
    end
    object Qrybasepricepriceinc2: TFloatField
      FieldName = 'priceinc2'
      Origin = 'P.priceinc2'
      currency = True
    end
    object QrybasepriceSellQTY3: TIntegerField
      FieldName = 'SellQTY3'
      Origin = 'P.SellQTY3'
    end
    object Qrybasepriceprice3: TFloatField
      FieldName = 'price3'
      Origin = 'P.price3'
      currency = True
    end
    object Qrybasepricepriceinc3: TFloatField
      FieldName = 'priceinc3'
      Origin = 'P.priceinc3'
      currency = True
    end
    object QrybasepricePURCHTAXCODE: TWideStringField
      FieldName = 'PURCHTAXCODE'
      Origin = 'P.PURCHTAXCODE'
      Size = 11
    end
    object QrybasepriceTAXCODE: TWideStringField
      FieldName = 'TAXCODE'
      Origin = 'P.TAXCODE'
      Size = 15
    end
    object Qrybasepricepurchaserate: TFloatField
      FieldName = 'purchaserate'
    end
    object Qrybasepricesalesrate: TFloatField
      FieldName = 'salesrate'
    end
  end
  object dsbaseprice: TDataSource
    DataSet = Qrybaseprice
    Left = 176
    Top = 148
  end
  object QryCustomerSpecialPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select CL.CustomerLinesID ,C.ClientId, Company ,  CL.Lineprice '
      'from tblCustomerLines CL '
      'inner join tblclients C on C.ClientID = CL.customerId '
      
        'where ProductID = :ProductID and (CL.customerId =:CustomerID or ' +
        ':CustomerID =0)')
    FetchRows = 1
    Left = 712
    Top = 156
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end>
    object QryCustomerSpecialPriceCompany: TWideStringField
      DisplayWidth = 32
      FieldName = 'Company'
      Origin = 'C.Company'
      Size = 160
    end
    object QryCustomerSpecialPriceLineprice: TFloatField
      DisplayWidth = 10
      FieldName = 'Lineprice'
      Origin = 'CL.LinePrice'
      currency = True
    end
    object QryCustomerSpecialPriceClientId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ClientId'
      Origin = 'C.ClientID'
      Visible = False
    end
    object QryCustomerSpecialPriceCustomerLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CustomerLinesID'
      Origin = 'CL.CustomerLinesID'
      Visible = False
    end
  end
  object dsCustomerSpecialPrice: TDataSource
    DataSet = QryCustomerSpecialPrice
    Left = 712
    Top = 188
  end
  object qryExtraSellPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select ESP.PriceId, C.ClientID, ESP.PartsId, `TypeName`, `DateFr' +
        'om`,`DateTo`,concat(`UOM`,'#39'('#39',`UOMMultiplier`,'#39')'#39' ) UOM,  ESP.Qt' +
        'yPercent1 , '
      
        'P.price1 - (P.price1*ESP.QtyPercent1 /100) as `Price1` /*,ESP.`P' +
        'rice1` */ , ESP.Terms,'
      'P.AvgCost, P.LatestCost'
      'from tblextrapricesell ESP '
      'inner join tblparts P on ESP.PartsID = P.PARTSID '
      'left join tblclienttype CT on ESP.clientTypeId = CT.ClientTypeID'
      'Left join tblClients C on C.ClientTypeID = CT.ClientTypeID'
      'where ESP.`PartsID` = :ProductId '
      
        'and (C.ClientID =:CustomerId or :CustomerId =0 or  ifnull(C.Clie' +
        'ntID,0)=0 )'
      'and (ESP.Terms =:Terms or :Terms ='#39#39' or ifnull(ESP.Terms,'#39#39')='#39#39')')
    FetchRows = 1
    Left = 816
    Top = 356
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerId'
      end
      item
        DataType = ftUnknown
        Name = 'Terms'
      end
      item
        DataType = ftUnknown
        Name = 'Terms'
      end>
    object qryExtraSellPriceTerms: TWideStringField
      DisplayWidth = 8
      FieldName = 'Terms'
      Origin = 'ESP.Terms'
      Size = 100
    end
    object qryExtraSellPriceTypeName: TWideStringField
      DisplayLabel = 'Customer type'
      DisplayWidth = 10
      FieldName = 'TypeName'
      Origin = 'CT.TypeName'
      Size = 50
    end
    object qryExtraSellPriceDateFrom: TDateField
      DisplayLabel = 'Date From'
      DisplayWidth = 10
      FieldName = 'DateFrom'
      Origin = 'ESP.DateFrom'
    end
    object qryExtraSellPriceDateTo: TDateField
      DisplayLabel = 'Date To'
      DisplayWidth = 10
      FieldName = 'DateTo'
      Origin = 'ESP.DateTo'
    end
    object qryExtraSellPriceUOM: TWideStringField
      DisplayWidth = 9
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 100
    end
    object qryExtraSellPriceQtyPercent1: TFloatField
      DisplayLabel = 'Discount %'
      DisplayWidth = 8
      FieldName = 'QtyPercent1'
      Origin = 'ESP.QtyPercent1'
      DisplayFormat = '##0.00'
    end
    object qryExtraSellPricePrice1: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 8
      FieldName = 'Price1'
      Origin = 'Price1'
      currency = True
    end
    object qryExtraSellPriceAvgCost: TFloatField
      DisplayLabel = 'Avg Cost'
      DisplayWidth = 10
      FieldName = 'AvgCost'
    end
    object qryExtraSellPriceLatestCost: TFloatField
      DisplayLabel = 'Latest Cost'
      DisplayWidth = 10
      FieldName = 'LatestCost'
    end
    object qryExtraSellPriceClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'C.ClientID'
      Visible = False
    end
    object qryExtraSellPricePartsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'ESP.PartsID'
      Visible = False
    end
    object qryExtraSellPricePriceId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PriceId'
      Origin = 'ESP.PriceID'
      Visible = False
    end
  end
  object dsExtraSellPrice: TDataSource
    DataSet = qryExtraSellPrice
    Left = 816
    Top = 384
  end
  object qryprodgroupdiscs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select GrpDiscID, clientId, col1,col2,col3,discount from tblprod' +
        'groupdiscs GD where clientId =:ProductID')
    FetchRows = 1
    AfterOpen = qryprodgroupdiscsAfterOpen
    Left = 168
    Top = 340
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object qryprodgroupdiscscol1: TWideStringField
      DisplayWidth = 16
      FieldName = 'col1'
      Origin = 'GD.Col1'
      Size = 125
    end
    object qryprodgroupdiscscol2: TWideStringField
      DisplayWidth = 15
      FieldName = 'col2'
      Origin = 'GD.Col2'
      Size = 125
    end
    object qryprodgroupdiscscol3: TWideStringField
      DisplayWidth = 15
      FieldName = 'col3'
      Origin = 'GD.Col3'
      Size = 125
    end
    object qryprodgroupdiscsdiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'discount'
      Origin = 'GD.Discount'
    end
    object qryprodgroupdiscsclientId: TIntegerField
      DisplayWidth = 10
      FieldName = 'clientId'
      Origin = 'GD.ClientID'
      Visible = False
    end
    object qryprodgroupdiscsGrpDiscID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'GrpDiscID'
      Origin = 'GD.GrpDiscID'
      Visible = False
    end
  end
  object dsprodgroupdiscs: TDataSource
    DataSet = qryprodgroupdiscs
    Left = 168
    Top = 312
  end
  object qrycustomerDiscount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select C.ClientId, Company ,  Concat(C.discount*100,'#39'%'#39') as Disc' +
        'ount, '
      'concat( C.specialDiscount*100 ,'#39'%'#39') as SpecialDiscount, '
      'C.GroupDiscountOverridesAll , C.SpecialProductPriceOverridesAll'
      'from  tblclients C '
      'where (ifnull(Discount,0)<> 0 or ifnull(Specialdiscount,0)<> 0)'
      'and ClientId = :CustomerID')
    FetchRows = 1
    Left = 712
    Top = 236
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end>
    object qrycustomerDiscountClientId: TIntegerField
      FieldName = 'ClientId'
    end
    object qrycustomerDiscountCompany: TWideStringField
      FieldName = 'Company'
      Size = 160
    end
    object qrycustomerDiscountDiscount: TWideStringField
      FieldName = 'Discount'
      Size = 24
    end
    object qrycustomerDiscountSpecialDiscount: TWideStringField
      FieldName = 'SpecialDiscount'
      Size = 24
    end
    object qrycustomerDiscountGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qrycustomerDiscountSpecialProductPriceOverridesAll: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
  end
  object dscustomerDiscount: TDataSource
    DataSet = qrycustomerDiscount
    Left = 712
    Top = 268
  end
  object QryPriceMatrix: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select  ID, EntryValueRef, Price    from tblpartspriceentry wher' +
        'e productId = :ProductId')
    FetchRows = 1
    OnCalcFields = QryPriceMatrixCalcFields
    Left = 352
    Top = 140
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object QryPriceMatrixEntryValueDesc: TStringField
      DisplayLabel = 'Entry Value Desc'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'EntryValueDesc'
      Size = 255
      Calculated = True
    end
    object QryPriceMatrixPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      Origin = 'tblpartspriceentry.Price'
      currency = True
    end
    object QryPriceMatrixEntryValueRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'EntryValueRef'
      Origin = 'tblpartspriceentry.EntryValueRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object QryPriceMatrixID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblpartspriceentry.ID'
      Visible = False
    end
  end
  object dsPriceMatrix: TDataSource
    DataSet = QryPriceMatrix
    Left = 352
    Top = 172
  end
  object dsUnitOfMeasure: TDataSource
    DataSet = qryUnitOfMeasure
    Left = 160
    Top = 468
  end
  object qryUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName  , Pa' +
        'rts.Price1*U.Multiplier Price1, Parts.Price2*U.Multiplier Price2' +
        ', Parts.Price3*U.Multiplier Price3 '
      
        'FROM tblunitsofmeasure U  inner join tblparts Parts on Parts.par' +
        'tsId = U.partID'
      ''
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, Part' +
        's.Price1*U.Multiplier Price1, Parts.Price2*U.Multiplier Price2, ' +
        'Parts.Price3*U.Multiplier Price3 '
      
        'FROM tblunitsofmeasure U ,  (Select PRICE1, PRICE2, PRICE3 from ' +
        'tblparts where PArtsId  = :xPartID) Parts '
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By Multiplier;')
    Left = 128
    Top = 466
    ParamData = <
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end>
    object qryUnitOfMeasureUnitName: TWideStringField
      DisplayWidth = 15
      FieldName = 'UnitName'
      Origin = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
      Origin = 'Multiplier'
    end
    object qryUnitOfMeasureUnitID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitID'
      Origin = 'UnitID'
      Visible = False
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      DisplayWidth = 35
      FieldName = 'UnitDescription'
      Origin = 'UnitDescription'
      Visible = False
      Size = 35
    end
    object qryUnitOfMeasureBaseUnitName: TWideStringField
      DisplayWidth = 15
      FieldName = 'BaseUnitName'
      Origin = 'BaseUnitName'
      Visible = False
      Size = 15
    end
    object qryUnitOfMeasurePrice1: TFloatField
      DisplayWidth = 10
      FieldName = 'Price1'
      currency = True
    end
    object qryUnitOfMeasurePrice2: TFloatField
      DisplayWidth = 10
      FieldName = 'Price2'
      currency = True
    end
    object qryUnitOfMeasurePrice3: TFloatField
      DisplayWidth = 10
      FieldName = 'Price3'
      currency = True
    end
  end
  object qrypartsforexcelprice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select convert(0.0,DECIMAL)  as Price, convert("T", char(10)) as' +
        ' Ovirrides')
    Left = 176
    Top = 522
    object qrypartsforexcelpricePrice: TFloatField
      FieldName = 'Price'
      currency = True
    end
    object qrypartsforexcelpriceOvirrides: TWideStringField
      FieldName = 'Ovirrides'
      Size = 10
    end
  end
  object dspartsforexcelprice: TDataSource
    DataSet = qrypartsforexcelprice
    Left = 208
    Top = 524
  end
end
