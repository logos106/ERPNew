unit ProductBOMHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TProductBOMHistoryGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainSaleno: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainSaleDate: TDateTimeField;
    qryMainfutureSo: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainSalesStatus: TWideStringField;
    qryMainshipdate: TDateField;
    qryMainheld: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainterms: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainHasSignature: TWideStringField;
    qryMainSalestype: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainConverted: TWideStringField;
    qryMainIsInternalOrder: TWideStringField;
    qryMainslPQAQty: TFloatField;
    qryMainslPQAID: TIntegerField;
    qryMainslPQAuomQty: TFloatField;
    qryMainSLPQAactive: TWideStringField;
    qryMainPTPQAQty: TFloatField;
    qryMainPTPQAID: TIntegerField;
    qryMainPTPQAuomQty: TFloatField;
    qryMainPTPQAactive: TWideStringField;
    qryMainInvSaleId: TIntegerField;
    qryMainInvslPQAQty: TFloatField;
    qryMainInvslPQAID: TIntegerField;
    qryMainInvslPQAuomQty: TFloatField;
    qryMainInvSLPQAactive: TWideStringField;
    QrymainInvalidcode: TIntegerField;
    btnFix: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnFixClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
  private
    fiProductId: Integer;
    Tablename :String;
    procedure MakeTempTable;
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Property ProductId :Integer read fiProductId write fiProductId;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonDbLib, DbSharedObjectsObj , PQALib, ProductQtyLib,
  tcConst, MySQLConst, LogLib, SharedObjs;

{$R *.dfm}


procedure TProductBOMHistoryGUI.FormCreate(Sender: TObject);
begin
  TableName := GetUserTemporaryTableName('ProductInternalSalesOrders');
  Qrymain.SQL.text := 'Select * from '+ tablename ;
  inherited;
  fbRemeberIgnoreDateSelection := True;
  fiProductId := 0;
end;

procedure TProductBOMHistoryGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TProductBOMHistoryGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  try
    if (Field is TFloatfield  ) then if TFloatfield(field).asfloat     = 0 then Afont.color := abrush.color;
    if (Field is TIntegerfield) then if TIntegerfield(field).asInteger = 0 then Afont.color := abrush.color;
  Except
    on E:Exception do begin
        Logtext(field.fieldname + ':' +E.Message);
    end;
  end;

    {BOM PQa should be always be active}
    if (Qrymaininvalidcode.asInteger = 1) (*or (Qrymaininvalidcode.asInteger = 7)*) then
          if sametext(field.fieldname , QrymainptPQAQty.fieldname) or
            sametext(field.fieldname ,  QrymainptPQAuomQty.fieldname) or
            sametext(field.fieldname , QrymainptPQAactive.fieldname) then ABrush.color := GridColhighLightRed;

      {converted Sales order - Salesline PQa should be inactive}
      if Qrymaininvalidcode.asInteger = 2 then
        if sametext(field.fieldname , QrymainslPQAQty.fieldname) or
          sametext(field.fieldname ,  QrymainslPQAuomQty.fieldname) or
          sametext(field.fieldname , QrymainSLPQAactive.fieldname) then ABrush.color := GridColhighLightRed;

      {convertd SO, not internal SO, should have an invoice and invoice pqa should be active.
      It is possible to have the invoice deleted at a later stage which is ok}
      if Qrymaininvalidcode.asInteger = 3 then
          if sametext(field.fieldname , QrymaininvSaleid.fieldname) or
            sametext(field.fieldname , QrymaininvslPQAQty.fieldname) or
            sametext(field.fieldname ,  QrymaininvslPQAuomQty.fieldname) or
            sametext(field.fieldname , QrymaininvslPQAactive.fieldname) then ABrush.color := GridColhighLightRed;

      {non converted Sales order - Salesline PQa should be inactive}
      if Qrymaininvalidcode.asInteger = 4 then
        if sametext(field.fieldname , QrymainslPQAQty.fieldname) or
          sametext(field.fieldname ,  QrymainslPQAuomQty.fieldname) or
          sametext(field.fieldname , QrymainSLPQAactive.fieldname) then ABrush.color := GridColhighLightRed;

      {convertd SO, not internal SO, should have an invoice and invoice pqa should be active.
      It is possible to have the invoice deleted at a later stage which is ok}
      if (Qrymaininvalidcode.asInteger = 5) or (Qrymaininvalidcode.asInteger = 6) then
          if sametext(field.fieldname , QrymaininvSaleid.fieldname) or
            sametext(field.fieldname , QrymaininvslPQAQty.fieldname) or
            sametext(field.fieldname ,  QrymaininvslPQAuomQty.fieldname) or
            sametext(field.fieldname , QrymaininvslPQAactive.fieldname) then ABrush.color := GridColhighLightRed;
end;
procedure TProductBOMHistoryGUI.grpFiltersClick(Sender: TObject);
begin
  groupfilterString :='';
  if grpFilters.itemindex = 0 then groupfilterString :='invalidcode <> 0';
  inherited;
end;

procedure TProductBOMHistoryGUI.btnFixClick(Sender: TObject);
var
  erpfixpqa:String;
begin
  inherited;
  IterateProcNo := 1;
  if userlock.Enabled =false then userlock.Enabled := TRue;
  ScriptMain.SQL.Clear;
  try
    erpfixpqa:=ERPFIXTablenameforCurVersion('tblpqa');
    ScriptMain.SQL.add('create table if not exists ' + erpfixpqa +' like tblpqa;');
    ScriptMain.SQL.add('insert ignore into ' + erpfixpqa +' select * from tblpqa ;');
    IterateselectedRecords(True , 'Updating');
  finally
    with ScriptMain do begin
      if SQL.count >2 then begin
        DoShowProgressbar(SQL.Count , WAITMSG);
        try
          logtext(SQL.text);
          Execute;
        finally
          Userlock.UnlockAllCurrentInstance;
          DoHideProgressbar;
        end;
        RefreshQuery;
      end;
    end;

  end;
end;

procedure TProductBOMHistoryGUI.IterateselectedRecordsCallback(
  var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if iterateProcno = 1 then begin

      if Userlock.Lock('tblsales' , QrymainSaleId.AsInteger) then begin

        {BOM PQa should always be active}
        if Qrymaininvalidcode.AsInteger =1 then ScriptMain.SQL.Add('update tblpqa set Active ="T" where PQAID = '+ inttostr(QrymainptpqaID.AsInteger)+';');
        //if Qrymaininvalidcode.AsInteger =7 then ScriptMain.SQL.Add('update tblpqa set Active ="F" where PQAID = '+ inttostr(QrymainptpqaID.AsInteger)+';');
        //invalidcode =1 where ptpqaactive ="F";';

        {converted Sales order - Salesline PQa should be inactive}
        if Qrymaininvalidcode.AsInteger =2 then ScriptMain.SQL.Add('update tblpqa set Active ="F" where PQAID = '+ inttostr(QrymainslpqaID.AsInteger)+';');
        //invalidcode =2 where converted ="T" and SLPQAactive ="T";';

        {non converted Sales order - Salesline PQa should be active}
        if Qrymaininvalidcode.AsInteger =4 then ScriptMain.SQL.Add('update tblpqa set Active ="T" where PQAID = '+ inttostr(QrymainslpqaID.AsInteger)+';');
        //invalidcode =4 where  converted ="F" and SLPQAactive="F";';
      end;
     if QrymaininvSaleId.AsInteger >0 then
      if Userlock.Lock('tblsales' , QrymaininvSaleId.AsInteger) then begin
        {convertd SO, not internal SO, should have an invoice and invoice pqa should be active.
        It is possible to have the invoice deleted at a later stage which is ok}
        if Qrymaininvalidcode.AsInteger =3 then ScriptMain.SQL.Add('update tblpqa set Active ="T" where PQAID = '+ inttostr(QrymaininvslpqaID.AsInteger)+';');
        //invalidcode =3 where  converted ="T" and isinternalorder ="F" and ( ifnull(invSaleid,0) =0 or ifnull(InvSlPqaactive,"F") ="F");');
      end;
  end;
end;

procedure TProductBOMHistoryGUI.RefreshQuery;
begin
    MakeTempTable;
    Qrymain.SQL.text := 'Select * from '+ tablename ;
    RefreshOrignalSQL(False);
    inherited;
    grpFiltersClick(grpFilters);
end;
procedure TProductBOMHistoryGUI.MakeTempTable;
var
  Qry:TERPQuery;
begin
  Qry:=DbSharedObj.GetQuery(commondblib.GetSharedMyDacConnection);
  try
    closedb(Qry);
    Qry.SQL.Clear;
    Qry.SQL.Add('select  P.partsId  from tblParts P inner join tblProctree Pt on P.partsId = Pt.masterId and Pt.mastertype ="mtProduct" and ifnull(Pt.parentId,0)=0');
    if ProductId <> 0 then Qry.SQL.Add('Where P.partsId =' + inttostr(ProductID));
    Qry.Open;
    With Scriptmain do begin
      SQL.Clear;
      SQL.Add('Drop table if exists '+ tablename +';');
      SQL.Add('      CREATE TABLE  '+ tablename +' ( '+
                    ' ID   int(11)       NULL AUTO_INCREMENT,'+
                    '  Saleno varchar(50) DEFAULT NULL, '+
                    '  SaleId int(11) NOT NULL DEFAULT 0, '+
                    '  CustomerName varchar(255) DEFAULT NULL, '+
                    '  TotalAmountinc double NOT NULL DEFAULT 0, '+
                    '  TotalAmount double NOT NULL DEFAULT 0, '+
                    '  Payment double NOT NULL DEFAULT 0, '+
                    '  Balance double NOT NULL DEFAULT 0, '+
                    '  SaleDate datetime DEFAULT NULL, '+
                    '  futureSo enum("T","F") DEFAULT "F", '+
                    '  Done enum("T","F") DEFAULT "F", '+
                    '  SalesStatus varchar(255) DEFAULT NULL, '+
                    '  shipdate date DEFAULT NULL, '+
                    '  held enum("T","F")  DEFAULT "F", '+
                    '  PONumber varchar(50) DEFAULT NULL, '+
                    '  terms varchar(255) DEFAULT NULL, '+
                    '  Comments varchar(255) DEFAULT NULL, '+
                    '  HasSignature enum("T","F")  DEFAULT "F", '+
                    '  Salestype varchar(11) NOT NULL DEFAULT "", '+
                    '  ProductName varchar(60) DEFAULT NULL, '+
                    '  uom varchar(255) DEFAULT NULL, '+
                    '  UnitofMeasureQtySold double NOT NULL DEFAULT 0, '+
                    '  UnitofMeasureShipped double NOT NULL DEFAULT 0, '+
                    '  UnitofMeasureBackorder double NOT NULL DEFAULT 0, '+
                    '  Converted enum("T","F")  DEFAULT "F", '+
                    '  IsInternalOrder enum("T","F")  DEFAULT "F", '+
                    '  slPQAQty double DEFAULT NULL, '+
                    '  slPQAID int(11) DEFAULT NULL, '+
                    '  slPQAuomQty double DEFAULT NULL, '+
                    '  SLPQAactive enum("T","F")  DEFAULT "T", '+
                    '  PTPQAQty double DEFAULT NULL, '+
                    '  PTPQAID int(11) DEFAULT NULL, '+
                    '  PTPQAuomQty double DEFAULT NULL, '+
                    '  PTPQAactive enum("T","F")  DEFAULT "T", '+
                    '  InvSaleId int(11) DEFAULT 0, '+
                    '  InvslPQAQty double DEFAULT NULL, '+
                    '  InvslPQAID int(11) DEFAULT NULL, '+
                    '  InvslPQAuomQty double DEFAULT NULL, '+
                    '  InvSLPQAactive enum("T","F")  DEFAULT "T", '+
                    ' Invalidcode int(11) default 0,'+
                    '  PRIMARY KEY (`ID`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;');
      if Qry.RecordCount>0 then begin
        Qry.First;
        While Qry.Eof = False do begin
          SQL.Add('insert ignore into '+ tablename +' '+
            ' (Saleno,SaleId,CustomerName,TotalAmountinc,TotalAmount,Payment,Balance,SaleDate,futureSo,Done,SalesStatus,shipdate,held, '+
            ' PONumber,terms,Comments,HasSignature,Salestype,ProductName,uom,UnitofMeasureQtySold,UnitofMeasureShipped,UnitofMeasureBackorder, '+
            ' Converted,IsInternalOrder,slPQAQty,slPQAID,slPQAuomQty,SLPQAactive,PTPQAQty,PTPQAID,PTPQAuomQty,PTPQAactive,InvSaleId,InvslPQAQty,InvslPQAID,InvslPQAuomQty,InvSLPQAactive) '+
            ' Select ' +
            ' S.InvoiceDocNumber as Saleno, ' +
            ' S.SaleId           as SaleId, ' +
            ' S.Customername     as CustomerName, ' +
            ' S.totalAmountinc   As TotalAmountinc, ' +
            ' S.totalAmount      As TotalAmount, ' +
            ' S.Payment          As Payment, ' +
            ' S.balance          as Balance, ' +
            ' S.SaleDate         as SaleDate, ' +
            ' S.futureSo         as futureSo, ' +
            ' S.Deleted          as Done, ' +
            ' S.QuoteStatus      as Status, ' +
            ' S.ShipDate         as shipdate, ' +
            ' S.HoldSale         as held, ' +
            ' S.PONumber         as PONumber, ' +
            ' S.terms            as terms, ' +
            ' S.Comments         as Comments, ' +
            ' If(IsNull(S.ClientSignature),"F","T") as HasSignature, ' +
            SaleType+'      as Saletype, ' +
            ' SL.ProductName  as ProductName , ' +
            ' concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as uom, ' +
            ' SL.UnitofMeasureQtySold as UnitofMeasureQtySold, ' +
            ' SL.UnitofMeasureShipped as UnitofMeasureShipped, ' +
            ' SL.UnitofMeasureBackorder as UnitofMeasureBackorder, ' +
            ' S.Converted        as Converted, ' +
            ' S.IsInternalOrder as IsInternalOrder, ' +
            ' SLPQA.Qty as slPQAQty, ' +
            ' SLPQA.PQAID as slPQAID, ' +
            ' SLPQA.uomQty as slPQAuomQty, ' +
            ' SLPQA.active as SLPQAactive, ' +
            ' PTPQA.Qty as PTPQAQty, ' +
            ' PTPQA.PQAID as PTPQAID, ' +
            ' PTPQA.uomQty as PTPQAuomQty, ' +
            ' PTPQA.active as PTPQAactive, ' +
            ' Inv.saleId as InvSaleId, ' +
            ' InvSLPQA.Qty as InvslPQAQty, ' +
            ' InvSLPQA.PQAID as InvslPQAID, ' +
            ' InvSLPQA.uomQty as InvslPQAuomQty, ' +
            ' InvSLPQA.active as InvSLPQAactive ' +
            ' From tblsales S ' +
            ' inner join tblsaleslines SL on S.saleId = SL.saleId and S.IsSalesOrder ="T" ' +
            ' inner join tblproctree PT on PT.MasterId = Sl.saleLineId and PT.MasterType <> "mtProduct" and ifnull(PT.ParentId,0)=0 ' +
            ' inner join tblproctreepart PP on PT.ProcTreeId = PP.ProcTreeId ' +
            ' inner join tblpqa SLPQA on SLPQA.TransLineID = SL.SaleLineID and SLPQA.TransID = SL.SaleID and SLPQA.TransType in ("TSalesOrderline") and SLPQA.Alloctype ="OUT" ' +
            ' inner join tblpqa PTPQA on PTPQA.TransID = SL.saleId and PTPQa.translineId = PP.ProcTreePartId and PTPQa.transtype in ("TProcTreePart") and PTPQa.Alloctype ="IN" ' +
            ' Left join (tblsales Inv ' +
            ' inner join tblsaleslines InvSL on Inv.saleId = InvSL.saleId ' +
            ' inner join tblpqa InvSLPQA on InvSLPQA.TransLineID = InvSL.SaleLineID and InvSLPQA.TransID = InvSL.SaleID and InvSLPQA.TransType in ('+ SalesTransTypes +' ) and InvSLPQA.Alloctype ="OUT" ' +
            ' ) on ifnull(Inv.salesorderGlobalref ,"")= S.GlobalRef and ifnull(InvSl.productId,0) = sl.productId and ifnull(invsl.seqno,0) = sl.seqno ' +
            ' Where SL.ProductID = ' + inttostr(Qry.FieldByName('partsId').asInteger)+
            ' and  S.saledate between ' + quotedstr(Formatdatetime(MysqlDateTimeFormat , filterdatefrom))+' and  ' + quotedstr(Formatdatetime(MysqlDateTimeFormat , filterdateTo))+';');
          Qry.Next;
        end;
      SQL.add('update '+tablename +' set invalidcode =0;');

      {BOM PQa should be active when converted}
      SQL.add('update '+tablename +' set invalidcode =1 where ptpqaactive ="F" and Converted ="T";');
      //SQL.add('update '+tablename +' set invalidcode =7 where ptpqaactive ="T" and Converted ="F";');

      {converted Sales order - Salesline PQa should be inactive}
      SQL.add('update '+tablename +' set invalidcode =2 where converted ="T" and SLPQAactive ="T";');

      {convertd SO, not internal SO, should have an invoice and invoice pqa should be active.
      It is possible to have the invoice deleted at a later stage which is ok}
      SQL.add('update '+tablename +' set invalidcode =3 where  converted ="T" and isinternalorder ="F" and ( ifnull(invSaleid,0) =0 or ifnull(InvSlPqaactive,"F") ="F");');

      {non converted Sales order - Salesline PQa should be inactive}
      SQL.add('update '+tablename +' set invalidcode =4 where  converted ="F" and SLPQAactive="F";');

      {convertd SO, not internal SO, should have an invoice and invoice pqa should be active.
      It is possible to have the invoice deleted at a later stage which is ok}
      SQL.add('update '+tablename +' set invalidcode =5 where  converted ="F" and ((ifnull(invSaleid,0) <>0) or (ifnull(InvSlPqaactive,"F")="T"));');

      {internal order having an invoice}
      SQL.add('update '+tablename +' set invalidcode =6 where  ISInternalorder ="T" and ((ifnull(invSaleid,0) <>0) or (ifnull(InvSlPqaactive,"F")="T"));');

    end;

      DoShowProgressbar(SQL.Count , WAITMSG);
      try
        clog(SQL.Text);
        Execute;
      finally
        DoHideProgressbar;
      end;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
  inherited;
end;

procedure TProductBOMHistoryGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(qryMainslPQAQty.fieldname);
  RemoveFieldfromGrid(qryMainptPQAQty.fieldname);
  RemoveFieldfromGrid(qryMaininvslPQAQty.fieldname);
  RemoveFieldfromGrid(qryMainslPQAID.fieldname);
  RemoveFieldfromGrid(qryMainptPQAID.fieldname);
  RemoveFieldfromGrid(qryMaininvslPQAID.fieldname);
  RemoveFieldfromGrid(qryMainInvalidcode.fieldname);
end;

initialization
  RegisterClassOnce(TProductBOMHistoryGUI);
end.
