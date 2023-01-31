inherited frmAllowancesUSA: TfrmAllowancesUSA
  Left = 1383
  Top = 504
  HelpContext = 228000
  Caption = 'Allowance'
  ClientHeight = 552
  ClientWidth = 724
  OldCreateOrder = True
  ExplicitLeft = 1383
  ExplicitTop = 504
  ExplicitWidth = 740
  ExplicitHeight = 591
  DesignSize = (
    724
    552)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 29
    Top = 429
    Width = 430
    Height = 62
    HelpContext = 228002
    Anchors = [akLeft, akBottom]
    Shape = bsFrame
  end
  object Bevel1: TBevel [1]
    Left = 29
    Top = 164
    Width = 430
    Height = 250
    HelpContext = 228003
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 59
    Top = 86
    Width = 65
    Height = 15
    HelpContext = 228004
    Caption = 'Description'
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 46
    Top = 183
    Width = 169
    Height = 15
    HelpContext = 228005
    Caption = 'Calculate Super on Allowance'
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 46
    Top = 208
    Width = 66
    Height = 15
    HelpContext = 228006
    Caption = 'Tax Exempt'
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 46
    Top = 233
    Width = 108
    Height = 15
    HelpContext = 228007
    Caption = 'Payroll Tax Exempt'
    Transparent = True
  end
  object Label5: TLabel [6]
    Left = 46
    Top = 258
    Width = 109
    Height = 15
    HelpContext = 228008
    Caption = 'Workcover Exempt'
    Transparent = True
  end
  object Label7: TLabel [7]
    Left = 51
    Top = 437
    Width = 44
    Height = 15
    HelpContext = 228009
    Anchors = [akLeft, akBottom]
    Caption = 'Amount'
    Transparent = True
    ExplicitTop = 495
  end
  object Label9: TLabel [8]
    Left = 239
    Top = 437
    Width = 55
    Height = 15
    HelpContext = 228010
    Anchors = [akLeft, akBottom]
    Caption = 'Based On'
    Transparent = True
    ExplicitTop = 495
  end
  object Label10: TLabel [9]
    Left = 657
    Top = 502
    Width = 35
    Height = 15
    HelpContext = 228011
    Anchors = [akBottom]
    Caption = 'Active'
    Transparent = True
    ExplicitLeft = 492
    ExplicitTop = 560
  end
  object Label8: TLabel [10]
    Left = 177
    Top = 437
    Width = 25
    Height = 15
    HelpContext = 228012
    Anchors = [akLeft, akBottom]
    Caption = '$ / %'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    ExplicitTop = 495
  end
  object lblAccount: TLabel [11]
    Left = 74
    Top = 128
    Width = 47
    Height = 15
    HelpContext = 228013
    Caption = 'Account'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 552
    Width = 724
    HelpContext = 228030
    ExplicitTop = 385
    ExplicitWidth = 454
  end
  inherited shapehint: TShape
    Left = 22
    ExplicitLeft = 13
  end
  inherited imgGridWatermark: TImage
    Left = 425
    Top = -5
    HelpContext = 228001
    ExplicitLeft = 425
    ExplicitTop = -5
  end
  inherited shapehintextra1: TShape
    Left = 94
    ExplicitLeft = 67
  end
  object Label11: TLabel [17]
    Left = 46
    Top = 287
    Width = 165
    Height = 15
    HelpContext = 228031
    Caption = 'Show on Summary Report as'
  end
  object lblDisplayInNotes: TLabel [18]
    Left = 150
    Top = 313
    Width = 263
    Height = 50
    HelpContext = 228032
    AutoSize = False
    Caption = 'lblDisplayInNotes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel [19]
    Left = 46
    Top = 377
    Width = 88
    Height = 15
    HelpContext = 228033
    Caption = 'Allowance Type'
  end
  object Label12: TLabel [20]
    Left = 531
    Top = 233
    Width = 95
    Height = 15
    HelpContext = 228033
    Caption = 'Allowance Types'
  end
  object DBCheckBox1: TwwCheckBox [21]
    Left = 242
    Top = 183
    Width = 16
    Height = 17
    HelpContext = 228018
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbUnchecked
    Color = 15785701
    DataField = 'SuperInc'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
  object DBCheckBox2: TwwCheckBox [22]
    Left = 242
    Top = 208
    Width = 17
    Height = 17
    HelpContext = 228019
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbUnchecked
    Color = 15785701
    DataField = 'TaxExempt'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 3
  end
  object DBCheckBox3: TwwCheckBox [23]
    Left = 242
    Top = 233
    Width = 17
    Height = 17
    HelpContext = 228020
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbUnchecked
    Color = 15785701
    DataField = 'PayrollTaxExempt'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 4
  end
  object DBCheckBox4: TwwCheckBox [24]
    Left = 242
    Top = 257
    Width = 17
    Height = 17
    HelpContext = 228021
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'Yes'
    DisplayValueUnchecked = 'No'
    NullAndBlankState = cbUnchecked
    Color = 15785701
    DataField = 'WorkcoverExempt'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 5
  end
  object btnNew: TDNMSpeedButton [25]
    Left = 320
    Top = 507
    Width = 87
    Height = 27
    HelpContext = 228022
    Anchors = [akBottom]
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 11
    AutoDisableParentOnclick = True
    OnClick = btnNewClick
    ExplicitLeft = 231
  end
  object chkActive: TwwCheckBox [26]
    Left = 664
    Top = 517
    Width = 17
    Height = 17
    HelpContext = 228023
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
    NullAndBlankState = cbChecked
    Anchors = [akBottom]
    Caption = 'chkActive'
    Checked = True
    DataField = 'Active'
    DataSource = DSAllowance
    State = cbChecked
    TabOrder = 9
    ExplicitLeft = 500
  end
  object cboCalcBy: TwwDBComboBox [27]
    Left = 174
    Top = 457
    Width = 41
    Height = 23
    HelpContext = 228024
    Anchors = [akLeft, akBottom]
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DataField = 'CalcBy'
    DataSource = DSAllowance
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
    TabOrder = 7
    UnboundDataType = wwDefault
    OnCloseUp = cboCalcByCloseUp
  end
  object cboDefaultAccount: TwwDBLookupCombo [28]
    Left = 134
    Top = 125
    Width = 245
    Height = 23
    HelpContext = 228025
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'30'#9'Account Name'#9'T'#9
      'Type'#9'20'#9'Type'#9'T'#9)
    DataField = 'AccountName'
    DataSource = DSAllowance
    LookupTable = qryAccounts
    LookupField = 'AccountName'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboDefaultAccountCloseUp
  end
  object edtDescription: TwwDBEdit [29]
    Left = 136
    Top = 83
    Width = 243
    Height = 23
    HelpContext = 228026
    DataField = 'Description'
    DataSource = DSAllowance
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
  object pnlTitle: TDNMPanel [30]
    Left = 124
    Top = 4
    Width = 480
    Height = 42
    HelpContext = 228027
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Invoice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 13
    ExplicitWidth = 303
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 478
      Height = 40
      HelpContext = 228028
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
      ExplicitWidth = 301
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 478
        Height = 40
        HelpContext = 228029
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Allowance'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 208
      end
    end
  end
  object cboBasedOn: TwwDBLookupCombo [31]
    Left = 239
    Top = 457
    Width = 200
    Height = 23
    HelpContext = 228015
    Anchors = [akLeft, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'BasedOn'#9'25'#9'BasedOn'#9#9)
    DataField = 'BasedOnID'
    DataSource = DSAllowance
    LookupTable = qryBasedOn
    LookupField = 'BasedOnID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 8
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnNotInList = cboBasedOnNotInList
  end
  object edtAmount: TwwDBEdit [32]
    Left = 51
    Top = 457
    Width = 107
    Height = 23
    HelpContext = 228014
    Anchors = [akLeft, akBottom]
    DataField = 'Amount'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object btnSave: TDNMSpeedButton [33]
    Left = 146
    Top = 507
    Width = 87
    Height = 27
    HelpContext = 228016
    Anchors = [akBottom]
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
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnSaveClick
    ExplicitLeft = 100
  end
  object btnCancel: TDNMSpeedButton [34]
    Left = 492
    Top = 507
    Width = 86
    Height = 27
    HelpContext = 228017
    Anchors = [akBottom]
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
    TabOrder = 12
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
    ExplicitLeft = 361
  end
  object cboDisplayIn: TDBComboBox [35]
    Left = 239
    Top = 283
    Width = 133
    Height = 23
    HelpContext = 228034
    Style = csDropDownList
    DataField = 'DisplayIn'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Items.Strings = (
      'Allowances'
      'Gross'
      'Do Not Display')
    ParentFont = False
    TabOrder = 14
    OnChange = cboDisplayInChange
  end
  object cboAllowanceType: TDBComboBox [36]
    Left = 54
    Top = 340
    Width = 133
    Height = 23
    HelpContext = 228035
    Style = csDropDownList
    DataField = 'AllowanceType'
    DataSource = DSAllowance
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Items.Strings = (
      'Car'
      'Laundry'
      'Meals'
      'Transport'
      'Travel'
      'Other')
    ParentFont = False
    TabOrder = 15
    Visible = False
    OnChange = cboDisplayInChange
  end
  object wwDBGrid1: TwwDBGrid [37]
    Left = 476
    Top = 254
    Width = 220
    Height = 160
    Selected.Strings = (
      'Allowance_Type'#9'25'#9'Allowance_Type')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsAllowanceType
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 16
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object wwDBLookupCombo1: TwwDBLookupCombo [38]
    Left = 239
    Top = 377
    Width = 200
    Height = 23
    HelpContext = 228015
    Anchors = [akLeft, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Allowance_Type'#9'25'#9'Allowance_Type'#9'F'#9)
    DataField = 'AllowTypeID'
    DataSource = DSAllowance
    LookupTable = qryAllowanceType
    LookupField = 'AllowTypeID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 17
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnNotInList = cboBasedOnNotInList
  end
  inherited tmrProcessMessage: TTimer
    Left = 460
    Top = 65528
  end
  inherited tmrdelay: TTimer
    Left = 496
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 144
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Left = 120
    Top = 65520
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 249
    Top = 65528
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 285
    Top = 65528
  end
  inherited MyConnection: TERPConnection
    Database = 'usa_sample_company'
    Connected = True
  end
  inherited DataState: TDataState
    Left = 320
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 179
    Top = 65528
  end
  inherited imgsort: TImageList
    Left = 355
    Top = 65528
    Bitmap = {
      494C010102006800E40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 74
    Top = 65528
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 390
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 214
    Top = 65528
  end
  inherited qryMemTrans: TERPQuery
    Left = 109
    Top = 65528
  end
  inherited tmrOnshow: TTimer
    Left = 72
    Top = 45
  end
  object qryAccounts: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.* ,AccDesc as Type'
      'FROM tblChartofAccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE Active = '#39'T'#39' AND IsHeader = '#39'F'#39
      'Order By AccDesc, AccountName;')
    Left = 416
    Top = 2
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
  object DSAllowance: TDataSource
    DataSet = qryAllowance
    Left = 353
    Top = 32
  end
  object qryBasedOn: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn'
      'ORDER BY BasedOn')
    Left = 482
    Top = 42
    object qryBasedOnBasedOn: TWideStringField
      DisplayWidth = 25
      FieldName = 'BasedOn'
      Size = 25
    end
    object qryBasedOnBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
  end
  object qryAllowance: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblallowances'
      'WHERE AllowanceID=:KeyID')
    Left = 426
    Top = 58
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryAllowanceAllowanceID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'AllowanceID'
      Origin = 'tblallowances.AllowanceID'
      ReadOnly = True
    end
    object qryAllowanceAmount: TFloatField
      FieldName = 'Amount'
      Origin = 'tblallowances.Amount'
      DisplayFormat = '#####0.00'
    end
    object qryAllowanceBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
      Origin = 'tblallowances.BasedOnID'
    end
    object qryAllowanceDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblallowances.Description'
      Size = 150
    end
    object qryAllowanceDisplayIn: TWideStringField
      FieldName = 'DisplayIn'
      Origin = 'tblallowances.DisplayIn'
      FixedChar = True
      Size = 14
    end
    object qryAllowancePayrollTaxExempt: TWideStringField
      FieldName = 'PayrollTaxExempt'
      Origin = 'tblallowances.PayrollTaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceSuperInc: TWideStringField
      FieldName = 'SuperInc'
      Origin = 'tblallowances.SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceTaxExempt: TWideStringField
      FieldName = 'TaxExempt'
      Origin = 'tblallowances.TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceWorkcoverExempt: TWideStringField
      FieldName = 'WorkcoverExempt'
      Origin = 'tblallowances.WorkcoverExempt'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblallowances.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblallowances.Active'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceCalcBy: TWideStringField
      FieldName = 'CalcBy'
      Origin = 'tblallowances.CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryAllowanceAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblallowances.AccountID'
    end
    object qryAllowanceAccountName: TWideStringField
      FieldName = 'AccountName'
      Origin = 'tblallowances.AccountName'
      OnChange = qryAllowanceAccountNameChange
      Size = 255
    end
    object qryAllowanceGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblallowances.GlobalRef'
      Size = 255
    end
    object qryAllowanceReportExempt: TWideStringField
      FieldName = 'ReportExempt'
      Origin = 'tblallowances.ReportExempt'
      FixedChar = True
      Size = 1
    end
    object qryAllowancePercentage: TFloatField
      FieldName = 'Percentage'
    end
    object qryAllowanceAllowanceType: TWideStringField
      FieldName = 'AllowanceType'
      FixedChar = True
      Size = 9
    end
    object qryAllowanceAllowanceCode: TWideStringField
      FieldName = 'AllowanceCode'
      Size = 3
    end
    object qryAllowancemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryAllowancemsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryAllowanceAllowTypeID: TIntegerField
      FieldName = 'AllowTypeID'
    end
  end
  object qryAllowanceType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select AllowTypeID, Allowance_Type'
      'FROM tblAllowanceTypes'
      'ORDER BY Allowance_Type')
    Active = True
    Left = 418
    Top = 106
    object qryAllowanceTypeAllowance_Type: TWideStringField
      DisplayWidth = 25
      FieldName = 'Allowance_Type'
      Origin = 'tblallowancetypes.Allowance_Type'
      Size = 25
    end
    object qryAllowanceTypeAllowTypeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'AllowTypeID'
      Origin = 'tblallowancetypes.AllowTypeID'
      Visible = False
    end
  end
  object dsAllowanceType: TDataSource
    DataSet = qryAllowanceType
    Left = 489
    Top = 104
  end
end
