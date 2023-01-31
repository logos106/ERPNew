inherited QuoteConvertedSalesListGUI: TQuoteConvertedSalesListGUI
  Caption = 'Quote Converted Sales List'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 856001
  inherited HeaderPanel: TPanel
    HelpContext = 856005
    inherited pnlHeader: TPanel
      Left = 109
      Width = 786
      ExplicitLeft = 109
      ExplicitWidth = 786
      HelpContext = 856002
      inherited TitleShader: TShader
        Width = 784
        ExplicitWidth = 784
        HelpContext = 856003
        inherited TitleLabel: TLabel
          Width = 784
          Caption = 'Quote Converted Sales List'
          ExplicitWidth = 784
          HelpContext = 856004
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 856006
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'IsRefund;CheckBox;T;F'
        'IsPOS;CheckBox;T;F'
        'IsCashSale;CheckBox;T;F'
        'IsInvoice;CheckBox;T;F'
        'IsSalesOrder;CheckBox;T;F'
        'Deleted;CheckBox;T;F'
        'converted;CheckBox;T;F')
      Selected.Strings = (
        'SaleID'#9'10'#9'Sale#'#9#9
        'Transtype'#9'11'#9'Type'#9'F'#9
        'GlobalRef'#9'10'#9'Global Ref'#9#9
        'InvoiceDocNumber'#9'10'#9'Doc Number'#9#9
        'OriginalNo'#9'10'#9'Original No'#9#9
        'BaseNo'#9'10'#9'Base Ref'#9#9
        'BOID'#9'10'#9'BO Ref'#9#9
        'CustomerName'#9'20'#9'Customer~Name'#9#9
        'SaleDate'#9'10'#9'Sale Date'#9#9
        'TotalAmount'#9'10'#9'Ex'#9#9'Total Amount'
        'TotalAmountInc'#9'10'#9'Inc'#9#9'Total Amount'
        'EmployeeName'#9'10'#9'Employee'#9#9
        'Deleted'#9'1'#9'Deleted?'#9#9
        'EnteredBy'#9'10'#9'Entered By'#9#9
        'converted'#9'1'#9'converted'#9'F'#9)
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
      '`EnteredBy`,'
      'if(ISSalesorder='#39'T'#39',S.converted, '#39'F'#39') as converted,'
      's.SalesOrderglobalref'
      'From tblSales S'
      'where ifnull(QuoteGlobalref,'#39#39') =:ConvertingFromRef'
      'and isquote = '#39'F'#39
      'order by SaleID')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ConvertingFromRef'
      end>
    inherited qryMainTranstype: TWideStringField
      Origin = 'Transtype'
    end
    object qryMainconverted: TWideStringField
      DisplayWidth = 1
      FieldName = 'converted'
      Origin = 'converted'
      FixedChar = True
      Size = 1
    end
    object qryMainSalesOrderglobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesOrderglobalref'
      Origin = 'S.SalesOrderglobalref'
      Visible = False
      Size = 255
    end
  end
end
