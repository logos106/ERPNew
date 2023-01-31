inherited fmIntegrationEbayConfig: TfmIntegrationEbayConfig
  Left = 756
  Top = 92
  HelpContext = 1062002
  Caption = 'Integration EBay Config'
  ClientHeight = 603
  ClientWidth = 609
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitLeft = 756
  ExplicitTop = 92
  ExplicitWidth = 625
  ExplicitHeight = 642
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 556
    Top = 575
    Anchors = [akRight, akBottom]
    ExplicitLeft = 490
    ExplicitTop = 536
  end
  object Label2: TLabel [1]
    Left = 54
    Top = 60
    Width = 83
    Height = 15
    HelpContext = 1062003
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'Account Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [2]
    Left = 73
    Top = 89
    Width = 64
    Height = 15
    HelpContext = 1062004
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'User Token'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [3]
    Left = 101
    Top = 261
    Width = 36
    Height = 15
    HelpContext = 1062005
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'App ID'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [4]
    Left = 102
    Top = 296
    Width = 35
    Height = 15
    HelpContext = 1062006
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'Dev ID'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [5]
    Left = 99
    Top = 332
    Width = 38
    Height = 15
    HelpContext = 1062007
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'Cert ID'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [6]
    Left = 40
    Top = 368
    Width = 97
    Height = 15
    HelpContext = 1062008
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'Required Version'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [7]
    Left = 27
    Top = 403
    Width = 110
    Height = 15
    HelpContext = 1062009
    Alignment = taRightJustify
    Caption = 'Company Database'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
  end
  object Label9: TLabel [8]
    Left = 80
    Top = 475
    Width = 57
    Height = 15
    HelpContext = 1062010
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'Next Sync'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [9]
    Left = 340
    Top = 475
    Width = 92
    Height = 15
    HelpContext = 1062011
    BiDiMode = bdLeftToRight
    Caption = 'Sync Date From '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel [10]
    Left = 51
    Top = 439
    Width = 86
    Height = 15
    HelpContext = 1062008
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = 'Ebay Customer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    Transparent = True
  end
  inherited chkActive: TCheckBox
    Left = 535
    Top = 575
    Anchors = [akRight, akBottom]
    ExplicitLeft = 469
    ExplicitTop = 536
  end
  inherited btnSave: TDNMSpeedButton
    Left = 186
    Top = 563
    ExplicitLeft = 131
    ExplicitTop = 524
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 333
    Top = 563
    ExplicitLeft = 243
    ExplicitTop = 524
  end
  inherited pnlTitle: TDNMPanel
    Width = 536
    HelpContext = 1062012
    ExplicitWidth = 536
    inherited TitleShader: TShader
      Width = 532
      HelpContext = 1062013
      ExplicitWidth = 532
      inherited TitleLabel: TLabel
        Width = 532
        HelpContext = 1062014
        Caption = 'Integration EBay Config'
        ExplicitWidth = 532
      end
    end
  end
  object edtAcountName: TEdit
    Left = 144
    Top = 56
    Width = 297
    Height = 23
    HelpContext = 1062015
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtUserTocken: TMemo
    Left = 144
    Top = 89
    Width = 447
    Height = 161
    HelpContext = 1062016
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'edtUserTocken')
    ParentFont = False
    TabOrder = 5
  end
  object edtAppID: TEdit
    Left = 144
    Top = 257
    Width = 447
    Height = 23
    HelpContext = 1062017
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object edtDevID: TEdit
    Left = 144
    Top = 292
    Width = 447
    Height = 23
    HelpContext = 1062018
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object edtCertID: TEdit
    Left = 144
    Top = 328
    Width = 447
    Height = 23
    HelpContext = 1062019
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object edtReqVersion: TEdit
    Left = 144
    Top = 364
    Width = 85
    Height = 23
    HelpContext = 1062020
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object edtEbayCustomer: TEdit
    Left = 144
    Top = 435
    Width = 166
    Height = 23
    HelpContext = 1062020
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object cboDatabases: TwwDBComboBox
    Left = 144
    Top = 400
    Width = 201
    Height = 23
    HelpContext = 1062021
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    AutoDropDown = True
    AutoFillDate = False
    AutoSize = False
    Column1Width = 215
    DropDownCount = 8
    DropDownWidth = 330
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = False
    TabOrder = 10
    UnboundDataType = wwDefault
    TwoColumnDisplay = True
  end
  object dtNextDate: TwwDBDateTimePicker
    Left = 144
    Top = 472
    Width = 157
    Height = 21
    HelpContext = 1062022
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'Tahoma'
    CalendarAttributes.Font.Style = []
    Date = 40890.000000000000000000
    Epoch = 1950
    Time = 0.498920717589499000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 11
  end
  object rgSiteIntegrationLoggingLevel: TRadioGroup
    Left = 20
    Top = 502
    Width = 571
    Height = 48
    HelpContext = 1062023
    Caption = ' Logging Level '
    Columns = 4
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'Error'
      'Warning'
      'Info'
      'Detail')
    ParentFont = False
    TabOrder = 12
  end
  object DtFrom: TwwDBDateTimePicker
    Left = 433
    Top = 472
    Width = 158
    Height = 21
    HelpContext = 1062024
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'Tahoma'
    CalendarAttributes.Font.Style = []
    Date = 40890.000000000000000000
    Epoch = 1950
    Time = 0.498920717589499000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 13
  end
  object btnchooseCustomer: TDNMSpeedButton
    Left = 316
    Top = 435
    Width = 29
    Height = 23
    HelpContext = 1063005
    Anchors = [akLeft, akTop, akRight]
    Caption = ' .  .  .'
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
    ParentFont = False
    TabOrder = 15
    AutoDisableParentOnclick = True
    OnClick = btnchooseCustomerClick
  end
  object chkSingleCustomer: TCheckBox
    Left = 371
    Top = 431
    Width = 220
    Height = 31
    Caption = 'Use Single ERP Customer for Ebay Orders'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    WordWrap = True
  end
end
