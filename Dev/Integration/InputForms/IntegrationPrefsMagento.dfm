object IntegrationPrefsMagentoGUI: TIntegrationPrefsMagentoGUI
  Left = 287
  Top = 127
  Caption = 'IntegrationPrefsMagentoGUI'
  ClientHeight = 380
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMagentoConfig: TDNMPanel
    Left = 10
    Top = 2
    Width = 551
    Height = 778
    HelpContext = 1686003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      551
      778)
    object Bevel1: TBevel
      Left = 6
      Top = 6
      Width = 539
      Height = 90
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 6
      Top = 648
      Width = 539
      Height = 5
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight]
      Shape = bsFrame
    end
    object lblTitle: TLabel
      Left = 14
      Top = 14
      Width = 49
      Height = 15
      HelpContext = 1686005
      Caption = 'Magento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 70
      Top = 180
      Width = 100
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Consumer Secret'
      Transparent = True
      Visible = False
    end
    object Label8: TLabel
      Left = 87
      Top = 144
      Width = 83
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Consumer Key'
      Transparent = True
      Visible = False
    end
    object Label4: TLabel
      Left = 14
      Top = 666
      Width = 76
      Height = 15
      HelpContext = 1686010
      Alignment = taRightJustify
      Caption = 'Admin Token '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object Label5: TLabel
      Left = 90
      Top = 217
      Width = 80
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Access Token'
      Transparent = True
      Visible = False
    end
    object Label6: TLabel
      Left = 49
      Top = 253
      Width = 121
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Access Token Secret'
      Transparent = True
      Visible = False
    end
    object Label1: TLabel
      Left = 100
      Top = 696
      Width = 74
      Height = 15
      HelpContext = 1686010
      Caption = 'Generated At'
      Transparent = True
      Visible = False
    end
    object Label2: TLabel
      Left = 116
      Top = 733
      Width = 58
      Height = 15
      HelpContext = 1686010
      Caption = 'Expires At'
      Transparent = True
      Visible = False
    end
    object Label3: TLabel
      Left = 115
      Top = 107
      Width = 55
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Base URL'
      Transparent = True
      Visible = False
    end
    object Label9: TLabel
      Left = 68
      Top = 326
      Width = 102
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Admin User Name'
      Transparent = True
      Visible = False
    end
    object Label10: TLabel
      Left = 73
      Top = 362
      Width = 97
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Admin Password'
      Transparent = True
      Visible = False
    end
    object Label11: TLabel
      Left = 109
      Top = 437
      Width = 61
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Sales Type'
      Transparent = True
      Visible = False
    end
    object Label12: TLabel
      Left = 76
      Top = 399
      Width = 94
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Synch Page Size'
      Transparent = True
      Visible = False
    end
    object Label13: TLabel
      Left = 259
      Top = 391
      Width = 159
      Height = 30
      HelpContext = 1686005
      Caption = 'DO NOT Change this Unless Magento Synch is too slow'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object Label14: TLabel
      Left = 103
      Top = 289
      Width = 67
      Height = 15
      HelpContext = 1686009
      Caption = 'Company ID'
      Transparent = True
      Visible = False
    end
    object Label15: TLabel
      Left = 89
      Top = 558
      Width = 81
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Product Name'
      Transparent = True
      Visible = False
    end
    object Label16: TLabel
      Left = 14
      Top = 532
      Width = 85
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Magento Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object Bevel3: TBevel
      AlignWithMargins = True
      Left = 6
      Top = 514
      Width = 539
      Height = 5
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight]
      Shape = bsFrame
    end
    object lblPrintNameToShortDes: TLabel
      Left = 54
      Top = 603
      Width = 116
      Height = 30
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Print Name To Short Description'
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object lblCopyProductinfoToERP: TLabel
      Left = 249
      Top = 603
      Width = 158
      Height = 30
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Synch Product Prices From Magento to ERP'
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object Label17: TLabel
      Left = 43
      Top = 482
      Width = 127
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Customer Identified by'
      Transparent = True
      Visible = False
    end
    object lbMagento: TLabel
      Left = 248
      Top = 35
      Width = 221
      Height = 15
      HelpContext = 504027
      Caption = 'Please contact ERP to enable Magento.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object edtConsumer_Secret: TEdit
      Left = 180
      Top = 178
      Width = 325
      Height = 23
      HelpContext = 1686011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
      Visible = False
      OnChange = edtConsumer_SecretChange
      OnMouseDown = edtConsumer_SecretMouseDown
      OnMouseUp = edtConsumer_SecretMouseUp
    end
    object edtConsumer_Key: TEdit
      Left = 180
      Top = 142
      Width = 325
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnChange = edtConsumer_KeyChange
    end
    object chkShowMagentoOnMainMenu: TwwCheckBox
      Left = 77
      Top = 70
      Width = 261
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Show Magento on Main Menu by Default'
      TabOrder = 0
      OnClick = chkShowMagentoOnMainMenuClick
    end
    object dtAuthTokenGeneratedAt: TDateTimePicker
      Left = 184
      Top = 695
      Width = 178
      Height = 23
      Date = 43794.551431354160000000
      Time = 43794.551431354160000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Visible = False
    end
    object edtAccess_Token: TEdit
      Left = 180
      Top = 214
      Width = 325
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnChange = edtAccess_TokenChange
    end
    object edtAccess_Token_Secret: TEdit
      Left = 180
      Top = 250
      Width = 325
      Height = 23
      HelpContext = 1686011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 5
      Visible = False
      OnChange = edtAccess_Token_SecretChange
      OnMouseDown = edtAccess_Token_SecretMouseDown
      OnMouseUp = edtAccess_Token_SecretMouseUp
    end
    object dtTokenExpireTime: TDateTimePicker
      Left = 184
      Top = 729
      Width = 178
      Height = 23
      Date = 43794.551431354160000000
      Time = 43794.551431354160000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Visible = False
    end
    object edtAPI_Base_URL: TEdit
      Left = 180
      Top = 106
      Width = 325
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnChange = edtAPI_Base_URLChange
    end
    object edtAdminUserName: TEdit
      Left = 180
      Top = 322
      Width = 250
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Visible = False
      OnChange = edtAdminUserNameChange
    end
    object edtAdminPassword: TEdit
      Left = 180
      Top = 358
      Width = 250
      Height = 23
      HelpContext = 1686011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 7
      Visible = False
      OnChange = edtAdminPasswordChange
      OnMouseDown = edtAdminPasswordMouseDown
      OnMouseUp = edtAdminPasswordMouseUp
    end
    object btnHelp: TDNMSpeedButton
      Left = 460
      Top = 348
      Width = 49
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Help'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 10
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnHelpClick
    end
    object Optsalestype: TAdvOfficeRadioGroup
      Left = 180
      Top = 425
      Width = 250
      Height = 39
      Version = '1.3.0.0'
      ParentBackground = False
      TabOrder = 11
      Visible = False
      OnClick = OptsalestypeClick
      Columns = 2
      Items.Strings = (
        'Sales Order'
        'Invoice')
      Ellipsis = False
    end
    object edtSynchPageSize: TAdvSpinEdit
      Left = 180
      Top = 394
      Width = 73
      Height = 24
      Value = 1
      FloatValue = 1.000000000000000000
      TimeValue = 0.041666666666666660
      HexValue = 0
      Enabled = True
      IncrementFloat = 0.100000000000000000
      IncrementFloatPage = 1.000000000000000000
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      MaxValue = 1000
      MinValue = 1
      TabOrder = 12
      Visible = False
      Version = '1.4.7.0'
      OnChange = edtSynchPageSizeChange
    end
    object edtCompanyId: TEdit
      Left = 180
      Top = 286
      Width = 325
      Height = 23
      HelpContext = 1686014
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      Visible = False
      OnChange = edtCompanyIdChange
    end
    object chkEnableMagento: TwwCheckBox
      Left = 77
      Top = 35
      Width = 124
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Magento Enabled'
      Enabled = False
      TabOrder = 14
      OnClick = chkEnableMagentoClick
    end
    object OptProductnameMaping: TAdvOfficeRadioGroup
      Left = 180
      Top = 548
      Width = 250
      Height = 39
      Version = '1.3.0.0'
      ParentBackground = False
      TabOrder = 15
      Visible = False
      OnClick = OptProductnameMapingClick
      Columns = 2
      Items.Strings = (
        'Product Name'
        'Print Name')
      Ellipsis = False
    end
    object chkPrintNameToShortDes: TwwCheckBox
      Left = 180
      Top = 610
      Width = 17
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Print Name To Short Description'
      TabOrder = 16
      OnClick = chkPrintNameToShortDesClick
    end
    object chkCopyProductinfoToERP: TwwCheckBox
      Left = 413
      Top = 610
      Width = 17
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Synch Product Details from Magento to ERP'
      TabOrder = 17
      Visible = False
      OnClick = chkCopyProductinfoToERPClick
    end
    object OptCustomerIDType: TAdvOfficeRadioGroup
      Left = 180
      Top = 470
      Width = 250
      Height = 39
      Version = '1.3.0.0'
      ParentBackground = False
      TabOrder = 18
      Visible = False
      OnClick = OptCustomerIDTypeClick
      Columns = 2
      Items.Strings = (
        'Name'
        'Email')
      Ellipsis = False
    end
    object chkAutosynchList: TwwCheckBox
      Left = 21
      Top = 121
      Width = 153
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Auto Synch From List'
      TabOrder = 19
      OnClick = chkAutosynchListClick
    end
  end
end
