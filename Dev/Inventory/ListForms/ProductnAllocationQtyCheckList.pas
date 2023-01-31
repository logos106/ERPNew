unit ProductnAllocationQtyCheckList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TProductnAllocationQtyCheckGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMaindepartmentId: TIntegerField;
    qryMainpqaid: TIntegerField;
    qryMaintransdate: TDateTimeField;
    qryMaintranstype: TWideStringField;
    qryMainqty: TFloatField;
    qryMainuomqty: TFloatField;
    qryMainbatch: TWideStringField;
    qryMainbins: TWideStringField;
    qryMainsn: TWideStringField;
    qryMainbatchQty: TFloatField;
    qryMainuombatchqty: TFloatField;
    qryMainbinQty: TFloatField;
    qryMainuombinqty: TFloatField;
    qryMainSNQty: TFloatField;
    qryMainuomSNqty: TFloatField;
    qryMainBatchmismatch: TWideStringField;
    qryMainBinsmismatch: TWideStringField;
    qryMainSNMismatch: TWideStringField;
    qryMainPartname: TWideStringField;
    qryMainFormname: TWideStringField;
    qryMainclasname: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainTransId: TIntegerField;
    qryMainTransactionNo: TIntegerField;
    qryMaintranslineId: TIntegerField;
    qryMainAvailuomqty      : TFloatField;
    qryMainStockuomqty      : TFloatField;
    qryMainbatchAvailuomqty : TFloatField;
    qryMainbinAvailuomqty   : TFloatField;
    qryMainsnAvailuomqty    : TFloatField;
    qryMainbatchstockuomqty : TFloatField;
    qryMainbinstockuomqty   : TFloatField;
    qryMainsnstockuomqty    : TFloatField;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Tablename :String;
    fiProductId: Integer;
    fiCLassID: Integer;
    function getcLassID: Integer;
    function getProductId: Integer;
    procedure setcLassID(const Value: Integer);
    procedure setProductId(const Value: Integer);
  Protected
    procedure SetGridColumns; Override;
    procedure Refreshtotals;Override;
  public
    Procedure RefreshQuery;Override;
    Property ProductId :Integer read getProductId write setProductId;
    Property cLassID :Integer read getcLassID write setcLassID;
  end;


implementation

uses CommonDbLib, CommonLib, ProductQtyLib, PQALib, LogLib, AppEnvironment,
  tcConst;

{$R *.dfm}

{ TProductnAllocationQtyCheckGUI }

procedure TProductnAllocationQtyCheckGUI.FormCreate(Sender: TObject);
begin
  TableName := GetUserTemporaryTableName('PnAQC');
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('T.* ,');
  Qrymain.sql.add('T.transId as  TransactionNo,');
  Qrymain.sql.add('P.partname as Partname,');
  Qrymain.sql.add('C.classname as clasname,');
  Qrymain.sql.add('TT.Description as Description ,');
  Qrymain.sql.add('if(T.batch="T" and (ifnull(batchqty,0) <> ifnull(qty,0) or ifnull(uombatchqty,0) <> ifnull(uomqty,0)),"T","F")   as Batchmismatch,');
  Qrymain.sql.add('if(T.bins="T" and (ifnull(binqty,0)   <> ifnull(qty,0) or ifnull(uombinqty,0)   <> ifnull(uomqty,0)),"T","F")   as Binsmismatch,');
  Qrymain.sql.add('if(T.sn  ="T" and (ifnull(snqty,0)    <> ifnull(qty,0) or ifnull(uomsnqty,0)    <> ifnull(uomqty,0)),"T","F")   as SNMismatch');
  Qrymain.sql.add('from '+tablename+' as T');
  Qrymain.sql.add('inner join tblparts P on T.ProductID = P.PARTSID');
  Qrymain.sql.add('inner join tblclass C on T.departmentId = C.classId');
  Qrymain.sql.add('Left join tblpqatranstypes TT on T.transtype = TT.Transtype');
  Qrymain.sql.add('where (:Option =1 ) Or');
  Qrymain.sql.add('((:Option =2 or :Option =5) and T.batch="T" and (ifnull(batchqty,0) <> ifnull(qty,0) or ifnull(uombatchqty,0) <> ifnull(uomqty,0))) or');
  Qrymain.sql.add('((:Option =3 or :Option =5) and T.bins ="T" and (ifnull(binqty,0)   <> ifnull(qty,0) or ifnull(uombinqty,0)   <> ifnull(uomqty,0))) or');
  Qrymain.sql.add('((:Option =4 or :Option =5) and T.sn   ="T" and (ifnull(snqty,0)    <> ifnull(qty,0) or ifnull(uomsnqty,0)    <> ifnull(uomqty,0)))');
  Qrymain.sql.add('Order by Partname, classname, TransactionNo desc, Transdate desc');
  inherited;
  ProductId := 0;
  ClassID:=0;
  HaveDateRangeSelection := False;
  SelectionOption :=soClassnProduct;
    AddCalcColumn(QrymainAvailuomqty.FieldName,False);
    AddCalcColumn(QrymainbatchAvailuomqty.FieldName,False);
    AddCalcColumn(QrymainbinAvailuomqty.FieldName,False);
    AddCalcColumn(QrymainsnAvailuomqty.FieldName,False);

    AddCalcColumn(QrymainStockuomqty.FieldName,False);
    AddCalcColumn(Qrymainbatchstockuomqty.FieldName,False);
    AddCalcColumn(Qrymainbinstockuomqty.FieldName,False);
    AddCalcColumn(Qrymainsnstockuomqty.FieldName,False);


end;

procedure TProductnAllocationQtyCheckGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(TableName);
  inherited;
end;

procedure TProductnAllocationQtyCheckGUI.FormShow(Sender: TObject);
begin
  inherited;
  {combo selections are enabled only when the list is not filtered for a product/class}
(*  if Assigned(ClassLookupform)   then ClassLookupform.EnableLookup := fiClassId =0;
  if Assigned(ProductLookupform) then ProductLookupform.EnableLookup := fiProductID=0;*)
end;

procedure TProductnAllocationQtyCheckGUI.RefreshQuery;
begin
  With scriptmain do begin
    SQL.clear;
    SQL.AdD('Drop table if exists '+tablename +';');
    SQL.AdD('CREATE TABLE '+tablename +' ( ' +
            ' ID            INT(11) NOT   NULL AUTO_INCREMENT, ' +
            ' ProductId     INT(11)       NULL DEFAULT NULL, ' +
            ' departmentId  INT(11)       NULL DEFAULT NULL, ' +
            ' pqaid         INT(11)       NULL DEFAULT 0 , ' +
            ' TransId       INT(11)       NULL DEFAULT NULL, ' +
            ' translineId   INT(11)       NULL DEFAULT NULL, ' +
            ' transdate     DATETIME      NULL DEFAULT NULL, ' +
            ' transtype     VARCHAR(255)  NULL DEFAULT NULL, ' +
            ' Formname      VARCHAR(255)  NULL DEFAULT NULL, ' +
            ' Alloctype     VARCHAR(20)   NULL DEFAULT NULL, ' +
            ' batch         ENUM("T","F") NULL DEFAULT "F", ' +
            ' bins          ENUM("T","F") NULL DEFAULT "F", ' +
            ' sn            ENUM("T","F") NULL DEFAULT "F", ' +
            ' active        ENUM("T","F") NULL DEFAULT "F", ' +
            ' isbo          ENUM("T","F") NULL DEFAULT "F", ' +
            ' Reserved      ENUM("T","F") NULL DEFAULT "F", ' +

            ' qty           DOUBLE        NULL DEFAULT NULL, ' +
            ' batchQty      DOUBLE        NULL DEFAULT NULL, ' +
            ' binQty        DOUBLE        NULL DEFAULT NULL, ' +
            ' SNQty         DOUBLE        NULL DEFAULT NULL, ' +

            ' uomqty        DOUBLE        NULL DEFAULT NULL, ' +
            ' uombatchqty   DOUBLE        NULL DEFAULT NULL, ' +
            ' uombinqty     DOUBLE        NULL DEFAULT NULL, ' +
            ' uomSNqty      DOUBLE        NULL DEFAULT NULL, ' +

            ' Availuomqty      DOUBLE        NULL DEFAULT NULL, ' +
            ' batchAvailuomqty DOUBLE        NULL DEFAULT NULL, ' +
            ' binAvailuomqty   DOUBLE        NULL DEFAULT NULL, ' +
            ' snAvailuomqty    DOUBLE        NULL DEFAULT NULL, ' +

            ' Stockuomqty      DOUBLE        NULL DEFAULT NULL, ' +
            ' batchstockuomqty DOUBLE        NULL DEFAULT NULL, ' +
            ' binstockuomqty   DOUBLE        NULL DEFAULT NULL, ' +
            ' snstockuomqty    DOUBLE        NULL DEFAULT NULL, ' +

            ' PRIMARY KEY (ID), ' +
            ' INDEX ProductId (ProductId), ' +
            ' INDEX departmentId (departmentId), ' +
            ' INDEX pqaid (pqaid), ' +
            ' INDEX TransId (TransId), ' +
            ' INDEX translineId (translineId), ' +
            ' INDEX transtype (transtype)     )     COLLATE="utf8_general_ci"     ENGINE=Myisam    ;');

    SQL.AdD('insert ignore into '+tablename +' (ProductId, departmentId, pqaid, TransId, transdate, transtype, Alloctype, qty , uomqty ,active, isbo, Reserved, Availuomqty,Stockuomqty)  ' +
            ' select pqa.ProductId, pqa.departmentId, pqa.pqaid, pqa.TransId, pqa.transdate, pqa.transtype, pqa.Alloctype, pqa.qty , pqa.uomqty , pqa.active,pqa.isbo,pqa.Reserved,' +
          iif(AppEnv.CompanyPrefs.CountSOBOInAvailable,
                  SQL4Qty(tAvailable , 'PQA', 'PQA.UOMQty') +' - ' + ProductQtylib.SQL4Qty(tsobo , 'PQA', 'PQA.UOMQty'),
                  SQL4Qty(tAvailable , 'PQA', 'PQA.UOMQty') )+',' +

              SQL4Qty(tinstock, 'PQA', 'PQA.UOMQty') +
            ' from tblpqa pqa ' +
            ' where 1=1'+
            iif(ProductID<>0 , ' and pqa.productid =' + inttostr(ProductID), '')+
            iif(classID  <>0 , ' and pqa.DepartmentId   =' + inttostr(classID)  , '')+
            ' group by pqa.pqaid;');

    SQL.AdD('update '+tablename +'   T  ' +
            ' inner join tblparts P on P.PartsId = T.productId  ' +
            ' set T.batch = P.batch, T.bins = P.MultipleBins, T.SN = P.SNTracking;');

    SQL.AdD('drop table if exists '+tablename +'1;');
    SQL.AdD('CREATE TABLE '+tablename +'1 ( ' +
            ' ID      INT(11) NOT NULL AUTO_INCREMENT, ' +
            ' pqaid   INT(11) NULL DEFAULT 0 , ' +
            ' qty     DOUBLE NULL DEFAULT NULL, ' +
            ' uomqty  DOUBLE NULL DEFAULT NULL, ' +
            ' Availuomqty  DOUBLE NULL DEFAULT NULL, ' +
            ' instockuomqty  DOUBLE NULL DEFAULT NULL, ' +
            ' PRIMARY KEY (ID), ' +
            ' INDEX pqaid (pqaid)    )    COLLATE="utf8_general_ci"    ENGINE=Myisam    ;');

    SQL.AdD('insert ignore into '+tablename +'1 (pqaid, qty , uomqty,Availuomqty,instockuomqty)  ' +
            ' select t.pqaid , sum(pqad.Qty) as qty, sum(pqad.UOMQty) as uomqty, ' +
              iif(AppEnv.CompanyPrefs.CountSOBOInAvailable,
                SQL4Qty(tAvailable, 't', 'pqad.UOMQty')+'-' + SQL4Qty(tsobo, 't', 'pqad.UOMQty'),
                SQL4Qty(tAvailable, 't', 'pqad.UOMQty')) +','+
              SQL4Qty(tinstock, 't', 'pqad.UOMQty') +
            ' from '+tablename +' t  ' +
            ' inner join tblpqadetails pqad on t.pqaid = pqad.pqaid and pqad.PQAType ="batch" ' +
            ' group by t.pqaid;');

    SQL.AdD('update '+tablename +' T1  ' +
            ' inner join '+tablename +'1 t2 on T1.pqaid = T2.pqaid  ' +
            ' set t1.batchQty = T2.qty , t1.uombatchQty = t2.uomqty, t1.batchAvailuomqty=t2.Availuomqty, t1.batchstockuomqty=t2.instockuomqty;');

    SQL.AdD('truncate table '+tablename +'1;');
    SQL.AdD('insert ignore into '+tablename +'1 (pqaid, qty , uomqty,Availuomqty,instockuomqty)  ' +
            ' select t.pqaid , sum(pqad.Qty) as qty, sum(pqad.UOMQty) as uomqty, ' +
              //SQL4Qty(tAvailable, 't', 'pqad.UOMQty') +','+
              iif(AppEnv.CompanyPrefs.CountSOBOInAvailable,SQL4Qty(tAvailable, 't', 'pqad.UOMQty')+'-' + SQL4Qty(tsobo, 't', 'pqad.UOMQty'),SQL4Qty(tAvailable, 't', 'pqad.UOMQty')) +','+
              SQL4Qty(tinstock, 't', 'pqad.UOMQty') +
            ' from '+tablename +' t  ' +
            ' inner join tblpqadetails pqad on t.pqaid = pqad.pqaid and pqad.PQAType ="bin" ' +
            ' group by t.pqaid;');

    SQL.AdD('update '+tablename +' T1  ' +
            ' inner join '+tablename +'1 t2 on T1.pqaid = T2.pqaid  ' +
            ' set t1.binQty = T2.qty , t1.uombinQty = t2.uomqty, t1.binAvailuomqty=t2.Availuomqty, t1.binstockuomqty=t2.instockuomqty;');

    SQL.AdD('truncate table '+tablename +'1;');
    SQL.AdD('insert ignore into '+tablename +'1 (pqaid, qty , uomqty,Availuomqty,instockuomqty)  ' +
            ' select t.pqaid , sum(pqad.Qty) as qty, sum(pqad.UOMQty) as uomqty, ' +
              //SQL4Qty(tAvailable, 't', 'pqad.UOMQty') +','+
              iif(AppEnv.CompanyPrefs.CountSOBOInAvailable,SQL4Qty(tAvailable, 't', 'pqad.UOMQty')+'-' + SQL4Qty(tsobo, 't', 'pqad.UOMQty'),SQL4Qty(tAvailable, 't', 'pqad.UOMQty')) +','+
              SQL4Qty(tinstock, 't', 'pqad.UOMQty') +
            ' from '+tablename +' t  ' +
            ' inner join tblpqadetails pqad on t.pqaid = pqad.pqaid and pqad.PQAType ="SN" ' +
            ' group by t.pqaid;');

    SQL.AdD('update '+tablename +' T1  ' +
            ' inner join '+tablename +'1 t2 on T1.pqaid = T2.pqaid  ' +
            ' set t1.snQty = T2.qty , t1.uomsnQty = t2.uomqty, t1.snAvailuomqty=t2.Availuomqty, t1.snstockuomqty=t2.instockuomqty;');

    SQL.AdD('update '+tablename +' T  inner join `tblpqatranstypes` as TT on TT.TransType = T.TransType Set T.formname = TT.formname;');

    SQL.AdD('drop table if exists '+tablename +'1;');
    clog(SQL.text);
    logtext(qrymain.SQL.text);
    execute;
  end;
  if grpfilters.itemindex <0 then grpfilters.itemindex := 0;
  qrymain.parambyname('Option').asInteger := grpfilters.itemindex+1;
  inherited;
end;

procedure TProductnAllocationQtyCheckGUI.Refreshtotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TProductnAllocationQtyCheckGUI.setcLassID   (const Value: Integer);begin  fiClassId  := value; if Assigned(ClassLookupform)   then ClassLookupform.LookupID   := Value; end;
procedure TProductnAllocationQtyCheckGUI.setProductId (const Value: Integer);begin  fiProductID:= value; if Assigned(ProductLookupform) then ProductLookupform.LookupID := Value;end;

function TProductnAllocationQtyCheckGUI.getcLassID  : Integer;begin (*Result := ficlassId  ; if result =0 then *)Result := SelectedClassId  ; if result =0 then result := fiClassid;end;
function TProductnAllocationQtyCheckGUI.getProductId: Integer;begin (*Result := fiProductID; if result =0 then *)Result := selectedProductID; if result =0 then result := fiProductId;end;

procedure TProductnAllocationQtyCheckGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainID.Fieldname);
    RemoveFieldfromGrid(qryMainProductId.Fieldname);
    RemoveFieldfromGrid(qryMaindepartmentId.Fieldname);
    RemoveFieldfromGrid(qryMainpqaid.Fieldname);
    RemoveFieldfromGrid(qryMaintranslineId.Fieldname);
    RemoveFieldfromGrid(qryMaintranstype.Fieldname);
    RemoveFieldfromGrid(qryMainFormname.Fieldname);
    RemoveFieldfromGrid(qryMainTransactionNo.Fieldname);
end;


procedure TProductnAllocationQtyCheckGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
       if qryMainBatchmismatch.asBoolean and (sametext(field.fieldname, qryMainbatchstockuomQty.fieldname) (*or sametext(field.fieldname, qryMainuombatchqty.fieldname)*)) then Doredhighlight(AFont,ABrush);
       if qryMainbinsmismatch.asBoolean  and (sametext(field.fieldname, qryMainbinstockuomQty.fieldname  ) (*or sametext(field.fieldname, qryMainuombinqty.fieldname  )*)) then Doredhighlight(AFont,ABrush);
       if qryMainsnmismatch.asBoolean    and (sametext(field.fieldname, qryMainsnstockuomQty.fieldname   ) (*or sametext(field.fieldname, qryMainuomsnqty.fieldname   )*)) then Doredhighlight(AFont,ABrush);
end;

procedure TProductnAllocationQtyCheckGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TProductnAllocationQtyCheckGUI);

end.
