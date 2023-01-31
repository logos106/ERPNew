inherited EmployeeTaxGUI: TEmployeeTaxGUI
  Left = 214
  Top = 112
  HelpContext = 127000
  Caption = 'Employee Tax'
  ClientHeight = 258
  ClientWidth = 797
  OldCreateOrder = True
  ExplicitLeft = 214
  ExplicitTop = 112
  ExplicitWidth = 813
  ExplicitHeight = 297
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 258
    Width = 797
    ExplicitTop = 453
    ExplicitWidth = 880
    HelpContext = 127039
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 797
    Height = 258
    HelpContext = 127015
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Category = 'AustPayroll'
    object DNMPanel3: TDNMPanel
      Left = 16
      Top = 16
      Width = 499
      Height = 224
      HelpContext = 127017
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label7: TLabel
        Left = 10
        Top = 24
        Width = 125
        Height = 15
        HelpContext = 127018
        Alignment = taRightJustify
        Caption = 'Tax File Number (TFN):'
        FocusControl = edTFN
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label99: TLabel
        Left = 74
        Top = 62
        Width = 61
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
      object Label3: TLabel
        Left = 69
        Top = 100
        Width = 66
        Height = 15
        HelpContext = 127020
        Alignment = taRightJustify
        Caption = 'Workcover:'
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
        Left = 73
        Top = 139
        Width = 62
        Height = 15
        HelpContext = 127021
        Alignment = taRightJustify
        Caption = 'HELP Debt:'
        Transparent = True
      end
      object Label5: TLabel
        Left = 35
        Top = 176
        Width = 100
        Height = 15
        HelpContext = 127022
        Alignment = taRightJustify
        Caption = 'SFSS Repayment:'
        Transparent = True
      end
      object Label65: TLabel
        Left = 294
        Top = 24
        Width = 24
        Height = 15
        HelpContext = 127023
        Alignment = taRightJustify
        Caption = 'ABN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edTFN: TDBEdit
        Left = 144
        Top = 21
        Width = 139
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
        Left = 144
        Top = 59
        Width = 330
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
      object Workcover: TwwDBLookupCombo
        Left = 144
        Top = 97
        Width = 330
        Height = 23
        HelpContext = 127026
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Company'#9'80'#9'Company'#9'F')
        DataField = 'WorkersCompInsurer'
        DataSource = DSEmployees
        LookupTable = qrySuppliers
        LookupField = 'ClientID'
        DropDownWidth = 250
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkHECS: TwwCheckBox
        Left = 144
        Top = 138
        Width = 14
        Height = 17
        HelpContext = 127027
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
        DataField = 'HECSIndicator'
        DataSource = DSEmployees
        ParentColor = False
        TabOrder = 3
        OnClick = chkHECSClick
      end
      object chkSFSS: TwwCheckBox
        Left = 144
        Top = 175
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
        DataField = 'StudentLoanIndicator'
        DataSource = DSEmployees
        ParentColor = False
        TabOrder = 4
        OnClick = chkSFSSClick
      end
      object ABN: TDBEdit
        Left = 327
        Top = 21
        Width = 145
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
        TabOrder = 5
      end
      object cboHECSTaxScales: TwwDBLookupCombo
        Left = 168
        Top = 135
        Width = 306
        Height = 23
        HelpContext = 127030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ScaleDescription'#9'40'#9'Scale Description'#9'F')
        DataField = 'HECSTaxScale'
        DataSource = DSEmployees
        LookupTable = qryHECSTaxScales
        LookupField = 'ScaleID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 6
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboStudentLoanTaxScales: TwwDBLookupCombo
        Left = 168
        Top = 173
        Width = 306
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
        DataField = 'StudentLoanTaxScale'
        DataSource = DSEmployees
        LookupTable = qryStudentLoanTaxScales
        LookupField = 'ScaleID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 7
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 523
      Top = 16
      Width = 257
      Height = 224
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
        Top = 17
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
        Left = 25
        Top = 170
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
        Left = 79
        Top = 36
        Width = 104
        Height = 104
        HelpContext = 127037
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        Caption = 'Options'
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
        Left = 78
        Top = 169
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
  inherited popSpelling: TPopupMenu
    Left = 16
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
  object qrySuppliers: TERPQuery
    SQL.Strings = (
      'Select ClientID, Company'
      'FROM tblClients'
      'WHERE Supplier='#39'T'#39
      'Order by Company;')
    Left = 843
    Top = 178
  end
  object dsEmpPaySettings: TDataSource
    Left = 140
    Top = 104
  end
  object qryTaxScale: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      
        'Where (((scaledescription not LIKE "%HELP%") and (scaledescripti' +
        'on not LIKE "%SFSS%")) or (scaledescription LIKE "%Use this code' +
        '%")) AND Active = '#39'T'#39' and REgionID = :RegionID;')
    BeforeOpen = qryTaxScaleBeforeOpen
    Left = 841
    Top = 300
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
  object qryHECSTaxScales: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      'Where scaledescription LIKE "%HELP%" AND Active = '#39'T'#39';')
    Left = 841
    Top = 332
  end
  object qryStudentLoanTaxScales: TERPQuery
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      'Where scaledescription LIKE "%SFSS%" AND Active = '#39'T'#39';')
    Left = 841
    Top = 372
  end
end
