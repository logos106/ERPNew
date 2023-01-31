inherited fmsaleslineManufactureSummary: TfmsaleslineManufactureSummary
  Left = 774
  Top = 272
  HelpContext = 1019002
  Caption = 'Manufacture Summary '
  ClientHeight = 562
  ClientWidth = 959
  Position = poMainFormCenter
  ExplicitLeft = 774
  ExplicitTop = 272
  ExplicitWidth = 975
  ExplicitHeight = 601
  DesignSize = (
    959
    562)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 496
    Width = 959
    HelpContext = 1019003
    ExplicitTop = 496
    ExplicitWidth = 959
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 178
    Width = 959
    Height = 318
    HelpContext = 1019028
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label10: TLabel
      Left = 10
      Top = 10
      Width = 307
      Height = 16
      HelpContext = 1019029
      Caption = 'Tree Items with Quantity and Quantity Allocation'
      Color = 11468799
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object grdMain: TwwDBGrid
      Left = 1
      Top = 36
      Width = 957
      Height = 281
      HelpContext = 1019030
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 12
      ControlType.Strings = (
        'Tree;CustomEdit;DBMemo1;F'
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'caption'#9'28'#9'Item'#9'F'
        'uom'#9'10'#9'UOM'#9#9
        'TreePartUOMtotalQty'#9'10'#9'Total'#9'F'#9'Transaction Quantity'
        'FromStockUOMQty'#9'12'#9'From Stock'#9'F'#9'Transaction Quantity'
        'ManufactureUOMQty'#9'12'#9'Manufacturing'#9'F'#9'Transaction Quantity'
        'OnOrderUOMQty'#9'12'#9'On Order'#9'F'#9'Transaction Quantity'
        'AvailableQty'#9'12'#9'Available'#9'F'#9'Product Quantity'
        'InstockQty'#9'12'#9'In Stock'#9'F'#9'Product Quantity')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.SaveToRegistry = True
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alBottom
      Color = clWhite
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
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
      TitleLines = 2
      TitleButtons = True
      UseTFields = False
      LineColors.GroupingColor = clSilver
      OnCalcCellColors = grdMainCalcCellColors
      OnDblClick = grdMainDblClick
      FooterColor = clWhite
      FooterCellColor = clWhite
      ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
      PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
    end
    object grpFilters: TwwRadioGroup
      Left = 408
      Top = -8
      Width = 519
      Height = 46
      HelpContext = 1019031
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      DisableThemes = False
      ItemIndex = 0
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'All'
        'From Stock'
        'Manufacturing'
        'On Order')
      ParentFont = False
      TabOrder = 1
      OnClick = grpFiltersClick
    end
  end
  object DNMPanel4: TDNMPanel [6]
    Left = 0
    Top = 496
    Width = 959
    Height = 66
    HelpContext = 1019032
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      959
      66)
    object Label8: TLabel
      Left = 1
      Top = 46
      Width = 957
      Height = 19
      HelpContext = 1019033
      Align = alBottom
      Alignment = taCenter
      Caption = 'Sub '#39'builds'#39'  must complete before it'#39's parent '#39'build'#39' commences'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitWidth = 504
    end
    object cmdClose: TDNMSpeedButton
      Left = 603
      Top = 7
      Width = 87
      Height = 27
      Hint = 'Close this form'
      HelpContext = 1019034
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Close'
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
      ModalResult = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
    end
    object btnEdit: TDNMSpeedButton
      Left = 256
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 1019036
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Edit'
      Default = True
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
    end
    object btnPrint: TDNMSpeedButton
      Left = 429
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 1019037
      Anchors = [akTop, akRight]
      Caption = '&Print'
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
      TabOrder = 2
      TabStop = False
      OnClick = btnPrintClick
    end
    object pnlChooseRpt: TDNMPanel
      Left = 772
      Top = 35
      Width = 185
      Height = 26
      HelpContext = 1019038
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object chkChooseRpt: TCheckBox
        Left = 38
        Top = 2
        Width = 142
        Height = 20
        HelpContext = 1019039
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Choose Template'
        TabOrder = 0
      end
    end
    object pnlHide: TDNMPanel
      Left = 772
      Top = 3
      Width = 185
      Height = 27
      HelpContext = 1019040
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object chkHide: TCheckBox
        Left = 7
        Top = 1
        Width = 173
        Height = 24
        HelpContext = 1019035
        Alignment = taLeftJustify
        Caption = 'Don'#39't Show Next Time'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chkHideClick
      end
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 959
    Height = 70
    HelpContext = 1019004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      959
      70)
    object pnlHeader: TPanel
      Left = 197
      Top = 8
      Width = 569
      Height = 57
      HelpContext = 1019005
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 567
        Height = 55
        HelpContext = 1019006
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
          Width = 567
          Height = 55
          HelpContext = 1019007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Manufacture Summary '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -40
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitHeight = 54
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [8]
    Left = 0
    Top = 70
    Width = 959
    Height = 108
    HelpContext = 1019008
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 5
      Width = 191
      Height = 16
      HelpContext = 1019011
      Caption = 'Manufacturing Product Details'
      Color = 11468799
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 62
      Top = 69
      Width = 94
      Height = 16
      HelpContext = 1019012
      Caption = 'Product  Name'
      Transparent = True
    end
    object Label9: TLabel
      Left = 114
      Top = 37
      Width = 46
      Height = 16
      HelpContext = 1019021
      Caption = 'Sale ID'
      Transparent = True
    end
    object wwDBEdit1: TwwDBEdit
      Left = 165
      Top = 65
      Width = 223
      Height = 24
      HelpContext = 1019022
      DataField = 'productname'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit6: TwwDBEdit
      Left = 165
      Top = 32
      Width = 70
      Height = 24
      HelpContext = 1019027
      DataField = 'SAleID'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object pnlsalesQty: TDNMPanel
      Left = 429
      Top = 1
      Width = 529
      Height = 106
      HelpContext = 1019041
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        529
        106)
      object Bevel3: TBevel
        Left = 11
        Top = 29
        Width = 506
        Height = 74
        HelpContext = 1019009
        Anchors = [akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitLeft = 408
      end
      object Bevel1: TBevel
        Left = 114
        Top = 29
        Width = 2
        Height = 74
        HelpContext = 1019010
        Anchors = [akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitLeft = 511
      end
      object Label3: TLabel
        Left = 8
        Top = 7
        Width = 92
        Height = 16
        HelpContext = 1019013
        Alignment = taRightJustify
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Sales Quantity'
        Transparent = True
        ExplicitLeft = 405
      end
      object Label4: TLabel
        Left = 317
        Top = 37
        Width = 30
        Height = 16
        HelpContext = 1019014
        Anchors = [akTop, akRight, akBottom]
        Caption = 'UOM'
        Transparent = True
        ExplicitLeft = 714
      end
      object Label5: TLabel
        Left = 24
        Top = 37
        Width = 52
        Height = 16
        HelpContext = 1019015
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Ordered'
        Transparent = True
        ExplicitLeft = 421
      end
      object Label6: TLabel
        Left = 120
        Top = 37
        Width = 53
        Height = 16
        HelpContext = 1019016
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Shipped'
        Transparent = True
        ExplicitLeft = 517
      end
      object Label7: TLabel
        Left = 221
        Top = 37
        Width = 71
        Height = 16
        HelpContext = 1019017
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Back Order'
        Transparent = True
        ExplicitLeft = 618
      end
      object Bevel2: TBevel
        Left = 11
        Top = 57
        Width = 506
        Height = 2
        HelpContext = 1019018
        Anchors = [akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitLeft = 408
      end
      object Bevel4: TBevel
        Left = 309
        Top = 29
        Width = 2
        Height = 74
        HelpContext = 1019019
        Anchors = [akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitLeft = 706
      end
      object Bevel5: TBevel
        Left = 216
        Top = 29
        Width = 2
        Height = 74
        HelpContext = 1019020
        Anchors = [akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitLeft = 613
      end
      object wwDBEdit2: TwwDBEdit
        Left = 317
        Top = 65
        Width = 192
        Height = 24
        HelpContext = 1019023
        Anchors = [akTop, akRight, akBottom]
        DataField = 'Salesuom'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitLeft = 714
      end
      object wwDBEdit3: TwwDBEdit
        Left = 24
        Top = 65
        Width = 83
        Height = 24
        HelpContext = 1019024
        Anchors = [akTop, akRight, akBottom]
        DataField = 'UnitofMeasureQtySold'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitLeft = 421
      end
      object wwDBEdit4: TwwDBEdit
        Left = 120
        Top = 65
        Width = 83
        Height = 24
        HelpContext = 1019025
        Anchors = [akTop, akRight, akBottom]
        DataField = 'UnitofMeasureShipped'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitLeft = 517
      end
      object wwDBEdit5: TwwDBEdit
        Left = 221
        Top = 65
        Width = 84
        Height = 24
        HelpContext = 1019026
        Anchors = [akTop, akRight, akBottom]
        DataField = 'UnitofMeasureBackorder'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitLeft = 618
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009000BC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryMain: TERPQuery
    SQL.Strings = (
      'sELECT '
      'Sl.SAleID, '
      'PT.PartsId, '
      'SL.productname, '
      
        'concat(SL.UnitofMeasureSaleLines, '#39' ('#39' , SL.UnitofMeasureMultipl' +
        'ier ,'#39')'#39' ) Salesuom,  SL.UnitofMeasureQtySold , SL.UnitofMeasure' +
        'Shipped , SL.UnitofMeasureBackorder,'
      
        'Convert(TreeNodeCaption(Level, caption ),char(255))  as caption,' +
        '  '
      
        'concat(TreePartUOM, '#39' ('#39' , treePartUOMMultiplier ,'#39')'#39' ) uom, Tre' +
        'ePartUOMtotalQty,  ManufactureUOMQty, FromStockUOMQty, OnOrderUO' +
        'MQty '
      
        ' from tblsaleslines SL inner join  tblproctree PT on PT.masterId' +
        ' = SL.saleLineId and PT.masterType <> '#39'mtProduct'#39' '
      ' where masterId = :saleLineId')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 97
    Top = 242
    ParamData = <
      item
        DataType = ftWord
        Name = 'saleLineId'
        Value = 3
      end>
    object qryMaincaption: TWideStringField
      DisplayLabel = 'Item'
      DisplayWidth = 50
      FieldName = 'caption'
      Origin = 'caption'
      Size = 255
    end
    object qryMainuom: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 125
    end
    object qryMainTreePartUOMtotalQty: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 10
      FieldName = 'TreePartUOMtotalQty'
      Origin = 'PT.TreePartUOMtotalQty'
    end
    object qryMainFromStockUOMQty: TFloatField
      DisplayLabel = 'From Stock'
      DisplayWidth = 10
      FieldName = 'FromStockUOMQty'
      Origin = 'PT.FromStockUOMQty'
    end
    object qryMainInstockQty: TFloatField
      DisplayLabel = 'Instock Qty'
      DisplayWidth = 10
      FieldName = 'InstockQty'
    end
    object qryMainAvailableQty: TFloatField
      DisplayLabel = 'Available Qty'
      DisplayWidth = 10
      FieldName = 'AvailableQty'
    end
    object qryMainManufactureUOMQty: TFloatField
      DisplayLabel = 'Manufacturing'
      DisplayWidth = 10
      FieldName = 'ManufactureUOMQty'
      Origin = 'PT.ManufactureUOMQty'
    end
    object qryMainOnOrderUOMQty: TFloatField
      DisplayLabel = 'On Order'
      DisplayWidth = 10
      FieldName = 'OnOrderUOMQty'
      Origin = 'PT.OnOrderUOMQty'
    end
    object qryMainproductname: TWideStringField
      FieldName = 'productname'
      Origin = 'SL.productname'
      Visible = False
      Size = 60
    end
    object qryMainSalesuom: TWideStringField
      FieldName = 'Salesuom'
      Origin = 'Salesuom'
      Visible = False
      Size = 280
    end
    object qryMainUnitofMeasureQtySold: TFloatField
      FieldName = 'UnitofMeasureQtySold'
      Origin = 'SL.UnitofMeasureQtySold'
      Visible = False
    end
    object qryMainUnitofMeasureShipped: TFloatField
      FieldName = 'UnitofMeasureShipped'
      Origin = 'SL.UnitofMeasureShipped'
      Visible = False
    end
    object qryMainUnitofMeasureBackorder: TFloatField
      FieldName = 'UnitofMeasureBackorder'
      Origin = 'SL.UnitofMeasureBackorder'
      Visible = False
    end
    object qryMainSAleID: TIntegerField
      FieldName = 'SAleID'
    end
    object qryMainPartsId: TIntegerField
      FieldName = 'PartsId'
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 136
    Top = 242
  end
end
