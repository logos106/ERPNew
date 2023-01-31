inherited ScopeListForm: TScopeListForm
  Left = 55
  Top = 524
  Caption = 'Scoping List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14609623
  end
  inherited HeaderPanel: TPanel
    Color = 14609623
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Scoping List'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
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
        'Scope Definition'#9'35'#9'Scope Definition'
        'Name'#9'33'#9'Name'#9'F'
        'Date'#9'10'#9'Date'
        'Employee'#9'21'#9'Employee'
        'Reference'#9'30'#9'Reference'
        'Active'#9'1'#9'Active')
      TitleColor = 14609623
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT Parent.Typename as "Scope Definition", main.DAID, main.ty' +
        'pename as "Name", main.Date,'
      'main.Description AS '#39'Reference'#39','
      'main.Active'
      
        'FROM tblda as main inner join tblDA as Parent on main.ParentId =' +
        ' Parent.DAID'
      'WHERE main.ObjectClass = '#39'TdaMDCustBase'#39
      '#AND TypeName = '#39'Scoping'#39';')
    Left = 88
    Top = 0
    object qryMainScopeDefinition: TStringField
      DisplayWidth = 35
      FieldName = 'Scope Definition'
      Origin = 'Parent.`Scope Definition`'
      Size = 40
    end
    object qryMainName: TStringField
      DisplayWidth = 33
      FieldName = 'Name'
      Origin = 'tblda.Name'
      Size = 40
    end
    object qryMainDate: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
      Origin = 'tblda.Date'
    end
    object qryMainEmployee: TStringField
      DisplayWidth = 21
      FieldKind = fkCalculated
      FieldName = 'Employee'
      Size = 255
      Calculated = True
    end
    object qryMainReference: TStringField
      DisplayWidth = 30
      FieldName = 'Reference'
      Origin = 'tblda.Reference'
      Size = 255
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblda.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainDAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'DAID'
      Origin = 'tblda.DAID'
      Visible = False
    end
  end
  object qryEmployeeID: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName'
      'FROM tblemployees;')
    Left = 157
    Top = 35
  end
end
