inherited RapCategoryListGUI: TRapCategoryListGUI
  Left = 126
  Top = 176
  Caption = 'RAP Category List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14144187
  end
  inherited HeaderPanel: TPanel
    Color = 14144187
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'RAP Category List'
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
        'ItemCode'#9'2'#9'Item code'#9#9
        'ItemNo'#9'4'#9'Item No'#9#9
        'ItemName'#9'53'#9'Item Name'#9#9
        'SeeAlso'#9'52'#9'See Also'#9#9
        'Note'#9'10'#9'Notes'#9#9
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14144187
      UseTFields = False
      FooterColor = 14144187
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select '
      
        'RPList.CategoryID,RPList.ItemCode,RPList.ItemNo,RPList.ItemName,' +
        'SeeAlso.ItemName as SeeAlso,RPList.Note,RPList.Active'
      'from tblRapCategories as RPList'
      
        'left join tblRapCategories as SeeAlso on RPList.SeeAlsoCategory ' +
        '= SeeAlso.ItemNo')
    object qryMainItemCode: TStringField
      DisplayLabel = 'Item code'
      DisplayWidth = 2
      FieldName = 'ItemCode'
      Origin = 'tblRapCategories.ItemCode'
      FixedChar = True
      Size = 2
    end
    object qryMainItemNo: TStringField
      DisplayLabel = 'Item No'
      DisplayWidth = 4
      FieldName = 'ItemNo'
      Origin = 'tblRapCategories.ItemNo'
      Size = 4
    end
    object qryMainItemName: TStringField
      DisplayLabel = 'Item Name'
      DisplayWidth = 53
      FieldName = 'ItemName'
      Origin = 'tblRapCategories.ItemName'
      Size = 100
    end
    object qryMainSeeAlso: TStringField
      DisplayLabel = 'See Also'
      DisplayWidth = 52
      FieldName = 'SeeAlso'
      Origin = 'SeeAlso.SeeAlso'
      Size = 100
    end
    object qryMainNote: TMemoField
      DisplayLabel = 'Notes'
      DisplayWidth = 10
      FieldName = 'Note'
      Origin = 'tblRapCategories.Note'
      BlobType = ftMemo
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblRapCategories.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainCategoryID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'CategoryID'
      Origin = 'tblRapCategories.CategoryID'
      Visible = False
    end
  end
  inherited ExportDialog: TProgressDialog
    Left = 259
  end
end
