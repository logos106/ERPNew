inherited EmployeeTaxUSGUI: TEmployeeTaxUSGUI
  Left = 214
  Top = 112
  HelpContext = 127000
  Caption = 'Employee Tax US'
  ClientHeight = 453
  ClientWidth = 880
  OldCreateOrder = True
  ExplicitWidth = 896
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 453
    Width = 880
    HelpContext = 127039
    ExplicitTop = 453
    ExplicitWidth = 880
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 32
    Top = 8
    Width = 799
    Height = 422
    HelpContext = 127015
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Category = 'AustPayroll'
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 785
      Height = 408
      HelpContext = 127016
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 783
    end
    object DNMPanel3: TDNMPanel
      Left = 13
      Top = 13
      Width = 772
      Height = 272
      HelpContext = 127017
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label7: TLabel
        Left = 19
        Top = 8
        Width = 88
        Height = 30
        HelpContext = 127018
        Alignment = taRightJustify
        Caption = 'Social Security Number (SSN):'
        FocusControl = edTFN
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblUSFedTaxScaleID: TLabel
        Left = 5
        Top = 66
        Width = 105
        Height = 14
        HelpContext = 127019
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tax Scale:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label65: TLabel
        Left = 272
        Top = 16
        Width = 18
        Height = 15
        HelpContext = 127023
        Alignment = taRightJustify
        Caption = 'EIN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label2: TLabel
        Left = 2
        Top = 146
        Width = 103
        Height = 14
        HelpContext = 127040
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Social Sec Scale:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label3: TLabel
        Left = 2
        Top = 210
        Width = 103
        Height = 14
        HelpContext = 127041
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Medicare Scale:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 367
        Top = 46
        Width = 66
        Height = 15
        HelpContext = 127042
        Alignment = taRightJustify
        Caption = 'Allowances'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblUSStateTaxScaleID: TLabel
        Left = 6
        Top = 110
        Width = 77
        Height = 14
        HelpContext = 127046
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'State Tax:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label5: TLabel
        Left = 364
        Top = 89
        Width = 66
        Height = 15
        HelpContext = 127047
        Alignment = taRightJustify
        Caption = 'Allowances'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label6: TLabel
        Left = 510
        Top = 46
        Width = 49
        Height = 15
        HelpContext = 127048
        Caption = 'Expense'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label8: TLabel
        Left = 639
        Top = 46
        Width = 43
        Height = 15
        HelpContext = 127049
        Caption = 'Liability'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label9: TLabel
        Left = 444
        Top = 146
        Width = 58
        Height = 15
        HelpContext = 127050
        Alignment = taRightJustify
        Caption = 'Employee:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label10: TLabel
        Left = 446
        Top = 175
        Width = 56
        Height = 15
        HelpContext = 127051
        Alignment = taRightJustify
        Caption = 'Company:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label11: TLabel
        Left = 444
        Top = 210
        Width = 58
        Height = 15
        HelpContext = 127052
        Alignment = taRightJustify
        Caption = 'Employee:'
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
        Left = 446
        Top = 239
        Width = 56
        Height = 15
        HelpContext = 127053
        Alignment = taRightJustify
        Caption = 'Company:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label13: TLabel
        Left = 444
        Top = 66
        Width = 58
        Height = 15
        HelpContext = 127054
        Alignment = taRightJustify
        Caption = 'Employee:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label14: TLabel
        Left = 444
        Top = 109
        Width = 58
        Height = 15
        HelpContext = 127055
        Alignment = taRightJustify
        Caption = 'Employee:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label15: TLabel
        Left = 510
        Top = 9
        Width = 251
        Height = 31
        HelpContext = 127069
        Caption = 
          'Double click on Expense / Liability account name to open Payroll' +
          ' Preferences'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edTFN: TDBEdit
        Left = 116
        Top = 12
        Width = 133
        Height = 23
        HelpContext = 127024
        DataField = 'TFN'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object TaxScale: TwwDBLookupCombo
        Left = 116
        Top = 63
        Width = 269
        Height = 23
        HelpContext = 127025
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ScaleDescription'#9'40'#9'Scale Description'#9'F')
        DataField = 'TaxScaleID'
        DataSource = DSEmployees
        LookupTable = qryTaxScale
        LookupField = 'ScaleID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkEnableStateTax: TwwCheckBox
        Left = 92
        Top = 109
        Width = 14
        Height = 17
        HelpContext = 127028
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
        Color = clBtnFace
        DataField = 'USEnableStateTax'
        DataSource = DSEmployees
        ParentColor = False
        TabOrder = 2
        OnClick = chkEnableStateTaxClick
      end
      object ABN: TDBEdit
        Left = 299
        Top = 12
        Width = 134
        Height = 23
        HelpContext = 127029
        DataField = 'ABN'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object StateTaxScale: TwwDBLookupCombo
        Left = 116
        Top = 106
        Width = 269
        Height = 23
        HelpContext = 127031
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ScaleDescription'#9'40'#9'Scale Description'#9'F')
        DataField = 'USStateTaxScaleID'
        DataSource = DSEmployees
        LookupTable = qryStateTaxScale
        LookupField = 'ScaleID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object SocialSecurityTaxScale: TwwDBLookupCombo
        Left = 114
        Top = 143
        Width = 319
        Height = 23
        HelpContext = 127043
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ScaleDescription'#9'40'#9'Scale Description'#9'F')
        DataField = 'USSocialSecurityTaxScaleID'
        DataSource = DSEmployees
        LookupTable = qrySocialSecurityTax
        LookupField = 'ScaleID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object MedicareTaxScale: TwwDBLookupCombo
        Left = 114
        Top = 207
        Width = 319
        Height = 23
        HelpContext = 127044
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ScaleDescription'#9'40'#9'Scale Description'#9'F')
        DataField = 'USMedicareTaxScaleID'
        DataSource = DSEmployees
        LookupTable = qryMedicareTaxScale
        LookupField = 'ScaleID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 6
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object edtAllowanceQty: TwwDBEdit
        Left = 391
        Top = 63
        Width = 42
        Height = 23
        HelpContext = 127045
        DataField = 'USPayAllowanceQty'
        DataSource = DSEmployees
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
      end
      object edtAllowanceStateQty: TwwDBEdit
        Left = 391
        Top = 106
        Width = 42
        Height = 23
        HelpContext = 127056
        DataField = 'USPayAllowanceStateQty'
        DataSource = DSEmployees
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
      end
      object edtTaxExpense: TEdit
        Left = 510
        Top = 63
        Width = 123
        Height = 23
        HelpContext = 127057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        OnDblClick = PayAccountDblClick
      end
      object edtTaxLiability: TEdit
        Left = 639
        Top = 63
        Width = 122
        Height = 23
        HelpContext = 127058
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
        OnDblClick = PayAccountDblClick
      end
      object edtStateExpense: TEdit
        Left = 510
        Top = 106
        Width = 123
        Height = 23
        HelpContext = 127059
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
        OnDblClick = PayAccountDblClick
      end
      object edtStateLiability: TEdit
        Left = 639
        Top = 106
        Width = 122
        Height = 23
        HelpContext = 127060
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
        OnDblClick = PayAccountDblClick
      end
      object edtSocialExpense: TEdit
        Left = 510
        Top = 143
        Width = 123
        Height = 23
        HelpContext = 127061
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
        OnDblClick = PayAccountDblClick
      end
      object edtSocialLiability: TEdit
        Left = 639
        Top = 143
        Width = 122
        Height = 23
        HelpContext = 127062
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 14
        OnDblClick = PayAccountDblClick
      end
      object edtSocialCoExpense: TEdit
        Left = 510
        Top = 172
        Width = 123
        Height = 23
        HelpContext = 127063
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 15
        OnDblClick = PayAccountDblClick
      end
      object edtSocialCoLiability: TEdit
        Left = 639
        Top = 172
        Width = 122
        Height = 23
        HelpContext = 127064
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 16
        OnDblClick = PayAccountDblClick
      end
      object edtMedExpense: TEdit
        Left = 510
        Top = 207
        Width = 123
        Height = 23
        HelpContext = 127065
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 17
        OnDblClick = PayAccountDblClick
      end
      object edtMedLiability: TEdit
        Left = 639
        Top = 207
        Width = 122
        Height = 23
        HelpContext = 127066
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 18
        OnDblClick = PayAccountDblClick
      end
      object edtMedCoExpense: TEdit
        Left = 510
        Top = 236
        Width = 123
        Height = 23
        HelpContext = 127067
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 19
        OnDblClick = PayAccountDblClick
      end
      object edtMedCoLiability: TEdit
        Left = 639
        Top = 236
        Width = 122
        Height = 23
        HelpContext = 127068
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 20
        OnDblClick = PayAccountDblClick
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 13
      Top = 292
      Width = 772
      Height = 106
      HelpContext = 127034
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 12
        Top = 10
        Width = 53
        Height = 15
        HelpContext = 127035
        Caption = 'Extra Tax'
        FocusControl = ExtraTax
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label20: TLabel
        Left = 481
        Top = 56
        Width = 31
        Height = 15
        HelpContext = 127036
        Caption = 'Value'
        FocusControl = ExtraTax
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ExtraTaxOptions: TwwRadioGroup
        Left = 12
        Top = 39
        Width = 421
        Height = 49
        HelpContext = 127037
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        Caption = 'Options'
        Columns = 3
        DataField = 'ExtraTaxOptions'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Dollar'
          'Percentage'
          'Fixed')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          '$'
          '%'
          'Fixed')
      end
      object ExtraTax: TDBEdit
        Left = 534
        Top = 55
        Width = 117
        Height = 23
        HelpContext = 127038
        DataField = 'ExtraTax'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited tmrdelay: TTimer
    Left = 16
    Top = 96
  end
  inherited popSpelling: TPopupMenu
    Left = 176
    Top = 88
  end
  object DSEmployees: TDataSource
    Left = 836
    Top = 34
  end
  object qryTaxScales: TERPQuery
    SQL.Strings = (
      'Select ScaleID,Threshold,A,B'
      'FROM tblTax'
      'WHERE ScaleID=:TaxScaleID')
    Left = 842
    Top = 139
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TaxScaleID'
      end>
  end
  object dsEmpPaySettings: TDataSource
    Left = 840
    Top = 104
  end
  object qryTaxScale: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      
        'Where (((scaledescription not LIKE "State Tax%") and (scaledescr' +
        'iption not LIKE "Medicare%")) and (scaledescription  not LIKE "S' +
        'ocial Security%")) AND Active = '#39'T'#39' and REgionID = :RegionID;')
    BeforeOpen = qryTaxScaleBeforeOpen
    Left = 833
    Top = 196
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
  object qryStateTaxScale: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      
        'Where (scaledescription LIKE "State Tax%") AND Active = '#39'T'#39' and ' +
        'REgionID = :RegionID;')
    BeforeOpen = qryStateTaxScaleBeforeOpen
    Left = 841
    Top = 332
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
  object qrySocialSecurityTax: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      
        'Where (scaledescription LIKE "Social Security%") AND Active = '#39'T' +
        #39' and REgionID = :RegionID;')
    BeforeOpen = qrySocialSecurityTaxBeforeOpen
    Left = 841
    Top = 252
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
  object qryMedicareTaxScale: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      
        'Where (scaledescription LIKE "Medicare%") AND Active = '#39'T'#39' and R' +
        'EgionID = :RegionID;')
    BeforeOpen = qryMedicareTaxScaleBeforeOpen
    Left = 841
    Top = 292
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
end
