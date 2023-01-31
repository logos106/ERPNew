inherited TranstotalMismatchGUI: TTranstotalMismatchGUI
  Caption = 'Total Amount Mismatch'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 896001
  inherited FooterPanel: TDnMPanel
    HelpContext = 896004
    inherited lblNote: TLabel
      Caption = 
        'Please Note the '#39'ID'#39' and Open the transaction from the relevant ' +
        'list to fix the record'
      HelpContext = 896002
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 376
      Top = -3
      ExplicitLeft = 376
      ExplicitTop = -3
      HelpContext = 896005
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 896006
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 896007
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Total Amount Mismatch'
          HelpContext = 896003
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 896008
      inherited grpFilters: TwwRadioGroup
        Columns = 6
        ItemIndex = 0
        Items.Strings = (
          'PO'
          'Invoice'
          'Quote'
          'CashSale'
          'Refund'
          'Sales Order')
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
    HelpContext = 896009
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'ID'#9'10'#9'ID#'
        'productname'#9'30'#9'Product'#9'F'
        'shipped'#9'10'#9'shipped'
        'unitex'#9'15'#9'unitex'
        'unitinc'#9'15'#9'unitinc'
        'totalex'#9'15'#9'totalex'
        'totalinc'#9'15'#9'totalinc')
      TitleLines = 2
      GroupFieldName = 'ID'
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        'Select '#39'PO'#39' category, pl.purchaseorderid ID, pl.purchaselineId l' +
        'ineID, pl.productname, '
      'pl.linecost unitex,pl.linecostinc unitinc,'
      'pl.TotalLineAmount totalex, '
      'pl.TotalLineAmountInc totalinc, '
      'pl.shipped '
      
        'from tblpurchaselines pl inner join tblpurchaseorders PO on PO.P' +
        'urchaseOrderID = pl.PurchaseOrderID and PO.IsPO = '#39'T'#39
      
        'where abs(abs(round(shipped * linecost,5)) -  abs(totallineamoun' +
        't))>.01 or '
      
        'abs(abs(round(shipped * linecostinc,5)) -  abs(totallineamountin' +
        'c))>.01'
      'union all '
      'Select '#39'Invoice'#39' , Sl.saleId, sl.salelineID, sl.productname, '
      'sl.lineprice,sl.linepriceinc,'
      'sl.TotalLineAmount, '
      'sl.TotalLineAmountInc, '
      'sl.shipped '
      
        'from tblsaleslines sl inner join tblsales s on s.SAleId = sl.Sal' +
        'eId and S.isinvoice = '#39'T'#39
      
        'where abs(abs(round(shipped * lineprice,5)) -  abs(totallineamou' +
        'nt))>.01 or '
      
        'abs(abs(round(shipped * linepriceinc,5)) -  abs(totallineamounti' +
        'nc))>.01'
      'union all '
      'Select '#39'refund'#39' , Sl.saleId, sl.salelineID, sl.productname, '
      'sl.lineprice,sl.linepriceinc,'
      'sl.TotalLineAmount, '
      'sl.TotalLineAmountInc, '
      'sl.shipped '
      
        'from tblsaleslines sl inner join tblsales s on s.SAleId = sl.Sal' +
        'eId and S.isrefund = '#39'T'#39
      
        'where abs(abs(round(shipped * lineprice,5)) -  abs(totallineamou' +
        'nt))>.01 or '
      
        'abs(abs(round(shipped * linepriceinc,5)) -  abs(totallineamounti' +
        'nc))>.01'
      'union all '
      'Select '#39'CashSale'#39' , Sl.saleId, sl.salelineID, sl.productname, '
      'sl.lineprice,sl.linepriceinc,'
      'sl.TotalLineAmount, '
      'sl.TotalLineAmountInc, '
      'sl.shipped '
      
        'from tblsaleslines sl inner join tblsales s on s.SAleId = sl.Sal' +
        'eId and S.iscashsale = '#39'T'#39
      
        'where abs(abs(round(shipped * lineprice,5)) -  abs(totallineamou' +
        'nt))>.01 or '
      
        'abs(abs(round(shipped * linepriceinc,5)) -  abs(totallineamounti' +
        'nc))>.01'
      'union all '
      'Select '#39'Quote'#39' , Sl.saleId, sl.salelineID, sl.productname, '
      'sl.lineprice,sl.linepriceinc,'
      'sl.TotalLineAmount, '
      'sl.TotalLineAmountInc, '
      'sl.shipped '
      
        'from tblsaleslines sl inner join tblsales s on s.SAleId = sl.Sal' +
        'eId and S.isquote = '#39'T'#39
      
        'where abs(abs(round(shipped * lineprice,5)) -  abs(totallineamou' +
        'nt))>.01 or '
      
        'abs(abs(round(shipped * linepriceinc,5)) -  abs(totallineamounti' +
        'nc))>.01'
      'union all '
      
        'Select '#39'Sales order'#39' , Sl.saleId, sl.salelineID, sl.productname,' +
        ' '
      'sl.lineprice,sl.linepriceinc,'
      'sl.TotalLineAmount, '
      'sl.TotalLineAmountInc, '
      'sl.shipped '
      
        'from tblsaleslines sl inner join tblsales s on s.SAleId = sl.Sal' +
        'eId and S.isSalesorder = '#39'T'#39
      
        'where abs(abs(round(shipped * lineprice,5)) -  abs(totallineamou' +
        'nt))>.01 or '
      
        'abs(abs(round(shipped * linepriceinc,5)) -  abs(totallineamounti' +
        'nc))>.01'
      ''
      'order by Category , ID, ProductName')
    Active = True
    object qryMainID: TIntegerField
      DisplayLabel = 'ID#'
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'ID'
    end
    object qryMainproductname: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 30
      FieldName = 'productname'
      Origin = 'productname'
      Size = 60
    end
    object qryMainshipped: TFloatField
      DisplayWidth = 10
      FieldName = 'shipped'
      Origin = 'shipped'
    end
    object qryMainunitex: TFloatField
      DisplayWidth = 15
      FieldName = 'unitex'
      Origin = 'unitex'
    end
    object qryMainunitinc: TFloatField
      DisplayWidth = 15
      FieldName = 'unitinc'
      Origin = 'unitinc'
    end
    object qryMaintotalex: TFloatField
      DisplayWidth = 15
      FieldName = 'totalex'
      Origin = 'totalex'
    end
    object qryMaintotalinc: TFloatField
      DisplayWidth = 15
      FieldName = 'totalinc'
      Origin = 'totalinc'
    end
    object qryMaincategory: TWideStringField
      DisplayLabel = 'Category'
      DisplayWidth = 11
      FieldName = 'category'
      Origin = 'category'
      Visible = False
      Size = 11
    end
    object qryMainlineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'lineID'
      Origin = 'lineID'
      Visible = False
    end
  end
end
