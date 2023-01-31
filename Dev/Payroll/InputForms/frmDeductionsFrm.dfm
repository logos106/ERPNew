inherited frmDeductions: TfrmDeductions
  Left = 524
  Top = 328
  HelpContext = 262000
  Caption = 'Deduction'
  ClientHeight = 416
  ClientWidth = 435
  OldCreateOrder = True
  ExplicitWidth = 441
  ExplicitHeight = 445
  DesignSize = (
    435
    416)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 44
    Top = 131
    Width = 342
    Height = 155
    HelpContext = 262002
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 52
    Top = 70
    Width = 65
    Height = 15
    HelpContext = 262003
    Caption = 'Description'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 395
    Top = 369
    Width = 35
    Height = 15
    HelpContext = 262006
    Caption = 'Active'
    Transparent = True
  end
  object Bevel2: TBevel [3]
    Left = 44
    Top = 292
    Width = 342
    Height = 70
    HelpContext = 262007
    Shape = bsFrame
  end
  object Label7: TLabel [4]
    Left = 65
    Top = 302
    Width = 44
    Height = 15
    HelpContext = 262008
    Caption = 'Amount'
    Transparent = True
  end
  object Label9: TLabel [5]
    Left = 208
    Top = 302
    Width = 55
    Height = 15
    HelpContext = 262009
    Caption = 'Based On'
    Transparent = True
  end
  object Label8: TLabel [6]
    Left = 162
    Top = 304
    Width = 25
    Height = 15
    HelpContext = 262010
    Caption = '$ / %'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblAccount: TLabel [7]
    Left = 52
    Top = 101
    Width = 47
    Height = 15
    HelpContext = 262011
    Caption = 'Account'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 416
    Width = 435
    HelpContext = 262026
    ExplicitTop = 383
    ExplicitWidth = 435
  end
  inherited imgGridWatermark: TImage
    HelpContext = 262001
  end
  object Label5: TLabel [13]
    Left = 55
    Top = 238
    Width = 319
    Height = 32
    HelpContext = 262027
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Tax Exempt Deductions will be excluded from the PAYG Payment Sum' +
      'mary upload Gross figure.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object chkActive: TwwCheckBox [14]
    Left = 404
    Top = 385
    Width = 16
    Height = 17
    HelpContext = 262016
    DisableThemes = False
    AlwaysTransparent = True
    DynamicCaption = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbChecked
    Caption = 'Yes'
    Checked = True
    Color = 15785701
    DataField = 'Active'
    DataSource = DSDeduction
    ParentColor = False
    State = cbChecked
    TabOrder = 8
  end
  object btnNew: TDNMSpeedButton [15]
    Left = 172
    Top = 379
    Width = 87
    Height = 27
    HelpContext = 262017
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnNewClick
  end
  object edtAmount: TwwDBEdit [16]
    Left = 58
    Top = 318
    Width = 82
    Height = 23
    HelpContext = 262018
    DataField = 'Amount'
    DataSource = DSDeduction
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboBasedON: TwwDBLookupCombo [17]
    Left = 203
    Top = 318
    Width = 167
    Height = 23
    HelpContext = 262019
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'BasedOn'#9'25'#9'BasedOn'#9#9)
    DataField = 'BasedOnID'
    DataSource = DSDeduction
    LookupTable = qryBasedOn
    LookupField = 'BasedOnID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 7
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnNotInList = cboBasedONNotInList
  end
  object cboCalcBy: TwwDBComboBox [18]
    Left = 156
    Top = 318
    Width = 41
    Height = 23
    HelpContext = 262020
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'CalcBy'
    DataSource = DSDeduction
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '%'#9'%'
      '$'#9'$'
      #163#9#163)
    ParentFont = False
    Sorted = False
    TabOrder = 6
    UnboundDataType = wwDefault
    OnCloseUp = cboCalcByCloseUp
  end
  object cboDefaultAccount: TwwDBLookupCombo [19]
    Left = 129
    Top = 96
    Width = 245
    Height = 23
    HelpContext = 262021
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'30'#9'Account Name'#9#9
      'Type'#9'20'#9'Type'#9#9)
    DataField = 'AccountName'
    DataSource = DSDeduction
    LookupTable = qryAccounts
    LookupField = 'AccountName'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 1
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboDefaultAccountCloseUp
  end
  object edtDescription: TwwDBEdit [20]
    Left = 129
    Top = 66
    Width = 243
    Height = 23
    HelpContext = 262022
    DataField = 'Description'
    DataSource = DSDeduction
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
  object pnlTitle: TDNMPanel [21]
    Left = 124
    Top = 4
    Width = 210
    Height = 42
    HelpContext = 262023
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Invoice'
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
      Width = 208
      Height = 40
      HelpContext = 262024
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
        Width = 208
        Height = 40
        HelpContext = 262025
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Deduction'
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
  object btnCancel: TDNMSpeedButton [22]
    Left = 299
    Top = 379
    Width = 87
    Height = 27
    HelpContext = 262013
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 11
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
  end
  object btnSave: TDNMSpeedButton [23]
    Left = 44
    Top = 379
    Width = 87
    Height = 27
    HelpContext = 262012
    Caption = '&Save'
    Default = True
    DisableTransparent = False
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 9
    AutoDisableParentOnclick = True
    OnClick = btnSaveClick
  end
  object chkIsWorkPlacegiving: TwwCheckBox [24]
    Left = 65
    Top = 198
    Width = 145
    Height = 17
    HelpContext = 262014
    DisableThemes = False
    AlwaysTransparent = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbChecked
    Caption = 'Is Work Place Giving?'
    Checked = True
    Color = 15785701
    DataField = 'IsWorkPlacegiving'
    DataSource = DSDeduction
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    State = cbChecked
    TabOrder = 4
  end
  object wwCheckBox2: TwwCheckBox [25]
    Left = 65
    Top = 170
    Width = 145
    Height = 17
    HelpContext = 262015
    DisableThemes = False
    AlwaysTransparent = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbUnchecked
    Caption = 'Is Union Fees ?'
    Color = 15785701
    DataField = 'UnionFees'
    DataSource = DSDeduction
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 3
  end
  object wwCheckBox1: TwwCheckBox [26]
    Left = 65
    Top = 140
    Width = 145
    Height = 17
    HelpContext = 262028
    DisableThemes = False
    AlwaysTransparent = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbChecked
    Caption = 'Is Tax Exempt?'
    Checked = True
    Color = 15785701
    DataField = 'TaxExempt'
    DataSource = DSDeduction
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    State = cbChecked
    TabOrder = 2
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006800C80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryAccounts: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.* ,AccDesc as Type'
      'FROM tblChartofAccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE Active = '#39'T'#39' AND IsHeader = '#39'F'#39
      'Order By AccDesc, AccountName;')
    Left = 395
    Top = 8
    object qryAccountsAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 30
      FieldName = 'AccountName'
      FixedChar = True
      Size = 50
    end
    object qryAccountsType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      FixedChar = True
      Size = 255
    end
    object qryAccountsAccountType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'AccountType'
      Visible = False
      FixedChar = True
      Size = 50
    end
    object qryAccountsAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Visible = False
    end
    object qryAccountsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      FixedChar = True
      Size = 255
    end
    object qryAccountsDescription: TWideStringField
      DisplayWidth = 150
      FieldName = 'Description'
      Visible = False
      FixedChar = True
      Size = 150
    end
    object qryAccountsBankAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'BankAccountName'
      Visible = False
      FixedChar = True
      Size = 255
    end
    object qryAccountsBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'Balance'
      Visible = False
    end
    object qryAccountsAccountNumber: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountNumber'
      Visible = False
      Size = 50
    end
    object qryAccountsTaxcode: TWideStringField
      DisplayWidth = 15
      FieldName = 'Taxcode'
      Visible = False
      Size = 15
    end
    object qryAccountsBankNumber: TWideStringField
      DisplayWidth = 50
      FieldName = 'BankNumber'
      Visible = False
      Size = 50
    end
    object qryAccountsExtra: TWideStringField
      DisplayWidth = 50
      FieldName = 'Extra'
      Visible = False
      Size = 50
    end
    object qryAccountsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAccountsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAccountsClass: TWideStringField
      DisplayWidth = 40
      FieldName = 'Class'
      Visible = False
      Size = 255
    end
    object qryAccountsAllClasses: TWideStringField
      DisplayWidth = 1
      FieldName = 'AllClasses'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAccountsOpeningBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'OpeningBalance'
      Visible = False
    end
    object qryAccountsDebits: TFloatField
      DisplayWidth = 10
      FieldName = 'Debits'
      Visible = False
    end
    object qryAccountsCredits: TFloatField
      DisplayWidth = 10
      FieldName = 'Credits'
      Visible = False
    end
    object qryAccountsClosingBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'ClosingBalance'
      Visible = False
    end
    object qryAccountsAccountGroup: TWideStringField
      DisplayWidth = 40
      FieldName = 'AccountGroup'
      Visible = False
      Size = 255
    end
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 361
    Top = 7
  end
  object DSDeduction: TDataSource
    DataSet = qryDeduction
    Left = 332
    Top = 35
  end
  object qryDeduction: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT DeductionID,Description,TaxExempt,TaxExemptFederal, TaxEx' +
        'emptState, TaxExemptSocial, TaxExemptMedicare, IsWorkPlacegiving' +
        ',UnionFees,Active, EditedFlag,'
      
        'DisplayIn, Amount, CalcBy, BasedOnID, AccountID, AccountName, Bo' +
        'x12CodeID'
      'FROM tblDeductions'
      'WHERE DeductionID=:KeyID')
    Left = 329
    Top = 6
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryDeductionDeductionID: TAutoIncField
      FieldName = 'DeductionID'
      ReadOnly = True
    end
    object qryDeductionDescription: TWideStringField
      FieldName = 'Description'
      Size = 150
    end
    object qryDeductionTaxExempt: TWideStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryDeductionIsWorkPlacegiving: TWideStringField
      FieldName = 'IsWorkPlacegiving'
      OnChange = qryDeductionIsWorkPlacegivingChange
      FixedChar = True
      Size = 1
    end
    object qryDeductionUnionFees: TWideStringField
      FieldName = 'UnionFees'
      FixedChar = True
      Size = 1
    end
    object qryDeductionActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryDeductionEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryDeductionDisplayIn: TWideStringField
      FieldName = 'DisplayIn'
      FixedChar = True
      Size = 31
    end
    object qryDeductionAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '0.00'
    end
    object qryDeductionBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryDeductionCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryDeductionAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryDeductionAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 255
    end
    object qryDeductionBox12CodeID: TIntegerField
      FieldName = 'Box12CodeID'
    end
    object qryDeductionTaxExemptFederal: TWideStringField
      FieldName = 'TaxExemptFederal'
      FixedChar = True
      Size = 1
    end
    object qryDeductionTaxExemptState: TWideStringField
      FieldName = 'TaxExemptState'
      FixedChar = True
      Size = 1
    end
    object qryDeductionTaxExemptSocial: TWideStringField
      FieldName = 'TaxExemptSocial'
      FixedChar = True
      Size = 1
    end
    object qryDeductionTaxExemptMedicare: TWideStringField
      FieldName = 'TaxExemptMedicare'
      FixedChar = True
      Size = 1
    end
  end
end
