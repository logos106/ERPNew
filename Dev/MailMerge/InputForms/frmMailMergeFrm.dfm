inherited frmMailMerge: TfrmMailMerge
  Left = 560
  Top = 170
  HelpContext = 34000
  Caption = 'Mail Merge'
  ClientHeight = 476
  ClientWidth = 681
  OldCreateOrder = True
  ExplicitLeft = 560
  ExplicitTop = 170
  ExplicitWidth = 697
  ExplicitHeight = 515
  DesignSize = (
    681
    476)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 66
    Width = 681
    HelpContext = 34001
    ExplicitTop = 453
    ExplicitWidth = 681
  end
  object DNMPanel2: TDNMPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 371
    Width = 675
    Height = 50
    HelpContext = 34003
    Margins.Bottom = 55
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 342
    ExplicitWidth = 664
    object lblemail: TLabel
      Left = 327
      Top = 17
      Width = 79
      Height = 15
      HelpContext = 34004
      Caption = 'Email subject:'
      Transparent = True
    end
    object rgSendMode: TwwRadioGroup
      Left = 40
      Top = 9
      Width = 281
      Height = 32
      HelpContext = 34005
      DisableThemes = False
      ItemIndex = 0
      TransparentActiveItem = True
      Indents.TextX = 5
      ShowGroupCaption = False
      Transparent = True
      Columns = 3
      Items.Strings = (
        'Email'
        'Print'
        'File')
      TabOrder = 0
      OnChange = rgSendModeChange
    end
    object edSubject: TwwDBEdit
      Left = 415
      Top = 13
      Width = 217
      Height = 23
      HelpContext = 34006
      Font.Charset = DEFAULT_CHARSET
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
  end
  object btnSetupHost: TDNMSpeedButton [6]
    Left = 28
    Top = 425
    Width = 87
    Height = 27
    HelpContext = 34007
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Setup &Host'
    Color = clBtnFace
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -13
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 4
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnSetupHostClick
    ExplicitTop = 402
  end
  object pnlmain: TDNMPanel [7]
    AlignWithMargins = True
    Left = 3
    Top = 69
    Width = 675
    Height = 296
    HelpContext = 34008
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 63
    ExplicitWidth = 664
    object Label7: TLabel
      Left = 467
      Top = 9
      Width = 52
      Height = 15
      HelpContext = 34015
      Caption = 'Template'
      Transparent = True
    end
    object Label9: TLabel
      Left = 135
      Top = 9
      Width = 29
      Height = 15
      HelpContext = 34016
      Caption = 'Send'
      Transparent = True
    end
    object Label10: TLabel
      Left = 36
      Top = 9
      Width = 34
      Height = 15
      HelpContext = 34017
      Caption = 'Group'
      Transparent = True
    end
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 4
      Top = 35
      Width = 667
      Height = 5
      HelpContext = 34018
      Align = alBottom
      ExplicitLeft = 16
      ExplicitTop = 29
      ExplicitWidth = 633
    end
    object Label11: TLabel
      Left = 247
      Top = 9
      Width = 52
      Height = 15
      HelpContext = 34019
      Caption = 'Filter List'
      Transparent = True
    end
    object pnlCustomerList: TDNMPanel
      Left = 1
      Top = 43
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 45
      ExplicitWidth = 656
      object Label1: TLabel
        Left = 24
        Top = 9
        Width = 63
        Height = 15
        HelpContext = 34009
        Caption = 'Customers'
        Transparent = True
      end
      object chkCustomer: TwwCheckBox
        Left = 142
        Top = 8
        Width = 19
        Height = 17
        HelpContext = 34021
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboCustomerList: TComboBox
        Left = 199
        Top = 5
        Width = 156
        Height = 23
        HelpContext = 34038
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboCustomerListChange
        OnDropDown = cboCustomerListDropDown
        Items.Strings = (
          'Customer List'
          'Customer Details List'
          'Back Order List'
          '')
      end
      object btnCustomerList: TDNMSpeedButton
        Left = 360
        Top = 5
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboCustomerListChange
      end
      object cboCustomerTemplate: TwwDBLookupCombo
        Left = 392
        Top = 5
        Width = 245
        Height = 23
        HelpContext = 34027
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = qryCustomersTemplates
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlshippingcontainer: TDNMPanel
      Left = 1
      Top = 259
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      ExplicitLeft = 256
      ExplicitTop = 112
      ExplicitWidth = 656
      object Label8: TLabel
        Left = 24
        Top = 10
        Width = 107
        Height = 15
        HelpContext = 34020
        Caption = 'Shipping Container'
        Transparent = True
      end
      object chkshippingcontainer: TwwCheckBox
        Left = 142
        Top = 9
        Width = 19
        Height = 17
        HelpContext = 34039
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboshippingcontainer: TComboBox
        Left = 199
        Top = 6
        Width = 156
        Height = 23
        HelpContext = 34040
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboshippingcontainerChange
        OnDropDown = cboMarketingListDropDown
        Items.Strings = (
          'Shipping Container list')
      end
      object btnshippingcontainer: TDNMSpeedButton
        Left = 360
        Top = 6
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboshippingcontainerChange
      end
      object cboShippingcontainerTemplate: TwwDBLookupCombo
        Left = 392
        Top = 6
        Width = 245
        Height = 23
        HelpContext = 34041
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = QryShipingcontainerMailMerge
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlMarketingList: TDNMPanel
      Left = 1
      Top = 223
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      ExplicitLeft = 8
      ExplicitTop = 29
      ExplicitWidth = 656
      object Label6: TLabel
        Left = 24
        Top = 15
        Width = 57
        Height = 15
        HelpContext = 34014
        Caption = 'Marketing'
        Transparent = True
      end
      object chkMarketing: TwwCheckBox
        Left = 142
        Top = 13
        Width = 19
        Height = 17
        HelpContext = 34026
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboMarketingList: TComboBox
        Left = 198
        Top = 7
        Width = 156
        Height = 23
        HelpContext = 34033
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboMarketingListChange
        OnDropDown = cboMarketingListDropDown
        Items.Strings = (
          'Marketing List'
          'Marketing Leads List'
          'Telemarketing List')
      end
      object btnMarketingList: TDNMSpeedButton
        Left = 360
        Top = 7
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboMarketingListChange
      end
      object cboMarketingTemplate: TwwDBLookupCombo
        Left = 392
        Top = 7
        Width = 245
        Height = 23
        HelpContext = 34031
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = qryMarketingTemplates
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlLoyaltyList: TDNMPanel
      Left = 1
      Top = 187
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      ExplicitLeft = 8
      ExplicitTop = 21
      ExplicitWidth = 656
      object Label5: TLabel
        Left = 24
        Top = 15
        Width = 40
        Height = 15
        HelpContext = 34013
        Caption = 'Loyalty'
        Transparent = True
      end
      object chkLoyalty: TwwCheckBox
        Left = 142
        Top = 13
        Width = 19
        Height = 17
        HelpContext = 34025
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboLoyaltyList: TComboBox
        Left = 199
        Top = 7
        Width = 156
        Height = 23
        HelpContext = 34034
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboLoyaltyListChange
        OnDropDown = cboLoyaltyListDropDown
        Items.Strings = (
          'Loyalty List'
          'Customer List'
          'Sales Order List')
      end
      object btnLoyaltyList: TDNMSpeedButton
        Left = 360
        Top = 7
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboLoyaltyListChange
      end
      object cboLoyaltyTemplate: TwwDBLookupCombo
        Left = 392
        Top = 7
        Width = 245
        Height = 23
        HelpContext = 34032
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = qryLoyaltyTemplates
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlOtherContactsList: TDNMPanel
      Left = 1
      Top = 151
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ExplicitLeft = 8
      ExplicitTop = 13
      ExplicitWidth = 656
      object Label4: TLabel
        Left = 24
        Top = 15
        Width = 59
        Height = 15
        HelpContext = 34012
        Caption = 'Prospects'
        Transparent = True
      end
      object chkOtherContacts: TwwCheckBox
        Left = 142
        Top = 13
        Width = 19
        Height = 17
        HelpContext = 34024
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboOtherContactsList: TComboBox
        Left = 199
        Top = 7
        Width = 156
        Height = 23
        HelpContext = 34035
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboOtherContactsListChange
        OnDropDown = cboOtherContactsListDropDown
        Items.Strings = (
          'Other Contacts List'
          'Appointments List')
      end
      object btnOtherContactsList: TDNMSpeedButton
        Left = 360
        Top = 7
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboOtherContactsListChange
      end
      object cboOtherTemplate: TwwDBLookupCombo
        Left = 392
        Top = 7
        Width = 245
        Height = 23
        HelpContext = 34030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = qryOtherContactsTemplates
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlEmployeesList: TDNMPanel
      Left = 1
      Top = 115
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 8
      ExplicitTop = 5
      ExplicitWidth = 656
      object Label3: TLabel
        Left = 24
        Top = 15
        Width = 62
        Height = 15
        HelpContext = 34011
        Caption = 'Employees'
        Transparent = True
      end
      object chkEmployees: TwwCheckBox
        Left = 142
        Top = 13
        Width = 19
        Height = 17
        HelpContext = 34023
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboEmployeesList: TComboBox
        Left = 199
        Top = 7
        Width = 156
        Height = 23
        HelpContext = 34036
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboEmployeesListChange
        OnDropDown = cboEmployeesListDropDown
        Items.Strings = (
          'Employees List'
          'Rep List'
          'To Do List')
      end
      object btnEmployeesList: TDNMSpeedButton
        Left = 360
        Top = 7
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboEmployeesListChange
      end
      object cboEmployeesTemplate: TwwDBLookupCombo
        Left = 392
        Top = 7
        Width = 245
        Height = 23
        HelpContext = 34029
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = qryEmployeesTemplates
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlSuppliersList: TDNMPanel
      Left = 1
      Top = 79
      Width = 673
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = -3
      ExplicitWidth = 656
      object Label2: TLabel
        Left = 24
        Top = 15
        Width = 54
        Height = 15
        HelpContext = 34010
        Caption = 'Suppliers'
        Transparent = True
      end
      object chkSuppliers: TwwCheckBox
        Left = 142
        Top = 13
        Width = 19
        Height = 17
        HelpContext = 34022
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
        TabOrder = 0
        OnClick = chkCustomerClick
      end
      object cboSuppliersList: TComboBox
        Left = 199
        Top = 7
        Width = 156
        Height = 23
        HelpContext = 34037
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboSuppliersListChange
        OnDropDown = cboSuppliersListDropDown
        Items.Strings = (
          'Suppliers List'
          'Purchase Order List'
          'Bill List')
      end
      object btnSuppliersList: TDNMSpeedButton
        Left = 360
        Top = 7
        Width = 26
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = cboSuppliersListChange
      end
      object cboSuppliersTemplate: TwwDBLookupCombo
        Left = 392
        Top = 7
        Width = 245
        Height = 23
        HelpContext = 34028
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'30'#9'TemplName'#9'F')
        LookupTable = qrySuppliersTemplates
        LookupField = 'TemplID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
  end
  object pnlTitle: TDNMPanel [8]
    Left = 236
    Top = 7
    Width = 238
    Height = 50
    HelpContext = 34042
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
      Height = 46
      HelpContext = 34043
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
        Height = 46
        HelpContext = 34044
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Mail Merge'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object cmdClose: TDNMSpeedButton [9]
    Left = 361
    Top = 441
    Width = 87
    Height = 27
    Hint = '"Close The List"'
    HelpContext = 34045
    Anchors = [akRight, akBottom]
    Caption = '&Close'
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
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = cmdCloseClick
    ExplicitTop = 418
  end
  object btnSend: TDNMSpeedButton [10]
    Left = 236
    Top = 441
    Width = 87
    Height = 27
    HelpContext = 34002
    Anchors = [akLeft, akBottom]
    Caption = '&Send'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnSendClick
    ExplicitTop = 418
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004C00500010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryCustomersTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 480
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'typename'
      end>
    object qryCustomersTemplatesTemplName: TWideStringField
      DisplayWidth = 30
      FieldName = 'TemplName'
      Size = 30
    end
    object qryCustomersTemplatesTemplID: TIntegerField
      FieldName = 'TemplID'
      Visible = False
    end
  end
  object qrySuppliersTemplates: TERPQuery
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 509
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeName'
      end>
  end
  object qryEmployeesTemplates: TERPQuery
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 538
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeName'
      end>
  end
  object qryOtherContactsTemplates: TERPQuery
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 568
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeName'
      end>
  end
  object qryLoyaltyTemplates: TERPQuery
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 597
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeName'
      end>
  end
  object qryMarketingTemplates: TERPQuery
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 626
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeName'
      end>
  end
  object DSMMHost: TDataSource
    DataSet = qryMMHost
    Left = 232
    Top = 8
  end
  object qryMMHost: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblmailmergehost')
    Left = 272
    Top = 8
  end
  object QryShipingcontainerMailMerge: TERPQuery
    SQL.Strings = (
      'Select TemplID,TemplName from tbltemplates T'
      'INNER JOIN tbltemplatetype TT on T.TypeID = TT.TypeID'
      'WHERE TT.TypeName = :TypeName'
      'Order by  TemplName')
    Left = 656
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeName'
      end>
  end
end
