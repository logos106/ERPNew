inherited frmProductOptionsDesignGUI: TfrmProductOptionsDesignGUI
  Left = 348
  Top = 139
  HelpContext = 380000
  Caption = 'Product Options - Design'
  ClientHeight = 621
  ClientWidth = 1278
  OldCreateOrder = True
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitLeft = 8
  ExplicitTop = -227
  ExplicitWidth = 1284
  ExplicitHeight = 650
  DesignSize = (
    1278
    621)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 621
    Width = 1278
    HelpContext = 380018
    ExplicitTop = 542
    ExplicitWidth = 825
  end
  inherited shapehint: TShape
    Left = 19
    ExplicitLeft = 15
  end
  inherited imgGridWatermark: TImage
    HelpContext = 380001
  end
  inherited shapehintextra1: TShape
    Left = 90
    ExplicitLeft = 74
  end
  object pnlTitle: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1278
    Height = 45
    HelpContext = 380015
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 1276
      Height = 43
      HelpContext = 380016
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
        Width = 1276
        Height = 43
        HelpContext = 380017
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Product Options - Design'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitTop = 4
        ExplicitWidth = 353
      end
    end
  end
  object pnlProduct: TDNMPanel [6]
    Left = 0
    Top = 45
    Width = 1278
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object lbProduct: TLabel
      Left = 8
      Top = 12
      Width = 45
      Height = 15
      Caption = 'Product'
    end
    object lbProductName: TLabel
      Left = 240
      Top = 12
      Width = 81
      Height = 15
      Caption = 'Product Name'
    end
    object lbEdCost: TLabel
      Left = 728
      Top = 12
      Width = 26
      Height = 15
      Caption = 'Cost'
    end
    object lbEdPrice: TLabel
      Left = 912
      Top = 12
      Width = 30
      Height = 15
      Caption = 'Price'
    end
    object edProductName: TDBEdit
      Left = 326
      Top = 7
      Width = 387
      Height = 23
      DataField = 'PARTNAME'
      DataSource = dsProductDetails
      Enabled = False
      TabOrder = 0
    end
    object edCost: TDBEdit
      Left = 766
      Top = 9
      Width = 99
      Height = 23
      DataField = 'COST1'
      DataSource = dsProductDetails
      Enabled = False
      TabOrder = 1
    end
    object edPrice: TDBEdit
      Left = 950
      Top = 9
      Width = 83
      Height = 23
      DataField = 'PRICE1'
      DataSource = dsProductDetails
      Enabled = False
      TabOrder = 2
    end
    object cbProduct: TERPDbLookupCombo
      Left = 63
      Top = 9
      Width = 171
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'35'#9'PARTNAME'#9'F'
        'COST1'#9'10'#9'Cost'#9'F'
        'PRICE1'#9'10'#9'Price'#9'F')
      DataField = 'PARTNAME'
      DataSource = dsProductDetails
      LookupTable = qryProductLookup
      LookupField = 'Partname'
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      OnAfterchange = cbProductChange
      OnBeforeOpenList = cbProductBeforeOpenList
      OnAfterOpenList = cbProductAfterOpenList
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'partsid'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
  end
  object tvProduct: TTreeView [7]
    Left = 0
    Top = 83
    Width = 217
    Height = 538
    Align = alLeft
    BevelInner = bvNone
    BevelOuter = bvNone
    Ctl3D = False
    HideSelection = False
    Indent = 19
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 2
    OnClick = tvProductClick
  end
  object ToolPanel: TDNMPanel [8]
    Left = 1099
    Top = 83
    Width = 179
    Height = 538
    Align = alRight
    BevelOuter = bvNone
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    object rgLevel: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 173
      Height = 66
      Align = alTop
      Caption = 'Level'
      ItemIndex = 0
      Items.Strings = (
        'Add to New Level'
        'Add to Existing Level')
      TabOrder = 0
      OnClick = rgLevelClick
    end
    object btnAdd: TDNMSpeedButton
      Left = 34
      Top = 91
      Width = 105
      Height = 26
      Caption = 'Add Option'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnAddClick
    end
    object btnEdit: TDNMSpeedButton
      Left = 34
      Top = 123
      Width = 105
      Height = 26
      Caption = 'Edit Option'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnEditClick
    end
    object btnDelete: TDNMSpeedButton
      Left = 34
      Top = 155
      Width = 105
      Height = 26
      Caption = 'Delete Option'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnDeleteClick
    end
    object dnmAddOption: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 208
      Width = 172
      Height = 73
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      object btnAddFromTemplate: TDNMSpeedButton
        Left = 6
        Top = 10
        Width = 159
        Height = 26
        Caption = 'Add Options from Template'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnAddFromTemplateClick
      end
      object cbTemplates: TComboBox
        Left = 16
        Top = 42
        Width = 145
        Height = 23
        Sorted = True
        TabOrder = 1
        OnChange = cbTemplatesChange
      end
    end
    object cbAddAllLevel: TCheckBox
      Left = 15
      Top = 291
      Width = 154
      Height = 17
      Caption = 'Copy to all at same level'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object btnClose: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 509
      Width = 173
      Height = 26
      HelpContext = 380011
      Align = alBottom
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object btnCompleted: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 477
      Width = 173
      Height = 26
      HelpContext = 380014
      Align = alBottom
      Caption = '&Save Product'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
  end
  object sbDesign: TScrollBox [9]
    Left = 217
    Top = 83
    Width = 882
    Height = 538
    Align = alClient
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    object pnlName: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 479
      Width = 874
      Height = 54
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label4: TLabel
        Left = 8
        Top = 17
        Width = 73
        Height = 15
        Caption = 'Option Name'
      end
      object lbOptionCost: TLabel
        Left = 381
        Top = 17
        Width = 66
        Height = 15
        Caption = 'Option Cost'
      end
      object lbOptionPrice: TLabel
        Left = 537
        Top = 17
        Width = 70
        Height = 15
        Caption = 'Option Price'
      end
      object edOPtionName: TEdit
        Left = 85
        Top = 15
        Width = 291
        Height = 21
        Enabled = False
        TabOrder = 0
      end
      object edOPtionPrice: TEdit
        Left = 614
        Top = 15
        Width = 71
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
      end
      object edOptionCost: TEdit
        Left = 463
        Top = 15
        Width = 67
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 2
      end
    end
    object edPartsID: TEdit
      Left = 674
      Top = -3
      Width = 83
      Height = 21
      Enabled = False
      TabOrder = 1
      Visible = False
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 436
    Top = 160
  end
  inherited tmrdelay: TTimer
    Left = 472
    Top = 160
  end
  inherited popSpelling: TPopupMenu
    Left = 96
    Top = 32
  end
  inherited tmrdelayMsg: TTimer
    Left = 8
    Top = 144
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 132
    Top = 6
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 69
    Top = 6
  end
  inherited MyConnection: TERPConnection
    Database = 'kashi_sample_company'
    Server = 'localhost'
    Left = 100
    Top = 5
  end
  inherited DataState: TDataState
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 227
    Top = 9
    object mnuCopyToClipboard: TMenuItem
      Caption = 'Copy To Clipboard'
      HelpContext = 380034
    end
    object mnuPasteFromClipboard: TMenuItem
      Caption = 'Paste From Clipboard'
      HelpContext = 380035
    end
  end
  inherited imgsort: TImageList
    Top = 56
    Bitmap = {
      494C010102008400640210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 466
    Top = 456
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 262
    Top = 48
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 326
    Top = 88
  end
  inherited qryMemTrans: TERPQuery
    Left = 501
    Top = 456
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 17
    Top = 26
    object actMemTrans: TAction
      Caption = 'Memorise Transaction'
      HelpContext = 380026
    end
    object actMemTransAuto: TAction
      Caption = 'Memorize Auto Transaction'
      HelpContext = 380027
    end
  end
  object popMemTrans: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 612
    Top = 61
    object MemorizeTransaction1: TMenuItem
      Action = actMemTrans
    end
    object MemorizeAutoTransaction1: TMenuItem
      Action = actMemTransAuto
    end
    object mnuAuditTrail: TMenuItem
      Caption = 'Audit Trail'
      HelpContext = 380028
    end
  end
  object qryGeneral: TERPQuery
    Connection = MyConnection
    Left = 541
    Top = 456
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        '#DUMMY QUERY - Order.Formcreate dynamically changes the query fo' +
        'r seach options '
      'SELECT '
      'Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1),255) AS Manuf  , '
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) AS Type  ,'
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) AS Dept  ,'
      'P.PARTSID as PARTSID,'
      'P.PARTTYPE as PARTTYPE,'
      'P.PRODUCTGROUP as PRODUCTGROUP,'
      'P.PARTNAME as PARTNAME,'
      'P.PARTSDESCRIPTION as PARTSDESCRIPTION,'
      'P.INCOMEACCNT as INCOMEACCNT,'
      'P.PurchaseDesc as PurchaseDesc,'
      'P.ASSETACCNT as ASSETACCNT,'
      'P.COGSACCNT as COGSACCNT,'
      'P.BARCODE as BARCODE,'
      'P.PRODUCTCODE as PRODUCTCODE,'
      'P.PURCHTAXCODE as PURCHTAXCODE,'
      'P.PREFEREDSUPP as PREFEREDSUPP,'
      'P.Batch as Batch,'
      'P.SpecialDiscount as SpecialDiscount,'
      'P.SNTracking as SNTracking,'
      'P.BuyQTY1 as BuyQTY1,'
      'P.BuyQTY2 as BuyQTY2,'
      'P.BuyQTY3 as BuyQTY3,'
      'P.COST1 as COST1,'
      'P.COST2 as COST2,'
      'P.COST3 as COST3,'
      'P.SellQTY1 as SellQTY1,'
      'P.SellQTY2 as SellQTY2,'
      'P.SellQTY3 as SellQTY3,'
      'P.PRICE1 as PRICE1,'
      'P.PRICE2 as PRICE2,'
      'P.PRICE3 as PRICE3,'
      'P.WHOLESALEPRICE as WHOLESALEPRICE,'
      'P.Active as Active,'
      'P.EditedFlag as EditedFlag,'
      'P.MultipleBins as MultipleBins,'
      'P.AvgCost as AvgCost,'
      'P.Discontinued as Discontinued,'
      'P.Attrib1Purchase as Attrib1Purchase,'
      'P.Attrib2Purchase as Attrib2Purchase,'
      'P.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      
        'if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCos' +
        'tPrice ,'
      'P.taxcode as TaxCode,'
      'p.LatestCost as LatestCost,'
      'p.AutoBatch as AutoBatch, '
      'p.Attrib1Sale as Attrib1Sale,'
      'p.Attrib2Sale as Attrib2Sale,'
      'p.Attrib1SaleRate as Attrib1SaleRate,'
      'P.LatestCostDate as LatestCostDate,'
      'SupplierProductCode,'
      'P.GeneralNotes,'
      '`P`.`CUSTFLD1`,'
      '`P`.`CUSTFLD2`,'
      '`P`.`CUSTFLD3`,'
      '`P`.`CUSTFLD4`,'
      '`P`.`CUSTFLD5`,'
      '`P`.`CUSTFLD6`,'
      '`P`.`CUSTFLD7`,'
      '`P`.`CUSTFLD8`,'
      '`P`.`CUSTFLD9`,'
      '`P`.`CUSTFLD10`,'
      '`P`.`CUSTFLD11`,'
      '`P`.`CUSTFLD12`,'
      '`P`.`CUSTFLD13`,'
      '`P`.`CUSTFLD14`,'
      '`P`.`CUSTFLD15`,'
      '`P`.`CUSTDATE1`,'
      '`P`.`CUSTDATE2`,'
      '`P`.`CUSTDATE3`'
      'FROM `tblParts` P'
      'WHERE P.Active = "T"'
      ' AND ('
      '  ((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        'or ((:SearchMode = 1) and ((Partname  LIKE Concat(:SearchValue,"' +
        '%"))  or (PREFEREDSUPP  LIKE Concat(:SearchValue,"%"))   or (Pur' +
        'chaseDesc LIKE Concat(:SearchValue,"%"))   or (Left(SUBSTRING_IN' +
        'DEX(P.ProductGroup,'#39'^'#39',1),255) LIKE Concat(:SearchValue,"%"))   ' +
        'or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_le' +
        'ngth(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Concat(' +
        ':SearchValue,"%"))   or (Left(substring(substring_index(P.Produc' +
        'tGroup,'#39'^'#39',3),char_length(substring_index(P.ProductGroup,'#39'^'#39',2))' +
        '+2),255) LIKE Concat(:SearchValue,"%"))  )) '
      
        'or ((:SearchMode = 2) and (Trim(:SearchValue) <> "") and ((Partn' +
        'ame  LIKE Concat("%",:SearchValue,"%"))   or (PREFEREDSUPP  LIKE' +
        ' Concat("%",:SearchValue,"%"))   or (PurchaseDesc LIKE Concat("%' +
        '",:SearchValue,"%"))  or (Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^' +
        #39',1),255) LIKE Concat("%",:SearchValue,"%"))  or (Left(substring' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(substring_ind' +
        'ex(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Concat("%",:SearchValue,"' +
        '%"))  or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),c' +
        'har_length(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) LIKE C' +
        'oncat("%",:SearchValue,"%"))  )) '
      ')'
      'and IfNull(:SearchValue,"") <> ""')
    Options.LongStrings = False
    Left = 315
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'P.PARTSID as PARTSID,'
      'P.PARTNAME as PARTNAME,'
      'P.COST1 as COST1,'
      'P.PRICE1 as PRICE1 '
      'FROM `tblParts` P'
      'WHERE P.Active = "T"'
      'AND P.PARTTYPE = "INV"')
    Options.LongStrings = False
    Left = 595
    Top = 456
    object cboProductQryPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object cboProductQryPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 255
    end
    object cboProductQryCOST1: TFloatField
      FieldName = 'COST1'
      currency = True
    end
    object cboProductQryPRICE1: TFloatField
      FieldName = 'PRICE1'
      currency = True
    end
  end
  object dsProductDetails: TDataSource
    DataSet = cboProductQry
    Left = 595
    Top = 488
  end
  object qryProductLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'P.PARTSID as PARTSID,'
      'P.PARTNAME as PARTNAME,'
      'P.COST1 as COST1,'
      'P.PRICE1 as PRICE1 '
      'FROM `tblParts` P'
      'WHERE P.Active = "T"'
      'AND P.PARTTYPE = "INV"'
      'AND P.HasProductOptions = "T"'
      
        '-- AND NOT EXISTS (SELECT 1 FROM tblProductHeader h WHERE h.true' +
        'erp_product_id = p.PartsId)'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (PartName LIKE Concat(:SearchValue,"%"' +
        ')))'
      
        'or ((:SearchMode = 2) and (PartName LIKE Concat("%",:SearchValue' +
        ',"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Options.LongStrings = False
    Left = 659
    Top = 456
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryProductLookupPARTNAME: TWideStringField
      DisplayWidth = 35
      FieldName = 'PARTNAME'
      Size = 255
    end
    object qryProductLookupCOST1: TFloatField
      DisplayLabel = 'Cost'
      DisplayWidth = 10
      FieldName = 'COST1'
      currency = True
    end
    object qryProductLookupPRICE1: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 10
      FieldName = 'PRICE1'
      currency = True
    end
    object qryProductLookupPARTSID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Visible = False
    end
  end
  object VTable: TVirtualTable
    Left = 600
    Top = 136
    Data = {03000000000000000000}
  end
end
