inherited VoucherGUI: TVoucherGUI
  Left = 371
  Top = 180
  HelpContext = 550000
  Caption = 'VoucherGUI'
  ClientHeight = 467
  ClientWidth = 547
  OldCreateOrder = True
  ExplicitLeft = 371
  ExplicitTop = 180
  ExplicitWidth = 555
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 112
    Top = 96
    Width = 95
    Height = 15
    HelpContext = 550002
    Alignment = taRightJustify
    Caption = 'Voucher Number'
    Transparent = True
  end
  object Label3: TLabel [1]
    Left = 176
    Top = 131
    Width = 31
    Height = 15
    HelpContext = 550003
    Alignment = taRightJustify
    Caption = 'Value'
    Transparent = True
  end
  object Label4: TLabel [2]
    Left = 162
    Top = 166
    Width = 45
    Height = 15
    HelpContext = 550004
    Alignment = taRightJustify
    Caption = 'Created'
    Transparent = True
  end
  object Label5: TLabel [3]
    Left = 169
    Top = 202
    Width = 38
    Height = 15
    HelpContext = 550005
    Alignment = taRightJustify
    Caption = 'Issued'
    Transparent = True
  end
  object Label6: TLabel [4]
    Left = 336
    Top = 200
    Width = 51
    Height = 15
    HelpContext = 550006
    Caption = 'Is Issued'
    Transparent = True
  end
  object Label7: TLabel [5]
    Left = 336
    Top = 240
    Width = 74
    Height = 15
    HelpContext = 550007
    Caption = 'Is Redeemed'
    Transparent = True
  end
  object Label8: TLabel [6]
    Left = 172
    Top = 376
    Width = 35
    Height = 15
    HelpContext = 550008
    Alignment = taRightJustify
    Caption = 'Active'
    Transparent = True
  end
  object Label9: TLabel [7]
    Left = 146
    Top = 237
    Width = 61
    Height = 15
    HelpContext = 550009
    Alignment = taRightJustify
    Caption = 'Redeemed'
    Transparent = True
  end
  object Label2: TLabel [8]
    Left = 151
    Top = 273
    Width = 56
    Height = 15
    HelpContext = 550010
    Alignment = taRightJustify
    Caption = 'Customer'
    Transparent = True
  end
  object Label10: TLabel [9]
    Left = 131
    Top = 308
    Width = 76
    Height = 15
    HelpContext = 550011
    Alignment = taRightJustify
    Caption = 'Issuing Class'
    Transparent = True
  end
  object Label11: TLabel [10]
    Left = 136
    Top = 344
    Width = 66
    Height = 15
    HelpContext = 550012
    Caption = 'Other Store'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 550001
  end
  inherited lblSkingroupMsg: TLabel
    Top = 401
    Width = 547
    HelpContext = 550031
  end
  object cboClassID: TwwDBLookupCombo [15]
    Left = 216
    Top = 304
    Width = 185
    Height = 23
    HelpContext = 550016
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ClassName'#9'25'#9'Department'#9'F')
    DataField = 'ClassID'
    DataSource = dsVouchers
    LookupTable = qryClasses
    LookupField = 'ClassID'
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object chkIsIssued: TwwCheckBox [16]
    Left = 320
    Top = 199
    Width = 13
    Height = 16
    HelpContext = 550017
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
    Caption = 'chkIsIssued'
    Color = clWindow
    DataField = 'IsIssued'
    DataSource = dsVouchers
    ParentColor = False
    TabOrder = 4
    ReadOnly = True
  end
  object chkIsRedeemed: TwwCheckBox [17]
    Left = 320
    Top = 240
    Width = 12
    Height = 17
    HelpContext = 550018
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
    Caption = 'chkIsRedeemed'
    Color = clWindow
    DataField = 'IsRedeemed'
    DataSource = dsVouchers
    ParentColor = False
    TabOrder = 6
    ReadOnly = True
  end
  object chkIsActive: TwwCheckBox [18]
    Left = 216
    Top = 376
    Width = 12
    Height = 15
    HelpContext = 550019
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
    Caption = 'chkIsActive'
    Color = clWindow
    DataField = 'Active'
    DataSource = dsVouchers
    ParentColor = False
    TabOrder = 10
    ReadOnly = True
  end
  object dtpCreated: TwwDBDateTimePicker [19]
    Left = 216
    Top = 160
    Width = 97
    Height = 23
    HelpContext = 550020
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DateCreated'
    DataSource = dsVouchers
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 2
  end
  object dtpIssued: TwwDBDateTimePicker [20]
    Left = 216
    Top = 200
    Width = 97
    Height = 23
    HelpContext = 550021
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DateIssued'
    DataSource = dsVouchers
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 3
  end
  object dtpRedeemed: TwwDBDateTimePicker [21]
    Left = 216
    Top = 240
    Width = 97
    Height = 23
    HelpContext = 550022
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DateRedeemed'
    DataSource = dsVouchers
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 5
  end
  object edtIssuedBy: TwwDBEdit [22]
    Left = 216
    Top = 336
    Width = 185
    Height = 23
    HelpContext = 550023
    DataField = 'IssuedBy'
    DataSource = dsVouchers
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object pnlHeader: TDNMPanel [23]
    Left = 0
    Top = 0
    Width = 547
    Height = 66
    HelpContext = 550024
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object pnlTitle: TDNMPanel
      Left = 155
      Top = 11
      Width = 238
      Height = 41
      HelpContext = 550025
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
        Width = 234
        Height = 37
        HelpContext = 550026
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
          Width = 234
          Height = 37
          HelpContext = 550027
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Vouchers'
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
  end
  object pnlFooter: TDNMPanel [24]
    Left = 0
    Top = 401
    Width = 547
    Height = 66
    HelpContext = 550028
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    TabStop = True
    DesignSize = (
      547
      66)
    object btnSave: TDNMSpeedButton
      Left = 137
      Top = 21
      Width = 115
      Height = 27
      HelpContext = 550029
      Anchors = [akBottom]
      Caption = '&Save'
      DisableTransparent = False
      Enabled = False
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
      TabStop = False
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 289
      Top = 21
      Width = 115
      Height = 27
      HelpContext = 550030
      Anchors = [akBottom]
      Cancel = True
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object edtValue: TwwDBEdit [25]
    Left = 216
    Top = 128
    Width = 97
    Height = 23
    HelpContext = 550014
    DataField = 'Value'
    DataSource = dsVouchers
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtVoucherNo: TwwDBEdit [26]
    Left = 216
    Top = 88
    Width = 153
    Height = 23
    HelpContext = 550013
    DataField = 'VoucherNo'
    DataSource = dsVouchers
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboClientID: TwwDBLookupCombo [27]
    Left = 216
    Top = 272
    Width = 185
    Height = 23
    HelpContext = 550015
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'25'#9'Customer'#9'F')
    DataField = 'ClientID'
    DataSource = dsVouchers
    LookupTable = qryClients
    LookupField = 'ClientID'
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 64
    Top = 408
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004800480010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryVouchers: TERPQuery
    SQL.Strings = (
      'SELECT VoucherID, VoucherNo, ClientID, ClassID,'
      'SaleID, Value, DateCreated, DateIssued, IsIssued,'
      'DateRedeemed, IsRedeemed, Active, IssuedBy, EditedFlag'
      'FROM tblvouchers'
      'WHERE VoucherID = :xVoucherID')
    AfterOpen = qryVouchersAfterOpen
    Left = 32
    Top = 112
    ParamData = <
      item
        DataType = ftString
        Name = 'xVoucherID'
        Size = 255
      end>
    object qryVouchersVoucherID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'VoucherID'
      ReadOnly = True
    end
    object qryVouchersVoucherNo: TWideStringField
      DisplayWidth = 20
      FieldName = 'VoucherNo'
    end
    object qryVouchersClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
    end
    object qryVouchersClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
    end
    object qryVouchersSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
    end
    object qryVouchersValue: TFloatField
      DisplayWidth = 10
      FieldName = 'Value'
      currency = True
    end
    object qryVouchersDateCreated: TDateField
      DisplayWidth = 10
      FieldName = 'DateCreated'
    end
    object qryVouchersDateIssued: TDateField
      DisplayWidth = 10
      FieldName = 'DateIssued'
    end
    object qryVouchersIsIssued: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsIssued'
      FixedChar = True
      Size = 1
    end
    object qryVouchersDateRedeemed: TDateField
      DisplayWidth = 10
      FieldName = 'DateRedeemed'
    end
    object qryVouchersIsRedeemed: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsRedeemed'
      FixedChar = True
      Size = 1
    end
    object qryVouchersIssuedBy: TWideStringField
      FieldName = 'IssuedBy'
      Size = 255
    end
    object qryVouchersActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryVouchersEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object dsVouchers: TDataSource
    DataSet = qryVouchers
    Left = 24
    Top = 40
  end
  object qryClients: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company'
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Customer = '#39'T'#39' '
      'Order By Company')
    Left = 400
    Top = 272
  end
  object qryClasses: TERPQuery
    SQL.Strings = (
      'SELECT ClassID, ClassName'
      'FROM tblclass '
      '')
    Left = 400
    Top = 304
  end
  object memQryVouchers: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'VoucherID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'VoucherNo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ClientID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'ClassID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'SaleID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Value'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'DateCreated'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'DateIssued'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'IsIssued'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'DateRedeemed'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'IsRedeemed'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Active'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IssuedBy'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'EditedFlag'
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
    Left = 32
    Top = 160
    object memQryVouchersVoucherID: TAutoIncField
      FieldName = 'VoucherID'
    end
    object memQryVouchersVoucherNo: TWideStringField
      FieldName = 'VoucherNo'
    end
    object memQryVouchersClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object memQryVouchersClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object memQryVouchersSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object memQryVouchersValue: TFloatField
      FieldName = 'Value'
    end
    object memQryVouchersDateCreated: TDateField
      FieldName = 'DateCreated'
    end
    object memQryVouchersDateIssued: TDateField
      FieldName = 'DateIssued'
    end
    object memQryVouchersIsIssued: TWideStringField
      FieldName = 'IsIssued'
      FixedChar = True
      Size = 1
    end
    object memQryVouchersDateRedeemed: TDateField
      FieldName = 'DateRedeemed'
    end
    object memQryVouchersIsRedeemed: TWideStringField
      FieldName = 'IsRedeemed'
      FixedChar = True
      Size = 1
    end
    object memQryVouchersActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object memQryVouchersIssuedBy: TWideStringField
      FieldName = 'IssuedBy'
      Size = 255
    end
    object memQryVouchersEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
end
