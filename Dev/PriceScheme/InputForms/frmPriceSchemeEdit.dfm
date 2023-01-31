inherited fmPriceSchemeEdit: TfmPriceSchemeEdit
  Left = 466
  Top = 282
  HelpContext = 180000
  Caption = 'Price Scheme'
  ClientHeight = 480
  ClientWidth = 590
  OldCreateOrder = True
  ExplicitLeft = 466
  ExplicitTop = 282
  ExplicitWidth = 606
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 436
    Width = 590
    ExplicitTop = 436
    ExplicitWidth = 590
    HelpContext = 180032
  end
  object Label2: TLabel [1]
    Left = 16
    Top = 64
    Width = 83
    Height = 15
    HelpContext = 180002
    Caption = 'Scheme Name'
    Transparent = True
  end
  object Label1: TLabel [2]
    Left = 471
    Top = 64
    Width = 95
    Height = 15
    HelpContext = 180003
    Caption = 'Scheme Number'
    Transparent = True
  end
  object Label4: TLabel [3]
    Left = 16
    Top = 112
    Width = 76
    Height = 15
    HelpContext = 180004
    Caption = 'Scheme Type'
    Transparent = True
  end
  object Label5: TLabel [4]
    Left = 16
    Top = 160
    Width = 59
    Height = 15
    HelpContext = 180005
    Caption = 'Valid From'
    Transparent = True
  end
  object Label6: TLabel [5]
    Left = 136
    Top = 160
    Width = 43
    Height = 15
    HelpContext = 180006
    Caption = 'Valid To'
    Transparent = True
  end
  object Label7: TLabel [6]
    Left = 16
    Top = 304
    Width = 102
    Height = 15
    HelpContext = 180007
    Caption = 'Apply to Price List'
    Transparent = True
  end
  object Label8: TLabel [7]
    Left = 16
    Top = 256
    Width = 93
    Height = 15
    HelpContext = 180008
    Caption = 'Related Scheme'
    Transparent = True
  end
  object Label9: TLabel [8]
    Left = 261
    Top = 256
    Width = 34
    Height = 15
    HelpContext = 180009
    Caption = 'Credit'
    Transparent = True
  end
  object Label10: TLabel [9]
    Left = 16
    Top = 208
    Width = 30
    Height = 15
    HelpContext = 180010
    Caption = 'Price'
    Transparent = True
  end
  object Label11: TLabel [10]
    Left = 136
    Top = 208
    Width = 115
    Height = 15
    HelpContext = 180011
    Caption = 'Discount or Qty Free'
    Transparent = True
  end
  object Label3: TLabel [11]
    Left = 264
    Top = 112
    Width = 144
    Height = 15
    HelpContext = 180012
    Caption = 'Scheme Type Description'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 180001
  end
  object cboSchemeType: TwwDBComboBox [16]
    Left = 16
    Top = 128
    Width = 217
    Height = 23
    HelpContext = 180023
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DataField = 'SchemeType'
    DataSource = dsScheme
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Value One'#9'1'
      'Value Two'#9'2')
    ParentFont = False
    Sorted = False
    TabOrder = 3
    UnboundDataType = wwDefault
    OnChange = cboSchemeTypeChange
    OnCloseUp = cboSchemeTypeCloseUp
  end
  object edtDateFrom: TwwDBDateTimePicker [17]
    Left = 16
    Top = 176
    Width = 82
    Height = 23
    HelpContext = 180024
    Anchors = [akTop, akRight]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DateFrom'
    DataSource = dsScheme
    Date = 37432.000000000000000000
    Epoch = 1950
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 5
    UnboundDataType = wwDTEdtDate
  end
  object edtDateTo: TwwDBDateTimePicker [18]
    Left = 136
    Top = 176
    Width = 82
    Height = 23
    HelpContext = 180025
    Anchors = [akTop, akRight]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DateTo'
    DataSource = dsScheme
    Date = 37432.000000000000000000
    Epoch = 1950
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 6
    UnboundDataType = wwDTEdtDate
  end
  object cboRelatedScheme: TwwDBLookupCombo [19]
    Left = 16
    Top = 272
    Width = 225
    Height = 23
    HelpContext = 180026
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'SchemeName'#9'30'#9'Scheme Name'#9'F'
      'SchemeNumber'#9'10'#9'Number'#9'F')
    DataField = 'RelatedSchemeID'
    DataSource = dsScheme
    LookupTable = qryPriceSchemeLookup
    LookupField = 'PriceSchemeID'
    Style = csDropDownList
    TabOrder = 9
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object edtCredit: TwwDBEdit [20]
    Left = 261
    Top = 272
    Width = 97
    Height = 23
    HelpContext = 180027
    DataField = 'Credit'
    DataSource = dsScheme
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtPrice: TwwDBEdit [21]
    Left = 16
    Top = 224
    Width = 97
    Height = 23
    HelpContext = 180028
    DataField = 'Price'
    DataSource = dsScheme
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtDiscount: TwwDBEdit [22]
    Left = 136
    Top = 224
    Width = 97
    Height = 23
    HelpContext = 180029
    DataField = 'DiscountOrQtyFree'
    DataSource = dsScheme
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object grdItems: TwwDBGrid [23]
    Left = 16
    Top = 320
    Width = 553
    Height = 105
    HelpContext = 180030
    ControlType.Strings = (
      'PriceListNumber;CustomEdit;cboGridListNumber;F'
      'PriceListName;CustomEdit;cboGridListName;F')
    Selected.Strings = (
      'PriceListNumber'#9'20'#9'List Number'#9#9
      'PriceListName'#9'30'#9'List Name'#9#9
      'QuantityThreshold'#9'10'#9'Quantity Threshold'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsSchemeItems
    TabOrder = 11
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    FooterColor = clWhite
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 22
      Height = 22
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
      OnClick = wwDBGrid1IButtonClick
      HelpContext = 180033
    end
  end
  object cboGridListNumber: TwwDBLookupCombo [24]
    Left = 144
    Top = 360
    Width = 121
    Height = 23
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ListNumber'#9'30'#9'List Number'#9'F')
    DataField = 'PriceListNumber'
    DataSource = dsSchemeItems
    LookupTable = qryPriceListLookup2
    LookupField = 'ListNumber'
    TabOrder = 12
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    HelpContext = 180034
  end
  object cboGridListName: TwwDBLookupCombo [25]
    Left = 320
    Top = 368
    Width = 121
    Height = 23
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ListName'#9'30'#9'List Name'#9'F')
    DataField = 'PriceListName'
    DataSource = dsSchemeItems
    LookupTable = qryPriceListLookup2
    LookupField = 'ListName'
    TabOrder = 13
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    HelpContext = 180035
  end
  object memTypeDesc: TMemo [26]
    Left = 264
    Top = 128
    Width = 303
    Height = 65
    HelpContext = 180031
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object edtSchemeNumber: TwwDBEdit [27]
    Left = 469
    Top = 80
    Width = 97
    Height = 23
    HelpContext = 180022
    DataField = 'SchemeNumber'
    DataSource = dsScheme
    Font.Charset = ANSI_CHARSET
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
  object edtSchemeName: TwwDBEdit [28]
    Left = 16
    Top = 80
    Width = 433
    Height = 23
    HelpContext = 180021
    DataField = 'SchemeName'
    DataSource = dsScheme
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnExit = edtSchemeNameExit
  end
  object pnlBottom: TDNMPanel [29]
    Left = 0
    Top = 436
    Width = 590
    Height = 44
    HelpContext = 180016
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    DesignSize = (
      590
      44)
    object btnSave: TDNMSpeedButton
      Left = 144
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 180017
      Action = actSave
      Anchors = [akBottom]
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
    end
    object btnNew: TDNMSpeedButton
      Left = 252
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 180018
      Action = actNew
      Anchors = [akBottom]
      Caption = 'New'
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
      TabOrder = 1
    end
    object btnCancel: TDNMSpeedButton
      Left = 360
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 180019
      Action = actCancel
      Anchors = [akBottom]
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
      TabOrder = 2
    end
    object chkActive: TwwCheckBox
      Left = 509
      Top = 15
      Width = 65
      Height = 17
      HelpContext = 180020
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
      Anchors = [akTop, akRight]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsScheme
      TabOrder = 3
    end
  end
  object pnlTitle: TDNMPanel [30]
    Left = 81
    Top = 6
    Width = 428
    Height = 41
    HelpContext = 180013
    Anchors = [akLeft, akTop, akRight]
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
      Width = 424
      Height = 37
      HelpContext = 180014
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
        Width = 424
        Height = 37
        HelpContext = 180015
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Price Scheme'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801800110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object ActionList: TActionList
    Left = 192
    Top = 16
    object actSave: TAction
      Caption = 'Save'
      OnExecute = actSaveExecute
      HelpContext = 180036
    end
    object actCancel: TAction
      Caption = 'Cancel'
      OnExecute = actCancelExecute
      HelpContext = 180037
    end
    object actNew: TAction
      Caption = 'New'
      OnExecute = actNewExecute
      HelpContext = 180038
    end
  end
  object qryScheme: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblPriceScheme')
    AfterPost = qrySchemeAfterPost
    Left = 520
    object qrySchemePriceSchemeID: TIntegerField
      FieldName = 'PriceSchemeID'
    end
    object qrySchemeGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrySchemeSchemeNumber: TWideStringField
      FieldName = 'SchemeNumber'
      Size = 255
    end
    object qrySchemeSchemeName: TWideStringField
      FieldName = 'SchemeName'
      Size = 255
    end
    object qrySchemeSchemeType: TIntegerField
      FieldName = 'SchemeType'
    end
    object qrySchemePrice: TFloatField
      FieldName = 'Price'
      currency = True
    end
    object qrySchemeDateFrom: TDateField
      FieldName = 'DateFrom'
    end
    object qrySchemeDateTo: TDateField
      FieldName = 'DateTo'
    end
    object qrySchemeCredit: TFloatField
      FieldName = 'Credit'
      currency = True
    end
    object qrySchemeRelatedSchemeID: TIntegerField
      FieldName = 'RelatedSchemeID'
    end
    object qrySchemeDiscountOrQtyFree: TFloatField
      FieldName = 'DiscountOrQtyFree'
      DisplayFormat = '#0.00'
    end
    object qrySchemeActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qrySchememsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object dsScheme: TDataSource
    DataSet = qryScheme
    Left = 520
    Top = 24
  end
  object qrySchemeItems: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblSchemePriceListItem')
    AfterOpen = qrySchemeItemsAfterOpen
    AfterPost = qrySchemeItemsAfterPost
    Left = 552
    object qrySchemeItemsPriceListNumber: TWideStringField
      DisplayLabel = 'List Number'
      DisplayWidth = 20
      FieldName = 'PriceListNumber'
      Origin = 'tblSchemePriceListItem.PriceListNumber'
      Size = 255
    end
    object qrySchemeItemsPriceListName: TWideStringField
      DisplayLabel = 'List Name'
      DisplayWidth = 30
      FieldName = 'PriceListName'
      Origin = 'tblSchemePriceListItem.PriceListName'
      Size = 255
    end
    object qrySchemeItemsQuantityThreshold: TFloatField
      DisplayLabel = 'Quantity Threshold'
      DisplayWidth = 10
      FieldName = 'QuantityThreshold'
    end
    object qrySchemeItemsSchemePriceListItemID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SchemePriceListItemID'
      Origin = 'tblSchemePriceListItem.SchemePriceListItemID'
      Visible = False
    end
    object qrySchemeItemsPriceSchemeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PriceSchemeID'
      Origin = 'tblSchemePriceListItem.PriceSchemeID'
      Visible = False
    end
    object qrySchemeItemsPriceListID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PriceListID'
      Origin = 'tblSchemePriceListItem.PriceListID'
      Visible = False
    end
  end
  object dsSchemeItems: TDataSource
    DataSet = qrySchemeItems
    Left = 552
    Top = 24
  end
  object qryPriceSchemeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblPriceScheme'
      'WHERE PriceSchemeID <> :PriceSchemeID')
    Left = 360
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PriceSchemeID'
      end>
  end
  object qryPriceListLookup2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblPriceList'
      'WHERE (:PriceSchemeID = 0'
      'OR PriceListID NOT IN'
      
        '(SELECT PriceListId FROM tblSchemePriceListItem WHERE PriceSchem' +
        'eID = :PriceSchemeID))'
      'AND (Active = "T")')
    Left = 328
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PriceSchemeID'
      end
      item
        DataType = ftUnknown
        Name = 'PriceSchemeID'
      end>
  end
end
