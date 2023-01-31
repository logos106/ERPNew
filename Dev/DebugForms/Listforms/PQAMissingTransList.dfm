inherited PQAMissingTransListGUI: TPQAMissingTransListGUI
  Caption = 'PQA Missing TransList'
  ExplicitLeft = 250
  ExplicitTop = 143
  ExplicitWidth = 1006
  ExplicitHeight = 591
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 851001
  inherited HeaderPanel: TPanel
    HelpContext = 851003
    inherited pnlHeader: TPanel
      HelpContext = 851004
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'PQA Missing TransList'
          HelpContext = 851002
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 851005
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'ProductId'#9'10'#9'Product#'
        'ProductName'#9'20'#9'Product'#9'F'
        'TransID'#9'15'#9'Trans#'
        'translineId'#9'10'#9'Trans Line#'
        'TransType'#9'15'#9'Trans Type'
        'TransDate'#9'12'#9'Trans Date'
        'alloctype'#9'3'#9'Alloc Type'
        'Qty'#9'10'#9'Quantity'
        'active'#9'1'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select'
      
        'TransDate, PQA.active, PQA.ProductId, PQA.ProductName, PQA.Trans' +
        'ID , PQa.translineId, PQa.alloctype , PQA.TransType , PQA.Qty  ,' +
        ' '
      
        'Sl.SalelineId, PL.purchaseLineId , PTP.proctreePartID, PTPIn.pro' +
        'ctreePArtID proctreePArtIDIn, SML.StockmovementLinesID   , RP.Re' +
        'pairPartsID'
      'from tblPQa PQA '
      
        'Left join (tblSalesLines SL inner join tblSales S on s.SaleId = ' +
        'Sl.SaleID '
      
        #9#9'and (S.IsInvoice = '#39'T'#39' or S.IsSalesorder = '#39'T'#39' or S.IsCashSale' +
        ' = '#39'T'#39' or S.IsRefund = '#39'T'#39' or S.IsPOS = '#39'T'#39') )  '
      
        #9#9'on SL.SaleLineId = PQA.TransLineID and SL.saleId = PQA.TransID' +
        ' '
      
        #9#9'and (PQA.transtype in ('#39'TInvoiceLine'#39' , '#39'TSalesOrderline'#39' , '#39'T' +
        'RefundSaleLine'#39' , '#39'TPOSCashSaleline'#39' , '#39'TPOSLaybylines'#39' , '#39'TCash' +
        'SaleLine'#39') ) '
      
        'Left join (tblPurchaseLines PL inner join tblpurchaseorders PO o' +
        'n PO.PurchaseOrderID = PL.purchaseOrderID and PO.IsPO = '#39'T'#39')'
      
        #9#9'on PL.purchaseLineId = PQA.TransLineID and PL.purchaseOrderID ' +
        '= PQA.TransID and PQA.TransType = '#39'TPurchaseOrderLine'#39
      
        'Left join (tblProctreePart PTP inner join tblProcTree PT on Pt.P' +
        'roctreeId = PTP.ProctreeId  ) '
      
        #9#9'on PTP.proctreePartId = PQA.transLineId and PQA.Transtype = '#39'T' +
        'ProcTreePart'#39
      
        'Left join (tblProctreePart PTPIn inner join tblProcTree PTIN on ' +
        'PTIN.ProctreeId = PTPIn.ProctreeId  ) '
      
        #9#9'on PTPIn.proctreePartId = PQA.transLineId and PQA.alloctype = ' +
        #39'IN'#39' and PQA.Transtype = '#39'TProcTreePartIN'#39
      
        'Left join (tblstockmovementlines SML inner join tblstockmovement' +
        ' SM on SM.StockmovementID = SML.stockmovementId) '
      
        #9#9'on PQA.TransLineID = SML.StockmovementLinesID and PQa.transId ' +
        '= SML.stockMovementId and PQa.transtype = '#39'TStockMovementLines'#39
      
        'Left join tblREpairParts RP on RP.RepairID = PQA.TransID and RP.' +
        'RepairPartsID = PQA.TransLineID and PQA.TransType = '#39'TRepairPart' +
        's'#39
      'Where '
      'ifnull(Sl.SalelineId,0)=0 '
      'and  ifnull(PL.purchaseLineId,0)=0 '
      'and  ifnull(PTP.proctreePartID,0)=0 '
      'and  ifnull(PTPIn.proctreePArtID,0)=0 '
      'and  ifnull(SML.StockmovementLinesID,0)=0'
      'and ifnull(RP.RepairPartsID,0) =0'
      'order by TransDate')
    object qryMainProductId: TIntegerField
      DisplayLabel = 'Product#'
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'PQA.ProductId'
    end
    object qryMainProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'PQA.ProductName'
      Size = 100
    end
    object qryMainTransID: TLargeintField
      DisplayLabel = 'Trans#'
      DisplayWidth = 15
      FieldName = 'TransID'
      Origin = 'PQA.TransID'
    end
    object qryMaintranslineId: TIntegerField
      DisplayLabel = 'Trans Line#'
      DisplayWidth = 10
      FieldName = 'translineId'
      Origin = 'PQA.translineId'
    end
    object qryMainTransType: TWideStringField
      DisplayLabel = 'Trans Type'
      DisplayWidth = 15
      FieldName = 'TransType'
      Origin = 'PQA.TransType'
      Size = 50
    end
    object qryMainTransDate: TDateTimeField
      DisplayLabel = 'Trans Date'
      DisplayWidth = 12
      FieldName = 'TransDate'
      Origin = 'PQA.TransDate'
    end
    object qryMainalloctype: TWideStringField
      DisplayLabel = 'Alloc Type'
      DisplayWidth = 3
      FieldName = 'alloctype'
      Origin = 'PQA.alloctype'
      Size = 3
    end
    object qryMainQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'PQA.Qty'
    end
    object qryMainactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 1
      FieldName = 'active'
      Origin = 'PQA.active'
      FixedChar = True
      Size = 1
    end
    object qryMainSalelineId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Sale LineId'
      DisplayWidth = 10
      FieldName = 'SalelineId'
      Origin = 'SL.SalelineId'
      Visible = False
    end
    object qryMainpurchaseLineId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'purchaseLineId'
      Origin = 'PL.purchaseLineId'
      Visible = False
    end
    object qryMainproctreePartID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'proctreePartID'
      Origin = 'PTP.proctreePartID'
      Visible = False
    end
    object qryMainStockmovementLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'StockmovementLinesID'
      Origin = 'SML.StockmovementLinesID'
      Visible = False
    end
    object qryMainRepairPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RepairPartsID'
      Origin = 'RP.RepairPartsID'
      Visible = False
    end
    object qryMainproctreePArtIDIn: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'proctreePArtIDIn'
      Origin = 'PTPIn.proctreePArtIDIn'
      Visible = False
    end
  end
end
