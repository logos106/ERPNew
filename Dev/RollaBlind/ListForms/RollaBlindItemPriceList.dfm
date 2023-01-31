inherited RollaBlindItemPriceListGUI: TRollaBlindItemPriceListGUI
  Left = 45
  Top = 127
  Caption = 'Item Price List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = clSilver
  end
  inherited HeaderPanel: TPanel
    Color = clSilver
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited Panel2: TPanel
      object lblGroupHeading: TLabel [0]
        Left = 600
        Top = 10
        Width = 233
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      inherited grpFilters: TRadioGroup
        Visible = False
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
      Selected.Strings = (
        'ItemNumber'#9'255'#9'Item Number'#9#9
        'ColourCode'#9'255'#9'Colour Code'#9#9
        'Description'#9'255'#9'Description - Cut-out sheet program'#9#9
        'Description2'#9'200'#9'Description - Price List'#9#9
        'Flag'#9'1'#9'Flag'#9#9
        'Length'#9'255'#9'Length'#9#9
        'Unit'#9'255'#9'Unit'#9#9
        'List'#9'10'#9'List'#9#9
        'Kanga'#9'10'#9'Kanga'#9#9
        'Group'#9'10'#9'Group'#9#9
        'Export'#9'10'#9'Export'#9#9
        'Branch'#9'10'#9'Branch'#9#9
        'Cost'#9'10'#9'Cost'#9#9)
      TitleColor = clSilver
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM tblrollaitemprices')
    object qryMainItemPriceID: TIntegerField
      FieldName = 'ItemPriceID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainItemNumber: TStringField
      DisplayLabel = 'Item Number'
      DisplayWidth = 255
      FieldName = 'ItemNumber'
      Size = 255
    end
    object qryMainColourCode: TStringField
      DisplayLabel = 'Colour Code'
      DisplayWidth = 255
      FieldName = 'ColourCode'
      Size = 255
    end
    object qryMainHeading: TStringField
      FieldName = 'Heading'
      Visible = False
      Size = 255
    end
    object qryMainDescription: TStringField
      DisplayLabel = 'Description - Cut-out sheet program'
      DisplayWidth = 255
      FieldName = 'Description'
      Size = 255
    end
    object qryMainDescription2: TStringField
      DisplayLabel = 'Description - Price List'
      DisplayWidth = 200
      FieldName = 'Description2'
      Size = 200
    end
    object qryMainFlag: TStringField
      DisplayWidth = 1
      FieldName = 'Flag'
      FixedChar = True
      Size = 1
    end
    object qryMainLength: TStringField
      DisplayWidth = 255
      FieldName = 'Length'
      Size = 255
    end
    object qryMainColour: TStringField
      FieldName = 'Colour'
      Visible = False
      Size = 50
    end
    object qryMainUnit: TStringField
      DisplayWidth = 255
      FieldName = 'Unit'
      Size = 255
    end
    object qryMainList: TFloatField
      DisplayWidth = 10
      FieldName = 'List'
      currency = True
    end
    object qryMainKanga: TFloatField
      DisplayWidth = 10
      FieldName = 'Kanga'
      currency = True
    end
    object qryMainGroup: TFloatField
      DisplayWidth = 10
      FieldName = 'Group'
      currency = True
    end
    object qryMainExport: TFloatField
      DisplayWidth = 10
      FieldName = 'Export'
      currency = True
    end
    object qryMainBranch: TFloatField
      DisplayWidth = 10
      FieldName = 'Branch'
      currency = True
    end
    object qryMainCost: TFloatField
      DisplayWidth = 10
      FieldName = 'Cost'
      currency = True
    end
    object qryMainSheetID: TIntegerField
      FieldName = 'SheetID'
      Visible = False
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
end
