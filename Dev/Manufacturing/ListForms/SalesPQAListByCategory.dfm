inherited SalesPQAListByCategoryGUI: TSalesPQAListByCategoryGUI
  Left = 355
  Caption = 'Sales PQA List By Category'
  ExplicitLeft = 355
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1453002
  inherited HeaderPanel: TPanel
    HelpContext = 1453030
    inherited dtFrom: TwwDBDateTimePicker
      Height = 22
      ExplicitHeight = 22
      HelpContext = 1453003
    end
    inherited dtTo: TwwDBDateTimePicker
      Height = 22
      ExplicitHeight = 22
      HelpContext = 1453004
    end
  end
  inherited Panel1: TPanel
    HelpContext = 1453031
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'SaleId'#9'10'#9'Sale #'
        'CustomerNAme'#9'20'#9'Customer'
        'productname'#9'20'#9'Product'
        'SaleDate'#9'10'#9'Sale Date'
        'UOM'#9'20'#9'UOM')
    end
    object PageMain: TPageControl
      Left = 0
      Top = 132
      Width = 996
      Height = 193
      ActivePage = TabSheet6
      Align = alBottom
      TabOrder = 2
      HelpContext = 1453005
      object TabSheet1: TTabSheet
        Caption = 'TSalesOrderLine  -  OUT'
        HelpContext = 1453006
        object lblTabSheet1: TLabel
          Left = 0
          Top = 0
          Width = 988
          Height = 19
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 4
          HelpContext = 1453007
        end
        object grdSalesOrderLineOUT: TwwDBGrid
          Left = 0
          Top = 19
          Width = 988
          Height = 144
          ControlType.Strings = (
            'active;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'Product'
            'transdate'#9'10'#9'Date'
            'UOMQty'#9'10'#9'Qty'
            'uom'#9'10'#9'uom'
            'active'#9'5'#9'Active'
            'batchno'#9'10'#9'No'
            'batchQty'#9'10'#9'Qty'
            'BinLocation'#9'10'#9'Location'
            'BinNumber'#9'10'#9'Number'
            'binQty'#9'10'#9'Qty'
            'Serialnumber'#9'10'#9'Serial~Number')
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
          DataSource = dsSalesOrderLineOUT
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = mnuFilter
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
          LineColors.GroupingColor = clSilver
          TitleImageList = imgPopup
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          ExplicitTop = 0
          ExplicitHeight = 163
          HelpContext = 1453008
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
            HelpContext = 1453009
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TProcTreePart  -  OUT'
        ImageIndex = 1
        HelpContext = 1453010
        object lblTabsheet2: TLabel
          Left = 0
          Top = 0
          Width = 988
          Height = 19
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 4
          HelpContext = 1453011
        end
        object wwDBGrid1: TwwDBGrid
          Left = 0
          Top = 19
          Width = 988
          Height = 144
          ControlType.Strings = (
            'active;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'Product'#9#9
            'transdate'#9'10'#9'Date'#9#9
            'UOMQty'#9'10'#9'Qty'#9#9
            'uom'#9'10'#9'uom'#9#9
            'active'#9'5'#9'Active'#9#9
            'batchno'#9'10'#9'No'#9'F'#9'Batch'
            'batchQty'#9'10'#9'Qty'#9'F'#9'Batch'
            'BinLocation'#9'10'#9'Location'#9'F'#9'Bin'
            'BinNumber'#9'10'#9'Number'#9'F'#9'Bin'
            'binQty'#9'10'#9'Qty'#9'F'#9'Bin'
            'Serialnumber'#9'10'#9'Serial~Number'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          OnMultiSelectAllRecords = grdMainMultiSelectAllRecords
          OnMultiSelectRecord = grdMainMultiSelectRecord
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          DataSource = dsProcTreePartOUT
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = mnuFilter
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
          TitleImageList = imgPopup
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          ExplicitTop = 0
          ExplicitHeight = 163
          HelpContext = 1453012
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
            HelpContext = 1453013
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'TProcTreePart  -  IN'
        ImageIndex = 2
        HelpContext = 1453014
        object lblTabSheet3: TLabel
          Left = 0
          Top = 0
          Width = 988
          Height = 19
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 4
          HelpContext = 1453015
        end
        object wwDBGrid2: TwwDBGrid
          Left = 0
          Top = 19
          Width = 988
          Height = 144
          ControlType.Strings = (
            'active;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'Product'#9#9
            'transdate'#9'10'#9'Date'#9#9
            'UOMQty'#9'10'#9'Qty'#9#9
            'uom'#9'10'#9'uom'#9#9
            'transtype'#9'10'#9'Trans Type'#9'F'
            'active'#9'5'#9'Active'#9#9
            'batchno'#9'10'#9'No'#9'F'#9'Batch'
            'batchQty'#9'10'#9'Qty'#9'F'#9'Batch'
            'BinLocation'#9'10'#9'Location'#9'F'#9'Bin'
            'BinNumber'#9'10'#9'Number'#9'F'#9'Bin'
            'binQty'#9'10'#9'Qty'#9'F'#9'Bin'
            'Serialnumber'#9'10'#9'Serial~Number'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          OnMultiSelectAllRecords = grdMainMultiSelectAllRecords
          OnMultiSelectRecord = grdMainMultiSelectRecord
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          DataSource = dsProcTreePartIN
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = mnuFilter
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
          TitleImageList = imgPopup
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          ExplicitTop = -2
          ExplicitHeight = 163
          HelpContext = 1453016
          object wwIButton3: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
            HelpContext = 1453017
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'TProcProgressIn  -  IN'
        ImageIndex = 3
        HelpContext = 1453018
        object lblTabsheet4: TLabel
          Left = 0
          Top = 0
          Width = 988
          Height = 19
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 4
          HelpContext = 1453019
        end
        object wwDBGrid3: TwwDBGrid
          Left = 0
          Top = 19
          Width = 988
          Height = 144
          ControlType.Strings = (
            'active;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'Product'#9#9
            'transdate'#9'10'#9'Date'#9#9
            'UOMQty'#9'10'#9'Qty'#9#9
            'uom'#9'10'#9'uom'#9#9
            'active'#9'5'#9'Active'#9#9
            'batchno'#9'10'#9'No'#9'F'#9'Batch'
            'batchQty'#9'10'#9'Qty'#9'F'#9'Batch'
            'BinLocation'#9'10'#9'Location'#9'F'#9'Bin'
            'BinNumber'#9'10'#9'Number'#9'F'#9'Bin'
            'binQty'#9'10'#9'Qty'#9'F'#9'Bin'
            'Serialnumber'#9'10'#9'Serial~Number'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          OnMultiSelectAllRecords = grdMainMultiSelectAllRecords
          OnMultiSelectRecord = grdMainMultiSelectRecord
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          DataSource = dsProcProgressInIN
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = mnuFilter
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
          TitleImageList = imgPopup
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          ExplicitTop = 0
          ExplicitHeight = 163
          HelpContext = 1453020
          object wwIButton4: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
            HelpContext = 1453021
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'TProcProgressOUT  -  OUT'
        ImageIndex = 4
        HelpContext = 1453022
        object lblTabsheet5: TLabel
          Left = 0
          Top = 0
          Width = 988
          Height = 19
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 4
          HelpContext = 1453023
        end
        object wwDBGrid4: TwwDBGrid
          Left = 0
          Top = 19
          Width = 988
          Height = 144
          ControlType.Strings = (
            'active;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'Product'#9#9
            'transdate'#9'10'#9'Date'#9#9
            'UOMQty'#9'10'#9'Qty'#9#9
            'uom'#9'10'#9'uom'#9#9
            'active'#9'5'#9'Active'#9#9
            'batchno'#9'10'#9'No'#9'F'#9'Batch'
            'batchQty'#9'10'#9'Qty'#9'F'#9'Batch'
            'BinLocation'#9'10'#9'Location'#9'F'#9'Bin'
            'BinNumber'#9'10'#9'Number'#9'F'#9'Bin'
            'binQty'#9'10'#9'Qty'#9'F'#9'Bin'
            'Serialnumber'#9'10'#9'Serial~Number'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          OnMultiSelectAllRecords = grdMainMultiSelectAllRecords
          OnMultiSelectRecord = grdMainMultiSelectRecord
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          DataSource = dsProcProgressOUT
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = mnuFilter
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
          TitleImageList = imgPopup
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          ExplicitTop = 0
          ExplicitHeight = 163
          HelpContext = 1453024
          object wwIButton5: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
            HelpContext = 1453025
          end
        end
      end
      object TabSheet6: TTabSheet
        Caption = 'All Others'
        ImageIndex = 5
        HelpContext = 1453026
        object lblTabsheet6: TLabel
          Left = 0
          Top = 0
          Width = 988
          Height = 19
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 4
          HelpContext = 1453027
        end
        object wwDBGrid5: TwwDBGrid
          Left = 0
          Top = 19
          Width = 988
          Height = 144
          ControlType.Strings = (
            'active;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'14'#9'Product'#9'F'
            'transdate'#9'10'#9'Date'#9#9
            'UOMQty'#9'10'#9'Qty'#9#9
            'uom'#9'10'#9'uom'#9#9
            'transtype'#9'10'#9'Trans Type'#9'F'
            'alloctype'#9'3'#9'Alloc Type'#9'F'
            'active'#9'5'#9'Active'#9#9
            'batchno'#9'10'#9'No'#9'F'#9'Batch'
            'batchQty'#9'10'#9'Qty'#9'F'#9'Batch'
            'BinLocation'#9'10'#9'Location'#9'F'#9'Bin'
            'BinNumber'#9'10'#9'Number'#9'F'#9'Bin'
            'binQty'#9'10'#9'Qty'#9'F'#9'Bin'
            'Serialnumber'#9'10'#9'Serial~Number'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          OnMultiSelectAllRecords = grdMainMultiSelectAllRecords
          OnMultiSelectRecord = grdMainMultiSelectRecord
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          BorderStyle = bsNone
          Color = clWhite
          DataSource = dsAllOthers
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = mnuFilter
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
          TitleImageList = imgPopup
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          ExplicitTop = 0
          ExplicitHeight = 163
          HelpContext = 1453028
          object wwIButton6: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
            HelpContext = 1453029
          end
        end
      end
    end
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C01010800A003180410001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000FFFFFF000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF007F7F7F00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF007F7F7F0000FFFF00FFFFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF00FFFFFF007F7F7F00FFFFFF0000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000FF000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000000000FF000000FF000000FF000000000000FF000000FF00
      0000FF0000007F7F7F0000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF0000FFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      FF000000000000FF000000FF000000FF000000FF000000FF000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008080000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000808000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000808000008080000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FDFF8000FEFFFFFFF8FF8000FC7FF83F
      F8FFC000FC7F1010F87FE000D837E00FF81FF000E00FC007F80FF800E00F8003
      F00FFC00C0078003E00F0600C0078003E00F070000018003E00F0180C0078003
      F01F0180C007C007F00F0060E00FE00FF00FC060E00F3018F007C060D837F83F
      F007F044FEFFFFFFF007F07EFEFFFFFFFFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select'
      'S.saleId as SaleId, '
      'S.customerName as CustomerNAme, '
      'SL.productname as productname, '
      
        'concat(SL.UnitofMeasureSaleLines , '#39'('#39' , SL.UnitofMeasureMultipl' +
        'ier , '#39')'#39') as UOM , '
      'S.SaleDate as SaleDate'
      'from tblsales S'
      'inner join tblsaleslines SL  on S.saleId = Sl.saleId '
      'Where SL.saleLineId = :saleLineId')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'saleLineId'
      end>
    object qryMainSaleId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Sale #'
      DisplayWidth = 10
      FieldName = 'SaleId'
      Origin = 'S.SaleID'
    end
    object qryMainCustomerNAme: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 20
      FieldName = 'CustomerNAme'
      Origin = 'S.CustomerName'
      Size = 255
    end
    object qryMainproductname: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'productname'
      Origin = 'SL.ProductName'
      Size = 60
    end
    object qryMainSaleDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 10
      FieldName = 'SaleDate'
      Origin = 'S.SaleDate'
    end
    object qryMainUOM: TWideStringField
      DisplayWidth = 20
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 279
    end
  end
  inherited MyConnection1: TERPConnection
    Server = 'localhost'
  end
  object qrySalesOrderLineOUT: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      
        'distinct pqa.pqaid , pqa.ProductName,  pqa.transdate, pqa.UOMQty' +
        ' , concat(pqa.UOM, '#39'('#39' , pqa.UOMMultiplier , '#39')'#39') as uom, pqa.ac' +
        'tive, '
      'pqabatch.Value as batchno, pqabatch.UOMQty batchQty,'
      'pbin.BinLocation , pbin.BinNumber , pqabin.UOMQty binQty,'
      'pqasn.Value as Serialnumber'
      'from tblpqa pqa'
      'inner join tblparts p on pqa.productId = p.partsId'
      
        'Left join tblpqadetails pqabatch on  pqabatch.pqaid = pqa.pqaid ' +
        'and pqabatch.PQAType ='#39'BATCH'#39' and P.batch ="T"'
      
        'Left join (tblpqadetails pqabin inner join tblproductbin as pbin' +
        ' on pbin.BinID = pqabin.BinID)on  pqabin.pqaid = pqa.pqaid and p' +
        'qabin.PQAType ='#39'BIN'#39' and p.MultipleBins="T" and '#9
      
        '((P.batch ="F"'#9' and ifnull(pqabin.ParentRef, '#39#39')='#39#39') or (P.batch' +
        ' ="T"'#9' and ifnull(pqabin.ParentRef, '#39#39')=pqabatch.GlobalRef) )'
      
        'Left join tblpqadetails pqasn on  pqasn.pqaid = pqa.pqaid and pq' +
        'asn.PQAType ='#39'SN'#39' and p.SNTracking="T" '
      
        'and '#9'((P.batch ="F"'#9' and P.multipleBins="F" and  ifnull(pqasn.Pa' +
        'rentRef, '#39#39')='#39#39') '
      
        #9'or (P.multipleBins ="T"'#9' and ifnull(pqasn.ParentRef, '#39#39')=pqabin' +
        '.GlobalRef) '
      
        #9'or (P.multipleBins ="F"'#9'and P.batch ="T"'#9' and ifnull(pqasn.Pare' +
        'ntRef, '#39#39')=pqabatch.GlobalRef) )'
      
        #9'Where pqa.translineID = :SaleLineId and pqa.transtype = '#39'TSales' +
        'OrderLine'#39' and pqa.alloctype ='#39'OUT'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 123
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleLineId'
      end>
    object qrySalesOrderLineOUTProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'pqa.ProductName'
      Size = 100
    end
    object qrySalesOrderLineOUTtransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'transdate'
      Origin = 'pqa.TransDate'
    end
    object qrySalesOrderLineOUTUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'pqa.UOMQty'
    end
    object qrySalesOrderLineOUTuom: TWideStringField
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 74
    end
    object qrySalesOrderLineOUTactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
      Origin = 'pqa.Active'
      FixedChar = True
      Size = 1
    end
    object qrySalesOrderLineOUTbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'pqabatch.Value'
      Size = 100
    end
    object qrySalesOrderLineOUTbatchQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'batchQty'
      Origin = 'pqabatch.UOMQty'
    end
    object qrySalesOrderLineOUTBinLocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'pbin.BinLocation'
      Size = 30
    end
    object qrySalesOrderLineOUTBinNumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'pbin.BinNumber'
      Size = 30
    end
    object qrySalesOrderLineOUTbinQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binQty'
      Origin = 'pqabin.UOMQty'
    end
    object qrySalesOrderLineOUTSerialnumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'pqasn.Value'
      Size = 100
    end
    object qrySalesOrderLineOUTpqaid: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'pqaid'
      Origin = 'pqa.PQAID'
      Visible = False
    end
  end
  object dsSalesOrderLineOUT: TDataSource
    DataSet = qrySalesOrderLineOUT
    Left = 124
    Top = 319
  end
  object QryProcTreePartOUT: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      
        'distinct pqa.pqaid , pqa.ProductName,  pqa.transdate, pqa.UOMQty' +
        ' , concat(pqa.UOM, '#39'('#39' , pqa.UOMMultiplier , '#39')'#39') as uom, pqa.ac' +
        'tive, '
      'pqabatch.Value as batchno, pqabatch.UOMQty batchQty,'
      'pbin.BinLocation , pbin.BinNumber , pqabin.UOMQty binQty,'
      'pqasn.Value as Serialnumber'
      'from tblpqa pqa'
      
        ' inner join tblproctreepart ptp on pqa.translineId = ptp.ProcTre' +
        'ePartId'
      
        ' inner join tblproctree pt on pt.ProcTreeId = ptp.ProcTreeId and' +
        ' pt.MasterType <> '#39'mtProduct'#39
      ''
      'inner join tblparts p on pqa.productId = p.partsId'
      
        'Left join tblpqadetails pqabatch on  pqabatch.pqaid = pqa.pqaid ' +
        'and pqabatch.PQAType ='#39'BATCH'#39' and P.batch ="T"'
      
        'Left join (tblpqadetails pqabin inner join tblproductbin as pbin' +
        ' on pbin.BinID = pqabin.BinID)on  pqabin.pqaid = pqa.pqaid and p' +
        'qabin.PQAType ='#39'BIN'#39' and p.MultipleBins="T" and '#9
      
        '((P.batch ="F"'#9' and ifnull(pqabin.ParentRef, '#39#39')='#39#39') or (P.batch' +
        ' ="T"'#9' and ifnull(pqabin.ParentRef, '#39#39')=pqabatch.GlobalRef) )'
      
        'Left join tblpqadetails pqasn on  pqasn.pqaid = pqa.pqaid and pq' +
        'asn.PQAType ='#39'SN'#39' and p.SNTracking="T" '
      
        'and '#9'((P.batch ="F"'#9' and P.multipleBins="F" and  ifnull(pqasn.Pa' +
        'rentRef, '#39#39')='#39#39') '
      
        #9'or (P.multipleBins ="T"'#9' and ifnull(pqasn.ParentRef, '#39#39')=pqabin' +
        '.GlobalRef) '
      
        #9'or (P.multipleBins ="F"'#9'and P.batch ="T"'#9' and ifnull(pqasn.Pare' +
        'ntRef, '#39#39')=pqabatch.GlobalRef) )'
      
        #9'Where pt.masterId = :SaleLineId and pqa.transtype = '#39'TProcTreeP' +
        'art'#39' and pqa.alloctype ='#39'OUT'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 155
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleLineId'
      end>
    object QryProcTreePartOUTProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'pqa.ProductName'
      Size = 100
    end
    object QryProcTreePartOUTtransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'transdate'
      Origin = 'pqa.TransDate'
    end
    object QryProcTreePartOUTUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'pqa.UOMQty'
    end
    object QryProcTreePartOUTuom: TWideStringField
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 74
    end
    object QryProcTreePartOUTactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
      Origin = 'pqa.Active'
      FixedChar = True
      Size = 1
    end
    object QryProcTreePartOUTbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'pqabatch.Value'
      Size = 100
    end
    object QryProcTreePartOUTbatchQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'batchQty'
      Origin = 'pqabatch.UOMQty'
    end
    object QryProcTreePartOUTBinLocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'pbin.BinLocation'
      Size = 30
    end
    object QryProcTreePartOUTBinNumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'pbin.BinNumber'
      Size = 30
    end
    object QryProcTreePartOUTbinQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binQty'
      Origin = 'pqabin.UOMQty'
    end
    object QryProcTreePartOUTSerialnumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'pqasn.Value'
      Size = 100
    end
    object QryProcTreePartOUTpqaid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'pqaid'
      Origin = 'pqa.PQAID'
      Visible = False
    end
  end
  object dsProcTreePartOUT: TDataSource
    DataSet = QryProcTreePartOUT
    Left = 156
    Top = 319
  end
  object qryProcTreePartIN: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      
        'distinct pqa.pqaid , pqa.ProductName,  pqa.transdate, pqa.UOMQty' +
        ' , concat(pqa.UOM, '#39'('#39' , pqa.UOMMultiplier , '#39')'#39') as uom, pqa.ac' +
        'tive, pqa.transtype ,'
      'pqabatch.Value as batchno, pqabatch.UOMQty batchQty,'
      'pbin.BinLocation , pbin.BinNumber , pqabin.UOMQty binQty,'
      'pqasn.Value as Serialnumber'
      'from tblpqa pqa'
      
        ' inner join tblproctreepart ptp on pqa.translineId = ptp.ProcTre' +
        'ePartId'
      
        ' inner join tblproctree pt on pt.ProcTreeId = ptp.ProcTreeId and' +
        ' pt.MasterType <> '#39'mtProduct'#39
      ''
      'inner join tblparts p on pqa.productId = p.partsId'
      
        'Left join tblpqadetails pqabatch on  pqabatch.pqaid = pqa.pqaid ' +
        'and pqabatch.PQAType ='#39'BATCH'#39' and P.batch ="T"'
      
        'Left join (tblpqadetails pqabin inner join tblproductbin as pbin' +
        ' on pbin.BinID = pqabin.BinID)on  pqabin.pqaid = pqa.pqaid and p' +
        'qabin.PQAType ='#39'BIN'#39' and p.MultipleBins="T" and '#9
      
        '((P.batch ="F"'#9' and ifnull(pqabin.ParentRef, '#39#39')='#39#39') or (P.batch' +
        ' ="T"'#9' and ifnull(pqabin.ParentRef, '#39#39')=pqabatch.GlobalRef) )'
      
        'Left join tblpqadetails pqasn on  pqasn.pqaid = pqa.pqaid and pq' +
        'asn.PQAType ='#39'SN'#39' and p.SNTracking="T" '
      
        'and '#9'((P.batch ="F"'#9' and P.multipleBins="F" and  ifnull(pqasn.Pa' +
        'rentRef, '#39#39')='#39#39') '
      
        #9'or (P.multipleBins ="T"'#9' and ifnull(pqasn.ParentRef, '#39#39')=pqabin' +
        '.GlobalRef) '
      
        #9'or (P.multipleBins ="F"'#9'and P.batch ="T"'#9' and ifnull(pqasn.Pare' +
        'ntRef, '#39#39')=pqabatch.GlobalRef) )'
      
        #9'Where pt.masterId = :SaleLineId and pqa.transtype in ('#39'TProcTre' +
        'ePart'#39' , '#39'TProcTreePartIN'#39' ) and pqa.alloctype ='#39'IN'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 187
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleLineId'
      end>
    object qryProcTreePartINProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'pqa.ProductName'
      Size = 100
    end
    object qryProcTreePartINtransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'transdate'
      Origin = 'pqa.TransDate'
    end
    object qryProcTreePartINUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'pqa.UOMQty'
    end
    object qryProcTreePartINuom: TWideStringField
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 74
    end
    object qryProcTreePartINactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
      Origin = 'pqa.Active'
      FixedChar = True
      Size = 1
    end
    object qryProcTreePartINbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'pqabatch.Value'
      Size = 100
    end
    object qryProcTreePartINbatchQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'batchQty'
      Origin = 'pqabatch.UOMQty'
    end
    object qryProcTreePartINBinLocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'pbin.BinLocation'
      Size = 30
    end
    object qryProcTreePartINBinNumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'pbin.BinNumber'
      Size = 30
    end
    object qryProcTreePartINbinQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binQty'
      Origin = 'pqabin.UOMQty'
    end
    object qryProcTreePartINSerialnumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'pqasn.Value'
      Size = 100
    end
    object qryProcTreePartINpqaid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'pqaid'
      Origin = 'pqa.PQAID'
      Visible = False
    end
    object qryProcTreePartINtranstype: TWideStringField
      FieldName = 'transtype'
      Origin = 'pqa.TransType'
      Size = 50
    end
  end
  object dsProcTreePartIN: TDataSource
    DataSet = qryProcTreePartIN
    Left = 188
    Top = 319
  end
  object qryProcProgressInIN: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      
        'distinct pqa.pqaid , pqa.ProductName,  pqa.transdate, pqa.UOMQty' +
        ' , concat(pqa.UOM, '#39'('#39' , pqa.UOMMultiplier , '#39')'#39') as uom, pqa.ac' +
        'tive, '
      'pqabatch.Value as batchno, pqabatch.UOMQty batchQty,'
      'pbin.BinLocation , pbin.BinNumber , pqabin.UOMQty binQty,'
      'pqasn.Value as Serialnumber'
      'from tblpqa pqa'
      
        ' inner join tblprocprogress ppg on pqa.TransLineID = ppg.ProcPro' +
        'gressID'
      
        ' inner join tblproctree pt on ppg.ProcTreeId = pt.ProcTreeId and' +
        ' pt.MasterType <> '#39'mtProduct'#39
      ''
      'inner join tblparts p on pqa.productId = p.partsId'
      
        'Left join tblpqadetails pqabatch on  pqabatch.pqaid = pqa.pqaid ' +
        'and pqabatch.PQAType ='#39'BATCH'#39' and P.batch ="T"'
      
        'Left join (tblpqadetails pqabin inner join tblproductbin as pbin' +
        ' on pbin.BinID = pqabin.BinID)on  pqabin.pqaid = pqa.pqaid and p' +
        'qabin.PQAType ='#39'BIN'#39' and p.MultipleBins="T" and '#9
      
        '((P.batch ="F"'#9' and ifnull(pqabin.ParentRef, '#39#39')='#39#39') or (P.batch' +
        ' ="T"'#9' and ifnull(pqabin.ParentRef, '#39#39')=pqabatch.GlobalRef) )'
      
        'Left join tblpqadetails pqasn on  pqasn.pqaid = pqa.pqaid and pq' +
        'asn.PQAType ='#39'SN'#39' and p.SNTracking="T" '
      
        'and '#9'((P.batch ="F"'#9' and P.multipleBins="F" and  ifnull(pqasn.Pa' +
        'rentRef, '#39#39')='#39#39') '
      
        #9'or (P.multipleBins ="T"'#9' and ifnull(pqasn.ParentRef, '#39#39')=pqabin' +
        '.GlobalRef) '
      
        #9'or (P.multipleBins ="F"'#9'and P.batch ="T"'#9' and ifnull(pqasn.Pare' +
        'ntRef, '#39#39')=pqabatch.GlobalRef) )'
      
        #9'Where pt.MasterId =  :SaleLineId and pqa.transtype = '#39'TProcProg' +
        'ressIn'#39' and pqa.alloctype ='#39'IN'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 219
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleLineId'
      end>
    object qryProcProgressInINProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'pqa.ProductName'
      Size = 100
    end
    object qryProcProgressInINtransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'transdate'
      Origin = 'pqa.TransDate'
    end
    object qryProcProgressInINUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'pqa.UOMQty'
    end
    object qryProcProgressInINuom: TWideStringField
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 74
    end
    object qryProcProgressInINactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
      Origin = 'pqa.Active'
      FixedChar = True
      Size = 1
    end
    object qryProcProgressInINbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'pqabatch.Value'
      Size = 100
    end
    object qryProcProgressInINbatchQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'batchQty'
      Origin = 'pqabatch.UOMQty'
    end
    object qryProcProgressInINBinLocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'pbin.BinLocation'
      Size = 30
    end
    object qryProcProgressInINBinNumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'pbin.BinNumber'
      Size = 30
    end
    object qryProcProgressInINbinQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binQty'
      Origin = 'pqabin.UOMQty'
    end
    object qryProcProgressInINSerialnumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'pqasn.Value'
      Size = 100
    end
    object qryProcProgressInINpqaid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'pqaid'
      Origin = 'pqa.PQAID'
      Visible = False
    end
  end
  object dsProcProgressInIN: TDataSource
    DataSet = qryProcProgressInIN
    Left = 220
    Top = 319
  end
  object qryProcProgressOUT: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      
        'distinct pqa.pqaid , pqa.ProductName,  pqa.transdate, pqa.UOMQty' +
        ' , concat(pqa.UOM, '#39'('#39' , pqa.UOMMultiplier , '#39')'#39') as uom, pqa.ac' +
        'tive, '
      'pqabatch.Value as batchno, pqabatch.UOMQty batchQty,'
      'pbin.BinLocation , pbin.BinNumber , pqabin.UOMQty binQty,'
      'pqasn.Value as Serialnumber'
      'from tblpqa pqa'
      
        ' inner join tblprocprogress ppg on pqa.TransLineID = ppg.ProcPro' +
        'gressID'
      
        ' inner join tblproctree pt on ppg.ProcTreeId = pt.ProcTreeId and' +
        ' pt.MasterType <> '#39'mtProduct'#39
      'inner join tblparts p on pqa.productId = p.partsId'
      
        'Left join tblpqadetails pqabatch on  pqabatch.pqaid = pqa.pqaid ' +
        'and pqabatch.PQAType ='#39'BATCH'#39' and P.batch ="T"'
      
        'Left join (tblpqadetails pqabin inner join tblproductbin as pbin' +
        ' on pbin.BinID = pqabin.BinID)on  pqabin.pqaid = pqa.pqaid and p' +
        'qabin.PQAType ='#39'BIN'#39' and p.MultipleBins="T" and '#9
      
        '((P.batch ="F"'#9' and ifnull(pqabin.ParentRef, '#39#39')='#39#39') or (P.batch' +
        ' ="T"'#9' and ifnull(pqabin.ParentRef, '#39#39')=pqabatch.GlobalRef) )'
      
        'Left join tblpqadetails pqasn on  pqasn.pqaid = pqa.pqaid and pq' +
        'asn.PQAType ='#39'SN'#39' and p.SNTracking="T" '
      
        'and '#9'((P.batch ="F"'#9' and P.multipleBins="F" and  ifnull(pqasn.Pa' +
        'rentRef, '#39#39')='#39#39') '
      
        #9'or (P.multipleBins ="T"'#9' and ifnull(pqasn.ParentRef, '#39#39')=pqabin' +
        '.GlobalRef) '
      
        #9'or (P.multipleBins ="F"'#9'and P.batch ="T"'#9' and ifnull(pqasn.Pare' +
        'ntRef, '#39#39')=pqabatch.GlobalRef) )'
      
        #9'Where pt.MasterId =  :SaleLineId and pqa.transtype = '#39'TProcProg' +
        'ressOUT'#39' and pqa.alloctype ='#39'OUT'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 251
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleLineId'
      end>
    object qryProcProgressOUTProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'pqa.ProductName'
      Size = 100
    end
    object qryProcProgressOUTtransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'transdate'
      Origin = 'pqa.TransDate'
    end
    object qryProcProgressOUTUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'pqa.UOMQty'
    end
    object qryProcProgressOUTuom: TWideStringField
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 74
    end
    object qryProcProgressOUTactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
      Origin = 'pqa.Active'
      FixedChar = True
      Size = 1
    end
    object qryProcProgressOUTbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'pqabatch.Value'
      Size = 100
    end
    object qryProcProgressOUTbatchQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'batchQty'
      Origin = 'pqabatch.UOMQty'
    end
    object qryProcProgressOUTBinLocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'pbin.BinLocation'
      Size = 30
    end
    object qryProcProgressOUTBinNumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'pbin.BinNumber'
      Size = 30
    end
    object qryProcProgressOUTbinQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binQty'
      Origin = 'pqabin.UOMQty'
    end
    object qryProcProgressOUTSerialnumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'pqasn.Value'
      Size = 100
    end
    object qryProcProgressOUTpqaid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'pqaid'
      Origin = 'pqa.PQAID'
      Visible = False
    end
  end
  object dsProcProgressOUT: TDataSource
    DataSet = qryProcProgressOUT
    Left = 252
    Top = 319
  end
  object dsAllOthers: TDataSource
    DataSet = qryAllOthers
    Left = 284
    Top = 319
  end
  object qryAllOthers: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      
        'distinct pqa.pqaid , pqa.ProductName,  pqa.transdate, pqa.UOMQty' +
        ' , concat(pqa.UOM, '#39'('#39' , pqa.UOMMultiplier , '#39')'#39') as uom, pqa.ac' +
        'tive,  pqa.transtype, PQa.alloctype,'
      'pqabatch.Value as batchno, pqabatch.UOMQty batchQty,'
      'pbin.BinLocation , pbin.BinNumber , pqabin.UOMQty binQty,'
      'pqasn.Value as Serialnumber'
      'from tblpqa pqa'
      'inner join tblparts p on pqa.productId = p.partsId'
      
        'Left join tblpqadetails pqabatch on  pqabatch.pqaid = pqa.pqaid ' +
        'and pqabatch.PQAType ='#39'BATCH'#39' and P.batch ="T"'
      
        'Left join (tblpqadetails pqabin inner join tblproductbin as pbin' +
        ' on pbin.BinID = pqabin.BinID)on  pqabin.pqaid = pqa.pqaid and p' +
        'qabin.PQAType ='#39'BIN'#39' and p.MultipleBins="T" and '#9
      
        '((P.batch ="F"'#9' and ifnull(pqabin.ParentRef, '#39#39')='#39#39') or (P.batch' +
        ' ="T"'#9' and ifnull(pqabin.ParentRef, '#39#39')=pqabatch.GlobalRef) )'
      
        'Left join tblpqadetails pqasn on  pqasn.pqaid = pqa.pqaid and pq' +
        'asn.PQAType ='#39'SN'#39' and p.SNTracking="T" '
      
        'and '#9'((P.batch ="F"'#9' and P.multipleBins="F" and  ifnull(pqasn.Pa' +
        'rentRef, '#39#39')='#39#39') '
      
        #9'or (P.multipleBins ="T"'#9' and ifnull(pqasn.ParentRef, '#39#39')=pqabin' +
        '.GlobalRef) '
      
        #9'or (P.multipleBins ="F"'#9'and P.batch ="T"'#9' and ifnull(pqasn.Pare' +
        'ntRef, '#39#39')=pqabatch.GlobalRef) )'
      #9'Where pqa.translineID = :SaleLineId and '
      #9
      
        'not ((pqa.transtype = '#39'TSalesOrderLine'#39' and pqa.alloctype ='#39'OUT'#39 +
        ') or '
      '(pqa.transtype = '#39'TProcTreePart'#39' and pqa.alloctype ='#39'OUT'#39') or '
      '(pqa.transtype = '#39'TProcTreePart'#39' and pqa.alloctype ='#39'IN'#39') or '
      '(pqa.transtype = '#39'TProcProgressIn'#39' and pqa.alloctype ='#39'IN'#39') or '
      '(pqa.transtype = '#39'TProcProgressOUT'#39' and pqa.alloctype ='#39'OUT'#39') )'
      
        'and pqa.transtype in ('#39'TSalesOrderLine'#39' , '#39'TProcTreePart'#39', '#39'TPro' +
        'cTreePart'#39','#39'TProcProgressIn'#39', '#39'TProcProgressOUT'#39', '#39'TProcTreePart' +
        'IN'#39')')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 283
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleLineId'
      end>
    object qryAllOthersProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'pqa.ProductName'
      Size = 100
    end
    object qryAllOtherstransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'transdate'
      Origin = 'pqa.TransDate'
    end
    object qryAllOthersUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'pqa.UOMQty'
    end
    object qryAllOthersuom: TWideStringField
      DisplayWidth = 10
      FieldName = 'uom'
      Origin = 'uom'
      Size = 74
    end
    object qryAllOthersactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
      Origin = 'pqa.Active'
      FixedChar = True
      Size = 1
    end
    object qryAllOthersbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'pqabatch.Value'
      Size = 100
    end
    object qryAllOthersbatchQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'batchQty'
      Origin = 'pqabatch.UOMQty'
    end
    object qryAllOthersBinLocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'pbin.BinLocation'
      Size = 30
    end
    object qryAllOthersBinNumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'pbin.BinNumber'
      Size = 30
    end
    object qryAllOthersbinQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binQty'
      Origin = 'pqabin.UOMQty'
    end
    object qryAllOthersSerialnumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'pqasn.Value'
      Size = 100
    end
    object qryAllOtherspqaid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'pqaid'
      Origin = 'pqa.PQAID'
      Visible = False
    end
    object qryAllOtherstranstype: TWideStringField
      FieldName = 'transtype'
      Origin = 'pqa.TransType'
      Size = 50
    end
    object qryAllOthersalloctype: TWideStringField
      FieldName = 'alloctype'
      Origin = 'pqa.Alloctype'
      Size = 3
    end
  end
end
