inherited POSCustomerDisplayGUI: TPOSCustomerDisplayGUI
  Left = 192
  Top = 200
  Hint = 'Copy|Copies the selection and puts it on the Clipboard'
  HelpContext = 423000
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'POS Customer Display'
  ClientHeight = 566
  ClientWidth = 792
  DefaultMonitor = dmDesktop
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Visible = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  ExplicitLeft = 192
  ExplicitTop = 200
  ExplicitWidth = 808
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 494
    Width = 792
    ExplicitTop = 494
    ExplicitWidth = 792
    HelpContext = 423009
  end
  object pnlDetails: TDNMPanel [4]
    Left = 0
    Top = 71
    Width = 792
    Height = 423
    HelpContext = 423005
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Details'
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -267
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object grdDisplayItems: TwwDBGrid
      Left = 0
      Top = 0
      Width = 792
      Height = 423
      HelpContext = 423006
      TabStop = False
      ControlType.Strings = (
        'Picture;Bitmap;Stretch To Fit;Source Copy')
      Selected.Strings = (
        'Qty'#9'5'#9'Qty'#9'F'
        'Description'#9'40'#9'Description'#9'F'#9
        'TotalPriceInc'#9'10'#9'TotalPriceInc'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWindow
      FixedCols = 0
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = True
      DataSource = DSGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgColumnResize, dgWordWrap, dgPerfectRowFit]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clMaroon
      TitleFont.Height = -13
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold, fsUnderline]
      TitleLines = 1
      TitleButtons = False
      LineColors.DataColor = clWindow
      LineColors.FixedColor = clWindow
      OnCalcTitleAttributes = grdDisplayItemsCalcTitleAttributes
      FooterColor = clWindow
      FooterCellColor = clWindow
    end
  end
  object pnlTitle: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 792
    Height = 71
    Cursor = crNo
    HelpContext = 423001
    Align = alTop
    Anchors = [akRight]
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      792
      71)
    object TitleLabel2: TLabel
      Left = 39
      Top = 0
      Width = 714
      Height = 56
      HelpContext = 423002
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Company Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -48
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 697
    end
    object TitleLabel1: TLabel
      Left = 39
      Top = 1
      Width = 714
      Height = 56
      HelpContext = 423003
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Company Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -48
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 697
    end
    object Label1: TLabel
      Left = 717
      Top = 0
      Width = 75
      Height = 71
      HelpContext = 423004
      Align = alRight
      AutoSize = False
      Transparent = True
      OnMouseEnter = Label1MouseEnter
      OnMouseLeave = Label1MouseLeave
      ExplicitLeft = 700
    end
  end
  object pnlMediaHost: TPanel [6]
    Left = 454
    Top = 108
    Width = 185
    Height = 96
    Caption = 'pnlMediaHost'
    TabOrder = 3
    HelpContext = 423010
    object pnlDisplay: TPanel
      Left = 0
      Top = 55
      Width = 185
      Height = 41
      Caption = 'pnlDisplay'
      TabOrder = 0
      HelpContext = 423011
    end
    object Player: TMediaPlayer
      Left = 0
      Top = 6
      Width = 253
      Height = 30
      DoubleBuffered = True
      Display = pnlDisplay
      Shareable = True
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 1
      HelpContext = 423012
    end
  end
  object pnlTotals: TDNMPanel [7]
    Left = 0
    Top = 494
    Width = 792
    Height = 72
    Cursor = crNo
    HelpContext = 423007
    Align = alBottom
    Anchors = []
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -48
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      792
      72)
    object TotalsLabel: TLabel
      Left = 0
      Top = 22
      Width = 786
      Height = 48
      HelpContext = 423008
      Alignment = taRightJustify
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = 'Sub Total : $0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -44
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 769
    end
  end
  object memGrid: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Picture'
        DataType = ftGraphic
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'TotalPriceInc'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AfterPost = memGridAfterPost
    Left = 41
    Top = 5
    object memGridQty: TWideStringField
      Alignment = taRightJustify
      DisplayWidth = 5
      FieldName = 'Qty'
    end
    object memGridDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Size = 255
    end
    object memGridTotalPriceInc: TCurrencyField
      DisplayWidth = 10
      FieldName = 'TotalPriceInc'
    end
    object memGridPicture: TGraphicField
      DisplayWidth = 15
      FieldName = 'Picture'
      Visible = False
      BlobType = ftGraphic
    end
    object memGridID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
  end
  object DSGrid: TDataSource
    DataSet = memGrid
    Left = 41
    Top = 34
  end
  object TmrSaveScreen: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TmrSaveScreenTimer
    Left = 88
    Top = 7
  end
  object tmrMedia: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrMediaTimer
    Left = 548
    Top = 216
  end
end
