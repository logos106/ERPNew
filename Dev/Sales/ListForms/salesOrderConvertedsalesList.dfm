inherited salesOrderConvertedsalesListGUI: TsalesOrderConvertedsalesListGUI
  Caption = 'Sales Order Converted Sales List'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 858001
  inherited HeaderPanel: TPanel
    HelpContext = 858005
    inherited pnlHeader: TPanel
      Left = 92
      Width = 801
      ExplicitLeft = 92
      ExplicitWidth = 801
      HelpContext = 858002
      inherited TitleShader: TShader
        Width = 799
        HelpContext = 858003
        inherited TitleLabel: TLabel
          Width = 799
          Caption = 'Sales Order Converted Sales List'
          HelpContext = 858004
        end
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      '`SaleID`,'
      '`GlobalRef`,'
      '`InvoiceDocNumber`,'
      '`OriginalNo`,'
      '`BaseNo`,'
      '`BOID`,'
      '`CustomerName`,'
      '`SaleDate`,'
      '`TotalAmount`,'
      '`TotalAmountInc`,'
      '`EmployeeName`,'
      
        'if(IsRefund='#39'T'#39','#39'Refund'#39' , if(IsPOS='#39'T'#39' , '#39'POS'#39' , if(IsCashSale=' +
        #39'T'#39' , '#39'Cash Sale'#39' , if(IsInvoice='#39'T'#39' , '#39'Invoice'#39' , if(IsSalesOrd' +
        'er = '#39'T'#39', '#39'Sales Order'#39' , '#39'unknown'#39'))))) as Transtype,'
      '`Deleted`,'
      '`EnteredBy`'
      'From tblSales S'
      'where ifnull(SalesOrderGlobalref,'#39#39') = :ConvertingFromRef'
      'order by saleID')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ConvertingFromRef'
      end>
  end
end
