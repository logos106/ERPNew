inherited ShipAddressGUI: TShipAddressGUI
  Left = 459
  Top = 123
  HelpContext = 496000
  Caption = 'Shipping Address'
  ClientHeight = 527
  ClientWidth = 659
  OldCreateOrder = True
  ExplicitLeft = 459
  ExplicitTop = 123
  ExplicitWidth = 675
  ExplicitHeight = 566
  DesignSize = (
    659
    527)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 66
    Top = 95
    Width = 95
    Height = 15
    HelpContext = 496002
    Caption = 'Select From List:'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 527
    Width = 659
    HelpContext = 496039
    ExplicitTop = 441
    ExplicitWidth = 659
  end
  object Label36: TLabel [2]
    Left = 608
    Top = 490
    Width = 43
    Height = 17
    HelpContext = 496003
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
    ExplicitTop = 453
  end
  inherited imgGridWatermark: TImage
    Left = 18
    Top = 243
    HelpContext = 496001
    ExplicitLeft = 18
    ExplicitTop = 243
  end
  object btnCancel: TDNMSpeedButton [7]
    Left = 361
    Top = 493
    Width = 87
    Height = 27
    Hint = 'Cancel and Close'
    HelpContext = 496011
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
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
    ExplicitTop = 456
  end
  object chkActive: TwwCheckBox [8]
    Left = 622
    Top = 506
    Width = 14
    Height = 15
    HelpContext = 496012
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbChecked
    Anchors = [akRight, akBottom]
    Caption = 'chkActive'
    Checked = True
    DataField = 'Active'
    DataSource = dscMain
    State = cbChecked
    TabOrder = 1
    OnClick = chkActiveClick
    ExplicitTop = 469
  end
  object DNMPanel1: TDNMPanel [9]
    Left = 40
    Top = 47
    Width = 511
    Height = 33
    HelpContext = 496005
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object lblCustomer: TLabel
      Left = 8
      Top = 4
      Width = 505
      Height = 24
      HelpContext = 496006
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblCustomer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object cboshiptoaddress: TwwDBLookupCombo [10]
    Left = 170
    Top = 92
    Width = 289
    Height = 23
    HelpContext = 496004
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'CompanyName'#9'40'#9'Name'#9'F'
      'ShipAddress'#9'50'#9'Address'#9'F')
    LookupTable = qryAddresses
    LookupField = 'ShipAddressID'
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboshiptoaddressCloseUp
    OnNotInList = cboshiptoaddressNotInList
  end
  object btnSave: TDNMSpeedButton [11]
    Left = 192
    Top = 494
    Width = 87
    Height = 27
    Hint = 'Save this Address against this client and Close'
    HelpContext = 496007
    Anchors = [akBottom]
    Caption = '&Ok'
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
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnSaveClick
    ExplicitTop = 457
  end
  object DNMPanel2: TDNMPanel [12]
    Left = 7
    Top = 124
    Width = 643
    Height = 358
    HelpContext = 496040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object lblMsg: TLabel
      Left = 1
      Top = 327
      Width = 641
      Height = 30
      HelpContext = 496021
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'This is '#39' + tblMainCompanyName.AsString +'#39#39#39's Physical Address w' +
        'hich cannot be modified.  Access has been changed to read-only.'
      Transparent = True
      Layout = tlCenter
      Visible = False
      WordWrap = True
      ExplicitTop = 292
      ExplicitWidth = 621
    end
    object DNMPanel3: TDNMPanel
      Left = 1
      Top = 1
      Width = 641
      Height = 326
      HelpContext = 496013
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitHeight = 258
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 641
        Height = 326
        HelpContext = 496014
        Align = alClient
        Shape = bsFrame
        ExplicitTop = -1
        ExplicitWidth = 643
        ExplicitHeight = 275
      end
      object Label2: TLabel
        Left = 31
        Top = 10
        Width = 62
        Height = 15
        HelpContext = 496015
        Alignment = taRightJustify
        Caption = 'Company : '
        Transparent = True
      end
      object Label3: TLabel
        Left = 29
        Top = 71
        Width = 64
        Height = 15
        HelpContext = 496016
        Alignment = taRightJustify
        Caption = 'Address1 : '
        Transparent = True
      end
      object Label4: TLabel
        Left = 26
        Top = 102
        Width = 67
        Height = 15
        HelpContext = 496017
        Alignment = taRightJustify
        Caption = 'Address 2 : '
        Transparent = True
      end
      object lblPostCode: TLabel
        Left = 168
        Top = 195
        Width = 66
        Height = 15
        HelpContext = 496018
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Postcode'
        Transparent = True
      end
      object lblSuburb: TLabel
        Left = 63
        Top = 164
        Width = 30
        Height = 15
        HelpContext = 496019
        Alignment = taRightJustify
        Caption = 'City : '
        Transparent = True
      end
      object lblState: TLabel
        Left = 54
        Top = 195
        Width = 39
        Height = 15
        HelpContext = 496020
        Alignment = taRightJustify
        Caption = 'State : '
        Transparent = True
      end
      object Label8: TLabel
        Left = 40
        Top = 226
        Width = 53
        Height = 15
        HelpContext = 496045
        Alignment = taRightJustify
        Caption = 'Country : '
        Transparent = True
      end
      object Label5: TLabel
        Left = 26
        Top = 133
        Width = 67
        Height = 15
        HelpContext = 496022
        Alignment = taRightJustify
        Caption = 'Address 3 : '
        Transparent = True
      end
      object Label10: TLabel
        Left = 409
        Top = 162
        Width = 59
        Height = 15
        HelpContext = 496031
        Alignment = taRightJustify
        Caption = 'Inco Place'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 369
        Top = 131
        Width = 99
        Height = 15
        HelpContext = 496032
        Alignment = taRightJustify
        Caption = 'Port of Discharge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 382
        Top = 69
        Width = 86
        Height = 15
        HelpContext = 496033
        Alignment = taRightJustify
        Caption = 'Port of Loading'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 375
        Top = 100
        Width = 93
        Height = 15
        HelpContext = 496034
        Alignment = taRightJustify
        Caption = 'Final Destination'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 384
        Top = 38
        Width = 84
        Height = 15
        HelpContext = 496041
        Alignment = taRightJustify
        Caption = 'Phone Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 53
        Top = 257
        Width = 40
        Height = 15
        HelpContext = 496046
        Alignment = taRightJustify
        Caption = 'Email : '
        Transparent = True
      end
      object Label13: TLabel
        Left = 40
        Top = 40
        Width = 53
        Height = 15
        HelpContext = 496047
        Alignment = taRightJustify
        Caption = 'Contact : '
        Transparent = True
      end
      object Label14: TLabel
        Left = 365
        Top = 195
        Width = 103
        Height = 15
        HelpContext = 496048
        Alignment = taRightJustify
        Caption = 'Address Validated'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label15: TLabel
        Left = 3
        Top = 288
        Width = 90
        Height = 15
        HelpContext = 496046
        Alignment = taRightJustify
        Caption = 'Location Code : '
        Transparent = True
      end
      object edtAddress: TwwDBEdit
        Left = 99
        Top = 67
        Width = 186
        Height = 23
        HelpContext = 496023
        DataField = 'ShipAddress'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtAddressChange
      end
      object edtAddress2: TwwDBEdit
        Left = 99
        Top = 98
        Width = 186
        Height = 23
        HelpContext = 496024
        DataField = 'ShipAddress1'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtAddress2Change
      end
      object State: TwwDBEdit
        Left = 99
        Top = 191
        Width = 68
        Height = 23
        HelpContext = 496025
        DataField = 'ShipState'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = StateChange
        OnExit = StateExit
      end
      object PostCode: TwwDBEdit
        Left = 243
        Top = 191
        Width = 101
        Height = 23
        HelpContext = 496026
        DataField = 'ShipPostcode'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = PostCodeChange
        OnExit = PostCodeExit
      end
      object Suburb: TwwDBLookupCombo
        Left = 99
        Top = 160
        Width = 186
        Height = 23
        HelpContext = 496027
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'City_sub'#9'20'#9'Suburb'#9'T'
          'State'#9'20'#9'State'#9'T'
          'Postcode'#9'4'#9'Postcode'#9'T'
          'Code'#9'10'#9'Code'#9'T')
        DataField = 'ShipCity'
        DataSource = dscMain
        LookupTable = qrySuburb
        LookupField = 'City_sub'
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = SuburbChange
        OnCloseUp = SuburbCloseUp
        OnEnter = SuburbEnter
        OnExit = SuburbExit
      end
      object edtCountry: TwwDBEdit
        Left = 99
        Top = 222
        Width = 285
        Height = 23
        HelpContext = 496028
        DataField = 'ShipCountry'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtCountryChange
        OnExit = edtCountryExit
      end
      object edtCompany: TwwDBEdit
        Left = 99
        Top = 6
        Width = 516
        Height = 23
        HelpContext = 496029
        DataField = 'CompanyName'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtCompanyChange
        OnExit = edtCompanyExit
      end
      object edtAddress3: TwwDBEdit
        Left = 99
        Top = 129
        Width = 186
        Height = 23
        HelpContext = 496030
        DataField = 'ShipAddress2'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtAddress3Change
      end
      object cboPortOfLoading: TwwDBLookupCombo
        Left = 478
        Top = 68
        Width = 138
        Height = 23
        HelpContext = 496035
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'City_sub'#9'20'#9'Suburb'#9'T'
          'State'#9'20'#9'State'#9'T'
          'Postcode'#9'10'#9'Postcode'#9'T'
          'Code'#9'10'#9'Code'#9'T')
        DataField = 'PortOfLanding'
        DataSource = dscMain
        LookupTable = qrySuburb
        LookupField = 'City_sub'
        ParentFont = False
        TabOrder = 11
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboPortOfLoadingEnter
      end
      object cboPortOfDischarge: TwwDBLookupCombo
        Left = 478
        Top = 130
        Width = 138
        Height = 23
        HelpContext = 496036
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'City_sub'#9'20'#9'Suburb'#9'T'
          'State'#9'20'#9'State'#9'T'
          'Postcode'#9'10'#9'Postcode'#9'T'
          'Code'#9'10'#9'Code'#9'T')
        DataField = 'PortOfDischarge'
        DataSource = dscMain
        LookupTable = qrySuburb
        LookupField = 'City_sub'
        ParentFont = False
        TabOrder = 13
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboPortOfDischargeEnter
      end
      object cboFinalDestination: TwwDBLookupCombo
        Left = 478
        Top = 99
        Width = 138
        Height = 23
        HelpContext = 496037
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'City_sub'#9'20'#9'Suburb'#9'T'
          'State'#9'20'#9'State'#9'T'
          'Postcode'#9'10'#9'Postcode'#9'T'
          'Code'#9'10'#9'Code'#9'T')
        DataField = 'FinalDestination'
        DataSource = dscMain
        LookupTable = qrySuburb
        LookupField = 'City_sub'
        ParentFont = False
        TabOrder = 12
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboFinalDestinationEnter
      end
      object cboIncoPlace: TwwDBLookupCombo
        Left = 478
        Top = 160
        Width = 138
        Height = 23
        HelpContext = 496038
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'City_sub'#9'20'#9'Suburb'#9'T'
          'State'#9'20'#9'State'#9'T'
          'Postcode'#9'10'#9'Postcode'#9'T'
          'Code'#9'10'#9'Code'#9'T')
        DataField = 'IncoPlace'
        DataSource = dscMain
        LookupTable = qrySuburb
        LookupField = 'City_sub'
        ParentFont = False
        TabOrder = 14
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboIncoPlaceEnter
      end
      object Phone: TwwDBEdit
        Left = 478
        Top = 34
        Width = 137
        Height = 23
        HelpContext = 496042
        DataField = 'Phone'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = PhoneChange
      end
      object edtEmail: TwwDBEdit
        Left = 99
        Top = 253
        Width = 516
        Height = 23
        HelpContext = 496049
        DataField = 'email'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
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
      object edtContactName: TwwDBEdit
        Left = 99
        Top = 36
        Width = 186
        Height = 23
        HelpContext = 496043
        DataField = 'ContactName'
        DataSource = dscMain
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
        OnChange = edtContactNameChange
      end
      object chkAddressValidated: TwwCheckBox
        Left = 478
        Top = 195
        Width = 14
        Height = 15
        HelpContext = 496050
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbChecked
        Caption = 'chkAddressValidated'
        Checked = True
        DataField = 'AddressValidated'
        DataSource = dscMain
        Enabled = False
        State = cbChecked
        TabOrder = 15
        ReadOnly = True
      end
      object btnValidateAddress: TDNMSpeedButton
        Left = 529
        Top = 189
        Width = 87
        Height = 27
        Hint = 'Save this Address against this client and Close'
        HelpContext = 496044
        Caption = 'Validate'
        Default = True
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 16
        AutoDisableParentOnclick = True
        OnClick = btnValidateAddressClick
      end
      object wwDBEdit1: TwwDBEdit
        Left = 99
        Top = 284
        Width = 142
        Height = 23
        HelpContext = 496049
        DataField = 'LocationCode'
        DataSource = dscMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
  end
  object pnlTitle: TDNMPanel [13]
    Left = 160
    Top = 4
    Width = 278
    Height = 36
    HelpContext = 496008
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 274
      Height = 32
      HelpContext = 496009
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
        Width = 274
        Height = 32
        HelpContext = 496010
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Shipping Address'
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
  inherited dlgReportSelect: TSelectionDialog
    Left = 6
    Top = 93
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 38
    Top = 94
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 532
    Top = 9
  end
  inherited DataState: TDataState
    Top = 55
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 596
    Top = 10
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005C00780010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dscMain: TDataSource
    DataSet = tblMain
    Left = 476
    Top = 444
  end
  object qrySuburb: TERPQuery
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country, Code'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    BeforeOpen = qrySuburbBeforeOpen
    Options.LongStrings = False
    Left = 34
    Top = 443
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryMaindelete: TERPQuery
    SQL.Strings = (
      
        'SELECT tblClients.Company, ShipAddressId, CompanyName, ShipAddre' +
        'ss,'
      'ShipAddress1, ShipCity, ShipPostCode, ShipState, ShipCountry,'
      'tblShippingAddress.EditedFlag, Customer_ID'
      'FROM tblShippingAddress LEFT JOIN tblClients'
      'ON Customer_ID = ClientID'
      'WHERE ShipAddressID = :xShipAddressID')
    Left = 144
    Top = 441
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xShipAddressID'
      end>
  end
  object qryAddresses: TERPQuery
    SQL.Strings = (
      'SELECT ShipAddressID, CompanyName, ShipAddress'
      'FROM tblShippingAddress'
      'WHERE Active='#39'T'#39
      'Group By CompanyName'
      'ORDER BY CompanyName')
    Left = 92
    Top = 444
  end
  object tblMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblShippingAddress'
      'WHERE ShipAddressID=:xID')
    AfterOpen = tblMainAfterOpen
    AfterInsert = tblMainAfterInsert
    AfterPost = tblMainAfterPost
    Left = 522
    Top = 444
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object tblMainGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblshippingaddress.GlobalRef'
      Size = 255
    end
    object tblMainShipAddressID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ShipAddressID'
      Origin = 'tblshippingaddress.ShipAddressID'
    end
    object tblMainCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Origin = 'tblshippingaddress.CompanyName'
      Size = 255
    end
    object tblMainCustomer_ID: TIntegerField
      FieldName = 'Customer_ID'
      Origin = 'tblshippingaddress.Customer_ID'
    end
    object tblMainShipAddress: TWideStringField
      FieldName = 'ShipAddress'
      Origin = 'tblshippingaddress.ShipAddress'
      Size = 255
    end
    object tblMainShipAddress1: TWideStringField
      FieldName = 'ShipAddress1'
      Origin = 'tblshippingaddress.ShipAddress1'
      Size = 255
    end
    object tblMainShipCity: TWideStringField
      FieldName = 'ShipCity'
      Origin = 'tblshippingaddress.ShipCity'
      Size = 255
    end
    object tblMainShipPostCode: TWideStringField
      FieldName = 'ShipPostCode'
      Origin = 'tblshippingaddress.ShipPostCode'
      Size = 255
    end
    object tblMainShipState: TWideStringField
      FieldName = 'ShipState'
      Origin = 'tblshippingaddress.ShipState'
      Size = 255
    end
    object tblMainShipCountry: TWideStringField
      FieldName = 'ShipCountry'
      Origin = 'tblshippingaddress.ShipCountry'
      Size = 255
    end
    object tblMainEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblshippingaddress.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblshippingaddress.msTimeStamp'
    end
    object tblMainShipAddress2: TWideStringField
      FieldName = 'ShipAddress2'
      Origin = 'tblshippingaddress.ShipAddress2'
      Size = 255
    end
    object tblMainActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblshippingaddress.Active'
      FixedChar = True
      Size = 1
    end
    object tblMainPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Origin = 'tblshippingaddress.PortOfLanding'
      Size = 100
    end
    object tblMainPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Origin = 'tblshippingaddress.PortOfDischarge'
      Size = 100
    end
    object tblMainFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Origin = 'tblshippingaddress.FinalDestination'
      Size = 100
    end
    object tblMainIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Origin = 'tblshippingaddress.IncoPlace'
      Size = 100
    end
    object tblMainPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblshippingaddress.Phone'
    end
    object tblMainemail: TWideStringField
      FieldName = 'email'
      Origin = 'tblshippingaddress.email'
      Size = 255
    end
    object tblMainContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblshippingaddress.ContactName'
      Size = 255
    end
    object tblMainmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblshippingaddress.msUpdateSiteCode'
      Size = 3
    end
    object tblMainCustomerPhysicalAddress: TWideStringField
      FieldName = 'CustomerPhysicalAddress'
      Origin = 'tblshippingaddress.CustomerPhysicalAddress'
      FixedChar = True
      Size = 1
    end
    object tblMainAddressValidated: TWideStringField
      FieldName = 'AddressValidated'
      Origin = 'tblshippingaddress.AddressValidated'
      FixedChar = True
      Size = 1
    end
    object tblMainLocationCode: TWideStringField
      FieldName = 'LocationCode'
      Size = 50
    end
  end
end
