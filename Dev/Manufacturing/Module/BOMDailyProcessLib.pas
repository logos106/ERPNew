unit BOMDailyProcessLib;

interface

uses ERPdbComponents, classes, busobjbase;

type
  TBOMDAilyProcessObj = Class(TComponent)
  Private
    //fERPConn :TERPconnection;
    fMyDacDataConn :TMyDacDataConnection;
    //fsUniqueProcesstimeTable:String;
    QrySalesList_Sum :TERPQuery;
    QrySalesList_Det :TERPQuery;
    QryResourceForProduct :TERPQuery;
    AnyScheduled:Boolean;
    Function ERPConn :TERPconnection;
    Function MyDacDataConn :TMyDacDataConnection;

    Function SalesList_Sum(const SalesLineIDs:String):TERPQuery;
    Function SalesList_Det(const SalesLineIDs: String; aProductID:Integer):TERPQuery;

    Function ResourceForProduct(aProductID:Integer):TERPQuery;
    procedure DoMakeSchedule(aQryResourceForProduct,aqrySalesList_Det:TERPQuery ; adQty :Double);
    procedure DoCompleteSalesLine(datefrom, dateTo:TDateTime;aqrySalesList_Det:TERPQuery ; adQty :Double);
    procedure NextDate(aProcresourcedetailID:Integer;aQryResourceForProduct:TERPQuery;aSeqno:Integer;aQtyUsed:Double=0);
    (*procedure NextDate(aResourceForProductID: Integer);Overload;*)
    function ResourceAvailablefortheDate(aResourceForProductID: Integer): Boolean;
    function endofThedayof(const aDate: TDatetime): TDatetime;
    function StartofThedayof(const aDate: TDatetime): TDatetime;
  Protected

  Public
    Constructor Create(AOwner:TComponent);Override;
    Destructor Destroy;Override;
    Class Function AutoSchedule(AOwner:TComponent; SalesLineIDs:String; var aScheduleFromDate:TDateTime):Boolean;
    Function DoAutoSchedule(SalesLineIDs:String; var aScheduleFromDate:TDateTime):Boolean;Overload;
    function DoAutoSchedule(SalesLineIDs: String;aProductID:Integer; var aScheduleFromDate:TDateTime):Boolean;Overload;
  End;


//procedure PopulateUniqueProcesstimeTable(var tablename :String);
function SalesListSQL(st:TStrings; const SalesLineIDs: String(*; UniqueProcesstimeTableName:String*); IncludeScheduled:Boolean = False): String;

implementation

uses DbSharedObjectsObj, CommonLib, CommonDbLib, dateutils, MySQLConst, sysutils,
  ProcessUtils, BusObjProcResource, BusObjProcessTimeNDS, AppEnvironment,
  BusObjProcessPartNDS, LogLib;

(*procedure PopulateUniqueProcesstimeTable(var tablename :String);
var
  cmd :TERPCommand;
begin
  if tablename ='' then tablename := CommonDbLib.GetUserTemporaryTableName('pst' );
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    with cmd do begin
        SQL.clear;
        SQL.Add('Drop table if exists ' + tablename +'1;');
        SQL.Add('CREATE TABLE '+ tablename +' Select Distinct processpartid FROM tblprocesstime where status <> "psNotScheduled";');
        SQL.Add('ALTER TABLE '+ tablename +' 	ADD INDEX processpartid (processpartid);');
        Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;*)

function TBOMDAilyProcessObj.ERPConn: TERPconnection;
begin
   (* if fERPConn = nil then begin
      fERPConn := GetNewMyDacConnection(Owner);
    end;
    if fERPConn.connected =False then begin
      fERPConn.connected := true;
    end;
    result := fERPConn;*)
    result := TERPConnection(MyDacDataConn.Connection);
end;
function TBOMDAilyProcessObj.MyDacDataConn: TMyDacDataConnection;
begin
    if fMyDacDataConn = nil then begin
      fMyDacDataConn := TMyDAcDataconnection.Create(Owner);
      fMyDacDataConn.Connection := GetNewMyDacConnection(fMyDacDataConn);
    end;
    result := fMyDacDataConn;
end;

constructor TBOMDAilyProcessObj.Create(AOwner: TComponent);
begin
  inherited;
  //fERPConn := nil;
  fMyDacDataConn := nil;
  //fsUniqueProcesstimeTable:='';
  QrySalesList_Sum := nil;
  QrySalesList_Det := nil;
  QryResourceForProduct := nil;
end;

destructor TBOMDAilyProcessObj.Destroy;
begin
  //DestroyUserTemporaryTable(fsUniqueProcesstimeTable);
  try if QrySalesList_Sum <> nil then  DbSharedObjectsObj.DbSharedObj.ReleaseObj(QrySalesList_Sum); Except end;
  try if QrySalesList_Det <> nil then  DbSharedObjectsObj.DbSharedObj.ReleaseObj(QrySalesList_Det); Except end;
  try if QryResourceForProduct <> nil then  DbSharedObjectsObj.DbSharedObj.ReleaseObj(QryResourceForProduct); Except end;
  Freeandnil(fMyDacDataConn);

  inherited;
end;
Function SalesListSQL(st:TStrings;  const SalesLineIDs:String(*; UniqueProcesstimeTableName:String*); IncludeScheduled:Boolean = False):String;
begin
    //if UniqueProcesstimeTableName ='' then PopulateUniqueProcesstimeTable(UniqueProcesstimeTableName);
    st.clear;
    st.add(' SELECT ' );
    st.add(' S.saleID            AS saleID         , ' );
    st.add(' if(Status =  ' + quotedstr(ProcessPartStatusToStr(psNotScheduled))+', "F","T") as Scheduled,') ;
    st.add(' sl.ProductID        AS ProductID      , ' );
    st.add(' sl.SaleLineId       AS SaleLineId     , ' );
    st.add(' sl.ProductName      AS ProductName    , ' );
    st.add(' S.saledate          AS saledate       , ' );
    st.add(' Sum(sl.Shipped)     AS Shipped        , ' );
    st.add(' sum(PP.Duration+ PP.Setupduration + PP.breakdownduration) AS totalDuration, ' );
    st.add(' PP.ID               AS ProcesspartID, ' );
    st.add(' prpr.seqno          AS seqno          , ' );
    st.add(' PS.Description      AS Processstep    , ' );
    st.add(' PRPR.ProcresourcedetailID as ProcresourcedetailID    , ' );
    st.add(' PTP.Proctreepartid  AS Proctreepartid , ');
    st.add(' PT.proctreeid       AS proctreeid       ' );
    st.add(' FROM tblsales s ' );
    st.add(' inner join tblsaleslines           SL    ON s.saleId           = SL.saleId' );
    st.add(' INNER JOIN tblproctree             PT    ON PT.MasterId        = SL.SaleLineID AND PT.MasterType <> "mtProduct" AND PT.proctreeid = PT.TreeRootId ' );
    st.add(' INNER JOIN tblprocesspart          PP    ON PT.ProcTreeId      = PP.ProcTreeId ' );
    st.add(' INNER JOIN tblproctreepart         PTP   ON PTP.ProcTreeId     = PT.ProcTreeId ' );
    st.add(' INNER JOIN tblprocessstep          PS    ON PS.ID              = PP.ProcessStepID ' );
    st.add(' INNER JOIN tblprocresourceprocess  PRP   ON PP.ProcessStepID   = PRP.ProcessStepId ' );
    st.add(' INNER JOIN tblprocresource         PR    ON PRP.ProcResourceId = PR.ProcResourceId  and PR.UsedWithProductsInSeq ="T"' );
    st.add(' INNER JOIN tblprocresourcedetails  PRD   ON PR.ProcResourceId  = PRD.ProcResourceId ' );
    st.add(' INNER JOIN tblprocresourceproducts PRPR  ON PRPR.ProcresourcedetailID = PRD.ID AND SL.ProductID = PRPR.ProductId ' );
    st.add(' WHERE S.issalesorder ="T" and S.COnverted ="F" ');
    if not(IncludeScheduled)   then st.add(' AND Status =  ' + quotedstr(ProcessPartStatusToStr(psNotScheduled))) ;
    if trim(SalesLineIDs)<> '' then st.add(' AND Sl.saleLineId in (' + SalesLineIDs +')');
end;
function TBOMDAilyProcessObj.SalesList_Det(const SalesLineIDs: String; aProductID:Integer): TERPQuery;
begin
  if QrySalesList_Det = nil then QrySalesList_Det := DbSharedObjectsObj.DbSharedObj.GetQuery(ERPConn);
  closedb(QrySalesList_Det);
  QrySalesList_Det.SQL.clear;
  SalesListSQL(QrySalesList_Det.SQL, SalesLineIDs);
  if aProductID <> 0 then QrySalesList_Det.SQL.add('AND sl.productid =' + inttostr(aProductID)+' AND PT.ProcTreeId = PT.TreeRootId ');
  QrySalesList_Det.SQL.add('group by SaleLineId,  productID ');
  QrySalesList_Det.SQL.add('order by Seqno ');
  opendb(QrySalesList_Det);
  Result := QrySalesList_Det;
  //Logtext('Sales Details');
  //Logtext(QrySalesList_Det.SQLtext);
end;
function TBOMDAilyProcessObj.ResourceForProduct(aProductID:Integer): TERPQuery;
begin
  if QryResourceForProduct = nil then QryResourceForProduct := DbSharedObjectsObj.DbSharedObj.GetQuery(ERPConn);
  if QryResourceForProduct.active and (QryResourceForProduct.parambyname('ProductID').asInteger = aProductID) then begin
  end else begin
    QryResourceForProduct.SQL.clear;
    QryResourceForProduct.SQL.add('SELECT DISTINCT M.ID,M.ProcresourcedetailID	,M.ProductId,M.ProductName	,M.Seqno	,M.NoOfResources,M.Active	,M.ResourceDate	, ');
    QryResourceForProduct.SQL.add('PRD.UOMQty, PRD.UOMQty * M.NoOfResources ResourceCapacity , P.seqno as pseqno');
    QryResourceForProduct.SQL.add('FROM tblprocresourceproducts  M   ');
    QryResourceForProduct.SQL.add('INNER JOIN tblprocresourceproducts P ON P.Active ="T" AND P.ProductId = :ProductID AND M.ProcresourcedetailID = P.ProcresourcedetailID   ');
    QryResourceForProduct.SQL.add('INNER JOIN tblprocresourcedetails PRD ON PRD.ID = M.ProcresourcedetailID ');
    QryResourceForProduct.SQL.add('WHERE M.Active ="T" and  M.Seqno <= P.seqno AND IFNULL(M.NoOfResources,0)>0    ');
    QryResourceForProduct.SQL.add('ORDER BY M.resourcedate , M.seqno DESC ');
    QryResourceForProduct.Parambyname('ProductID').asInteger := aProductId;
    //Logtext('Product REsource');
    //Logtext(QryResourceForProduct.SQLtext);
  end;
  opendb(QryResourceForProduct);
  Logtext('Checking for resource Availability for '+ QryResourceForProduct.Fieldbyname('ProductName').asString +'(' + inttostr(QryResourceForProduct.Fieldbyname('Seqno').asInteger)+')');
  While true do begin
    closedb(QryResourceForProduct);
    opendb(QryResourceForProduct);
    if QryResourceForProduct.recordcount =0 then begin
      break;
    end;
    if ResourceAvailablefortheDate(QryResourceForProduct.fieldbyname('ID').asInteger) then begin
      Logtext('Available for ' + FormatDateTime('dd-mm-yyyy' , QryResourceForProduct.Fieldbyname('ResourceDate').asDateTime));
      break;
    end;
    Logtext('Check for next Day ' + FormatDateTime('dd-mm-yyyy' , QryResourceForProduct.Fieldbyname('ResourceDate').asDateTime));
    //NextDate(QryResourceForProduct.Fieldbyname('ProcresourcedetailID').asInteger, QryResourceForProduct, QryResourceForProduct.Fieldbyname('Seqno').asInteger);
    NextDate(QryResourceForProduct.Fieldbyname('ProcresourcedetailID').asInteger, QryResourceForProduct, QryResourceForProduct.Fieldbyname('Seqno').asInteger);
  end;
end;

function TBOMDAilyProcessObj.SalesList_Sum(const SalesLineIDs:String):TERPQuery;
begin
  if QrySalesList_Sum = nil then QrySalesList_Sum := DbSharedObjectsObj.DbSharedObj.GetQuery(ERPConn);
  closedb(QrySalesList_Sum);
  QrySalesList_Sum.SQL.clear;
  SalesListSQL(QrySalesList_Sum.SQL, SalesLineIDs);
  QrySalesList_Sum.SQL.add('group by productID ');
  QrySalesList_Sum.SQL.add('order by Seqno ');
  opendb(QrySalesList_Sum);
  Result := QrySalesList_Sum;
  //Logtext('Sales Summary');
  //Logtext(QrySalesList_Sum.SQLtext);
end;

Class Function TBOMDAilyProcessObj.AutoSchedule(AOwner:TComponent; SalesLineIDs:String; var aScheduleFromDate:TDateTime):Boolean;
var
  QrySales:TERPQuery;
  aDailyProcessObj :TBOMDAilyProcessObj ;
begin
  Result := False;
  if trim(SalesLineIDs) = '' then exit;
  aDailyProcessObj :=TBOMDAilyProcessObj.create(AOwner);
  try
    Result := aDailyProcessObj.DoAutoSchedule(SalesLineIDs, aScheduleFromDate);
  finally
    Freeandnil(aDailyProcessObj);
  end;
end;
function TBOMDAilyProcessObj.StartofThedayof(const aDate:TDatetime):TDatetime;
begin
  REsult :=  dateof(aDate) + TimeOf(AppEnv.CompanyPrefs.StartOfDay);
end;
function TBOMDAilyProcessObj.endofThedayof(const aDate:TDatetime):TDatetime;
begin
  REsult :=  dateof(aDate) + TimeOf(AppEnv.CompanyPrefs.endOfDay);
end;
function TBOMDAilyProcessObj.DoAutoSchedule(SalesLineIDs: String;aProductID:Integer; var aScheduleFromDate:TDateTime):Boolean;
var
  fdQtyToBuild, fdREsource, fdQty, fdRunningQty:double;
  fdtStart, fdtEnd:TDateTime;

  Procedure OpenResourceForProduct;
  begin
      ResourceForProduct(QrySalesList_Det.Fieldbyname('ProductId').asInteger);
      if QryResourceForProduct.Recordcount =0 then begin
        fdREsource:= 0;
        Exit;
      end;

      QryResourceForProduct.First;
      fdREsource :=QryResourceForProduct.Fieldbyname('ResourceCapacity').asFloat;
      //if trunc(fdREsource) <> fdREsource then fdREsource := trunc(fdREsource)+1;
  end;
begin
  if trim(SalesLineIDs) = '' then exit;
  if aProductId =0 then exit;
  fdREsource := 0;
  fdRunningQty:= 0;

  With  SalesList_Det(SalesLineIDs, aProductID) do begin
      if recordcount =0 then exit;
      First;


      While EOF = False do begin
        if fdREsource <=0 then begin
          OpenResourceForProduct;
          if QryResourceForProduct.Recordcount =0 then begin
            Next;
            continue;
          end;
        end;
        fdQtyToBuild := Fieldbyname('Shipped').asFloat;
        fdtStart:= 0;
        fdtEnd := 0;
        While (fdQtyToBuild>0) do begin
          fdQty := 0;
          if fdQtyToBuild <= fdREsource then begin
            fdQty := fdQtyToBuild;
            fdQtyToBuild := 0;
            fdREsource := fdREsource - fdQty;
          end else begin
            fdQty := fdREsource;
            fdQtyToBuild := fdQtyToBuild-fdQty;
            fdREsource := 0;
          end;
          if fdtStart = 0 then fdtStart := StartofThedayof(QryResourceForProduct.FieldByName('ResourceDate').asdatetime) ;//Startoftheday(QryResourceForProduct.FieldByName('ResourceDate').asdatetime);
          //if fdtEnd < endoftheday(QryResourceForProduct.FieldByName('ResourceDate').asdatetime) then fdtEnd := endoftheday(QryResourceForProduct.FieldByName('ResourceDate').asdatetime);
          if fdtEnd < EndofThedayof(QryResourceForProduct.FieldByName('ResourceDate').asdatetime) then fdtEnd := EndofThedayof(QryResourceForProduct.FieldByName('ResourceDate').asdatetime);
          AnyScheduled:= true;
          DoMakeSchedule(QryResourceForProduct,qrySalesList_Det , fdQty);
          fdRunningQty := fdRunningQty +fdQty;
          if (fdREsource =0) and (fdQtyToBuild>0) then begin
            NextDate(FieldByName('ProcresourcedetailID').asInteger, QryResourceForProduct, FieldByName('Seqno').asInteger, fdRunningQty(*.FieldByName('Seqno').asInteger, QryResourceForProduct.Fieldbyname('ID').asInteger*));
            OpenResourceForProduct; fdRunningQty:= 0;
          end;
        end;
        if (fdtEnd<>0) and (fdtStart<>0)  then begin
          if (aScheduleFromDate=0) or (aScheduleFromDate > fdtStart) then aScheduleFromDate :=  fdtStart;
          //NextDate(FieldByName('ProcresourcedetailID').asInteger, QryResourceForProduct, FieldByName('Seqno').asInteger, fdRunningQty (*.FieldByName('Seqno').asInteger, QryResourceForProduct.Fieldbyname('ID').asInteger*));
          DoCompleteSalesLine(fdtStart,fdtEnd, qrySalesList_Det , fdQty);
        end;
        Next;
      end;
      if fdRunningQty <> 0 then
        NextDate(FieldByName('ProcresourcedetailID').asInteger, QryResourceForProduct, FieldByName('Seqno').asInteger , fdRunningQty);
  end;
end;
function TBOMDAilyProcessObj.ResourceAvailablefortheDate(aResourceForProductID:Integer):Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(ERPConn);
  try
    Closedb(qry);
    Qry.SQL.Clear;
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND sunday    ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 1 UNION');
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND Monday    ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 2 UNION');
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND Tuesday   ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 3 UNION');
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND Wednesday ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 4 UNION');
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND Thursday  ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 5 UNION');
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND Friday    ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 6 UNION');
    Qry.SQL.add('SELECT PRDD.* FROM tblprocresourceproducts PRDD ' + ' INNER JOIN tblprocresourcedetails PRD ON PRD.ID = PRDD.ProcresourcedetailID  ' + ' INNER JOIN tblprocresourcedays PR ON PR.ProcResourceID = PRD.ProcResourceId WHERE PRDD.ID=' + inttostr(aResourceForProductID)+' AND Saturday  ="T" AND DAYOFWEEK(PRDD.ResourceDate)= 7');
    opendb(Qry);
    result := (Qry.recordcount >0) and (Dateof(Qry.fieldbyname('ResourceDate').asDateTime)>Date) ;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Procedure TBOMDAilyProcessObj.NextDate(aProcresourcedetailID:Integer;aQryResourceForProduct:TERPQuery;aSeqno:Integer;aQtyUsed:Double=0);
var
  qry: TERPQuery;
  logedtitle :Boolean;
  Procedure LogQry(const comment :String);
  begin

    if not logedtitle then Logtext('comment:ProcresourcedetailID,ProductId,ProductName,Seqno,NoOfResources,ResourceDate', 'd:\erp.log');
    logedtitle := true;
    qry.First;
    While qry.EOF = False do begin
      Logtext(comment +':' +
             inttostr(qry.FieldByName('ProcresourcedetailID').asInteger)+','+
             inttostr(qry.FieldByName('ProductId').asInteger)+','+
             qry.FieldByName('ProductName').asString+','+
             inttostr(qry.FieldByName('Seqno').asInteger)+','+
             inttostr(qry.FieldByName('NoOfResources').asInteger)+','+
             Formatdatetime('dd/mm/yyyy', qry.FieldByName('ResourceDate').asDatetime), 'd:\erp.log');
      qry.Next;
    end;
    qry.First;
  end;
begin
    logedtitle :=False;
    qry := DbSharedObj.GetQuery(ERPConn);
    try
      qry.SQL.Clear;
      qry.SQL.Add('SELECT M.* FROM tblprocresourceproducts  M '+
                  ' WHERE M.Active ="T"  '+
                  ' AND ((M.Seqno = ' + inttostr(aSeqno)+' and  ' + inttostr(aSeqno)+'<> 0) Or ID = ' + inttostr(aQryResourceForProduct.Fieldbyname('ID').asInteger)+' )  '+
                  ' AND M.ProcresourcedetailID= ' + inttostr(aProcresourcedetailID));
      qry.open;
      LogQry('Before');
      try
            if qry.Locate('ID' , aQryResourceForProduct.Fieldbyname('ID').asInteger , []) then begin
                try
                    if  (aQryResourceForProduct.FieldByName('Seqno').asInteger = aSeqno) then begin
                      EditDB(qry);
                      qry.Fieldbyname('ResourceDate').asDateTime := incday(qry.Fieldbyname('ResourceDate').asDateTime);
                      Exit;
                    end else if aQtyUsed <> 0 then begin
                      if aQryResourceForProduct.Fieldbyname('ResourceCapacity').AsFloat <= aQtyUsed then begin
                        EditDB(qry);
                        qry.Fieldbyname('NoofResources').asInteger :=  0;
                      end else begin
                        EditDB(qry);
                        qry.Fieldbyname('NoofResources').asInteger := trunc((aQryResourceForProduct.Fieldbyname('ResourceCapacity').AsFloat - aQtyUsed)/aQryResourceForProduct.Fieldbyname('UOMQty').AsFloat);
                      end;
                    end;
                finally
                  PostDB(qry);
                end;
            end;

            if qry.Locate('seqno' , aSeqno , []) then begin
              if devmode then begin
                LogQry('Between');
                qry.Locate('seqno' , aSeqno , []);
              end;
              EditDB(qry);
              qry.Fieldbyname('NoofResources').asInteger :=  Qry.Fieldbyname('NoofResources').asInteger + trunc((aQtyUsed / aQryResourceForProduct.Fieldbyname('UOMQty').AsFloat));

              if (Qry.Fieldbyname('REsourceDate').asDateTime <= aQryResourceForProduct.Fieldbyname('REsourceDate').asDateTime) then begin
                qry.Fieldbyname('REsourceDate').asDateTime := incday(aQryResourceForProduct.Fieldbyname('REsourceDate').asDateTime,1);
              end;

              if  (Qry.Fieldbyname('REsourceDate').asDateTime <=date) then begin
                qry.Fieldbyname('REsourceDate').asDateTime := incday(date,1);
              end;

              PostDB(qry);
            end;
      finally
        LogQry('After');
      end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;
(*Procedure TBOMDAilyProcessObj.NextDate(aResourceForProductID:Integer);
var
  qry: TERPQuery;
begin
  inherited;
  qry := DbSharedObj.GetQuery(ERPConn);
  try
    qry.SQL.Clear;
    qry.SQL.Add('Select * from tblprocresourceproducts where ID = ' + inttostr(aResourceForProductID));
    qry.open;
    qry.Fieldbyname('ResourceDate').asDateTime := incday(qry.Fieldbyname('ResourceDate').asDateTime);
    PostDB(Qry);
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;*)
Procedure TBOMDAilyProcessObj.DoMakeSchedule(aQryResourceForProduct,aqrySalesList_Det:TERPQuery ; adQty :Double);
var
  obj : TProcResourceSchedule;
  Pt: TProcessTimeNDS;
  //fiProcesstimeID:Integer;
begin
  obj := TProcResourceSchedule.CreateWithNewConn(Self, ERPConn);
  try
    //With obj do begin
      obj.Load(0);
      obj.New;
      obj.ResourceProductID := aQryResourceForProduct.FieldByName('ID').asInteger;
      obj.SaleLineId        := aqrySalesList_Det.FieldByName('SaleLineId').asInteger;
      obj.proctreeid        := aqrySalesList_Det.FieldByName('proctreeid').asInteger;
      obj.ProcesspartID     := aqrySalesList_Det.FieldByName('ProcesspartID').asInteger;
      obj.SaleID            := aqrySalesList_Det.FieldByName('SaleID').asInteger;
      obj.Seqno             := aqrySalesList_Det.FieldByName('Seqno').asInteger;//aQryResourceForProduct.FieldByName('Seqno').asInteger;
      obj.ScheduledQty      := adQty;
      obj.ScheduleDate      := Dateof(aQryResourceForProduct.FieldByName('ResourceDate').asDateTime);
      obj.PostDB;
      PT:= TProcessTimeNDS.create(obj);
      try
        Pt.ProcessPartId     := aqrySalesList_Det.Fieldbyname('ProcesspartID').asInteger;
        Pt.TimeStart         := StartofThedayof(aQryResourceForProduct.Fieldbyname('resourcedate').asDateTime);
        Pt.Duration          := SecondsBetween(AppEnv.CompanyPrefs.StartOfDay,AppEnv.CompanyPrefs.EndOfDay) ;// 24*60*60; // whole day //Secondsbetween(Timestart,Timeend);
        Pt.Active            := true;
        Pt.ResourcedetailsID := aQryResourceForProduct.FieldByName('ProcresourcedetailID').asInteger;
        Pt.EmployeeId        := appenv.Employee.EmployeeID;
        if Pt.SaveNoCheck then begin
            obj.ProcesstimeID := pt.ID;
            obj.PostDB;
        end;

      finally
        Freeandnil(Pt);
      end;
    //end;
  finally
    Freeandnil(obj);
  end;
end;
procedure TBOMDAilyProcessObj.DoCompleteSalesLine(datefrom, dateTo:TDateTime;aqrySalesList_Det:TERPQuery ; adQty :Double);
var
  cmd :TERPCommand;
  qry: TERPQuery;
  fs:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(ERPConn);
  try
    Closedb(qry);
    qry.SQL.clear;
    qry.SQL.Add('SELECT PP.Id FROM `tblProcessPart` PP INNER JOIN tblproctree pt ON PP.proctreeid = pt.ProcTreeId WHERE pt.TreeRootId = ' +inttostr(aqrySalesList_Det.FieldByName('Proctreeid').AsInteger ));
    Opendb(qry);
    fs:=qry.GroupConcat('ID', '', False, ',', '','',False, True)
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  if fs = '' then exit;// this shouldn't happen

  cmd := DbSharedObj.Getcommand(ERPConn);
  try
    cmd.SQL.Clear;
    cmd.SQL.AdD('update tblProcessPart Set TimeStart = ' + Quotedstr(Formatdatetime(MySQLDatetimeFormat ,  datefrom))+',' +
                                         //' TimeEnd = ' + Quotedstr(Formatdatetime(MySQLDatetimeFormat ,  dateTo))+ ',' +
                                         ' Status =  ' + quotedstr(ProcessPartStatusToStr(psScheduled)) +
                                         ' where ID in (' + fs+');');
    //cmd.SQL.AdD('update tblproctree Set complete ="T" where TreeRootId = ' +inttostr(aqrySalesList_Det.FieldByName('Proctreeid').AsInteger )+';');
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;
function TBOMDAilyProcessObj.DoAutoSchedule(SalesLineIDs: String; var aScheduleFromDate:TDateTime): Boolean;
var
  ProductIDs :String;
begin
  AnyScheduled:= False;
  try
      if trim(SalesLineIDs) = '' then exit;
      MyDacDataConn.BeginTransaction;
      try
        With  SalesList_Sum(SalesLineIDs) do begin
          if recordcount =0 then exit;
          ProductIDs := GroupConcat('ProductId', '', False, ',','','',False, true);
          if trim(ProductIDs)='' then exit ;// this shouldn't happen
          First;
          aScheduleFromDate := 0;
          while EOF = False do begin
            DoAutoSchedule(SalesLineIDs, Fieldbyname('ProductID').asInteger, aScheduleFromDate);
            Next;
          end;
        end;
        MyDacDataConn.CommitTransaction;
      Except
        on E:Exception do begin
          Result := False;
          MyDacDataConn.RollbackTransaction;
        end;
      end;
  finally
    Result := AnyScheduled;
  end;
end;


end.
