inherited fmCostCentreList: TfmCostCentreList
  Left = 88
  Top = 366
  Caption = 'Cost Centre List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Cost Centres'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'Both')
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'Global Ref'
        'CostCentreName'#9'40'#9'Cost Centre Name'
        'CostCentreDescription'#9'75'#9'Cost Centre Description'#9'F'
        'Active'#9'1'#9'Active')
      TitleColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT * FROM tblCostCentre'
      'WHERE (Active = "T" AND :Active = "Active")'
      'OR (Active <> "T" AND :Active = "Inactive")'
      'OR (:Active = "Both") '
      'ORDER BY CostCEntreName')
    ParamData = <
      item
        DataType = ftString
        Name = 'Active'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Active'
      end
      item
        DataType = ftString
        Name = 'Active'
      end>
    object qryMainGlobalRef: TStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Origin = 'tblCostCentre.GlobalRef'
      Size = 255
    end
    object qryMainCostCentreName: TStringField
      DisplayLabel = 'Cost Centre Name'
      DisplayWidth = 40
      FieldName = 'CostCentreName'
      Origin = 'tblCostCentre.CostCentreName'
      Size = 255
    end
    object qryMainCostCentreDescription: TStringField
      DisplayLabel = 'Cost Centre Description'
      DisplayWidth = 75
      FieldName = 'CostCentreDescription'
      Origin = 'tblCostCentre.CostCentreDescription'
      Size = 255
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblCostCentre.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainCostCentreId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Cost Centre ID'
      DisplayWidth = 15
      FieldName = 'CostCentreId'
      Origin = 'tblCostCentre.CostCentreId'
      Visible = False
    end
  end
end
