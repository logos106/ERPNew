inherited frmPayRates: TfrmPayRates
  Left = 229
  Top = 304
  HelpContext = 319000
  Caption = 'Pay Rate'
  ClientHeight = 601
  ClientWidth = 422
  OldCreateOrder = True
  ExplicitLeft = 229
  ExplicitTop = 304
  ExplicitWidth = 438
  ExplicitHeight = 640
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 20
    Top = 136
    Width = 369
    Height = 400
    HelpContext = 319002
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 44
    Top = 91
    Width = 65
    Height = 15
    HelpContext = 319003
    Caption = 'Description'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 44
    Top = 192
    Width = 52
    Height = 15
    HelpContext = 319004
    Caption = 'Multiplier'
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 56
    Top = 220
    Width = 317
    Height = 15
    HelpContext = 319005
    Caption = 'Number Times Normal Hours ie Double Time would be  2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label4: TLabel [4]
    Left = 156
    Top = 144
    Width = 190
    Height = 30
    HelpContext = 319006
    Caption = 
      'If checked, then this is a Pay Rate description (not a Shift Des' +
      'cription)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label5: TLabel [5]
    Left = 66
    Top = 152
    Width = 63
    Height = 15
    HelpContext = 319007
    Caption = 'Is Pay Rate'
    Transparent = True
  end
  object Label143: TLabel [6]
    Left = 376
    Top = 546
    Width = 35
    Height = 15
    HelpContext = 319008
    Alignment = taCenter
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel [7]
    Left = 156
    Top = 192
    Width = 30
    Height = 15
    HelpContext = 319009
    Alignment = taCenter
    AutoSize = False
    Caption = 'of'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 601
    Width = 422
    HelpContext = 319029
    ExplicitTop = 529
    ExplicitWidth = 422
  end
  object Label7: TLabel [9]
    Left = 66
    Top = 319
    Width = 44
    Height = 15
    HelpContext = 319021
    Caption = 'Super? '
    Transparent = True
  end
  object Label8: TLabel [10]
    Left = 161
    Top = 304
    Width = 185
    Height = 45
    HelpContext = 319022
    AutoSize = False
    Caption = 
      'The setting here will load by default when you select this      ' +
      '  Pay Rate in the Employee Pay window.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 319001
  end
  object Label9: TLabel [13]
    Left = 66
    Top = 367
    Width = 78
    Height = 15
    HelpContext = 319023
    Caption = 'Accrue Leave'
    Transparent = True
  end
  object Label10: TLabel [14]
    Left = 161
    Top = 359
    Width = 161
    Height = 30
    HelpContext = 319024
    Caption = 'If checked, then leave will be accrued for this Pay Rate'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Bevel2: TBevel [15]
    Left = 37
    Top = 405
    Width = 331
    Height = 5
    HelpContext = 319025
    Shape = bsBottomLine
  end
  object Label11: TLabel [16]
    Left = 66
    Top = 424
    Width = 111
    Height = 15
    HelpContext = 319026
    Caption = 'Accrue Extra Leave'
    Transparent = True
  end
  object Label12: TLabel [17]
    Left = 44
    Top = 459
    Width = 63
    Height = 15
    HelpContext = 319027
    Caption = 'Leave Type'
    Transparent = True
  end
  object Label13: TLabel [18]
    Left = 44
    Top = 494
    Width = 52
    Height = 15
    HelpContext = 319028
    Caption = 'Multiplier'
    Transparent = True
  end
  object Label14: TLabel [21]
    Left = 44
    Top = 267
    Width = 71
    Height = 15
    HelpContext = 319021
    Caption = 'Income Type'
    Transparent = True
  end
  object chkIsPayRate: TwwCheckBox [22]
    Left = 44
    Top = 152
    Width = 14
    Height = 15
    HelpContext = 319014
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
    DataField = 'IsPayRate'
    DataSource = DSPayRate
    TabOrder = 2
    OnClick = chkIsPayRateClick
  end
  object chkActive: TDBCheckBox [23]
    Left = 385
    Top = 561
    Width = 17
    Height = 16
    HelpContext = 319015
    Caption = 'Active'
    DataField = 'Active'
    DataSource = DSPayRate
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    ValueChecked = 'T'
    ValueUnchecked = 'F'
  end
  object cboParentRate: TwwDBLookupCombo [24]
    Left = 189
    Top = 188
    Width = 184
    Height = 23
    HelpContext = 319016
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taRightJustify
    Selected.Strings = (
      'Description'#9'30'#9'Rate'#9'F')
    DataField = 'MultiplierParentID'
    DataSource = DSPayRate
    LookupTable = qryPayRates
    LookupField = 'RateID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 4
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object edtDescription: TwwDBEdit [25]
    Left = 113
    Top = 87
    Width = 248
    Height = 23
    HelpContext = 319017
    DataField = 'Description'
    DataSource = DSPayRate
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
  end
  object pnlTitle: TDNMPanel [26]
    Left = 136
    Top = 10
    Width = 150
    Height = 42
    HelpContext = 319018
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Invoice'
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
      Width = 148
      Height = 40
      HelpContext = 319019
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
        Width = 148
        Height = 40
        HelpContext = 319020
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Pay Rate'
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
  object chksuper: TwwCheckBox [27]
    Left = 44
    Top = 319
    Width = 14
    Height = 15
    HelpContext = 319030
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
    DataField = 'IsSuperEnabled'
    DataSource = DSPayRate
    TabOrder = 5
  end
  object btnCancel: TDNMSpeedButton [28]
    Left = 273
    Top = 550
    Width = 87
    Height = 27
    HelpContext = 319011
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
  end
  object btnSave: TDNMSpeedButton [29]
    Left = 61
    Top = 550
    Width = 87
    Height = 27
    HelpContext = 319010
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
  end
  object chkAccrueLeave: TwwCheckBox [30]
    Left = 44
    Top = 367
    Width = 14
    Height = 15
    HelpContext = 319031
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
    DataField = 'AccrueLeave'
    DataSource = DSPayRate
    TabOrder = 6
  end
  object chkExtraLeaveAccrual: TwwCheckBox [31]
    Left = 44
    Top = 424
    Width = 14
    Height = 15
    HelpContext = 319032
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
    DataField = 'ExtraLeaveAccrual'
    DataSource = DSPayRate
    TabOrder = 7
    OnClick = chkExtraLeaveAccrualClick
  end
  object cboExtraLeaveType: TwwDBLookupCombo [32]
    Left = 113
    Top = 455
    Width = 184
    Height = 23
    HelpContext = 319033
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taRightJustify
    Selected.Strings = (
      'LeaveType'#9'30'#9'Leave Type'#9'F')
    DataField = 'ExtraLeaveTypeID'
    DataSource = DSPayRate
    LookupTable = qryLeaveTypes
    LookupField = 'LeaveTypeID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 8
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object edtExtraLeaveMultiplier: TwwDBEdit [33]
    Left = 112
    Top = 490
    Width = 61
    Height = 23
    HelpContext = 319012
    DataField = 'ExtraLeaveMultiplier'
    DataSource = DSPayRate
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtMultiplier: TwwDBEdit [34]
    Left = 103
    Top = 188
    Width = 48
    Height = 23
    HelpContext = 319034
    DataField = 'Multiplier'
    DataSource = DSPayRate
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
  object cmdNew: TDNMSpeedButton [35]
    Left = 167
    Top = 550
    Width = 87
    Height = 27
    HelpContext = 319013
    Caption = '&New'
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
    TabOrder = 11
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object cboIncomeType: TwwDBComboBox [36]
    Left = 164
    Top = 264
    Width = 209
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'IncomeType'
    DataSource = DSPayRate
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Closely Held Payees'#9'CHP'
      'Foreign Employment'#9'FEI'
      'Inbound Assignees to Australia'#9'IAA'
      'Labour Hire'#9'LAB'
      'Other Specified Payments'#9'OSP'
      'Salary and Wages'#9'SAW'
      'Seasonal Worker Programme'#9'SWP'
      'Voluntary Agreement'#9'VOL'
      'Working Holiday Makers'#9'WHM')
    ParentFont = False
    Sorted = False
    TabOrder = 14
    UnboundDataType = wwDefault
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 34
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 38
    Top = 3
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Connected = True
  end
  inherited DataState: TDataState
    Left = 74
    Top = 24
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006800B40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 84
  end
  object qryPayRate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RateID,Description,Multiplier, EditedFlag, IsPayRate,'
      'MultiplierParentID, Active,IsLeave, IsSuperEnabled, AccrueLeave,'
      
        'ExtraLeaveAccrual, ExtraLeaveTypeID, ExtraLeaveMultiplier, Incom' +
        'eType'
      'FROM tblPayRates'
      'WHERE RateID=:KeyID')
    Left = 377
    Top = 9
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryPayRateRateID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'RateID'
      Origin = 'tblpayrates.RateID'
      ReadOnly = True
    end
    object qryPayRateDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblpayrates.Description'
      Size = 100
    end
    object qryPayRateMultiplier: TFloatField
      FieldName = 'Multiplier'
      Origin = 'tblpayrates.Multiplier'
    end
    object qryPayRateEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblpayrates.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryPayRateIsPayRate: TWideStringField
      FieldName = 'IsPayRate'
      Origin = 'tblpayrates.IsPayRate'
      OnChange = qryPayRateIsPayRateChange
      FixedChar = True
      Size = 1
    end
    object qryPayRateActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblpayrates.Active'
      FixedChar = True
      Size = 1
    end
    object qryPayRateMultiplierParentID: TIntegerField
      FieldName = 'MultiplierParentID'
      Origin = 'tblpayrates.MultiplierParentID'
    end
    object qryPayRateIsLeave: TWideStringField
      FieldName = 'IsLeave'
      Origin = 'tblpayrates.IsLeave'
      FixedChar = True
      Size = 1
    end
    object qryPayRateIsSuperEnabled: TWideStringField
      FieldName = 'IsSuperEnabled'
      Origin = 'tblpayrates.IsSuperEnabled'
      FixedChar = True
      Size = 1
    end
    object qryPayRateAccrueLeave: TWideStringField
      FieldName = 'AccrueLeave'
      Origin = 'tblpayrates.AccrueLeave'
      FixedChar = True
      Size = 1
    end
    object qryPayRateExtraLeaveAccrual: TWideStringField
      FieldName = 'ExtraLeaveAccrual'
      Origin = 'tblpayrates.ExtraLeaveAccrual'
      FixedChar = True
      Size = 1
    end
    object qryPayRateExtraLeaveMultiplier: TFloatField
      FieldName = 'ExtraLeaveMultiplier'
      Origin = 'tblpayrates.ExtraLeaveMultiplier'
    end
    object qryPayRateExtraLeaveTypeID: TIntegerField
      FieldName = 'ExtraLeaveTypeID'
      Origin = 'tblpayrates.ExtraLeaveTypeID'
    end
    object qryPayRateIncomeType: TWideStringField
      FieldName = 'IncomeType'
      Size = 3
    end
  end
  object DSPayRate: TDataSource
    DataSet = qryPayRate
    Left = 137
    Top = 25
  end
  object memQryPayRate: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'RateID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Multiplier'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsPayRate'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
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
    Left = 379
    Top = 42
    object memQryPayRateRateID: TAutoIncField
      FieldName = 'RateID'
    end
    object memQryPayRateDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object memQryPayRateMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object memQryPayRateEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object memQryPayRateIsPayRate: TWideStringField
      FieldName = 'IsPayRate'
      FixedChar = True
      Size = 1
    end
  end
  object qryPayRates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select RateID, Description'
      'FROM tblPayRates'
      'WHERE Active = '#39'T'#39' AND RateID <> :xKeyID ;')
    Left = 385
    Top = 131
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xKeyID'
      end>
  end
  object qryLeaveTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select LeaveTypeID, LeaveType'
      'FROM tblLeaveTypes'
      'WHERE Active = '#39'T'#39';')
    Left = 369
    Top = 355
  end
end
