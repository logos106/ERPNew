inherited IncompleteproctreepartGUI: TIncompleteproctreepartGUI
  Caption = 'IncompleteproctreepartGUI'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 769001
  inherited FooterPanel: TDnMPanel
    HelpContext = 769003
    inherited barStatus: TAdvOfficeStatusBar
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited Panel1: TPanel
    HelpContext = 769004
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'type'#9'7'#9'type'#9'F'
        'ProcTreePartId'#9'10'#9'ProcTreePart#'#9'F'#9'Proc Tree Part'
        'SaleId_1'#9'10'#9'SaleId'#9#9'Proc Tree Part'
        'SaleLineId'#9'10'#9'SaleLineId'#9#9'Proc Tree Part'
        'ProductId'#9'10'#9'ProductId'#9#9'Proc Tree Part'
        'ProductName'#9'15'#9'ProductName'#9#9'Proc Tree Part'
        'ProcTreeId'#9'10'#9'ProcTreeId'#9#9'Proc Tree Part'
        'SerialNumbers'#9'10'#9'SerialNumbers'#9#9'Proc Tree Part'
        'Qty'#9'10'#9'Qty'#9#9'Proc Tree Part'
        'UOMQty'#9'10'#9'UOM Qty'#9#9'Proc Tree Part'
        'UOMQtyOriginal'#9'10'#9'UOM Qty Original'#9#9'Proc Tree Part'
        'UOMQtyUsed'#9'10'#9'UOM Qty Used'#9#9'Proc Tree Part'
        'UnitOfMeasure'#9'10'#9'UOM'#9#9'Proc Tree Part'
        'UnitOfMeasureMultiplier'#9'10'#9'UOM Mult'#9#9'Proc Tree Part'
        'DateRequired'#9'18'#9'Date Required'#9#9'Proc Tree Part'
        'Active'#9'1'#9'Active'#9#9'Proc Tree Part'
        'UseStock'#9'1'#9'UseStock?'#9#9)
      TitleLines = 2
      UseTFields = False
      inherited btnGrid: TwwIButton
        Height = 33
        ExplicitHeight = 33
        HelpContext = 769002
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        'Select  S.SAleId, ptp.* , if(S.ISSalesorder="T" , "SO" , if(S.IS' +
        'Invoice="T" , "Inv" ,if (S.IsQuote="T", "Quote" , "unknown") )) ' +
        'type'
      'From '
      'tblSales S'
      'inner join tblSalesLines SL on S.SaleId = Sl.SaleId '
      
        'inner join tblProcTree Pt on Pt.masterId = Sl.SaleLineID  and Pt' +
        '.mastertype <> '#39'mtproduct'#39'  #and ifnull(Pt.PArentID,0) =0'
      'inner join tblproctreepart PTP on PTP.ProcTreeID = PT.ProcTreeId'
      'where ifnull(ptp.saleId,0) = 0 '
      'gROUP BY SL.Productname')
    object qryMainSAleId: TIntegerField
      DisplayLabel = 'Sale#'
      DisplayWidth = 10
      FieldName = 'SAleId'
      Origin = 'tblSales.SAleId'
    end
    object qryMainProcTreePartId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcTreePartId'
      Origin = 'PTP.ProcTreePartId'
    end
    object qryMainSaleId_1: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleId_1'
      Origin = 'PTP.SaleId'
    end
    object qryMainSaleLineId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineId'
      Origin = 'PTP.SaleLineId'
    end
    object qryMainProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'PTP.ProductId'
    end
    object qryMainProductName: TWideStringField
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'PTP.ProductName'
      Size = 60
    end
    object qryMainProcTreeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcTreeId'
      Origin = 'PTP.ProcTreeId'
    end
    object qryMainSerialNumbers: TWideMemoField
      DisplayWidth = 10
      FieldName = 'SerialNumbers'
      Origin = 'PTP.SerialNumbers'
      BlobType = ftWideMemo
    end
    object qryMainQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'PTP.Qty'
    end
    object qryMainUOMQty: TFloatField
      DisplayLabel = 'UOM Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'PTP.UOMQty'
    end
    object qryMainUOMQtyOriginal: TFloatField
      DisplayLabel = 'UOM Qty Original'
      DisplayWidth = 10
      FieldName = 'UOMQtyOriginal'
      Origin = 'PTP.UOMQtyOriginal'
    end
    object qryMainUOMQtyUsed: TFloatField
      DisplayLabel = 'UOM Qty Used'
      DisplayWidth = 10
      FieldName = 'UOMQtyUsed'
      Origin = 'PTP.UOMQtyUsed'
    end
    object qryMainUnitOfMeasure: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 10
      FieldName = 'UnitOfMeasure'
      Origin = 'PTP.UnitOfMeasure'
      Size = 255
    end
    object qryMainUnitOfMeasureMultiplier: TFloatField
      DisplayLabel = 'UOM Mult'
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureMultiplier'
      Origin = 'PTP.UnitOfMeasureMultiplier'
    end
    object qryMainDateRequired: TDateTimeField
      DisplayLabel = 'Date Required'
      DisplayWidth = 18
      FieldName = 'DateRequired'
      Origin = 'PTP.DateRequired'
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'PTP.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainUseStock: TWideStringField
      DisplayLabel = 'UseStock?'
      DisplayWidth = 1
      FieldName = 'UseStock'
      Origin = 'PTP.UseStock'
      FixedChar = True
      Size = 1
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'PTP.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainUnitOfMeasureId: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureId'
      Origin = 'PTP.UnitOfMeasureId'
      Visible = False
    end
    object qryMainClassId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassId'
      Origin = 'PTP.ClassId'
      Visible = False
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'PTP.msTimeStamp'
      Visible = False
    end
    object qryMaintype: TWideStringField
      FieldName = 'type'
      Size = 7
    end
  end
end
