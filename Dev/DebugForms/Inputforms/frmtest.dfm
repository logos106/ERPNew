inherited fmtest: Tfmtest
  Left = 211
  Top = 204
  Caption = 'fmtest'
  ExplicitLeft = 211
  ExplicitTop = 204
  DesignSize = (
    949
    532)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 8
    Top = 24
    Width = 441
    Height = 81
  end
  object Label1: TLabel [4]
    Left = 40
    Top = 66
    Width = 38
    Height = 15
    Caption = 'Label1'
  end
  object Bevel2: TBevel [5]
    Left = 455
    Top = 8
    Width = 490
    Height = 184
  end
  object Bevel3: TBevel [6]
    Left = 8
    Top = 111
    Width = 209
    Height = 97
  end
  object lblmsg: TLabel [7]
    Left = 10
    Top = 177
    Width = 199
    Height = 15
    Alignment = taCenter
    AutoSize = False
  end
  object Bevel4: TBevel [8]
    Left = 8
    Top = 214
    Width = 209
    Height = 97
  end
  object Bevel5: TBevel [9]
    Left = 240
    Top = 214
    Width = 209
    Height = 97
  end
  object Bevel6: TBevel [10]
    Left = 240
    Top = 111
    Width = 209
    Height = 97
  end
  object Label2: TLabel [11]
    Left = 8
    Top = 320
    Width = 38
    Height = 15
    Caption = 'Label2'
  end
  object English: TButton [14]
    Left = 360
    Top = 34
    Width = 75
    Height = 25
    Caption = 'English'
    TabOrder = 2
    OnClick = EnglishClick
  end
  object Edit1: TEdit [15]
    Left = 84
    Top = 65
    Width = 331
    Height = 23
    TabOrder = 3
    Text = 'Edit1'
  end
  object Button2: TButton [16]
    Left = 473
    Top = 121
    Width = 106
    Height = 25
    Caption = 'dump language db'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton [17]
    Left = 473
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton [18]
    Left = 477
    Top = 59
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton [19]
    Left = 473
    Top = 90
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Memo1: TMemo [20]
    Left = 597
    Top = 35
    Width = 337
    Height = 142
    Lines.Strings = (
      'Memo1')
    TabOrder = 8
  end
  object Button6: TButton [21]
    Left = 50
    Top = 146
    Width = 143
    Height = 25
    Caption = 'Populate Products'
    TabOrder = 9
    OnClick = Button6Click
  end
  object Button7: TButton [22]
    Left = 50
    Top = 249
    Width = 143
    Height = 25
    Caption = 'Script all tables'
    TabOrder = 10
    OnClick = Button7Click
  end
  object Button8: TButton [23]
    Left = 288
    Top = 146
    Width = 127
    Height = 25
    Caption = 'backup / restore'
    TabOrder = 11
    OnClick = Button8Click
  end
  object Button9: TButton [24]
    Left = 288
    Top = 249
    Width = 127
    Height = 25
    Caption = 'Price Matrix'
    TabOrder = 12
  end
  object Edit2: TEdit [25]
    Left = 8
    Top = 345
    Width = 159
    Height = 23
    TabOrder = 13
    Text = #1571#1576#1580#1583#1610#1577' '#1593#1585#1576#1610#1577#8206' '
  end
  object Button10: TButton [26]
    Left = 173
    Top = 345
    Width = 75
    Height = 25
    Caption = 'Print'
    TabOrder = 14
    OnClick = Button10Click
  end
  object Button11: TButton [27]
    Left = 173
    Top = 371
    Width = 75
    Height = 25
    Caption = 'translate'
    TabOrder = 15
    OnClick = Button11Click
  end
  object Edit3: TEdit [28]
    Left = 8
    Top = 374
    Width = 156
    Height = 23
    TabOrder = 16
    Text = 'Edit1'
  end
  object Memo2: TMemo [29]
    Left = 8
    Top = 403
    Width = 240
    Height = 110
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1'
      #1571#1576#1580#1583#1610#1577' '#1593#1585#1576#1610#1577#8206' '
      #1571#1576#1580#1583#1610#1577' '#1593#1585#1576#1610#1577#8206' '
      #1571#1576#1580#1583#1610#1577' '#1593#1585#1576#1610#1577#8206' '
      #1571#1576#1580#1583#1610#1577' '#1593#1585#1576#1610#1577#8206' '
      #1571#1576#1580#1583#1610#1577' '#1593#1585#1576#1610#1577#8206' ')
    TabOrder = 17
  end
  object Button12: TButton [30]
    Left = 272
    Top = 344
    Width = 110
    Height = 25
    Caption = 'Collation'
    TabOrder = 18
    OnClick = Button12Click
  end
  object Button13: TButton [31]
    Left = 272
    Top = 375
    Width = 110
    Height = 25
    Caption = 'Export /Import'
    TabOrder = 19
    OnClick = Button13Click
  end
  object Memo3: TMemo [32]
    Left = 272
    Top = 414
    Width = 672
    Height = 110
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'SELECT'
      'S.SaleDate as '#39'Sale Date'#39','
      'S.TimeOfSale as TimeOfSale,'
      
        'If(S.IsCashSale='#39'T'#39' And S.IsPOS='#39'F'#39' ,'#39'Cash Sale     '#39',If(S.IsRef' +
        'und='#39'T'#39','#39'Refund     '#39',If(S.IsCashSale='#39'T'#39' And '
      
        'S.IsPOS='#39'T'#39','#39'POS     '#39',If(S.IsInvoice='#39'T'#39','#39'Invoice'#39','#39'Sales Order' +
        #39')))) as '#39'Transaction Type'#39','
      'S.CustomerName as '#39'Customer Name'#39' ,'
      'S.GlobalRef as '#39'Global #'#39' ,'
      'S.OriginalNo as '#39'Original #'#39','
      'S.InvoiceDocNumber as '#39'Invoice Number'#39' ,'
      'S.PONumber as '#39'PO Number'#39','
      'S.ConNote as '#39'Consignment Note'#39', '
      'S.Class as '#39'Class Name'#39','
      'S.Deleted as Deleted,'
      'S.SaleID as SaleID,'
      'SL.SalesLinesCustField1 as SalesLinesCustField1,'
      'SL.SalesLinesCustField2 as SalesLinesCustField2,'
      'SL.SalesLinesCustField3 as SalesLinesCustField3,'
      'SL.SalesLinesCustField4 as SalesLinesCustField4,'
      'SL.SalesLinesCustField5 as SalesLinesCustField5,'
      'SL.SalesLinesCustField6 as SalesLinesCustField6,'
      'SL.SalesLinesCustField7 as SalesLinesCustField7,'
      'SL.SalesLinesCustField8 as SalesLinesCustField8,'
      'SL.SalesLinesCustField9 as SalesLinesCustField9,'
      'SL.SalesLinesCustField10 as SalesLinesCustField10,'
      'SL.ShipDate as ShipDate,'
      'SL.Discounts as Discounts,'
      'SL.DiscountPercent as DiscountPercent, '
      'SL.Markup as Markup, '
      'SL.MarkupPercent as MarkupPercent,'
      'SL.SmartOrderCreated as SmartOrderCreated,'
      'SL.ProductName as '#39'Product Name'#39','
      'SL.Product_Description as '#39'Product Description'#39' ,'
      'SL.LinePrice as '#39'Line Price (Ex)'#39','
      'SL.LinePriceInc as '#39'Line Price (Inc)'#39','
      
        'If(SL.Shipped<>0.00,SL.TotalLineAmount,SL.BackOrder * SL.LinePri' +
        'ce) as '#39'Line Total (Ex)'#39','
      
        'If(SL.Shipped<>0.00,SL.TotalLineAmountInc,SL.BackOrder * SL.Line' +
        'PriceInc) as '#39'Line Total (Inc)'#39','
      'SL.LineTaxCode as '#39'Tax Code'#39','
      'SL.LineTax as '#39'Line Tax'#39','
      'SL.LineCost as '#39'Line Cost (Ex)'#39','
      'SL.LineCostInc as '#39'Line Cost (Inc)'#39','
      'SL.Shipped,'
      'If(SL.Shipped<>0.00,0.00,SL.BackOrder) as BackOrder,'
      'SL.Attrib1Sale as Attrib1Sale, '
      'SL.Attrib2Sale as Attrib2Sale, '
      'SL.Attrib1SaleRate as Attrib1SaleRate,'
      'SL.Attrib1SaleRate* SL.Shipped as Attrib1SaleRateShipped,'
      'SL.Attrib1SaleRate* SL.QtySold as Attrib1SaleRateOrdered,'
      'SL.WarrantyEndsOn as WarrantyEndsOn,'
      'SL.WarrantyPeriod as WarrantyPeriod,'
      'SL.ShipDate as LineShipDate,'
      'Concat(E.FirstName," ", E.LastName) AS '#39'Employee Name'#39','
      'E.EmployeeID as EmployeeID,'
      'PT.TypeDesc as '#39'Product Type'#39', '
      
        'Left(If(InStr(P.PRODUCTGROUP,'#39'^'#39') -1 >0,Left(P.PRODUCTGROUP,InSt' +
        'r(P.PRODUCTGROUP,'#39'^'#39')-'
      '1),P.PRODUCTGROUP),255) AS Department ,'
      
        'Left(MID(P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'#39'^'#39')+1 ,If(LOCATE(' +
        #39'^'#39',P.PRODUCTGROUP,InStr'
      
        '(P.PRODUCTGROUP,'#39'^'#39')+1) - InStr(P.PRODUCTGROUP,'#39'^'#39') >0,LOCATE('#39'^' +
        #39',P.PRODUCTGROUP,InStr'
      
        '(P.PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(P.PRODUCTGROUP,'#39'^'#39'),IF(InStr(P' +
        '.PRODUCTGROUP,'#39'^'#39')<>0,LENGTH'
      '(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'#39'^'#39'),0))),255)  AS Type,'
      
        'Left(if((LOCATE('#39'^'#39',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'#39'^'#39')+1))' +
        ' >0, MID(P.PRODUCTGROUP,LOCATE'
      
        '('#39'^'#39',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(' +
        'P.PRODUCTGROUP)- LOCATE'
      
        '('#39'^'#39',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'#39'^'#39')+1)),  Null),255)  ' +
        'AS Manufacturer ,'
      'P.PREFEREDSUPP as '#39'Prefered Supplier'#39','
      'C.ClientID as ClientID,'
      'SR.MediaType as Source,'
      'C.CustFld1 as CustFld1,'
      'C.CustFld2 as CustFld2,'
      'C.CustFld3 as CustFld3,'
      'C.CustFld4 as CustFld4,'
      'C.CustFld5 as CustFld5,'
      'C.CustFld6 as CustFld6,'
      'C.CustFld7 as CustFld7,'
      'C.CustFld8 as CustFld8,'
      'C.CustFld9 as CustFld9,'
      'C.CustFld10 as CustFld10,'
      'C.CustFld11 as CustFld11,'
      'C.CustFld12 as CustFld12,'
      'C.CustFld13 as CustFld13,'
      'C.CustFld14 as CustFld14,'
      'C.CustFld15 as CustFld15,'
      'CT.TypeName as CustomerType'
      'FROM tblSales S'
      'INNER JOIN tblSalesLines SL ON  S.SaleID = SL.SaleID'
      'INNER JOIN tblparts P ON P.PARTSID = SL.ProductID'
      'INNER JOIN tblparttypes PT ON P.PARTTYPE = PT.TypeCode'
      'INNER JOIN tblClients C ON S.ClientID = C.ClientID'
      'INNER JOIN tblclienttype CT on CT.ClientTypeID= C.ClientTypeID'
      'INNER JOIN tblEmployees E ON S.EmployeeName = E.EmployeeName'
      'LEFT JOIN tblsource SR ON SR.MedTypeID=C.MedTypeID'
      
        'WHERE (S.IsRefund ='#39'T'#39' OR S.IsCashSale='#39'T'#39' OR S.IsInvoice='#39'T'#39' OR' +
        ' (S.Converted<>'#39'T'#39' AND S.IsSalesOrder='#39'T'#39') OR '
      'S.IsPOS='#39'T'#39') AND S.IsQuote='#39'F'#39'  AND S.IsLayby='#39'F'#39' '
      'Order BY SL.SaleID Desc')
    ScrollBars = ssVertical
    TabOrder = 20
  end
  object Button14: TButton [33]
    Left = 388
    Top = 352
    Width = 79
    Height = 34
    Caption = 'Export TTextFileObj'
    TabOrder = 21
    WordWrap = True
    OnClick = Button14Click
  end
  object Button15: TButton [34]
    Left = 473
    Top = 352
    Width = 79
    Height = 34
    Caption = 'Import TTextFileObj'
    TabOrder = 22
    WordWrap = True
    OnClick = Button15Click
  end
  object Button16: TButton [35]
    Left = 453
    Top = 286
    Width = 126
    Height = 25
    Caption = 'Collation test'
    TabOrder = 23
    OnClick = Button16Click
  end
  object Button17: TButton [36]
    Left = 465
    Top = 152
    Width = 126
    Height = 25
    Caption = 'Collation test no log'
    TabOrder = 24
    OnClick = Button17Click
  end
  object Button18: TButton [37]
    Left = 558
    Top = 356
    Width = 126
    Height = 25
    Caption = 'ERP_FIX tables'
    TabOrder = 25
    OnClick = Button18Click
  end
  object Button19: TButton [38]
    Left = 712
    Top = 376
    Width = 232
    Height = 25
    Caption = 'Button19'
    TabOrder = 26
    OnClick = Button19Click
  end
  object Arabic: TButton [39]
    Left = 240
    Top = 34
    Width = 75
    Height = 25
    Caption = 'Arabic'
    TabOrder = 1
    OnClick = ArabicClick
  end
  object Button1: TButton [40]
    Left = 40
    Top = 34
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  inherited MyConnection: TERPConnection
    Left = 512
    Top = 175
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004C014C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  object MyDump1: TMyDump
    TableNames = 'tblpreferences'
    SQL.Strings = (
      
        'delete from tblpreferences where PrefName = '#39'TStockQtysLocations' +
        'ReportGUI'#39';'
      
        'INSERT INTO tblpreferences(GlobalRef, PackageID, UserID, PrefGro' +
        'up, PrefName, PrefType, PrefValue, PrefDesc, msTimeStamp) VALUES'
      
        '  (NULL, 0, 0, '#39'GuiPrefs'#39', '#39'TStockQtysLocationsReportGUI'#39', NULL,' +
        ' '#39'<?xml version=\"1.0\" encoding=\"UTF-8\" ?><TStockQtysLocation' +
        'sReportGUI><grdMain><Columns><UOMQty><Hidden>False</Hidden><Visi' +
        'ble>False</Visible><Index>18</Index><DisplayWidth>10</DisplayWid' +
        'th><DisplayLabel>UOMQty</DisplayLabel></UOMQty><UOMMultiplier><V' +
        'isible>False</Visible><Index>18</Index><DisplayWidth>10</Display' +
        'Width><DisplayLabel>UOMMultiplier</DisplayLabel><Hidden>True</Hi' +
        'dden></UOMMultiplier><SOQty><Visible>False</Visible><Index>18</I' +
        'ndex><DisplayWidth>10</DisplayWidth><DisplayLabel>SOQty</Display' +
        'Label><Hidden>True</Hidden></SOQty><Qty><Visible>False</Visible>' +
        '<Index>18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>Qt' +
        'y</DisplayLabel><Hidden>True</Hidden></Qty><PartsId><Visible>Fal' +
        'se</Visible><Index>18</Index><DisplayWidth>10</DisplayWidth><Dis' +
        'playLabel>PartsId</DisplayLabel><Hidden>True</Hidden></PartsId><' +
        'InstockQty><Hidden>False</Hidden><Visible>False</Visible><Index>' +
        '18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>InstockQt' +
        'y</DisplayLabel></InstockQty><gLevel><Visible>False</Visible><In' +
        'dex>18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>gLeve' +
        'l</DisplayLabel><Hidden>True</Hidden></gLevel><DepartmentID><Vis' +
        'ible>False</Visible><Index>18</Index><DisplayWidth>10</DisplayWi' +
        'dth><DisplayLabel>DepartmentID</DisplayLabel><Hidden>True</Hidde' +
        'n></DepartmentID><BatchExpiryDate><Visible>False</Visible><Index' +
        '>18</Index><DisplayWidth>18</DisplayWidth><DisplayLabel>BatchExp' +
        'iryDate</DisplayLabel><Hidden>True</Hidden></BatchExpiryDate><Au' +
        'toID><Visible>False</Visible><Index>18</Index><DisplayWidth>10</' +
        'DisplayWidth><DisplayLabel>AutoID</DisplayLabel><Hidden>True</Hi' +
        'dden></AutoID><Value><Visible>True</Visible><Index>15</Index><Di' +
        'splayWidth>10</DisplayWidth><DisplayLabel>Value</DisplayLabel><H' +
        'idden>False</Hidden></Value><Cost><Visible>True</Visible><Index>' +
        '14</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>Cost</Dis' +
        'playLabel><Hidden>False</Hidden></Cost><SOUOMQty><Visible>True</' +
        'Visible><Index>13</Index><DisplayWidth>10</DisplayWidth><Display' +
        'Label>Sales Order</DisplayLabel><Hidden>False</Hidden></SOUOMQty' +
        '><InstockUOMQty><Visible>True</Visible><Index>12</Index><Display' +
        'Width>10</DisplayWidth><DisplayLabel>In-Stock</DisplayLabel><Hid' +
        'den>False</Hidden></InstockUOMQty><Serialnumber><Visible>True</V' +
        'isible><Index>11</Index><DisplayWidth>13</DisplayWidth><DisplayL' +
        'abel>Serial Number</DisplayLabel><Hidden>False</Hidden></Serialn' +
        'umber><Binnumber><Visible>True</Visible><Index>10</Index><Displa' +
        'yWidth>11</DisplayWidth><DisplayLabel>Bin Number</DisplayLabel><' +
        'Hidden>False</Hidden></Binnumber><Binlocation><Visible>True</Vis' +
        'ible><Index>9</Index><DisplayWidth>11</DisplayWidth><DisplayLabe' +
        'l>Bin Location</DisplayLabel><Hidden>False</Hidden></Binlocation' +
        '><ExpiryDate><Visible>True</Visible><Index>8</Index><DisplayWidt' +
        'h>10</DisplayWidth><DisplayLabel>Expiry Date</DisplayLabel><Hidd' +
        'en>False</Hidden></ExpiryDate><Batchnumber><Visible>True</Visibl' +
        'e><Index>7</Index><DisplayWidth>14</DisplayWidth><DisplayLabel>B' +
        'atch Number</DisplayLabel><Hidden>False</Hidden></Batchnumber><U' +
        'OM><Visible>True</Visible><Index>6</Index><DisplayWidth>16</Disp' +
        'layWidth><DisplayLabel>Units of ~Measure</DisplayLabel><Hidden>F' +
        'alse</Hidden></UOM><Classname><Visible>True</Visible><Index>5</I' +
        'ndex><DisplayWidth>14</DisplayWidth><DisplayLabel>Department~Nam' +
        'e</DisplayLabel><Hidden>False</Hidden></Classname><PartsDescript' +
        'ion><Visible>True</Visible><Index>4</Index><DisplayWidth>17</Dis' +
        'playWidth><DisplayLabel>Description</DisplayLabel><Hidden>False<' +
        '/Hidden></PartsDescription><ProductColumn3><Visible>True</Visibl' +
        'e><Index>3</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>D' +
        'ept</DisplayLabel><Hidden>False</Hidden></ProductColumn3><Produc' +
        'tColumn2><Visible>True</Visible><Index>2</Index><DisplayWidth>13' +
        '</DisplayWidth><DisplayLabel>Type</DisplayLabel><Hidden>False</H' +
        'idden></ProductColumn2><ProductColumn1><Visible>True</Visible><I' +
        'ndex>1</Index><DisplayWidth>13</DisplayWidth><DisplayLabel>Manuf' +
        'acture</DisplayLabel><Hidden>False</Hidden></ProductColumn1><Pro' +
        'ductName><Visible>True</Visible><Index>0</Index><DisplayWidth>21' +
        '</DisplayWidth><DisplayLabel>Product</DisplayLabel><Hidden>False' +
        '</Hidden></ProductName></Columns><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TStockQtysLocationsReportGUI>'#39', N' +
        'ULL, '#39'2008-11-05 11:38:26'#39');')
    Connection = MyConnection
    Objects = [doData]
    Options.GenerateHeader = False
    Options.AddDrop = False
    Options.CompleteInsert = True
    Left = 684
    Top = 64
  end
  object dbConn: TMyConnection
    Database = 'testpoints'
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Left = 200
    Top = 8
  end
  object dbDump: TMyDump
    Connection = dbConn
    Objects = [doData]
    Left = 256
    Top = 8
  end
  object MyDump2: TMyDump
    TableNames = 'tblpassword'
    Connection = dbConn
    Objects = [doData]
    Left = 464
    Top = 160
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    Left = 472
    Top = 200
  end
  object PME: TERPQuery
    Connection = MyConnection
    Left = 464
    Top = 264
  end
  object ERPScript1: TERPScript
    SQL.Strings = (
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `Blank1`   `' +
        'Blank1` varchar(17) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `Blank2`   `' +
        'Blank2` varchar(7) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `DirectEntry' +
        'UserName`   `DirectEntryUserName` varchar(26) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `DirectEntry' +
        'UserID`   `DirectEntryUserID` varchar(6) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `Transaction' +
        'Description`   `TransactionDescription` varchar(12) DEFAULT NULL' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `Blank3`   `' +
        'Blank3` varchar(39) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblabadescriptiverecord`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `BSB`   `BSB` var' +
        'char(7) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `CreditDebitAccou' +
        'ntNumber`   `CreditDebitAccountNumber` varchar(9) DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `AccountName`   `' +
        'AccountName` varchar(32) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `LodgementReferen' +
        'ces`   `LodgementReferences` varchar(18) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `UsersBSB`   `Use' +
        'rsBSB` varchar(7) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `UsersAccountNumb' +
        'er`   `UsersAccountNumber` varchar(9) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `NameofRemitter` ' +
        '  `NameofRemitter` varchar(16) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `AmountOfWithhold' +
        'ingTax`   `AmountOfWithholdingTax` varchar(8) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `TransType`   `Tr' +
        'ansType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `TransCodeDesc`  ' +
        ' `TransCodeDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      'ALTER TABLE `tblabadetailrecord`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblabatransactiondescriptions` CHANGE COLUMN `Globa' +
        'lRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblabatransactiondescriptions` CHANGE COLUMN `Descr' +
        'iption`   `Description` varchar(12) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblabatransactiondescriptions`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      
        'ALTER TABLE `tblabatranscode` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabatranscode` CHANGE COLUMN `TransCodeDescriptio' +
        'n`   `TransCodeDescription` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      'ALTER TABLE `tblabatranscode`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblability` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblability` CHANGE COLUMN `AbilityDesc`   `AbilityD' +
        'esc` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblability`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblaccountposting` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaccountposting` CHANGE COLUMN `SourceName`   `So' +
        'urceName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaccountposting` CHANGE COLUMN `Description`   `D' +
        'escription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaccountposting` CHANGE COLUMN `EmployeeName`   `' +
        'EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblaccountposting`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblaccountpostingdetail` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblaccountpostingdetail` CHANGE COLUMN `DeptClassNa' +
        'me`   `DeptClassName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblaccountpostingdetail` CHANGE COLUMN `AccountName' +
        '`   `AccountName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblaccountpostingdetail` CHANGE COLUMN `AccountType' +
        '`   `AccountType` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblaccountpostingdetail` CHANGE COLUMN `Description' +
        '`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblaccountpostingdetail`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblaccountsclasses` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaccountsclasses` CHANGE COLUMN `ClassName`   `Cl' +
        'assName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblaccountsclasses`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblacctypedesc` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblacctypedesc` CHANGE COLUMN `AccType`   `AccType`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblacctypedesc` CHANGE COLUMN `AccDesc`   `AccDesc`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblacctypedesc` CHANGE COLUMN `OriginalDesc`   `Ori' +
        'ginalDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblacctypedesc`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbladvimpcsvtabtempl` CHANGE COLUMN `TemplateName` ' +
        '  `TemplateName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbladvimpcsvtabtempl` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbladvimpcsvtabtempl`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbladvimpcsvtabtempllines` CHANGE COLUMN `FieldName' +
        '`   `FieldName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbladvimpcsvtabtempllines` CHANGE COLUMN `FieldType' +
        '`   `FieldType` varchar(40) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbladvimpcsvtabtempllines` CHANGE COLUMN `FieldDesc' +
        '`   `FieldDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbladvimpcsvtabtempllines` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbladvimpcsvtabtempllines`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblallowancebasedon` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblallowancebasedon` CHANGE COLUMN `BasedOn`   `Bas' +
        'edOn` varchar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblallowancebasedon`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblallowances` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblallowances` CHANGE COLUMN `Description`   `Descr' +
        'iption` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblallowances` CHANGE COLUMN `CalcBy`   `CalcBy` va' +
        'rchar(3) NOT NULL DEFAULT '#39'$'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblallowances` CHANGE COLUMN `AccountName`   `Accou' +
        'ntName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblallowances`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CancellationReason`' +
        '   `CancellationReason` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Contact`   `Contact' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Start_Time`   `Star' +
        't_Time` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Actual_Start_time` ' +
        '  `Actual_Start_time` varchar(50) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `End_Time`   `End_Ti' +
        'me` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Actual_End_time`   ' +
        '`Actual_End_time` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `TrainerCode`   `Tra' +
        'inerCode` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Notes`   `Notes` te' +
        'xt COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `FeedbackNotes`   `F' +
        'eedbackNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `ServiceDesc`   `Ser' +
        'viceDesc` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Othertxt`   `Othert' +
        'xt` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `MSRef`   `MSRef` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CustomerDetails`   ' +
        '`CustomerDetails` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Phone`   `Phone` va' +
        'rchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `AltPhone`   `AltPho' +
        'ne` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Fax`   `Fax` varcha' +
        'r(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Mobile`   `Mobile` ' +
        'varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `EnteredByEmployeeNa' +
        'me`   `EnteredByEmployeeName` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `Status`   `Status` ' +
        'varchar(255) DEFAULT '#39'N/A'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD1`   `CUSTFL' +
        'D1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD2`   `CUSTFL' +
        'D2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD3`   `CUSTFL' +
        'D3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD4`   `CUSTFL' +
        'D4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD5`   `CUSTFL' +
        'D5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD6`   `CUSTFL' +
        'D6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD7`   `CUSTFL' +
        'D7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD8`   `CUSTFL' +
        'D8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD9`   `CUSTFL' +
        'D9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD10`   `CUSTF' +
        'LD10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD11`   `CUSTF' +
        'LD11` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD12`   `CUSTF' +
        'LD12` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD13`   `CUSTF' +
        'LD13` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD14`   `CUSTF' +
        'LD14` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblappointments` CHANGE COLUMN `CUSTFLD15`   `CUSTF' +
        'LD15` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblappointments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblapprovallevels` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblapprovallevels` CHANGE COLUMN `ApprovalType`   `' +
        'ApprovalType` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblapprovallevels` CHANGE COLUMN `EmployeeName`   `' +
        'EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblapprovallevels` CHANGE COLUMN `EnteredByEmployee' +
        'Name`   `EnteredByEmployeeName` varchar(255) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      'ALTER TABLE `tblapprovallevels`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblapprovals` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblapprovals` CHANGE COLUMN `ApprovalType`   `Appro' +
        'valType` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblapprovals` CHANGE COLUMN `ApprovedRef`   `Approv' +
        'edRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblapprovals`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblatosubmissiondetails` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblatosubmissiondetails` CHANGE COLUMN `EmployeeNam' +
        'e`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblatosubmissiondetails` CHANGE COLUMN `Result`   `' +
        'Result` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblatosubmissiondetails`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblatosubmissions` CHANGE COLUMN `GLOBALREF`   `GLO' +
        'BALREF` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblatosubmissions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblattachments` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblattachments` CHANGE COLUMN `TableName`   `TableN' +
        'ame` varchar(40) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblattachments` CHANGE COLUMN `AttachmentName`   `A' +
        'ttachmentName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblattachments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblaudittrail` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaudittrail` CHANGE COLUMN `TransType`   `TransTy' +
        'pe` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaudittrail` CHANGE COLUMN `DataDescription`   `D' +
        'ataDescription` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblaudittrail` CHANGE COLUMN `ChangedFields`   `Cha' +
        'ngedFields` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblaudittrail` CHANGE COLUMN `TransGlobalref`   `Tr' +
        'ansGlobalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblaudittrail` CHANGE COLUMN `applicationVersion`  ' +
        ' `applicationVersion` varchar(20) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      'ALTER TABLE `tblaudittrail`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblawardadvance` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawardadvance` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblawardadvance`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblawardclassificationdetails` CHANGE COLUMN `Globa' +
        'lRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblawardclassificationdetails` CHANGE COLUMN `Class' +
        'ification`   `Classification` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblawardclassificationdetails` CHANGE COLUMN `Type`' +
        '   `Type` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawardclassificationdetails` CHANGE COLUMN `Advan' +
        'ceIDName`   `AdvanceIDName` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblawardclassificationdetails` CHANGE COLUMN `Advan' +
        'ceToClassification`   `AdvanceToClassification` varchar(255) DEF' +
        'AULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawardclassificationdetails`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      
        'ALTER TABLE `tblawards` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawards` CHANGE COLUMN `AwardName`   `AwardName` ' +
        'varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblawards`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblawardshifts` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblawardshifts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblawardsleave` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawardsleave` CHANGE COLUMN `Type`   `Type` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawardsleave` CHANGE COLUMN `AccrueAfterPeriod`  ' +
        ' `AccrueAfterPeriod` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblawardsleave` CHANGE COLUMN `AccruePeriod`   `Acc' +
        'ruePeriod` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblawardsleave`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Company`   `Company` ' +
        'varchar(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Title`   `Title` varc' +
        'har(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `First_Name`   `First_' +
        'Name` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Last_Name`   `Last_Na' +
        'me` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Address`   `Address` ' +
        'varchar(38) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Stree2`   `Stree2` va' +
        'rchar(38) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Suburb`   `Suburb` va' +
        'rchar(27) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Postcode`   `Postcode' +
        '` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Bill_Address`   `Bill' +
        '_Address` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Bill_Street_2`   `Bil' +
        'l_Street_2` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Bill_Suburb`   `Bill_' +
        'Suburb` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Bill_State`   `Bill_S' +
        'tate` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Bill_Postcode`   `Bil' +
        'l_Postcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Phone`   `Phone` varc' +
        'har(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Alt_Phone`   `Alt_Pho' +
        'ne` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Mobile`   `Mobile` va' +
        'rchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Fax`   `Fax` varchar(' +
        '20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Email`   `Email` varc' +
        'har(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Contact_1`   `Contact' +
        '_1` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Contact_2`   `Contact' +
        '_2` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Contact_1_Phone`   `C' +
        'ontact_1_Phone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Contact_2_Phone`   `C' +
        'ontact_2_Phone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `ABN`   `ABN` varchar(' +
        '15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Job_Name`   `Job_Name' +
        '` varchar(39) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `Filler`   `Filler` va' +
        'rchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblawordmerge`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbalancesheet` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbalancesheet` CHANGE COLUMN `AccountName`   `Acc' +
        'ountName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbalancesheet` CHANGE COLUMN `AccountNumber`   `A' +
        'ccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbalancesheet` CHANGE COLUMN `AccountType`   `Acc' +
        'ountType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbalancesheet` CHANGE COLUMN `Column1`   `Column1' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbalancesheet`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbankcodes` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankcodes` CHANGE COLUMN `BankName`   `BankName`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbankcodes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbankdeposit` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdeposit` CHANGE COLUMN `ClassName`   `ClassN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdeposit` CHANGE COLUMN `Notes`   `Notes` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbankdeposit`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `TrnsType`   `Tr' +
        'nsType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `PaymentMethod` ' +
        '  `PaymentMethod` varchar(70) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `CompanyName`   ' +
        '`CompanyName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `ReferenceNo`   ' +
        '`ReferenceNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `TransClassName`' +
        '   `TransClassName` varchar(50) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `AccountName`   ' +
        '`AccountName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `Name`   `Name` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankdepositlines` CHANGE COLUMN `Notes`   `Notes' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbankdepositlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbankdepositlinessales` CHANGE COLUMN `Globalref`' +
        '   `Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblbankdepositlinessales` CHANGE COLUMN `PaymentMet' +
        'hod`   `PaymentMethod` varchar(100) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblbankdepositlinessales`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblbarcodestoprint` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbarcodestoprint` CHANGE COLUMN `BatchNo`   `Batc' +
        'hNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbarcodestoprint`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `Tab1_Type`   `Tab1_Ty' +
        'pe` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `Tab1_Month`   `Tab1_M' +
        'onth` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `BasSheetDesc`   `BasS' +
        'heetDesc` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G1Selected`   `G1Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G2Selected`   `G2Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G3Selected`   `G3Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G4Selected`   `G4Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G7Selected`   `G7Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G10Selected`   `G10Se' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G11Selected`   `G11Se' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G13Selected`   `G13Se' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G14Selected`   `G14Se' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G15Selected`   `G15Se' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `G18Selected`   `G18Se' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `Tab2_Type`   `Tab2_Ty' +
        'pe` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `Tab2_Month`   `Tab2_M' +
        'onth` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `W1Selected`   `W1Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `W2Selected`   `W2Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `W3Selected`   `W3Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `W4Selected`   `W4Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `T1Selected`   `T1Sele' +
        'cted` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `T4`   `T4` varchar(25' +
        '5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `F4`   `F4` varchar(50' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `_1CSelected`   `_1CSe' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `_1DSelected`   `_1DSe' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `_1ESelected`   `_1ESe' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `_1FSelected`   `_1FSe' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `_1GSelected`   `_1GSe' +
        'lected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `Tab3_Type`   `Tab3_Ty' +
        'pe` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbasreports` CHANGE COLUMN `Tab3_Month`   `Tab3_M' +
        'onth` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbasreports`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `BatchName`   `BatchNa' +
        'me` varchar(40) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `PanelOrder`   `PanelO' +
        'rder` varchar(10) DEFAULT '#39'NULL'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `Attributes1`   `Attri' +
        'butes1` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `Attributes2`   `Attri' +
        'butes2` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `Attributes3`   `Attri' +
        'butes3` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `Attributes4`   `Attri' +
        'butes4` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbatchsaves` CHANGE COLUMN `Attributes5`   `Attri' +
        'butes5` longtext COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbatchsaves`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbudgetclass` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbudgetclass`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbudgetlines` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbudgetlines` CHANGE COLUMN `GloabalRef`   `Gloab' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbudgetlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbudgetperiodlines` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbudgetperiodlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbudgetperiods` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbudgetperiods` CHANGE COLUMN `Notes`   `Notes` t' +
        'ext COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbudgetperiods`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbudgets` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbudgets` CHANGE COLUMN `Name`   `Name` varchar(2' +
        '5) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbudgets` CHANGE COLUMN `Description`   `Descript' +
        'ion` varchar(50) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbudgets` CHANGE COLUMN `Amount1Label`   `Amount1' +
        'Label` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbudgets` CHANGE COLUMN `Amount2Label`   `Amount2' +
        'Label` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbudgets`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbuildpartalloc` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbuildpartalloc` CHANGE COLUMN `SerialNumber`   `' +
        'SerialNumber` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbuildpartalloc`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblbusobjexportprop` CHANGE COLUMN `BusinessObjectN' +
        'ame`   `BusinessObjectName` varchar(255) NOT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblbusobjexportprop` CHANGE COLUMN `PropertyName`  ' +
        ' `PropertyName` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblbusobjexportprop`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcallrecordings` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcallrecordings` CHANGE COLUMN `ClientName`   `Cl' +
        'ientName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcallrecordings` CHANGE COLUMN `Reference`   `Ref' +
        'erence` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcallrecordings` CHANGE COLUMN `Employee`   `Empl' +
        'oyee` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcallrecordings` CHANGE COLUMN `Extension`   `Ext' +
        'ension` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcallrecordings`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `CardHolderName`   `Card' +
        'HolderName` varchar(40) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `TxReference`   `TxRefer' +
        'ence` varchar(20) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `MerchantID`   `Merchant' +
        'ID` varchar(15) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `CardNumber`   `CardNumb' +
        'er` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `ExpiryDate`   `ExpiryDa' +
        'te` varchar(5) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `AuthID`   `AuthID` varc' +
        'har(6) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `TransType`   `TransType' +
        '` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcardfast`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcart_customer_ref` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcart_customer_ref`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcart_sales_ref` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcart_sales_ref`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `AccountName`   `' +
        'AccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `AccountType`   `' +
        'AccountType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Description`   `' +
        'Description` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `AccountNumber`  ' +
        ' `AccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Taxcode`   `Taxc' +
        'ode` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `BankNumber`   `B' +
        'ankNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Extra`   `Extra`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Class`   `Class`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `AccountGroup`   ' +
        '`AccountGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `BankAccountName`' +
        '   `BankAccountName` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Level1`   `Level' +
        '1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Level2`   `Level' +
        '2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Level3`   `Level' +
        '3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `Level4`   `Level' +
        '4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `APCANo`   `APCAN' +
        'o` varchar(6) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `BSB`   `BSB` var' +
        'char(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `BankAccountNumbe' +
        'r`   `BankAccountNumber` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      'ALTER TABLE `tblchartofaccounts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `ClassName`   `ClassName` v' +
        'archar(60) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `ClassGroup`   `ClassGroup`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Description`   `Descriptio' +
        'n` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `SubClassOf`   `SubClassOf`' +
        ' varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Level1`   `Level1` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Level2`   `Level2` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Level3`   `Level3` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Level4`   `Level4` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Street`   `Street` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Street2`   `Street2` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Street3`   `Street3` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Suburb`   `Suburb` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `State`   `State` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Postcode`   `Postcode` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `Country`   `Country` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblclass`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblclassificationallowances` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblclassificationallowances`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblclassificationdeductions`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblclassificationextrapayrates` CHANGE COLUMN `Glob' +
        'alRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblclassificationextrapayrates`  COLLATE='#39'utf8_gene' +
        'ral_ci'#39';'
      
        'ALTER TABLE `tblclientcareplan` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclientcareplan` CHANGE COLUMN `ServiceDesc`   `S' +
        'erviceDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblclientcareplan`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblclientphonesupport` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclientphonesupport` CHANGE COLUMN `Notes`   `Not' +
        'es` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblclientphonesupport`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Company`   `Company` var' +
        'char(160) CHARACTER SET utf8 DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `ABN`   `ABN` varchar(15)' +
        ' DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Title`   `Title` varchar' +
        '(32) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `FirstName`   `FirstName`' +
        ' varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `MiddleName`   `MiddleNam' +
        'e` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `LastName`   `LastName` v' +
        'archar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Position`   `Position` v' +
        'archar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Street`   `Street` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Street2`   `Street2` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Suburb`   `Suburb` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `State`   `State` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Country`   `Country` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Postcode`   `Postcode` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillStreet`   `BillStree' +
        't` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillStreet2`   `BillStre' +
        'et2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillSuburb`   `BillSubur' +
        'b` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillState`   `BillState`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillCountry`   `BillCoun' +
        'try` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillPostcode`   `BillPos' +
        'tcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `POBox`   `POBox` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `POSuburb`   `POSuburb` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `POState`   `POState` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `POCountry`   `POCountry`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `POPostcode`   `POPostcod' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Phone`   `Phone` varchar' +
        '(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `FaxNumber`   `FaxNumber`' +
        ' varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Mobile`   `Mobile` varch' +
        'ar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Email`   `Email` varchar' +
        '(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `AltContact`   `AltContac' +
        't` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `AltPhone`   `AltPhone` v' +
        'archar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Contact1`   `Contact1` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Contact2`   `Contact2` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Contact1Phone`   `Contac' +
        't1Phone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Contact2Phone`   `Contac' +
        't2Phone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Notes`   `Notes` text CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `ClientNo`   `ClientNo` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `TYPE`   `TYPE` varchar(5' +
        '0) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `TERMS`   `TERMS` varchar' +
        '(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `ShippingMethod`   `Shipp' +
        'ingMethod` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `JobName`   `JobName` var' +
        'char(79) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `JobRegistration`   `JobR' +
        'egistration` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD1` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD2` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD3` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD4` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD5` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD6` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD7` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD8` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD9` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD10`   `CUSTFLD10`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD11`   `CUSTFLD11`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD12`   `CUSTFLD12`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD13`   `CUSTFLD13`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD14`   `CUSTFLD14`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CUSTFLD15`   `CUSTFLD15`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `RepName`   `RepName` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CorrespondenceMethod`   ' +
        '`CorrespondenceMethod` varchar(30) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `AccountNo`   `AccountNo`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BankAccountName`   `Bank' +
        'AccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BankAccountBSB`   `BankA' +
        'ccountBSB` varchar(7) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BankAccountNo`   `BankAc' +
        'countNo` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `URL`   `URL` varchar(255' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CombinedInvoiceBOID`   `' +
        'CombinedInvoiceBOID` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CombinedPurchaseBOID`   ' +
        '`CombinedPurchaseBOID` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CombinedSaleOrderBOID`  ' +
        ' `CombinedSaleOrderBOID` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CardNumber`   `CardNumbe' +
        'r` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `DefaultClass`   `Default' +
        'Class` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `JobTitle`   `JobTitle` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Tasks`   `Tasks` text CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `SpecialInstructions`   `' +
        'SpecialInstructions` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `SerialNumber`   `SerialN' +
        'umber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `ModelNumber`   `ModelNum' +
        'ber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Manufacture`   `Manufact' +
        'ure` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `DeliveryNotes`   `Delive' +
        'ryNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `DefaultContactMethod`   ' +
        '`DefaultContactMethod` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CreditCardNumber`   `Cre' +
        'ditCardNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CreditCardExpiryDate`   ' +
        '`CreditCardExpiryDate` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CreditCardCardHolderName' +
        '`   `CreditCardCardHolderName` varchar(40) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CreditCardNotes`   `Cred' +
        'itCardNotes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CreditCardType`   `Credi' +
        'tCardType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `CustomerJobNumber`   `Cu' +
        'stomerJobNumber` varchar(20) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `EmailXML`   `EmailXML` v' +
        'archar(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `InvoiceComment`   `Invoi' +
        'ceComment` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `Street3`   `Street3` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BillStreet3`   `BillStre' +
        'et3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BPAYBillerCode`   `BPAYB' +
        'illerCode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BPAYReference`   `BPAYRe' +
        'ference` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `PortOfLanding`   `PortOf' +
        'Landing` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `PortOfDischarge`   `Port' +
        'OfDischarge` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `FinalDestination`   `Fin' +
        'alDestination` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `IncoPlace`   `IncoPlace`' +
        ' varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblclients`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblclientsotherphones` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclientsotherphones` CHANGE COLUMN `Phone`   `Pho' +
        'ne` varchar(20) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclientsotherphones` CHANGE COLUMN `Comment`   `C' +
        'omment` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblclientsotherphones`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblclienttoshipaddresslink` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblclienttoshipaddresslink`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblclienttype` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclienttype` CHANGE COLUMN `TypeName`   `TypeName' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclienttype` CHANGE COLUMN `TypeDescription`   `T' +
        'ypeDescription` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblclienttype` CHANGE COLUMN `DefaultPostAccount`  ' +
        ' `DefaultPostAccount` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      'ALTER TABLE `tblclienttype`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `FirstColumn`   `F' +
        'irstColumn` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `SecondColumnName`' +
        '   `SecondColumnName` varchar(50) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `ThirdColumnName` ' +
        '  `ThirdColumnName` varchar(50) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `PartColumnName`  ' +
        ' `PartColumnName` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `DefaultClass`   `' +
        'DefaultClass` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `ClassHeading`   `' +
        'ClassHeading` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `ComField1Name`   ' +
        '`ComField1Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `ComField2Name`   ' +
        '`ComField2Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `ComField3Name`   ' +
        '`ComField3Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `ComField4Name`   ' +
        '`ComField4Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblcolumnheadings`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcomments` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcomments` CHANGE COLUMN `Comments`   `Comments` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcomments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcommissionperiod` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcommissionperiod` CHANGE COLUMN `Period`   `Peri' +
        'od` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcommissionperiod`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcommissiontypes` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcommissiontypes` CHANGE COLUMN `CommissionDesc` ' +
        '  `CommissionDesc` varchar(50) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      'ALTER TABLE `tblcommissiontypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcommonquerylist` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcommonquerylist` CHANGE COLUMN `QueryGroup`   `Q' +
        'ueryGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcommonquerylist` CHANGE COLUMN `Name`   `Name` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcommonquerylist` CHANGE COLUMN `QueryText`   `Qu' +
        'eryText` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcommonquerylist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `CompanyName` ' +
        '  `CompanyName` varchar(200) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `TradingName` ' +
        '  `TradingName` varchar(200) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Address`   `A' +
        'ddress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Address2`   `' +
        'Address2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `City`   `City' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `State`   `Sta' +
        'te` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Postcode`   `' +
        'Postcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Country`   `C' +
        'ountry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ContactName` ' +
        '  `ContactName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ContactEmail`' +
        '   `ContactEmail` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `PhoneNumber` ' +
        '  `PhoneNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FaxNumber`   ' +
        '`FaxNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ABN`   `ABN` ' +
        'varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `CompanyNumber' +
        '`   `CompanyNumber` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POBox`   `POB' +
        'ox` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POBox2`   `PO' +
        'Box2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POCity`   `PO' +
        'City` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POState`   `P' +
        'OState` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POPostcode`  ' +
        ' `POPostcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POCountry`   ' +
        '`POCountry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FileReference' +
        '`   `FileReference` varchar(16) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `TaxSignatory`' +
        '   `TaxSignatory` varchar(38) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `BSB`   `BSB` ' +
        'varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `AccountNo`   ' +
        '`AccountNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FontCompanyNa' +
        'me`   `FontCompanyName` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FontAddress` ' +
        '  `FontAddress` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FontSuburb`  ' +
        ' `FontSuburb` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FontPhone`   ' +
        '`FontPhone` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FontABN`   `F' +
        'ontABN` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `FontDefault` ' +
        '  `FontDefault` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ColorCompanyN' +
        'ame`   `ColorCompanyName` varchar(50) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ColorAddress`' +
        '   `ColorAddress` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ColorSuburb` ' +
        '  `ColorSuburb` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ColorPhone`  ' +
        ' `ColorPhone` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ColorABN`   `' +
        'ColorABN` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `ColorDefault`' +
        '   `ColorDefault` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `StyleCompanyN' +
        'ame`   `StyleCompanyName` varchar(4) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `StyleAddress`' +
        '   `StyleAddress` varchar(4) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `StyleSuburb` ' +
        '  `StyleSuburb` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `StylePhone`  ' +
        ' `StylePhone` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `StyleABN`   `' +
        'StyleABN` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `StyleDefault`' +
        '   `StyleDefault` varchar(4) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `BankBranch`  ' +
        ' `BankBranch` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `APCANo`   `AP' +
        'CANo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Email`   `Ema' +
        'il` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `URL`   `URL` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `DocumentTempl' +
        'atePath`   `DocumentTemplatePath` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Contact`   `C' +
        'ontact` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `SupplierId`  ' +
        ' `SupplierId` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `DVAABN`   `DV' +
        'AABN` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPloginID`  ' +
        ' `RAPloginID` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPPassword` ' +
        '  `RAPPassword` varchar(100) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPLoginPage`' +
        '   `RAPLoginPage` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPProgramNam' +
        'e`   `RAPProgramName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPInvoiceDes' +
        'cription`   `RAPInvoiceDescription` varchar(255) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPProductGro' +
        'up`   `RAPProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `RAPContractNu' +
        'mber`   `RAPContractNumber` varchar(100) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `Address3`   `' +
        'Address3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcompanyinformation` CHANGE COLUMN `POBox3`   `PO' +
        'Box3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcompanyinformation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `Company`   `Company` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactTitle`   `Contac' +
        'tTitle` varchar(32) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactFirstName`   `Co' +
        'ntactFirstName` varchar(30) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactSurName`   `Cont' +
        'actSurName` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactAddress`   `Cont' +
        'actAddress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactAddress2`   `Con' +
        'tactAddress2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactAddress3`   `Con' +
        'tactAddress3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactCity`   `Contact' +
        'City` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactState`   `Contac' +
        'tState` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactPcode`   `Contac' +
        'tPcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactCountry`   `Cont' +
        'actCountry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactPH`   `ContactPH' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactAltPH`   `Contac' +
        'tAltPH` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactMOB`   `ContactM' +
        'OB` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactFax`   `ContactF' +
        'ax` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `ContactEmail`   `Contac' +
        'tEmail` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `Notes`   `Notes` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `CardNumber`   `CardNumb' +
        'er` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `AccountNo`   `AccountNo' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `JobTitle`   `JobTitle` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeInComputerIPAddres' +
        's`   `LogMeInComputerIPAddress` varchar(20) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeInEmailPassword`  ' +
        ' `LogMeInEmailPassword` varchar(100) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeInUserName`   `Log' +
        'MeInUserName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeInPassword`   `Log' +
        'MeInPassword` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeInERPUserName`   `' +
        'LogMeInERPUserName` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeInERPPassword`   `' +
        'LogMeInERPPassword` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblcontacts` CHANGE COLUMN `LogMeIncomputerPassword' +
        '`   `LogMeIncomputerPassword` varchar(100) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      'ALTER TABLE `tblcontacts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcontrols` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcontrols` CHANGE COLUMN `ControlName`   `Control' +
        'Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcontrols`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcostcentre` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcostcentre` CHANGE COLUMN `CostCentreName`   `Co' +
        'stCentreName` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblcostcentre` CHANGE COLUMN `CostCentreDescription' +
        '`   `CostCentreDescription` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      'ALTER TABLE `tblcostcentre`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcountries` CHANGE COLUMN `Country`   `Country` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcountries` CHANGE COLUMN `CurrencyDesc`   `Curre' +
        'ncyDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcountries`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcourse` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcourse`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcurrencyconversion` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcurrencyconversion` CHANGE COLUMN `Country`   `C' +
        'ountry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcurrencyconversion` CHANGE COLUMN `Currency`   `' +
        'Currency` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcurrencyconversion` CHANGE COLUMN `CurrencySymbo' +
        'l`   `CurrencySymbol` varchar(3) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      'ALTER TABLE `tblcurrencyconversion`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcurrencyconversionhistory` CHANGE COLUMN `Global' +
        'Ref`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblcurrencyconversionhistory`  COLLATE='#39'utf8_genera' +
        'l_ci'#39';'
      
        'ALTER TABLE `tblcustomcharts` CHANGE COLUMN `ChartName`   `Chart' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomcharts` CHANGE COLUMN `ReportClassName`   ' +
        '`ReportClassName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblcustomcharts` CHANGE COLUMN `X_LabelsField`   `X' +
        '_LabelsField` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcustomcharts` CHANGE COLUMN `X_ChartedField`   `' +
        'X_ChartedField` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcustomcharts` CHANGE COLUMN `Y_ChartedField`   `' +
        'Y_ChartedField` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcustomcharts` CHANGE COLUMN `Z_ChartedField`   `' +
        'Z_ChartedField` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblcustomcharts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomercoststransfer` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcustomercoststransfer` CHANGE COLUMN `CustomerFr' +
        'omName`   `CustomerFromName` varchar(255) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblcustomercoststransfer` CHANGE COLUMN `EmployeeNa' +
        'me`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblcustomercoststransfer` CHANGE COLUMN `Notes`   `' +
        'Notes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomercoststransfer`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblcustomercoststransferdetails` CHANGE COLUMN `Glo' +
        'balRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblcustomercoststransferdetails`  COLLATE='#39'utf8_gen' +
        'eral_ci'#39';'
      
        'ALTER TABLE `tblcustomercoststransferlines` CHANGE COLUMN `Globa' +
        'lRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblcustomercoststransferlines` CHANGE COLUMN `Custo' +
        'merToName`   `CustomerToName` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomercoststransferlines` CHANGE COLUMN `Produ' +
        'ctName`   `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblcustomercoststransferlines` CHANGE COLUMN `Descr' +
        'iption`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblcustomercoststransferlines`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `Notes`   `Notes` t' +
        'ext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `EquipName`   `Equi' +
        'pName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `Manufacture`   `Ma' +
        'nufacture` varchar(100) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `model`   `model` v' +
        'archar(100) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `Serialno`   `Seria' +
        'lno` varchar(100) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `Registration`   `R' +
        'egistration` varchar(100) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblcustomerequip` CHANGE COLUMN `UOM`   `UOM` varch' +
        'ar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomerequip`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomerjobcards` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerjobcards` CHANGE COLUMN `Notes`   `Notes' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomerjobcards`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomerlines` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerlines` CHANGE COLUMN `Name`   `Name` var' +
        'char(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerlines` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomerlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomerservices` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomerservices`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomerservicesratings` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblcustomerservicesratings` CHANGE COLUMN `RatingDe' +
        'sc`   `RatingDesc` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblcustomerservicesratings`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblcustomerskills` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomerskills` CHANGE COLUMN `SkillName`   `Ski' +
        'llName` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomerskills`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomfielddropdowns` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblcustomfielddropdowns` CHANGE COLUMN `Text`   `Te' +
        'xt` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfielddropdowns`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel1`   `CFLabe' +
        'l1` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel2`   `CFLabe' +
        'l2` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel3`   `CFLabe' +
        'l3` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel4`   `CFLabe' +
        'l4` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel5`   `CFLabe' +
        'l5` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel6`   `CFLabe' +
        'l6` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel7`   `CFLabe' +
        'l7` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel8`   `CFLabe' +
        'l8` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel9`   `CFLabe' +
        'l9` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel10`   `CFLab' +
        'el10` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel11`   `CFLab' +
        'el11` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel12`   `CFLab' +
        'el12` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel13`   `CFLab' +
        'el13` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel14`   `CFLab' +
        'el14` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel15`   `CFLab' +
        'el15` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel16`   `CFLab' +
        'el16` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel17`   `CFLab' +
        'el17` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfields` CHANGE COLUMN `CFLabel18`   `CFLab' +
        'el18` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomfields`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomfilters` CHANGE COLUMN `FilterName`   `Fil' +
        'terName` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfilters` CHANGE COLUMN `ReportName`   `Rep' +
        'ortName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomfilters` CHANGE COLUMN `FilterStatement`  ' +
        ' `FilterStatement` longtext NOT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblcustomfilters`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `ClassName`   `Cl' +
        'assName` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `AltRowColor`   `' +
        'AltRowColor` varchar(15) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `ViewableFields` ' +
        '  `ViewableFields` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `FontDetails`   `' +
        'FontDetails` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `ColumnsOrder`   ' +
        '`ColumnsOrder` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `Report`   `Repor' +
        't` varchar(40) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `ReportTab`   `Re' +
        'portTab` varchar(40) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblcustomizedlists` CHANGE COLUMN `ListMode`   `Lis' +
        'tMode` varchar(255) NOT NULL DEFAULT '#39'Full List'#39' COLLATE utf8_ge' +
        'neral_ci ;'
      'ALTER TABLE `tblcustomizedlists`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldailyworkrecord` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldailyworkrecord` CHANGE COLUMN `Zone`   `Zone` v' +
        'archar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldailyworkrecord`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '1`   `CustomField1` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '2`   `CustomField2` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '3`   `CustomField3` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '4`   `CustomField4` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '5`   `CustomField5` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '6`   `CustomField6` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '7`   `CustomField7` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '8`   `CustomField8` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '9`   `CustomField9` varchar(25) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `CustomField' +
        '10`   `CustomField10` varchar(25) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `AUSStandard' +
        '`   `AUSStandard` varchar(25) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `Comments`  ' +
        ' `Comments` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines` CHANGE COLUMN `DownTimeRea' +
        'son`   `DownTimeReason` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tbldailyworkrecordlines`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tbldbpreferences` CHANGE COLUMN `PrefType`   `PrefT' +
        'ype` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldbpreferences` CHANGE COLUMN `Name`   `Name` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldbpreferences` CHANGE COLUMN `FieldType`   `Fiel' +
        'dType` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldbpreferences` CHANGE COLUMN `FieldValue`   `Fie' +
        'ldValue` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldbpreferences` CHANGE COLUMN `DefaultValue`   `D' +
        'efaultValue` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldbpreferences` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldbpreferences`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldeductions` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeductions` CHANGE COLUMN `Description`   `Descr' +
        'iption` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeductions` CHANGE COLUMN `CalcBy`   `CalcBy` va' +
        'rchar(3) NOT NULL DEFAULT '#39'$'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeductions` CHANGE COLUMN `AccountName`   `Accou' +
        'ntName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldeductions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldefaultrunparts` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldefaultrunparts` CHANGE COLUMN `ProductName`   `' +
        'ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldefaultrunparts` CHANGE COLUMN `TaxCode`   `TaxC' +
        'ode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldefaultrunparts` CHANGE COLUMN `FreqType`   `Fre' +
        'qType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldefaultrunparts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldepositline` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldepositline` CHANGE COLUMN `TrnType`   `TrnType`' +
        ' varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldepositline` CHANGE COLUMN `InvoiceNo`   `Invoic' +
        'eNo` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldepositline` CHANGE COLUMN `PaidInFull`   `PaidI' +
        'nFull` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldepositline` CHANGE COLUMN `RefNo`   `RefNo` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldepositline` CHANGE COLUMN `EnteredBy`   `Entere' +
        'dBy` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldepositline`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `Notes`   `Notes` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `ReferenceNo`   `Referen' +
        'ceNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `CardholdersName`   `Car' +
        'dholdersName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `CreditCardNumber`   `Cr' +
        'editCardNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `CompanyName`   `Company' +
        'Name` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `BankAccountName`   `Ban' +
        'kAccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `BankAccountBSB`   `Bank' +
        'AccountBSB` varchar(7) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `BankAccountNo`   `BankA' +
        'ccountNo` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldeposits`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `ClientName`   `' +
        'ClientName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `Address`   `Add' +
        'ress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `Phone`   `Phone' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `Mobile`   `Mobi' +
        'le` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `Company`   `Com' +
        'pany` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `ProductName`   ' +
        '`ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `TaxCode`   `Tax' +
        'Code` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `PaymentMethodNa' +
        'me`   `PaymentMethodName` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `PreferedSupp`  ' +
        ' `PreferedSupp` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `FreqType`   `Fr' +
        'eqType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `Reference`   `R' +
        'eference` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldespatchrunlines` CHANGE COLUMN `DeliveryDocket`' +
        '   `DeliveryDocket` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      'ALTER TABLE `tbldespatchrunlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldiagramoptions` CHANGE COLUMN `ListType`   `List' +
        'Type` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldiagramoptions` CHANGE COLUMN `GraphType`   `Gra' +
        'phType` varchar(255) DEFAULT '#39'Bar'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldiagramoptions` CHANGE COLUMN `Label`   `Label` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldiagramoptions` CHANGE COLUMN `XAxis`   `XAxis` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldiagramoptions` CHANGE COLUMN `YAxis`   `YAxis` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldiagramoptions` CHANGE COLUMN `Name`   `Name` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldiagramoptions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldirty` CHANGE COLUMN `siteCode`   `siteCode` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldirty` CHANGE COLUMN `ConflictMsg`   `ConflictMs' +
        'g` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldirty`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbldocpath` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldocpath` CHANGE COLUMN `DocumentPath`   `Documen' +
        'tPath` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldocpath` CHANGE COLUMN `PosPath`   `PosPath` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbldocpath`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemailedreports` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreports` CHANGE COLUMN `UserID`   `UserID' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreports` CHANGE COLUMN `ReportType`   `Re' +
        'portType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreports` CHANGE COLUMN `TransactionDescri' +
        'ption`   `TransactionDescription` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreports` CHANGE COLUMN `Status`   `Status' +
        '` varchar(255) DEFAULT '#39'Success'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreports` CHANGE COLUMN `EmailAddressUsed`' +
        '   `EmailAddressUsed` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      'ALTER TABLE `tblemailedreports`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemailedreportsschedule` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblemailedreportsschedule` CHANGE COLUMN `ReportNam' +
        'e`   `ReportName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblemailedreportsschedule` CHANGE COLUMN `Mode`   `' +
        'Mode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreportsschedule` CHANGE COLUMN `DateRange' +
        'Mode`   `DateRangeMode` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblemailedreportsschedule` CHANGE COLUMN `Emails`  ' +
        ' `Emails` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailedreportsschedule`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `EmailTo`   `EmailTo` ' +
        'varchar(150) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `EmailFrom`   `EmailFr' +
        'om` varchar(150) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `EmailSubject`   `Emai' +
        'lSubject` varchar(150) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `EmailBody`   `EmailBo' +
        'dy` longtext NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `EmailCC`   `EmailCC` ' +
        'varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `EmailBCC`   `EmailBCC' +
        '` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `UserName`   `UserName' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemailqueue` CHANGE COLUMN `Password`   `Password' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemailqueue`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeeallowances` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeallowances` CHANGE COLUMN `Allowance`   ' +
        '`Allowance` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeallowances` CHANGE COLUMN `CalcBy`   `Ca' +
        'lcBy` varchar(3) NOT NULL DEFAULT '#39'$'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeallowances` CHANGE COLUMN `ClassName`   ' +
        '`ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeeallowances`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeecommission` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeecommission`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeedeductions` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeedeductions` CHANGE COLUMN `Deduction`   ' +
        '`Deduction` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeedeductions` CHANGE COLUMN `Notes`   `Not' +
        'es` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeedeductions` CHANGE COLUMN `CalcBy`   `Ca' +
        'lcBy` varchar(3) NOT NULL DEFAULT '#39'$'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeedeductions` CHANGE COLUMN `ClassName`   ' +
        '`ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeedeductions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeefa` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeefa` CHANGE COLUMN `AssetName`   `AssetNa' +
        'me` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeefa`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeeformsaccess` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeeformsaccess`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeegridsettings` CHANGE COLUMN `Owner`   `O' +
        'wner` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeegridsettings` CHANGE COLUMN `FieldList` ' +
        '  `FieldList` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeegridsettings` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblemployeegridsettings` CHANGE COLUMN `ControlName' +
        '`   `ControlName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblemployeegridsettings`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblemployeepayrates` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeepayrates` CHANGE COLUMN `ClassName`   `C' +
        'lassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeepayrates`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeepaysettings` CHANGE COLUMN `UKTaxCode`  ' +
        ' `UKTaxCode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeepaysettings` CHANGE COLUMN `UKNINO`   `U' +
        'KNINO` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblemployeepaysettings` CHANGE COLUMN `EmployeePayN' +
        'otes`   `EmployeePayNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeepaysettings` CHANGE COLUMN `NICTableLett' +
        'er`   `NICTableLetter` varchar(8) DEFAULT '#39'A'#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblemployeepaysettings` CHANGE COLUMN `IRPR`   `IRP' +
        'R` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeepaysettings`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeepics` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeepics`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeeprocesssteps` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblemployeeprocesssteps` CHANGE COLUMN `EmployeeNam' +
        'e`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblemployeeprocesssteps` CHANGE COLUMN `ProcessStep' +
        '`   `ProcessStep` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblemployeeprocesssteps`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Title`   `Title` varch' +
        'ar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `FirstName`   `FirstNam' +
        'e` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `MiddleName`   `MiddleN' +
        'ame` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `LastName`   `LastName`' +
        ' varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Street`   `Street` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Street2`   `Street2` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Suburb`   `Suburb` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Postcode`   `Postcode`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `State`   `State` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Country`   `Country` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Phone`   `Phone` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `AltPhone`   `AltPhone`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `FaxNumber`   `FaxNumbe' +
        'r` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Mobile`   `Mobile` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Email`   `Email` varch' +
        'ar(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `AltContact`   `AltCont' +
        'act` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Company`   `Company` v' +
        'archar(35) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Position`   `Position`' +
        ' varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `ABN`   `ABN` varchar(1' +
        '5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Notes`   `Notes` text ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD1`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD2`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD3`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD4`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD5`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD6`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD7`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD8`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD9`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD10`   `CUSTFLD1' +
        '0` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD11`   `CUSTFLD1' +
        '1` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD12`   `CUSTFLD1' +
        '2` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD13`   `CUSTFLD1' +
        '3` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD14`   `CUSTFLD1' +
        '4` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `CUSTFLD15`   `CUSTFLD1' +
        '5` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `TFN`   `TFN` varchar(9' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Sex`   `Sex` varchar(3' +
        '2) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `RepCode`   `RepCode` v' +
        'archar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `EmployeeName`   `Emplo' +
        'yeeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Classification`   `Cla' +
        'ssification` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `NextOfKin`   `NextOfKi' +
        'n` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `NextOfKinRelationship`' +
        '   `NextOfKinRelationship` varchar(100) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `NextOfKinPhone`   `Nex' +
        'tOfKinPhone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `PayNotes`   `PayNotes`' +
        ' text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `AreaRange`   `AreaRang' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `DefaultClassName`   `D' +
        'efaultClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Street3`   `Street3` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `WorkPhone`   `WorkPhon' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployees`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeeskills` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeskills` CHANGE COLUMN `SkillName`   `Ski' +
        'llName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeskills` CHANGE COLUMN `ProviderName`   `' +
        'ProviderName` varchar(100) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeskills` CHANGE COLUMN `Certificate`   `C' +
        'ertificate` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeskills` CHANGE COLUMN `Comments`   `Comm' +
        'ents` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeeskills`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeesundries` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeesundries`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblemployeeterminations` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblemployeeterminations` CHANGE COLUMN `EmployeeNam' +
        'e`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblemployeeterminations` CHANGE COLUMN `TypeOfDeath' +
        'Benefit`   `TypeOfDeathBenefit` varchar(64) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeterminations` CHANGE COLUMN `ReasonLeft`' +
        '   `ReasonLeft` varchar(32) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblemployeeterminations` CHANGE COLUMN `OtherPaymen' +
        'tType`   `OtherPaymentType` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblemployeeterminations` CHANGE COLUMN `Data`   `Da' +
        'ta` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeeterminations`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblemployeetypes` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblemployeetypes` CHANGE COLUMN `TypeName`   `TypeN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblemployeetypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblempnocommsproducts` CHANGE COLUMN `Globalref`   ' +
        '`Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblempnocommsproducts` CHANGE COLUMN `ProductName` ' +
        '  `ProductName` varchar(100) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblempnocommsproducts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblequipment` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipment` CHANGE COLUMN `EquipmentName`   `Equi' +
        'pmentName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipment` CHANGE COLUMN `EquipmentDescription` ' +
        '  `EquipmentDescription` varchar(100) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblequipment` CHANGE COLUMN `Manufacture`   `Manufa' +
        'cture` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipment` CHANGE COLUMN `Model`   `Model` varch' +
        'ar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblequipment`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblequipmentparts` CHANGE COLUMN `Globalref`   `Glo' +
        'balref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentparts` CHANGE COLUMN `Equipmentname`   ' +
        '`Equipmentname` varchar(100) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblequipmentparts` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentparts` CHANGE COLUMN `PARTSDESCRIPTION`' +
        '   `PARTSDESCRIPTION` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      'ALTER TABLE `tblequipmentparts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblequipmentservice` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentservice` CHANGE COLUMN `ItemName`   `It' +
        'emName` varchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentservice` CHANGE COLUMN `Notes`   `Notes' +
        '` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentservice` CHANGE COLUMN `Custom1`   `Cus' +
        'tom1` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentservice` CHANGE COLUMN `Custom2`   `Cus' +
        'tom2` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentservice` CHANGE COLUMN `ItemCode`   `It' +
        'emCode` varchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblequipmentservice`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblequipmentservicecosts` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblequipmentservicecosts` CHANGE COLUMN `Provider` ' +
        '  `Provider` varchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentservicecosts` CHANGE COLUMN `PartDescri' +
        'ption`   `PartDescription` varchar(64) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblequipmentservicecosts`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `Notes`   `Notes` v' +
        'archar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `Code`   `Code` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField1`   `C' +
        'ustomField1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField2`   `C' +
        'ustomField2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField3`   `C' +
        'ustomField3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField4`   `C' +
        'ustomField4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField5`   `C' +
        'ustomField5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField6`   `C' +
        'ustomField6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField7`   `C' +
        'ustomField7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField8`   `C' +
        'ustomField8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField9`   `C' +
        'ustomField9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `CustomField10`   `' +
        'CustomField10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblequipmentxref` CHANGE COLUMN `UOM`   `UOM` varch' +
        'ar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblequipmentxref`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step1Caption`   `Step1C' +
        'aption` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step1VideoFilename`   `' +
        'Step1VideoFilename` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step2Caption`   `Step2C' +
        'aption` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step2VideoFilename`   `' +
        'Step2VideoFilename` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step3Caption`   `Step3C' +
        'aption` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step3VideoFilename`   `' +
        'Step3VideoFilename` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step4Caption`   `Step4C' +
        'aption` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step4VideoFilename`   `' +
        'Step4VideoFilename` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step5Caption`   `Step5C' +
        'aption` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step5VideoFilename`   `' +
        'Step5VideoFilename` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step6Caption`   `Step6C' +
        'aption` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Step6VideoFilename`   `' +
        'Step6VideoFilename` varchar(100) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `TrainingStep1Caption`  ' +
        ' `TrainingStep1Caption` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Trainingstep1VideoFilen' +
        'ame`   `Trainingstep1VideoFilename` varchar(100) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `TrainingStep2Caption`  ' +
        ' `TrainingStep2Caption` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Trainingstep2VideoFilen' +
        'ame`   `Trainingstep2VideoFilename` varchar(100) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `TrainingStep3Caption`  ' +
        ' `TrainingStep3Caption` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Trainingstep3VideoFilen' +
        'ame`   `Trainingstep3VideoFilename` varchar(100) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `TrainingStep4Caption`  ' +
        ' `TrainingStep4Caption` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Trainingstep4VideoFilen' +
        'ame`   `Trainingstep4VideoFilename` varchar(100) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `TrainingStep5Caption`  ' +
        ' `TrainingStep5Caption` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Trainingstep5VideoFilen' +
        'ame`   `Trainingstep5VideoFilename` varchar(100) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `TrainingStep6Caption`  ' +
        ' `TrainingStep6Caption` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblerpsetup` CHANGE COLUMN `Trainingstep6VideoFilen' +
        'ame`   `Trainingstep6VideoFilename` varchar(100) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      'ALTER TABLE `tblerpsetup`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbleucountries` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbleucountries` CHANGE COLUMN `CountryName`   `Coun' +
        'tryName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbleucountries` CHANGE COLUMN `Code`   `Code` varch' +
        'ar(8) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbleucountries`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblexportobjectlist` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexportobjectlist` CHANGE COLUMN `Description`   ' +
        '`Description` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexportobjectlist` CHANGE COLUMN `ObjectName`   `' +
        'ObjectName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblexportobjectlist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblexporttables` CHANGE COLUMN `TableName`   `Table' +
        'Name` varchar(255) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblexporttables` CHANGE COLUMN `SQLStatement`   `SQ' +
        'LStatement` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexporttables` CHANGE COLUMN `TableDescription`  ' +
        ' `TableDescription` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblexporttables`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblexporttopdt` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexporttopdt` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexporttopdt` CHANGE COLUMN `FileName`   `FileNam' +
        'e` varchar(40) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexporttopdt` CHANGE COLUMN `Query`   `Query` tex' +
        't NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblexporttopdt` CHANGE COLUMN `HeaderString`   `Hea' +
        'derString` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblexporttopdt`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblextraprice` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblextraprice` CHANGE COLUMN `PartName`   `PartName' +
        '` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblextraprice` CHANGE COLUMN `SupplierProductCode` ' +
        '  `SupplierProductCode` varchar(50) NOT NULL DEFAULT '#39#39' COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblextraprice` CHANGE COLUMN `SupplierProductName` ' +
        '  `SupplierProductName` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblextraprice` CHANGE COLUMN `UOM`   `UOM` varchar(' +
        '100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblextraprice`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblextrapricesell` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblextrapricesell` CHANGE COLUMN `ExtraSellDesc`   ' +
        '`ExtraSellDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblextrapricesell` CHANGE COLUMN `UOM`   `UOM` varc' +
        'har(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblextrapricesell`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfaxdispatchers` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxdispatchers` CHANGE COLUMN `FaxName`   `FaxNa' +
        'me` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxdispatchers` CHANGE COLUMN `ComputerName`   `' +
        'ComputerName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblfaxdispatchers`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `EmployeeName`   `Employ' +
        'eeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `ClientName`   `ClientNa' +
        'me` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `FaxNumber`   `FaxNumber' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `TransType`   `TransType' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `TransGlobal`   `TransGl' +
        'obal` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `Description`   `Descrip' +
        'tion` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `Status`   `Status` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfaxspool` CHANGE COLUMN `CoverSheetNotes`   `Cov' +
        'erSheetNotes` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfaxspool`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfaxspooldocs` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfaxspooldocs`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfbt` CHANGE COLUMN `GlobalRef`   `GlobalRef` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfbt` CHANGE COLUMN `Notes`   `Notes` varchar(150' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfbt` CHANGE COLUMN `ClassName`   `ClassName` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfbt`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfeformula` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfeformula` CHANGE COLUMN `FormulaName`   `Formul' +
        'aName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfeformula` CHANGE COLUMN `Formula`   `Formula` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfeformula`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfenames` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfenames` CHANGE COLUMN `FormulaEntryName`   `For' +
        'mulaEntryName` varchar(50) NOT NULL DEFAULT '#39#39' COLLATE utf8_gene' +
        'ral_ci ;'
      'ALTER TABLE `tblfenames`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfesaleslines` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfesaleslines` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfesaleslines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfesaleslinesrelatedprs` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblfesaleslinesrelatedprs` CHANGE COLUMN `Formula` ' +
        '  `Formula` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfesaleslinesrelatedprs` CHANGE COLUMN `ProductNa' +
        'me`   `ProductName` varchar(60) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblfesaleslinesrelatedprs`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblfixedassetlabelstoprint` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblfixedassetlabelstoprint`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblfixedassetpercentages` CHANGE COLUMN `Descriptio' +
        'n`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblfixedassetpercentages` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblfixedassetpercentages` CHANGE COLUMN `ClassName`' +
        '   `ClassName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblfixedassetpercentages`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `AssetCode`   `AssetC' +
        'ode` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `AssetName`   `AssetN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `AssetType`   `AssetT' +
        'ype` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `LocationDescription`' +
        '   `LocationDescription` varchar(100) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `BrandName`   `BrandN' +
        'ame` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Manufacture`   `Manu' +
        'facture` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Model`   `Model` var' +
        'char(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Serial`   `Serial` v' +
        'archar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Notes`   `Notes` tex' +
        't COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `AssetCondition`   `A' +
        'ssetCondition` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Colour`   `Colour` v' +
        'archar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Size`   `Size` varch' +
        'ar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Shape`   `Shape` var' +
        'char(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `Status`   `Status` v' +
        'archar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `WarrantyType`   `War' +
        'rantyType` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `InsuredBy`   `Insure' +
        'dBy` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `InsurancePolicy`   `' +
        'InsurancePolicy` varchar(100) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD' +
        '1` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD' +
        '2` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD' +
        '3` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD' +
        '4` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD' +
        '5` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD' +
        '6` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD' +
        '7` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD' +
        '8` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD' +
        '9` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD10`   `CUSTFL' +
        'D10` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD11`   `CUSTFL' +
        'D11` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD12`   `CUSTFL' +
        'D12` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD13`   `CUSTFL' +
        'D13` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD14`   `CUSTFL' +
        'D14` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `CUSTFLD15`   `CUSTFL' +
        'D15` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `PriorAccumDeprecDate' +
        '`   `PriorAccumDeprecDate` varchar(4) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `FixedAssetCostAccoun' +
        'tName`   `FixedAssetCostAccountName` varchar(255) DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `ClearingAccountName`' +
        '   `ClearingAccountName` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `PARTNAME`   `PARTNAM' +
        'E` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `FixedAssetDepreciati' +
        'onAccountName`   `FixedAssetDepreciationAccountName` varchar(255' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `SupplierName`   `Sup' +
        'plierName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `BARCODE`   `BARCODE`' +
        ' varchar(35) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `PriorAccumDeprecDate' +
        '2`   `PriorAccumDeprecDate2` varchar(4) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `FixedAssetCostAccoun' +
        'tName2`   `FixedAssetCostAccountName2` varchar(255) DEFAULT NULL' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `ClearingAccountName2' +
        '`   `ClearingAccountName2` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `FixedAssetDepreciati' +
        'onAccountName2`   `FixedAssetDepreciationAccountName2` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `FixedAssetDepreciati' +
        'onAssetAccountName`   `FixedAssetDepreciationAssetAccountName` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassets` CHANGE COLUMN `FixedAssetDepreciati' +
        'onAssetAccountName2`   `FixedAssetDepreciationAssetAccountName2`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfixedassets`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails` CHANGE COLUMN `G' +
        'lobalRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails` CHANGE COLUMN `Y' +
        'ear`   `Year` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails` CHANGE COLUMN `M' +
        'onth`   `Month` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails`  COLLATE='#39'utf8_g' +
        'eneral_ci'#39';'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails2` CHANGE COLUMN `' +
        'GlobalRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails2` CHANGE COLUMN `' +
        'Year`   `Year` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails2` CHANGE COLUMN `' +
        'Month`   `Month` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblfixedassetsdepreciationdetails2`  COLLATE='#39'utf8_' +
        'general_ci'#39';'
      
        'ALTER TABLE `tblfixedassetservicelog` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblfixedassetservicelog` CHANGE COLUMN `AssetCode` ' +
        '  `AssetCode` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassetservicelog` CHANGE COLUMN `AssetName` ' +
        '  `AssetName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblfixedassetservicelog` CHANGE COLUMN `ServiceProv' +
        'ider`   `ServiceProvider` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblfixedassetservicelog` CHANGE COLUMN `ServiceNote' +
        's`   `ServiceNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassetservicelog`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblfixedassettypes` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfixedassettypes` CHANGE COLUMN `AssetTypeCode`  ' +
        ' `AssetTypeCode` varchar(50) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblfixedassettypes` CHANGE COLUMN `AssetTypeName`  ' +
        ' `AssetTypeName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblfixedassettypes` CHANGE COLUMN `Notes`   `Notes`' +
        ' text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfixedassettypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblforeigncurrencyfieldsonreport` CHANGE COLUMN `Am' +
        'ountfieldName`   `AmountfieldName` varchar(255) DEFAULT NULL COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tblforeigncurrencyfieldsonreport` CHANGE COLUMN `Am' +
        'ountCaption`   `AmountCaption` varchar(255) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblforeigncurrencyfieldsonreport`  COLLATE='#39'utf8_ge' +
        'neral_ci'#39';'
      
        'ALTER TABLE `tblforeigncurrencyonreport` CHANGE COLUMN `ListName' +
        '`   `ListName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblforeigncurrencyonreport`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblforeignprice` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblforeignprice` CHANGE COLUMN `PartName`   `PartNa' +
        'me` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblforeignprice` CHANGE COLUMN `SupplierProductCode' +
        '`   `SupplierProductCode` varchar(50) NOT NULL DEFAULT '#39#39' COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tblforeignprice` CHANGE COLUMN `SupplierProductName' +
        '`   `SupplierProductName` varchar(50) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblforeignprice` CHANGE COLUMN `UOM`   `UOM` varcha' +
        'r(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblforeignprice`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblforms` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblforms` CHANGE COLUMN `FormName`   `FormName` var' +
        'char(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblforms` CHANGE COLUMN `BusinessObjectName`   `Bus' +
        'inessObjectName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblforms` CHANGE COLUMN `Description`   `Descriptio' +
        'n` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblforms` CHANGE COLUMN `SkinsGroup`   `SkinsGroup`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblforms`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncbookingdrinks` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookingdrinks` CHANGE COLUMN `Meal`   `Meal`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookingdrinks` CHANGE COLUMN `Course`   `Cou' +
        'rse` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookingdrinks` CHANGE COLUMN `ProductName`  ' +
        ' `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblfuncbookingdrinks` CHANGE COLUMN `Description`  ' +
        ' `Description` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblfuncbookingdrinks`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncbookingmeals` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookingmeals` CHANGE COLUMN `Meal`   `Meal` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookingmeals` CHANGE COLUMN `Course`   `Cour' +
        'se` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookingmeals` CHANGE COLUMN `ProductName`   ' +
        '`ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblfuncbookingmeals` CHANGE COLUMN `Description`   ' +
        '`Description` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblfuncbookingmeals`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `Contact`   `Contact' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `Start_Time`   `Star' +
        't_Time` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `End_Time`   `End_Ti' +
        'me` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `RateType`   `RateTy' +
        'pe` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `Notes`   `Notes` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `FeedbackNotes`   `F' +
        'eedbackNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `Othertxt`   `Othert' +
        'xt` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `CustomerDetails`   ' +
        '`CustomerDetails` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `Phone`   `Phone` va' +
        'rchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `AltPhone`   `AltPho' +
        'ne` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `Fax`   `Fax` varcha' +
        'r(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `BillToDetails`   `B' +
        'illToDetails` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `BillPhone`   `BillP' +
        'hone` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `BillAltPhone`   `Bi' +
        'llAltPhone` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `BillFax`   `BillFax' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncbookings` CHANGE COLUMN `BookingDescription`' +
        '   `BookingDescription` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      'ALTER TABLE `tblfuncbookings`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfunccourses` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfunccourses` CHANGE COLUMN `CourseName`   `Cours' +
        'eName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfunccourses`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncmeals` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncmeals` CHANGE COLUMN `MealName`   `MealName`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfuncmeals`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncresourceallocation` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblfuncresourceallocation` CHANGE COLUMN `ResourceN' +
        'ame`   `ResourceName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblfuncresourceallocation`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblfuncresources` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncresources` CHANGE COLUMN `ResourceName`   `R' +
        'esourceName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncresources` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfuncresources`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncroomallocation` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncroomallocation` CHANGE COLUMN `StartDummy`  ' +
        ' `StartDummy` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblfuncroomallocation` CHANGE COLUMN `EndDummy`   `' +
        'EndDummy` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncroomallocation` CHANGE COLUMN `RateType`   `' +
        'RateType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfuncroomallocation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncrooms` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncrooms` CHANGE COLUMN `Name`   `Name` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfuncrooms`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `Status1`   `Status1' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `Status2`   `Status2' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `Status3`   `Status3' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `Status4`   `Status4' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `Status5`   `Status5' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfuncstatuses` CHANGE COLUMN `Status6`   `Status6' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfuncstatuses`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblfunctypes` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblfunctypes` CHANGE COLUMN `FuncTypeName`   `FuncT' +
        'ypeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblfunctypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblgendata` CHANGE COLUMN `Description`   `Descript' +
        'ion` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgendata` CHANGE COLUMN `Value1`   `Value1` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgendata` CHANGE COLUMN `Value2`   `Value2` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgendata` CHANGE COLUMN `Value3`   `Value3` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgendata` CHANGE COLUMN `Value4`   `Value4` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgendata` CHANGE COLUMN `Value5`   `Value5` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblgendata`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblgeneraljournal` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgeneraljournal` CHANGE COLUMN `TransactionNo`   ' +
        '`TransactionNo` varchar(25) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblgeneraljournal`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `AccountNam' +
        'e`   `AccountName` varchar(100) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `AccountNum' +
        'ber`   `AccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `TaxCode`  ' +
        ' `TaxCode` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `Memo`   `M' +
        'emo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `ClientName' +
        '`   `ClientName` varchar(80) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `ClassName`' +
        '   `ClassName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblgeneraljournaldetails` CHANGE COLUMN `EmployeeNa' +
        'me`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblgeneraljournaldetails`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `GlobalRef`   `GlobalRef` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CustomerAddress`   `Custome' +
        'rAddress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `ShipAddress`   `ShipAddress' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `Notes`   `Notes` text COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `PONumber`   `PONumber` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `Phone`   `Phone` varchar(25' +
        '5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `Mobile`   `Mobile` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `AuthorisedBy`   `Authorised' +
        'By` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `ContactName`   `ContactName' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `SerialNumbers`   `SerialNum' +
        'bers` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD1` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD2` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD3` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD4` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD5` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD6` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD7` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD8` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD9` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD10`   `CUSTFLD10` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD11`   `CUSTFLD11` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD12`   `CUSTFLD12` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD13`   `CUSTFLD13` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD14`   `CUSTFLD14` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhire` CHANGE COLUMN `CUSTFLD15`   `CUSTFLD15` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblhire`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `ItemHireNo`   `ItemHir' +
        'eNo` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `HireUnitOfTime`   `Hir' +
        'eUnitOfTime` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `SerialNumber`   `Seria' +
        'lNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `PartName`   `PartName`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `PartDescription`   `Pa' +
        'rtDescription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblhirelines` CHANGE COLUMN `OffHireRef`   `OffHire' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblhirelines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `Product_Descripti' +
        'on`   `Product_Description` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `LineTaxCode`   `L' +
        'ineTaxCode` varchar(5) DEFAULT '#39'GST'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `UnitofMeasureSale' +
        'Lines`   `UnitofMeasureSaleLines` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `TimeCostExpAcc`  ' +
        ' `TimeCostExpAcc` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `GroupName`   `Gro' +
        'upName` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `LaybyID`   `Layby' +
        'ID` varchar(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `SoldSerials`   `S' +
        'oldSerials` tinytext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `DescAttrib1`   `D' +
        'escAttrib1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `DescAttrib2`   `D' +
        'escAttrib2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `Supplier`   `Supp' +
        'lier` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `SupplierContact` ' +
        '  `SupplierContact` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `DescAttrib4`   `D' +
        'escAttrib4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `DescAttrib5`   `D' +
        'escAttrib5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `Area`   `Area` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `SearchFilter`   `' +
        'SearchFilter` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `SearchFilterCopy`' +
        '   `SearchFilterCopy` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `HireSerials`   `H' +
        'ireSerials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `DocketNumber`   `' +
        'DocketNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `SpecDescription` ' +
        '  `SpecDescription` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      'ALTER TABLE `tblhiresaleslines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `CommodityCode`   ' +
        '`CommodityCode` varchar(8) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `DeliveryTerms`   ' +
        '`DeliveryTerms` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `TransactionNature' +
        '`   `TransactionNature` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `SupplementaryUnit' +
        '`   `SupplementaryUnit` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `Country`   `Count' +
        'ry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblintrastatlines` CHANGE COLUMN `TraderRef`   `Tra' +
        'derRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblintrastatlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblintrastats` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblintrastats` CHANGE COLUMN `Month`   `Month` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblintrastats`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblinuse` CHANGE COLUMN `Username`   `Username` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblinuse` CHANGE COLUMN `ClassName`   `ClassName` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblinuse` CHANGE COLUMN `DatasetName`   `DatasetNam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblinuse` CHANGE COLUMN `GroupName`   `GroupName` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblinuse` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblinuse`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblleave` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblleave` CHANGE COLUMN `Type`   `Type` varchar(255' +
        ') NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblleave` CHANGE COLUMN `AccrueAfterPeriod`   `Accr' +
        'ueAfterPeriod` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblleave` CHANGE COLUMN `AccruePeriod`   `AccruePer' +
        'iod` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblleave` CHANGE COLUMN `ClassName`   `ClassName` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblleave`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblleaveaccruals` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblleaveaccruals` CHANGE COLUMN `LeaveType`   `Leav' +
        'eType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblleaveaccruals` CHANGE COLUMN `AccrualType`   `Ac' +
        'crualType` varchar(255) DEFAULT '#39'Accrual'#39' COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblleaveaccruals`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblleavetypes` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblleavetypes` CHANGE COLUMN `LeaveType`   `LeaveTy' +
        'pe` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblleavetypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbllicence` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllicence` CHANGE COLUMN `Location`   `Location` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllicence` CHANGE COLUMN `Notes`   `Notes` text CO' +
        'LLATE utf8_general_ci ;'
      'ALTER TABLE `tbllicence`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbllicencehistory` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllicencehistory` CHANGE COLUMN `ServerMID`   `Ser' +
        'verMID` varchar(20) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbllicencehistory` CHANGE COLUMN `LicenceXML`   `Li' +
        'cenceXML` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbllicencehistory` CHANGE COLUMN `Notes`   `Notes` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbllicencehistory`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbllicenceinvoiced` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllicenceinvoiced` CHANGE COLUMN `Licence`   `Lice' +
        'nce` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbllicenceinvoiced`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbllistlinecolor` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllistlinecolor` CHANGE COLUMN `GroupType`   `Grou' +
        'pType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllistlinecolor` CHANGE COLUMN `Text`   `Text` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbllistlinecolor`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbllocations` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllocations` CHANGE COLUMN `City_sub`   `City_sub`' +
        ' varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllocations` CHANGE COLUMN `State`   `State` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllocations` CHANGE COLUMN `Postcode`   `Postcode`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllocations` CHANGE COLUMN `Country`   `Country` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbllocations` CHANGE COLUMN `Code`   `Code` varchar' +
        '(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbllocations`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `Form`   `Form` varchar' +
        '(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `Control`   `Control` v' +
        'archar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `Owner`   `Owner` varch' +
        'ar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `ControlNameUser`   `Co' +
        'ntrolNameUser` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `Hint`   `Hint` varchar' +
        '(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `Description`   `Descri' +
        'ption` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `Time`   `Time` varchar' +
        '(16) DEFAULT '#39'00:00:00'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrohelp` CHANGE COLUMN `LastTime`   `LastTime`' +
        ' varchar(16) DEFAULT '#39'00:00:00'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmacrohelp`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmacrokeywordslinks` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmacrokeywordslinks`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmacromovies` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacromovies` CHANGE COLUMN `Path`   `Path` varch' +
        'ar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacromovies` CHANGE COLUMN `Filename`   `Filenam' +
        'e` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmacromovies` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmacromovies`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmailmerge` CHANGE COLUMN `MMGroup`   `MMGroup` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmailmerge` CHANGE COLUMN `DocumentName`   `Docum' +
        'entName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmailmerge`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmailmergehost` CHANGE COLUMN `EmailAddress`   `E' +
        'mailAddress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmailmergehost` CHANGE COLUMN `POPHost`   `POPHos' +
        't` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmailmergehost` CHANGE COLUMN `SMTPHost`   `SMTPH' +
        'ost` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmailmergehost` CHANGE COLUMN `FromContact`   `Fr' +
        'omContact` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmailmergehost` CHANGE COLUMN `UserID`   `UserID`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmailmergehost` CHANGE COLUMN `UserPassword`   `U' +
        'serPassword` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmailmergehost`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `OwnerName`   `OwnerName' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `Driver`   `Driver` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `Phone`   `Phone` varcha' +
        'r(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `Notes`   `Notes` text C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `FromCity`   `FromCity` ' +
        'varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `FromState`   `FromState' +
        '` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `FromPostcode`   `FromPo' +
        'stcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `ToCity`   `ToCity` varc' +
        'har(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `ToState`   `ToState` va' +
        'rchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `ToPostcode`   `ToPostco' +
        'de` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifest` CHANGE COLUMN `VehicleName`   `Vehicle' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmanifest`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmanifestlines` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmanifestlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmanifestroutes` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestroutes` CHANGE COLUMN `RouteFrom`   `Rou' +
        'teFrom` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestroutes` CHANGE COLUMN `RouteTo`   `Route' +
        'To` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestroutes` CHANGE COLUMN `RouteDesc`   `Rou' +
        'teDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmanifestroutes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `VehicleName`   ' +
        '`VehicleName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `OwnerName`   `O' +
        'wnerName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `Driver`   `Driv' +
        'er` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `Phone`   `Phone' +
        '` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `RegistrationNo`' +
        '   `RegistrationNo` varchar(10) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblmanifestvehicles` CHANGE COLUMN `Notes`   `Notes' +
        '` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmanifestvehicles`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmanufacture` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanufacture` CHANGE COLUMN `Name`   `Name` varch' +
        'ar(50) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanufacture` CHANGE COLUMN `ReceiptNumberCaption' +
        '`   `ReceiptNumberCaption` varchar(100) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      'ALTER TABLE `tblmanufacture`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmanuftemplate` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmanuftemplate` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblmanuftemplate` CHANGE COLUMN `DisplayDescription' +
        '`   `DisplayDescription` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      'ALTER TABLE `tblmanuftemplate`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Company' +
        '`   `Company` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Title`   `ContactTitle` varchar(32) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'FirstName`   `ContactFirstName` varchar(30) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'SurName`   `ContactSurName` varchar(30) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Address`   `ContactAddress` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Address2`   `ContactAddress2` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Address3`   `ContactAddress3` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'City`   `ContactCity` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'State`   `ContactState` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Pcode`   `ContactPcode` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Country`   `ContactCountry` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'PH`   `ContactPH` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'AltPH`   `ContactAltPH` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'MOB`   `ContactMOB` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Fax`   `ContactFax` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Contact' +
        'Email`   `ContactEmail` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Notes` ' +
        '  `Notes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `CardNum' +
        'ber`   `CardNumber` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `Account' +
        'No`   `AccountNo` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts` CHANGE COLUMN `JobTitl' +
        'e`   `JobTitle` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblmarketingcontactcontacts`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblmarketingcontactproducts` CHANGE COLUMN `Globalr' +
        'ef`   `Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblmarketingcontactproducts` CHANGE COLUMN `Product' +
        'Name`   `ProductName` varchar(100) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactproducts` CHANGE COLUMN `Descrip' +
        'tion`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblmarketingcontactproducts`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CompanyTypeNam' +
        'e`   `CompanyTypeName` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `COMPANY`   `CO' +
        'MPANY` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Street`   `Str' +
        'eet` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Street2`   `St' +
        'reet2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Street3`   `St' +
        'reet3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `FaxNumber`   `' +
        'FaxNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Phone`   `Phon' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `AltPhone`   `A' +
        'ltPhone` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Mobile`   `Mob' +
        'ile` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `SUBURB`   `SUB' +
        'URB` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `STATE`   `STAT' +
        'E` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `POSTCODE`   `P' +
        'OSTCODE` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `URL`   `URL` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `EmployeeSize` ' +
        '  `EmployeeSize` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Notes`   `Note' +
        's` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `JobTitle`   `J' +
        'obTitle` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Title`   `Titl' +
        'e` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `FirstName`   `' +
        'FirstName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `MiddleName`   ' +
        '`MiddleName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `LastName`   `L' +
        'astName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Email`   `Emai' +
        'l` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Country`   `Co' +
        'untry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `Source`   `Sou' +
        'rce` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillStreet`   ' +
        '`BillStreet` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillStreet2`  ' +
        ' `BillStreet2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillStreet3`  ' +
        ' `BillStreet3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillSuburb`   ' +
        '`BillSuburb` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillState`   `' +
        'BillState` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillPostcode` ' +
        '  `BillPostcode` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `BillCountry`  ' +
        ' `BillCountry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `REpName`   `RE' +
        'pName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD1`   `C' +
        'USTFLD1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD2`   `C' +
        'USTFLD2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD3`   `C' +
        'USTFLD3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD4`   `C' +
        'USTFLD4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD5`   `C' +
        'USTFLD5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD6`   `C' +
        'USTFLD6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD7`   `C' +
        'USTFLD7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD8`   `C' +
        'USTFLD8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD9`   `C' +
        'USTFLD9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD10`   `' +
        'CUSTFLD10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD11`   `' +
        'CUSTFLD11` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD12`   `' +
        'CUSTFLD12` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD13`   `' +
        'CUSTFLD13` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD14`   `' +
        'CUSTFLD14` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingcontacts` CHANGE COLUMN `CUSTFLD15`   `' +
        'CUSTFLD15` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmarketingcontacts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `ActionRef`   ' +
        '`ActionRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `EmployeeName`' +
        '   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `Duration`   `' +
        'Duration` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `TypeName`   `' +
        'TypeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `ResultTypeNam' +
        'e`   `ResultTypeName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblmarketingleadlines` CHANGE COLUMN `Notes`   `Not' +
        'es` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmarketingleadlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmarketingleads` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleads` CHANGE COLUMN `Company`   `Compa' +
        'ny` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleads` CHANGE COLUMN `notes`   `notes` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingleads` CHANGE COLUMN `LeadStatus`   `Le' +
        'adStatus` varchar(255) DEFAULT '#39'Unknown'#39' COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblmarketingleads`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmarketingrangeselection` CHANGE COLUMN `RangeDes' +
        'cription`   `RangeDescription` varchar(255) NOT NULL DEFAULT '#39#39' ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingrangeselection` CHANGE COLUMN `XMLData`' +
        '   `XMLData` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingrangeselection` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblmarketingrangeselection`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblmarketingrangeselectionmessages` CHANGE COLUMN `' +
        'GlobalRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblmarketingrangeselectionmessages` CHANGE COLUMN `' +
        'Message`   `Message` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmarketingrangeselectionmessages`  COLLATE='#39'utf8_' +
        'general_ci'#39';'
      
        'ALTER TABLE `tblmemtrans` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmemtrans` CHANGE COLUMN `Type`   `Type` varchar(' +
        '30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmemtrans` CHANGE COLUMN `formClass`   `formClass' +
        '` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmemtrans`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmergefields` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmergefields` CHANGE COLUMN `TableName`   `TableN' +
        'ame` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmergefields` CHANGE COLUMN `FieldName`   `FieldN' +
        'ame` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmergefields` CHANGE COLUMN `FieldLabel`   `Field' +
        'Label` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmergefields`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Name`   `Name` varchar(' +
        '30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Details`   `Details` te' +
        'xt COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `LastName`   `LastName` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Phone`   `Phone` varcha' +
        'r(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Mobile`   `Mobile` varc' +
        'har(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Email`   `Email` varcha' +
        'r(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Fax`   `Fax` varchar(20' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Source`   `Source` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `Company`   `Company` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmessages` CHANGE COLUMN `contactType`   `contact' +
        'Type` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmessages`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmodel` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmodel` CHANGE COLUMN `Name`   `Name` varchar(30)' +
        ' NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmodel`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid`  CHANGE COLUMN `SiteCode` `SiteCode' +
        '` CHAR(3) NULL DEFAULT NULL COLLATE '#39'latin1_general_ci'#39' ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `SiteDesc`   `SiteDes' +
        'c` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `EmailAddressData`   ' +
        '`EmailAddressData` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `EmailUsername`   `Em' +
        'ailUsername` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `EmailPassword`   `Em' +
        'ailPassword` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `LastPC`   `LastPC` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `Servername`   `Serve' +
        'rname` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `DatabaseName`   `Dat' +
        'abaseName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblmsbackendid`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `Tab4_Type`   `Tab4_Typ' +
        'e` varchar(50) DEFAULT '#39'Two Monthly'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `Tab4_Month`   `Tab4_Mo' +
        'nth` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `BasSheetDesc`   `BasSh' +
        'eetDesc` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `NZG5Selected`   `NZG5S' +
        'elected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `NZG6Selected`   `NZG6S' +
        'elected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblnzreturns` CHANGE COLUMN `NZG11Selected`   `NZG1' +
        '1Selected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblnzreturns`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblorder` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblorder` CHANGE COLUMN `CustDocketRef`   `CustDock' +
        'etRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblorder`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblorderlines` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblorderlines` CHANGE COLUMN `Description`   `Descr' +
        'iption` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblorderlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `Notes`   `Notes` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField1`   `C' +
        'ustomField1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField2`   `C' +
        'ustomField2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField3`   `C' +
        'ustomField3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField4`   `C' +
        'ustomField4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField5`   `C' +
        'ustomField5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField6`   `C' +
        'ustomField6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField7`   `C' +
        'ustomField7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField8`   `C' +
        'ustomField8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField9`   `C' +
        'ustomField9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblotherfollowup` CHANGE COLUMN `CustomField10`   `' +
        'CustomField10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblotherfollowup`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblotherfollowuptime` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblotherfollowuptime`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Company`   `Company` varc' +
        'har(80) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `ContactTitle`   `ContactT' +
        'itle` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `ContactFirstName`   `Cont' +
        'actFirstName` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `ContactLastName`   `Conta' +
        'ctLastName` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Street`   `Street` varcha' +
        'r(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Suburb`   `Suburb` varcha' +
        'r(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `State`   `State` varchar(' +
        '20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Postcode`   `Postcode` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `POBox`   `POBox` varchar(' +
        '50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `POSuburb`   `POSuburb` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `POState`   `POState` varc' +
        'har(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `POPostcode`   `POPostcode' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `BillStreet`   `BillStreet' +
        '` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `BillSuburb`   `BillSuburb' +
        '` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `BillState`   `BillState` ' +
        'varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `BillPostcode`   `BillPost' +
        'code` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Phone`   `Phone` varchar(' +
        '20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `AltPhone`   `AltPhone` va' +
        'rchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Mobile`   `Mobile` varcha' +
        'r(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `FaxNumber`   `FaxNumber` ' +
        'varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Email`   `Email` varchar(' +
        '80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `ABN`   `ABN` varchar(15) ' +
        'DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Notes`   `Notes` text COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD1` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD2` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD3` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD4` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD5` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD6` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD7` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD8` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD9` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD10`   `CUSTFLD10` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD11`   `CUSTFLD11` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD12`   `CUSTFLD12` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD13`   `CUSTFLD13` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD14`   `CUSTFLD14` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `CUSTFLD15`   `CUSTFLD15` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `Street2`   `Street2` varc' +
        'har(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothers` CHANGE COLUMN `BillStreet2`   `BillStree' +
        't2` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblothers`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblothertype` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblothertype` CHANGE COLUMN `OtherType`   `OtherTyp' +
        'e` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblothertype`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpartbarcodes` CHANGE COLUMN `BarCode`   `BarCode' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartbarcodes` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpartbarcodes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PARTTYPE`   `PARTTYPE` var' +
        'char(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PRODUCTGROUP`   `PRODUCTGR' +
        'OUP` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PARTNAME`   `PARTNAME` var' +
        'char(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PARTSDESCRIPTION`   `PARTS' +
        'DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PARTSDESCRIPTION_Memo`   `' +
        'PARTSDESCRIPTION_Memo` longtext CHARACTER SET utf8 COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PURCHASEDESC`   `PURCHASED' +
        'ESC` varchar(255) CHARACTER SET utf8 DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `INCOMEACCNT`   `INCOMEACCN' +
        'T` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `ASSETACCNT`   `ASSETACCNT`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `COGSACCNT`   `COGSACCNT` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `BARCODE`   `BARCODE` varch' +
        'ar(35) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PRODUCTCODE`   `PRODUCTCOD' +
        'E` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `TAXCODE`   `TAXCODE` varch' +
        'ar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PURCHTAXCODE`   `PURCHTAXC' +
        'ODE` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `PREFEREDSUPP`   `PREFEREDS' +
        'UPP` varchar(55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `ProductComment`   `Product' +
        'Comment` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `SupplierProductCode`   `Su' +
        'pplierProductCode` varchar(50) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `ProductPopUpNotes`   `Prod' +
        'uctPopUpNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `Area`   `Area` varchar(255' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `TotalQty_UOM`   `TotalQty_' +
        'UOM` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CommodityCode`   `Commodit' +
        'yCode` varchar(8) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD1` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD2` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD3` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD4` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD5` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD6` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD7` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD8` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD9` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD10`   `CUSTFLD10` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD11`   `CUSTFLD11` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD12`   `CUSTFLD12` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD13`   `CUSTFLD13` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD14`   `CUSTFLD14` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `CUSTFLD15`   `CUSTFLD15` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `ProductionNotes`   `Produc' +
        'tionNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `GeneralNotes`   `GeneralNo' +
        'tes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `Description`   `Descriptio' +
        'n` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparts` CHANGE COLUMN `ProductUOM`   `ProductUOM`' +
        ' varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblparts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpartsclasspreferences` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpartsclasspreferences` CHANGE COLUMN `ClassName`' +
        '   `ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpartsclasspreferences`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblpartsnotes` CHANGE COLUMN `Globalref`   `Globalr' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartsnotes` CHANGE COLUMN `Notes`   `Notes` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpartsnotes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpartspics` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpartspics`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpartsspecifications` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartsspecifications` CHANGE COLUMN `SpecDescript' +
        'ion`   `SpecDescription` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblpartsspecifications` CHANGE COLUMN `SpecValue`  ' +
        ' `SpecValue` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpartsspecifications`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PARTTYPE`   `PART' +
        'TYPE` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PARTNAME`   `PART' +
        'NAME` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PARTS_DESCRIPTION' +
        '`   `PARTS_DESCRIPTION` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PURCHASE_DESCRIPT' +
        'ION`   `PURCHASE_DESCRIPTION` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PRODUCTCODE`   `P' +
        'RODUCTCODE` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `TAXCODE`   `TAXCO' +
        'DE` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PURCHTAXCODE`   `' +
        'PURCHTAXCODE` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `PREFEREDSUPP`   `' +
        'PREFEREDSUPP` varchar(55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `SupplierProductCo' +
        'de`   `SupplierProductCode` varchar(50) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `Catagory`   `Cata' +
        'gory` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `Catagory2`   `Cat' +
        'agory2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `Catagory3`   `Cat' +
        'agory3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `DiscountCode`   `' +
        'DiscountCode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpartstemporary` CHANGE COLUMN `ClonePartName`   ' +
        '`ClonePartName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblpartstemporary`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblparttypes` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparttypes` CHANGE COLUMN `TypeCode`   `TypeCode`' +
        ' varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblparttypes` CHANGE COLUMN `TypeDesc`   `TypeDesc`' +
        ' varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblparttypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpassword` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpassword` CHANGE COLUMN `Logon_Name`   `Logon_Na' +
        'me` varchar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpassword` CHANGE COLUMN `Logon_Password`   `Logo' +
        'n_Password` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpassword`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayersuperaccounts` CHANGE COLUMN `SuperName`   ' +
        '`SuperName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayersuperaccounts` CHANGE COLUMN `AccountNo`   ' +
        '`AccountNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayersuperaccounts` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayersuperaccounts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaymentconformations` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpaymentconformations` CHANGE COLUMN `TransGlobal' +
        'Ref`   `TransGlobalRef` varchar(30) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblpaymentconformations` CHANGE COLUMN `TransType` ' +
        '  `TransType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpaymentconformations` CHANGE COLUMN `ClientName`' +
        '   `ClientName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpaymentconformations`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblpaymentmethods` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaymentmethods` CHANGE COLUMN `NAME`   `NAME` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaymentmethods`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayrates` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayrates` CHANGE COLUMN `Description`   `Descrip' +
        'tion` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayrates`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayratetype` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayratetype` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayratetype`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `GlobalRef`   `GlobalRef` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `EmpName`   `EmpName` varcha' +
        'r(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `Class`   `Class` varchar(25' +
        '5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `PayPeriod`   `PayPeriod` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `PayNotes`   `PayNotes` text' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `PayXMLData`   `PayXMLData` ' +
        'text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `Region`   `Region` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpays` CHANGE COLUMN `UKTaxCodeUsed`   `UKTaxCode' +
        'Used` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpays`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaysactionauthorisations` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpaysactionauthorisations` CHANGE COLUMN `Type`  ' +
        ' `Type` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysactionauthorisations` CHANGE COLUMN `Who`   ' +
        '`Who` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysactionauthorisations`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblpaysallowances` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysallowances` CHANGE COLUMN `ClassName`   `Cla' +
        'ssName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaysallowances`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayscommission` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayscommission` CHANGE COLUMN `CommissionDesc`  ' +
        ' `CommissionDesc` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayscommission` CHANGE COLUMN `ClassName`   `Cla' +
        'ssName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayscommission`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayscommissionlines` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayscommissionlines` CHANGE COLUMN `Description`' +
        '   `Description` varchar(100) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      'ALTER TABLE `tblpayscommissionlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaysdeductions` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysdeductions` CHANGE COLUMN `Notes`   `Notes` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysdeductions` CHANGE COLUMN `ClassName`   `Cla' +
        'ssName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaysdeductions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaysemployeeservices` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpaysemployeeservices` CHANGE COLUMN `ServiceName' +
        '`   `ServiceName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpaysemployeeservices` CHANGE COLUMN `PartName`  ' +
        ' `PartName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysemployeeservices` CHANGE COLUMN `PartDescrip' +
        'tion`   `PartDescription` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblpaysemployeeservices`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblpaysleave` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysleave` CHANGE COLUMN `LeaveType`   `LeaveTyp' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysleave` CHANGE COLUMN `ClassName`   `ClassNam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaysleave`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayspayrates` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayspayrates` CHANGE COLUMN `ClassName`   `Class' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayspayrates`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaysplit` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysplit` CHANGE COLUMN `Branch`   `Branch` varc' +
        'har(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysplit` CHANGE COLUMN `BSB`   `BSB` varchar(16' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysplit` CHANGE COLUMN `AccountNo`   `AccountNo' +
        '` varchar(9) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysplit` CHANGE COLUMN `Type`   `Type` varchar(' +
        '16) NOT NULL DEFAULT '#39'%'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysplit` CHANGE COLUMN `AccountName`   `Account' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaysplit`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayssplits` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssplits` CHANGE COLUMN `Branch`   `Branch` va' +
        'rchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssplits` CHANGE COLUMN `BSB`   `BSB` varchar(' +
        '16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssplits` CHANGE COLUMN `AccountNo`   `Account' +
        'No` varchar(16) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssplits` CHANGE COLUMN `AccountName`   `Accou' +
        'ntName` varchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayssplits`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayssundries` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssundries` CHANGE COLUMN `Sundry`   `Sundry` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssundries` CHANGE COLUMN `ClassName`   `Class' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayssundries`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpayssuperannuation` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssuperannuation` CHANGE COLUMN `AccountNo`   ' +
        '`AccountNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpayssuperannuation` CHANGE COLUMN `ClassName`   ' +
        '`ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpayssuperannuation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `Type`   `Type` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `AccountName`   ' +
        '`AccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `AccountGroupLev' +
        'els`   `AccountGroupLevels` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `AccountType`   ' +
        '`AccountType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `ClientName`   `' +
        'ClientName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `Description`   ' +
        '`Description` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `EmployeeName`  ' +
        ' `EmployeeName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpaystransactions` CHANGE COLUMN `MSType`   `MSTy' +
        'pe` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaystransactions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpaysukbenefits` CHANGE COLUMN `Description`   `D' +
        'escription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysukbenefits` CHANGE COLUMN `NICsClass`   `NIC' +
        'sClass` varchar(32) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpaysukbenefits` CHANGE COLUMN `BenefitReceivedFr' +
        'om`   `BenefitReceivedFrom` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblpaysukbenefits` CHANGE COLUMN `ClassName`   `Cla' +
        'ssName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpaysukbenefits`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccattendants` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccattendants`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccdelivery` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccdelivery` CHANGE COLUMN `InvoiceNo`   `Invoic' +
        'eNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccdelivery`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccdipreading` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccdipreading`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccdipreadinglines` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccdipreadinglines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccgrades` CHANGE COLUMN `GradeName`   `GradeNam' +
        'e` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccgrades` CHANGE COLUMN `GradeDesc`   `GradeDes' +
        'c` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccgrades` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccgrades`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpcchoses` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpcchoses`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccimpconfimporteddepno` CHANGE COLUMN `Descript' +
        'ion`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblpccimpconfimporteddepno` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblpccimpconfimporteddepno`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblpccimpconfnativedep` CHANGE COLUMN `DepName`   `' +
        'DepName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccimpconfnativedep` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccimpconfnativedep`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccimportconfigure` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccimportconfigure` CHANGE COLUMN `CustFieldEqua' +
        'lTo`   `CustFieldEqualTo` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      'ALTER TABLE `tblpccimportconfigure`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccimportconfigurematch` CHANGE COLUMN `FieldNam' +
        'eSource`   `FieldNameSource` varchar(255) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblpccimportconfigurematch` CHANGE COLUMN `FieldNam' +
        'eTarget`   `FieldNameTarget` varchar(255) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblpccimportconfigurematch` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblpccimportconfigurematch`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblpccimportedproductcode` CHANGE COLUMN `ProductCo' +
        'de`   `ProductCode` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblpccimportedproductcode` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpccimportedproductcode` CHANGE COLUMN `Descripti' +
        'on`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblpccimportedproductcode`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblpccimportrates` CHANGE COLUMN `Description`   `D' +
        'escription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccimportrates` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccimportrates`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccimportrateseftcodes` CHANGE COLUMN `EFTCode` ' +
        '  `EFTCode` varchar(8) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccimportrateseftcodes` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpccimportrateseftcodes`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblpccimportratesproductcodes` CHANGE COLUMN `Produ' +
        'ctCode`   `ProductCode` varchar(11) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblpccimportratesproductcodes` CHANGE COLUMN `Globa' +
        'lRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblpccimportratesproductcodes`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      
        'ALTER TABLE `tblpccproductcode` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpccproductcode` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccproductcode`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpccsaleslines` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpccsaleslines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpcctanks` CHANGE COLUMN `TankDescription`   `Tan' +
        'kDescription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpcctanks` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpcctanks`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpcctransavailable` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpcctransavailable`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tblpda_despatch_ref`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpda_options_email_transfer` CHANGE COLUMN `popus' +
        'er`   `popuser` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpda_options_email_transfer` CHANGE COLUMN `poppa' +
        'ss`   `poppass` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpda_options_email_transfer` CHANGE COLUMN `popho' +
        'st`   `pophost` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpda_options_email_transfer`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      'ALTER TABLE `tblpda_purchases_ref`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tblpda_repairs_ref`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tblpda_sales_ref`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tblpda_stocktake_ref`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `ListSelectio' +
        'nColour`   `ListSelectionColour` varchar(20) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `SmallBtnColo' +
        'ur`   `SmallBtnColour` varchar(20) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `CalendarReps' +
        '`   `CalendarReps` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `HintStartCol' +
        'or`   `HintStartColor` varchar(40) DEFAULT '#39'clSkyBlue'#39' COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `HintEndColor' +
        '`   `HintEndColor` varchar(40) DEFAULT '#39'clMoneyGreen'#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `HintFontName' +
        '`   `HintFontName` varchar(30) DEFAULT '#39'Arial'#39' COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `HintFontColo' +
        'r`   `HintFontColor` varchar(40) DEFAULT '#39'clNavy'#39' COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `skinoption` ' +
        '  `skinoption` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblpersonalpreferences`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpersonaltabs` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpersonaltabs` CHANGE COLUMN `FieldName`   `Field' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpersonaltabs`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblphonesupport` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupport` CHANGE COLUMN `PhoneSupportPeriodN' +
        'o1`   `PhoneSupportPeriodNo1` varchar(50) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupport` CHANGE COLUMN `PhoneSupportPeriodN' +
        'o2`   `PhoneSupportPeriodNo2` varchar(50) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupport` CHANGE COLUMN `PhoneSupportPeriodN' +
        'o3`   `PhoneSupportPeriodNo3` varchar(50) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupport` CHANGE COLUMN `PhoneSupportPeriodN' +
        'o4`   `PhoneSupportPeriodNo4` varchar(50) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      'ALTER TABLE `tblphonesupport`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Company`   `Comp' +
        'any` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Contact`   `Cont' +
        'act` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Form`   `Form` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Issue`   `Issue`' +
        ' text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Type`   `Type` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Solution`   `Sol' +
        'ution` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `CallTime`   `Cal' +
        'lTime` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblphonesupportlog` CHANGE COLUMN `Version`   `Vers' +
        'ion` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblphonesupportlog`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblphsupportlogversions` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblphsupportlogversions` CHANGE COLUMN `Version`   ' +
        '`Version` varchar(255) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblphsupportlogversions`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblpickingassembly` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpickingassembly` CHANGE COLUMN `Barcode`   `Barc' +
        'ode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpickingassembly`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpickingassemblylines` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpickingassemblylines` CHANGE COLUMN `ProductName' +
        '`   `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpickingassemblylines` CHANGE COLUMN `Description' +
        '`   `Description` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpickingassemblylines` CHANGE COLUMN `UOM`   `UOM' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpickingassemblylines`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblpickslip` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpickslip`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpicksliplines` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpicksliplines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `GlobalRef`   `GlobalRef` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `InvoiceDocNumber`   `Invoice' +
        'DocNumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `OriginalNo`   `OriginalNo` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `BaseNo`   `BaseNo` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Account`   `Account` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `BOID`   `BOID` varchar(255) ' +
        'DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `CustomerName`   `CustomerNam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `InvoiceTo`   `InvoiceTo` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `ShipTo`   `ShipTo` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PickupFrom`   `PickupFrom` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `EmployeeName`   `EmployeeNam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Class`   `Class` varchar(255' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `OrderNumber`   `OrderNumber`' +
        ' varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PONumber`   `PONumber` varch' +
        'ar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `ChequeNo`   `ChequeNo` varch' +
        'ar(45) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `ConNote`   `ConNote` varchar' +
        '(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Memo`   `Memo` text COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Comments`   `Comments` text ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `InvoicePrintDesc`   `Invoice' +
        'PrintDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PickMemo`   `PickMemo` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Shipping`   `Shipping` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Terms`   `Terms` varchar(255' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PayMethod`   `PayMethod` var' +
        'char(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PayDueDate`   `PayDueDate` v' +
        'archar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `TimeOfSale`   `TimeOfSale` v' +
        'archar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `LaybyID`   `LaybyID` varchar' +
        '(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `TillName`   `TillName` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `EnteredBy`   `EnteredBy` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `EnteredAt`   `EnteredAt` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `SalesOrderGlobalRef`   `Sale' +
        'sOrderGlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `QuoteGlobalRef`   `QuoteGlob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `RepairGlobalRef`   `RepairGl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `ARNotes`   `ARNotes` text CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `QuoteStatus`   `QuoteStatus`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `RunName`   `RunName` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Reference`   `Reference` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `AutoSmartOrderRef`   `AutoSm' +
        'artOrderRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PrescriberName`   `Prescribe' +
        'rName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PrescriberTypeCode`   `Presc' +
        'riberTypeCode` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `ProviderNum`   `ProviderNum`' +
        ' varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `DVAFileNum`   `DVAFileNum` v' +
        'archar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranName`   `VeteranName`' +
        ' varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranPhoneNo`   `VeteranPh' +
        'oneNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranPostcode`   `VeteranP' +
        'ostcode` varchar(6) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Veteranfirstname`   `Veteran' +
        'firstname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranSurname`   `VeteranSu' +
        'rname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranShipPostcode`   `Vete' +
        'ranShipPostcode` varchar(6) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `PriorApprovalRefNo`   `Prior' +
        'ApprovalRefNo` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `DVADeliveryCode`   `DVADeliv' +
        'eryCode` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `CustDocketRef`   `CustDocket' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `POSPostCode`   `POSPostCode`' +
        ' varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `Medtype`   `Medtype` varchar' +
        '(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpos`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposeop` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposeop` CHANGE COLUMN `TillName`   `TillName` va' +
        'rchar(254) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposeop`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposeoppayments` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposeoppayments` CHANGE COLUMN `PayMethod`   `Pay' +
        'Method` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposeoppayments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `FunctionName`   `Fu' +
        'nctionName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `Hint`   `Hint` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `CaptionLine1`   `Ca' +
        'ptionLine1` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `CaptionLine2`   `Ca' +
        'ptionLine2` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposfunctions` CHANGE COLUMN `FontName`   `FontNa' +
        'me` varchar(20) DEFAULT '#39'Arial'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposfunctions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposgroup` CHANGE COLUMN `POSGroupName`   `POSGro' +
        'upName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposgroup`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `CaptionLine1`' +
        '   `CaptionLine1` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `CaptionLine2`' +
        '   `CaptionLine2` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `FontName`   `' +
        'FontName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `FunctionName`' +
        '   `FunctionName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `Hint`   `Hint' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `Memo`   `Memo' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposkeypadcustomize`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposkeypads` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposkeypads` CHANGE COLUMN `Description`   `Descr' +
        'iption` varchar(20) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposkeypads`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `PARTTYPE`   `PARTTYPE` ' +
        'varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `INCOMEACCNT`   `INCOMEA' +
        'CCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `ASSETACCNT`   `ASSETACC' +
        'NT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `COGSACCNT`   `COGSACCNT' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `ProductGroup`   `Produc' +
        'tGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `ProductName`   `Product' +
        'Name` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `Product_Description`   ' +
        '`Product_Description` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `Product_Description_Mem' +
        'o`   `Product_Description_Memo` longtext COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `LineTaxCode`   `LineTax' +
        'Code` varchar(5) DEFAULT '#39'GST'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `UnitofMeasureSaleLines`' +
        '   `UnitofMeasureSaleLines` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `TimeCostExpAcc`   `Time' +
        'CostExpAcc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `GroupName`   `GroupName' +
        '` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `LaybyID`   `LaybyID` va' +
        'rchar(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SoldSerials`   `SoldSer' +
        'ials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `DescAttrib3`   `DescAtt' +
        'rib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `DescAttrib1`   `DescAtt' +
        'rib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `DescAttrib2`   `DescAtt' +
        'rib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `Supplier`   `Supplier` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SupplierContact`   `Sup' +
        'plierContact` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `DescAttrib4`   `DescAtt' +
        'rib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `DescAttrib5`   `DescAtt' +
        'rib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `Area`   `Area` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SearchFilter`   `Search' +
        'Filter` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SearchFilterCopy`   `Se' +
        'archFilterCopy` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `HireSerials`   `HireSer' +
        'ials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `DocketNumber`   `Docket' +
        'Number` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SpecDescription`   `Spe' +
        'cDescription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `WarrantyPeriod`   `Warr' +
        'antyPeriod` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField1`  ' +
        ' `SalesLinesCustField1` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField2`  ' +
        ' `SalesLinesCustField2` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField3`  ' +
        ' `SalesLinesCustField3` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField4`  ' +
        ' `SalesLinesCustField4` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField5`  ' +
        ' `SalesLinesCustField5` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField6`  ' +
        ' `SalesLinesCustField6` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField7`  ' +
        ' `SalesLinesCustField7` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField8`  ' +
        ' `SalesLinesCustField8` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField9`  ' +
        ' `SalesLinesCustField9` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `SalesLinesCustField10` ' +
        '  `SalesLinesCustField10` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `LineNotes`   `LineNotes' +
        '` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `CustomData`   `CustomDa' +
        'ta` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `MemoLine`   `MemoLine` ' +
        'text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `VoucherNo`   `VoucherNo' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `RelatedParentLineRef`  ' +
        ' `RelatedParentLineRef` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `RapCategorycode`   `Rap' +
        'Categorycode` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `RAPProductCode`   `RAPP' +
        'roductCode` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `RapProductName`   `RapP' +
        'roductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpospayments` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpospayments` CHANGE COLUMN `PayMethod`   `PayMet' +
        'hod` varchar(50) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpospayments` CHANGE COLUMN `Ref`   `Ref` varchar' +
        '(45) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpospayments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblposredeempoints` CHANGE COLUMN `Globalref`   `Gl' +
        'obalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposredeempoints` CHANGE COLUMN `ProductName`   `' +
        'ProductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblposredeempoints`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpostilleop` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostilleop` CHANGE COLUMN `TillName`   `TillName' +
        '` varchar(254) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostilleop` CHANGE COLUMN `EmployeeName`   `Empl' +
        'oyeeName` varchar(254) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpostilleop`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `TillName`   `TillName` ' +
        'varchar(30) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `ReceiptPrinterType`   `' +
        'ReceiptPrinterType` varchar(255) DEFAULT '#39'EPSON'#39' COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `ComputerName`   `Comput' +
        'erName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `RemoteReceipt`   `Remot' +
        'eReceipt` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `PPPathFileName`   `PPPa' +
        'thFileName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `Company`   `Company` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `Address1`   `Address1` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `Address2`   `Address2` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `State`   `State` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `PostCode`   `PostCode` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `CITY`   `CITY` varchar(' +
        '100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `PHONENUMBER`   `PHONENU' +
        'MBER` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `FAXNUMBER`   `FAXNUMBER' +
        '` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `USBPrinterName`   `USBP' +
        'rinterName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `PolePort`   `PolePort` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `ScaleDeviceName`   `Sca' +
        'leDeviceName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `ScannerDeviceName`   `S' +
        'cannerDeviceName` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblpostills` CHANGE COLUMN `PoleDisplayName`   `Pol' +
        'eDisplayName` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpostills`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpqa` CHANGE COLUMN `GlobalRef`   `GlobalRef` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqa` CHANGE COLUMN `TransType`   `TransType` var' +
        'char(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqa` CHANGE COLUMN `Alloctype`   `Alloctype` var' +
        'char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqa` CHANGE COLUMN `UOM`   `UOM` varchar(50) DEF' +
        'AULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqa` CHANGE COLUMN `ProductName`   `ProductName`' +
        ' varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpqa`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpqadetails` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqadetails` CHANGE COLUMN `ParentRef`   `ParentR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqadetails` CHANGE COLUMN `Value`   `Value` varc' +
        'har(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpqadetails`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpqatranstypes` CHANGE COLUMN `Transtype`   `Tran' +
        'stype` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqatranstypes` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpqatranstypes` CHANGE COLUMN `FormName`   `FormN' +
        'ame` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpqatranstypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpreferences` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpreferences` CHANGE COLUMN `PrefGroup`   `PrefGr' +
        'oup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpreferences` CHANGE COLUMN `PrefName`   `PrefNam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpreferences` CHANGE COLUMN `PrefValue`   `PrefVa' +
        'lue` text CHARACTER SET utf8 COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpreferences` CHANGE COLUMN `PrefDesc`   `PrefDes' +
        'c` varchar(128) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpreferences`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `CompanyName`   `Comp' +
        'anyName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `Notes`   `Notes` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `ReferenceNo`   `Refe' +
        'renceNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `BankAccountName`   `' +
        'BankAccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `BankAccountBSB`   `B' +
        'ankAccountBSB` varchar(7) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `BankAccountNo`   `Ba' +
        'nkAccountNo` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `RepName`   `RepName`' +
        ' varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprepayments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpricelevels` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpricelevels` CHANGE COLUMN `PriceLevel`   `Price' +
        'Level` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpricelevels`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpricelist` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpricelist` CHANGE COLUMN `ListNumber`   `ListNum' +
        'ber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpricelist` CHANGE COLUMN `ListName`   `ListName`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpricelist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpricelistitem` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpricelistitem` CHANGE COLUMN `ProductName`   `Pr' +
        'oductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpricelistitem`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpricescheme` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpricescheme` CHANGE COLUMN `SchemeNumber`   `Sch' +
        'emeNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpricescheme` CHANGE COLUMN `SchemeName`   `Schem' +
        'eName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpricescheme`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprimarykeys` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprimarykeys` CHANGE COLUMN `KeyName`   `KeyName`' +
        ' varchar(50) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprimarykeys`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprintdocs` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprintdocs` CHANGE COLUMN `DocName`   `DocName` v' +
        'archar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprintdocs`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocess` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocess`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocesslines` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocesslines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocesspart` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocesspart` CHANGE COLUMN `Status`   `Status` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocesspart`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocessparttimesheet` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblprocessparttimesheet`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblprocessprogress` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocessprogress`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocessstep` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocessstep` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(255) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_' +
        'ci ;'
      'ALTER TABLE `tblprocessstep`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocesstime` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocesstime`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocpickslip` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocpickslip` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocpickslip`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `SaleDocNumber` ' +
        '  `SaleDocNumber` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `SaleCustomerNam' +
        'e`   `SaleCustomerName` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `SaleLineProduct' +
        'Name`   `SaleLineProductName` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `SaleLineProduct' +
        'Description`   `SaleLineProductDescription` varchar(255) DEFAULT' +
        ' NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `StepDescription' +
        '`   `StepDescription` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `ItemCaption`   ' +
        '`ItemCaption` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `ItemDescription' +
        '`   `ItemDescription` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblprocpickslipline` CHANGE COLUMN `ItemPartUom`   ' +
        '`ItemPartUom` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblprocpickslipline`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocresource` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocresource` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprocresource` CHANGE COLUMN `ResourceName`   `Re' +
        'sourceName` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocresource`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprocresourceavailability` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblprocresourceavailability` CHANGE COLUMN `Descrip' +
        'tion`   `Description` varchar(255) NOT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblprocresourceavailability`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblprocresourceprocess` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprocresourceprocess`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `MasterType`   `MasterTy' +
        'pe` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `Caption`   `Caption` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `Description`   `Descrip' +
        'tion` varchar(255) CHARACTER SET utf8 DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `Details`   `Details` te' +
        'xt COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `PartSource`   `PartSour' +
        'ce` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `InputType`   `InputType' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `CustomInputClass`   `Cu' +
        'stomInputClass` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `ProcStepItemRef`   `Pro' +
        'cStepItemRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `Value`   `Value` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `Info`   `Info` text COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctree` CHANGE COLUMN `TreePartUOM`   `TreePar' +
        'tUOM` varchar(100) DEFAULT '#39'Units'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblproctree`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblproctreepart` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctreepart` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctreepart` CHANGE COLUMN `SerialNumbers`   `S' +
        'erialNumbers` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproctreepart` CHANGE COLUMN `UnitOfMeasure`   `U' +
        'nitOfMeasure` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblproctreepart` CHANGE COLUMN `Parttype`   `Partty' +
        'pe` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblproctreepart`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprodgroupdiscs` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprodgroupdiscs` CHANGE COLUMN `Col1`   `Col1` va' +
        'rchar(125) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprodgroupdiscs` CHANGE COLUMN `Col2`   `Col2` va' +
        'rchar(125) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprodgroupdiscs` CHANGE COLUMN `Col3`   `Col3` va' +
        'rchar(125) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprodgroupdiscs`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblproductattributegroups` CHANGE COLUMN `Name`   `' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductattributegroups` CHANGE COLUMN `globalref' +
        '`   `globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblproductattributegroups` CHANGE COLUMN `PartType`' +
        '   `PartType` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductattributegroups` CHANGE COLUMN `ProdDesc`' +
        '   `ProdDesc` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblproductattributegroups`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblproductattributenames` CHANGE COLUMN `Name`   `N' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductattributenames` CHANGE COLUMN `globalref`' +
        '   `globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblproductattributenames`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblproductattributeproducts` CHANGE COLUMN `GroupNa' +
        'me`   `GroupName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblproductattributeproducts` CHANGE COLUMN `Product' +
        'Name`   `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblproductattributeproducts` CHANGE COLUMN `AttribN' +
        'ame`   `AttribName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblproductattributeproducts` CHANGE COLUMN `AttribV' +
        'alue`   `AttribValue` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblproductattributeproducts` CHANGE COLUMN `globalr' +
        'ef`   `globalref` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblproductattributeproducts`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblproductattributevalues` CHANGE COLUMN `Value`   ' +
        '`Value` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductattributevalues` CHANGE COLUMN `Abbreviat' +
        'ion`   `Abbreviation` varchar(30) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblproductattributevalues` CHANGE COLUMN `globalref' +
        '`   `globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblproductattributevalues`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblproductbin` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductbin` CHANGE COLUMN `BinLocation`   `BinLo' +
        'cation` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductbin` CHANGE COLUMN `BinNumber`   `BinNumb' +
        'er` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblproductbin`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblproductclasses` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductclasses` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductclasses` CHANGE COLUMN `ProductGroup`   `' +
        'ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblproductclasses` CHANGE COLUMN `ClassName`   `Cla' +
        'ssName` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblproductclasses`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblproductcodeabbrevlines` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblproductcodeabbrevlines` CHANGE COLUMN `Descripti' +
        'onAttribValue`   `DescriptionAttribValue` varchar(255) DEFAULT N' +
        'ULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductcodeabbrevlines`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblproductcodeabbrevsetup` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblproductcodeabbrevsetup` CHANGE COLUMN `CatagoryN' +
        'ame`   `CatagoryName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblproductcodeabbrevsetup`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblproductcommission` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductcommission` CHANGE COLUMN `Partname`   `P' +
        'artname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblproductcommission`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblproductforecastformula` CHANGE COLUMN `Formula` ' +
        '  `Formula` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductforecastformula` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblproductforecastformula`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblproductrewardpoints` CHANGE COLUMN `UOM`   `UOM`' +
        ' varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductrewardpoints` CHANGE COLUMN `Partname`   ' +
        '`Partname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblproductrewardpoints` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblproductrewardpoints`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `TaskName`   `TaskNa' +
        'me` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `TaskNotes`   `TaskN' +
        'otes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `PartType`   `PartTy' +
        'pe` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `ProductGroup`   `Pr' +
        'oductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `PartName`   `PartNa' +
        'me` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `PartDescription`   ' +
        '`PartDescription` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `ProductCode`   `Pro' +
        'ductCode` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojectlines` CHANGE COLUMN `CustomerName`   `Cu' +
        'stomerName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprojectlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblprojects` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojects` CHANGE COLUMN `ProjectName`   `Project' +
        'Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojects` CHANGE COLUMN `Notes`   `Notes` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojects` CHANGE COLUMN `CustomerName`   `Custom' +
        'erName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprojects` CHANGE COLUMN `SaleOrderNumber`   `Sal' +
        'eOrderNumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblprojects`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpropcontrolitems` CHANGE COLUMN `ItemType`   `It' +
        'emType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpropcontrolitems` CHANGE COLUMN `PropName`   `Pr' +
        'opName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpropcontrolitems` CHANGE COLUMN `ControlName`   ' +
        '`ControlName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpropcontrolitems` CHANGE COLUMN `DefaultValue`  ' +
        ' `DefaultValue` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblpropcontrolitems`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpublicholidays` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpublicholidays` CHANGE COLUMN `Description`   `D' +
        'escription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpublicholidays`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `PARTTYPE`   `PARTT' +
        'YPE` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `INCOMEACCNT`   `IN' +
        'COMEACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `ASSETACCNT`   `ASS' +
        'ETACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `COGSACCNT`   `COGS' +
        'ACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `ProductGroup`   `P' +
        'roductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `ProductName`   `Pr' +
        'oductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `PartBarcode`   `Pa' +
        'rtBarcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `Product_Descriptio' +
        'n`   `Product_Description` varchar(255) CHARACTER SET utf8 DEFAU' +
        'LT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `AccountNumber`   `' +
        'AccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `AccountName`   `Ac' +
        'countName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `AccountGroup`   `A' +
        'ccountGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `LineTaxCode`   `Li' +
        'neTaxCode` varchar(5) DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `UnitofMeasurePOLin' +
        'es`   `UnitofMeasurePOLines` varchar(255) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `Class`   `Class` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomerJob`   `Cu' +
        'stomerJob` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `RAstatus`   `RAsta' +
        'tus` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `Batch`   `Batch` v' +
        'archar(9) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `serialno`   `seria' +
        'lno` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `RAInvoiceNo`   `RA' +
        'InvoiceNo` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `DescAttrib1`   `De' +
        'scAttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `DescAttrib2`   `De' +
        'scAttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `DescAttrib3`   `De' +
        'scAttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `DescAttrib4`   `De' +
        'scAttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `DescAttrib5`   `De' +
        'scAttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `SearchFilter`   `S' +
        'earchFilter` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `SearchFilterCopy` ' +
        '  `SearchFilterCopy` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `DocketNumber`   `D' +
        'ocketNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `SpecDescription`  ' +
        ' `SpecDescription` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField1`   `C' +
        'ustomField1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField2`   `C' +
        'ustomField2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField3`   `C' +
        'ustomField3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField4`   `C' +
        'ustomField4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField5`   `C' +
        'ustomField5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField6`   `C' +
        'ustomField6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField7`   `C' +
        'ustomField7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField8`   `C' +
        'ustomField8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField9`   `C' +
        'ustomField9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `CustomField10`   `' +
        'CustomField10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `LineNotes`   `Line' +
        'Notes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `MemoLine`   `MemoL' +
        'ine` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `EquipmentName`   `' +
        'EquipmentName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `SupplierProductCod' +
        'e`   `SupplierProductCode` varchar(50) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `SupplierProductNam' +
        'e`   `SupplierProductName` varchar(50) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `RALineRef`   `RALi' +
        'neRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpurchaselines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `PurchaseOrderNumb' +
        'er`   `PurchaseOrderNumber` varchar(30) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `OriginalNo`   `Or' +
        'iginalNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `BaseNo`   `BaseNo' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `Account`   `Accou' +
        'nt` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `BOID`   `BOID` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `SupplierName`   `' +
        'SupplierName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `OrderTo`   `Order' +
        'To` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `ShipTo`   `ShipTo' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `EmployeeName`   `' +
        'EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `InvoiceNumber`   ' +
        '`InvoiceNumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `RefNo`   `RefNo` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `Comments`   `Comm' +
        'ents` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `SalesComments`   ' +
        '`SalesComments` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `Shipping`   `Ship' +
        'ping` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `Terms`   `Terms` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `PrintedBy`   `Pri' +
        'ntedBy` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `EnteredBy`   `Ent' +
        'eredBy` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `EnteredAt`   `Ent' +
        'eredAt` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `ConNote`   `ConNo' +
        'te` varchar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `CustPONumber`   `' +
        'CustPONumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `APNotes`   `APNot' +
        'es` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `ContactName`   `C' +
        'ontactName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `SalesGlobalref`  ' +
        ' `SalesGlobalref` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `RARef`   `RARef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblpurchaseorders`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblquotestatus` CHANGE COLUMN `Status`   `Status` v' +
        'archar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblquotestatus` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblquotestatus`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblreconciliation` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblreconciliation` CHANGE COLUMN `StatementNo`   `S' +
        'tatementNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblreconciliation` CHANGE COLUMN `Notes`   `Notes` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblreconciliation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblreconciliationdepositlines` CHANGE COLUMN `Globa' +
        'lRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblreconciliationdepositlines` CHANGE COLUMN `Refer' +
        'ence`   `Reference` varchar(30) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblreconciliationdepositlines` CHANGE COLUMN `Payee' +
        '`   `Payee` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblreconciliationdepositlines` CHANGE COLUMN `Notes' +
        '`   `Notes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblreconciliationdepositlines`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      
        'ALTER TABLE `tblreconciliationwithdrawallines` CHANGE COLUMN `Gl' +
        'obalRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblreconciliationwithdrawallines` CHANGE COLUMN `Re' +
        'ference`   `Reference` varchar(30) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblreconciliationwithdrawallines` CHANGE COLUMN `Pa' +
        'yee`   `Payee` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblreconciliationwithdrawallines` CHANGE COLUMN `No' +
        'tes`   `Notes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblreconciliationwithdrawallines`  COLLATE='#39'utf8_ge' +
        'neral_ci'#39';'
      
        'ALTER TABLE `tblreference` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblreference` CHANGE COLUMN `Ref_type`   `Ref_type`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblreference` CHANGE COLUMN `Referencetxt`   `Refer' +
        'encetxt` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblreference`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblreferrals` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblreferrals`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `Region`   `Regio' +
        'n` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `RegionAbbreviati' +
        'on`   `RegionAbbreviation` varchar(3) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `CurrencySymbol` ' +
        '  `CurrencySymbol` varchar(3) CHARACTER SET utf8 DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `WholeCurrencyNam' +
        'e`   `WholeCurrencyName` varchar(30) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `DecimalCurrencyN' +
        'ame`   `DecimalCurrencyName` varchar(30) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `ShortDateFormat`' +
        '   `ShortDateFormat` varchar(10) DEFAULT '#39'dd/mm/yyyy'#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `SuburbName`   `S' +
        'uburbName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `StateName`   `St' +
        'ateName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `PostcodeMask`   ' +
        '`PostcodeMask` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `PhoneNumberMask`' +
        '   `PhoneNumberMask` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `MobileNumberMask' +
        '`   `MobileNumberMask` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `BSBName`   `BSBN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `BSBMask`   `BSBM' +
        'ask` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `BankAccountMask`' +
        '   `BankAccountMask` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `ForeignExDefault' +
        '`   `ForeignExDefault` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `TaxCodeSalesInc`' +
        '   `TaxCodeSalesInc` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `TaxCodeSalesEx` ' +
        '  `TaxCodeSalesEx` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `TaxCodePurchaseI' +
        'nc`   `TaxCodePurchaseInc` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `TaxCodePurchaseE' +
        'x`   `TaxCodePurchaseEx` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `TaxCodeNoTax`   ' +
        '`TaxCodeNoTax` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `BusinessTaxNoLab' +
        'el`   `BusinessTaxNoLabel` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `BusinessTaxNoMas' +
        'k`   `BusinessTaxNoMask` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `BusinessNoLabel`' +
        '   `BusinessNoLabel` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `POSDocName`   `P' +
        'OSDocName` varchar(100) DEFAULT '#39'TAX INVOICE'#39' COLLATE utf8_gener' +
        'al_ci ;'
      'ALTER TABLE `tblregionaloptions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrelatedclients` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrelatedclients` CHANGE COLUMN `MasterCompany`   ' +
        '`MasterCompany` varchar(80) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblrelatedclients` CHANGE COLUMN `ChildCompany`   `' +
        'ChildCompany` varchar(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrelatedclients`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrelatedcontacts` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrelatedcontacts` CHANGE COLUMN `MasterCompany`  ' +
        ' `MasterCompany` varchar(80) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblrelatedcontacts` CHANGE COLUMN `ChildCompany`   ' +
        '`ChildCompany` varchar(80) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblrelatedcontacts`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tblrelatedparts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `Globalref`   `Glob' +
        'alref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `GSFSReceiptNo`   `' +
        'GSFSReceiptNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultConditionCode' +
        '`   `FaultConditionCode` varchar(20) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultConditionDesc' +
        '`   `FaultConditionDesc` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultSymptomcode` ' +
        '  `FaultSymptomcode` varchar(20) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultSymptomDesc` ' +
        '  `FaultSymptomDesc` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultDefectCode`  ' +
        ' `FaultDefectCode` varchar(20) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultDefectDesc`  ' +
        ' `FaultDefectDesc` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultRepairCode`  ' +
        ' `FaultRepairCode` varchar(20) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultRepairDesc`  ' +
        ' `FaultRepairDesc` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultSectionCode` ' +
        '  `FaultSectionCode` varchar(20) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `FaultSectionDesc` ' +
        '  `FaultSectionDesc` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `Repaircode`   `Rep' +
        'aircode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `AscClaimRemarks`  ' +
        ' `AscClaimRemarks` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `Authorisationnumbe' +
        'r`   `Authorisationnumber` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `Model`   `Model` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `SerialNo`   `Seria' +
        'lNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `Manufacture`   `Ma' +
        'nufacture` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `RetailerName`   `R' +
        'etailerName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairdetails` CHANGE COLUMN `ReceiptNumberCapti' +
        'on`   `ReceiptNumberCaption` varchar(100) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      'ALTER TABLE `tblrepairdetails`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrepairfaults` CHANGE COLUMN `Globalref`   `Globa' +
        'lref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairfaults` CHANGE COLUMN `code`   `code` varc' +
        'har(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairfaults` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairfaults` CHANGE COLUMN `Manufacture`   `Man' +
        'ufacture` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairfaults` CHANGE COLUMN `ReceiptNumberCaptio' +
        'n`   `ReceiptNumberCaption` varchar(100) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      'ALTER TABLE `tblrepairfaults`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `PartName`   `PartNam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `TaxCode`   `TaxCode`' +
        ' varchar(5) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `ClassName`   `ClassN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `PartType`   `PartTyp' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `MemoLine`   `MemoLin' +
        'e` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `InvoiceLineRef`   `I' +
        'nvoiceLineRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `Equipment`   `Equipm' +
        'ent` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `UnitofMeasure`   `Un' +
        'itofMeasure` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `SerialNos`   `Serial' +
        'Nos` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairparts` CHANGE COLUMN `ParentLineRef`   `Pa' +
        'rentLineRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrepairparts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Notes`   `Notes` text CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `FeedbackNotes`   `Feedba' +
        'ckNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CustomerDetails`   `Cust' +
        'omerDetails` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Phone`   `Phone` varchar' +
        '(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `AltPhone`   `AltPhone` v' +
        'archar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Fax`   `Fax` varchar(30)' +
        ' DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Status`   `Status` varch' +
        'ar(100) DEFAULT '#39'New Repair'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `BillToCustomerDetails`  ' +
        ' `BillToCustomerDetails` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `BillPhone`   `BillPhone`' +
        ' varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `BillAltPhone`   `BillAlt' +
        'Phone` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `BillFax`   `BillFax` var' +
        'char(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `SOGlobalRef`   `SOGlobal' +
        'Ref` varchar(255) DEFAULT NULL COMMENT '#39'Global ref of the conver' +
        'ted SalesOrder. SalesOrder-->repairs'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `QuoteGlobalRef`   `Quote' +
        'GlobalRef` varchar(255) DEFAULT NULL COMMENT '#39'Global ref of the ' +
        'converted Quote. Quote-->repairs'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CustomerPONumber`   `Cus' +
        'tomerPONumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CompletionTime`   `Compl' +
        'etionTime` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Shipping`   `Shipping` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Terms`   `Terms` varchar' +
        '(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `Mobile`   `Mobile` varch' +
        'ar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `BillMobile`   `BillMobil' +
        'e` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD1` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD2` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD3` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD4` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD5` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD6` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD7` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD8` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD9` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD10`   `CUSTFLD10`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD11`   `CUSTFLD11`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD12`   `CUSTFLD12`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD13`   `CUSTFLD13`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD14`   `CUSTFLD14`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairs` CHANGE COLUMN `CUSTFLD15`   `CUSTFLD15`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrepairs`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Globalref`  ' +
        ' `Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F1`   `F1` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F2`   `F2` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F3`   `F3` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F4`   `F4` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F5`   `F5` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F6`   `F6` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F7`   `F7` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F8`   `F8` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F9`   `F9` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F10`   `F10`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F11`   `F11`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F12`   `F12`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F13`   `F13`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F14`   `F14`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F15`   `F15`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F16`   `F16`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F17`   `F17`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F18`   `F18`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F19`   `F19`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F20`   `F20`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F21`   `F21`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F22`   `F22`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F23`   `F23`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F24`   `F24`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F25`   `F25`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F26`   `F26`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F27`   `F27`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F28`   `F28`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F29`   `F29`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F30`   `F30`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F31`   `F31`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F32`   `F32`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F33`   `F33`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F34`   `F34`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F35`   `F35`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F36`   `F36`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F37`   `F37`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F38`   `F38`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `F39`   `F39`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '`   `Description1` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '`   `Description2` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '`   `Description3` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description4' +
        '`   `Description4` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description5' +
        '`   `Description5` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description6' +
        '`   `Description6` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description7' +
        '`   `Description7` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description8' +
        '`   `Description8` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description9' +
        '`   `Description9` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '0`   `Description10` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '1`   `Description11` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '2`   `Description12` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '3`   `Description13` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '4`   `Description14` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '5`   `Description15` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '6`   `Description16` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '7`   `Description17` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '8`   `Description18` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description1' +
        '9`   `Description19` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '0`   `Description20` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '1`   `Description21` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '2`   `Description22` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '3`   `Description23` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '4`   `Description24` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '5`   `Description25` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '6`   `Description26` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '7`   `Description27` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '8`   `Description28` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description2' +
        '9`   `Description29` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '0`   `Description30` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '1`   `Description31` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '2`   `Description32` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '3`   `Description33` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '4`   `Description34` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '5`   `Description35` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '6`   `Description36` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '7`   `Description37` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '8`   `Description38` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Description3' +
        '9`   `Description39` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblrepairsexportconfig` CHANGE COLUMN `Dateformat` ' +
        '  `Dateformat` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblrepairsexportconfig`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblresources` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblresources` CHANGE COLUMN `FirstName`   `FirstNam' +
        'e` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblresources` CHANGE COLUMN `LastName`   `LastName`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblresources`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblretirementage` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblretirementage` CHANGE COLUMN `Sex`   `Sex` varch' +
        'ar(7) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblretirementage`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `SelcallType`   `SelcallType`' +
        ' varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `CustomerName`   `CustomerNam' +
        'e` varchar(40) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `FreqBand`   `FreqBand` varch' +
        'ar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `AntennaTypeBase`   `AntennaT' +
        'ypeBase` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `AntennaTypeMobiles1`   `Ante' +
        'nnaTypeMobiles1` varchar(20) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `AntennaTypeMobiles2`   `Ante' +
        'nnaTypeMobiles2` varchar(20) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `AntennaTypeMobiles3`   `Ante' +
        'nnaTypeMobiles3` varchar(20) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `RadioModelsUsed1`   `RadioMo' +
        'delsUsed1` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `RadioModelsUsed2`   `RadioMo' +
        'delsUsed2` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `RadioModelsUsed3`   `RadioMo' +
        'delsUsed3` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `Description`   `Description`' +
        ' text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrft` CHANGE COLUMN `GlobalRef`   `GlobalRef` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrft`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrftantennatypemobiles` CHANGE COLUMN `AntennaTyp' +
        'eMobilesName`   `AntennaTypeMobilesName` varchar(20) DEFAULT NUL' +
        'L COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftantennatypemobiles` CHANGE COLUMN `AntennaTyp' +
        'eMobilesDescription`   `AntennaTypeMobilesDescription` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftantennatypemobiles` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblrftantennatypemobiles`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `Subtone`   `Subtone`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `RptLocations`   `Rpt' +
        'Locations` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `Deviation`   `Deviat' +
        'ion` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `LicenseNo`   `Licens' +
        'eNo` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `Details`   `Details`' +
        ' varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `Note`   `Note` varch' +
        'ar(250) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrftchannels`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrftfreqband` CHANGE COLUMN `FreqBandName`   `Fre' +
        'qBandName` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftfreqband` CHANGE COLUMN `FreqBandDescription`' +
        '   `FreqBandDescription` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblrftfreqband` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrftfreqband`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrftradiomodelsused` CHANGE COLUMN `RadioModelsUs' +
        'edName`   `RadioModelsUsedName` varchar(20) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblrftradiomodelsused` CHANGE COLUMN `RadioModelsUs' +
        'edDescription`   `RadioModelsUsedDescription` varchar(255) DEFAU' +
        'LT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftradiomodelsused` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrftradiomodelsused`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `SelcallNo`   `' +
        'SelcallNo` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `Vehicle`   `Ve' +
        'hicle` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `Driver`   `Dri' +
        'ver` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `AntennaType`  ' +
        ' `AntennaType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `Rego`   `Rego`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `Serial`   `Ser' +
        'ial` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `RadioModel`   ' +
        '`RadioModel` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `Note`   `Note`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalldetails` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrftselcalldetails`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrftselcalltype` CHANGE COLUMN `SelcallType`   `S' +
        'elcallType` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalltype` CHANGE COLUMN `SelcallTypeDescri' +
        'ption`   `SelcallTypeDescription` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftselcalltype` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrftselcalltype`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblroster` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblroster` CHANGE COLUMN `PlannerID`   `PlannerID` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblroster` CHANGE COLUMN `Type`   `Type` varchar(25' +
        '5) DEFAULT '#39'Allocation'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblroster` CHANGE COLUMN `Notes`   `Notes` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblroster`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblruns` CHANGE COLUMN `RunName`   `RunName` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblruns` CHANGE COLUMN `Operator`   `Operator` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblruns` CHANGE COLUMN `GlobalRef`   `GlobalRef` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblruns` CHANGE COLUMN `ClassName`   `ClassName` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblruns`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `ClientName`   `ClientN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `Address`   `Address` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `Phone`   `Phone` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `Mobile`   `Mobile` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `Company`   `Company` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `PayMethodName`   `PayM' +
        'ethodName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `TaxCode`   `TaxCode` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `ProductName`   `Produc' +
        'tName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `PreferedSupp`   `Prefe' +
        'redSupp` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrunslines` CHANGE COLUMN `FreqType`   `FreqType`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblrunslines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `InvoiceDocNumber`   `Invoi' +
        'ceDocNumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `OriginalNo`   `OriginalNo`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `BaseNo`   `BaseNo` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Account`   `Account` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `BOID`   `BOID` varchar(255' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `CustomerName`   `CustomerN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `InvoiceTo`   `InvoiceTo` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `ShipTo`   `ShipTo` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `PickupFrom`   `PickupFrom`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `EmployeeName`   `EmployeeN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Class`   `Class` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `OrderNumber`   `OrderNumbe' +
        'r` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `PONumber`   `PONumber` var' +
        'char(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `ChequeNo`   `ChequeNo` var' +
        'char(45) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `ConNote`   `ConNote` varch' +
        'ar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Memo`   `Memo` text COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Comments`   `Comments` tex' +
        't COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `InvoicePrintDesc`   `Invoi' +
        'cePrintDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `PickMemo`   `PickMemo` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Shipping`   `Shipping` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Terms`   `Terms` varchar(2' +
        '55) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `PayMethod`   `PayMethod` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `PayDueDate`   `PayDueDate`' +
        ' varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `TimeOfSale`   `TimeOfSale`' +
        ' varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `LaybyID`   `LaybyID` varch' +
        'ar(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `TillName`   `TillName` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `EnteredBy`   `EnteredBy` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `EnteredAt`   `EnteredAt` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `SalesOrderGlobalRef`   `Sa' +
        'lesOrderGlobalRef` varchar(255) DEFAULT NULL COMMENT '#39'globalref ' +
        'of the converted Sales Order. SalesOrder -->Invoic'#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `QuoteGlobalRef`   `QuoteGl' +
        'obalRef` varchar(255) DEFAULT NULL COMMENT '#39'globalref of the con' +
        'verted Quote. Quote --> Invoice/SalesOrd'#39' COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `RepairGlobalRef`   `Repair' +
        'GlobalRef` varchar(255) DEFAULT NULL COMMENT '#39'Globalref of the c' +
        'onverted Repairs. Repairs--> Invoice'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `SOProgressPaymentGlobalRef' +
        '`   `SOProgressPaymentGlobalRef` varchar(255) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `SOProgressPaymentOriginalR' +
        'ef`   `SOProgressPaymentOriginalRef` varchar(255) DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `ARNotes`   `ARNotes` text ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `QuoteStatus`   `QuoteStatu' +
        's` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `RunName`   `RunName` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Reference`   `Reference` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `AutoSmartOrderRef`   `Auto' +
        'SmartOrderRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `ContactName`   `ContactNam' +
        'e` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `POSPostCode`   `POSPostCod' +
        'e` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `Medtype`   `Medtype` varch' +
        'ar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsales`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsalescommission` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalescommission` CHANGE COLUMN `EmployeeName`   ' +
        '`EmployeeName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsalescommission` CHANGE COLUMN `ProductName`   `' +
        'ProductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsalescommission`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsalescommissionupdates` CHANGE COLUMN `globalref' +
        '`   `globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblsalescommissionupdates`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `PARTTYPE`   `PARTTYPE' +
        '` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `INCOMEACCNT`   `INCOM' +
        'EACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `ASSETACCNT`   `ASSETA' +
        'CCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `COGSACCNT`   `COGSACC' +
        'NT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `ProductGroup`   `Prod' +
        'uctGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `ProductName`   `Produ' +
        'ctName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `Product_Description` ' +
        '  `Product_Description` varchar(255) CHARACTER SET utf8 DEFAULT ' +
        'NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `Product_Description_M' +
        'emo`   `Product_Description_Memo` longtext CHARACTER SET utf8 CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `LineTaxCode`   `LineT' +
        'axCode` varchar(5) DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `UnitofMeasureSaleLine' +
        's`   `UnitofMeasureSaleLines` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `LaybyID`   `LaybyID` ' +
        'varchar(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SoldSerials`   `SoldS' +
        'erials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `DescAttrib3`   `DescA' +
        'ttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `DescAttrib1`   `DescA' +
        'ttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `DescAttrib2`   `DescA' +
        'ttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `Supplier`   `Supplier' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SupplierContact`   `S' +
        'upplierContact` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `DescAttrib4`   `DescA' +
        'ttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `DescAttrib5`   `DescA' +
        'ttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `Area`   `Area` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SearchFilter`   `Sear' +
        'chFilter` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SearchFilterCopy`   `' +
        'SearchFilterCopy` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `HireSerials`   `HireS' +
        'erials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `DocketNumber`   `Dock' +
        'etNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SpecDescription`   `S' +
        'pecDescription` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `WarrantyPeriod`   `Wa' +
        'rrantyPeriod` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField1`' +
        '   `SalesLinesCustField1` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField2`' +
        '   `SalesLinesCustField2` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField3`' +
        '   `SalesLinesCustField3` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField4`' +
        '   `SalesLinesCustField4` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField5`' +
        '   `SalesLinesCustField5` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField6`' +
        '   `SalesLinesCustField6` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField7`' +
        '   `SalesLinesCustField7` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField8`' +
        '   `SalesLinesCustField8` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField9`' +
        '   `SalesLinesCustField9` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `SalesLinesCustField10' +
        '`   `SalesLinesCustField10` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `LineNotes`   `LineNot' +
        'es` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `CustomData`   `Custom' +
        'Data` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `MemoLine`   `MemoLine' +
        '` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `RelatedParentLineRef`' +
        '   `RelatedParentLineRef` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `PartBarcode`   `PartB' +
        'arcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `ProgresspaymentRef`  ' +
        ' `ProgresspaymentRef` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      'ALTER TABLE `tblsaleslines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsaleslinespoints` CHANGE COLUMN `Globalref`   `G' +
        'lobalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslinespoints` CHANGE COLUMN `ProductName`   ' +
        '`ProductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsaleslinespoints` CHANGE COLUMN `Deptname`   `De' +
        'ptname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsaleslinespoints`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `PARTTYPE`   `PART' +
        'TYPE` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `INCOMEACCNT`   `I' +
        'NCOMEACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `ASSETACCNT`   `AS' +
        'SETACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `COGSACCNT`   `COG' +
        'SACCNT` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `ProductGroup`   `' +
        'ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `Product_Descripti' +
        'on`   `Product_Description` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `LineTaxCode`   `L' +
        'ineTaxCode` varchar(5) DEFAULT '#39'GST'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `UnitofMeasureSale' +
        'Lines`   `UnitofMeasureSaleLines` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `TimeCostExpAcc`  ' +
        ' `TimeCostExpAcc` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `GroupName`   `Gro' +
        'upName` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `LaybyID`   `Layby' +
        'ID` varchar(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SoldSerials`   `S' +
        'oldSerials` tinytext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `DescAttrib1`   `D' +
        'escAttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `DescAttrib2`   `D' +
        'escAttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `DescAttrib3`   `D' +
        'escAttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `DescAttrib4`   `D' +
        'escAttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `DescAttrib5`   `D' +
        'escAttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SupplierContact` ' +
        '  `SupplierContact` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `Supplier`   `Supp' +
        'lier` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `Area`   `Area` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SearchFilter`   `' +
        'SearchFilter` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SearchFilterCopy`' +
        '   `SearchFilterCopy` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `HireSerials`   `H' +
        'ireSerials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `DocketNumber`   `' +
        'DocketNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SpecDescription` ' +
        '  `SpecDescription` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `WarrantyPeriod`  ' +
        ' `WarrantyPeriod` varchar(100) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld1`   `SalesLinesCustField1` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld2`   `SalesLinesCustField2` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld3`   `SalesLinesCustField3` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld4`   `SalesLinesCustField4` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld5`   `SalesLinesCustField5` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld6`   `SalesLinesCustField6` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld7`   `SalesLinesCustField7` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld8`   `SalesLinesCustField8` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld9`   `SalesLinesCustField9` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `SalesLinesCustFie' +
        'ld10`   `SalesLinesCustField10` varchar(255) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `LineNotes`   `Lin' +
        'eNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `CustomData`   `Cu' +
        'stomData` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `MemoLine`   `Memo' +
        'Line` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `RelatedParentLine' +
        'Ref`   `RelatedParentLineRef` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `Product_Descripti' +
        'on_Memo`   `Product_Description_Memo` longtext COLLATE utf8_gene' +
        'ral_ci ;'
      'ALTER TABLE `tblsaleslines_pos`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsalespayments` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalespayments` CHANGE COLUMN `PayMethod`   `PayM' +
        'ethod` varchar(50) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalespayments` CHANGE COLUMN `Ref`   `Ref` varch' +
        'ar(45) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsalespayments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsalespayments_pos` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalespayments_pos` CHANGE COLUMN `PayMethod`   `' +
        'PayMethod` varchar(50) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalespayments_pos` CHANGE COLUMN `Ref`   `Ref` v' +
        'archar(45) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsalespayments_pos`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsalesredeempoints` CHANGE COLUMN `Globalref`   `' +
        'Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalesredeempoints` CHANGE COLUMN `ProductName`  ' +
        ' `ProductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblsalesredeempoints`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsalesshippingdetails` CHANGE COLUMN `Globalref` ' +
        '  `Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsalesshippingdetails` CHANGE COLUMN `FlightNo`  ' +
        ' `FlightNo` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalesshippingdetails` CHANGE COLUMN `Description' +
        '`   `Description` varchar(100) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblsalesshippingdetails` CHANGE COLUMN `WeightUOM` ' +
        '  `WeightUOM` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsalesshippingdetails` CHANGE COLUMN `SizeUOM`   ' +
        '`SizeUOM` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsalesshippingdetails`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `InvoiceDocNumber`   `I' +
        'nvoiceDocNumber` varchar(30) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `OriginalNo`   `Origina' +
        'lNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Account`   `Account` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `BOID`   `BOID` varchar' +
        '(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `CustomerName`   `Custo' +
        'merName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `InvoiceTo`   `InvoiceT' +
        'o` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `ShipTo`   `ShipTo` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `PickupFrom`   `PickupF' +
        'rom` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `EmployeeName`   `Emplo' +
        'yeeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Class`   `Class` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `OrderNumber`   `OrderN' +
        'umber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `PONumber`   `PONumber`' +
        ' varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `ChequeNo`   `ChequeNo`' +
        ' varchar(45) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `ConNote`   `ConNote` v' +
        'archar(25) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Memo`   `Memo` text CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Comments`   `Comments`' +
        ' text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `InvoicePrintDesc`   `I' +
        'nvoicePrintDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `PickMemo`   `PickMemo`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `PrintedBy`   `PrintedB' +
        'y` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Shipping`   `Shipping`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Terms`   `Terms` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `PayMethod`   `PayMetho' +
        'd` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `PayDueDate`   `PayDueD' +
        'ate` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `TimeOfSale`   `TimeOfS' +
        'ale` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `LaybyID`   `LaybyID` v' +
        'archar(14) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `TillName`   `TillName`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `EnteredBy`   `EnteredB' +
        'y` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `EnteredAt`   `EnteredA' +
        't` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `QuoteGlobalRef`   `Quo' +
        'teGlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `SalesOrderGlobalRef`  ' +
        ' `SalesOrderGlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `ARNotes`   `ARNotes` t' +
        'ext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `BaseNo`   `BaseNo` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `RepairGlobalRef`   `Re' +
        'pairGlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `QuoteStatus`   `QuoteS' +
        'tatus` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `RunName`   `RunName` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `Reference`   `Referenc' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsales_pos`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblschemepricelistitem` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblschemepricelistitem` CHANGE COLUMN `PriceListNum' +
        'ber`   `PriceListNumber` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblschemepricelistitem` CHANGE COLUMN `PriceListNam' +
        'e`   `PriceListName` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      'ALTER TABLE `tblschemepricelistitem`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblselectedaccountsforreprots` CHANGE COLUMN `Globa' +
        'lref`   `Globalref` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblselectedaccountsforreprots` CHANGE COLUMN `Accou' +
        'ntType`   `AccountType` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblselectedaccountsforreprots` CHANGE COLUMN `Accou' +
        'ntname`   `Accountname` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblselectedaccountsforreprots`  COLLATE='#39'utf8_gener' +
        'al_ci'#39';'
      
        'ALTER TABLE `tblseqnumbers` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblseqnumbers` CHANGE COLUMN `SeqName`   `SeqName` ' +
        'varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblseqnumbers`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblserialnumbers` CHANGE COLUMN `SerialNo`   `Seria' +
        'lNo` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblserialnumbers` CHANGE COLUMN `Productname`   `Pr' +
        'oductname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblserialnumbers` CHANGE COLUMN `classname`   `clas' +
        'sname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblserialnumbers`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblservices` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblservices` CHANGE COLUMN `ServiceDesc`   `Service' +
        'Desc` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblservices`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblshipcontainerdetails` CHANGE COLUMN `GLOBALREF` ' +
        '  `GLOBALREF` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblshipcontainerdetails` CHANGE COLUMN `CommercialI' +
        'nvNo`   `CommercialInvNo` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblshipcontainerdetails` CHANGE COLUMN `SupplierWor' +
        'kOrderNo`   `SupplierWorkOrderNo` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshipcontainerdetails`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `CompanyName`   `' +
        'CompanyName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipAddress`   `' +
        'ShipAddress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipAddress1`   ' +
        '`ShipAddress1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipCity`   `Shi' +
        'pCity` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipPostCode`   ' +
        '`ShipPostCode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipState`   `Sh' +
        'ipState` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipCountry`   `' +
        'ShipCountry` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `ShipAddress2`   ' +
        '`ShipAddress2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `PortOfLanding`  ' +
        ' `PortOfLanding` varchar(100) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `PortOfDischarge`' +
        '   `PortOfDischarge` varchar(100) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `FinalDestination' +
        '`   `FinalDestination` varchar(100) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblshippingaddress` CHANGE COLUMN `IncoPlace`   `In' +
        'coPlace` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblshippingaddress`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblshippingagent` CHANGE COLUMN `Globalref`   `Glob' +
        'alref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingagent` CHANGE COLUMN `Code`   `Code` var' +
        'char(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingagent` CHANGE COLUMN `Description`   `De' +
        'scription` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingagent` CHANGE COLUMN `SupplierName`   `S' +
        'upplierName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingagent` CHANGE COLUMN `Insurance`   `Insu' +
        'rance` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblshippingagent`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `ShippingContai' +
        'nerStatus`   `ShippingContainerStatus` varchar(255) DEFAULT NULL' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `DeparturePoint' +
        '`   `DeparturePoint` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `VesselName`   ' +
        '`VesselName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `ArrivalPoint` ' +
        '  `ArrivalPoint` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `ContainerName`' +
        '   `ContainerName` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `ContainerNotes' +
        '`   `ContainerNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingcontainer` CHANGE COLUMN `GLOBALREF`   `' +
        'GLOBALREF` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblshippingcontainer`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblshippingmethods` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblshippingmethods` CHANGE COLUMN `ShippingMethod` ' +
        '  `ShippingMethod` varchar(20) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      'ALTER TABLE `tblshippingmethods`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsimpletypeactions` CHANGE COLUMN `Globalref`   `' +
        'Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsimpletypeactions` CHANGE COLUMN `Choice`   `Cho' +
        'ice` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsimpletypeactions` CHANGE COLUMN `SimpletypeName' +
        '`   `SimpletypeName` varchar(100) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblsimpletypeactions` CHANGE COLUMN `simpletypecode' +
        '`   `simpletypecode` varchar(100) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      'ALTER TABLE `tblsimpletypeactions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsimpletypes` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsimpletypes` CHANGE COLUMN `TypeCode`   `TypeCod' +
        'e` varchar(30) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsimpletypes` CHANGE COLUMN `Name`   `Name` varch' +
        'ar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsimpletypes` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsimpletypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsitelocations` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsitelocations` CHANGE COLUMN `Location`   `Locat' +
        'ion` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsitelocations`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblskillprovider` CHANGE COLUMN `globalref`   `glob' +
        'alref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblskillprovider` CHANGE COLUMN `SkillProviderName`' +
        '   `SkillProviderName` varchar(100) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      'ALTER TABLE `tblskillprovider`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblskillproviderskills` CHANGE COLUMN `globalref`  ' +
        ' `globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblskillproviderskills` CHANGE COLUMN `Skillname`  ' +
        ' `Skillname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblskillproviderskills`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblskills` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblskills` CHANGE COLUMN `Skill`   `Skill` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblskills`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsmartorder` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsmartorder` CHANGE COLUMN `SmartOrderDesc`   `Sm' +
        'artOrderDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsmartorder` CHANGE COLUMN `SalesGlobalref`   `Sa' +
        'lesGlobalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblsmartorder`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `PODesc`   `PODes' +
        'c` varchar(255) CHARACTER SET utf8 DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `SupplierContact`' +
        '   `SupplierContact` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `UnitofMeasure`  ' +
        ' `UnitofMeasure` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `DescAttrib1`   `' +
        'DescAttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `DescAttrib2`   `' +
        'DescAttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `DescAttrib3`   `' +
        'DescAttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `DescAttrib4`   `' +
        'DescAttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `DescAttrib5`   `' +
        'DescAttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustPONumber`   ' +
        '`CustPONumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `PARTSNAME`   `PA' +
        'RTSNAME` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `SearchFilter`   ' +
        '`SearchFilter` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `SearchFilterCopy' +
        '`   `SearchFilterCopy` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `SupplierName`   ' +
        '`SupplierName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `ClassName`   `Cl' +
        'assName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CusJobName`   `C' +
        'usJobName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `DocketNumber`   ' +
        '`DocketNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `LineNotes`   `Li' +
        'neNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField1`   ' +
        '`CustomField1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField2`   ' +
        '`CustomField2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField3`   ' +
        '`CustomField3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField4`   ' +
        '`CustomField4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField5`   ' +
        '`CustomField5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField6`   ' +
        '`CustomField6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField7`   ' +
        '`CustomField7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField8`   ' +
        '`CustomField8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField9`   ' +
        '`CustomField9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `CustomField10`  ' +
        ' `CustomField10` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `EquipmentName`  ' +
        ' `EquipmentName` varchar(100) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `SupplierProductC' +
        'ode`   `SupplierProductCode` varchar(50) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `supplierProductn' +
        'ame`   `supplierProductname` varchar(50) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblsmartorderlines` CHANGE COLUMN `PartBarCode`   `' +
        'PartBarCode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsmartorderlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsource` CHANGE COLUMN `GlobalRef`   `GlobalRef` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsource` CHANGE COLUMN `MediaType`   `MediaType` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsource`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblstockadjustentry` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentry` CHANGE COLUMN `Accountname`   ' +
        '`Accountname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblstockadjustentry` CHANGE COLUMN `Notes`   `Notes' +
        '` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentry` CHANGE COLUMN `Employee`   `Em' +
        'ployee` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentry` CHANGE COLUMN `ImportgroupOrig' +
        'inalno`   `ImportgroupOriginalno` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      'ALTER TABLE `tblstockadjustentry`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `AccountNam' +
        'e`   `AccountName` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `ProductNam' +
        'e`   `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `PartBarcod' +
        'e`   `PartBarcode` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `Descriptio' +
        'n`   `Description` varchar(255) CHARACTER SET utf8 DEFAULT NULL ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `Serialnos`' +
        '   `Serialnos` longtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `ClassName`' +
        '   `ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `BatchNo`  ' +
        ' `BatchNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `BinLocatio' +
        'n`   `BinLocation` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `BinNumber`' +
        '   `BinNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `SerialNumb' +
        'er`   `SerialNumber` varchar(50) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `UOM`   `UO' +
        'M` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines` CHANGE COLUMN `Parttype` ' +
        '  `Parttype` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockadjustentrylines`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblstocklastcostadjustments` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblstocklastcostadjustments` CHANGE COLUMN `TransTy' +
        'pe`   `TransType` varchar(100) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblstocklastcostadjustments`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tblstockmovement` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovement` CHANGE COLUMN `StockmovementEntry' +
        'globalref`   `StockmovementEntryglobalref` varchar(255) DEFAULT ' +
        'NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovement` CHANGE COLUMN `StockmovementEntry' +
        'Type`   `StockmovementEntryType` varchar(255) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovement` CHANGE COLUMN `Notes`   `Notes` t' +
        'ext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovement` CHANGE COLUMN `Employee`   `Emplo' +
        'yee` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblstockmovement`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `ProductName` ' +
        '  `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `Description` ' +
        '  `Description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `ClassName`   ' +
        '`ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `AccountName` ' +
        '  `AccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `Serials`   `S' +
        'erials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `UOM`   `UOM` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstockmovementlines` CHANGE COLUMN `Parttype`   `' +
        'Parttype` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblstockmovementlines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblstocktransferentry` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentry` CHANGE COLUMN `StockMovement' +
        'Globalref`   `StockMovementGlobalref` varchar(255) DEFAULT NULL ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentry` CHANGE COLUMN `TransferFromC' +
        'lassName`   `TransferFromClassName` varchar(255) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentry` CHANGE COLUMN `EmployeeName`' +
        '   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblstocktransferentry` CHANGE COLUMN `Notes`   `Not' +
        'es` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentry` CHANGE COLUMN `Accountname` ' +
        '  `Accountname` varchar(100) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblstocktransferentry`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `Customer' +
        'Name`   `CustomerName` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `ClassNam' +
        'eTo`   `ClassNameTo` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `ProductN' +
        'ame`   `ProductName` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `PartBarc' +
        'ode`   `PartBarcode` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `ProductD' +
        'esc`   `ProductDesc` varchar(255) CHARACTER SET utf8 DEFAULT NUL' +
        'L COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `DescAttr' +
        'ib1`   `DescAttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `DescAttr' +
        'ib2`   `DescAttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `DescAttr' +
        'ib3`   `DescAttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `DescAttr' +
        'ib4`   `DescAttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `DescAttr' +
        'ib5`   `DescAttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `UOM`   `' +
        'UOM` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `BatchNoF' +
        'rom`   `BatchNoFrom` varchar(50) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `BinLocat' +
        'ionFrom`   `BinLocationFrom` varchar(30) DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `BinNumbe' +
        'rFrom`   `BinNumberFrom` varchar(30) DEFAULT '#39#39' COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `BatchNoT' +
        'o`   `BatchNoTo` varchar(50) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `BinLocat' +
        'ionTo`   `BinLocationTo` varchar(30) DEFAULT '#39#39' COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `BinNumbe' +
        'rTo`   `BinNumberTo` varchar(30) DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `SerialNu' +
        'mber`   `SerialNumber` varchar(100) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblstocktransferentrylines` CHANGE COLUMN `Parttype' +
        '`   `Parttype` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblstocktransferentrylines`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblsundrytypes` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsundrytypes` CHANGE COLUMN `SundryDesc`   `Sundr' +
        'yDesc` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsundrytypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsuperannuation` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsuperannuation` CHANGE COLUMN `AccountNo`   `Acc' +
        'ountNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsuperannuation` CHANGE COLUMN `ClassName`   `Cla' +
        'ssName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsuperannuation` CHANGE COLUMN `SuperFund`   `Sup' +
        'erFund` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsuperannuation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblsupertype` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsupertype` CHANGE COLUMN `Description`   `Descri' +
        'ption` varchar(50) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblsupertype`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltablemanagement` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltablemanagement` CHANGE COLUMN `RoomPlanName`   ' +
        '`RoomPlanName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tbltablemanagement`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltablemanagementstatus` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbltablemanagementstatus` CHANGE COLUMN `StatusText' +
        '`   `StatusText` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltablemanagementstatus` CHANGE COLUMN `ColourName' +
        '`   `ColourName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltablemanagementstatus`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tbltablemanagementtemplates` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltablemanagementtemplates` CHANGE COLUMN `RoomPla' +
        'nName`   `RoomPlanName` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tbltablemanagementtemplates`  COLLATE='#39'utf8_general' +
        '_ci'#39';'
      
        'ALTER TABLE `tbltask` CHANGE COLUMN `GlobalRef`   `GlobalRef` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltask` CHANGE COLUMN `Description`   `Description' +
        '` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltask`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tbltax`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltaxcodes` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltaxcodes` CHANGE COLUMN `Name`   `Name` varchar(' +
        '5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltaxcodes` CHANGE COLUMN `Description`   `Descrip' +
        'tion` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltaxcodes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltaxscales` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltaxscales` CHANGE COLUMN `ScaleDescription`   `S' +
        'caleDescription` varchar(100) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      'ALTER TABLE `tbltaxscales`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltemplates` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltemplates` CHANGE COLUMN `TemplName`   `TemplNam' +
        'e` varchar(30) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltemplates` CHANGE COLUMN `TemplateClass`   `Temp' +
        'lateClass` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltemplates` CHANGE COLUMN `SQLString`   `SQLStrin' +
        'g` text NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltemplates` CHANGE COLUMN `DesignTimeSQLString`  ' +
        ' `DesignTimeSQLString` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltemplates`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltemplatetype` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltemplatetype` CHANGE COLUMN `TypeName`   `TypeNa' +
        'me` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltemplatetype`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltenderaccountprefs` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltenderaccountprefs` CHANGE COLUMN `Paymethod`   ' +
        '`Paymethod` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltenderaccountprefs` CHANGE COLUMN `Account`   `A' +
        'ccount` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltenderaccountprefs`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblterms` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblterms` CHANGE COLUMN `Terms`   `Terms` varchar(5' +
        '0) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblterms` CHANGE COLUMN `Description`   `Descriptio' +
        'n` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblterms`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltimeinc` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltimeinc`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltimesheetentry` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheetentry` CHANGE COLUMN `Type`   `Type` va' +
        'rchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheetentry` CHANGE COLUMN `WhoEntered`   `Wh' +
        'oEntered` varchar(64) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltimesheetentry`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `Job`   `Job` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `EmployeeName`   `Empl' +
        'oyeeName` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `ClassName`   `ClassNa' +
        'me` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `ServiceName`   `Servi' +
        'ceName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `PartName`   `PartName' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `PartsDescription`   `' +
        'PartsDescription` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `PayRateTypeName`   `P' +
        'ayRateTypeName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `Notes`   `Notes` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltimesheets` CHANGE COLUMN `Equipment`   `Equipme' +
        'nt` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltimesheets`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltntcustomerheader` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomerheader` CHANGE COLUMN `AccountCode`  ' +
        ' `AccountCode` varchar(9) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltntcustomerheader`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `AccountC' +
        'ode`   `AccountCode` varchar(9) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `ServiceG' +
        'roup`   `ServiceGroup` varchar(4) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `RateCalc' +
        'Type`   `RateCalcType` varchar(4) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `RTIDefau' +
        'ltCode`   `RTIDefaultCode` varchar(4) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tbltntcustomerservicetype` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbltntcustomerservicetype` CHANGE COLUMN `AccountCo' +
        'de`   `AccountCode` varchar(9) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicetype` CHANGE COLUMN `ServiceGr' +
        'oup`   `ServiceGroup` varchar(4) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicetype` CHANGE COLUMN `ServiceTy' +
        'pe`   `ServiceType` varchar(4) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicetype` CHANGE COLUMN `RateCalcT' +
        'ype`   `RateCalcType` varchar(4) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicetype`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `AccountCo' +
        'de`   `AccountCode` varchar(9) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `ServiceGr' +
        'oup`   `ServiceGroup` varchar(4) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `ServiceTy' +
        'pe`   `ServiceType` varchar(4) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `SourceRat' +
        'ingArea`   `SourceRatingArea` varchar(4) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `Destinati' +
        'onRatingArea`   `DestinationRatingArea` varchar(4) DEFAULT NULL ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `RateCalcu' +
        'lationType`   `RateCalculationType` varchar(4) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tbltntfileheader` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntfileheader` CHANGE COLUMN `Division`   `Divis' +
        'ion` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltntfileheader`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltntfiletrailer` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltntfiletrailer`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltntpostcodetoratingareazone` CHANGE COLUMN `Glob' +
        'alRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbltntpostcodetoratingareazone` CHANGE COLUMN `Pcod' +
        'e`   `Pcode` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntpostcodetoratingareazone` CHANGE COLUMN `RatR' +
        'ef`   `RatRef` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntpostcodetoratingareazone` CHANGE COLUMN `Zone' +
        '`   `Zone` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntpostcodetoratingareazone`  COLLATE='#39'utf8_gene' +
        'ral_ci'#39';'
      
        'ALTER TABLE `tbltntscheduleheader` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltntscheduleheader`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltntscheduleservicegroup` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltntscheduleservicegroup` CHANGE COLUMN `ServiceG' +
        'roup`   `ServiceGroup` varchar(4) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicegroup`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `GlobalRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `ServiceGroup`   `ServiceGroup` varchar(4) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `ServiceType`   `ServiceType` varchar(4) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `SourceRatingArea`   `SourceRatingArea` varchar(4) DEFAULT NUL' +
        'L COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `DestinationRatingArea`   `DestinationRatingArea` varchar(4) D' +
        'EFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `RateCalculationType`   `RateCalculationType` varchar(4) DEFAU' +
        'LT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates`  COLLATE='#39'ut' +
        'f8_general_ci'#39';'
      
        'ALTER TABLE `tbltntscheduleservicetype` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbltntscheduleservicetype` CHANGE COLUMN `ServiceGr' +
        'oup`   `ServiceGroup` varchar(4) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetype` CHANGE COLUMN `ServiceTy' +
        'pe`   `ServiceType` varchar(4) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetype`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tbltodo` CHANGE COLUMN `GlobalRef`   `GlobalRef` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltodo` CHANGE COLUMN `Description`   `Description' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltodo` CHANGE COLUMN `Result`   `Result` varchar(' +
        '255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltodo` CHANGE COLUMN `Type`   `Type` varchar(10) ' +
        'DEFAULT '#39'ToDo'#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltodo`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltodolines` CHANGE COLUMN `Results`   `Results` m' +
        'ediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltodolines` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltodolines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltraffic` CHANGE COLUMN `GlobalRef`   `GlobalRef`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltraffic` CHANGE COLUMN `Branch`   `Branch` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltraffic`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltrainerrates` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltrainerrates`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltraining` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltraining` CHANGE COLUMN `Description`   `Descrip' +
        'tion` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltraining`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltrainingday` CHANGE COLUMN `Globalref`   `Global' +
        'ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingday` CHANGE COLUMN `Description`   `Desc' +
        'ription` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingday` CHANGE COLUMN `TimeFrom`   `TimeFro' +
        'm` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingday` CHANGE COLUMN `TimeTo`   `TimeTo` v' +
        'archar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltrainingday`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltrainingdays` CHANGE COLUMN `Globalref`   `Globa' +
        'lref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltrainingdays`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltrainingemployeemodules` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodules` CHANGE COLUMN `Employee' +
        'Name`   `EmployeeName` varchar(100) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodules` CHANGE COLUMN `MoreTrai' +
        'ningDetails`   `MoreTrainingDetails` varchar(255) DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodules`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tbltrainingemployeemodulestatus` CHANGE COLUMN `Glo' +
        'balRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodulestatus` CHANGE COLUMN `Emp' +
        'loyeeName`   `EmployeeName` varchar(100) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodulestatus` CHANGE COLUMN `Mod' +
        'ulename`   `Modulename` varchar(100) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodulestatus`  COLLATE='#39'utf8_gen' +
        'eral_ci'#39';'
      
        'ALTER TABLE `tbltrainingemployeemodulestatusdetails` CHANGE COLU' +
        'MN `GlobalRef`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingemployeemodulestatusdetails`  COLLATE='#39'u' +
        'tf8_general_ci'#39';'
      
        'ALTER TABLE `tbltrainingmodules` CHANGE COLUMN `Globalref`   `Gl' +
        'obalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingmodules` CHANGE COLUMN `TrainingModuleNa' +
        'me`   `TrainingModuleName` varchar(100) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tbltrainingmodules` CHANGE COLUMN `TEMFieldname`   ' +
        '`TEMFieldname` varchar(100) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbltrainingmodules` CHANGE COLUMN `Videofilename`  ' +
        ' `Videofilename` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltrainingmodules` CHANGE COLUMN `ModuleHelpcontex' +
        'tID`   `ModuleHelpcontextID` varchar(50) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      'ALTER TABLE `tbltrainingmodules`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltrainingmoduletask` CHANGE COLUMN `Globalref`   ' +
        '`Globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingmoduletask` CHANGE COLUMN `TrainingModul' +
        'eName`   `TrainingModuleName` varchar(100) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingmoduletask` CHANGE COLUMN `TrainingModul' +
        'eTaskTitle`   `TrainingModuleTaskTitle` varchar(100) DEFAULT NUL' +
        'L COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltrainingmoduletask` CHANGE COLUMN `TrainingModul' +
        'eTaskDescription`   `TrainingModuleTaskDescription` longtext COL' +
        'LATE utf8_general_ci ;'
      'ALTER TABLE `tbltrainingmoduletask`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltransactionmapper` CHANGE COLUMN `GlobalRef`   `' +
        'GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionmapper` CHANGE COLUMN `FromTranType` ' +
        '  `FromTranType` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltransactionmapper` CHANGE COLUMN `ToTranType`   ' +
        '`ToTranType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionmapper` CHANGE COLUMN `MasterMappings' +
        '`   `MasterMappings` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionmapper` CHANGE COLUMN `DetailMappings' +
        '`   `DetailMappings` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltransactionmapper`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Type`   `Type` varc' +
        'har(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `AccountName`   `Acc' +
        'ountName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `AccountGroupLevels`' +
        '   `AccountGroupLevels` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Level1`   `Level1` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Level2`   `Level2` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Level3`   `Level3` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Level4`   `Level4` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `AccountType`   `Acc' +
        'ountType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `ClientName`   `Clie' +
        'ntName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `ProductGroup`   `Pr' +
        'oductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `ProductDesc`   `Pro' +
        'ductDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `RepName`   `RepName' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `TaxCode`   `TaxCode' +
        '` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Notes`   `Notes` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions` CHANGE COLUMN `Chq/Ref`   `Chq/Ref' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltransactions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Type`   `Type' +
        '` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `AccountName` ' +
        '  `AccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `AccountGroupL' +
        'evels`   `AccountGroupLevels` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Level1`   `Le' +
        'vel1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Level2`   `Le' +
        'vel2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Level3`   `Le' +
        'vel3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Level4`   `Le' +
        'vel4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `AccountType` ' +
        '  `AccountType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `ClientName`  ' +
        ' `ClientName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `ProductName` ' +
        '  `ProductName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `ProductGroup`' +
        '   `ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `ProductDesc` ' +
        '  `ProductDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `RepName`   `R' +
        'epName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `TaxCode`   `T' +
        'axCode` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Notes`   `Not' +
        'es` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummary` CHANGE COLUMN `Chq/Ref`   `C' +
        'hq/Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tbltransactionsummary`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Type` ' +
        '  `Type` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Global' +
        'Ref`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Accoun' +
        'tName`   `AccountName` varchar(50) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Accoun' +
        'tGroupLevels`   `AccountGroupLevels` varchar(255) DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Level1' +
        '`   `Level1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Level2' +
        '`   `Level2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Level3' +
        '`   `Level3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Level4' +
        '`   `Level4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Accoun' +
        'tType`   `AccountType` varchar(50) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Client' +
        'Name`   `ClientName` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Produc' +
        'tName`   `ProductName` varchar(50) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Produc' +
        'tGroup`   `ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Produc' +
        'tDesc`   `ProductDesc` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `RepNam' +
        'e`   `RepName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `TaxCod' +
        'e`   `TaxCode` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Notes`' +
        '   `Notes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactionsummarydetails` CHANGE COLUMN `Chq/Re' +
        'f`   `Chq/Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tbltransactionsummarydetails`  COLLATE='#39'utf8_genera' +
        'l_ci'#39';'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Type`   ' +
        '`Type` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `GlobalRe' +
        'f`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `AccountN' +
        'ame`   `AccountName` varchar(50) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `AccountG' +
        'roupLevels`   `AccountGroupLevels` varchar(255) DEFAULT NULL COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Level1` ' +
        '  `Level1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Level2` ' +
        '  `Level2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Level3` ' +
        '  `Level3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Level4` ' +
        '  `Level4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `AccountT' +
        'ype`   `AccountType` varchar(50) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `ClientNa' +
        'me`   `ClientName` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `ProductN' +
        'ame`   `ProductName` varchar(60) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `ProductG' +
        'roup`   `ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `ProductD' +
        'esc`   `ProductDesc` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `RepName`' +
        '   `RepName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `TaxCode`' +
        '   `TaxCode` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Notes`  ' +
        ' `Notes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress` CHANGE COLUMN `Chq/Ref`' +
        '   `Chq/Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltransactions_inprogress`  COLLATE='#39'utf8_general_' +
        'ci'#39';'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `DeclarationType`   ' +
        '`DeclarationType` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `CurrentResponseType' +
        '`   `CurrentResponseType` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `CorrelationID`   `C' +
        'orrelationID` varchar(32) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `CurrentSentType`   ' +
        '`CurrentSentType` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `ErrorNumber`   `Err' +
        'orNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `ErrorType`   `Error' +
        'Type` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `ErrorMessage`   `Er' +
        'rorMessage` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `ResponseEndPoint`  ' +
        ' `ResponseEndPoint` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `ResponseClass`   `R' +
        'esponseClass` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblukgovgateway` CHANGE COLUMN `ProtocolState`   `P' +
        'rotocolState` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tblukgovgateway`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `DeclarationType' +
        '`   `DeclarationType` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `CurrentResponse' +
        'Type`   `CurrentResponseType` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `CorrelationID` ' +
        '  `CorrelationID` varchar(32) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `CurrentSentType' +
        '`   `CurrentSentType` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `ErrorNumber`   ' +
        '`ErrorNumber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `ErrorType`   `E' +
        'rrorType` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `ErrorMessage`  ' +
        ' `ErrorMessage` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `ResponseEndPoin' +
        't`   `ResponseEndPoint` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `ResponseClass` ' +
        '  `ResponseClass` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tblukgovgatewaytest` CHANGE COLUMN `ProtocolState` ' +
        '  `ProtocolState` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      'ALTER TABLE `tblukgovgatewaytest`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitbookingdockets` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookingdockets` CHANGE COLUMN `DocketNum`   ' +
        '`DocketNum` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookingdockets` CHANGE COLUMN `Notes`   `Not' +
        'es` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunitbookingdockets`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitbookinglines` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunitbookinglines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `PONumber`   `PONumb' +
        'er` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `BookedBy`   `Booked' +
        'By` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Contact`   `Contact' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Phone`   `Phone` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Mobile`   `Mobile` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Notes`   `Notes` te' +
        'xt COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Address`   `Address' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `ShipAddress`   `Shi' +
        'pAddress` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Location`   `Locati' +
        'on` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `ContactWhoBooked`  ' +
        ' `ContactWhoBooked` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblunitbookings` CHANGE COLUMN `Equipment`   `Equip' +
        'ment` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunitbookings`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitbookingservices` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookingservices` CHANGE COLUMN `CrewName`   ' +
        '`CrewName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitbookingservices` CHANGE COLUMN `ServiceName`' +
        '   `ServiceName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      'ALTER TABLE `tblunitbookingservices`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunits` CHANGE COLUMN `GlobalRef`   `GlobalRef` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunits` CHANGE COLUMN `EquipType`   `EquipType` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunits` CHANGE COLUMN `Description`   `Descriptio' +
        'n` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunits`  COLLATE='#39'utf8_general_ci'#39';'
      'ALTER TABLE `tblunitservices`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitservicesrqd` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunitservicesrqd`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitservicestimeframes`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tblunitskillsrqd` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitskillsrqd` CHANGE COLUMN `Skill`   `Skill` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunitskillsrqd`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitsofmeasure` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitsofmeasure` CHANGE COLUMN `UnitName`   `Unit' +
        'Name` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitsofmeasure` CHANGE COLUMN `UnitDescription` ' +
        '  `UnitDescription` varchar(35) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tblunitsofmeasure` CHANGE COLUMN `BaseUnitName`   `' +
        'BaseUnitName` varchar(15) DEFAULT '#39'Units'#39' COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tblunitsofmeasure`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunitsoftime` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitsoftime` CHANGE COLUMN `UnitOfTimeName`   `U' +
        'nitOfTimeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tblunitsoftime`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunittimeframes` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunittimeframes` CHANGE COLUMN `TimeName`   `Time' +
        'Name` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunittimeframes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunittypes` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunittypes` CHANGE COLUMN `TypeDescription`   `Ty' +
        'peDescription` varchar(250) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblunittypes` CHANGE COLUMN `Capacity`   `Capacity`' +
        ' varchar(250) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunittypes` CHANGE COLUMN `Description`   `Descri' +
        'ption` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunittypes`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunpacksegproduct` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunpacksegproduct` CHANGE COLUMN `ProductUOM`   `' +
        'ProductUOM` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblunpacksegproduct`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblunpacksegproductlines` CHANGE COLUMN `GlobalRef`' +
        '   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblunpacksegproductlines` CHANGE COLUMN `ProductUOM' +
        '`   `ProductUOM` varchar(50) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblunpacksegproductlines`  COLLATE='#39'utf8_general_ci' +
        #39';'
      
        'ALTER TABLE `tblupdatedetails` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblupdatedetails` CHANGE COLUMN `Version`   `Versio' +
        'n` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblupdatedetails` CHANGE COLUMN `Changes`   `Change' +
        's` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblupdatedetails` CHANGE COLUMN `UserVersion`   `Us' +
        'erVersion` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblupdatedetails`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VATDesc`   `VATDesc` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `Type`   `Type` varcha' +
        'r(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `Month`   `Month` varc' +
        'har(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT1Selected`   `VAT1' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT2Selected`   `VAT2' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT3Selected`   `VAT3' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT4Selected`   `VAT4' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT5Selected`   `VAT5' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT6Selected`   `VAT6' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT7Selected`   `VAT7' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT8Selected`   `VAT8' +
        'Selected` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvatreturns` CHANGE COLUMN `VAT9Selected`   `VAT9' +
        'Selected` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblvatreturns`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblvouchers` CHANGE COLUMN `GlobalRef`   `GlobalRef' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvouchers` CHANGE COLUMN `VoucherNo`   `VoucherNo' +
        '` varchar(20) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblvouchers` CHANGE COLUMN `IssuedBy`   `IssuedBy` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblvouchers`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `GlobalRef`   `GlobalR' +
        'ef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `InvoiceRefNo`   `Invo' +
        'iceRefNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `Notes`   `Notes` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `ReferenceNo`   `Refer' +
        'enceNo` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `CardholdersName`   `C' +
        'ardholdersName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `CreditCardNumber`   `' +
        'CreditCardNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `CompanyName`   `Compa' +
        'nyName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `BankAccountName`   `B' +
        'ankAccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `BankAccountBSB`   `Ba' +
        'nkAccountBSB` varchar(7) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `BankAccountNo`   `Ban' +
        'kAccountNo` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblwithdrawal`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblwithdrawallines` CHANGE COLUMN `GlobalRef`   `Gl' +
        'obalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawallines` CHANGE COLUMN `TrnType`   `TrnT' +
        'ype` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawallines` CHANGE COLUMN `PONo`   `PONo` v' +
        'archar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawallines` CHANGE COLUMN `InvoiceNo`   `In' +
        'voiceNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawallines` CHANGE COLUMN `PaidInFull`   `P' +
        'aidInFull` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblwithdrawallines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblwoallocation` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblwoallocation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `SerialNumber`   `Se' +
        'rialNumber` mediumtext NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `UsedSerials`   `Use' +
        'dSerials` mediumtext NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `DescAttrib1`   `Des' +
        'cAttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `DescAttrib2`   `Des' +
        'cAttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `DescAttrib3`   `Des' +
        'cAttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `DescAttrib4`   `Des' +
        'cAttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblwoalloclines` CHANGE COLUMN `DescAttrib5`   `Des' +
        'cAttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      'ALTER TABLE `tblwoalloclines`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblwolineassembly` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwolineassembly` CHANGE COLUMN `FullDescription` ' +
        '  `FullDescription` text COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblwolineassembly`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblworkcover` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblworkcover` CHANGE COLUMN `Workcover`   `Workcove' +
        'r` varchar(150) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblworkcover`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblworkerscompensation` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblworkerscompensation` CHANGE COLUMN `Description`' +
        '   `Description` varchar(150) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblworkerscompensation` CHANGE COLUMN `ClassName`  ' +
        ' `ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblworkerscompensation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblworkorder` CHANGE COLUMN `GlobalRef`   `GlobalRe' +
        'f` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblworkorder`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tblworkorderline` CHANGE COLUMN `GlobalRef`   `Glob' +
        'alRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tblworkorderline`  COLLATE='#39'utf8_general_ci'#39';'
      ''
      
        'update tbltemplates Set SQLString := replace(SQLString , '#39'LENGTH' +
        '('#39' , '#39'CHAR_LENGTH('#39') where tbltemplates.SQLString like '#39'%length(' +
        '%'#39' ;'
      
        'update tbltemplates Set SQLString := replace(SQLString , '#39'length' +
        '('#39' , '#39'CHAR_LENGTH('#39') where tbltemplates.SQLString like '#39'%length(' +
        '%'#39' ;'
      
        'update tbltemplates Set SQLString := replace(SQLString , '#39'Length' +
        '('#39' , '#39'CHAR_LENGTH('#39') where tbltemplates.SQLString like '#39'%length(' +
        '%'#39' ;'
      ''
      'DROP TABLE IF EXISTS `tmp_7468fix_saleslines`;'
      'DROP TABLE IF EXISTS `tmp_7468fix_purchaselinesbeforeupdate`;'
      'DROP TABLE IF EXISTS `tmp_7468fix_saleslinesbeforeupdate`;'
      'DROP TABLE IF EXISTS `tmp_7470parts`;'
      'DROP TABLE IF EXISTS `tmp_7470marketingleads`;'
      'DROP TABLE IF EXISTS `tmp_7468fix_purchaselines`;'
      'DROP TABLE IF EXISTS `tmp_7462fix_pqadetails`;'
      'DROP TABLE IF EXISTS `tmp_7462fix_pqa`;'
      'DROP TABLE IF EXISTS `tmp_7462fix_proctree`;'
      'DROP TABLE IF EXISTS `tmp_7462fix_tblproctreepart`;'
      'DROP TABLE IF EXISTS `tmp_7462fix_proctreepart`;'
      ''
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `UOM`   `UOM` varchar(' +
        '50) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `ProductName`   `Produ' +
        'ctName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `ProductColumn1`   `Pr' +
        'oductColumn1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `ProductColumn2`   `Pr' +
        'oductColumn2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `ProductColumn3`   `Pr' +
        'oductColumn3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `PartsDescription`   `' +
        'PartsDescription` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `Classname`   `Classna' +
        'me` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `Batchnumber`   `Batch' +
        'number` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `ExpiryDate`   `Expiry' +
        'Date` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `Binlocation`   `Binlo' +
        'cation` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `Binnumber`   `Binnumb' +
        'er` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `Serialnumber`   `Seri' +
        'alnumber` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_adjustuom` CHANGE COLUMN `Reason`   `Reason` va' +
        'rchar(100) DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_adjustuom`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_allocation` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_allocation` CHANGE COLUMN `ParentRef`   `Parent' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_allocation` CHANGE COLUMN `Value`   `Value` var' +
        'char(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_allocation` CHANGE COLUMN `Newglobalref`   `New' +
        'globalref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_allocation`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_autoalloc` CHANGE COLUMN `alloctype`   `allocty' +
        'pe` varchar(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_autoalloc` CHANGE COLUMN `Value`   `Value` varc' +
        'har(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_autoalloc` CHANGE COLUMN `UOM`   `UOM` varchar(' +
        '50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_autoalloc`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_bankrec` CHANGE COLUMN `ReconciledFlagtype`   `' +
        'ReconciledFlagtype` varchar(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_bankrec` CHANGE COLUMN `Description`   `Descrip' +
        'tion` varchar(50) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_bankrec` CHANGE COLUMN `Category`   `Category` ' +
        'varchar(50) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_bankrec` CHANGE COLUMN `ReferenceNo`   `Referen' +
        'ceNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_bankrec` CHANGE COLUMN `Notes`   `Notes` varcha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_bankrec` CHANGE COLUMN `CompanyName`   `Company' +
        'Name` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_bankrec`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `PARTNAME`   `PARTNAME` ' +
        'varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `classname`   `classname' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `UOM`   `UOM` varchar(50' +
        ') DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `Batchno`   `Batchno` va' +
        'rchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `StockmovementEntrygloba' +
        'lref`   `StockmovementEntryglobalref` varchar(255) DEFAULT NULL ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `TransType`   `TransType' +
        '` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `formName`   `formName` ' +
        'varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_batches` CHANGE COLUMN `Alloctype`   `Alloctype' +
        '` varchar(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_batches`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_budget` CHANGE COLUMN `PeriodDescription`   `Pe' +
        'riodDescription` varchar(50) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_budget` CHANGE COLUMN `JobName`   `JobName` var' +
        'char(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_budget`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_foreignpurchase` CHANGE COLUMN `PurchaseOrderNu' +
        'mber`   `PurchaseOrderNumber` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tmp_foreignpurchase` CHANGE COLUMN `SupplierName`  ' +
        ' `SupplierName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_foreignpurchase` CHANGE COLUMN `ProductName`   ' +
        '`ProductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tmp_foreignpurchase`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_foreignsales` CHANGE COLUMN `InvoiceDocNumber` ' +
        '  `InvoiceDocNumber` varchar(255) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_foreignsales` CHANGE COLUMN `CustomerName`   `C' +
        'ustomerName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_foreignsales` CHANGE COLUMN `ProductName`   `Pr' +
        'oductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_foreignsales`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `Accounts`   `Acco' +
        'unts` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `Type`   `Type` va' +
        'rchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `GlobalRef`   `Glo' +
        'balRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `Class`   `Class` ' +
        'varchar(60) DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `AccountName`   `A' +
        'ccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `Client Name`   `C' +
        'lient Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `ProductDescriptio' +
        'n`   `ProductDescription` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `RepName`   `RepNa' +
        'me` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `TaxCode`   `TaxCo' +
        'de` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_generalledger` CHANGE COLUMN `AccountNumber`   ' +
        '`AccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tmp_generalledger`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `GlobalRef`   `Global' +
        'Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Type`   `Type` varch' +
        'ar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Name`   `Name` varch' +
        'ar(122) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `ContactName`   `Cont' +
        'actName` varchar(122) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Street`   `Street` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Street2`   `Street2`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Street3`   `Street3`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Suburb`   `Suburb` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `State`   `State` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Postcode`   `Postcod' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Country`   `Country`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Phone`   `Phone` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `JobName`   `JobName`' +
        ' varchar(39) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `FaxNumber`   `FaxNum' +
        'ber` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Mobile`   `Mobile` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Email`   `Email` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `Active`   `Active` v' +
        'archar(1) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `AccountNo`   `Accoun' +
        'tNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `StopCredit`   `StopC' +
        'redit` varchar(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillStreet`   `BillS' +
        'treet` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillStreet2`   `Bill' +
        'Street2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillStreet3`   `Bill' +
        'Street3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillSuburb`   `BillS' +
        'uburb` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillState`   `BillSt' +
        'ate` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillPostcode`   `Bil' +
        'lPostcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `BillCountry`   `Bill' +
        'Country` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD1`   `CUSTFLD' +
        '1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD2`   `CUSTFLD' +
        '2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD3`   `CUSTFLD' +
        '3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD4`   `CUSTFLD' +
        '4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD5`   `CUSTFLD' +
        '5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD6`   `CUSTFLD' +
        '6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD7`   `CUSTFLD' +
        '7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD8`   `CUSTFLD' +
        '8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD9`   `CUSTFLD' +
        '9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD10`   `CUSTFL' +
        'D10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD11`   `CUSTFL' +
        'D11` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD12`   `CUSTFL' +
        'D12` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD13`   `CUSTFL' +
        'D13` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD14`   `CUSTFL' +
        'D14` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_globallist` CHANGE COLUMN `CUSTFLD15`   `CUSTFL' +
        'D15` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_globallist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_grouppartsreorder` CHANGE COLUMN `PARTSNAME`   ' +
        '`PARTSNAME` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_grouppartsreorder` CHANGE COLUMN `PODesc`   `PO' +
        'Desc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_grouppartsreorder` CHANGE COLUMN `SupplierName`' +
        '   `SupplierName` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_grouppartsreorder` CHANGE COLUMN `ClassName`   ' +
        '`ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_grouppartsreorder` CHANGE COLUMN `UnitofMeasure' +
        '`   `UnitofMeasure` varchar(255) DEFAULT '#39'Units'#39' COLLATE utf8_ge' +
        'neral_ci ;'
      'ALTER TABLE `tmp_grouppartsreorder`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_paygpaymentsummary` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_paygpaymentsummary` CHANGE COLUMN `EmployeeName' +
        '`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_paygpaymentsummary` CHANGE COLUMN `UnionDescrip' +
        'tion`   `UnionDescription` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      'ALTER TABLE `tmp_paygpaymentsummary`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_payrollrecreport` CHANGE COLUMN `DateDescriptio' +
        'n`   `DateDescription` varchar(20) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      'ALTER TABLE `tmp_payrollrecreport`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_posummary` CHANGE COLUMN `ErrorCodeDesc`   `Err' +
        'orCodeDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_posummary`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_pqa20090417` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_pqa20090417` CHANGE COLUMN `TransType`   `Trans' +
        'Type` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_pqa20090417` CHANGE COLUMN `Alloctype`   `Alloc' +
        'type` varchar(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_pqa20090417` CHANGE COLUMN `UOM`   `UOM` varcha' +
        'r(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_pqa20090417` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_pqa20090417`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_prepayments` CHANGE COLUMN `Company`   `Company' +
        '` varchar(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_prepayments` CHANGE COLUMN `PrepaymentCompanyna' +
        'me`   `PrepaymentCompanyname` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      'ALTER TABLE `tmp_prepayments`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `SaleDocNumber` ' +
        '  `SaleDocNumber` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `CustomerName`  ' +
        ' `CustomerName` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `LineProductName' +
        '`   `LineProductName` varchar(255) NOT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `LineProductDesc' +
        'ription`   `LineProductDescription` varchar(255) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `StepDescription' +
        '`   `StepDescription` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `StepStatus`   `' +
        'StepStatus` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `ProcItem`   `Pr' +
        'ocItem` varchar(255) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `ProcItemDescrip' +
        'tion`   `ProcItemDescription` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `ProcItemDetails' +
        '`   `ProcItemDetails` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `ProcItemPartTyp' +
        'e`   `ProcItemPartType` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_processpartlist` CHANGE COLUMN `ProcItemPartUom' +
        '`   `ProcItemPartUom` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      'ALTER TABLE `tmp_processpartlist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `SaleCustomer' +
        'Name`   `SaleCustomerName` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `Partname`   ' +
        '`Partname` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `PartsDescrip' +
        'tion`   `PartsDescription` varchar(255) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `Description`' +
        '   `Description` varchar(255) DEFAULT '#39'0'#39' COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `SaleDocNumbe' +
        'r`   `SaleDocNumber` varchar(30) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `LineProductN' +
        'ame`   `LineProductName` varchar(60) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `LineProductD' +
        'escription`   `LineProductDescription` varchar(255) DEFAULT NULL' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `Status`   `S' +
        'tatus` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `UOM`   `UOM`' +
        ' varchar(50) NOT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionpartlist` CHANGE COLUMN `Selected`   ' +
        '`Selected` varchar(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tmp_productionpartlist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ResourceNam' +
        'e`   `ResourceName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ProcessDesc' +
        'ription`   `ProcessDescription` varchar(255) DEFAULT '#39'0'#39' COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `IsProcess` ' +
        '  `IsProcess` varchar(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ProcessStat' +
        'us`   `ProcessStatus` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ItemCaption' +
        '`   `ItemCaption` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ItemIndentC' +
        'aption`   `ItemIndentCaption` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ItemDescrip' +
        'tion`   `ItemDescription` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ItemInfo`  ' +
        ' `ItemInfo` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `ItemDetails' +
        '`   `ItemDetails` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `SaleLinePro' +
        'ductName`   `SaleLineProductName` varchar(60) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `SaleLinePro' +
        'ductDescription`   `SaleLineProductDescription` varchar(255) DEF' +
        'AULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `SaleDocNumb' +
        'er`   `SaleDocNumber` varchar(30) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `SaleCustome' +
        'rName`   `SaleCustomerName` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `DurationFmt' +
        '`   `DurationFmt` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `SetupDurati' +
        'onFmt`   `SetupDurationFmt` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `BreakdownDu' +
        'rationFmt`   `BreakdownDurationFmt` varchar(255) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `UOM`   `UOM' +
        '` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet` CHANGE COLUMN `SaleLineUOM' +
        '`   `SaleLineUOM` varchar(100) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_productionworksheet`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tmp_productmatrix` CHANGE COLUMN `ProductName`   `P' +
        'roductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_productmatrix`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `TransType`   `T' +
        'ransType` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `FormName`   `Fo' +
        'rmName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `StockMovementEn' +
        'tryglobalref`   `StockMovementEntryglobalref` varchar(255) DEFAU' +
        'LT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `ProductName`   ' +
        '`ProductName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `FirstColumn`   ' +
        '`FirstColumn` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `SecondColumn`  ' +
        ' `SecondColumn` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_productmovement` CHANGE COLUMN `ThirdColumn`   ' +
        '`ThirdColumn` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      'ALTER TABLE `tmp_productmovement`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `Category`  ' +
        ' `Category` varchar(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `firstColumn' +
        '`   `firstColumn` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `Secondcolum' +
        'n`   `Secondcolumn` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `Thirdcolumn' +
        '`   `Thirdcolumn` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `ProductName' +
        '`   `ProductName` varchar(60) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `Transaction' +
        'Type`   `TransactionType` varchar(100) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `FormName`  ' +
        ' `FormName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `InvoiceNo` ' +
        '  `InvoiceNo` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CustomerNam' +
        'e`   `CustomerName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `UnitOfMeasu' +
        're`   `UnitOfMeasure` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `EmployeeNam' +
        'e`   `EmployeeName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `ProductDesc' +
        'ription`   `ProductDescription` varchar(255) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `IsSpecial` ' +
        '  `IsSpecial` varchar(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD1`  ' +
        ' `CUSTFLD1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD2`  ' +
        ' `CUSTFLD2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD3`  ' +
        ' `CUSTFLD3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD4`  ' +
        ' `CUSTFLD4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD5`  ' +
        ' `CUSTFLD5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD6`  ' +
        ' `CUSTFLD6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD7`  ' +
        ' `CUSTFLD7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD8`  ' +
        ' `CUSTFLD8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD9`  ' +
        ' `CUSTFLD9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD10` ' +
        '  `CUSTFLD10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD11` ' +
        '  `CUSTFLD11` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD12` ' +
        '  `CUSTFLD12` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD13` ' +
        '  `CUSTFLD13` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD14` ' +
        '  `CUSTFLD14` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `CUSTFLD15` ' +
        '  `CUSTFLD15` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `converted` ' +
        '  `converted` varchar(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary` CHANGE COLUMN `TypeName`  ' +
        ' `TypeName` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_productsalessummary`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `Partname`   `Partna' +
        'me` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `rootCaption`   `roo' +
        'tCaption` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `Caption`   `Caption' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `Details`   `Details' +
        '` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `TreePartsName`   `T' +
        'reePartsName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `InputType`   `Input' +
        'Type` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `CustomInputClass`  ' +
        ' `CustomInputClass` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `ProcStepItemRef`   ' +
        '`ProcStepItemRef` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `Value`   `Value` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `Info`   `Info` text' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `UOM`   `UOM` varcha' +
        'r(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `UOMPartname`   `UOM' +
        'Partname` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `ProcessStep`   `Pro' +
        'cessStep` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `ProcessPartPartname' +
        '`   `ProcessPartPartname` varchar(60) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `ResourceDescription' +
        '`   `ResourceDescription` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_producttree` CHANGE COLUMN `ResourceName`   `Re' +
        'sourceName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_producttree`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountType' +
        '`   `AccountType` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Description' +
        '`   `Description` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Accounts`  ' +
        ' `Accounts` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Account_Typ' +
        'e`   `Account_Type` varchar(50) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountName' +
        '`   `AccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountGrou' +
        'pLevels`   `AccountGroupLevels` varchar(255) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Level1`   `' +
        'Level1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Level2`   `' +
        'Level2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Level3`   `' +
        'Level3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `Level4`   `' +
        'Level4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountHead' +
        'erOrder`   `AccountHeaderOrder` varchar(255) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountSub1' +
        'Order`   `AccountSub1Order` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountSub2' +
        'Order`   `AccountSub2Order` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `AccountSub3' +
        'Order`   `AccountSub3Order` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `FilterWeekd' +
        'ay`   `FilterWeekday` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport` CHANGE COLUMN `FilterMonth' +
        'Name`   `FilterMonthName` varchar(255) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_profitandlossreport`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tmp_regedit` CHANGE COLUMN `KeyName`   `KeyName` te' +
        'xt COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_regedit` CHANGE COLUMN `RegName`   `RegName` va' +
        'rchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_regedit` CHANGE COLUMN `RegValue`   `RegValue` ' +
        'varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_regedit`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `TYPE`   `TYPE` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `DESCRIPTION`   `DE' +
        'SCRIPTION` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `CLIENT`   `CLIENT`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `IN DAYS`   `IN DAY' +
        'S` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `COMPANYLABEL`   `C' +
        'OMPANYLABEL` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `DAYNAME`   `DAYNAM' +
        'E` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_reminderlist` CHANGE COLUMN `NOTES`   `NOTES` t' +
        'ext COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_reminderlist`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `AccountName`   `Acc' +
        'ountName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `PartBarcode`   `Par' +
        'tBarcode` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `Description`   `Des' +
        'cription` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `ClassName`   `Class' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `UOM`   `UOM` varcha' +
        'r(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_saeproducts` CHANGE COLUMN `Parttype`   `Partty' +
        'pe` varchar(13) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_saeproducts`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_salesordermanufacturereport2` CHANGE COLUMN `Op' +
        'tionName`   `OptionName` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport2` CHANGE COLUMN `Op' +
        'tionInfo`   `OptionInfo` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport2` CHANGE COLUMN `Op' +
        'tionItem`   `OptionItem` varchar(255) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport2`  COLLATE='#39'utf8_ge' +
        'neral_ci'#39';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `TimeOfSale`   `Time' +
        'OfSale` varchar(11) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `TransactionType`   ' +
        '`TransactionType` varchar(9) NOT NULL DEFAULT '#39#39' COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CustomerName`   `Cu' +
        'stomerName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CustomerType`   `Cu' +
        'stomerType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Memo`   `Memo` text' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Comments`   `Commen' +
        'ts` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `OriginalNo`   `Orig' +
        'inalNo` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `InvoiceNumber`   `I' +
        'nvoiceNumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PONumber`   `PONumb' +
        'er` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `EmployeeName`   `Em' +
        'ployeeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `ConsignmentNote`   ' +
        '`ConsignmentNote` varchar(25) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `ClassName`   `Class' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `ProductType`   `Pro' +
        'ductType` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Manufacturer`   `Ma' +
        'nufacturer` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Type`   `Type` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Department`   `Depa' +
        'rtment` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `ProductName`   `Pro' +
        'ductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `ProductDescription`' +
        '   `ProductDescription` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `TaxCode`   `TaxCode' +
        '` varchar(5) DEFAULT '#39'GST'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PreferedSupplier`  ' +
        ' `PreferedSupplier` varchar(55) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD1`   `CUSTFL' +
        'D1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD2`   `CUSTFL' +
        'D2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD3`   `CUSTFL' +
        'D3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD4`   `CUSTFL' +
        'D4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD5`   `CUSTFL' +
        'D5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD6`   `CUSTFL' +
        'D6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD7`   `CUSTFL' +
        'D7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD8`   `CUSTFL' +
        'D8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD9`   `CUSTFL' +
        'D9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD10`   `CUSTF' +
        'LD10` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD11`   `CUSTF' +
        'LD11` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD12`   `CUSTF' +
        'LD12` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD13`   `CUSTF' +
        'LD13` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD14`   `CUSTF' +
        'LD14` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `CUSTFLD15`   `CUSTF' +
        'LD15` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `RunName`   `RunName' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `DescAttrib1`   `Des' +
        'cAttrib1` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `DescAttrib2`   `Des' +
        'cAttrib2` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `DescAttrib3`   `Des' +
        'cAttrib3` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `DescAttrib4`   `Des' +
        'cAttrib4` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `DescAttrib5`   `Des' +
        'cAttrib5` varchar(255) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '1`   `SalesLinesCustField1` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '2`   `SalesLinesCustField2` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '3`   `SalesLinesCustField3` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '4`   `SalesLinesCustField4` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '5`   `SalesLinesCustField5` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '6`   `SalesLinesCustField6` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '7`   `SalesLinesCustField7` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '8`   `SalesLinesCustField8` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '9`   `SalesLinesCustField9` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `SalesLinesCustField' +
        '10`   `SalesLinesCustField10` varchar(255) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `UnitOfMeasureSaleLi' +
        'nes`   `UnitOfMeasureSaleLines` varchar(255) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Till`   `Till` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Area`   `Area` varc' +
        'har(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `Source`   `Source` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `POSSource`   `POSSo' +
        'urce` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `WarrantyPeriod`   `' +
        'WarrantyPeriod` varchar(100) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `POSPostCode`   `POS' +
        'PostCode` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld1`   `P' +
        'artsCustFld1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld2`   `P' +
        'artsCustFld2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld3`   `P' +
        'artsCustFld3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld4`   `P' +
        'artsCustFld4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld5`   `P' +
        'artsCustFld5` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld6`   `P' +
        'artsCustFld6` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld7`   `P' +
        'artsCustFld7` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld8`   `P' +
        'artsCustFld8` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld9`   `P' +
        'artsCustFld9` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld10`   `' +
        'PartsCustFld10` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld11`   `' +
        'PartsCustFld11` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld12`   `' +
        'PartsCustFld12` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld13`   `' +
        'PartsCustFld13` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld14`   `' +
        'PartsCustFld14` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustFld15`   `' +
        'PartsCustFld15` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustDate1`   `' +
        'PartsCustDate1` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_salesreport` CHANGE COLUMN `PartsCustDate2`   `' +
        'PartsCustDate2` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      'ALTER TABLE `tmp_salesreport`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_salessummary` CHANGE COLUMN `ErrorCodeDesc`   `' +
        'ErrorCodeDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      'ALTER TABLE `tmp_salessummary`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_serialnumbers` CHANGE COLUMN `PartName`   `Part' +
        'Name` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_serialnumbers` CHANGE COLUMN `SerialNumber`   `' +
        'SerialNumber` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_serialnumbers` CHANGE COLUMN `Type`   `Type` va' +
        'rchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_serialnumbers` CHANGE COLUMN `Company`   `Compa' +
        'ny` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_serialnumbers` CHANGE COLUMN `Department`   `De' +
        'partment` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_serialnumbers` CHANGE COLUMN `Volume_UOM`   `Vo' +
        'lume_UOM` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_serialnumbers`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `Trans Type`   `Trans Type` ' +
        'varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `formName`   `formName` varc' +
        'har(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `StockmovementEntryglobalref' +
        '`   `StockmovementEntryglobalref` varchar(255) DEFAULT NULL COLL' +
        'ATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `Firstcolumn`   `Firstcolumn' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `Secondcolumn`   `Secondcolu' +
        'mn` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `Thirdcolumn`   `Thirdcolumn' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `Product`   `Product` varcha' +
        'r(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `ClassName`   `ClassName` va' +
        'rchar(255) DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssr` CHANGE COLUMN `Period`   `Period` varchar(' +
        '20) CHARACTER SET utf8 DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_ssr`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `className`   `className` v' +
        'archar(60) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `transType`   `transType` v' +
        'archar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `FormName`   `FormName` var' +
        'char(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `ProductName`   `ProductNam' +
        'e` varchar(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `Firstcolumn`   `Firstcolum' +
        'n` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `Secondcolumn`   `Secondcol' +
        'umn` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_ssrr` CHANGE COLUMN `Thirdcolumn`   `Thirdcolum' +
        'n` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_ssrr`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `Customer ' +
        'Name`   `Customer Name` varchar(255) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `JobName` ' +
        '  `JobName` varchar(39) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `TransID` ' +
        '  `TransID` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `Type`   `' +
        'Type` varchar(11) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `PONumber`' +
        '   `PONumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `ClassName' +
        '`   `ClassName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_statementrunningtotal` CHANGE COLUMN `ForeignEx' +
        'changeCode`   `ForeignExchangeCode` varchar(50) DEFAULT NULL COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statementrunningtotal`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `Customer Name`   `Cu' +
        'stomer Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `JobName`   `JobName`' +
        ' varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `Receipt No`   `Recei' +
        'pt No` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `Invoice Number`   `I' +
        'nvoice Number` varchar(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `Type`   `Type` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `Status`   `Status` v' +
        'archar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `PONumber`   `PONumbe' +
        'r` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `ClassName`   `ClassN' +
        'ame` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_statements` CHANGE COLUMN `Flag`   `Flag` varch' +
        'ar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_statements`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_statementsum` CHANGE COLUMN `Type`   `Type` var' +
        'char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_statementsum`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_stockstatus` CHANGE COLUMN `Productname`   `Pro' +
        'ductname` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_stockstatus` CHANGE COLUMN `UOM`   `UOM` varcha' +
        'r(100) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_stockstatus`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `SupplierName' +
        '`   `SupplierName` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `Type`   `Typ' +
        'e` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `PONumber`   ' +
        '`PONumber` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `InvoiceNumbe' +
        'r`   `InvoiceNumber` varchar(30) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `Name`   `Nam' +
        'e` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `AccountName`' +
        '   `AccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `APNotes`   `' +
        'APNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountspayable` CHANGE COLUMN `ForeignExcha' +
        'ngecode`   `ForeignExchangecode` varchar(50) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      'ALTER TABLE `tmp_tblaccountspayable`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CustomerN' +
        'ame`   `CustomerName` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CustomerT' +
        'ype`   `CustomerType` varchar(255) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `Type`   `' +
        'Type` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `InvoiceNu' +
        'mber`   `InvoiceNumber` varchar(30) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `Name`   `' +
        'Name` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `Transacti' +
        'onName`   `TransactionName` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD1`' +
        '   `CUSTFLD1` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD2`' +
        '   `CUSTFLD2` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD3`' +
        '   `CUSTFLD3` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD4`' +
        '   `CUSTFLD4` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD5`' +
        '   `CUSTFLD5` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD6`' +
        '   `CUSTFLD6` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD7`' +
        '   `CUSTFLD7` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD8`' +
        '   `CUSTFLD8` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD9`' +
        '   `CUSTFLD9` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD10' +
        '`   `CUSTFLD10` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD11' +
        '`   `CUSTFLD11` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD12' +
        '`   `CUSTFLD12` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD13' +
        '`   `CUSTFLD13` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD14' +
        '`   `CUSTFLD14` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `CUSTFLD15' +
        '`   `CUSTFLD15` varchar(50) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `Phone`   ' +
        '`Phone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `FaxNumber' +
        '`   `FaxNumber` varchar(20) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `Mobile`  ' +
        ' `Mobile` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `AltPhone`' +
        '   `AltPhone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `ARNotes` ' +
        '  `ARNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `AccountNa' +
        'me`   `AccountName` varchar(255) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `ForeignEx' +
        'changecode`   `ForeignExchangecode` varchar(50) DEFAULT NULL COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable` CHANGE COLUMN `PO_Number' +
        '`   `PO_Number` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_tblaccountsreceivable`  COLLATE='#39'utf8_general_c' +
        'i'#39';'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `GlobalRef`   ' +
        '`GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Company`   `C' +
        'ompany` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Title`   `Tit' +
        'le` varchar(10) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `First_Name`  ' +
        ' `First_Name` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Last_Name`   ' +
        '`Last_Name` varchar(30) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Address`   `A' +
        'ddress` varchar(38) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Stree2`   `St' +
        'ree2` varchar(38) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Suburb`   `Su' +
        'burb` varchar(27) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `State`   `Sta' +
        'te` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Postcode`   `' +
        'Postcode` varchar(4) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Bill_Address`' +
        '   `Bill_Address` varchar(40) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Bill_Street_2' +
        '`   `Bill_Street_2` varchar(40) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Bill_Suburb` ' +
        '  `Bill_Suburb` varchar(30) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Bill_State`  ' +
        ' `Bill_State` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Bill_Postcode' +
        '`   `Bill_Postcode` varchar(4) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Phone`   `Pho' +
        'ne` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Alt_Phone`   ' +
        '`Alt_Phone` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Mobile`   `Mo' +
        'bile` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Fax`   `Fax` ' +
        'varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Email`   `Ema' +
        'il` varchar(80) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Contact_1`   ' +
        '`Contact_1` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Contact_2`   ' +
        '`Contact_2` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Contact_1_Pho' +
        'ne`   `Contact_1_Phone` varchar(20) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Contact_2_Pho' +
        'ne`   `Contact_2_Phone` varchar(50) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Account_No`  ' +
        ' `Account_No` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `ABN`   `ABN` ' +
        'varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Job_Name`   `' +
        'Job_Name` varchar(39) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `Filler`   `Fi' +
        'ller` varchar(20) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tblmailmergeemail` CHANGE COLUMN `TypeName`   `' +
        'TypeName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_tblmailmergeemail`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Type`   `Type` ' +
        'varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `GlobalRef`   `G' +
        'lobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `AccountName`   ' +
        '`AccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `AccountGroupLev' +
        'els`   `AccountGroupLevels` varchar(255) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Level1`   `Leve' +
        'l1` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Level2`   `Leve' +
        'l2` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Level3`   `Leve' +
        'l3` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Level4`   `Leve' +
        'l4` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `AccountType`   ' +
        '`AccountType` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `ClientName`   `' +
        'ClientName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `ProductName`   ' +
        '`ProductName` varchar(60) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `ProductGroup`  ' +
        ' `ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `ProductDesc`   ' +
        '`ProductDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `RepName`   `Rep' +
        'Name` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `TaxCode`   `Tax' +
        'Code` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Notes`   `Notes' +
        '` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_tbltransactions` CHANGE COLUMN `Chq/Ref`   `Chq' +
        '/Ref` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_tbltransactions`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `Class`   `C' +
        'lass` varchar(60) DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `Type`   `Ty' +
        'pe` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `GlobalRef` ' +
        '  `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `AccountName' +
        '`   `AccountName` varchar(50) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `ClientName`' +
        '   `ClientName` varchar(255) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `ProductName' +
        '`   `ProductName` varchar(60) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `ProductDesc' +
        '`   `ProductDesc` varchar(255) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `TaxCode`   ' +
        '`TaxCode` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `Notes`   `N' +
        'otes` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails` CHANGE COLUMN `AccountType' +
        '`   `AccountType` varchar(100) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_transaccountdetails`  COLLATE='#39'utf8_general_ci'#39 +
        ';'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `GlobalRef`  ' +
        ' `GlobalRef` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `Type`   `Typ' +
        'e` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `Client Name`' +
        '   `Client Name` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `AccountName`' +
        '   `AccountName` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `Account Type' +
        '`   `Account Type` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `ProductName`' +
        '   `ProductName` varchar(60) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `ProductGroup' +
        '`   `ProductGroup` varchar(255) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `ProductDesc`' +
        '   `ProductDesc` varchar(255) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `TaxCode`   `' +
        'TaxCode` varchar(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `Account`   `' +
        'Account` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_transactionjournal` CHANGE COLUMN `AccountNumbe' +
        'r`   `AccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      'ALTER TABLE `tmp_transactionjournal`  COLLATE='#39'utf8_general_ci'#39';'
      
        'ALTER TABLE `tmp_trialbalance` CHANGE COLUMN `AccountName`   `Ac' +
        'countName` varchar(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_trialbalance` CHANGE COLUMN `AccountNameOnly`  ' +
        ' `AccountNameOnly` varchar(50) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_trialbalance` CHANGE COLUMN `AccountNumber`   `' +
        'AccountNumber` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tmp_trialbalance` CHANGE COLUMN `Account`   `Accoun' +
        't` varchar(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      'ALTER TABLE `tmp_trialbalance`  COLLATE='#39'utf8_general_ci'#39';'
      ''
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `St' +
        'ate`   `State` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Po' +
        'stcode`   `Postcode` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ph' +
        'oneNumber`   `PhoneNumber` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Fa' +
        'xNumber`   `FaxNumber` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `AB' +
        'N`   `ABN` varchar(15) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'mpanyName`   `CompanyName` varchar(200) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ad' +
        'dress`   `Address` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ad' +
        'dress2`   `Address2` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ci' +
        'ty`   `City` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesGlobalRef`   `SalesGlobalRef` Text DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `In' +
        'voiceDocNumber`   `InvoiceDocNumber` varchar(30) DEFAULT NULL CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Or' +
        'iginalNo`   `OriginalNo` Text DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ba' +
        'seNo`   `BaseNo` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ac' +
        'count`   `Account` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `BO' +
        'ID`   `BOID` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stomerName`   `CustomerName` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `In' +
        'voiceTo`   `InvoiceTo` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sh' +
        'ipTo`   `ShipTo` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pi' +
        'ckupFrom`   `PickupFrom` Text DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Em' +
        'ployeeName`   `EmployeeName` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cl' +
        'ass`   `Class` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Or' +
        'derNumber`   `OrderNumber` varchar(30) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `PO' +
        'Number`   `PONumber` varchar(30) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ch' +
        'equeNo`   `ChequeNo` varchar(45) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'nNote`   `ConNote` varchar(25) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Me' +
        'mo`   `Memo` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'mments`   `Comments` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `In' +
        'voicePrintDesc`   `InvoicePrintDesc` Text DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pi' +
        'ckMemo`   `PickMemo` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sh' +
        'ipping`   `Shipping` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Te' +
        'rms`   `Terms` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pa' +
        'yMethod`   `PayMethod` varchar(50) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pa' +
        'yDueDate`   `PayDueDate` varchar(11) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ti' +
        'meOfSale`   `TimeOfSale` varchar(11) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ti' +
        'llName`   `TillName` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `En' +
        'teredBy`   `EnteredBy` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `En' +
        'teredAt`   `EnteredAt` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesOrderGlobalRef`   `SalesOrderGlobalRef` Text DEFAULT NULL COM' +
        'MENT '#39'globalref of the converted Sales Order. SalesOrder -->Invo' +
        'ic'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Qu' +
        'oteGlobalRef`   `QuoteGlobalRef` Text DEFAULT NULL COMMENT '#39'glob' +
        'alref of the converted Quote. Quote --> Invoice/SalesOrd'#39' COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Re' +
        'pairGlobalRef`   `RepairGlobalRef` Text DEFAULT NULL COMMENT '#39'Gl' +
        'obalref of the converted Repairs. Repairs--> Invoice'#39' COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `AR' +
        'Notes`   `ARNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Qu' +
        'oteStatus`   `QuoteStatus` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ru' +
        'nName`   `RunName` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Re' +
        'ference`   `Reference` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Au' +
        'toSmartOrderRef`   `AutoSmartOrderRef` Text DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntactName`   `ContactName` varchar(100) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `PO' +
        'SPostCode`   `POSPostCode` varchar(4) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Me' +
        'dtype`   `Medtype` varchar(100) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `PA' +
        'RTTYPE`   `PARTTYPE` varchar(13) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `IN' +
        'COMEACCNT`   `INCOMEACCNT` varchar(50) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `AS' +
        'SETACCNT`   `ASSETACCNT` varchar(50) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `CO' +
        'GSACCNT`   `COGSACCNT` varchar(50) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pr' +
        'oductGroup`   `ProductGroup` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pr' +
        'oductName`   `ProductName` varchar(60) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pr' +
        'oduct_Description`   `Product_Description` Text DEFAULT NULL COL' +
        'LATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pr' +
        'oduct_Description_Memo`   `Product_Description_Memo` longtext CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Li' +
        'neTaxCode`   `LineTaxCode` varchar(5) DEFAULT '#39#39' COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Un' +
        'itofMeasure`   `UnitofMeasure` Text DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `So' +
        'ldSerials`   `SoldSerials` mediumtext COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `De' +
        'scAttrib3`   `DescAttrib3` Text NOT NULL DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `De' +
        'scAttrib1`   `DescAttrib1` Text NOT NULL DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `De' +
        'scAttrib2`   `DescAttrib2` Text NOT NULL DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Su' +
        'pplier`   `Supplier` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Su' +
        'pplierContact`   `SupplierContact` Text DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `De' +
        'scAttrib4`   `DescAttrib4` Text NOT NULL DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `De' +
        'scAttrib5`   `DescAttrib5` Text NOT NULL DEFAULT '#39#39' COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Ar' +
        'ea`   `Area` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Se' +
        'archFilter`   `SearchFilter` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Se' +
        'archFilterCopy`   `SearchFilterCopy` Text DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Do' +
        'cketNumber`   `DocketNumber` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sp' +
        'ecDescription`   `SpecDescription` Text DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Wa' +
        'rrantyPeriod`   `WarrantyPeriod` varchar(100) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField1`   `SalesLinesCustField1` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField2`   `SalesLinesCustField2` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField3`   `SalesLinesCustField3` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField4`   `SalesLinesCustField4` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField5`   `SalesLinesCustField5` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField6`   `SalesLinesCustField6` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField7`   `SalesLinesCustField7` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField8`   `SalesLinesCustField8` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField9`   `SalesLinesCustField9` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Sa' +
        'lesLinesCustField10`   `SalesLinesCustField10` Text DEFAULT NULL' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Li' +
        'neNotes`   `LineNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stomData`   `CustomData` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Me' +
        'moLine`   `MemoLine` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Re' +
        'latedParentLineRef`   `RelatedParentLineRef` Text DEFAULT NULL C' +
        'OLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Pa' +
        'rtBarcode`   `PartBarcode` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'mpanyContact`   `CompanyContact` varchar(114) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stJobName`   `CustJobName` varchar(79) DEFAULT NULL COLLATE utf8' +
        '_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stABN`   `CustABN` varchar(15) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stTitle`   `CustTitle` varchar(32) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stFirstName`   `CustFirstName` varchar(40) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stMiddleName`   `CustMiddleName` varchar(40) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stLastName`   `CustLastName` varchar(40) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stStreet`   `CustStreet` Text DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stStreet2`   `CustStreet2` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stSuburb`   `CustSuburb` Text DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stState`   `CustState` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stCountry`   `CustCountry` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPostcode`   `CustPostcode` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stBillStreet`   `CustBillStreet` Text DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stBillStreet2`   `CustBillStreet2` Text DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stBillSuburb`   `CustBillSuburb` Text DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stBillState`   `CustBillState` Text DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stBillCountry`   `CustBillCountry` Text DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stBillPostcode`   `CustBillPostcode` Text DEFAULT NULL COLLATE u' +
        'tf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPOBox`   `CustPOBox` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      ''
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPOSuburb`   `CustPOSuburb` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPOState`   `CustPOState` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPOCountry`   `CustPOCountry` Text DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPOPostcode`   `CustPOPostcode` Text DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stPhone`   `CustPhone` varchar(20) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stFaxNumber`   `CustFaxNumber` varchar(20) DEFAULT NULL COLLATE ' +
        'utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stMobile`   `CustMobile` varchar(20) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stEmail`   `CustEmail` varchar(80) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stAltContact`   `CustAltContact` varchar(50) DEFAULT NULL COLLAT' +
        'E utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cu' +
        'stAltPhone`   `CustAltPhone` varchar(20) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Cl' +
        'ientNo`   `ClientNo` varchar(50) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `De' +
        'liveryNotes`   `DeliveryNotes` text COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Su' +
        'ppProdCode`   `SuppProdCode` varchar(50) DEFAULT NULL COLLATE ut' +
        'f8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntEmail`   `ContEmail` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntTitle`   `ContTitle` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntFirstName`   `ContFirstName` Text DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntSurname`   `ContSurname` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntAddress`   `ContAddress` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntAddress2`   `ContAddress2` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntAddress3`   `ContAddress3` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntCity`   `ContCity` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntState`   `ContState` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntPostcode`   `ContPostcode` Text DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntCountry`   `ContCountry` Text DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntPh`   `ContPh` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntAltPh`   `ContAltPh` Text DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntMob`   `ContMob` Text DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Co' +
        'ntactFax`   `ContactFax` Text DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1`  COLLATE='#39'utf8_ge' +
        'neral_ci'#39';'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `RecordType`' +
        '   `RecordType` char(1) DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `ReelSequenc' +
        'eNumber`   `ReelSequenceNumber` char(2) DEFAULT '#39'01'#39' COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `UserBankNam' +
        'e`   `UserBankName` char(3) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblabadescriptiverecord` CHANGE COLUMN `ProcessingI' +
        'ndicator`   `ProcessingIndicator` char(1) NOT NULL DEFAULT '#39#39' CO' +
        'LLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `RecordType`   `R' +
        'ecordType` char(1) DEFAULT '#39'1'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `Indicator`   `In' +
        'dicator` char(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblabadetailrecord` CHANGE COLUMN `TransactionCode`' +
        '   `TransactionCode` char(2) DEFAULT NULL COLLATE utf8_general_c' +
        'i ;'
      
        'ALTER TABLE `tblabatranscode` CHANGE COLUMN `TransCode`   `Trans' +
        'Code` char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblatosubmissiondetails` CHANGE COLUMN `Active`   `' +
        'Active` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblatosubmissiondetails` CHANGE COLUMN `IsTerminate' +
        'd`   `IsTerminated` char(1) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblawordmerge` CHANGE COLUMN `State`   `State` char' +
        '(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblbankcodes` CHANGE COLUMN `BankCode`   `BankCode`' +
        ' char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcardfast` CHANGE COLUMN `TxType`   `TxType` char' +
        '(1) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblchartofaccounts` CHANGE COLUMN `BankCode`   `Ban' +
        'kCode` char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclass` CHANGE COLUMN `SiteCode`   `SiteCode` cha' +
        'r(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclassificationdeductions` CHANGE COLUMN `GlobalR' +
        'ef`   `GlobalRef` char(255) DEFAULT NULL COLLATE utf8_general_ci' +
        ' ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `BankCode`   `BankCode` c' +
        'har(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblclients` CHANGE COLUMN `ForeignExchangeSellCode`' +
        '   `ForeignExchangeSellCode` char(3) DEFAULT NULL COLLATE utf8_g' +
        'eneral_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `CommAgg1`   `Comm' +
        'Agg1` char(1) DEFAULT '#39'-'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `CommAgg2`   `Comm' +
        'Agg2` char(1) DEFAULT '#39'-'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `CommAgg3`   `Comm' +
        'Agg3` char(1) DEFAULT '#39'-'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcolumnheadings` CHANGE COLUMN `CommAgg4`   `Comm' +
        'Agg4` char(1) DEFAULT '#39'-'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcurrencyconversion` CHANGE COLUMN `Code`   `Code' +
        '` char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblcurrencyconversionhistory` CHANGE COLUMN `Code` ' +
        '  `Code` char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbldeposits` CHANGE COLUMN `ForeignExchangeCode`   ' +
        '`ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_general_' +
        'ci ;'
      
        'ALTER TABLE `tblemployees` CHANGE COLUMN `Initials`   `Initials`' +
        ' char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblhiresaleslines` CHANGE COLUMN `ForeignExchangeSe' +
        'llCode`   `ForeignExchangeSellCode` char(3) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblmacrokeywordslinks` CHANGE COLUMN `reftable`   `' +
        'reftable` char(1) NOT NULL DEFAULT '#39'0'#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblmsbackendid` CHANGE COLUMN `SiteCode`   `SiteCod' +
        'e` char(3) COLLATE utf8_general_ci DEFAULT NULL;'
      
        'ALTER TABLE `tblpersonalpreferences` CHANGE COLUMN `skinoptionMa' +
        'rble`   `skinoptionMarble` char(1) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblpersonaltabs` CHANGE COLUMN `TabStop`   `TabStop' +
        '` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `ForeignExchangeCode`   `Fore' +
        'ignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranInitial`   `VeteranIn' +
        'itial` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpos` CHANGE COLUMN `VeteranGender`   `VeteranGen' +
        'der` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `KeyName`   `K' +
        'eyName` char(2) NOT NULL DEFAULT '#39#39' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposkeypadcustomize` CHANGE COLUMN `QuickKey`   `' +
        'QuickKey` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblposlines` CHANGE COLUMN `ForeignExchangeSellCode' +
        '`   `ForeignExchangeSellCode` char(3) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tblpreferences` CHANGE COLUMN `PrefType`   `PrefTyp' +
        'e` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblprepayments` CHANGE COLUMN `ForeignExchangeCode`' +
        '   `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_gener' +
        'al_ci ;'
      
        'ALTER TABLE `tblproductcodeabbrevlines` CHANGE COLUMN `Descripti' +
        'onAttribAbbrev`   `DescriptionAttribAbbrev` char(3) DEFAULT NULL' +
        ' COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblpurchaselines` CHANGE COLUMN `ForeignExchangeCod' +
        'e`   `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tblpurchaseorders` CHANGE COLUMN `ForeignExchangeCo' +
        'de`   `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_ge' +
        'neral_ci ;'
      
        'ALTER TABLE `tblregionaloptions` CHANGE COLUMN `DateSeparator`  ' +
        ' `DateSeparator` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrelatedparts` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrelatedparts` CHANGE COLUMN `PartName`   `PartNa' +
        'me` char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblrftchannels` CHANGE COLUMN `RepeaterNo`   `Repea' +
        'terNo` char(3) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblsales` CHANGE COLUMN `ForeignExchangeCode`   `Fo' +
        'reignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tblsaleslines` CHANGE COLUMN `ForeignExchangeSellCo' +
        'de`   `ForeignExchangeSellCode` char(3) DEFAULT NULL COLLATE utf' +
        '8_general_ci ;'
      
        'ALTER TABLE `tblsaleslines_pos` CHANGE COLUMN `ForeignExchangeSe' +
        'llCode`   `ForeignExchangeSellCode` char(3) DEFAULT NULL COLLATE' +
        ' utf8_general_ci ;'
      
        'ALTER TABLE `tblsales_pos` CHANGE COLUMN `ForeignExchangeCode`  ' +
        ' `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltax` CHANGE COLUMN `GlobalRef`   `GlobalRef` cha' +
        'r(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomerheader` CHANGE COLUMN `RecordType`   ' +
        '`RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomerheader` CHANGE COLUMN `DefaultSchedul' +
        'e`   `DefaultSchedule` char(1) DEFAULT NULL COLLATE utf8_general' +
        '_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `RecordTy' +
        'pe`   `RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `Schedule' +
        '`   `Schedule` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicegroup` CHANGE COLUMN `GetMinim' +
        'umConNoteCharge`   `GetMinimumConNoteCharge` char(1) DEFAULT NUL' +
        'L COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomerservicetype` CHANGE COLUMN `RecordTyp' +
        'e`   `RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntcustomertrafficlane` CHANGE COLUMN `RecordTyp' +
        'e`   `RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntfileheader` CHANGE COLUMN `RecordType`   `Rec' +
        'ordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntfiletrailer` CHANGE COLUMN `RecordType`   `Re' +
        'cordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleheader` CHANGE COLUMN `RecordType`   ' +
        '`RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicegroup` CHANGE COLUMN `RecordTy' +
        'pe`   `RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ' +
        ';'
      
        'ALTER TABLE `tbltntscheduleservicegroup` CHANGE COLUMN `Schedule' +
        'Number`   `ScheduleNumber` char(1) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicegroup` CHANGE COLUMN `MinimumC' +
        'onNoteChargeFlag`   `MinimumConNoteChargeFlag` char(1) DEFAULT N' +
        'ULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `RecordType`   `RecordType` char(1) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetrafficlanerates` CHANGE COLUM' +
        'N `ScheduleNumber`   `ScheduleNumber` char(1) DEFAULT NULL COLLA' +
        'TE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetype` CHANGE COLUMN `RecordTyp' +
        'e`   `RecordType` char(1) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tbltntscheduleservicetype` CHANGE COLUMN `ScheduleN' +
        'umber`   `ScheduleNumber` char(1) DEFAULT NULL COLLATE utf8_gene' +
        'ral_ci ;'
      
        'ALTER TABLE `tblunitservices` CHANGE COLUMN `GlobalRef`   `Globa' +
        'lRef` char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitservices` CHANGE COLUMN `ServiceDesc`   `Ser' +
        'viceDesc` char(50) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitservicestimeframes` CHANGE COLUMN `GlobalRef' +
        '`   `GlobalRef` char(255) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblunitservicestimeframes` CHANGE COLUMN `TimeName`' +
        '   `TimeName` char(5) DEFAULT NULL COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tblwithdrawal` CHANGE COLUMN `ForeignExchangeCode` ' +
        '  `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_genera' +
        'l_ci ;'
      
        'ALTER TABLE `tmp_foreignpurchase` CHANGE COLUMN `ForeignExchange' +
        'Code`   `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_' +
        'general_ci ;'
      
        'ALTER TABLE `tmp_foreignsales` CHANGE COLUMN `ForeignExchangeCod' +
        'e`   `ForeignExchangeCode` char(3) DEFAULT NULL COLLATE utf8_gen' +
        'eral_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Fo' +
        'reignExchangeCode`   `ForeignExchangeCode` char(3) DEFAULT NULL ' +
        'COLLATE utf8_general_ci ;'
      
        'ALTER TABLE `tmp_salesordermanufacturereport1` CHANGE COLUMN `Fo' +
        'reignExchangeSellCode`   `ForeignExchangeSellCode` char(3) DEFAU' +
        'LT NULL COLLATE utf8_general_ci ;'
      'Alter database DEFAULT CHARACTER SET = utf8;'
      'Alter database DEFAULT Collate = '#39'utf8_general_ci'#39';')
    BeforeExecute = ERPScript1BeforeExecute
    Connection = MyConnection
    IgnorenContinueOnError = False
    Left = 512
    Top = 280
  end
  object ERPQuery2: TERPQuery
    Connection = MyConnection
    Left = 472
    Top = 200
  end
end
