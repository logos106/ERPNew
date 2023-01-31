inherited fmMain: TfmMain
  Left = 1470
  Top = 307
  Width = 860
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 852
  end
  inherited pnlBottom: TPanel
    Width = 852
    object btnPrint: TDNMSpeedButton
      Left = 136
      Top = 8
      Width = 100
      Height = 33
      Caption = 'Print'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      Visible = False
      OnClick = btnPrintClick
    end
  end
  inherited pnlLeft: TPanel
    Height = 290
    Anchors = []
  end
  inherited pnlRight: TPanel
    Left = 839
    Width = 13
    Height = 290
    Anchors = []
  end
  object ProgressBar: TProgressBar [4]
    Left = 0
    Top = 412
    Width = 852
    Height = 16
    Align = alBottom
    Min = 0
    Max = 100
    Step = 1
    TabOrder = 4
    Visible = False
  end
  inherited PageControl: TPageControl
    Width = 822
    Height = 290
    ActivePage = tabinvalid
    TabIndex = 2
    TabOrder = 5
    inherited tabMain: TTabSheet
      inherited memLog: TMemo
        Width = 814
        Height = 262
      end
    end
    inherited tabUpdate: TTabSheet
      object grid: TwwDBGrid
        Left = 0
        Top = 0
        Width = 814
        Height = 262
        Selected.Strings = (
          'Transtype'#9'10'#9'Trans Type'
          'Description'#9'95'#9'Product Name '
          'SaleId'#9'10'#9'ID'
          'BackOrder'#9'10'#9'BackOrder')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = Datasource
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = gridCalcCellColors
      end
    end
    inherited tabinvalid: TTabSheet
      Caption = 'Sales/PO with Links broken'
      object InvalidGrid: TwwDBGrid
        Left = 0
        Top = 0
        Width = 814
        Height = 262
        Selected.Strings = (
          'Transtype'#9'10'#9'Trans Type'
          'Description'#9'75'#9'Product Name '
          'SaleId'#9'10'#9'ID'
          'OriginalTrans'#9'255'#9'OriginalTrans'
          'Qtysold'#9'10'#9'Sold'
          'Shipped'#9'10'#9'Shipped'
          'Backorder'#9'10'#9'Backorder')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = datasourceinvalid
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = gridCalcCellColors
      end
    end
  end
  inherited Panel2: TPanel
    Top = 395
    Width = 852
    Height = 17
    TabOrder = 6
    inherited ProgressBardb: TProgressBar
      Left = 280
      Top = 0
      Width = 289
      Align = alNone
    end
  end
  inherited Script: TMyScript
    SQL.Strings = (
      'Drop table if exists tmp_7468Fix_saleslinesbeforeupdate;'
      
        'create table tmp_7468Fix_saleslinesbeforeupdate select * from tb' +
        'lsaleslines;'
      'drop table if exists tmp_1;'
      
        'create table tmp_1 Select  space(255) as globalref, SL.saleId, S' +
        'l.baselineno , 0 as salelineId1, 0 as saleLineId2, 0 as saleLine' +
        'Id3, count(Sl.SaleLineID) ctr, 0 as Seqno, 0 as Seqno1, 0 as seq' +
        'no2 from tblSaleslines SL inner join tblSales  S on S.SaleId = S' +
        'l.saleID where ifnull(baselineno,0) <> 0 group by Sl.saleId, SL.' +
        'baselineno  order by ctr desc;'
      'delete from tmp_1 where ctr<=1 ;'
      
        'update tmp_1 t  inner join tblsaleslines  SL on SL.SaleLineId = ' +
        't.baselineno inner join tblSales S on s.saleId = Sl.SaleID Set t' +
        '.globalref = S.Globalref;'
      
        'update tmp_1 set salelineId1 = ifnull((Select min(SaleLineID) fr' +
        'om tblSaleslines SL where SL.BaseLineno = tmp_1.BaseLineNo),0);'
      
        'update tmp_1 set salelineId2 = ifnull((Select min(SaleLineID) fr' +
        'om tblSaleslines SL where SL.BaseLineno = tmp_1.BaseLineNo and S' +
        'L.SaleLineId <> tmp_1.SaleLineID1),0);'
      
        'update tmp_1 set salelineId3 = ifnull((Select min(SaleLineID) fr' +
        'om tblSaleslines SL where SL.BaseLineno = tmp_1.BaseLineNo and S' +
        'L.SaleLineId <> tmp_1.SaleLineID1 and SL.SaleLineId <> tmp_1.Sal' +
        'eLineID2),0);'
      
        'update tmp_1 t inner join tblSaleslines sl on sl.SalelineId = t.' +
        'baselineno inner join tblsales S on s.SaleId = sl.SaleID inner j' +
        'oin tblSaleslines sl1 on sl1.SalelineId = t.SaleLineID1 inner jo' +
        'in tblsales S1 on s1.SaleId = sl1.SaleID inner join tblSalesline' +
        's sl2 on sl2.SalelineId = t.SaleLineID2 inner join tblsales S2 o' +
        'n s2.SaleId = sl2.SaleID Set t.Seqno = sl.seqno , t.Seqno1 = sl1' +
        '.Seqno, t.Seqno2 = sl2.seqno where ifnull(sl1.shipped,0) <> 0 or' +
        ' ifnull(sl2.shipped,0)<> 0;'
      
        'alter table tblsaleslines Add column 7468Fix_saleslines Enum('#39'T'#39 +
        ','#39'F'#39') default '#39'F'#39';'
      
        'update tblsaleslines SL inner join tmp_1 on tmp_1.salelineId1 = ' +
        'SL.SaleLineId and SL.Seqno <> tmp_1.Seqno1 set 7468Fix_salesline' +
        's = '#39'T'#39' ;'
      
        'update tblsaleslines SL inner join tmp_1 on tmp_1.salelineId2 = ' +
        'SL.SaleLineId  Left join tblsaleslines SL1  on SL1.baselineno = ' +
        'SL.baselineno and SL1.7468Fix_saleslines  = "T" set SL.7468Fix_s' +
        'aleslines = '#39'T'#39'  where ifnull(SL1.SaleLineID,0) = 0;'
      'drop table if exists tmp_7468Fix_saleslines;'
      
        'create table tmp_7468Fix_saleslines select * from tblsaleslines ' +
        'where ifnull(7468Fix_saleslines,"F") = "T" and ifnull(Shipped,0)' +
        ' = 0;'
      
        'Delete from tblSaleslines where ifnull(7468Fix_saleslines,"F") =' +
        ' "T" and ifnull(Shipped,0) = 0;'
      ''
      'drop table if exists tmp_1;'
      
        'update tblSaleslines  SL inner join tblSaleslines  SLO on  ifnul' +
        'l(SL.baselineno,0) = SLO.SaleLineId set SL.Seqno = SLO.seqno whe' +
        're SL.Seqno <> SLO.Seqno  ;'
      'drop table if exists tmp_1;'
      
        'create table tmp_1 select Seqno, SaleId, count(SaleLineID) ctr ,' +
        ' 0 as SaleLineId1, 0 as SaleLineID2 from tblsaleslines  group by' +
        ' Seqno, SaleId;'
      'delete from tmp_1 where ctr<= 1;'
      
        'update tmp_1 set SaleLineId1 = ifnull((Select min(SaleLineID) fr' +
        'om tblsaleslines SL where SL.SaleId = tmp_1.SaleId and SL.Seqno ' +
        '= tmp_1.Seqno),0);'
      
        'update tmp_1 set SaleLineId2 = ifnull((Select min(SaleLineID) fr' +
        'om tblsaleslines SL where SL.SaleId = tmp_1.SaleId and SL.Seqno ' +
        '= tmp_1.Seqno and SL.SaleLineID <> tmp_1.SaleLineID1),0);'
      
        'update tmp_1 inner join tblSaleslines SL1 on SL1.saleLineId = tm' +
        'p_1.SaleLineId1 inner join tblSaleslines SL2 on SL2.saleLineId =' +
        ' tmp_1.SaleLineId2 Set SL2.deleted = "T" where  SL1.Productname=' +
        ' SL2.Productname  and  SL1.ProductId= SL2.ProductId and  SL1.Qty' +
        'Sold= SL2.Qtysold and  SL1.shipped= SL2.Shipped and  SL1.Backord' +
        'er= SL2.backorder and  SL1.Seqno= SL2.Seqno and SL1.Deleted ="F"' +
        ';'
      
        'insert into tmp_7468Fix_saleslines Select * from tblSaleslines w' +
        'here ifnull(Deleted, "F")  = "T";'
      'Delete from tblSaleslines  where ifnull(Deleted, "F") = "T";'
      'alter table tblsaleslines drop  column 7468Fix_saleslines ;'
      ''
      ''
      'Drop table if exists tmp_7468Fix_purchaselinesbeforeupdate;'
      
        'create table tmp_7468Fix_purchaselinesbeforeupdate select * from' +
        ' tblpurchaselines;'
      'drop table if exists tmp_1;'
      
        'create table tmp_1 Select  space(255) as globalref, SL.PurchaseO' +
        'rderID, Sl.baselineno , 0 as PurchaseLineID1, 0 as PurchaseLineI' +
        'D2, 0 as PurchaseLineID3, count(Sl.PurchaseLineID) ctr, 0 as Seq' +
        'no, 0 as Seqno1, 0 as seqno2 from tblpurchaselines SL inner join' +
        ' tblpurchaseorders  S on S.PurchaseOrderID = Sl.PurchaseOrderID ' +
        'where ifnull(baselineno,0) <> 0 group by Sl.PurchaseOrderID, SL.' +
        'baselineno  order by ctr desc;'
      'delete from tmp_1 where ctr<=1 ;'
      
        'update tmp_1 t  inner join tblpurchaselines  SL on SL.PurchaseLi' +
        'neID = t.baselineno inner join tblpurchaseorders S on s.Purchase' +
        'OrderID = Sl.PurchaseOrderID Set t.globalref = S.Globalref;'
      
        'update tmp_1 set PurchaseLineID1 = ifnull((Select min(PurchaseLi' +
        'neID) from tblpurchaselines SL where SL.BaseLineno = tmp_1.BaseL' +
        'ineNo),0);'
      
        'update tmp_1 set PurchaseLineID2 = ifnull((Select min(PurchaseLi' +
        'neID) from tblpurchaselines SL where SL.BaseLineno = tmp_1.BaseL' +
        'ineNo and SL.PurchaseLineID <> tmp_1.PurchaseLineID1),0);'
      
        'update tmp_1 set PurchaseLineID3 = ifnull((Select min(PurchaseLi' +
        'neID) from tblpurchaselines SL where SL.BaseLineno = tmp_1.BaseL' +
        'ineNo and SL.PurchaseLineID <> tmp_1.PurchaseLineID1 and SL.Purc' +
        'haseLineID <> tmp_1.PurchaseLineID2),0);'
      
        'update tmp_1 t inner join tblpurchaselines sl on sl.PurchaseLine' +
        'ID = t.baselineno inner join tblpurchaseorders S on s.PurchaseOr' +
        'derID = sl.PurchaseOrderID inner join tblpurchaselines sl1 on sl' +
        '1.PurchaseLineID = t.PurchaseLineID1 inner join tblpurchaseorder' +
        's S1 on s1.PurchaseOrderID = sl1.PurchaseOrderID inner join tblp' +
        'urchaselines sl2 on sl2.PurchaseLineID = t.PurchaseLineID2 inner' +
        ' join tblpurchaseorders S2 on s2.PurchaseOrderID = sl2.PurchaseO' +
        'rderID Set t.Seqno = sl.seqno , t.Seqno1 = sl1.Seqno, t.Seqno2 =' +
        ' sl2.seqno where ifnull(sl1.shipped,0) <> 0 or ifnull(sl2.shippe' +
        'd,0)<> 0;'
      
        'alter table tblpurchaselines Add column 7468Fix_purchaselines En' +
        'um('#39'T'#39','#39'F'#39') default '#39'F'#39';'
      
        'update tblpurchaselines SL inner join tmp_1 on tmp_1.PurchaseLin' +
        'eID1 = SL.PurchaseLineID and SL.Seqno <> tmp_1.Seqno1 set 7468Fi' +
        'x_purchaselines = '#39'T'#39' ;'
      
        'update tblpurchaselines SL inner join tmp_1 on tmp_1.PurchaseLin' +
        'eID2 = SL.PurchaseLineID  Left join tblpurchaselines SL1  on SL1' +
        '.baselineno = SL.baselineno and SL1.7468Fix_purchaselines  = "T"' +
        ' set SL.7468Fix_purchaselines = '#39'T'#39'  where ifnull(SL1.PurchaseLi' +
        'neID,0) = 0;'
      'drop table if exists tmp_7468Fix_purchaselines;'
      
        'create table tmp_7468Fix_purchaselines select * from tblpurchase' +
        'lines where ifnull(7468Fix_purchaselines,"F") = "T" and ifnull(S' +
        'hipped,0) = 0;'
      
        'Delete from tblpurchaselines where ifnull(7468Fix_purchaselines,' +
        '"F") = "T" and ifnull(Shipped,0) = 0;'
      ''
      'drop table if exists tmp_1;'
      
        'update tblpurchaselines  PL inner join tblpurchaselines  PLO on ' +
        ' ifnull(PL.baselineno,0) = PLO.PurchaseLineID set PL.Seqno = PLO' +
        '.seqno where PL.Seqno <> PLO.Seqno ;'
      'drop table if exists tmp_1;'
      
        'create table tmp_1 select Seqno, PurchaseOrderID, count(Purchase' +
        'LineID) ctr , 0 as PurchaseLineID1, 0 as PurchaseLineID2 from tb' +
        'lpurchaselines  group by Seqno, PurchaseOrderID;'
      'delete from tmp_1 where ctr<= 1;'
      
        'update tmp_1 set PurchaseLineID1 = ifnull((Select min(PurchaseLi' +
        'neID) from tblpurchaselines PL where PL.PurchaseOrderID = tmp_1.' +
        'PurchaseOrderID and PL.Seqno = tmp_1.Seqno),0);'
      
        'update tmp_1 set PurchaseLineID2 = ifnull((Select min(PurchaseLi' +
        'neID) from tblpurchaselines PL where PL.PurchaseOrderID = tmp_1.' +
        'PurchaseOrderID and PL.Seqno = tmp_1.Seqno and PL.PurchaseLineID' +
        ' <> tmp_1.PurchaseLineID1),0);'
      
        'update tmp_1 inner join tblpurchaselines PL1 on PL1.PurchaseLine' +
        'ID = tmp_1.PurchaseLineID1 inner join tblpurchaselines PL2 on PL' +
        '2.PurchaseLineID = tmp_1.PurchaseLineID2 Set PL2.deleted = "T" w' +
        'here  PL1.Productname= PL2.Productname  and  PL1.ProductId= PL2.' +
        'ProductId and  PL1.QtySold= PL2.Qtysold and  PL1.shipped= PL2.Sh' +
        'ipped and  PL1.Backorder= PL2.backorder and  PL1.Seqno= PL2.Seqn' +
        'o and PL1.Deleted ="F";'
      
        'insert into tmp_7468Fix_purchaselines  Select * from tblpurchase' +
        'lines where ifnull(Deleted, "F")  = "T";'
      'Delete from tblpurchaselines where ifnull(Deleted, "F") = "T";'
      
        'alter table tblpurchaselines drop  column 7468Fix_purchaselines ' +
        ';')
    BeforeExecute = ScriptBeforeExecute
    OnError = ScriptError
  end
  object Query: TMyQuery
    SQL.Strings = (
      
        'Select "Sales" as Description, SaleId as ID, ProductName, Backor' +
        'der, deleted  from tmp_7468Fix_saleslines   '
      'union '
      
        'Select "PO" as Description, PurchaseOrderID as ID, ProductName, ' +
        'Backorder , deleted from tmp_7468Fix_purchaselines'
      'order by ID, productname')
    Left = 288
    Top = 48
  end
  object Table: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Transtype'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'SaleId'
        DataType = ftInteger
      end
      item
        Name = 'BackOrder'
        DataType = ftFloat
      end>
    AutoAddIndexes = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 7
    Top = 38
    object TableTranstype: TStringField
      DisplayLabel = 'Trans Type'
      DisplayWidth = 10
      FieldName = 'Transtype'
      Size = 100
    end
    object TableDescription: TStringField
      DisplayLabel = 'Product Name '
      DisplayWidth = 95
      FieldName = 'Description'
      Size = 100
    end
    object TableSaleId: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 10
      FieldName = 'SaleId'
    end
    object TableBackOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'BackOrder'
    end
  end
  object Datasource: TDataSource
    DataSet = Table
    Left = 40
    Top = 40
  end
  object dlgPrint: TPdtPrintDAT
    ObjectToPrint = grid
    DialogTitle = 'Update Details'
    ReportId = '(000.000)'
    Version = '1.58k Pro W2W'
    Left = 17
  end
  object QryInvalid: TMyQuery
    SQL.Strings = (
      
        'Select "Sales" Category, S.BaseNo,  SL.SaleID ID, SL.ProductName' +
        ', SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped , SL.UnitofM' +
        'easureBackorder'
      'from tblSaleslines SL '
      'inner join tblSales S on s.SalEId = SL.SaleID'
      'Left join tblSaleslines SLO on SLO.SaleLineID= SL.Baselineno'
      'where ifnull(SL.Baselineno,0) <> 0 '
      'and ifnull(SLO.SaleLineID,0) = 0'
      'union '
      
        'Select "PO" Category, PO.BaseNo,PL.PurchaseOrderID ID, PL.Produc' +
        'tName, PL.UnitofMeasureQtySold , PL.UnitofMeasureShipped , PL.Un' +
        'itofMeasureBackorder'
      'from tblpurchaselines PL '
      
        'inner join tblpurchaseorders PO on PO.PurchaseOrderId = PL.Purch' +
        'aseOrderId'
      
        'Left join tblpurchaselines PLO on PLO.PurchaseLineID= PL.Baselin' +
        'eno'
      'where ifnull(PL.Baselineno,0) <> 0 '
      'and ifnull(PLO.PurchaseLineID,0) = 0')
    Left = 328
    Top = 48
  end
  object tableinvalid: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Transtype'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'SaleId'
        DataType = ftInteger
      end
      item
        Name = 'OriginalTrans'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Qtysold'
        DataType = ftFloat
      end
      item
        Name = 'Shipped'
        DataType = ftFloat
      end
      item
        Name = 'Backorder'
        DataType = ftFloat
      end>
    AutoAddIndexes = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 359
    Top = 46
    object tableinvalidCategory: TStringField
      DisplayLabel = 'Trans Type'
      DisplayWidth = 10
      FieldName = 'Transtype'
      Size = 100
    end
    object tableinvalidDescription: TStringField
      DisplayLabel = 'Product Name '
      DisplayWidth = 75
      FieldName = 'Description'
      Size = 100
    end
    object tableinvalidSaleId: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 10
      FieldName = 'SaleId'
    end
    object tableinvalidOriginalTrans: TStringField
      DisplayWidth = 255
      FieldName = 'OriginalTrans'
      Size = 255
    end
    object tableinvalidQtysold: TFloatField
      DisplayLabel = 'Sold'
      DisplayWidth = 10
      FieldName = 'Qtysold'
    end
    object tableinvalidShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'Shipped'
    end
    object tableinvalidBackorder: TFloatField
      DisplayWidth = 10
      FieldName = 'Backorder'
    end
  end
  object datasourceinvalid: TDataSource
    DataSet = tableinvalid
    Left = 392
    Top = 48
  end
  object Invalidgprint: TPdtPrintDAT
    ObjectToPrint = InvalidGrid
    DialogTitle = 'Sales/PO with broken Links'
    ReportId = '(000.000)'
    Version = '1.58k Pro W2W'
    Left = 54
  end
end
