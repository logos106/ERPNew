inherited ScopingDefinitionGUI: TScopingDefinitionGUI
  Left = 59
  Top = 172
  Caption = 'Scoping Definition List'
  ClientHeight = 563
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Top = 470
  end
  inherited FooterPanel: TPanel
    Top = 483
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
      Caption = 'Scope Definition List'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
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
    Height = 341
    inherited grdMain: TwwDBGrid
      Height = 341
      ControlType.Strings = (
        'Active;CheckBox;T;f')
      Selected.Strings = (
        'GlobalRef'#9'40'#9'Global Ref'
        'TypeName'#9'39'#9'Name'#9'F'
        'Date'#9'10'#9'Date'
        'Description'#9'40'#9'Description'
        'Active'#9'1'#9'Active')
      TitleColor = 14609623
      FooterColor = 14609623
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      ' SELECT * FROM tblda'
      ' WHERE ObjectClass = '#39'TdaMDCustPropDefList'#39' ')
    object qryMainGlobalRef: TStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblda.GlobalRef'
      Size = 255
    end
    object qryMainTypeName: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 39
      FieldName = 'TypeName'
      Origin = 'tblda.TypeName'
      Size = 40
    end
    object qryMainDate: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
      Origin = 'tblda.Date'
    end
    object qryMainDescription: TStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblda.Description'
      Size = 255
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblda.ACTIVE'
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
    object qryMainObjectClass: TStringField
      DisplayWidth = 40
      FieldName = 'ObjectClass'
      Origin = 'tblda.ObjectClass'
      Visible = False
      Size = 40
    end
    object qryMainXML: TMemoField
      DisplayWidth = 10
      FieldName = 'XML'
      Origin = 'tblda.XML'
      Visible = False
      BlobType = ftMemo
    end
    object qryMainParentID: TIntegerField
      DisplayWidth = 15
      FieldName = 'ParentID'
      Origin = 'tblda.ParentID'
      Visible = False
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblda.msTimeStamp'
      Visible = False
    end
  end
end
