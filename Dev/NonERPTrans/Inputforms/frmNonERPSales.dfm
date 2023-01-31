inherited fmNonERPSales: TfmNonERPSales
  Left = 453
  Top = 299
  Caption = 'Non ERP Sale'
  ExplicitLeft = 453
  ExplicitTop = 299
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel2: TDNMPanel
    inherited pnlTitle: TDNMPanel
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Non ERP Sale'
        end
      end
    end
  end
  inherited qryMaster: TERPQuery
    Top = 227
    object qryMasterSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qryMasterInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Size = 30
    end
    object qryMasterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object qryMasterSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object qryMasterClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryMasterClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object qryMasterIsPOS: TWideStringField
      FieldName = 'IsPOS'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsRefund: TWideStringField
      FieldName = 'IsRefund'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsQuote: TWideStringField
      FieldName = 'IsQuote'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsLayby: TWideStringField
      FieldName = 'IsLayby'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsCustomerReturn: TWideStringField
      FieldName = 'IsCustomerReturn'
      FixedChar = True
      Size = 1
    end
    object qryMasterERPSaleID: TIntegerField
      FieldName = 'ERPSaleID'
    end
  end
  inherited qrydetails: TERPQuery
    Top = 227
  end
  inherited dsMaster: TDataSource
    Top = 259
  end
  inherited dsdetails: TDataSource
    Top = 259
  end
end
