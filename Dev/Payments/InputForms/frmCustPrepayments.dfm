inherited fmCustPrepayments: TfmCustPrepayments
  Left = 499
  Top = 113
  HelpContext = 81000
  Caption = 'Customer Prepayment'
  ClientHeight = 494
  ExplicitLeft = 499
  ExplicitTop = 113
  ExplicitHeight = 533
  DesignSize = (
    799
    494)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel4: TBevel [0]
    Left = 246
    Top = 353
    Width = 313
    Height = 72
    HelpContext = 81049
    Anchors = [akLeft, akBottom]
    Shape = bsFrame
  end
  inherited Bevel3: TBevel
    Left = 582
    Top = 353
    Width = 199
    Height = 72
    HelpContext = 81002
    ExplicitLeft = 579
    ExplicitTop = 353
    ExplicitWidth = 199
    ExplicitHeight = 72
  end
  inherited Bevel2: TBevel
    Left = 18
    Top = 354
    Width = 207
    Height = 71
    HelpContext = 81003
    ExplicitLeft = 18
    ExplicitTop = 354
    ExplicitWidth = 207
    ExplicitHeight = 71
  end
  inherited Box30: TBevel
    HelpContext = 81004
  end
  inherited Bevel1: TBevel
    Left = 18
    HelpContext = 81005
    ExplicitLeft = 18
  end
  inherited lblPaymentDate: TLabel
    HelpContext = 81006
  end
  inherited Label3: TLabel
    Top = 166
    HelpContext = 81007
    ExplicitTop = 166
  end
  inherited Label1: TLabel
    Top = 62
    HelpContext = 81008
    Caption = 'Customer'
    ExplicitTop = 62
  end
  inherited Label23: TLabel
    HelpContext = 81009
  end
  inherited cboPayMethod_Label: TLabel
    Top = 115
    HelpContext = 81010
    ExplicitTop = 115
  end
  inherited Label29: TLabel
    HelpContext = 81011
  end
  inherited ClassLabel: TLabel
    Top = 115
    HelpContext = 81012
    ExplicitTop = 115
  end
  inherited Label81: TLabel
    Top = 167
    HelpContext = 81013
    ExplicitTop = 167
  end
  inherited Label28: TLabel
    HelpContext = 81014
  end
  inherited Label6: TLabel
    Left = 46
    Top = 361
    HelpContext = 81017
    ExplicitLeft = 46
    ExplicitTop = 361
  end
  inherited lblForeignCurrencyCode: TLabel
    Top = 115
    HelpContext = 81019
    Visible = True
    ExplicitTop = 115
  end
  inherited lblExchangeRate: TLabel
    Top = 63
    HelpContext = 81020
    Visible = True
    ExplicitTop = 63
  end
  inherited lblForeignAmount: TLabel
    Left = 133
    Top = 115
    HelpContext = 81021
    Visible = True
    ExplicitLeft = 133
    ExplicitTop = 115
  end
  inherited Label5: TLabel
    Left = 606
    Top = 363
    HelpContext = 81016
    ExplicitLeft = 603
    ExplicitTop = 363
  end
  inherited lblSkingroupMsg: TLabel
    Top = 449
    ExplicitTop = 494
  end
  inherited imgGridWatermark: TImage
    HelpContext = 81001
  end
  object Label4: TLabel [22]
    Left = 261
    Top = 363
    Width = 61
    Height = 15
    HelpContext = 81050
    Anchors = [akLeft, akBottom]
    Caption = 'Entered By'
    Transparent = True
  end
  object lblEnteredBy: TLabel [23]
    Left = 333
    Top = 363
    Width = 69
    Height = 15
    HelpContext = 81051
    Anchors = [akLeft, akBottom]
    Caption = 'lblEnteredBy'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [24]
    Left = 261
    Top = 384
    Width = 59
    Height = 15
    HelpContext = 81052
    Anchors = [akLeft, akBottom]
    Caption = 'Entered At'
    Transparent = True
  end
  object Label8: TLabel [25]
    Left = 182
    Top = 166
    Width = 128
    Height = 19
    HelpContext = 81012
    AutoSize = False
    Caption = 'Rep'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblEnteredAt: TDBText [26]
    Left = 333
    Top = 383
    Width = 78
    Height = 15
    HelpContext = 81053
    DataField = 'EnteredAt'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblPayamthint: TLabel [29]
    Left = 30
    Top = 204
    Width = 77
    Height = 15
    HelpContext = 81007
    Caption = 'lblPayamthint'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  inherited cboPaymentMethod: TwwDBLookupCombo
    Top = 131
    HelpContext = 81026
    TabOrder = 6
    OnExit = cboPaymentMethodExit
    ExplicitTop = 131
  end
  inherited txtRecordID: TDBEdit
    HelpContext = 81027
    TabOrder = 14
  end
  inherited btnPopup: TDNMSpeedButton
    Left = 490
    Top = 182
    HelpContext = 81028
    TabOrder = 20
    ExplicitLeft = 490
    ExplicitTop = 182
  end
  inherited Notes: TDBMemo
    Left = 39
    HelpContext = 81029
    ExplicitLeft = 39
  end
  inherited txtAvailCredit: TDBEdit
    Left = 603
    Top = 386
    HelpContext = 81035
    ExplicitLeft = 603
    ExplicitTop = 386
  end
  inherited txtApplyCredit: TDBEdit
    Left = 45
    Top = 385
    HelpContext = 81036
    TabOrder = 12
    ExplicitLeft = 45
    ExplicitTop = 385
  end
  inherited txtAmount: TDBEdit
    Top = 182
    Width = 131
    HelpContext = 81037
    ExplicitTop = 182
    ExplicitWidth = 131
  end
  inherited btnPayments: TDNMSpeedButton
    Left = 129
    HelpContext = 81038
    ExplicitLeft = 129
  end
  inherited btnReconciled: TDNMSpeedButton
    Left = 563
    HelpContext = 81039
    Font.Height = -12
    TabOrder = 22
    ExplicitLeft = 563
  end
  inherited cboForeignCurrencyCode: TwwDBLookupCombo
    Top = 131
    HelpContext = 81041
    TabOrder = 1
    Visible = True
    OnExit = cboForeignCurrencyCodeExit
    ExplicitTop = 131
  end
  inherited edtExchangeRate: TwwDBEdit
    Top = 81
    HelpContext = 81042
    TabOrder = 11
    Visible = True
    ExplicitTop = 81
  end
  inherited edtForeignAmount: TwwDBEdit
    Left = 133
    Top = 131
    HelpContext = 81043
    TabOrder = 2
    Visible = True
    ExplicitLeft = 133
    ExplicitTop = 131
  end
  object UseAccNo: TDNMSpeedButton [42]
    Left = 299
    Top = 112
    Width = 22
    Height = 22
    HelpContext = 81048
    DisableTransparent = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
      55555575555555775F55509999999901055557F55555557F75F5001111111101
      105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
      01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
      8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
      0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
      0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
      05555555575FF777755555555500055555555555557775555555}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 18
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = UseAccNoClick
  end
  inherited RefenceNo: TDBEdit
    Top = 182
    Width = 135
    HelpContext = 81044
    TabOrder = 7
    ExplicitTop = 182
    ExplicitWidth = 135
  end
  inherited pnlTitle: TDNMPanel
    Left = 227
    Width = 328
    HelpContext = 81045
    Anchors = [akTop]
    TabOrder = 16
    ExplicitLeft = 227
    ExplicitWidth = 328
    inherited TitleShader: TShader
      Width = 324
      HelpContext = 81046
      ExplicitWidth = 324
      inherited TitleLabel: TLabel
        Width = 324
        HelpContext = 81047
        Caption = 'Customer Prepayment'
        ExplicitWidth = 324
      end
    end
  end
  inherited cboClient: TERPDbLookupCombo
    Top = 81
    HelpContext = 81022
    DropDownWidth = 380
    LookupFormClassName = 'TCustomerExpressListGUI'
    EditFormClassName = 'TfrmCustomer'
    LookupFormKeyStringFieldName = 'Company'
    LookupComboType = ctCustomer
    LookupFieldAlt = 'PrintName'
    ExplicitTop = 81
  end
  inherited btnDeposit: TDNMSpeedButton
    Left = 562
    TabOrder = 19
    ExplicitLeft = 562
  end
  inherited cboCreationDate: TwwDBDateTimePicker
    Top = 81
    HelpContext = 81023
    ExplicitTop = 81
  end
  inherited cboClass: TwwDBLookupCombo
    Top = 131
    HelpContext = 81024
    OnExit = cboClassExit
    ExplicitTop = 131
  end
  inherited DNMPanel1: TDNMPanel
    Top = 449
    Height = 45
    TabOrder = 17
    ExplicitTop = 449
    ExplicitHeight = 45
    inherited Label11: TLabel
      Height = 39
    end
    inherited lblEFT: TLabel
      Height = 39
      HelpContext = 81018
    end
    inherited cmdPrint: TDNMSpeedButton
      AlignWithMargins = True
      Left = 417
      Top = 8
      Height = 29
      HelpContext = 81030
      Margins.Left = 33
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      ExplicitLeft = 417
      ExplicitTop = 0
      ExplicitHeight = 29
    end
    inherited cmdSave: TDNMSpeedButton
      AlignWithMargins = True
      Left = 171
      Top = 8
      Height = 29
      HelpContext = 81031
      Margins.Left = 99
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      OnClick = cmdSaveClick
      ExplicitLeft = 171
      ExplicitTop = 0
      ExplicitHeight = 29
    end
    inherited cmdCancel: TDNMSpeedButton
      AlignWithMargins = True
      Left = 540
      Top = 8
      Height = 29
      HelpContext = 81032
      Margins.Left = 33
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      Font.Height = -12
      ExplicitLeft = 540
      ExplicitTop = 0
      ExplicitHeight = 29
    end
    inherited chkDeleted: TwwCheckBox
      Top = 19
      HelpContext = 81033
      ExplicitTop = 19
    end
    inherited cmdNew: TDNMSpeedButton
      AlignWithMargins = True
      Left = 294
      Top = 8
      Height = 29
      HelpContext = 81034
      Margins.Left = 33
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alLeft
      ExplicitLeft = 294
      ExplicitTop = 0
      ExplicitHeight = 29
    end
    inherited chkEFT: TwwCheckBox
      Top = 19
      HelpContext = 81040
      ExplicitTop = 19
    end
  end
  inherited cboAccount: TwwDBLookupCombo
    Top = 182
    HelpContext = 81025
    ExplicitTop = 182
  end
  object cboEmployee: TwwDBLookupCombo [51]
    Left = 182
    Top = 182
    Width = 111
    Height = 23
    HelpContext = 81054
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'EmployeeName'#9'25'#9'EmployeeName'#9'F')
    DataField = 'RepName'
    DataSource = DSMaster
    LookupTable = cboEmployeeLookup
    LookupField = 'EmployeeName'
    DropDownWidth = 300
    ParentFont = False
    TabOrder = 4
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboEmployeeCloseUp
  end
  object btnCardPayment: TDNMSpeedButton [52]
    Left = 678
    Top = 79
    Width = 87
    Height = 27
    HelpContext = 81055
    Anchors = [akTop, akRight]
    Caption = 'Card Payment'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnCardPaymentClick
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 2
    Top = 7
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 34
    Top = 6
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 114
    Top = 47
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005800B40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited tblMaster: TERPQuery
    Connection = MyConnection
    Left = 107
    Top = 262
    inherited tblMasterGlobalRef: TWideStringField
      Origin = 'tblPrePayments.GlobalRef'
    end
    inherited tblMasterPrePaymentID: TAutoIncField
      AutoGenerateValue = arAutoInc
      Origin = 'tblPrePayments.PrePaymentID'
    end
    inherited tblMasterEmployeeID: TIntegerField
      Origin = 'tblPrePayments.EmployeeID'
    end
    inherited tblMasterClientID: TIntegerField
      Origin = 'tblPrePayments.ClientID'
    end
    inherited tblMasterPrePaymentDate: TDateField
      Origin = 'tblPrePayments.PrePaymentDate'
    end
    inherited tblMasterPayAmount: TFloatField
      DisplayLabel = 'Payment Amount'
      Origin = 'tblPrePayments.PayAmount'
      OnChange = tblMasterPayAmountChange
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblMasterPayMethodID: TIntegerField
      Origin = 'tblPrePayments.PayMethodID'
    end
    inherited tblMasterNotes: TWideStringField
      Origin = 'tblPrePayments.Notes'
    end
    inherited tblMasterReferenceNo: TWideStringField
      Origin = 'tblPrePayments.ReferenceNo'
      OnChange = tblMasterReferenceNoChange
    end
    inherited tblMasterEditedFlag: TWideStringField
      Origin = 'tblPrePayments.EditedFlag'
    end
    inherited tblMasterClassID: TIntegerField
      Origin = 'tblPrePayments.ClassID'
    end
    inherited tblMasterMasterAccountID: TIntegerField
      Origin = 'tblPrePayments.MasterAccountID'
    end
    inherited tblMasterBankAccountID: TIntegerField
      Origin = 'tblPrePayments.BankAccountID'
    end
    inherited tblMasterCustomer: TWideStringField
      Origin = 'tblPrePayments.Customer'
    end
    inherited tblMasterSupplier: TWideStringField
      Origin = 'tblPrePayments.Supplier'
    end
    inherited tblMasterDeleted: TWideStringField
      Origin = 'tblPrePayments.Deleted'
    end
    inherited tblMasterReconciled: TWideStringField
      Origin = 'tblPrePayments.Reconciled'
    end
    inherited tblMasterDepositID: TIntegerField
      Origin = 'tblPrePayments.DepositID'
    end
    inherited tblMasterReconciliationID: TIntegerField
      Origin = 'tblPrePayments.ReconciliationID'
    end
    inherited tblMasterBankAccountName: TWideStringField
      Origin = 'tblPrePayments.BankAccountName'
    end
    inherited tblMasterBankAccountBSB: TWideStringField
      Origin = 'tblPrePayments.BankAccountBSB'
    end
    inherited tblMasterBankAccountNo: TWideStringField
      Origin = 'tblPrePayments.BankAccountNo'
    end
    inherited tblMasterCompanyName: TWideStringField
      Origin = 'tblPrePayments.CompanyName'
    end
    inherited tblMasterPaid: TWideStringField
      Origin = 'tblPrePayments.Paid'
    end
    inherited tblMasterBalance: TFloatField
      Origin = 'tblPrePayments.Balance'
    end
    inherited tblMasterPayment: TFloatField
      Origin = 'tblPrePayments.Payment'
    end
    inherited tblMasterDeposited: TWideStringField
      Origin = 'tblPrePayments.Deposited'
    end
    inherited tblMasterForeignExchangeCode: TWideStringField
      Origin = 'tblPrePayments.ForeignExchangeCode'
    end
    inherited tblMasterForeignExchangeRate: TFloatField
      Origin = 'tblPrePayments.ForeignExchangeRate'
    end
    inherited tblMasterForeignPayAmount: TFloatField
      Origin = 'tblPrePayments.ForeignPayAmount'
      DisplayFormat = '###,###,###,##0.00;-###,###,###,##0.00'
      EditFormat = '###,###,###,##0.00;-###,###,###,##0.00'
    end
    inherited tblMasterForeignPaid: TFloatField
      Origin = 'tblPrePayments.ForeignPaid'
    end
    inherited tblMasterForeignBalance: TFloatField
      Origin = 'tblPrePayments.ForeignBalance'
    end
    inherited tblMasterForeignPayment: TFloatField
      Origin = 'tblPrePayments.ForeignPayment'
    end
    object tblMasterRepId: TIntegerField
      FieldName = 'RepId'
      Origin = 'tblPrePayments.RepId'
    end
    object tblMasterRepName: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblPrePayments.RepName'
      Size = 100
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblMasterChequePrinted: TWideStringField
      FieldName = 'ChequePrinted'
      FixedChar = True
      Size = 1
    end
  end
  inherited DSMaster: TDataSource
    Left = 106
    Top = 291
  end
  inherited qryPayMethod: TERPQuery
    SQL.Strings = (
      'SELECT PayMethodID, Name as '#39'Payment Method'#39',IsCreditCard'
      'FROM tblpaymentmethods where Active ="T" '
      'ORDER BY Name')
  end
  inherited cboClassQry: TERPQuery
    Left = 315
  end
  inherited cboClientlookup: TERPQuery
    SQL.Strings = (
      'SELECT C.ClientID,'
      'C.Company,'
      'Sum(C.Balance) as Balance,'
      'C.BankAccountName, C.BankAccountBSB, C.BankAccountNo,'
      'C.PayMethodID, C.ForeignExchangeSellCode'
      'FROM tblclients C'
      'WHERE (not IsNull(C.Company) AND char_length(Trim(C.Company))>0)'
      'AND C.Active <>'#39'F'#39
      'AND C.Customer = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C.Company LIKE Concat(:SearchValue,"%' +
        '")))'
      
        'or ((:SearchMode = 2) and (C.Company LIKE Concat("%",:SearchValu' +
        'e,"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'GROUP BY ClientID'
      'ORDER BY C.Company;')
    AfterOpen = cboClientlookupAfterOpen
    Left = 231
    Top = 72
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
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 283
    Top = 213
    object cboEmployeeLookupEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmployeeID'
      Origin = 'tblEmployees.EmployeeID'
    end
    object cboEmployeeLookupEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblEmployees.EmployeeName'
      Size = 255
    end
  end
end
