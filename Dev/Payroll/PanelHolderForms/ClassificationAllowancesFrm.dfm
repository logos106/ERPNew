inherited frmClassificationAllowances: TfrmClassificationAllowances
  Left = 345
  Top = 172
  HelpContext = 567000
  Caption = 'frmClassificationAllowances'
  ClientHeight = 513
  ClientWidth = 682
  OldCreateOrder = True
  ExplicitLeft = 345
  ExplicitTop = 172
  ExplicitWidth = 698
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 513
    Width = 682
    ExplicitTop = 513
    ExplicitWidth = 682
    HelpContext = 567007
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 48
    Top = 40
    Width = 610
    Height = 227
    HelpContext = 567001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object grdAllowances: TwwDBGrid
      Left = 1
      Top = 1
      Width = 608
      Height = 225
      HelpContext = 567002
      ControlType.Strings = (
        'Based On;CustomEdit;BasedOn;T'
        'Allowance;CustomEdit;Allowance;T'
        'lookupAllowance;CustomEdit;cboAllowance;F'
        'lookupBasedOn;CustomEdit;cboBasedOn;F'
        'CalcBy;CustomEdit;cboAllowCalcBy;F'
        'Amount;CustomEdit;edAmount;F')
      Selected.Strings = (
        'lookupAllowance'#9'28'#9'Allowance'#9'F'
        'Amount'#9'15'#9'Amount'#9'F'
        'CalcBy'#9'6'#9'$/%'#9'F'
        'lookupBasedOn'#9'28'#9'Based On'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSAllowances2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      OnEnter = grdAllowancesEnter
      object grdAllowncesIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 24
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = grdAllowncesIButtonClick
        HelpContext = 567008
      end
    end
    object cboAllowance: TwwDBLookupCombo
      Left = 63
      Top = 45
      Width = 100
      Height = 23
      HelpContext = 567003
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'150'#9'Description'#9#9)
      DataField = 'lookupAllowance'
      DataSource = DSAllowances2
      LookupTable = qryAllowances
      LookupField = 'AllowanceID'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAllowCalcBy: TwwDBComboBox
      Left = 274
      Top = 45
      Width = 33
      Height = 23
      HelpContext = 567004
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'CalcBy'
      DataSource = DSAllowances2
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        '$'#9'$'
        '%'#9'%')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object cboBasedOn: TwwDBLookupCombo
      Left = 326
      Top = 44
      Width = 66
      Height = 23
      HelpContext = 567005
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'BasedOn'#9'25'#9'BasedOn'#9#9)
      DataField = 'BasedOnID'
      DataSource = DSAllowances2
      LookupTable = qryBasedOn
      LookupField = 'BasedOn'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object edAmount: TwwDBEdit
      Left = 160
      Top = 104
      Width = 57
      Height = 23
      HelpContext = 567006
      DataField = 'Amount'
      DataSource = DSAllowances2
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
    end
  end
  object DSAllowances2: TDataSource
    Left = 578
    Top = 6
  end
  object qryAllowances: TERPQuery
    SQL.Strings = (
      
        'Select AllowanceID, Description, SuperInc, TaxExempt, PayrollTax' +
        'Exempt, '
      'WorkcoverExempt, DisplayIn, Amount, CalcBy, BasedOnID, Active'
      'FROM tblAllowances'
      'WHERE Active='#39'T'#39)
    Left = 487
    Top = 7
    object qryAllowancesDescription: TWideStringField
      DisplayWidth = 150
      FieldName = 'Description'
      Size = 150
    end
    object qryAllowancesAllowanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AllowanceID'
      ReadOnly = True
      Visible = False
    end
    object qryAllowancesSuperInc: TWideStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesPayrollTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'PayrollTaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesWorkcoverExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'WorkcoverExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesDisplayIn: TWideStringField
      DisplayWidth = 31
      FieldName = 'DisplayIn'
      Visible = False
      FixedChar = True
      Size = 31
    end
    object qryAllowancesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
    end
    object qryAllowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryAllowancesBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryAllowancesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 614
    Top = 7
  end
end
