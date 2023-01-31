inherited frmClassificationDeductions: TfrmClassificationDeductions
  Left = 228
  Top = 195
  HelpContext = 568000
  Caption = 'frmClassificationDeductions'
  ClientHeight = 513
  ClientWidth = 879
  OldCreateOrder = True
  ExplicitLeft = 228
  ExplicitTop = 195
  ExplicitWidth = 895
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 513
    Width = 879
    ExplicitTop = 513
    ExplicitWidth = 879
    HelpContext = 568007
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 96
    Top = 96
    Width = 610
    Height = 227
    HelpContext = 568001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object grdDeductions: TwwDBGrid
      Left = 1
      Top = 1
      Width = 608
      Height = 225
      HelpContext = 568002
      ControlType.Strings = (
        'DeductionLookup;CustomEdit;cboDeduction;F'
        'BasedOnLookup;CustomEdit;cboBasedOnDeduct;F'
        'CalcBy;CustomEdit;cboDeductCalcBy;F'
        'Amount;CustomEdit;edAmount;F')
      Selected.Strings = (
        'DeductionLookup'#9'20'#9'Deduction'#9'F'
        'Amount'#9'11'#9'Amount'#9'F'
        'CalcBy'#9'4'#9'$/%'#9'F'
        'BasedOnLookup'#9'20'#9'Based On'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsClassDeductions
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
      object grdDeductionsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 24
        Height = 22
        AllowAllUp = True
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
        NumGlyphs = 2
        OnClick = grdDeductionsIButtonClick
        HelpContext = 568008
      end
    end
    object cboDeduction: TwwDBLookupCombo
      Left = 144
      Top = 84
      Width = 107
      Height = 23
      HelpContext = 568003
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'25'#9'Description'#9'F')
      DataField = 'DeductionLookup'
      DataSource = dsClassDeductions
      LookupTable = qryDeductions
      LookupField = 'DeductionID'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboDeductCalcBy: TwwDBComboBox
      Left = 311
      Top = 82
      Width = 30
      Height = 23
      HelpContext = 568004
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'CalcBy'
      DataSource = dsClassDeductions
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
    object cboBasedOnDeduct: TwwDBLookupCombo
      Left = 360
      Top = 73
      Width = 89
      Height = 23
      HelpContext = 568005
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'BasedOn'#9'15'#9'BasedOn'#9'F')
      DataField = 'BasedOnLookup'
      DataSource = dsClassDeductions
      LookupTable = qryBasedOn
      LookupField = 'BasedOnID'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object edAmount: TwwDBEdit
      Left = 112
      Top = 136
      Width = 81
      Height = 23
      HelpContext = 568006
      DataField = 'Amount'
      DataSource = dsClassDeductions
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
  object dsClassDeductions: TDataSource
    Left = 745
    Top = 101
  end
  object qryDeductions: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tbldeductions WHERE Active = '#39'T'#39)
    Left = 744
    Top = 159
    object qryDeductionsDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 150
    end
    object qryDeductionsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryDeductionsDeductionID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DeductionID'
      ReadOnly = True
      Visible = False
    end
    object qryDeductionsTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsUnionFees: TWideStringField
      DisplayWidth = 1
      FieldName = 'UnionFees'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsDisplayIn: TWideStringField
      FieldName = 'DisplayIn'
      FixedChar = True
      Size = 31
    end
    object qryDeductionsAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryDeductionsBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryDeductionsCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 750
    Top = 215
  end
end
