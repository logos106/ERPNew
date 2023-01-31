inherited FmPartialBuild: TFmPartialBuild
  Left = 415
  Top = 281
  BorderStyle = bsSizeable
  Caption = 'Sub BOM Partial Build'
  ClientWidth = 993
  OnResize = FormResize
  ExplicitLeft = 415
  ExplicitTop = 281
  ExplicitWidth = 1009
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1647002
  inherited lblSkingroupMsg: TLabel
    Top = 426
    Width = 993
    ExplicitTop = 482
    ExplicitWidth = 993
    HelpContext = 1647003
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object AdvReflectionImage1: TAdvReflectionImage [5]
    Left = 368
    Top = 256
    Width = 32
    Height = 32
    AutoSize = False
    Version = '1.5.0.2'
    HelpContext = 1647004
  end
  object DNMPanel2: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 993
    Height = 85
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      993
      85)
    HelpContext = 1647005
    object Label1: TLabel
      Left = 5
      Top = 39
      Width = 71
      Height = 15
      HelpContext = 1647006
      Caption = 'Sales Order '
      Color = clBtnFace
      ParentColor = False
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 328
      Top = 16
      Width = 336
      Height = 52
      HelpContext = 1647007
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
        Width = 334
        Height = 50
        HelpContext = 1647008
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
          Width = 334
          Height = 50
          HelpContext = 1647009
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Partial Invoicing'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 7
          ExplicitWidth = 513
        end
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 5
      Top = 54
      Width = 121
      Height = 23
      HelpContext = 1647010
      DataField = 'saleId'
      DataSource = dsMain
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 85
    Width = 993
    Height = 341
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    HelpContext = 1647011
    object splMultiSelectList: TSplitter
      Left = 248
      Top = 1
      Width = 2
      Height = 339
      HelpContext = 1647012
      Align = alRight
      ExplicitLeft = 276
      ExplicitTop = -22
    end
    object grdMain: TwwDBGrid
      Left = 250
      Top = 1
      Width = 742
      Height = 339
      ControlType.Strings = (
        'HasChildern;CheckBox;T;F')
      Selected.Strings = (
        'Caption'#9'20'#9'Item'
        'description'#9'15'#9'Description'
        'Processstep'#9'15'#9'Process'
        'ToBeBuilt'#9'5'#9'To Be Built'#9#9'Build Quantity'
        'ManufacturedUOMQty'#9'5'#9'Built'#9#9'Build Quantity'
        'ManufactureUOMQty'#9'5'#9'Ordered'#9#9'Build Quantity'
        'FromStockUOMQty'#9'5'#9'From Stock'#9#9'Stock Quantity'
        'OnOrderUOMQty'#9'5'#9'On Order'#9#9'Stock Quantity'
        'ManufacturingUOMQty'#9'5'#9'Used'#9#9'Stock Quantity')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.SaveToRegistry = True
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alRight
      BorderStyle = bsNone
      Color = clWhite
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
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
      TitleLines = 2
      TitleButtons = True
      LineColors.GroupingColor = clSilver
      OnCalcCellColors = grdMainCalcCellColors
      FooterCellColor = clWhite
      ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
      PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
      HelpContext = 1647013
      object btnGrid: TwwIButton
        Left = 0
        Top = 0
        Width = 13
        Height = 22
        AllowAllUp = True
        HelpContext = 1647014
      end
    end
    object pnlDetails: TDNMPanel
      Left = 1
      Top = 1
      Width = 247
      Height = 339
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      HelpContext = 1647015
      object DBText1: TDBText
        AlignWithMargins = True
        Left = 4
        Top = 11
        Width = 239
        Height = 44
        HelpContext = 1647016
        Margins.Top = 10
        Align = alTop
        DataField = 'PTcaption'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitLeft = 2
        ExplicitTop = 12
        ExplicitWidth = 390
      end
      object lblTimerMsg: TLabel
        Left = 1
        Top = 322
        Width = 245
        Height = 16
        Cursor = crHandPoint
        Align = alBottom
        Alignment = taCenter
        Caption = 'TimerMsg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlowSize = 2
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
        ExplicitWidth = 62
        HelpContext = 1647017
      end
      object pnlQty: TDNMPanel
        Left = 1
        Top = 58
        Width = 245
        Height = 94
        HelpContext = 1647018
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblQtytoBeinvoiced: TLabel
          AlignWithMargins = True
          Left = 42
          Top = 3
          Width = 200
          Height = 29
          HelpContext = 1647019
          Margins.Left = 42
          Align = alTop
          Caption = 'Place Into Stock'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          ExplicitWidth = 186
        end
        object edtUOMQty: TEdit
          AlignWithMargins = True
          Left = 44
          Top = 38
          Width = 139
          Height = 53
          HelpContext = 1647020
          Margins.Left = 44
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnEnter = edtUOMQtyEnter
          ExplicitHeight = 44
        end
      end
      object pnlChooseRpt: TDNMPanel
        AlignWithMargins = True
        Left = 4
        Top = 155
        Width = 239
        Height = 164
        HelpContext = 1647021
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 158
        ExplicitWidth = 245
        object chkChooseRpt: TCheckBox
          AlignWithMargins = True
          Left = 34
          Top = 84
          Width = 193
          Height = 76
          HelpContext = 1647022
          Margins.Left = 33
          Margins.Right = 11
          TabStop = False
          Align = alClient
          Caption = 'Choose Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          ExplicitWidth = 199
        end
        object chkPrintReport: TCheckBox
          AlignWithMargins = True
          Left = 34
          Top = 4
          Width = 193
          Height = 74
          HelpContext = 1647023
          Margins.Left = 33
          Margins.Right = 11
          TabStop = False
          Align = alTop
          Caption = 'Print Report When Built'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          ExplicitWidth = 199
        end
      end
    end
  end
  object pnlButtons: TDNMPanel [8]
    Left = 0
    Top = 426
    Width = 993
    Height = 106
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 1647024
  end
  inherited tmrProcessMessage: TTimer
    Left = 740
    Top = 240
  end
  inherited tmrdelay: TTimer
    Left = 776
    Top = 240
  end
  inherited popSpelling: TPopupMenu
    Left = 424
    Top = 240
  end
  inherited tmrdelayMsg: TTimer
    Left = 704
    Top = 240
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 529
    Top = 240
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 565
    Top = 240
  end
  inherited MyConnection: TERPConnection
    Left = 354
    Top = 207
  end
  inherited DataState: TDataState
    Left = 600
    Top = 240
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 459
    Top = 240
  end
  inherited imgsort: TImageList
    Left = 635
    Top = 240
    Bitmap = {
      494C010102004801F40210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 354
    Top = 240
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 670
    Top = 240
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 494
    Top = 240
  end
  inherited qryMemTrans: TERPQuery
    Left = 389
    Top = 240
  end
  inherited tmrOnshow: TTimer
    Left = 816
    Top = 240
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Distinct '
      'S.saleId ,'
      'SL.SaleLineID,'
      'S.converted,'
      'SL.productNAme, '
      
        'concat(SL.UnitofMeasureSaleLines , "(", SL.UnitofMeasureMultipli' +
        'er , ")") AS UOM,'
      'if(IFNULL(P.partsID,0) =0 , "F" , "T") AS isProduct , '
      'P.parttype ,'
      'PT.description, '
      'TreeNodeCaption(PT.Level, PT.Caption) as Caption,'
      'if(IFNULL(PTC.ProctreeId,0) =0 , "F" , "T") AS HasChildern,'
      'PT.ManufactureUOMQty , '
      'PT.FromStockUOMQty , '
      'PT.OnOrderUOMQty,'
      'PT.proctreeId ,'
      'PT.ManufacturedUOMQty , '
      'PT.ManufacturingUOMQty,'
      
        'if (IFNULL(PTC.ProctreeId,0)<>0 AND IFNULL(P.partsID,0) <>0 AND ' +
        'IFNULL(PT.ManufactureUOMQty,0)- IFNULL(PT.ManufacturedUOMQty,0)>' +
        '=1 ,"T","F") AS CanBuild,'
      
        'convert(if (IFNULL(PTC.ProctreeId,0)<>0 AND IFNULL(P.partsID,0) ' +
        '<>0 ,IFNULL(PT.ManufactureUOMQty,0)- IFNULL(PT.ManufacturedUOMQt' +
        'y,0) ,0), Decimal) AS ToBeBuilt,'
      'Pt.caption as Ptcaption,'
      
        'if(IFNULL(PT.treeRootID,0) = IFNULL(PT.proctreeID,0),"T" , "F" )' +
        ' AS Isroot,'
      'S.IsInternalOrder'
      'FROM tblSales S'
      'inner join tblsaleslines SL  ON SL.SaleId = S.SaleID'
      
        'INNER JOIN tblProctree PT ON SL.SaleLineID = PT.masterID AND PT.' +
        'MasterType <> '#39'mtProduct'#39
      'LEFT JOIN tblParts P ON P.partsId = PT.partsID'
      'LEFT JOIN tblProcTree PTC ON PT.ProctreeID = PTC.parentID'
      'Where (SL.SaleLineId = :SaleLineID )'
      '/*Where (SL.SaleLineId = :SaleLineID or :SaleLineID=0) and '
      '(PT.proctreeID= :ProcTreeID or :ProcTreeID =0) and '
      '( :SaleLineID<>0 or  :ProcTreeID<>0)*/'
      'ORDER BY PT.sequenceDown')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryMainBeforeOpen
    AfterOpen = qryMainAfterOpen
    AfterScroll = qryMainAfterScroll
    Left = 851
    Top = 240
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SaleLineID'
        Value = 0
      end>
    object qryMainCaption: TWideStringField
      DisplayLabel = 'Item'
      DisplayWidth = 20
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 255
    end
    object qryMaindescription: TWideStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Origin = 'PT.Description'
      Size = 255
    end
    object qryMainProcessstep: TWideStringField
      DisplayLabel = 'Process'
      DisplayWidth = 15
      FieldName = 'Processstep'
      Size = 255
    end
    object qryMainToBeBuilt: TFloatField
      DisplayLabel = 'To Be Built'
      DisplayWidth = 5
      FieldName = 'ToBeBuilt'
      Origin = 'ToBeBuilt'
    end
    object qryMainManufacturedUOMQty: TFloatField
      DisplayLabel = 'Built'
      DisplayWidth = 5
      FieldName = 'ManufacturedUOMQty'
      Origin = 'PT.ManufacturedUOMQty'
    end
    object qryMainManufactureUOMQty: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 5
      FieldName = 'ManufactureUOMQty'
      Origin = 'PT.ManufactureUOMQty'
    end
    object qryMainFromStockUOMQty: TFloatField
      DisplayLabel = 'From Stock'
      DisplayWidth = 5
      FieldName = 'FromStockUOMQty'
      Origin = 'PT.FromStockUOMQty'
    end
    object qryMainOnOrderUOMQty: TFloatField
      DisplayLabel = 'On Order'
      DisplayWidth = 5
      FieldName = 'OnOrderUOMQty'
      Origin = 'PT.OnOrderUOMQty'
    end
    object qryMainManufacturingUOMQty: TFloatField
      DisplayLabel = 'Used'
      DisplayWidth = 5
      FieldName = 'ManufacturingUOMQty'
      Origin = 'PT.ManufacturingUOMQty'
    end
    object qryMainSaleLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 5
      FieldName = 'SaleLineID'
      Origin = 'SL.SaleLineID'
      Visible = False
    end
    object qryMainHasChildern: TWideStringField
      DisplayLabel = 'Has Childern?'
      DisplayWidth = 5
      FieldName = 'HasChildern'
      Origin = 'HasChildern'
      Visible = False
      Size = 1
    end
    object qryMainsaleId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'saleId'
      Origin = 'S.SaleID'
      Visible = False
    end
    object qryMainconverted: TWideStringField
      DisplayWidth = 1
      FieldName = 'converted'
      Origin = 'S.Converted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainproductNAme: TWideStringField
      DisplayWidth = 255
      FieldName = 'productNAme'
      Origin = 'SL.ProductName'
      Visible = False
      Size = 255
    end
    object qryMainUOM: TWideStringField
      DisplayWidth = 279
      FieldName = 'UOM'
      Origin = 'UOM'
      Visible = False
      Size = 279
    end
    object qryMainisProduct: TWideStringField
      DisplayWidth = 1
      FieldName = 'isProduct'
      Origin = 'isProduct'
      Visible = False
      Size = 1
    end
    object qryMainparttype: TWideStringField
      DisplayWidth = 13
      FieldName = 'parttype'
      Origin = 'P.PARTTYPE'
      Visible = False
      Size = 13
    end
    object qryMainproctreeId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'proctreeId'
      Origin = 'PT.ProcTreeId'
      Visible = False
    end
    object qryMainCanBuild: TWideStringField
      FieldName = 'CanBuild'
      Origin = 'CanBuild'
      Visible = False
      Size = 1
    end
    object qryMainPTcaption: TWideStringField
      FieldName = 'PTcaption'
      Origin = 'PT.Caption'
      Visible = False
      Size = 255
    end
    object qryMainIsroot: TWideStringField
      FieldName = 'Isroot'
      Origin = 'Isroot'
      Visible = False
      Size = 1
    end
    object qryMainIsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      Origin = 'S.IsInternalOrder'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 854
    Top = 207
  end
  object c: TActionList
    Left = 899
    Top = 237
    object actclose: TDNMAction
      Caption = 'CLOSE'
      HelpContext = 1647025
      ImageIndex = 766
      OnExecute = actcloseExecute
      buttoncolor = clWhite
    end
    object actSave: TDNMAction
      Caption = 'MAKE INVOICE'
      HelpContext = 1647026
      ImageIndex = 765
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
      buttoncolor = clWhite
    end
    object actAllocate: TDNMAction
      Caption = 'ALLOCATE'
      ImageIndex = 15
      OnExecute = actAllocateExecute
      buttoncolor = clWhite
      HelpContext = 1647027
    end
  end
end
