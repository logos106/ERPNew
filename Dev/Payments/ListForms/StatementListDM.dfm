inherited StatementListDat: TStatementListDat
  OldCreateOrder = True
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      'Null as TransactionDate,'
      'CustomerName as CustomerName,'
      'NULL AS ReceiptNo,'
      'NULL as InvoiceNumber,'
      'Null as TransType,'
      
        'case group_concat(distinct If(tblsales.Balance = 0, 3, if(tblsal' +
        'es.Balance = TotalAmountInc, 1, If(tblsales.Balance < TotalAmoun' +
        'tInc, 2, 0)))) when "1" then "No Payment" when "2" then "Partial' +
        'ly paid" when "3" then "Fully paid" else "Partially Paid" end as' +
        ' Status,'
      'NULL as TransactionDueDate,'
      'NULL AS DaysOutstanding,'
      'Sum(TotalAmountInc) AS TotalAmount,'
      
        '0-ifnull((select sum(balance) from tblprepayments where clientId' +
        ' = tblSales.clientID),0) as PrepayAmount, '
      'sum(tblsales.Balance) AS OutstandingAmount,'
      
        'sum(If( TO_DAYS(NOW()) - TO_DAYS(DueDate)<=0, tblsales.Balance, ' +
        '0.00)) AS WithinTerms, '
      
        'sum(If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >0 And  TO_DAYS(Now())' +
        ' - TO_DAYS(DueDate) <=7 ,tblsales.Balance,0.00)) AS Days1to7, '
      
        'sum(if( TO_DAYS(NOW()) - TO_DAYS(DueDate) >7 And  TO_DAYS(Now())' +
        ' - TO_DAYS(DueDate) <=14 ,tblsales.Balance,0.00)) AS Days7to14, '
      
        'sum(If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >14 And  TO_DAYS(Now()' +
        ') - TO_DAYS(DueDate)<=21 ,tblsales.Balance,0.00)) AS Days14to21,' +
        ' '
      
        'sum(If(( TO_DAYS(NOW()) - TO_DAYS(DueDate) >21),tblsales.Balance' +
        ',0.00)) AS morethan21,'
      
        'sum(If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >0 And  TO_DAYS(Now())' +
        ' - TO_DAYS(DueDate) <=30 ,tblsales.Balance,0.00)) AS Days1to30, '
      
        'sum(if( TO_DAYS(NOW()) - TO_DAYS(DueDate) >30 And  TO_DAYS(Now()' +
        ') - TO_DAYS(DueDate) <=60 ,tblsales.Balance,0.00)) AS Days30to60' +
        ', '
      
        'sum(If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >60 And  TO_DAYS(Now()' +
        ') - TO_DAYS(DueDate)<=90 ,tblsales.Balance,0.00)) AS Days60to90,' +
        ' '
      
        'sum(If(( TO_DAYS(NOW()) - TO_DAYS(DueDate) >90),tblsales.Balance' +
        ',0.00)) AS MoreThan90,'
      'NULL as SaleID,'
      'tblClients.ClientID as ClientID,'
      '1 as Details,'
      'NULL  as GlobalRef'
      'FROM tblsales'
      
        'LEFT JOIN tblClients  ON  tblsales.CustomerName = tblClients.Com' +
        'pany'
      'WHERE ( IsRefund ='#39'T'#39' OR IsInvoice='#39'T'#39') AND IsCashSale='#39'F'#39'  AND'
      
        'IsSalesOrder='#39'F'#39' AND IsQuote='#39'F'#39' AND tblsales.Deleted<>"T" AND T' +
        'otalAmountInc <> 0'
      'AND SaleDate between :dateFrom and :dateTo '
      'GROUP BY tblsales.CustomerName '
      'union all '
      'SELECT'
      'SaleDate as TransactionDate,'
      'CustomerName as CustomerName,'
      'NULL AS ReceiptNo,'
      'InvoiceDocNumber as InvoiceNumber,'
      
        'If(IsRefund='#39'T'#39','#39'Refund          '#39','#39'Invoice            '#39') as Tra' +
        'nsType,'
      
        'If(tblsales.Balance = 0, '#39'Fully Paid         '#39', if(tblsales.Bala' +
        'nce = TotalAmountInc, '#39'No Payment         '#39', If(tblsales.Balance' +
        ' < TotalAmountInc, '#39'Partially Paid'#39', 0))) as Status,'
      'DueDate as TransactionDueDate,'
      'TO_DAYS(NOW()) - TO_DAYS(DueDate) AS DaysOutstanding,'
      'TotalAmountInc AS TotalAmount,'
      'null  AS PrepayAmount, '
      'tblsales.Balance AS OutstandingAmount,'
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate)<=0, tblsales.Balance, 0.00' +
        ') AS WithinTerms, '
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >0 And  TO_DAYS(Now()) - T' +
        'O_DAYS(DueDate) <=7 ,tblsales.Balance,0.00) AS Days1to7, '
      
        'if( TO_DAYS(NOW()) - TO_DAYS(DueDate) >7 And  TO_DAYS(Now()) - T' +
        'O_DAYS(DueDate) <=14 ,tblsales.Balance,0.00) AS Days7to14, '
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >14 And  TO_DAYS(Now()) - ' +
        'TO_DAYS(DueDate)<=21 ,tblsales.Balance,0.00) AS Days14to21, '
      
        'If(( TO_DAYS(NOW()) - TO_DAYS(DueDate) >21),tblsales.Balance,0.0' +
        '0) AS morethan21,'
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >0 And  TO_DAYS(Now()) - T' +
        'O_DAYS(DueDate) <=30 ,tblsales.Balance,0.00) AS Days1to30, '
      
        'if( TO_DAYS(NOW()) - TO_DAYS(DueDate) >30 And  TO_DAYS(Now()) - ' +
        'TO_DAYS(DueDate) <=60 ,tblsales.Balance,0.00) AS Days30to60, '
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >60 And  TO_DAYS(Now()) - ' +
        'TO_DAYS(DueDate)<=90 ,tblsales.Balance,0.00) AS Days60to90, '
      
        'If(( TO_DAYS(NOW()) - TO_DAYS(DueDate) >90),tblsales.Balance,0.0' +
        '0) AS MoreThan90,'
      'SaleID as SaleID,'
      'tblClients.ClientID as ClientID,'
      '2 as Details,'
      'tblsales.GlobalRef as GlobalRef'
      'FROM tblsales'
      
        'LEFT JOIN tblClients  ON  tblsales.CustomerName = tblClients.Com' +
        'pany'
      'WHERE ( IsRefund ='#39'T'#39' OR IsInvoice='#39'T'#39') AND IsCashSale='#39'F'#39'  AND'
      
        'IsSalesOrder='#39'F'#39' AND IsQuote='#39'F'#39' AND tblsales.Deleted<>"T" AND T' +
        'otalAmountInc <> 0'
      'AND SaleDate between :dateFrom and :dateTo '
      'GROUP BY tblsales.SaleID'
      'union all '
      'SELECT'
      'PrePaymentDate  as TransactionDate,'
      'CompanyName as CustomerName,'
      'null AS ReceiptNo,'
      'null as InvoiceNumber,'
      '"Prepayment" as TransType,'
      '"Prepayment" as Status,'
      'PrePaymentDate as TransactionDueDate,'
      '0 AS DaysOutstanding,'
      'Null AS TotalAmount,'
      'sum(0-ifnull(Balance,0)) AS PrepayAmount, '
      'sum(0-ifnull(Balance,0)) AS OutstandingAmount,'
      '0 AS WithinTerms, '
      '0 AS Days1to7, '
      '0 AS Days7to14,  '
      '0 AS Days14to21,  '
      '0 AS morethan21,'
      '0 AS Days1to30, '
      '0 AS Days30to60,  '
      '0 AS Days60to90,  '
      '0 AS MoreThan90,'
      'null as SaleID,'
      'ClientID as ClientID, '
      '2 as details,'
      'GlobalRef as GlobalRef'
      'FROM tblprepayments  '
      'WHERE Deleted <> "T" '
      'and PrePaymentDate between :dateFrom and :dateTo '
      'group by ClientID'
      'Union ALL'
      'SELECT'
      'SaleDate as TransactionDate,'
      'CustomerName as CustomerName,'
      'NULL AS ReceiptNo,'
      'InvoiceDocNumber as InvoiceNumber,'
      
        'If(IsRefund='#39'T'#39','#39'Refund          '#39','#39'Invoice            '#39') as Tra' +
        'nsType,'
      
        'If(tblsales.Balance = 0, '#39'Fully Paid         '#39', if(tblsales.Bala' +
        'nce = TotalAmountInc, '#39'No Payment         '#39', If(tblsales.Balance' +
        ' < TotalAmountInc, '#39'Partially Paid'#39', 0))) as Status,'
      'DueDate as TransactionDueDate,'
      'TO_DAYS(NOW()) - TO_DAYS(DueDate) AS DaysOutstanding,'
      'TotalAmountInc AS TotalAmount,'
      'null  AS Prepayamount, '
      'tblsales.balance AS OutstandingAmount,'
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate)<=0, tblsales.Balance, 0.00' +
        ') AS WithinTerms, '
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >0 And  TO_DAYS(Now()) - T' +
        'O_DAYS(DueDate) <=7 ,tblsales.Balance,0.00) AS Days1to7, '
      
        'if( TO_DAYS(NOW()) - TO_DAYS(DueDate) >7 And  TO_DAYS(Now()) - T' +
        'O_DAYS(DueDate) <=14 ,tblsales.Balance,0.00) AS Days7to14, '
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >14 And  TO_DAYS(Now()) - ' +
        'TO_DAYS(DueDate)<=21 ,tblsales.Balance,0.00) AS Days14to21, '
      
        'If(( TO_DAYS(NOW()) - TO_DAYS(DueDate) >21),tblsales.Balance,0.0' +
        '0) AS morethan21,'
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >0 And  TO_DAYS(Now()) - T' +
        'O_DAYS(DueDate) <=30 ,tblsales.Balance,0.00) AS Days1to30, '
      
        'if( TO_DAYS(NOW()) - TO_DAYS(DueDate) >30 And  TO_DAYS(Now()) - ' +
        'TO_DAYS(DueDate) <=60 ,tblsales.Balance,0.00) AS Days30to60, '
      
        'If( TO_DAYS(NOW()) - TO_DAYS(DueDate) >60 And  TO_DAYS(Now()) - ' +
        'TO_DAYS(DueDate)<=90 ,tblsales.Balance,0.00) AS Days60to90, '
      
        'If(( TO_DAYS(NOW()) - TO_DAYS(DueDate) >90),tblsales.Balance,0.0' +
        '0) AS MoreThan90,'
      'SaleID as SaleID,'
      'tblClients.ClientID as ClientID,'
      '3 as Details,'
      'tblsales.GlobalRef as GlobalRef'
      'FROM tblsales'
      
        'LEFT JOIN tblClients  ON  tblsales.CustomerName = tblClients.Com' +
        'pany'
      'WHERE ( IsRefund ='#39'T'#39' OR IsInvoice='#39'T'#39') AND IsCashSale='#39'F'#39'  AND'
      
        'IsSalesOrder='#39'F'#39' AND IsQuote='#39'F'#39' AND tblsales.Deleted<>"T" AND T' +
        'otalAmountInc <> 0'
      'AND SaleDate between :dateFrom and :dateTo '
      'GROUP BY tblsales.SaleID'
      'union all '
      'SELECT '
      'PaymentDate as TransactionDate,'
      'tblClients.Company as CustomerName,'
      'tbldepositline.PaymentID  AS ReceiptNo,'
      'InvoiceNo as InvoiceNumber,'
      #39'Payment'#39' as TransType,'
      #39'Payment'#39' as Status,'
      'InvoiceDate as TransactionDate,'
      '0 AS DaysOutstanding,'
      '-(tbldepositline.Payment)  AS TotalAmount,'
      'null  AS PrepayAmount, '
      'NULL AS OutstandingAmount,'
      '0 AS WithinTerms, '
      '0 AS Days1to7, '
      '0 AS Days7to14, '
      '0 AS Days14to21, '
      '0 AS morethan21,'
      '0 AS Days1to30, '
      '0 AS Days30to60, '
      '0 AS Days60to90, '
      '0 AS MoreThan90,'
      'tbldepositline.SaleID as SaleID,'
      'tblClients.ClientID as ClientID, '
      '3 as Details,'
      'tbldeposits.GlobalRef as GlobalRef'
      'FROM tbldepositline'
      
        'INNER JOIN tbldeposits ON tbldepositline.PaymentID=tbldeposits.P' +
        'aymentID'
      'LEFT JOIN tblClients ON CusID = tblClients.ClientID'
      'LEFT JOIN tblsales ON tblsales.SaleID = tbldepositline.SaleID'
      'WHERE tbldeposits.Deleted <>'#39'T'#39'  '
      'AND InvoiceDate between :dateFrom and :dateTo'
      'union ALL'
      'SELECT'
      'PrePaymentDate  as TransactionDate,'
      'CompanyName as CustomerName,'
      'PrePaymentID AS ReceiptNo,'
      'PrepaymentID  as InvoiceNumber,'
      '"Prepayment" as TransType,'
      '"Prepayment" as Status,'
      'PrePaymentDate as TransactionDueDate,'
      '0 AS DaysOutstanding,'
      'null AS TotalAmount,'
      '0-balance as PrepayAmount,'
      '0-balance AS OutstandingAmount,'
      '0 AS WithinTerms, '
      '0 AS Days1to7, '
      '0 AS Days7to14,  '
      '0 AS Days14to21,  '
      '0 AS morethan21,'
      '0 AS Days1to30, '
      '0 AS Days30to60,  '
      '0 AS Days60to90,  '
      '0 AS MoreThan90,'
      'PrepaymentID as SaleID,'
      'ClientID as ClientID, '
      '3 as details,'
      'GlobalRef as Globalref'
      'FROM tblprepayments  '
      'WHERE Deleted <> "T" '
      'and PrePaymentDate between :dateFrom and :dateTo '
      'ORDER BY customername,details,InvoiceNumber,ReceiptNo')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dateTo'
      end
      item
        DataType = ftUnknown
        Name = 'dateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dateTo'
      end
      item
        DataType = ftUnknown
        Name = 'dateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dateTo'
      end
      item
        DataType = ftUnknown
        Name = 'dateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dateTo'
      end
      item
        DataType = ftUnknown
        Name = 'dateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dateTo'
      end
      item
        DataType = ftUnknown
        Name = 'dateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dateTo'
      end>
  end
end
