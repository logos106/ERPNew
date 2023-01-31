inherited fmStockToFixedAsset: TfmStockToFixedAsset
  HelpContext = 1407002
  Caption = 'Product To Fixed Asset'
  ClientWidth = 996
  ExplicitWidth = 1012
  ExplicitHeight = 240
  DesignSize = (
    996
    532)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 491
    Width = 996
    HelpContext = 1407003
    ExplicitTop = 491
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object pnlTop: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 996
    Height = 137
    HelpContext = 1407011
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      137)
    object Label1: TLabel
      Left = 53
      Top = 74
      Width = 65
      Height = 15
      HelpContext = 1407012
      Caption = 'Description'
    end
    object Label2: TLabel
      Left = 685
      Top = 74
      Width = 77
      Height = 15
      HelpContext = 1407013
      Caption = 'Creation Date'
    end
    object Label3: TLabel
      Left = 53
      Top = 103
      Width = 62
      Height = 15
      HelpContext = 1407014
      Caption = 'Created By'
    end
    object Label4: TLabel
      Left = 685
      Top = 103
      Width = 91
      Height = 15
      HelpContext = 1407015
      Caption = 'Processed Date'
    end
    object pnlTitle: TDNMPanel
      Left = 260
      Top = 7
      Width = 475
      Height = 41
      HelpContext = 1407016
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 471
        Height = 37
        HelpContext = 1407017
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
          Width = 471
          Height = 37
          HelpContext = 1407018
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Product To Fixed Asset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 326
        end
      end
    end
    object edtDescription: TwwDBEdit
      Left = 136
      Top = 71
      Width = 489
      Height = 23
      HelpContext = 1407019
      DataField = 'Description'
      DataSource = dsMain
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
    object edtCreationDate: TwwDBEdit
      Left = 793
      Top = 71
      Width = 104
      Height = 23
      HelpContext = 1407020
      DataField = 'CreationDate'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtEmployeeName: TwwDBEdit
      Left = 136
      Top = 100
      Width = 185
      Height = 23
      HelpContext = 1407021
      DataField = 'EmployeeName'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkProcessed: TwwCheckBox
      Left = 394
      Top = 103
      Width = 94
      Height = 17
      HelpContext = 1407022
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Processed'
      DataField = 'Processed'
      DataSource = dsMain
      TabOrder = 4
      ReadOnly = True
    end
    object edtProcessDate: TwwDBEdit
      Left = 793
      Top = 100
      Width = 104
      Height = 23
      HelpContext = 1407023
      DataField = 'ProcessDate'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object grdLines: TwwDBGrid [6]
    Left = 0
    Top = 137
    Width = 996
    Height = 354
    HelpContext = 1407024
    ControlType.Strings = (
      'IsHireAsset;CustomEdit;chkIsHire;F'
      'ProductName;CustomEdit;cboProduct;F'
      'DeptClassName;CustomEdit;cboDeptClass;F'
      'AssetType;CustomEdit;cboAssetType;F')
    Selected.Strings = (
      'ProductName'#9'20'#9'Product Name'#9#9
      'ProductType'#9'10'#9'Product Type'#9#9
      'AssetName'#9'20'#9'Asset Name'#9#9
      'AssetDescription'#9'20'#9'Asset Description'#9'F'
      'AssetCode'#9'10'#9'Asset Code'#9#9
      'IsHireAsset'#9'1'#9'Is Hire Asset'#9#9
      'AssetType'#9'15'#9'Asset Type'#9#9
      'PurchaseCost'#9'10'#9'Purchase Cost'#9#9
      'PurchaseDate'#9'10'#9'Purchase Date'#9#9
      'BatchNUmber'#9'10'#9'Batch No'#9#9
      'BatchExpiryDate'#9'18'#9'Batch Expiry'#9#9
      'BinNumber'#9'10'#9'Bin No'#9#9
      'BinLocation'#9'10'#9'Bin Location'#9#9
      'SerialNumber'#9'10'#9'Serial No'#9#9
      'DeptClassName'#9'10'#9'Class Name'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsDetail
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
    OnColEnter = grdLinesColEnter
    OnDblClick = grdLinesDblClick
    object grdLinesIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 22
      Height = 22
      HelpContext = 1407025
      AllowAllUp = True
      Glyph.Data = {
        C6030000424DC603000000000000360000002800000010000000130000000100
        18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
        666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
        99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
        CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
        333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
        99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
        C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
        C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
        77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
        8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
        B2B2B2808080333366000080333366777777777777333366000080333399C0C0
        C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
        0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
        CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
        0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
        868686808080666699333399333399000080333366666666808080969696C0C0
        C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
        8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
        B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
        80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
        CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
        99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
        D7CCCCCCCCCCCCCCCCCC}
      OnClick = grdLinesIButtonClick
    end
  end
  object cboDeptClass: TwwDBLookupCombo [7]
    Left = 234
    Top = 200
    Width = 121
    Height = 23
    HelpContext = 1407026
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'DeptClassName'
    DataSource = dsDetail
    LookupTable = qryDepClassLookup
    LookupField = 'ClassName'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object cboAssetType: TwwDBLookupCombo [8]
    Left = 420
    Top = 195
    Width = 121
    Height = 23
    HelpContext = 1407027
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'AssetType'
    DataSource = dsDetail
    LookupTable = qryAssetTypeLookup
    LookupField = 'AssetTypeCode'
    ParentFont = False
    TabOrder = 4
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnChange = cboAssetTypeChange
    OnCloseUp = cboAssetTypeCloseUp
  end
  object chkIsHire: TwwCheckBox [9]
    Left = 704
    Top = 200
    Width = 97
    Height = 17
    HelpContext = 1407028
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    DataField = 'IsHireAsset'
    DataSource = dsDetail
    TabOrder = 5
    OnClick = chkIsHireClick
  end
  object pnlBottom: TDNMPanel [10]
    Left = 0
    Top = 491
    Width = 996
    Height = 41
    HelpContext = 1407004
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      41)
    object btnSave: TDNMSpeedButton
      Left = 239
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 1407005
      Caption = 'Save'
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
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 671
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 1407006
      Caption = 'Cancel'
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
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object chkActive: TwwCheckBox
      Left = 922
      Top = 13
      Width = 65
      Height = 17
      HelpContext = 1407007
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsMain
      TabOrder = 2
    end
    object btnSelect: TDNMSpeedButton
      Left = 347
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 1407008
      Caption = 'Select Prod'#39's'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnSelectClick
    end
    object btnProcess: TDNMSpeedButton
      Left = 455
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 1407009
      Caption = 'Process'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnProcessClick
    end
    object btnStockAdjustment: TDNMSpeedButton
      Left = 563
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 1407010
      Caption = 'Stock Adj'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnStockAdjustmentClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 860
    Top = 8
  end
  inherited tmrdelay: TTimer
    Left = 896
    Top = 8
  end
  inherited popSpelling: TPopupMenu
    Left = 544
    Top = 8
  end
  inherited tmrdelayMsg: TTimer
    Left = 72
    Top = 8
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 649
    Top = 8
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 685
    Top = 8
  end
  inherited MyConnection: TERPConnection
    
    Left = 18
    Top = 7
  end
  inherited DataState: TDataState
    Left = 720
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 579
    Top = 8
  end
  inherited imgsort: TImageList
    Left = 755
    Top = 8
    Bitmap = {
      494C010102004401980110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 474
    Top = 8
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 790
    Top = 8
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 614
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 509
    Top = 8
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblStockToFixedAsset')
    Left = 552
    Top = 296
    object qryMainGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainStockToFixedAssetID: TIntegerField
      FieldName = 'StockToFixedAssetID'
    end
    object qryMainCreationDate: TDateTimeField
      FieldName = 'CreationDate'
    end
    object qryMainProcessDate: TDateTimeField
      FieldName = 'ProcessDate'
    end
    object qryMainProcessed: TWideStringField
      FieldName = 'Processed'
      FixedChar = True
      Size = 1
    end
    object qryMainActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryMainDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryMainEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryMainEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryMainmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryMainStockAdjustEntryID: TIntegerField
      FieldName = 'StockAdjustEntryID'
    end
    object qryMainPurchaseOrderId: TIntegerField
      FieldName = 'PurchaseOrderId'
    end
  end
  object qryDetail: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblStockToFixedAssetLine')
    Left = 624
    Top = 296
    object qryDetailProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'tblstocktofixedassetline.ProductName'
      Size = 255
    end
    object qryDetailProductType: TWideStringField
      DisplayLabel = 'Product Type'
      DisplayWidth = 10
      FieldName = 'ProductType'
      Origin = 'tblstocktofixedassetline.ProductType'
      Size = 255
    end
    object qryDetailAssetName: TWideStringField
      DisplayLabel = 'Asset Name'
      DisplayWidth = 20
      FieldName = 'AssetName'
      Origin = 'tblstocktofixedassetline.AssetName'
      Size = 255
    end
    object qryDetailAssetDescription: TWideStringField
      DisplayLabel = 'Asset Description'
      DisplayWidth = 20
      FieldName = 'AssetDescription'
      Size = 255
    end
    object qryDetailAssetCode: TWideStringField
      DisplayLabel = 'Asset Code'
      DisplayWidth = 10
      FieldName = 'AssetCode'
      Origin = 'tblstocktofixedassetline.AssetCode'
      Size = 255
    end
    object qryDetailIsHireAsset: TWideStringField
      DisplayLabel = 'Is Hire Asset'
      DisplayWidth = 1
      FieldName = 'IsHireAsset'
      Origin = 'tblstocktofixedassetline.IsHireAsset'
      FixedChar = True
      Size = 1
    end
    object qryDetailAssetType: TWideStringField
      DisplayLabel = 'Asset Type'
      DisplayWidth = 15
      FieldName = 'AssetType'
      Size = 255
    end
    object qryDetailPurchaseCost: TFloatField
      DisplayLabel = 'Purchase Cost'
      DisplayWidth = 10
      FieldName = 'PurchaseCost'
      currency = True
    end
    object qryDetailPurchaseDate: TDateField
      DisplayLabel = 'Purchase Date'
      DisplayWidth = 10
      FieldName = 'PurchaseDate'
    end
    object qryDetailBatchNUmber: TWideStringField
      DisplayLabel = 'Batch No'
      DisplayWidth = 10
      FieldName = 'BatchNUmber'
      Origin = 'tblstocktofixedassetline.BatchNumber'
      Size = 255
    end
    object qryDetailBatchExpiryDate: TDateTimeField
      DisplayLabel = 'Batch Expiry'
      DisplayWidth = 18
      FieldName = 'BatchExpiryDate'
      Origin = 'tblstocktofixedassetline.BatchExpiryDate'
    end
    object qryDetailBinNumber: TWideStringField
      DisplayLabel = 'Bin No'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'tblstocktofixedassetline.BinNumber'
      Size = 255
    end
    object qryDetailBinLocation: TWideStringField
      DisplayLabel = 'Bin Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'tblstocktofixedassetline.BinLocation'
      Size = 255
    end
    object qryDetailSerialNumber: TWideStringField
      DisplayLabel = 'Serial No'
      DisplayWidth = 10
      FieldName = 'SerialNumber'
      Origin = 'tblstocktofixedassetline.SerialNumber'
      Size = 255
    end
    object qryDetailDeptClassName: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 10
      FieldName = 'DeptClassName'
      Size = 255
    end
    object qryDetailGlobalRef: TWideStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Origin = 'tblstocktofixedassetline.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryDetailStockToFixedAssetLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'StockToFixedAssetLineID'
      Origin = 'tblstocktofixedassetline.StockToFixedAssetLineID'
      Visible = False
    end
    object qryDetailStockToFixedAssetID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StockToFixedAssetID'
      Origin = 'tblstocktofixedassetline.StockToFixedAssetID'
      Visible = False
    end
    object qryDetailProductID: TIntegerField
      DisplayLabel = 'Product ID'
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblstocktofixedassetline.ProductID'
      Visible = False
    end
    object qryDetailIsBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsBatch'
      Origin = 'tblstocktofixedassetline.IsBatch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDetailIsBin: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsBin'
      Origin = 'tblstocktofixedassetline.IsBin'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDetailIsSerialNumber: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsSerialNumber'
      Origin = 'tblstocktofixedassetline.IsSerialNumber'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDetailmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblstocktofixedassetline.PurchaseCost'
      Visible = False
    end
    object qryDetailmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblstocktofixedassetline.DeptClassName'
      Visible = False
      Size = 3
    end
    object qryDetailAssetId: TIntegerField
      DisplayWidth = 10
      FieldName = 'AssetId'
      Origin = 'tblstocktofixedassetline.PurchaseDate'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 552
    Top = 352
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 624
    Top = 352
  end
  object qryDepClassLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select ClassName, ClassID from tblclass where Active = "T"')
    Left = 856
    Top = 384
    object qryDepClassLookupClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 60
    end
    object qryDepClassLookupClassID: TIntegerField
      FieldName = 'ClassID'
    end
  end
  object qryAssetTypeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select AssetTypeCode, AssetTypeID from tblfixedassettypes where ' +
        'Active = "T"')
    Left = 840
    Top = 304
    object qryAssetTypeLookupAssetTypeCode: TWideStringField
      FieldName = 'AssetTypeCode'
      Size = 50
    end
    object qryAssetTypeLookupAssetTypeID: TIntegerField
      FieldName = 'AssetTypeID'
    end
  end
end
