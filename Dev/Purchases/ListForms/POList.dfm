inherited POListGUI: TPOListGUI
  Left = 87
  Top = 157
  Caption = 'Purchase Order List'
  ExplicitLeft = 87
  ExplicitTop = 157
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 886001
  inherited HeaderPanel: TPanel
    HelpContext = 886005
    inherited pnlHeader: TPanel
      Left = 273
      Width = 394
      ExplicitLeft = 273
      ExplicitWidth = 394
      HelpContext = 886002
      inherited TitleShader: TShader
        Width = 392
        ExplicitWidth = 392
        HelpContext = 886003
        inherited TitleLabel: TLabel
          Width = 392
          Caption = 'Purchase Order List'
          ExplicitWidth = 392
          HelpContext = 886004
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 886006
      inherited btnExpressDetail: TDNMSpeedButton
        Visible = False
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      'tblPurchaseOrders.PurchaseOrderID as PurchaseOrderID,'
      'tblPurchaseOrders.SupplierName,'
      
        'If(tblPurchaseOrders.IsPO='#39'T'#39','#39'Purchase Order'#39', If(tblPurchaseOr' +
        'ders.IsPOCredit='#39'T'#39','#39'PO Credit'#39','#39#39')) as Type,'
      'tblPurchaseOrders.PurchaseOrderNumber  as "P/O Num",'
      'date(tblPurchaseOrders.OrderDate) as OrderDate,'
      'tblPurchaseOrders.Comments as Comments,'
      'tblPurchaseOrders.ETADate as ETADate,'
      'tblPurchaseOrders.InvoiceNumber as InvoiceNumber,'
      'Round(tblPurchaseOrders.TotalAmountInc,2) as TotalAmountInc,'
      'tblPurchaseOrders.InvoiceDate as InvoiceDate,'
      'tblPurchaseOrders.Approved, '
      'tblPurchaseOrders.Paid'
      'FROM tblPurchaseOrders'
      
        'LEFT JOIN tblPurchaseLines ON  (tblPurchaseOrders.PurchaseOrderI' +
        'D = tblPurchaseLines.PurchaseOrderID)'
      'Where '
      '(tblPurchaseOrders.IsPO='#39'T'#39' OR tblPurchaseOrders.IsPOCredit='#39'T'#39')'
      'AND tblPurchaseOrders.OrderDate between :txtFrom and :txtTo'
      
        'AND ((:Approved = "T" AND tblPurchaseOrders.Approved = "T") OR (' +
        ':Approved = "F")) '
      
        'AND (((tblPurchaseOrders.TotalAmountInc <= :EmployeeApprovalValu' +
        'eH) AND (tblPurchaseOrders.TotalAmountInc >= :EmployeeApprovalVa' +
        'lueL)) OR ((:EmployeeApprovalValueH = 0)OR (tblPurchaseOrders.En' +
        'teredBy = :EnteredBy)))'
      'GROUP BY tblPurchaseOrders.PurchaseOrderID'
      'Order by OrderDate desc')
  end
end
