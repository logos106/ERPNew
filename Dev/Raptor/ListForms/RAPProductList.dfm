inherited RapProductListGUI: TRapProductListGUI
  Left = 104
  Top = 295
  Caption = 'The Raptor Schedule'
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
      Caption = 'The Raptor Schedule'
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
        'PriorApprovalRequired;CheckBox;T;F'
        'GST;CheckBox;T;F'
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'ItemNo'#9'7'#9'Item No'#9#9
        'Description'#9'35'#9'Name'#9#9
        'PartNAme'#9'30'#9'Platinum1 Product Name'#9#9
        'PriorApprovalRequired'#9'1'#9'Required?'#9'F'#9'Prior Approval'
        'PriorApprovalAmtLimit'#9'12'#9'Amount Limit'#9'F'#9'Prior Approval'
        'PriorApprovalQtyLimit'#9'12'#9'Quantity Limit'#9'F'#9'Prior Approval'
        'GST'#9'1'#9'GST r/s?'#9#9
        'SpecialConsitions'#9'10'#9'Special Consitions'#9#9
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14144187
      TitleLines = 2
      UseTFields = False
      FooterColor = 14144187
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT 2 as DisplayCat, tblrapproducts.RapCategoryID as Category' +
        'ID, '
      'tblrapproducts.ProductCode as ItemNo,'
      'tblrapproducts.Description,'
      'tblrapproducts.RapProductID,'
      'tblrapproducts.ProductID,'
      'tblrapproducts.PriorApprovalRequired,'
      'tblrapproducts.PriorApprovalQtyLimit,'
      'tblrapproducts.PriorApprovalAmtLimit,'
      'tblrapproducts.GST,'
      'tblrapproducts.SpecialConsitions,'
      'tblrapproducts.Active , '
      'tblParts.PartNAme '
      'FROM'
      'tblrapproducts '
      'inner join tblParts on ProductID = PartsId'
      'Where ifnull(ProductId,0) <> 0'
      'union'
      
        'SELECT 2 as DisplayCat, tblrapproducts.RapCategoryID as Category' +
        'ID,'
      'tblrapproducts.ProductCode as ItemNo,'
      'tblrapproducts.Description,'
      'tblrapproducts.RapProductID,'
      'tblrapproducts.ProductID,'
      'tblrapproducts.PriorApprovalRequired,'
      'tblrapproducts.PriorApprovalQtyLimit,'
      'tblrapproducts.PriorApprovalAmtLimit,'
      'tblrapproducts.GST,'
      'tblrapproducts.SpecialConsitions,'
      'tblrapproducts.Active , '
      '""'
      'FROM'
      'tblrapproducts '
      'Where ifnull(ProductId,0) = 0'
      'union '
      'Select 1 as DisplayCat , tblrapcategories.CategoryID,'
      'tblrapcategories.ItemNo,'
      'tblrapcategories.ItemName, 0,0,'#39'F'#39',0,0,"F","",Active , ""'
      'From tblrapcategories'
      'order by CategoryID, DisplayCat'
      '')
    object qryMainItemNo: TStringField
      DisplayLabel = 'Item No'
      DisplayWidth = 7
      FieldName = 'ItemNo'
      Origin = 'tblrapproducts.ItemNo'
      Size = 4
    end
    object qryMainDescription: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 35
      FieldName = 'Description'
      Origin = 'tblrapproducts.Description'
      Size = 100
    end
    object qryMainPartNAme: TStringField
      DisplayLabel = 'Platinum1 Product Name'
      DisplayWidth = 30
      FieldName = 'PartNAme'
      Size = 60
    end
    object qryMainPriorApprovalRequired: TStringField
      DisplayLabel = 'Required?'
      DisplayWidth = 1
      FieldName = 'PriorApprovalRequired'
      Origin = 'tblrapproducts.PriorApprovalRequired'
      FixedChar = True
      Size = 1
    end
    object qryMainPriorApprovalAmtLimit: TFloatField
      DisplayLabel = 'Amount Limit'
      DisplayWidth = 12
      FieldName = 'PriorApprovalAmtLimit'
      Origin = 'tblrapproducts.PriorApprovalAmtLimit'
    end
    object qryMainPriorApprovalQtyLimit: TFloatField
      DisplayLabel = 'Quantity Limit'
      DisplayWidth = 12
      FieldName = 'PriorApprovalQtyLimit'
      Origin = 'tblrapproducts.PriorApprovalQtyLimit'
    end
    object qryMainGST: TStringField
      DisplayLabel = 'GST r/s?'
      DisplayWidth = 1
      FieldName = 'GST'
      Origin = 'tblrapproducts.GST'
      FixedChar = True
      Size = 1
    end
    object qryMainSpecialConsitions: TMemoField
      DisplayLabel = 'Special Consitions'
      DisplayWidth = 10
      FieldName = 'SpecialConsitions'
      Origin = 'tblrapproducts.SpecialConsitions'
      BlobType = ftMemo
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblrapproducts.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainDisplayCat: TLargeintField
      FieldName = 'DisplayCat'
      Origin = 'tblrapproducts.DisplayCat'
      Visible = False
    end
    object qryMainCategoryID: TIntegerField
      FieldName = 'CategoryID'
      Origin = 'tblrapproducts.CategoryID'
      Visible = False
    end
    object qryMainRapProductID: TLargeintField
      FieldName = 'RapProductID'
      Origin = 'tblrapproducts.RapProductID'
      Visible = False
    end
    object qryMainProductID: TLargeintField
      FieldName = 'ProductID'
      Origin = 'tblrapproducts.ProductID'
      Visible = False
    end
  end
  inherited ExportDialog: TProgressDialog
    Left = 259
  end
end
