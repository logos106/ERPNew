object IntegrationPrefsAmazonGUI: TIntegrationPrefsAmazonGUI
  Left = 838
  Top = 139
  HelpContext = 1685002
  Caption = 'IntegrationPrefsAmazonGUI'
  ClientHeight = 490
  ClientWidth = 635
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
  object pnlAmazonConfig: TDNMPanel
    Left = 16
    Top = 28
    Width = 545
    Height = 429
    HelpContext = 1685003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      545
      429)
    object Bevel8: TBevel
      Left = 3
      Top = 3
      Width = 539
      Height = 423
      HelpContext = 1685004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 335
    end
    object Label7: TLabel
      Left = 14
      Top = 14
      Width = 46
      Height = 15
      HelpContext = 1685005
      Caption = 'Amazon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblAmazonEnabled: TLabel
      Left = 19
      Top = 116
      Width = 100
      Height = 117
      HelpContext = 1685006
      AutoSize = False
      Caption = 'lblAmazonEnabled'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object GroupBox1: TGroupBox
      Left = 141
      Top = 14
      Width = 392
      Height = 408
      HelpContext = 1685007
      Caption = 'Amazon Account Settings'
      TabOrder = 2
      object Label10: TLabel
        Left = 77
        Top = 39
        Width = 67
        Height = 15
        HelpContext = 1685008
        Alignment = taRightJustify
        Caption = 'Access Key'
        Transparent = True
      end
      object Label11: TLabel
        Left = 82
        Top = 68
        Width = 62
        Height = 15
        HelpContext = 1685009
        Alignment = taRightJustify
        Caption = 'Secret Key'
        Transparent = True
      end
      object Label81: TLabel
        Left = 48
        Top = 145
        Width = 96
        Height = 15
        HelpContext = 1685010
        Alignment = taRightJustify
        Caption = 'MWS Auth Token'
        Transparent = True
      end
      object Label1: TLabel
        Left = 98
        Top = 174
        Width = 46
        Height = 15
        HelpContext = 1685011
        Alignment = taRightJustify
        Caption = 'Seller Id'
        Transparent = True
      end
      object Label5: TLabel
        Left = 68
        Top = 235
        Width = 76
        Height = 15
        HelpContext = 1685012
        Alignment = taRightJustify
        Caption = 'Services URL'
        Transparent = True
      end
      object Label2: TLabel
        Left = 60
        Top = 203
        Width = 84
        Height = 15
        HelpContext = 1685013
        Alignment = taRightJustify
        Caption = 'Marketplace Id'
        Transparent = True
      end
      object Label3: TLabel
        Left = 39
        Top = 266
        Width = 105
        Height = 15
        HelpContext = 1685014
        Alignment = taRightJustify
        Caption = 'Amazon Customer'
        Transparent = True
      end
      object Label4: TLabel
        Left = 122
        Top = 94
        Width = 253
        Height = 27
        HelpContext = 1685015
        AutoSize = False
        Caption = 'These 2 fields from Amazon Developer Central Information.'
        Enabled = False
        WordWrap = True
      end
      object Label6: TLabel
        Left = 11
        Top = 325
        Width = 116
        Height = 15
        HelpContext = 1685014
        Alignment = taRightJustify
        Caption = 'Amazon Department'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 24
        Top = 346
        Width = 104
        Height = 15
        HelpContext = 1685014
        Alignment = taRightJustify
        Caption = 'Amazon Fulfilment'
        Transparent = True
      end
      object Label9: TLabel
        Left = 18
        Top = 375
        Width = 112
        Height = 15
        HelpContext = 1685014
        Alignment = taRightJustify
        Caption = 'Merchant Fulfilment'
        Transparent = True
      end
      object edtAccessKey: TEdit
        Left = 151
        Top = 36
        Width = 239
        Height = 23
        HelpContext = 1685016
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edtChange
      end
      object edtSecretKey: TEdit
        Left = 151
        Top = 65
        Width = 239
        Height = 23
        HelpContext = 1685017
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        OnChange = edtChange
      end
      object edtMWSAuthToken: TEdit
        Left = 151
        Top = 142
        Width = 239
        Height = 23
        HelpContext = 1685018
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        OnChange = edtChange
      end
      object edtSellerId: TEdit
        Left = 151
        Top = 171
        Width = 239
        Height = 23
        HelpContext = 1685019
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edtChange
      end
      object edtServicesURL: TEdit
        Left = 151
        Top = 232
        Width = 239
        Height = 23
        HelpContext = 1685020
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = edtChange
      end
      object edtMarketplaceId: TEdit
        Left = 151
        Top = 200
        Width = 239
        Height = 23
        HelpContext = 1685021
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnChange = edtChange
      end
      object cboAmazonCustomer: TwwDBLookupCombo
        Left = 151
        Top = 263
        Width = 238
        Height = 23
        HelpContext = 1685022
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        LookupTable = qryCustomerLookup
        LookupField = 'PrintName'
        ParentFont = False
        TabOrder = 8
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboAmazonCustomerChange
      end
      object cboAmazonAFNClass: TwwDBLookupCombo
        Left = 134
        Top = 342
        Width = 238
        Height = 23
        HelpContext = 1685022
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        LookupTable = qryAFNClassLookup
        LookupField = 'Classname'
        ParentFont = False
        TabOrder = 9
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboAmazonAFNClassChange
      end
      object cboAmazonMFNClass: TwwDBLookupCombo
        Left = 134
        Top = 371
        Width = 238
        Height = 23
        HelpContext = 1685022
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        LookupTable = qryMFNClassLookup
        LookupField = 'Classname'
        ParentFont = False
        TabOrder = 6
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboAmazonMFNClassChange
      end
      object chkAutoCheckForOrders: TwwCheckBox
        Left = 11
        Top = 295
        Width = 156
        Height = 17
        HelpContext = 1685023
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Auto Check For Orders'
        TabOrder = 7
        OnClick = chkAutoCheckForOrdersClick
      end
    end
    object chkAmazonEnabled: TwwCheckBox
      Left = 19
      Top = 47
      Width = 116
      Height = 17
      HelpContext = 1685024
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
      Caption = 'Amazon Enabled'
      TabOrder = 0
      OnClick = chkAmazonEnabledClick
    end
    object btnAmazonTest: TDNMSpeedButton
      Left = 19
      Top = 78
      Width = 87
      Height = 27
      HelpContext = 1685025
      Anchors = [akTop, akRight]
      Caption = 'Test'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnAmazonTestClick
    end
    object btnTestAccount: TDNMSpeedButton
      Left = 9
      Top = 208
      Width = 116
      Height = 27
      HelpContext = 1685026
      Anchors = [akTop, akRight]
      Caption = 'Load Test Settings'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 3
      Visible = False
      AutoDisableParentOnclick = True
    end
  end
  object qryCustomerLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, PrintName FROM tblclients '
      'WHERE Customer = "T" AND Active = "T"'
      'order by PrintName')
    Left = 384
    Top = 384
  end
  object dsCustomerLookup: TDataSource
    DataSet = qryCustomerLookup
    Left = 464
    Top = 376
  end
  object qryAFNClassLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT classId, classname FROM tblclass WHERE active ="T" ORDER ' +
        'BY classname')
    Left = 352
    Top = 384
  end
  object qryMFNClassLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT classId, classname FROM tblclass WHERE active ="T" ORDER ' +
        'BY classname')
    Left = 352
    Top = 384
  end
end
