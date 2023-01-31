inherited fmProductQtys: TfmProductQtys
  Left = 86
  Top = 150
  HelpContext = 778001
  Caption = 'fmProductQtys'
  ClientHeight = 635
  ClientWidth = 1102
  OldCreateOrder = True
  ExplicitWidth = 1108
  ExplicitHeight = 663
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 32
    Width = 1102
    HelpContext = 778036
  end
  inherited imgGridWatermark: TImage
    Left = 258
    Top = 471
    ExplicitLeft = 258
    ExplicitTop = 471
  end
  object DNMSpeedButton2: TDNMSpeedButton [5]
    Left = 712
    Top = 2
    Width = 121
    Height = 23
    HelpContext = 778004
    Caption = 'Refresh'
    Color = clBtnFace
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentColor = False
    TabOrder = 4
    OnClick = DNMSpeedButton2Click
  end
  object DNMSpeedButton3: TDNMSpeedButton [6]
    Left = 128
    Top = 0
    Width = 121
    Height = 23
    HelpContext = 778005
    Caption = 'Conmpare Available'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 5
    OnClick = DNMSpeedButton3Click
  end
  object DNMSpeedButton1: TDNMSpeedButton [7]
    Left = 0
    Top = 0
    Width = 121
    Height = 23
    HelpContext = 778006
    Caption = 'Conmpare Instock'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 1
    OnClick = DNMSpeedButton1Click
  end
  object PageControl1: TPageControl [8]
    Left = 0
    Top = 32
    Width = 1102
    Height = 603
    HelpContext = 778007
    ActivePage = TabSheet2
    Align = alBottom
    TabOrder = 0
    object TabSheet1: TTabSheet
      HelpContext = 778008
      Caption = 'TabSheet1'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 208
        Top = 240
        Width = 38
        Height = 15
        HelpContext = 778009
        Caption = 'Label1'
      end
      object Label2: TLabel
        Left = 704
        Top = 248
        Width = 38
        Height = 15
        HelpContext = 778010
        Caption = 'Label2'
      end
      object Label3: TLabel
        Left = 160
        Top = 528
        Width = 38
        Height = 15
        HelpContext = 778011
        Caption = 'Label2'
      end
      object Label4: TLabel
        Left = 672
        Top = 528
        Width = 38
        Height = 15
        HelpContext = 778012
        Caption = 'Label2'
      end
      object Label5: TLabel
        Left = 0
        Top = 8
        Width = 81
        Height = 18
        HelpContext = 778013
        Caption = 'Parts Form '
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 544
        Top = 8
        Width = 86
        Height = 18
        HelpContext = 778014
        Caption = 'Product List'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 0
        Top = 264
        Width = 122
        Height = 18
        HelpContext = 778015
        Caption = 'Stock Adjustment'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 544
        Top = 264
        Width = 135
        Height = 18
        HelpContext = 778016
        Caption = 'Product Movement'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object grdParts: TwwDBGrid
        Left = 0
        Top = 24
        Width = 529
        Height = 210
        HelpContext = 778017
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'
          'ProductID'#9'10'#9'ProductID'
          'DepartmentID'#9'10'#9'DepartmentID'
          'ProductName'#9'20'#9'ProductName'
          'AvailableQty'#9'10'#9'AvailableQty'
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'
          'SOQty'#9'10'#9'SOQty'
          'SOBOQty'#9'10'#9'SOBOQty'
          'InstockQty'#9'10'#9'InstockQty'
          'POBOQty'#9'10'#9'POBOQty')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsParts
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
      end
      object grdSa: TwwDBGrid
        Left = 0
        Top = 282
        Width = 529
        Height = 210
        HelpContext = 778018
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'#9#9
          'ProductID'#9'10'#9'ProductID'#9#9
          'DepartmentID'#9'10'#9'DepartmentID'#9#9
          'ProductName'#9'20'#9'ProductName'#9#9
          'AvailableQty'#9'10'#9'AvailableQty'#9#9
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'#9#9
          'SOQty'#9'10'#9'SOQty'#9#9
          'SOBOQty'#9'10'#9'SOBOQty'#9#9
          'InstockQty'#9'10'#9'InstockQty'#9#9
          'POBOQty'#9'10'#9'POBOQty'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsSa
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object grdProductList: TwwDBGrid
        Left = 544
        Top = 25
        Width = 529
        Height = 210
        HelpContext = 778019
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'#9#9
          'ProductID'#9'10'#9'ProductID'#9#9
          'DepartmentID'#9'10'#9'DepartmentID'#9#9
          'ProductName'#9'20'#9'ProductName'#9'F'
          'AvailableQty'#9'10'#9'AvailableQty'#9#9
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'#9#9
          'SOQty'#9'10'#9'SOQty'#9#9
          'SOBOQty'#9'10'#9'SOBOQty'#9#9
          'InstockQty'#9'10'#9'InstockQty'#9#9
          'POBOQty'#9'10'#9'POBOQty'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsProductList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object grdproductmovement: TwwDBGrid
        Left = 544
        Top = 283
        Width = 529
        Height = 210
        HelpContext = 778020
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'#9#9
          'ProductID'#9'10'#9'ProductID'#9#9
          'DepartmentID'#9'10'#9'DepartmentID'#9#9
          'ProductName'#9'20'#9'ProductName'#9'F'
          'AvailableQty'#9'10'#9'AvailableQty'#9#9
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'#9#9
          'SOQty'#9'10'#9'SOQty'#9#9
          'SOBOQty'#9'10'#9'SOBOQty'#9#9
          'InstockQty'#9'10'#9'InstockQty'#9#9
          'POBOQty'#9'10'#9'POBOQty'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsproductmovement
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object Edit1: TEdit
        Left = 208
        Top = 256
        Width = 121
        Height = 23
        HelpContext = 778021
        TabOrder = 4
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 704
        Top = 264
        Width = 121
        Height = 23
        HelpContext = 778022
        TabOrder = 5
        Text = 'Edit1'
      end
      object Edit3: TEdit
        Left = 160
        Top = 544
        Width = 121
        Height = 23
        HelpContext = 778023
        TabOrder = 6
        Text = 'Edit1'
      end
      object Edit4: TEdit
        Left = 672
        Top = 544
        Width = 121
        Height = 23
        HelpContext = 778024
        TabOrder = 7
        Text = 'Edit1'
      end
    end
    object TabSheet2: TTabSheet
      HelpContext = 778025
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Label9: TLabel
        Left = 0
        Top = 8
        Width = 88
        Height = 19
        HelpContext = 778026
        Caption = 'Parts Form '
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 0
        Top = 264
        Width = 134
        Height = 19
        HelpContext = 778027
        Caption = 'Stock Adjustment'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 552
        Top = 264
        Width = 144
        Height = 19
        HelpContext = 778028
        Caption = 'Product Movement'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 552
        Top = 8
        Width = 93
        Height = 19
        HelpContext = 778029
        Caption = 'Product List'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object wwDBGrid1: TwwDBGrid
        Left = 0
        Top = 27
        Width = 529
        Height = 210
        HelpContext = 778030
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'#9#9
          'ProductID'#9'10'#9'ProductID'#9#9
          'DepartmentID'#9'10'#9'DepartmentID'#9#9
          'ProductName'#9'100'#9'ProductName'#9#9
          'AvailableQty'#9'10'#9'AvailableQty'#9#9
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'#9#9
          'SOQty'#9'10'#9'SOQty'#9#9
          'SOBOQty'#9'10'#9'SOBOQty'#9#9
          'InstockQty'#9'10'#9'InstockQty'#9#9
          'POBOQty'#9'10'#9'POBOQty'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = gdsParts
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
      end
      object wwDBGrid2: TwwDBGrid
        Left = 552
        Top = 27
        Width = 529
        Height = 210
        HelpContext = 778031
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'
          'ProductID'#9'10'#9'ProductID'
          'DepartmentID'#9'10'#9'DepartmentID'
          'ProductName'#9'100'#9'ProductName'
          'AvailableQty'#9'10'#9'AvailableQty'
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'
          'SOQty'#9'10'#9'SOQty'
          'SOBOQty'#9'10'#9'SOBOQty'
          'InstockQty'#9'10'#9'InstockQty'
          'POBOQty'#9'10'#9'POBOQty')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = gdsProductList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object wwDBGrid3: TwwDBGrid
        Left = 0
        Top = 283
        Width = 529
        Height = 210
        HelpContext = 778032
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'
          'ProductID'#9'10'#9'ProductID'
          'DepartmentID'#9'10'#9'DepartmentID'
          'ProductName'#9'100'#9'ProductName'
          'AvailableQty'#9'10'#9'AvailableQty'
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'
          'SOQty'#9'10'#9'SOQty'
          'SOBOQty'#9'10'#9'SOBOQty'
          'InstockQty'#9'10'#9'InstockQty'
          'POBOQty'#9'10'#9'POBOQty')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = gdsSa
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object wwDBGrid4: TwwDBGrid
        Left = 552
        Top = 283
        Width = 529
        Height = 210
        HelpContext = 778033
        Selected.Strings = (
          'PQAID'#9'10'#9'PQAID'
          'ProductID'#9'10'#9'ProductID'
          'DepartmentID'#9'10'#9'DepartmentID'
          'ProductName'#9'100'#9'ProductName'
          'AvailableQty'#9'10'#9'AvailableQty'
          'AllocatedBOQty'#9'10'#9'AllocatedBOQty'
          'SOQty'#9'10'#9'SOQty'
          'SOBOQty'#9'10'#9'SOBOQty'
          'InstockQty'#9'10'#9'InstockQty'
          'POBOQty'#9'10'#9'POBOQty')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = gdsproductmovement
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
    end
    object TabSheet3: TTabSheet
      HelpContext = 778034
      Caption = 'TabSheet3'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object wwDBGrid5: TwwDBGrid
        Left = 0
        Top = 0
        Width = 1094
        Height = 573
        HelpContext = 778035
        Selected.Strings = (
          'PQAId'#9'10'#9'PQAID'
          'Description'#9'50'#9'Description'
          'd1'#9'10'#9'd1'
          'd2'#9'10'#9'd2'
          'd3'#9'10'#9'd3'
          'd4'#9'10'#9'd4')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsProductQty
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
        OnCalcCellColors = wwDBGrid5CalcCellColors
      end
    end
  end
  object chkIgnoreDates: TCheckBox [9]
    Left = 840
    Top = 5
    Width = 93
    Height = 17
    HelpContext = 778003
    Alignment = taLeftJustify
    Caption = 'Ignore Dates'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 3
  end
  object dtp: TDateTimePicker [10]
    Left = 968
    Top = 2
    Width = 113
    Height = 23
    HelpContext = 778002
    Date = 40392.647178518500000000
    Time = 40392.647178518500000000
    TabOrder = 2
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 78
    Top = 472
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 472
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 113
    Top = 472
  end
  inherited DataState: TDataState
    Left = 148
    Top = 472
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 183
    Top = 472
  end
  inherited imgsort: TImageList
    Left = 43
    Top = 472
    Bitmap = {
      494C01010200B400C00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 218
    Top = 472
  end
  object QryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      'from tblPQA as PQA '
      
        'where PQA.ProductID = :ProductID and (PQA.transDate < :Transdate' +
        ' or :TransDate = 0)'
      'group by PQA.PQAID')
    Left = 40
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ProductID'
        Value = 0
      end>
    object QryPartsPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'tblPQA.PQAID'
    end
    object QryPartsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblPQA.ProductID'
    end
    object QryPartsDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'tblPQA.DepartmentID'
    end
    object QryPartsProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'tblPQA.ProductName'
      Size = 100
    end
    object QryPartsAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object QryPartsAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object QryPartsSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object QryPartsSOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object QryPartsInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object QryPartsPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object QrySA: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      ' FROM tblParts as P'
      'inner join tblPQA as PQA on PQA.ProductId = P.PartsID '
      'inner join tblclass as C on PQA.departmentID = C.ClassID '
      
        'Left join tblProductClasses as PC on PC.ProductID = PQA.ProductI' +
        'D and PC.ClassID = PQA.departmentID'
      'Where P.active <>"F" and PC.ACtive <> "F" '
      
        'and PQA.ProductID =:ProductID  and (PQA.transDate < :Transdate o' +
        'r :TransDate = 0)'
      'group by PQA.PQAID')
    Left = 72
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object QrySAPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'PQA.PQAID'
    end
    object QrySAProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
    end
    object QrySADepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
    end
    object QrySAProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object QrySAAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object QrySAAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object QrySASOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object QrySASOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object QrySAInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object QrySAPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object QryProductList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      ''
      'FROM tblParts as P'
      'Left join tblProductClasses as PC on PC.ProductID = P.PartsId'
      
        'left join tblPQA as PQA on PC.ProductID = PQA.ProductID and PC.C' +
        'lassID = PQA.departmentID'
      'left join tblclass as C on PQA.departmentID = C.ClassID '
      
        'LEFT JOIN tbltaxcodes AS T1 ON T1.Name = P.TAXCODE AND T1.Region' +
        'ID= 1 '
      
        'LEFT JOIN tbltaxcodes AS T2 ON T2.Name = P.PURCHTAXCODE AND T2.R' +
        'egionID= 1 '
      
        'WHERE char_length(P.PARTNAME)>0 AND not IsNull(P.PARTNAME) and i' +
        'fnull(PC.Active,"T") = "T"'
      
        'and P.PartsId =:ProductID  and (PQA.transDate < :Transdate or :T' +
        'ransDate = 0)'
      'Group by PQa.PQAID')
    Left = 112
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object QryProductListPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'PQA.PQAID'
    end
    object QryProductListProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
    end
    object QryProductListDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
    end
    object QryProductListProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object QryProductListAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object QryProductListAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object QryProductListSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object QryProductListSOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object QryProductListInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object QryProductListPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object Qryproductmovement: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      ''
      'FROM tblParts as P'
      'inner join tblPQA as PQA on PQA.ProductId = P.PartsID '
      'inner join tblclass as C on PQA.departmentID = C.ClassID '
      
        'Left join tblProductClasses as PC on PC.ProductID = PQA.ProductI' +
        'D and PC.ClassID = PQA.departmentID'
      
        'Left  join tblpqatranstypes as TT on TT.TransType = PQA.TransTyp' +
        'e'
      ''
      
        'LEFt JOIN tblStockMovement SM on SM.StockmovementId = PQA.TransI' +
        'd and PQA.TransType = '#39'TStockMovementLines'#39
      
        'LEFt JOIN tblpqatranstypes as SMTT on SM.StockmovementEntryType ' +
        '= SMTT.TransType'
      
        'Where   if((PQA.Active ="F") and  (not(PQA.TransType in ('#39'TProcT' +
        'reePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTreePart'#39')' +
        ' and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" and  PQA' +
        '.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and (PQA.Tr' +
        'ansType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQA.QTY,0)' +
        ',0))) <> 0'
      
        'and PQA.ProductId =:ProductID and (PQA.transDate < :Transdate or' +
        ' :TransDate = 0)'
      'group by PQA.PQAID')
    Left = 152
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object QryproductmovementPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'PQA.PQAID'
    end
    object QryproductmovementProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
    end
    object QryproductmovementDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
    end
    object QryproductmovementProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object QryproductmovementAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object QryproductmovementAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object QryproductmovementSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object QryproductmovementSOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object QryproductmovementInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object QryproductmovementPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object dsParts: TDataSource
    DataSet = QryParts
    Left = 40
    Top = 192
  end
  object dsSa: TDataSource
    DataSet = QrySA
    Left = 72
    Top = 192
  end
  object dsProductList: TDataSource
    DataSet = QryProductList
    Left = 120
    Top = 192
  end
  object dsproductmovement: TDataSource
    DataSet = Qryproductmovement
    Left = 160
    Top = 192
  end
  object gQryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      'from tblPQA as PQA '
      
        'where PQA.ProductID = :ProductID and (PQA.transDate < :Transdate' +
        ' or :TransDate = 0)'
      'group by PQA.ProductID, PQA.DepartmentID')
    Left = 248
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ProductID'
        Value = 0
      end>
    object gQryPartsPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'tblPQA.PQAID'
    end
    object gQryPartsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblPQA.ProductID'
    end
    object gQryPartsDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'tblPQA.DepartmentID'
    end
    object gQryPartsProductName: TWideStringField
      DisplayWidth = 100
      FieldName = 'ProductName'
      Origin = 'tblPQA.ProductName'
      Size = 100
    end
    object gQryPartsAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object gQryPartsAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object gQryPartsSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object gQryPartsSOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object gQryPartsInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object gQryPartsPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object gQrySA: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      ' FROM tblParts as P'
      'inner join tblPQA as PQA on PQA.ProductId = P.PartsID '
      'inner join tblclass as C on PQA.departmentID = C.ClassID '
      
        'Left join tblProductClasses as PC on PC.ProductID = PQA.ProductI' +
        'D and PC.ClassID = PQA.departmentID'
      'Where P.active <>"F" and PC.ACtive <> "F" '
      
        'and PQA.ProductID =:ProductID and (PQA.transDate < :Transdate or' +
        ' :TransDate = 0)'
      'group by P.PartsID, P.PARTNAME')
    Left = 280
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object gQrySAPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'PQA.PQAID'
    end
    object gQrySAProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
    end
    object gQrySADepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
    end
    object gQrySAProductName: TWideStringField
      DisplayWidth = 100
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object gQrySAAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object gQrySAAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object gQrySASOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object gQrySASOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object gQrySAInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object gQrySAPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object gQryProductList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      ''
      'FROM tblParts as P'
      'Left join tblProductClasses as PC on PC.ProductID = P.PartsId'
      
        'left join tblPQA as PQA on PC.ProductID = PQA.ProductID and PC.C' +
        'lassID = PQA.departmentID'
      'left join tblclass as C on PQA.departmentID = C.ClassID '
      
        'LEFT JOIN tbltaxcodes AS T1 ON T1.Name = P.TAXCODE AND T1.Region' +
        'ID= 1 '
      
        'LEFT JOIN tbltaxcodes AS T2 ON T2.Name = P.PURCHTAXCODE AND T2.R' +
        'egionID= 1 '
      
        'WHERE char_length(P.PARTNAME)>0 AND not IsNull(P.PARTNAME) and i' +
        'fnull(PC.Active,"T") = "T"'
      
        'and P.PartsId =:ProductID and (PQA.transDate < :Transdate or :Tr' +
        'ansDate = 0)'
      'Group by P.PartsID, P.PARTNAME')
    Left = 320
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object gQryProductListPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'PQA.PQAID'
    end
    object gQryProductListProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
    end
    object gQryProductListDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
    end
    object gQryProductListProductName: TWideStringField
      DisplayWidth = 100
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object gQryProductListAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object gQryProductListAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object gQryProductListSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object gQryProductListSOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object gQryProductListInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object gQryProductListPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object gQryproductmovement: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select distinct PQA.PQAID, PQA.ProductID, PQA.DepartmentID, PQA.' +
        'ProductName,'
      
        'Round(Round(Sum(if((PQA.Active ="F") and  (not(PQA.TransType in ' +
        '('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTr' +
        'eePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" ' +
        'and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and' +
        ' (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQ' +
        'A.QTY,0),0)))),5), 5) as AvailableQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TInvoi' +
        'ceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as Alloc' +
        'atedBOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(((PQA.TransType = '#39'TS' +
        'alesOrderLine'#39') OR (PQA.TransType = '#39'TPOSLaybylines'#39' and PQA.Res' +
        'erved = "T")) and (PQA.IsBO ="F"),ifnull(PQA.QTY,0), 0))),5), 5)' +
        ' as SOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as SO' +
        'BOQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TSales' +
        'OrderLine'#39' or PQA.IsBO ="T",0,if(PQA.TransType = '#39'TPOSLaybylines' +
        #39' and PQA.Reserved = "T" ,0 ,if(PQA.alloctype="IN"  , ifnull(PQA' +
        '.QTY,0), 0-ifnull(PQA.QTY,0)))))),5), 5) as InstockQty, '
      
        'Round(Round(Sum(if(PQA.Active ="F" , 0, if(PQA.TransType='#39'TPurch' +
        'aseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))),5), 5) as' +
        ' POBOQty '
      ''
      'FROM tblParts as P'
      'inner join tblPQA as PQA on PQA.ProductId = P.PartsID '
      'inner join tblclass as C on PQA.departmentID = C.ClassID '
      
        'Left join tblProductClasses as PC on PC.ProductID = PQA.ProductI' +
        'D and PC.ClassID = PQA.departmentID'
      
        'Left  join tblpqatranstypes as TT on TT.TransType = PQA.TransTyp' +
        'e'
      ''
      
        'LEFt JOIN tblStockMovement SM on SM.StockmovementId = PQA.TransI' +
        'd and PQA.TransType = '#39'TStockMovementLines'#39
      
        'LEFt JOIN tblpqatranstypes as SMTT on SM.StockmovementEntryType ' +
        '= SMTT.TransType'
      
        'Where  if((PQA.Active ="F") and  (not(PQA.TransType in ('#39'TProcTr' +
        'eePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcTreePart'#39') ' +
        'and (PQA.alloctype ="IN")) ), 0, if(PQA.alloctype="IN" and  PQA.' +
        'ISBo="F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and (PQA.Tra' +
        'nsType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F") ,0-ifnull(PQA.QTY,0),' +
        '0))) <> 0'
      
        'and PQA.ProductId =:ProductID and (PQA.transDate < :Transdate or' +
        ' :TransDate = 0)'
      'group by PQA.ProductID, PQA.DepartmentID')
    Left = 360
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object gQryproductmovementPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'PQA.PQAID'
    end
    object gQryproductmovementProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
    end
    object gQryproductmovementDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
    end
    object gQryproductmovementProductName: TWideStringField
      DisplayWidth = 100
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object gQryproductmovementAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object gQryproductmovementAllocatedBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocatedBOQty'
      Origin = '.AllocatedBOQty'
    end
    object gQryproductmovementSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object gQryproductmovementSOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object gQryproductmovementInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = '.InstockQty'
    end
    object gQryproductmovementPOBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'POBOQty'
      Origin = '.POBOQty'
    end
  end
  object gdsParts: TDataSource
    DataSet = gQryParts
    Left = 248
    Top = 192
  end
  object gdsSa: TDataSource
    DataSet = gQrySA
    Left = 280
    Top = 192
  end
  object gdsProductList: TDataSource
    DataSet = gQryProductList
    Left = 328
    Top = 192
  end
  object gdsproductmovement: TDataSource
    DataSet = gQryproductmovement
    Left = 368
    Top = 192
  end
  object dsProductQty: TDataSource
    DataSet = ProductQty
    Left = 432
    Top = 192
  end
  object ProductQty: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tmp_11')
    Left = 424
    Top = 160
    object ProductQtyPQAId: TLargeintField
      DisplayLabel = 'PQAID'
      DisplayWidth = 10
      FieldName = 'PQAId'
      Origin = 'tmp_11.PQAId'
    end
    object ProductQtyDescription: TWideStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Origin = 'tmp_11.Description'
      Size = 50
    end
    object ProductQtyd1: TFloatField
      DisplayWidth = 10
      FieldName = 'd1'
      Origin = 'tmp_11.d1'
    end
    object ProductQtyd2: TFloatField
      DisplayWidth = 10
      FieldName = 'd2'
      Origin = 'tmp_11.d2'
    end
    object ProductQtyd3: TFloatField
      DisplayWidth = 10
      FieldName = 'd3'
      Origin = 'tmp_11.d3'
    end
    object ProductQtyd4: TFloatField
      DisplayWidth = 10
      FieldName = 'd4'
      Origin = 'tmp_11.d4'
    end
    object ProductQtyID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_11.ID'
      Visible = False
    end
  end
end
