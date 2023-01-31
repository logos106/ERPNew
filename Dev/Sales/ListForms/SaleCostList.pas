unit SaleCostList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSaleCostListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDetailLevel: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainParentSaleID: TIntegerField;
    qryMainSaleType: TWideStringField;
    qryMainCustomerID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainPODate: TDateField;
    qryMainProductId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainsaleQty: TFloatField;
    qryMainPOQty: TFloatField;
    qryMainPurchCostEx: TFloatField;
    qryMainPurchCostInc: TFloatField;
    qryMainExtraCostEx: TFloatField;
    qryMainExtraCostInc: TFloatField;
    qryMainSupplierID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainSellPriceEx: TFloatField;
    qryMainSellPriceInc: TFloatField;
    qryMainProfitEx: TFloatField;
    qryMainProfitInc: TFloatField;
    qryMainSaleLineID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainSalesGlobalref: TWideStringField;
    qryMainSalesOriginalno: TWideStringField;
    qryMainrefno: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    TempTable: string;
    procedure PopulateTable;
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

var
  SaleCostListGUI: TSaleCostListGUI;

implementation

uses
  DbSharedObjectsObj, CommonDbLib, TempTableUtils, ProductQtyLib, PQALib,
  MySQLConst, DateUtils, GridFieldsObj, LogLib, tcConst, CommonLib;

{$R *.dfm}

{ TSaleCostListGUI }

procedure TSaleCostListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(DetailLevel = 1)';
      end;
    1:
      begin {Detail}
        GroupFilterString := '((DetailLevel = 1) or (DetailLevel = 2))';
      end;
    2:
      begin {Extra Detail}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TSaleCostListGUI.FormCreate(Sender: TObject);
begin
  TempTable := CreateUserTemporaryTable('tmp_salecost');
  qryMain.SQL.Text := 'select ' +NL+
                      ' convert(concat(OriginalsaleId, "-" , SaleSeqno) , char(255)) as refno,  ' +NL+
                      ' if(DetailLevel<>4 , transdate , null) as SaleDate, ' +NL+
                      ' if(DetailLevel=4 , transdate , null) as POdate, ' +NL+
                      ' T.*  from ' + TempTable + ' as T ' +
    ' order by CustomerName, SalesOriginalno , ParentSaleId, SaleId, SaleLineId , DetailLevel';
  inherited;

end;

procedure TSaleCostListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  DestroyUserTemporaryTable(CommonDbLib.GetSharedMyDacConnection, TempTable);
end;

procedure TSaleCostListGUI.FormShow(Sender: TObject);
begin
  inherited;
  ListtimerMsg('Purchase Orders and the Cost details are from the Purchase Orders Created for these Invoices.' + NL +
              'ie: If It Was Taken From Available Stock and a Seprate Purchase Order was Not Created for the Sale, the cost will not Appear in this Report' , nil, 30);
end;

procedure TSaleCostListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMainDetailLevel.AsInteger = 1 then begin
    ABrush.Color := GridColHighLightDarkGreen;
    AFont.Style := AFont.Style + [fsBold];
    AFont.Color := GridColFontBlack;
  end else begin
    if qryMainDetailLevel.AsInteger = 2 then begin
      ABrush.Color := GridColhighLightGreen;
      AFont.Color := GridColFontBlack;
      if  (sametext(Field.Fieldname , QrymainSaledate.fieldname)) then begin
        AFont.color := abrush.color;
      end;
    end;
    (*if qryMainDetailLevel.AsInteger in [3,4] then begin
      if  (sametext(Field.Fieldname , QrymainSaleQty.fieldname))
            or (sametext(Field.Fieldname , qryMainSellPriceEx.fieldname))
            or (sametext(Field.Fieldname , qryMainSaleDate.fieldname))
            or (sametext(Field.Fieldname , qryMainSellPriceInc.fieldname))  then begin
        ABrush.Color := GridColhighLightYellow1;
        AFont.Color := GridColFontBlack;
      end;
    //end else if qryMainDetailLevel.AsInteger = 4 then begin
      if       (sametext(Field.Fieldname , QrymainPOQty.fieldname))
            or (sametext(Field.Fieldname , QrymainPurchaseOrderID.fieldname))
            or (sametext(Field.Fieldname , qryMainPurchCostEx.fieldname))
            or (sametext(Field.Fieldname , qryMainPurchCostInc.fieldname))
            or (sametext(Field.Fieldname , qryMainPODate.fieldname))
            or (sametext(Field.Fieldname , qryMainSupplierName.fieldname))
            or (sametext(Field.Fieldname , qryMainExtraCostEx.fieldname))
            or (sametext(Field.Fieldname , qryMainExtraCostInc.fieldname)) then begin
        ABrush.Color := GridColhighLightYellow2;
        AFont.Color := GridColFontBlack;
      end else if (sametext(Field.Fieldname , qryMainProductName.fieldname))
            or (sametext(Field.Fieldname , qryMainProductPrintname.fieldname)) then begin
        AFont.Color := ABrush.Color;
      end;
    end;*)
  end;

  if (qryMainDetailLevel.AsInteger >= 3) then
    if  (sametext(Field.Fieldname , QrymainSaleID.fieldname)) then
      AFont.Color := ABrush.Color;

  if (qryMainDetailLevel.AsInteger <> 2) then
    if sametext(Field.Fieldname , QrymainSaleType.fieldname) or (sametext(Field.Fieldname , qrymainrefno.fieldname)) then
      AFont.Color := ABrush.Color;

  if (qryMainDetailLevel.AsInteger > 1) then
    if (sametext(Field.Fieldname , qrymainCustomerName.fieldname)) then
      AFont.Color := ABrush.Color;
end;

procedure TSaleCostListGUI.PopulateTable;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add('Drop table if exists  ' + TempTable+';');
    SQL.add('Create table   ' + TempTable+' like tmp_salecost;');

    { lop level invoice }
    SQL.Add('insert into ' + TempTable+
               ' (DetailLevel,SaleId,ParentSaleId,SaleType,CustomerId,CustomerName,TransDate)'+
               ' select 1, SaleId, SaleId, "Invoice", ClientId, CustomerName, SaleDate'+
               NL+' from tblsales where IsInvoice = "T"'+
               ' and IfNull(ClientId,0) > 0'+
               ' and GlobalRef = OriginalNo'+ { top level in backorder chain }
               ' and SaleDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat,filterdatefrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat,FilterDateTo)) + ';');

    { backorder invoice chain }
    SQL.Add('insert into ' + TempTable+
               ' (DetailLevel,SaleId,ParentSaleId,SaleType,CustomerId,CustomerName,TransDate,SellPriceEx,SellPriceInc)'+
               NL+' select'+
               ' 2 as DetailLevel,'+
               ' s.SaleID,'+
               ' ps.SaleID as ParentSaleID,'+
               ' "Invoice" as SaleType,'+
               ' s.ClientID as CustomerId,'+
               ' s.CustomerName,'+
               ' s.SaleDate as TransDate,'+
               ' s.TotalAmount as SellPriceEx,'+
               ' s.TotalAmountInc as SellPriceInc'+
               NL+' from tblsales s'+
               ' inner join tblsales ps on s.OriginalNo = ps.GlobalRef'+
               NL+' where s.IsInvoice = "T"'+
               ' and IfNull(s.ClientId,0) > 0'+
               ' and s.SaleDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat,filterdatefrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat,FilterDateTo)) + ';');

    { backorder invoice chain }
    SQL.Add('insert into ' + TempTable+
               ' (DetailLevel,'+
               ' SaleId,'+
               ' ParentSaleId,'+
               ' SaleType,'+
               ' CustomerId,'+
               ' CustomerName,'+
               ' TransDate,'+
               ' SaleLineID,'+
               ' ProductId,'+
               ' ProductName,'+
               ' saleQty,'+
               ' POQty,'+
               ' SellPriceEx,'+
               ' SellPriceInc)'+
               NL+' select'+
               ' 3 as DetailLevel,'+
               ' s.SaleID,'+
               ' ps.SaleID as ParentSaleID,'+
               ' "Invoice" as SaleType,'+
               ' s.ClientID as CustomerId,'+
               ' s.CustomerName,'+
               ' s.SaleDate as TransDate,'+
               ' sl.SaleLineId,'+
               ' sl.ProductId,'+
               ' sl.ProductName,'+
               ' sl.Shipped as saleQty,'+
               ' Null  as POQty,'+
               ' sl.TotalLineAmount as SellPriceEx,'+
               ' sl.TotalLineAmountInc as SellPriceInc'+
               NL+' from tblsales s'+
               ' inner join tblsaleslines sl on sl.SaleID = s.SaleID'+
               ' inner join tblsales ps on s.OriginalNo = ps.GlobalRef'+
               //' Left join tblpurchaselines pl on pl.SaleLineID = sl.SaleLineID'+
               NL+' where s.IsInvoice = "T"'+
               ' and IfNull(s.ClientId,0) > 0'+
               //' and ifnull(pl.SaleLineID,0)=0 ' +
               ' and s.SaleDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat,filterdatefrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat,FilterDateTo)) +' ;');

    { backorder invoice chain - purchases }
    SQL.Add('insert into ' + TempTable+
               ' (DetailLevel,'+
               ' SaleId,'+
               ' ParentSaleId,'+
               ' SaleType,'+
               ' CustomerId,'+
               ' CustomerName,'+
               ' TransDate,'+
               ' SaleLineID,'+
               ' ProductId,'+
               ' ProductName,'+
               ' PurchaseOrderId,'+
               ' saleQty,'+
               ' POQty,'+
               ' SupplierID,'+
               ' SupplierName,'+
               ' PurchCostEx,'+
               ' PurchCostInc)'+
               NL+' select'+
               ' 4 as DetailLevel,'+
               ' s.SaleID,'+
               ' ps.SaleID as ParentSaleID,'+
               ' "Purchase" as SaleType,'+
               ' s.ClientID as CustomerId,'+
               ' s.CustomerName,'+
               ' p.orderDate as TransDate,'+
               ' sl.SaleLineId,'+
               ' pl.ProductId,'+
               ' pl.ProductName,'+
               ' p.PurchaseOrderId,'+
               ' null  as saleQty,'+
               ' pl.Shipped as POQty,'+
               ' p.ClientID as SupplierID,'+
               ' p.SupplierName as SupplierName,'+
               ' pl.TotalLineAmount as SellPriceEx,'+
               ' pl.TotalLineAmountInc as SellPriceInc'+
               NL+' from tblsales s'+
               ' inner join tblsaleslines sl on sl.SaleID = s.SaleID'+
               ' inner join tblpurchaselines pl on pl.SaleLineID = sl.SaleLineID'+
               ' inner join tblpurchaseorders p on p.PurchaseOrderID = pl.PurchaseOrderID'+
               ' inner join tblsales ps on s.OriginalNo = ps.GlobalRef'+
               NL+' where s.IsInvoice = true'+
               ' and IfNull(s.ClientId,0) > 0'+
               ' and s.SaleDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat,filterdatefrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat,FilterDateTo)) + ';');

    { Bills related tp purchase orders }
    SQL.Add('insert into ' + TempTable+
               ' (DetailLevel,SaleID,SaleLineID,ParentSaleID,SaleType,CustomerID,' +
              '   CustomerName,TransDate,ProductName,PurchaseOrderID,SupplierID,SupplierName,ExtraCostEx,ExtraCostInc)'+
               NL+' select'+
               ' t.DetailLevel,'+
               ' t.SaleID,'+
               ' t.SaleLineID,'+
               ' t.ParentSaleID,'+
               ' t.SaleType,'+
               ' t.CustomerID,'+
               ' t.CustomerName,'+
               ' p.OrderDate as TransDate,'+
               ' pl.AccountName as ProductName,'+
               ' p.PurchaseOrderID,'+
               ' p.ClientID as SupplierId,'+
               ' p.SupplierName as SupplierName,'+
               ' pl.TotalLineAmount as ExtraCostEx,'+
               ' pl.TotalLineAmountInc as ExtraCostInc'+
               NL+' from tblpurchaseorders p'+
               ' inner join tblpurchaselines pl on pl.PurchaseOrderID = p.PurchaseOrderID'+
               ' inner join '+TempTable+' T on pl.RelatedPOID = t.PurchaseOrderId'+
               NL+' where p.IsBill = "T";');


    SQL.add('drop table if exists ' +TempTable + '_1;');

    SQL.Add('create table ' +  TempTable + '_1 as '+
               NL+' select'+
               ' t.SaleID,'+
               ' sum(IfNull(t.PurchCostEx,0)) as PurchCostEx,'+
               ' sum(IfNull(t.PurchCostInc,0)) as PurchCostInc,'+
               ' sum(IfNull(t.ExtraCostEx,0)) as ExtraCostEx,'+
               ' sum(IfNull(t.ExtraCostInc,0)) as ExtraCostInc,'+
               ' sum(IfNull(t.SellPriceEx,0)) as SellPriceEx,'+
               ' sum(IfNull(t.SellPriceInc,0)) as SellPriceInc'+
               NL+' from ' + TempTable + ' t'+
               NL+' where t.DetailLevel in (3,4)'+
               ' group by SaleID'+';');
    SQL.Add('update ' + TempTable + ' t'+
               ' inner join ' + TempTable + '_1 t1 on t1.SaleId = t.SaleId and t.DetailLevel = 2'+
               ' set t.PurchCostEx = t1.PurchCostEx'+
               ' , t.PurchCostInc = t1.PurchCostInc'+
               ' , t.ExtraCostEx = t1.ExtraCostEx'+
               ' , t.ExtraCostInc = t1.ExtraCostInc'+
               ' , t.SellPriceEx = t1.SellPriceEx'+
               ' , t.SellPriceInc = t1.SellPriceInc'+';');

    SQL.add('drop table if exists ' +TempTable + '_1;');


    SQL.Add('create table ' +  TempTable + '_1 as '+
               NL+' select'+
               ' t.SaleID,'+
               ' sum(IfNull(t.PurchCostEx,0)) as PurchCostEx,'+
               ' sum(IfNull(t.PurchCostInc,0)) as PurchCostInc,'+
               ' sum(IfNull(t.ExtraCostEx,0)) as ExtraCostEx,'+
               ' sum(IfNull(t.ExtraCostInc,0)) as ExtraCostInc,'+
               ' sum(IfNull(t.SellPriceEx,0)) as SellPriceEx,'+
               ' sum(IfNull(t.SellPriceInc,0)) as SellPriceInc'+
               NL+' from ' + TempTable + ' t'+
               NL+' where t.DetailLevel = 2'+
               ' group by ParentSaleID'+';');

    SQL.Add('update ' + TempTable + ' t'+
               ' inner join ' + TempTable + '_1 t1 on t1.SaleId = t.SaleId and t.DetailLevel = 1'+
               ' set t.PurchCostEx = t1.PurchCostEx'+
               ' , t.PurchCostInc = t1.PurchCostInc'+
               ' , t.ExtraCostEx = t1.ExtraCostEx'+
               ' , t.ExtraCostInc = t1.ExtraCostInc'+
               ' , t.SellPriceEx = t1.SellPriceEx'+
               ' , t.SellPriceInc = t1.SellPriceInc'+';');

    SQL.add('drop table if exists ' +TempTable + '_1;');

    SQL.Add('update ' + TempTable+
               ' set ProfitEx = (IfNull(SellPriceEx,0) - IfNull(PurchCostEx,0) - IfNull(ExtraCostEx,0))'+
               ' , ProfitInc = (IfNull(SellPriceInc,0) - IfNull(PurchCostInc,0) - IfNull(ExtraCostInc,0))'+
               NL+' where DetailLevel in (1,2)'+';');
    SQL.Add('update ' + TempTable+ ' T inner join tblsales S on S.saleId = T.saleId Set T.SalesGlobalref = s.globalref , T.SalesOriginalno = S.originalno;');
    SQL.Add('update ' + TempTable+ ' T inner join tblsales S on S.globalref = T.SalesOriginalno Set T.OriginalSaleId = s.saleId ;');
    SQL.Add('update ' + TempTable+ ' T inner join tblparts P on T.ProductId = P.partsID Set T.ProductPrintName = P.ProductPrintName ;');

    SQL.add('drop table if exists ' +TempTable + '_1;');
    SQL.add('Create table  ' +TempTable + '_1  Select ' +
              ' @SaleSeqno:=if(@OriginalSaleId <> T.OriginalSaleId ,  @SaleSeqno:=1,  if(@SaleId = T.SaleId,  @SaleSeqno:= @SaleSeqno ,  @SaleSeqno+1)) as SaleSeqno ,     ' +
              //' @SalelineSeqno:=if(DetailLevel=1 or DetailLevel=2 , @SalelineSeqno:= 0, if(@saleLineId <> T.saleLineId,  @SalelineSeqno:= 1,  @SalelineSeqno+1)) as SalelineSeqno ,     ' +
              ' @OriginalSaleId :=  T.OriginalSaleId  as TOriginalSaleId , ' +
              '   @SaleId := T.SaleId as TSaleId, ' +
              //'@SalelineSeqno := T.SalelineId as TSalelineSID, ' +
              ' T.* ' +
              ' from ' +
              ' 	(SELECT @SaleSeqno:=0) r , ' +
              '  (SELECT @SaleId:=0) s, ' +
              ' (SELECT @OriginalSaleId :=0) as o, '+
               // '(select @SalelineSeqno := 0) as sl,' +
              ' ' +TempTable + ' T ' +
              ' order by CustomerName, SalesOriginalno , ParentSaleId, SaleId, SaleLineId , DetailLevel;');
     SQL.add('Drop table if exists ' +TempTable + ';');
     SQL.add('Create table ' +TempTable + ' select * from ' +TempTable + '_1 T;');
     SQL.add('Drop table if exists ' +TempTable + '_1;');
    clog(SQL.text);
    SQL.text := ChangeQuery(SQL.text);
    Execute;
  end;

end;

procedure TSaleCostListGUI.RefreshQuery;
begin
  if qryMain.Active then qryMain.Close;
  PopulateTable;
  inherited;
end;

procedure TSaleCostListGUI.RefreshTotals;
var
  bm: TBookmark;
  totPurchCostEx,
  totPurchCostInc,
  totExtraCostEx,
  totExtraCostInc,
  totSellPriceEx,
  totSellPriceInc,
  totProfitEx,
  totProfitInc: double;
begin
//  inherited;
  totPurchCostEx := 0;
  totPurchCostInc := 0;
  totExtraCostEx := 0;
  totExtraCostInc := 0;
  totSellPriceEx := 0;
  totSellPriceInc := 0;
  totProfitEx := 0;
  totProfitInc := 0;
  qryMain.DisableControls;
  try
    bm := qryMain.GetBookmark;
    try
      qryMain.First;
      while not qryMain.Eof do begin
        if qryMainDetailLevel.AsInteger = 1 then begin
          totPurchCostEx := totPurchCostEx + qryMainPurchCostEx.AsFloat;
          totPurchCostInc := totPurchCostInc + qryMainPurchCostInc.AsFloat;
          totExtraCostEx := totExtraCostEx + qryMainExtraCostEx.AsFloat;
          totExtraCostInc := totExtraCostInc + qryMainExtraCostInc.AsFloat;
          totSellPriceEx := totSellPriceEx + qryMainSellPriceEx.AsFloat;
          totSellPriceInc := totSellPriceInc + qryMainSellPriceInc.AsFloat;
          totProfitEx := totProfitEx + qryMainProfitEx.AsFloat;
          totProfitInc := totProfitInc + qryMainProfitInc.AsFloat;
        end;
        qryMain.Next;
      end;
      qryMain.GotoBookmark(bm);
    finally
      qryMain.FreeBookmark(bm);
    end;
  finally
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName(qryMainPurchCostEx.FieldName).FooterValue := FloatToStrF(totPurchCostEx, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainPurchCostInc.FieldName).FooterValue := FloatToStrF(totPurchCostInc, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainExtraCostEx.FieldName).FooterValue := FloatToStrF(totExtraCostEx, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainExtraCostInc.FieldName).FooterValue := FloatToStrF(totExtraCostInc, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainSellPriceEx.FieldName).FooterValue := FloatToStrF(totSellPriceEx, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainSellPriceInc.FieldName).FooterValue := FloatToStrF(totSellPriceInc, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainProfitEx.FieldName).FooterValue := FloatToStrF(totProfitEx, ffCurrency, 15, 2);
  grdMain.ColumnByName(qryMainProfitInc.FieldName).FooterValue := FloatToStrF(totProfitInc, ffCurrency, 15, 2);
end;

procedure TSaleCostListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainid.fieldname);
  RemoveFieldfromGrid(qrymainDetailLevel.fieldname);
  RemoveFieldfromGrid(qrymainCustomerId.fieldname);
  RemoveFieldfromGrid(qrymainProductId.fieldname);
  RemoveFieldfromGrid(qrymainSupplierId.fieldname);
  RemoveFieldfromGrid(qrymainSaleLineId.fieldname);
  RemoveFieldfromGrid(qrymainParentsaleId.fieldname);
  if not devmode then begin
    RemoveFieldfromGrid(qryMainSalesGlobalref.fieldname);
    RemoveFieldfromGrid(qryMainSalesOriginalno.fieldname);
  end;
end;

initialization
  RegisterClass(TSaleCostListGUI);

end.
