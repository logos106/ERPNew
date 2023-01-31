inherited MessagePrefsGUI: TMessagePrefsGUI
  Left = 100
  Top = 104
  HelpContext = 1095002
  Caption = 'MessagePrefsGUI'
  ClientHeight = 857
  ClientWidth = 1093
  ExplicitLeft = 100
  ExplicitTop = 104
  ExplicitWidth = 1109
  ExplicitHeight = 896
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 857
    Width = 1093
    HelpContext = 1095003
    ExplicitTop = 822
    ExplicitWidth = 954
  end
  object lblWidth: TLabel [1]
    Left = -81
    Top = 9
    Width = 863
    Height = 22
    HelpContext = 1095004
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1093
    Height = 857
    HelpContext = 1095418
    VertScrollBar.Position = 2099
    ExplicitWidth = 1084
    ExplicitHeight = 861
    object pnlVoucherSalePrint: TDNMPanel
      Left = 0
      Top = 8531
      Width = 1074
      Height = 409
      HelpContext = 1095351
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 29
      object Bevel24: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095352
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label62: TLabel
        Left = 18
        Top = 14
        Width = 105
        Height = 15
        HelpContext = 1095353
        Caption = 'Voucher Sale Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label184: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095354
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label185: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095355
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label186: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095356
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label187: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095357
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label188: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095358
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label189: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095359
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label190: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095360
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtVoucherSalePrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095361
        DataField = 'VoucherSalePrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memVoucherSalePrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095362
        DataField = 'VoucherSalePrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableVoucherSalePrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095363
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
        Caption = 'Auto Send Email When Voucher Sale is Printed'
        DataField = 'EnableVoucherSalePrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnablVoucherSalePrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095364
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
        Caption = 'Auto Send SMS When Voucher Sale is Printed'
        DataField = 'EnablVoucherSalePrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memVoucherSalePrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095365
        DataField = 'VoucherSalePrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlSMSConfig: TDNMPanel
      Left = 0
      Top = 2799
      Width = 1074
      Height = 116
      HelpContext = 1095005
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 14
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 102
        HelpContext = 1095006
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        ParentShowHint = False
        Shape = bsFrame
        ShowHint = True
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 58
      end
      object Label61: TLabel
        Left = 14
        Top = 14
        Width = 26
        Height = 15
        HelpContext = 1095007
        Caption = 'SMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label63: TLabel
        Left = 154
        Top = 17
        Width = 63
        Height = 15
        HelpContext = 1095009
        Caption = 'User Name'
        Transparent = True
      end
      object Label64: TLabel
        Left = 154
        Top = 46
        Width = 58
        Height = 15
        HelpContext = 1095010
        Caption = 'Password'
        Transparent = True
      end
      object Label81: TLabel
        Left = 154
        Top = 75
        Width = 84
        Height = 15
        HelpContext = 1095011
        Caption = 'Phone Number'
        Transparent = True
      end
      object lblSMSEnabled: TLabel
        Left = 21
        Top = 68
        Width = 119
        Height = 32
        HelpContext = 1095366
        AutoSize = False
        Caption = 'lblSMSEnabled'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object chkSMSEnabled: TwwCheckBox
        Left = 19
        Top = 46
        Width = 102
        Height = 17
        HelpContext = 1095012
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
        Caption = 'SMS Enabled'
        TabOrder = 0
        OnClick = chkSMSEnabledClick
      end
      object edtSMSUserName: TEdit
        Left = 247
        Top = 15
        Width = 274
        Height = 23
        HelpContext = 1095013
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = edtSMSUserNameChange
      end
      object edtSMSPassword: TEdit
        Left = 247
        Top = 44
        Width = 274
        Height = 23
        HelpContext = 1095014
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        OnChange = edtSMSPasswordChange
      end
      object edtPhoneNumber: TEdit
        Left = 247
        Top = 73
        Width = 274
        Height = 23
        HelpContext = 1095015
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edtPhoneNumberChange
      end
      object btnSMSrates: TDNMSpeedButton
        Left = 61
        Top = 11
        Width = 79
        Height = 23
        HelpContext = 1095367
        Caption = 'SMS Rates'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = btnSMSratesClick
      end
    end
    object pnlShippingContainer: TDNMPanel
      Left = 0
      Top = 4441
      Width = 1074
      Height = 409
      HelpContext = 1095166
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095167
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label65: TLabel
        Left = 18
        Top = 14
        Width = 237
        Height = 15
        HelpContext = 1095168
        Caption = 'Shipping Container Status or Date Change'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label66: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095169
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label67: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095170
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label68: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095171
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label69: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095172
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label70: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095173
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label71: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095174
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label72: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095175
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtShipContainerChangeEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095176
        DataField = 'ShipContainerChangeEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memShipContainerChangeEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095177
        DataField = 'ShipContainerChangeEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableShipContainerChangeEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095178
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
        Caption = 'Auto Send Email When Shipping Container Status / Date is Changed'
        DataField = 'EnableShipContainerChangeEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnablShipContainerChangeSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095179
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
        Caption = 'Auto Send SMS When Shipping Container Status / Date is changed'
        DataField = 'EnablShipContainerChangeSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memShipContainerChangeSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095180
        DataField = 'ShipContainerChangeSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlSalesOrderShipChange: TDNMPanel
      Left = 0
      Top = 8122
      Width = 1074
      Height = 409
      HelpContext = 1095121
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 28
      object Bevel15: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095122
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 1
        ExplicitTop = 2
        ExplicitWidth = 543
        ExplicitHeight = 407
      end
      object Label106: TLabel
        Left = 18
        Top = 14
        Width = 142
        Height = 15
        HelpContext = 1095123
        Caption = 'Sales Order Ship Change'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label107: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095124
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label108: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095125
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label109: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095126
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label110: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095127
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label111: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095128
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label112: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095129
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label113: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095130
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtSOShipChangeEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095131
        DataField = 'SOShipChangeEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memSOShipChangeEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095132
        DataField = 'SOShipChangeEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableSOShipChangeEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095133
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
        Caption = 'Auto Send Email When Sales Order Ship is Changed'
        DataField = 'EnableSOShipChangeEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableSOShipChangeSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095134
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
        Caption = 'Auto Send SMS When Sales Order Ship is Changed'
        DataField = 'EnableSOShipChangeSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memSOShipChangeSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095135
        DataField = 'SOShipChangeSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlSalesOrderSave: TDNMPanel
      Left = 0
      Top = 7713
      Width = 1074
      Height = 409
      HelpContext = 1095106
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 27
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095107
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label37: TLabel
        Left = 18
        Top = 14
        Width = 99
        Height = 15
        HelpContext = 1095108
        Caption = 'Sales Order Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label38: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095109
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label39: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095110
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label40: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095111
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label41: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095112
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label42: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095113
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label43: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095114
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label44: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095115
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtSOSaveEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095116
        DataField = 'SOSaveEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memSOSaveEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095117
        DataField = 'SOSaveEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableSOSaveEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095118
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
        Caption = 'Auto Send Email When Sales Order is Saved'
        DataField = 'EnableSOSaveEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableSOSaveSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095119
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
        Caption = 'Auto Send SMS When Sales Order is Saved'
        DataField = 'EnableSOSaveSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memSOSaveSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095120
        DataField = 'SOSaveSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlSalesOrderPrint: TDNMPanel
      Left = 0
      Top = 7304
      Width = 1074
      Height = 409
      HelpContext = 1095091
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 26
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095092
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitWidth = 1051
      end
      object Label29: TLabel
        Left = 18
        Top = 14
        Width = 98
        Height = 15
        HelpContext = 1095093
        Caption = 'Sales Order Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label30: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095094
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label31: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095095
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label32: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095096
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label33: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095097
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label34: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095098
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label35: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095099
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label36: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095100
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtSOPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095101
        DataField = 'SOPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memSOPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095102
        DataField = 'SOPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableSOPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095103
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
        Caption = 'Auto Send Email When Sales Order is Printed'
        DataField = 'EnableSOPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableSOPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095104
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
        Caption = 'Auto Send SMS When Sales Order is Printed'
        DataField = 'EnableSOPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memSOPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095105
        DataField = 'SOPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 6895
      Width = 1074
      Height = 409
      HelpContext = 1095276
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 25
      object Bevel19: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095277
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 394
      end
      object pnlRAPrint: TLabel
        Left = 18
        Top = 14
        Width = 122
        Height = 15
        HelpContext = 1095278
        Caption = 'Return Authority Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label145: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095279
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label146: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095280
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label147: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095281
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label148: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095282
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label150: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095283
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label151: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095284
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label152: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095285
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtRAPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095286
        DataField = 'RAPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memRAPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095287
        DataField = 'RAPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableRAPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095288
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
        Caption = 'Auto Send Email When Return Authority is Printed'
        DataField = 'EnableRAPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableRAPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095289
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
        Caption = 'Auto Send SMS When Return Authority is Printed'
        DataField = 'EnableRAPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memRAPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095290
        DataField = 'RAPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlRepairPrint: TDNMPanel
      Left = 0
      Top = 6486
      Width = 1074
      Height = 409
      HelpContext = 1095246
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 24
      object Bevel17: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095247
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitWidth = 1078
      end
      object Label122: TLabel
        Left = 18
        Top = 14
        Width = 67
        Height = 15
        HelpContext = 1095248
        Caption = 'Repair Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label123: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095249
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label124: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095250
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label125: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095251
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label126: TLabel
        Left = 98
        Top = 43
        Width = 95
        Height = 15
        HelpContext = 1095252
        Caption = 'Auto Send Email '
        Transparent = True
      end
      object Label127: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095253
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label128: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095254
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label129: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095255
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtRepairPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095256
        DataField = 'RepairPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memRepairPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095257
        DataField = 'RepairPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableRepairPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095258
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
        Caption = 'Auto Send Email When Repair is Printed'
        DataField = 'EnableRepairPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableRepairPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095259
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
        Caption = 'Auto Send SMS When Repair is Printed'
        DataField = 'EnableRepairPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memRepairPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095260
        DataField = 'RepairPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlRepairInvoiced: TDNMPanel
      Left = 0
      Top = 6077
      Width = 1074
      Height = 409
      HelpContext = 1095403
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 23
      object Bevel30: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095404
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 1
        ExplicitWidth = 543
        ExplicitHeight = 407
      end
      object Label208: TLabel
        Left = 18
        Top = 14
        Width = 87
        Height = 15
        HelpContext = 1095405
        Caption = 'Repair Invoiced'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label209: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095406
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label210: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095407
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label211: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095408
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label212: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095409
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label213: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095410
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label214: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095411
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label215: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095412
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095413
        DataField = 'RepairInvoicedEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object DBMemo1: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095414
        DataField = 'RepairInvoicedEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object wwCheckBox1: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095415
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
        Caption = 'Auto Send Email When Repair is Invoiced'
        DataField = 'EnableRepairInvoicedEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox2: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095416
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
        Caption = 'Auto Send SMS When Repair is Invoiced'
        DataField = 'EnableRepairInvoicedSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object DBMemo2: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095417
        DataField = 'RepairInvoicedSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlRefundPrint: TDNMPanel
      Left = 0
      Top = 5668
      Width = 1074
      Height = 409
      HelpContext = 1095231
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 22
      object Bevel16: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095232
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label114: TLabel
        Left = 18
        Top = 14
        Width = 70
        Height = 15
        HelpContext = 1095233
        Caption = 'Refund Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label115: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095234
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label116: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095235
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label117: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095236
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label118: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095237
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label119: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095238
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label120: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095239
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label121: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095240
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtRefundPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095241
        DataField = 'RefundPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memRefundPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095242
        DataField = 'RefundPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableRefundPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095243
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
        Caption = 'Auto Send Email When Refund is Printed'
        DataField = 'EnableRefundPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableRefundPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095244
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
        Caption = 'Auto Send SMS When Refund is Printed'
        DataField = 'EnableRefundPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memRefundPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095245
        DataField = 'RefundPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlQuoteSave: TDNMPanel
      Left = 0
      Top = 5259
      Width = 1074
      Height = 409
      HelpContext = 1095151
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095152
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 34
        ExplicitTop = 114
        ExplicitWidth = 531
      end
      object Label53: TLabel
        Left = 18
        Top = 14
        Width = 65
        Height = 15
        HelpContext = 1095153
        Caption = 'Quote Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label54: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095154
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label55: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095155
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label56: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095156
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label57: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095157
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label58: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095158
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label59: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095159
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label60: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095160
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtQuoteSaveEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095161
        DataField = 'QuoteSaveEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memQuoteSaveEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095162
        DataField = 'QuoteSaveEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableQuoteSaveEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095163
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
        Caption = 'Auto Send Email When Quote is Saved'
        DataField = 'EnableQuoteSaveEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableQuoteSaveSMS: TwwCheckBox
        Left = 73
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095164
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
        Caption = 'Auto Send SMS When Quote is Saved'
        DataField = 'EnableQuoteSaveSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memQuoteSaveSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095165
        DataField = 'QuoteSaveSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlQuote: TDNMPanel
      Left = 0
      Top = 4850
      Width = 1074
      Height = 409
      HelpContext = 1095136
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095137
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label45: TLabel
        Left = 18
        Top = 14
        Width = 64
        Height = 15
        HelpContext = 1095138
        Caption = 'Quote Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label46: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095139
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label47: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095140
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label48: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095141
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label49: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095142
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label50: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095143
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label51: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095144
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label52: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095145
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtQuotePrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095146
        DataField = 'QuotePrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memQuotePrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095147
        DataField = 'QuotePrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableQuotePrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095148
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
        Caption = 'Auto Send Email When Quote is Printed'
        DataField = 'EnableQuotePrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableQuotePrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095149
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
        Caption = 'Auto Send SMS When Quote is Printed'
        DataField = 'EnableQuotePrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memQuotePrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095150
        DataField = 'QuotePrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlPOPrint: TDNMPanel
      Left = 0
      Top = 4032
      Width = 1074
      Height = 409
      HelpContext = 1095261
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      object Bevel18: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095262
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label133: TLabel
        Left = 18
        Top = 14
        Width = 121
        Height = 15
        HelpContext = 1095263
        Caption = 'Purchase Order Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label134: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095264
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label138: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095265
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label139: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095266
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label140: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095267
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label141: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095268
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label142: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095269
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label143: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095270
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtPOPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095271
        DataField = 'POPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memPOPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095272
        DataField = 'POPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnablePOPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095273
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
        Caption = 'Auto Send Email When Purchase Order is Printed'
        DataField = 'EnablePOPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnablePOPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095274
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
        Caption = 'Auto Send SMS When Purchase Order is Printed'
        DataField = 'EnablePOPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memPOPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095275
        DataField = 'POPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlPOSOReceipt: TDNMPanel
      Left = 0
      Top = 3623
      Width = 1074
      Height = 409
      HelpContext = 1095201
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      object Bevel12: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095202
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label82: TLabel
        Left = 18
        Top = 12
        Width = 270
        Height = 15
        HelpContext = 1095203
        Caption = 'Purchase Order Receive Goods For Sales Order'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label83: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095204
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label84: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095205
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label85: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095206
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label86: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095207
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label87: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095208
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label88: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095209
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label89: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095210
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtPOReceiveSOEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095211
        DataField = 'POReceiveSOEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memPOReceiveSOEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095212
        DataField = 'POReceiveSOEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnablePOReceiveSOEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095213
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
        Caption = 
          'Auto Send Email When Purchase Order Goods Are Received for a Sal' +
          'es Order'
        DataField = 'EnablePOReceiveSOEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnablePOReceiveSOSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095214
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
        Caption = 
          'Auto Send SMSWhen Purchase Order Goods Are Received for a Sales ' +
          'Order'
        DataField = 'EnablePOReceiveSOSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memPOReceiveSOSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095215
        DataField = 'POReceiveSOSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlPOInvoiceReceipt: TDNMPanel
      Left = 0
      Top = 3214
      Width = 1074
      Height = 409
      HelpContext = 1095216
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      object Bevel13: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095217
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label90: TLabel
        Left = 18
        Top = 12
        Width = 242
        Height = 15
        HelpContext = 1095218
        Caption = 'Purchase Order Receive Goods For Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label91: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095219
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label92: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095220
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label93: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095221
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label94: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095222
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label95: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095223
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label96: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095224
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label97: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095225
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtPOReceiveInvEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095226
        DataField = 'POReceiveInvEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memPOReceiveInvEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095227
        DataField = 'POReceiveInvEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnablePOReceiveInvEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095228
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
        Caption = 'Auto Send Email When Purchase Order Goods Are Received'
        DataField = 'EnablePOReceiveInvEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnablePOReceiveInvSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095229
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
        Caption = 'Auto Send SMS When Purchase Order Goods Are Received'
        DataField = 'EnablePOReceiveInvSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memPOReceiveInvSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095230
        DataField = 'POReceiveInvSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlPOCreate: TDNMPanel
      Left = 0
      Top = 2915
      Width = 1074
      Height = 299
      HelpContext = 1095393
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      object Bevel29: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 285
        HelpContext = 1095394
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label203: TLabel
        Left = 18
        Top = 14
        Width = 132
        Height = 15
        HelpContext = 1095395
        Caption = 'Purchase Order Create'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label204: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095396
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label205: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095397
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label206: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095398
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label207: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095399
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object edtPOCreateEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095400
        DataField = 'POCreateEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memPOCreateEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095401
        DataField = 'POCreateEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnablePOCreateEmail: TwwCheckBox
        Left = 70
        Top = 41
        Width = 16
        Height = 17
        HelpContext = 1095402
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
        Caption = 'Auto Send Email When Purchase Order is Created'
        DataField = 'EnablePOCreateEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
    end
    object pnlPrintStatementsSMS: TDNMPanel
      Left = 0
      Top = 2628
      Width = 1074
      Height = 171
      HelpContext = 1095376
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      object Bevel26: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 157
        HelpContext = 1095377
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label195: TLabel
        Left = 18
        Top = 14
        Width = 125
        Height = 15
        HelpContext = 1095378
        Caption = 'Print Statements SMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label201: TLabel
        Left = 21
        Top = 50
        Width = 43
        Height = 53
        HelpContext = 1095379
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label202: TLabel
        Left = 296
        Top = 132
        Width = 209
        Height = 15
        HelpContext = 1095380
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object memPrintStatementsSMSText: TDBMemo
        Left = 70
        Top = 47
        Width = 435
        Height = 83
        HelpContext = 1095381
        DataField = 'PrintStatementsSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
      end
    end
    object pnlPOSCashSalePrint: TDNMPanel
      Left = 0
      Top = 2219
      Width = 1074
      Height = 409
      HelpContext = 1095336
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      object Bevel23: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095337
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label175: TLabel
        Left = 18
        Top = 14
        Width = 115
        Height = 15
        HelpContext = 1095338
        Caption = 'POS Cash Sale Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label176: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095339
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label177: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095340
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label178: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095341
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label179: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095342
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label180: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095343
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label181: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095344
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label182: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095345
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtPOSCashSalePrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095346
        DataField = 'POSCashSalePrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memPOSCashSalePrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095347
        DataField = 'POSCashSalePrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnablePOSCashSalePrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095348
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
        Caption = 'Auto Send Email When POS Cash Sale is Printed'
        DataField = 'EnablePOSCashSalePrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnablePOSCashSalePrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095349
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
        Caption = 'Auto Send SMS When POS Cash Sale is Printed'
        DataField = 'EnablePOSCashSalePrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memPOSCashSalePrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095350
        DataField = 'POSCashSalePrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 2140
      Width = 1074
      Height = 79
      HelpContext = 1095388
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      object Bevel28: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 65
        HelpContext = 1095389
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 63
      end
      object Label199: TLabel
        Left = 14
        Top = 14
        Width = 59
        Height = 15
        HelpContext = 1095390
        Caption = 'Messages'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox3: TwwCheckBox
        Left = 21
        Top = 39
        Width = 324
        Height = 17
        HelpContext = 1095392
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
        Caption = 'Exclude Inactive Contacts from Messages'
        Checked = True
        DataField = 'ExcludeInactiveContactFromMessages'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
    end
    object pnlInvoiceShipChange: TDNMPanel
      Left = 0
      Top = 1731
      Width = 1074
      Height = 409
      HelpContext = 1095076
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object Bevel14: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095077
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitWidth = 529
        ExplicitHeight = 424
      end
      object Label98: TLabel
        Left = 18
        Top = 14
        Width = 114
        Height = 15
        HelpContext = 1095078
        Caption = 'Invoice Ship Change'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label99: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095079
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label100: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095080
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label101: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095081
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label102: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095082
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label103: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095083
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label104: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095084
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label105: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095085
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtInvShipChangeEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095086
        DataField = 'InvShipChangeEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memInvShipChangeEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095087
        DataField = 'InvShipChangeEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableInvShipChangeEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095088
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
        Caption = 'Auto Send Email When Invoice Ship Change'
        DataField = 'EnableInvShipChangeEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableInvShipChangeSMS: TwwCheckBox
        Left = 70
        Top = 265
        Width = 16
        Height = 17
        HelpContext = 1095089
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
        Caption = 'Auto Send SMS When Invoice Ship Change'
        DataField = 'EnableInvShipChangeSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memInvShipChangeSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095090
        DataField = 'InvShipChangeSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlInvoiceSave: TDNMPanel
      Left = 0
      Top = 1322
      Width = 1074
      Height = 409
      HelpContext = 1095061
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095062
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 394
      end
      object Label21: TLabel
        Left = 18
        Top = 14
        Width = 71
        Height = 15
        HelpContext = 1095063
        Caption = 'Invoice Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label22: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095064
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label23: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095065
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label24: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095066
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label25: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095067
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label26: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095068
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label27: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095069
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label28: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095070
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtInvoiceSaveEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095071
        DataField = 'InvoiceSaveEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memInvoiceSaveEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095072
        DataField = 'InvoiceSaveEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableInvoiceSaveMail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095073
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
        Caption = 'Auto Send Email When Invoice is Saved'
        DataField = 'EnableInvoiceSaveMail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableInvoiceSaveSMS: TwwCheckBox
        Left = 70
        Top = 265
        Width = 16
        Height = 17
        HelpContext = 1095074
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
        Caption = 'Auto Send SMS When Invoice is Saved'
        DataField = 'EnableInvoiceSaveSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memInvoiceSaveSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095075
        DataField = 'InvoiceSaveSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlInvoicePrint: TDNMPanel
      Left = 0
      Top = 913
      Width = 1074
      Height = 409
      HelpContext = 1095368
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095369
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 4
        ExplicitTop = 0
        ExplicitWidth = 537
        ExplicitHeight = 401
      end
      object Label13: TLabel
        Left = 18
        Top = 14
        Width = 70
        Height = 15
        HelpContext = 1095370
        Caption = 'Invoice Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095371
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label15: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095372
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label16: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095373
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095052
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label18: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095053
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label19: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095054
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label20: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095055
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtInvoiceMailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095374
        DataField = 'InvoiceMailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memInvoiceMailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095375
        DataField = 'InvoiceMailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableInvoiceMail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095058
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
        Caption = 'Auto Send Email When Invoice is Printed'
        DataField = 'EnableInvoiceMail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableInvoicePrintSMS: TwwCheckBox
        Left = 70
        Top = 265
        Width = 16
        Height = 17
        HelpContext = 1095059
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
        Caption = 'Auto Send SMS When Invoice is Printed'
        DataField = 'EnableInvoicePrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memInvoicePrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095060
        DataField = 'InvoicePrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlInvoicePickingSlip: TDNMPanel
      Left = 0
      Top = 504
      Width = 1074
      Height = 409
      HelpContext = 1095016
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095017
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label1: TLabel
        Left = 18
        Top = 14
        Width = 109
        Height = 15
        HelpContext = 1095018
        Caption = 'Invoice Picking Slip'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label135: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095019
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label136: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095020
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label137: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095021
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label149: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095022
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label2: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095023
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label3: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095024
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095025
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtInvoicePickEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095026
        DataField = 'InvoicePickMailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memInvoicePickMailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095027
        DataField = 'InvoicePickMailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableInvoicePickMail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095028
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
        Caption = 'Auto Send Email When Invoice is Picked'
        DataField = 'EnableInvoicePickMail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableInvoicePickSMS: TwwCheckBox
        Left = 70
        Top = 265
        Width = 16
        Height = 17
        HelpContext = 1095029
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
        Caption = 'Auto Send SMS When Invoice is Picked'
        DataField = 'EnableInvoicePickSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memInvoicePickSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095030
        DataField = 'InvoicePickSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlInvoiceEmailAttachment: TDNMPanel
      Left = 0
      Top = 225
      Width = 1074
      Height = 279
      HelpContext = 1095046
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Bevel25: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 265
        HelpContext = 1095047
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
      end
      object Label191: TLabel
        Left = 18
        Top = 14
        Width = 74
        Height = 15
        HelpContext = 1095048
        Caption = 'Invoice Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label192: TLabel
        Left = 21
        Top = 48
        Width = 43
        Height = 15
        HelpContext = 1095049
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label193: TLabel
        Left = 21
        Top = 85
        Width = 43
        Height = 53
        HelpContext = 1095050
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label194: TLabel
        Left = 296
        Top = 244
        Width = 209
        Height = 15
        HelpContext = 1095051
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtInvoiceEmailAttachmentSubject: TwwDBEdit
        Left = 70
        Top = 45
        Width = 435
        Height = 23
        HelpContext = 1095056
        DataField = 'InvoiceMailAttachmentSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memInvoiceMailAttachmentBodyText: TDBMemo
        Left = 70
        Top = 82
        Width = 435
        Height = 158
        HelpContext = 1095057
        DataField = 'InvoiceMailAttachmentBodyText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
    end
    object pnlInvoiceDel: TDNMPanel
      Left = 0
      Top = -184
      Width = 1074
      Height = 409
      HelpContext = 1095031
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095032
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
      end
      object Label5: TLabel
        Left = 18
        Top = 14
        Width = 88
        Height = 15
        HelpContext = 1095033
        Caption = 'Invoice Delivery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095034
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label7: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095035
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label8: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095036
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095037
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label10: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095038
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label11: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095039
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095040
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtInvoiceDelMailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095041
        DataField = 'InvoiceDelMailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memInvoiceDelMailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095042
        DataField = 'InvoiceDelMailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableInvoiceDelMail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095043
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
        Caption = 'Auto Send Email on Invoice Delivery'
        DataField = 'EnableInvoiceDelMail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableInvoiceDelSMS: TwwCheckBox
        Left = 70
        Top = 265
        Width = 16
        Height = 17
        HelpContext = 1095044
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
        Caption = 'Auto Send SMS on Invoice Delivery'
        DataField = 'EnableInvoiceDelSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memInvoiceDelSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095045
        DataField = 'InvoiceDelSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = -593
      Width = 1074
      Height = 409
      HelpContext = 1095306
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Bevel21: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095307
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object pnlCreditPrint: TLabel
        Left = 18
        Top = 14
        Width = 64
        Height = 15
        HelpContext = 1095308
        Caption = 'Credit Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label161: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095309
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label162: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095310
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label163: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095311
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label164: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095312
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label165: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095313
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label166: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095314
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label167: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095315
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtCreditPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095316
        DataField = 'CreditPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memCreditPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095317
        DataField = 'CreditPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableCreditPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095318
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
        Caption = 'Auto Send Email When Credit is Printed'
        DataField = 'EnableCreditPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableCreditPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095319
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
        Caption = 'Auto Send SMS When Credit is Printed'
        DataField = 'EnableCreditPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memCreditPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095320
        DataField = 'CreditPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlCashSalePrint: TDNMPanel
      Left = 0
      Top = -1002
      Width = 1074
      Height = 409
      HelpContext = 1095321
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel22: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095322
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label160: TLabel
        Left = 18
        Top = 14
        Width = 87
        Height = 15
        HelpContext = 1095323
        Caption = 'Cash Sale Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label168: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095324
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label169: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095325
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label170: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095326
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label171: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095327
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label172: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095328
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label173: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095329
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label174: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095330
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtCashSalePrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095331
        DataField = 'CashSalePrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memCashSalePrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095332
        DataField = 'CashSalePrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableCashSalePrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095333
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
        Caption = 'Auto Send Email When Cash Sale  is Printed'
        DataField = 'EnableCashSalePrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableCashSalePrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095334
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
        Caption = 'Auto Send SMS When Cash Sale  is Printed'
        DataField = 'EnableCashSalePrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memCashSalePrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095335
        DataField = 'CashSalePrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlBillPrint: TDNMPanel
      Left = 0
      Top = -1411
      Width = 1074
      Height = 409
      HelpContext = 1095291
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel20: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 395
        HelpContext = 1095292
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label144: TLabel
        Left = 18
        Top = 14
        Width = 47
        Height = 15
        HelpContext = 1095293
        Caption = 'Bill Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label153: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095294
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label154: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095295
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label155: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095296
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label156: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095297
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label157: TLabel
        Left = 98
        Top = 266
        Width = 87
        Height = 15
        HelpContext = 1095298
        Caption = 'Auto Send SMS'
        Transparent = True
      end
      object Label158: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095299
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label159: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095300
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtBillPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095301
        DataField = 'BillPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memBillPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095302
        DataField = 'BillPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableBillPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095303
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
        Caption = 'Auto Send Email When Bill is Printed'
        DataField = 'EnableBillPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableBillPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095304
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
        Caption = 'Auto Send SMS When Bill is Printed'
        DataField = 'EnableBillPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memBillPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095305
        DataField = 'BillPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
    end
    object pnlAppointment: TDNMPanel
      Left = 0
      Top = -1928
      Width = 1074
      Height = 517
      HelpContext = 1095181
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 503
        HelpContext = 1095182
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitWidth = 1051
      end
      object Label73: TLabel
        Left = 18
        Top = 14
        Width = 72
        Height = 15
        HelpContext = 1095183
        Caption = 'Appointment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label74: TLabel
        Left = 21
        Top = 67
        Width = 43
        Height = 15
        HelpContext = 1095184
        Alignment = taRightJustify
        Caption = 'Subject'
        Transparent = True
      end
      object Label75: TLabel
        Left = 21
        Top = 104
        Width = 43
        Height = 53
        HelpContext = 1095185
        AutoSize = False
        Caption = 'Email Text'
        Transparent = True
        WordWrap = True
      end
      object Label76: TLabel
        Left = 296
        Top = 261
        Width = 209
        Height = 15
        HelpContext = 1095186
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label77: TLabel
        Left = 98
        Top = 43
        Width = 92
        Height = 15
        HelpContext = 1095187
        Caption = 'Auto Send Email'
        Transparent = True
      end
      object Label78: TLabel
        Left = 98
        Top = 266
        Width = 146
        Height = 15
        HelpContext = 1095188
        Caption = 'Auto Send SMS Customer'
        Transparent = True
      end
      object Label79: TLabel
        Left = 21
        Top = 290
        Width = 43
        Height = 53
        HelpContext = 1095189
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label80: TLabel
        Left = 296
        Top = 372
        Width = 209
        Height = 15
        HelpContext = 1095190
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label130: TLabel
        Left = 21
        Top = 406
        Width = 43
        Height = 53
        HelpContext = 1095191
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label131: TLabel
        Left = 98
        Top = 382
        Width = 112
        Height = 15
        HelpContext = 1095192
        Caption = 'Auto Send SMS Rep'
        Transparent = True
      end
      object Label132: TLabel
        Left = 296
        Top = 488
        Width = 209
        Height = 15
        HelpContext = 1095193
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtAppointmentPrintEmailSubject: TwwDBEdit
        Left = 70
        Top = 64
        Width = 435
        Height = 23
        HelpContext = 1095194
        DataField = 'AppointmentPrintEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object memAppointmentPrintEmailText: TDBMemo
        Left = 70
        Top = 101
        Width = 435
        Height = 158
        HelpContext = 1095195
        DataField = 'AppointmentPrintEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 1
      end
      object chkEnableAppointmentPrintEmail: TwwCheckBox
        Left = 70
        Top = 42
        Width = 16
        Height = 17
        HelpContext = 1095196
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
        Caption = 'Auto Send Email When Appointments Are Printed'
        DataField = 'EnableAppointmentPrintEmail'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkEnableAppointmentPrintSMS: TwwCheckBox
        Left = 70
        Top = 264
        Width = 16
        Height = 17
        HelpContext = 1095197
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
        Caption = 'Auto Send SMS When Appointments Are Printed'
        DataField = 'EnableAppointmentPrintSMS'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object memAppointmentPrintSMSText: TDBMemo
        Left = 70
        Top = 287
        Width = 435
        Height = 83
        HelpContext = 1095198
        DataField = 'AppointmentPrintSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 4
      end
      object chkEnableAppointmentRepPrintSMS: TwwCheckBox
        Left = 70
        Top = 380
        Width = 16
        Height = 17
        HelpContext = 1095199
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
        Caption = 'Auto Send SMS to Rep When Appointments Are Printed'
        DataField = 'EnableAppointmentRepPrintSMS'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object memAppointmentPrintRepSMSText: TDBMemo
        Left = 70
        Top = 403
        Width = 435
        Height = 83
        HelpContext = 1095200
        DataField = 'AppointmentPrintRepSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 6
      end
    end
    object pnlARSMSText: TDNMPanel
      Left = 0
      Top = -2099
      Width = 1074
      Height = 171
      HelpContext = 1095382
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel27: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1060
        Height = 157
        HelpContext = 1095383
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 266
      end
      object Label196: TLabel
        Left = 18
        Top = 14
        Width = 148
        Height = 15
        HelpContext = 1095384
        Caption = 'Accounts Receivable SMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label197: TLabel
        Left = 21
        Top = 50
        Width = 43
        Height = 53
        HelpContext = 1095385
        AutoSize = False
        Caption = 'SMS Text'
        Transparent = True
        WordWrap = True
      end
      object Label198: TLabel
        Left = 296
        Top = 132
        Width = 209
        Height = 15
        HelpContext = 1095386
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Right Click for the Field List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object memARSMSText: TDBMemo
        Left = 70
        Top = 47
        Width = 435
        Height = 83
        HelpContext = 1095387
        DataField = 'ARSMSText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = mnuMsgText
        TabOrder = 0
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 617
    Top = 150
  end
  inherited tmrdelay: TTimer
    Left = 666
    Top = 150
  end
  inherited popSpelling: TPopupMenu
    Left = 866
    Top = 150
  end
  inherited tmrdelayMsg: TTimer
    Left = 716
    Top = 150
  end
  object dsPrefs: TDataSourcePrefs
    FieldDefs = <>
    FieldNames.Strings = (
      'AppointmentPrintEmailSubject'
      'AppointmentPrintEmailText'
      'AppointmentPrintRepSMSText'
      'AppointmentPrintSMSText'
      'ARSMSText'
      'BillPrintEmailSubject'
      'BillPrintEmailText'
      'BillPrintSMSText'
      'CashSalePrintEmailSubject'
      'CashSalePrintEmailText'
      'CashSalePrintSMSText'
      'CreditPrintEmailSubject'
      'CreditPrintEmailText'
      'CreditPrintSMSText'
      'EnableAppointmentPrintEmail'
      'EnableAppointmentPrintSMS'
      'EnableAppointmentRepPrintSMS'
      'EnableBillPrintEmail'
      'EnableBillPrintSMS'
      'EnableCashSalePrintEmail'
      'EnableCashSalePrintSMS'
      'EnableCreditPrintEmail'
      'EnableCreditPrintSMS'
      'EnableInvoiceDelMail'
      'EnableInvoiceDelSMS'
      'EnableInvoiceMail'
      'EnableInvoicePickMail'
      'EnableInvoicePickSMS'
      'EnableInvoicePrintSMS'
      'EnableInvoiceSaveMail'
      'EnableInvoiceSaveSMS'
      'EnableInvShipChangeEmail'
      'EnableInvShipChangeSMS'
      'EnablePOCreateEmail'
      'EnablePOPrintEmail'
      'EnablePOPrintSMS'
      'EnablePOReceiveInvEmail'
      'EnablePOReceiveInvSMS'
      'EnablePOReceiveSOEmail'
      'EnablePOReceiveSOSMS'
      'EnablePOSCashSalePrintEmail'
      'EnablePOSCashSalePrintSMS'
      'EnableQuotePrintEmail'
      'EnableQuotePrintSMS'
      'EnableQuoteSaveEmail'
      'EnableQuoteSaveSMS'
      'EnableRAPrintEmail'
      'EnableRAPrintSMS'
      'EnableRefundPrintEmail'
      'EnableRefundPrintSMS'
      'EnableRepairInvoicedEmail'
      'EnableRepairInvoicedSMS'
      'EnableRepairPrintEmail'
      'EnableRepairPrintSMS'
      'EnableShipContainerChangeEmail'
      'EnableSOPrintEmail'
      'EnableSOPrintSMS'
      'EnableSOSaveEmail'
      'EnableSOSaveSMS'
      'EnableSOShipChangeEmail'
      'EnableSOShipChangeSMS'
      'EnableVoucherSalePrintEmail'
      'EnablShipContainerChangeSMS'
      'EnablVoucherSalePrintSMS'
      'ExcludeInactiveContactFromMessages'
      'InvoiceDelMailSubject'
      'InvoiceDelMailText'
      'InvoiceDelSMSText'
      'InvoiceMailAttachmentBodyText'
      'InvoiceMailAttachmentSubject'
      'InvoiceMailSubject'
      'InvoiceMailText'
      'InvoicePickMailSubject'
      'InvoicePickMailText'
      'InvoicePickSMSText'
      'InvoicePrintSMSText'
      'InvoiceSaveEmailSubject'
      'InvoiceSaveEmailText'
      'InvoiceSaveSMSText'
      'InvShipChangeEmailSubject'
      'InvShipChangeEmailText'
      'InvShipChangeSMSText'
      'POCreateEmailSubject'
      'POCreateEmailText'
      'POPrintEmailSubject'
      'POPrintEmailText'
      'POPrintSMSText'
      'POReceiveInvEmailSubject'
      'POReceiveInvEmailText'
      'POReceiveInvSMSText'
      'POReceiveSOEmailSubject'
      'POReceiveSOEmailText'
      'POReceiveSOSMSText'
      'POSCashSalePrintEmailSubject'
      'POSCashSalePrintEmailText'
      'POSCashSalePrintSMSText'
      'PrintStatementsSMSText'
      'QuotePrintEmailSubject'
      'QuotePrintEmailText'
      'QuotePrintSMSText'
      'QuoteSaveEmailSubject'
      'QuoteSaveEmailText'
      'QuoteSaveSMSText'
      'RAPrintEmailSubject'
      'RAPrintEmailText'
      'RAPrintSMSText'
      'RefundPrintEmailSubject'
      'RefundPrintEmailText'
      'RefundPrintSMSText'
      'RepairInvoicedEmailSubject'
      'RepairInvoicedEmailText'
      'RepairInvoicedSMSText'
      'RepairPrintEmailSubject'
      'RepairPrintEmailText'
      'RepairPrintSMSText'
      'ShipContainerChangeEmailSubject'
      'ShipContainerChangeEmailText'
      'ShipContainerChangeSMSText'
      'SOPrintEmailSubject'
      'SOPrintEmailText'
      'SOPrintSMSText'
      'SOSaveEmailSubject'
      'SOSaveEmailText'
      'SOSaveSMSText'
      'SOShipChangeEmailSubject'
      'SOShipChangeEmailText'
      'SOShipChangeSMSText'
      'VoucherSalePrintEmailSubject'
      'VoucherSalePrintEmailText'
      'VoucherSalePrintSMSText')
    Left = 816
    Top = 150
  end
  object mnuMsgText: TAdvPopupMenu
    OnPopup = mnuMsgTextPopup
    Version = '2.5.3.4'
    Left = 766
    Top = 150
  end
end
