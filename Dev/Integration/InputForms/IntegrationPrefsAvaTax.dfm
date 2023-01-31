object IntegrationPrefsAvaTaxGUI: TIntegrationPrefsAvaTaxGUI
  Left = 363
  Top = 124
  Caption = 'Integration Prefs AvaTax'
  ClientHeight = 739
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    625
    739)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAvaTaxConfig: TDNMPanel
    Left = 37
    Top = 8
    Width = 551
    Height = 705
    HelpContext = 1686003
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      551
      705)
    object Bevel1: TBevel
      Left = 6
      Top = 7
      Width = 539
      Height = 692
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object lblTitle: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 527
      Height = 15
      HelpContext = 1686005
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Align = alTop
      Caption = 'Avalara Tax'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      ExplicitWidth = 66
    end
    object PnlERP: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 81
      Width = 527
      Height = 135
      Margins.Left = 11
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      BevelEdges = [beRight, beBottom]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 31
        Top = 12
        Width = 126
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'AvaTax Account Type :'
        Transparent = True
      end
      object Label5: TLabel
        Left = 92
        Top = 51
        Width = 65
        Height = 15
        HelpContext = 1686007
        Alignment = taRightJustify
        Caption = 'Username :'
        Transparent = True
      end
      object Label6: TLabel
        Left = 93
        Top = 81
        Width = 64
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Password :'
        Transparent = True
      end
      object Label7: TLabel
        Left = 96
        Top = 111
        Width = 61
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Base URL :'
        Transparent = True
      end
      object OptAccountType: TAdvOfficeRadioGroup
        Left = 167
        Top = -1
        Width = 234
        Height = 39
        Version = '1.3.0.0'
        ParentBackground = False
        TabOrder = 0
        OnExit = OptAccountTypeClick
        Columns = 2
        Items.Strings = (
          'Sandbox'
          'Production')
        Ellipsis = False
      end
      object edtUsername: TEdit
        Left = 163
        Top = 45
        Width = 341
        Height = 23
        HelpContext = 1686012
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnExit = edtUsernameChange
      end
      object edtPassword: TEdit
        Left = 166
        Top = 77
        Width = 341
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        OnExit = edtPasswordChange
      end
      object edtBaseURL: TEdit
        Left = 166
        Top = 107
        Width = 341
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnExit = edtBaseURLChange
      end
      object btnCoreEdiDetails: TDNMSpeedButton
        Left = 407
        Top = -1
        Width = 100
        Height = 40
        Caption = 'Core EDI Details for Avalara'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 4
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnCoreEdiDetailsClick
      end
    end
    object pnlcommon: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 220
      Width = 527
      Height = 91
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      BevelEdges = [beRight, beBottom]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label4: TLabel
        Left = 52
        Top = 66
        Width = 108
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'AvaTax Sales Code'
        Transparent = True
      end
      object Label2: TLabel
        Left = 87
        Top = 4
        Width = 73
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Company ID :'
        Transparent = True
      end
      object Label3: TLabel
        Left = 69
        Top = 35
        Width = 91
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Company Code :'
        Transparent = True
      end
      object edtCompanyCode: TEdit
        Left = 166
        Top = 31
        Width = 341
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnExit = edtCompanyCodeChange
      end
      object edtCompanyID: TEdit
        Left = 166
        Top = 0
        Width = 341
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnExit = edtCompanyIDChange
      end
      object edtAvaTaxSaleCode: TEdit
        Left = 166
        Top = 62
        Width = 341
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtAvaTaxSaleCodeChange
      end
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 33
      Width = 527
      Height = 42
      Margins.Left = 11
      Margins.Right = 11
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object chkEnableAvaTax: TwwCheckBox
        Left = 70
        Top = 24
        Width = 117
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Enable AvaTax'
        TabOrder = 0
        OnClick = chkEnableAvaTaxClick
      end
      object chkShowAvaTaxOnMainMenu: TwwCheckBox
        Left = 236
        Top = 24
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
        Caption = 'Show AvaTax on Main Menu by Default'
        TabOrder = 1
        OnClick = chkShowAvaTaxOnMainMenuClick
      end
      object chkAutosynchList: TwwCheckBox
        Left = 316
        Top = -7
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
        TabOrder = 2
        Visible = False
        OnClick = chkAutosynchListClick
      end
    end
    object pnlLocations: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 657
      Width = 527
      Height = 78
      Margins.Left = 11
      Margins.Right = 11
      Align = alTop
      BevelEdges = [beRight, beBottom]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      Visible = False
      DesignSize = (
        527
        78)
      object Label9: TLabel
        Left = 8
        Top = 70
        Width = 79
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Tax Locations'
        Transparent = True
      end
      object btnNewLoc: TDNMSpeedButton
        Left = 388
        Top = 0
        Width = 147
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'Add a New Location'
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
        TabOrder = 0
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnNewLocClick
      end
      object grdTaxLocations: TwwDBGrid
        Left = 0
        Top = -22
        Width = 527
        Height = 100
        Selected.Strings = (
          'jurisdictionTypeId'#9'10'#9'Type'#9'F'#9'Location'
          'jurisName'#9'15'#9'Name'#9'F'#9'Location'
          'jurisCode'#9'10'#9'Code'#9'F'#9'Location'
          'country'#9'10'#9'Country'#9'F'#9'Location'
          'nexusTypeId'#9'21'#9'Tax Type'#9'F'#9)
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alBottom
        Color = clWhite
        DataSource = dsTaxLocations
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = True
        UseTFields = False
        LineColors.GroupingColor = clSilver
        FooterCellColor = clWhite
        ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
      end
    end
    object pnlHint: TPanel
      AlignWithMargins = True
      Left = 133
      Top = 568
      Width = 386
      Height = 83
      Margins.Left = 132
      Margins.Right = 31
      Align = alTop
      BevelEdges = [beRight, beBottom]
      BevelOuter = bvNone
      Color = clMaroon
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      object lblHintAvalara: TLabel
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 384
        Height = 57
        Cursor = crHandPoint
        HelpContext = 1686005
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alClient
        Alignment = taCenter
        Caption = 'Please Ensure Your Avalara Account Details are Fully Setup'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlBottom
        WordWrap = True
        OnMouseDown = lblHintAvalaraMouseDown
        ExplicitWidth = 373
        ExplicitHeight = 48
      end
      object lblHintAvalaraLink: TLabel
        AlignWithMargins = True
        Left = 1
        Top = 58
        Width = 384
        Height = 24
        Cursor = crHandPoint
        HelpContext = 1686005
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = '( CTRL + Left Click for Avalara Setup Page )'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        OnMouseDown = lblHintAvalaraMouseDown
        ExplicitLeft = 2
        ExplicitTop = 52
        ExplicitWidth = 336
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 403
      Width = 527
      Height = 160
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      BevelEdges = [beRight, beBottom]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      object lblNotaxTaxcode: TLabel
        Left = 66
        Top = 34
        Width = 44
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'No Tax :'
        Transparent = True
      end
      object lblTaxExcemptTaxCode: TLabel
        Left = 31
        Top = 66
        Width = 79
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Tax Excempt :'
        Transparent = True
      end
      object lblPickupTaxcode: TLabel
        Left = 65
        Top = 98
        Width = 45
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Pickup :'
        Transparent = True
      end
      object lblShippingTaxcode: TLabel
        Left = 55
        Top = 130
        Width = 55
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Shipping :'
        Transparent = True
      end
      object Label12: TLabel
        Left = 18
        Top = 8
        Width = 101
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Avalara Taxcodes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object edtNotaxTaxcode: TEdit
        Left = 119
        Top = 30
        Width = 200
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtNotaxTaxcodeChange
      end
      object edtTaxExcemptTaxCode: TEdit
        Left = 119
        Top = 62
        Width = 200
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnExit = edtTaxExcemptTaxcodeChange
      end
      object edtShippingTaxcode: TEdit
        Left = 119
        Top = 126
        Width = 200
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtPickupTaxcode: TEdit
        Left = 119
        Top = 94
        Width = 200
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 368
        Top = 30
        Width = 137
        Height = 119
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 22
        Margins.Bottom = 11
        Align = alRight
        BevelEdges = [beRight, beBottom]
        BevelOuter = bvNone
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        object lblTaxCodehint: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 135
          Height = 117
          Cursor = crHandPoint
          HelpContext = 1686005
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'Please Make Sure that One of These Tax Codes is Assigned to The ' +
            'Customer Card (Accounts.Default Taxcode)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          WordWrap = True
          OnMouseDown = lblHintAvalaraMouseDown
          ExplicitLeft = 2
          ExplicitTop = 52
          ExplicitWidth = 336
          ExplicitHeight = 24
        end
      end
      object btnNotaxTaxcode: TDNMSpeedButton
        Left = 325
        Top = 33
        Width = 33
        Height = 23
        Caption = ' . . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 5
        AutoDisableParentOnclick = True
        OnClick = chooseTaxCode
      end
      object btnTaxExcemptTaxCode: TDNMSpeedButton
        Left = 323
        Top = 62
        Width = 33
        Height = 23
        Caption = ' . . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 6
        AutoDisableParentOnclick = True
        OnClick = chooseTaxCode
      end
      object btnPickupTaxcode: TDNMSpeedButton
        Left = 322
        Top = 94
        Width = 33
        Height = 23
        Caption = ' . . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 7
        AutoDisableParentOnclick = True
        OnClick = chooseTaxCode
      end
      object btnShippingTaxcode: TDNMSpeedButton
        Left = 322
        Top = 126
        Width = 33
        Height = 23
        Caption = ' . . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 8
        AutoDisableParentOnclick = True
        OnClick = chooseTaxCode
      end
      object btnTaxCodesinAvalara: TDNMSpeedButton
        Left = 176
        Top = 1
        Width = 143
        Height = 23
        Caption = 'Taxcodes in Avalara'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 9
        AutoDisableParentOnclick = True
        OnClick = btnTaxCodesinAvalaraClick
      end
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 315
      Width = 527
      Height = 84
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      BevelEdges = [beRight, beBottom]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object lblPickupShipingMethod: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 156
        Height = 30
        HelpContext = 372085
        Alignment = taRightJustify
        Caption = '"PICK-UP" Ship Method  For Sale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblCommittedStatus: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 39
        Width = 152
        Height = 30
        HelpContext = 372085
        Alignment = taRightJustify
        Caption = '"COMMITED" Sales Status For invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edtPickupShipingMethod: TEdit
        Left = 166
        Top = 1
        Width = 200
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtPickupShipingMethodChange
      end
      object btnPickupShipingMethod: TDNMSpeedButton
        Left = 372
        Top = 8
        Width = 33
        Height = 23
        Caption = ' . . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnPickupShipingMethodClick
      end
      object edtCommittedStatus: TEdit
        Left = 166
        Top = 45
        Width = 200
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnExit = edtCommittedStatusChange
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 372
        Top = 45
        Width = 33
        Height = 23
        Caption = ' . . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
    end
  end
  object qryTaxLocations: TERPQuery
    SQL.Strings = (
      'Select "State" as jurisdictionTypeId, '
      '"NEW YORK" as jurisName,'
      '"36" as jurisCode,'
      '"US" as country, '
      '"SalesTax"  as nexusTypeId'
      'From Dual')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 99
    Top = 248
    object qryTaxLocationsjurisdictionTypeId: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'jurisdictionTypeId'
      Origin = 'jurisdictionTypeId'
      Size = 2
    end
    object qryTaxLocationsjurisName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 15
      FieldName = 'jurisName'
      Origin = 'jurisName'
      Size = 2
    end
    object qryTaxLocationsjurisCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'jurisCode'
      Origin = 'jurisCode'
      Size = 2
    end
    object qryTaxLocationscountry: TWideStringField
      DisplayLabel = 'Country'
      DisplayWidth = 10
      FieldName = 'country'
      Origin = 'country'
      Size = 2
    end
    object qryTaxLocationsnexusTypeId: TWideStringField
      DisplayLabel = 'Tax~Type'
      DisplayWidth = 21
      FieldName = 'nexusTypeId'
      Origin = 'nexusTypeId'
      Size = 2
    end
  end
  object dsTaxLocations: TDataSource
    DataSet = qryTaxLocations
    Left = 102
    Top = 215
  end
end
