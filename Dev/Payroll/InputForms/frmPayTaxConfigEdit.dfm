inherited fmPayTaxConfigEdit: TfmPayTaxConfigEdit
  HelpContext = 1308002
  Caption = 'Payroll Tax'
  ClientHeight = 379
  ClientWidth = 475
  Position = poScreenCenter
  ExplicitWidth = 491
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 379
    Width = 475
    HelpContext = 1308003
    ExplicitTop = 314
    ExplicitWidth = 475
  end
  inherited shapehint: TShape
    Left = -2
    ExplicitLeft = -2
  end
  inherited imgGridWatermark: TImage
    Left = 417
    Top = 35
    ExplicitLeft = 417
    ExplicitTop = 35
  end
  inherited shapehintextra1: TShape
    Left = 19
    ExplicitLeft = 19
  end
  object Label1: TLabel [5]
    Left = 46
    Top = 77
    Width = 56
    Height = 15
    HelpContext = 1308004
    Caption = 'Tax Name'
  end
  object Label2: TLabel [6]
    Left = 46
    Top = 105
    Width = 49
    Height = 15
    HelpContext = 1308005
    Caption = 'Tax Type'
  end
  object Label3: TLabel [7]
    Left = 46
    Top = 189
    Width = 99
    Height = 15
    HelpContext = 1308006
    Caption = 'Expense Account'
  end
  object Label4: TLabel [8]
    Left = 46
    Top = 218
    Width = 93
    Height = 15
    HelpContext = 1308007
    Caption = 'Liability Account'
  end
  object Label5: TLabel [9]
    Left = 46
    Top = 161
    Width = 106
    Height = 15
    HelpContext = 1308008
    Caption = 'Allowance Amount'
  end
  object Label6: TLabel [10]
    Left = 46
    Top = 247
    Width = 98
    Height = 15
    HelpContext = 1308009
    Caption = 'Default Tax Scale'
  end
  object Label7: TLabel [11]
    Left = 46
    Top = 133
    Width = 63
    Height = 15
    HelpContext = 1308010
    Caption = 'Group Type'
  end
  object pnlTitle: TDNMPanel [12]
    Left = 74
    Top = 9
    Width = 327
    Height = 39
    HelpContext = 1308011
    Anchors = [akLeft, akTop, akRight]
    
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 12
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 325
      Height = 37
      HelpContext = 1308012
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
        Width = 325
        Height = 37
        HelpContext = 1308013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Payroll Tax'
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
  object cmdClose: TDNMSpeedButton [13]
    Left = 125
    Top = 342
    Width = 93
    Height = 29
    HelpContext = 1308014
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
    TabOrder = 10
    OnClick = cmdCloseClick
  end
  object cmdCancel: TDNMSpeedButton [14]
    Left = 257
    Top = 342
    Width = 93
    Height = 29
    HelpContext = 1308015
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
    TabOrder = 11
  end
  object edtTaxName: TwwDBEdit [15]
    Left = 165
    Top = 74
    Width = 218
    Height = 23
    HelpContext = 1308016
    DataField = 'TaxName'
    DataSource = dsPayTaxConfig
    Font.Charset = ANSI_CHARSET
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
  object cboTaxType: TwwDBComboBox [16]
    Left = 165
    Top = 102
    Width = 121
    Height = 23
    HelpContext = 1308017
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    AutoDropDown = True
    DataField = 'TaxType'
    DataSource = dsPayTaxConfig
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Company'
      'Employee')
    ParentFont = False
    Sorted = False
    TabOrder = 1
    UnboundDataType = wwDefault
  end
  object cboExpenseAccount: TwwDBLookupCombo [17]
    Left = 165
    Top = 186
    Width = 202
    Height = 23
    HelpContext = 1308018
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'40'#9'Account Name'#9'F')
    DataField = 'ExpenseAccountId'
    DataSource = dsPayTaxConfig
    LookupTable = qryExpenseAccountLookup
    LookupField = 'AccountID'
    ParentFont = False
    TabOrder = 4
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object cboLiabilityAccount: TwwDBLookupCombo [18]
    Left = 165
    Top = 215
    Width = 202
    Height = 23
    HelpContext = 1308019
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'40'#9'Account Name'#9'F')
    DataField = 'LiabilityAccountId'
    DataSource = dsPayTaxConfig
    LookupTable = qryLiabilityAccountLookup
    LookupField = 'AccountID'
    ParentFont = False
    TabOrder = 5
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object chkPrimary: TwwCheckBox [19]
    Left = 46
    Top = 280
    Width = 134
    Height = 17
    HelpContext = 1308020
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Primary Tax'
    DataField = 'PrimaryTax'
    DataSource = dsPayTaxConfig
    TabOrder = 7
  end
  object chkRoundTax: TwwCheckBox [20]
    Left = 46
    Top = 307
    Width = 134
    Height = 17
    HelpContext = 1308021
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Round Tax'
    DataField = 'RoundTax'
    DataSource = dsPayTaxConfig
    TabOrder = 8
  end
  object chkActive: TwwCheckBox [21]
    Left = 384
    Top = 347
    Width = 73
    Height = 17
    HelpContext = 1308022
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = 'Active'
    DataField = 'Active'
    DataSource = dsPayTaxConfig
    TabOrder = 9
  end
  object edtAllowanceAmount: TwwDBEdit [22]
    Left = 165
    Top = 158
    Width = 121
    Height = 23
    HelpContext = 1308023
    DataField = 'AllowanceAmount'
    DataSource = dsPayTaxConfig
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboTaxScale: TwwDBLookupCombo [23]
    Left = 165
    Top = 244
    Width = 202
    Height = 23
    HelpContext = 1308024
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ScaleDescription'#9'40'#9'Tax Scale'#9'F')
    DataField = 'DefaultTaxScaleId'
    DataSource = dsPayTaxConfig
    LookupTable = qryTaxScaleLookup
    LookupField = 'ScaleID'
    ParentFont = False
    TabOrder = 6
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = True
  end
  object cboGroupType: TwwDBComboBox [24]
    Left = 165
    Top = 130
    Width = 121
    Height = 23
    HelpContext = 1308025
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    AutoDropDown = True
    DataField = 'GroupType'
    DataSource = dsPayTaxConfig
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Federal Tax'#9'Federal'
      'State Tax'#9'State'
      'Medicare Tax'#9'Medicare'
      'Social Security Tax'#9'SocialSecurity'
      'Other Tax'#9'Other')
    ParentFont = False
    Sorted = False
    TabOrder = 2
    UnboundDataType = wwDefault
  end
  inherited tmrProcessMessage: TTimer
    Left = 452
    Top = 32
  end
  inherited tmrdelay: TTimer
    Left = 488
    Top = 32
  end
  inherited popSpelling: TPopupMenu
    Left = 96
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 201
    Top = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 253
    Top = 65528
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 288
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 131
    Top = 0
  end
  inherited imgsort: TImageList
    Left = 323
    Top = 65528
    Bitmap = {
      494C0101020014014C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 26
    Top = 0
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 358
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 166
    Top = 0
  end
  inherited qryMemTrans: TERPQuery
    Left = 61
    Top = 0
  end
  object qryPayTaxConfig: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblPayTaxConfig')
    Left = 368
    Top = 56
    object qryPayTaxConfigGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryPayTaxConfigID: TIntegerField
      FieldName = 'ID'
    end
    object qryPayTaxConfigRegionId: TIntegerField
      FieldName = 'RegionId'
    end
    object qryPayTaxConfigTaxName: TWideStringField
      FieldName = 'TaxName'
      Size = 255
    end
    object qryPayTaxConfigExpenseAccountId: TIntegerField
      FieldName = 'ExpenseAccountId'
    end
    object qryPayTaxConfigLiabilityAccountId: TIntegerField
      FieldName = 'LiabilityAccountId'
    end
    object qryPayTaxConfigTaxType: TWideStringField
      FieldName = 'TaxType'
      FixedChar = True
      Size = 8
    end
    object qryPayTaxConfigPrimaryTax: TWideStringField
      FieldName = 'PrimaryTax'
      FixedChar = True
      Size = 1
    end
    object qryPayTaxConfigRoundTax: TWideStringField
      FieldName = 'RoundTax'
      FixedChar = True
      Size = 1
    end
    object qryPayTaxConfigActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryPayTaxConfigmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryPayTaxConfigmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryPayTaxConfigExpenseAccount: TStringField
      FieldKind = fkLookup
      FieldName = 'ExpenseAccount'
      LookupDataSet = qryExpenseAccountLookup
      LookupKeyFields = 'AccountID'
      LookupResultField = 'AccountName'
      KeyFields = 'ExpenseAccountId'
      Size = 255
      Lookup = True
    end
    object qryPayTaxConfigAllowanceAmount: TFloatField
      FieldName = 'AllowanceAmount'
    end
    object qryPayTaxConfigDefaultTaxScaleId: TIntegerField
      FieldName = 'DefaultTaxScaleId'
    end
    object qryPayTaxConfigDefaultTaxScale: TStringField
      FieldKind = fkLookup
      FieldName = 'DefaultTaxScale'
      LookupDataSet = qryTaxScaleLookup
      LookupKeyFields = 'ScaleID'
      LookupResultField = 'ScaleDescription'
      KeyFields = 'DefaultTaxScaleId'
      Size = 255
      Lookup = True
    end
    object qryPayTaxConfigGroupType: TWideStringField
      FieldName = 'GroupType'
      FixedChar = True
      Size = 14
    end
  end
  object dsPayTaxConfig: TDataSource
    DataSet = qryPayTaxConfig
    Left = 368
    Top = 96
  end
  object qryExpenseAccountLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblchartofaccounts'
      'where AccountType = "EXP" and Active = "T"'
      'Order by accountname')
    Left = 440
    Top = 112
  end
  object qryLiabilityAccountLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblchartofaccounts'
      'where AccountType = "OCLIAB" and Active = "T"'
      'Order by accountname')
    Left = 440
    Top = 168
  end
  object qryTaxScaleLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tbltaxscales '
      'where Active = "T"'
      'and RegionID = :RegionID'
      'Order by scaledescription')
    BeforeOpen = qryTaxScaleLookupBeforeOpen
    Left = 352
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
end
