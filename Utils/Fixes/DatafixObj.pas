unit DatafixObj;



interface
uses
  Classes, ERPdbComponents;

type
  TGeneralStringProc    = Procedure (const Value:String) of Object;

  TDatafixObj = class(TComponent)
  Private
    fConnection: TERPConnection;
    fsErrmsg: String;
    fsinfoMsg: String;
    fsdatabasename: String;
    fsServername: String;
    fProgressdialog: TGeneralStringProc;

    function NewQuery(SQL: string = ''): TERPQuery;
    function FixRequired(fixedVersiono: String): boolean;
    function ExecuteSQL(SQL: string): Boolean;
    function getConnection: TERPConnection;
    Procedure Backuptable(TableName,versionNo:String);
    function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
    function fields(Tablename1, tablename2: String): String;
    Procedure AddErrMsg(const Value:String);
    Procedure AddInfomsg(const Value:String);
    Procedure DeleteDeletedInvoiceLines;
    Procedure DeleteDeletedSOLines;
    Procedure DeleteDeletedPOLines;
    Procedure DoProgressdialog(Const Value:String);
    function HasPPG:Boolean;
  Protected

  Public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    Property Connection: TERPConnection read getConnection write fConnection;
    Property Errmsg:String read fsErrmsg write fsErrmsg;
    Property infoMsg :String read fsinfoMsg write fsinfoMsg;
    Property Servername:String read fsServername write fsServername;
    Property databasename :String read fsdatabasename write fsdatabasename;
    Property Progressdialog:TGeneralStringProc Read fProgressdialog write fProgressdialog;
    function FixInactivePQAs: Boolean;
    function FixDeletedTranslines: Boolean;
    function FixDeletedProductMovements: boolean;
    function PPGCheknFix:Boolean;
//    Function FixReturns:Boolean;
  end;

implementation

uses {UtilsLib,}
  VersionUtils, sysutils, DbConst, db, DbSharedObjectsObj, EmailUtilsSimple,
  MailServerConst, Windows, ModuleFileNameUtils, TempTableUtils,
  ERPVersionConst;



{ TDatafixObj }
function TDatafixObj.getConnection: TERPConnection;
begin
    result := nil;
    if fsdatabasename = '' then exit;
    if fsServername = '' then exit;
    if fConnection = nil then begin
      fConnection := TERPConnection.Create(nil);
      fConnection.Port := SERVER_PORT;
      fConnection.Username := SYSDB_USER;
      fConnection.Password := SYSDB_PASS;
      fConnection.Options.Compress := MYDAC_OPTIONS_COMPRESS;
      fConnection.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
      fConnection.LoginPrompt := False;
      fConnection.Server := Servername;
      fConnection.Database := databasename;
      fConnection.Open;
    end;
    REsult := fConnection;
end;
(*Function TDatafixObj.BackuptableSQL(const aTablename , abackupTablename:String):String;
begin
  result := '';
  if not TempTableUtils.TableExists(Connection, abackupTablename) then begin
      Result := ' Create table if not exists ' +abackupTablename+'  like like '+aTablename+'; ' +
                ' insert ignore into  ' +abackupTablename+'  select * from  '+aTablename+' ; ' ;
  end else begin

  end;
end;*)
function TDatafixObj.HasPPG: Boolean;
var
  qry: TERPQuery;
begin
  result := false;
  qry := DbSharedObj.GetQuery(Connection);
  try
    qry.SQL.Text := 'select version from tblupdatedetails';
    qry.Open;
    if VersionComp(qry.FieldByName('version').AsString,'2018.4.2.0') >= 0 then begin
      qry.Close;
      qry.SQL.Text := 'Select count(*) ctr from tblprocprogress';
      qry.open;
      Result := qry.fieldbyname('ctr').AsInteger>0;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TDatafixObj.FixDeletedProductMovements: boolean;
var
  qry: TERPQuery;
  s: string;
  SendTo: string;
begin
  result := true;
  SendTo := EMAIL_SUPPORT_RECEPIENT;
  qry := DbSharedObj.GetQuery(Connection);
  try
    qry.SQL.Text := 'select version from tblupdatedetails';
    qry.Open;
    if VersionComp(qry.FieldByName('version').AsString,'14.0.0.0') >= 0 then begin
      AddInfoMsg('Checking deleted Stock Movements ...');
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select tblstockadjustentry.CreationDate, tblstockadjustentry.StockAdjustEntryID, tblstockadjustentry.Employee, tblstockmovement.StockmovementID');
      qry.SQL.Add('from tblstockadjustentry, tblstockmovement');
      qry.SQL.Add('where tblstockmovement.StockmovementEntryglobalref = tblstockadjustentry.GlobalRef and tblstockmovement.StockmovementEntryType = "StockAdjustEntry" ');
      qry.SQL.Add('and tblstockmovement.Deleted = "F" and tblstockadjustentry.Deleted = "T"');
      qry.Open;
      if not qry.IsEmpty then begin
        s:= 'The following '+ IntToStr(qry.RecordCount) + ' Stock Adjustments in Database '+ Connection.Database +' where marked as Deleted but the linked Stock Movement was not deleted:' + #13#10;
        while not qry.Eof do begin
          s:= s + 'Creation Date: ' + qry.FieldByName('CreationDate').AsString +
            '  Employee: ' + qry.FieldByName('Employee').AsString +
            '  Stock Adjust Entry Id: ' + qry.FieldByName('StockAdjustEntryID').AsString +
            '  Stock Movement Id: ' + qry.FieldByName('StockMovementID').AsString + #13#10;
          qry.Next;
        end;
        AddInfoMsg(s);
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblcompanyinformation');
        qry.Open;
        s := 'This is an auto generated message from ' + self.ClassName + #13#10 + #13#10 +
          'During a Maintenance check errors where found for the following company:' + #13#10 + #13#10 +
          qry.FieldByName('CompanyName').AsString + #13#10 +
          qry.FieldByName('Address').AsString + #13#10 +
          qry.FieldByName('Address2').AsString + #13#10 +
          qry.FieldByName('City').AsString + '  ' + qry.FieldByName('State').AsString  + '  ' +qry.FieldByName('PostCode').AsString + #13#10 +
          qry.FieldByName('Country').AsString + #13#10 +
          'Phone: ' + qry.FieldByName('PhoneNumber').AsString + #13#10 + #13#10 +
          s;
//        if IsDebuggerPresent() or (Pos('dev\',Lowercase(GetCurrentModuleName)) > 0) then begin
//          SendTo := 'dev@trueerp.com';
//          s := '********** THIS IS A DEVELOPMENT TEST **********' + #13#10 + #13#10 + s;
//        end;

        SendEmail(SendTo,'True ERP Error Notification',s);

      end;
      AddInfoMsg('Finished checking deleted Stock Movements.');
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TDatafixObj.FixDeletedTranslines: Boolean;
var
  ctr:Integer;
const
  TablestoBackup :Array[1..8] of string = ('tblsales' , 'tblpurchaseorders' , 'tblsaleslines' , 'tblpurchaselines', 'tblPQA' , 'tblpqadetails' , 'tblProcTree' ,'tblproctreePArt');
begin
    result:= false;
    if connection = nil then begin
      AddErrmsg( 'Not enough paramteres for the Database Connection');
      exit;
    end;
    try
      for ctr := low(TablestoBackup) to high(TablestoBackup) do Backuptable(TablestoBackup[ctr] , '');
      DoProgressdialog('Fix Deleted Invoice Lines' );
      DeleteDeletedInvoicelines;
      DoProgressdialog('Fix Deleted SO Lines' );
      DeleteDeletedSOLines;
      DoProgressdialog('Fix Deleted PO Lines' );
      DeleteDeletedPOLines;
      AddInfoMsg('    Trans line Fix.. done');
      Result := true;
    except
      on E: Exception do begin
          AddErrmsg( e.Message);
      end;
    end;
end;

function TDatafixObj.FixInactivePQAs: Boolean;
var
  s: string;
  Procedure MakePQAActive(Transtype:String);
  var
    Query: TERPQuery;
  begin
    DoProgressdialog(Transtype +'FixInactivePQAs' );
    Query := NewQuery(s);
      try
        s := Query.groupconcat('PQAID');
        if s <> ''  then  begin
          AddInfomsg('    ' + Transtype +' PQAs Fixed:' + inttostr(Query.recordcount) );
          Result := ExecuteSQL('update tblPQa set Active = "T" where PQAID in (' + s + ') ;');
          if not Result then exit;
        end;
      finally
        if Query.Active then Query.close;
        Freeandnil(Query);
      end;
  end;
begin
  Result := False;
  try
    if connection = nil then begin
      AddErrmsg( 'Not enough paramteres for the Database Connection');
      exit;
    end;


    if not FixRequired('9.0.7.0') then begin
      AddInfomsg('FixInactivePQAs: Update not required');
      Result := True;
      exit;
    end;

    connection.StartTransaction;
    try
      Backuptable('tblPQA' , '9.0.7.0');
      { Purhase PQAs }

      s := 'Select PQA.PQAID from tblpurchaseorders  PO ' + ' inner join tblpurchaselines PL on PO.PurchaseOrderID = PL.PurchaseOrderID ' +
                    ' inner join tblPQA PQA on PL.PurchaseLineID = PQA.TransLineID and PL.PurchaseOrderID = PQA.TransID and PQA.TransType = "TPurchaseOrderLine" and PQA.ProductId = PL.ProductID ' +
                    ' where  ifnull(PO.boid,"") =""  and ifnull(PQA.Active,"T") = "F" ';
      MakePQAActive('Purchase');
      { Invoice PQAs}
      s := 'Select PQA.PQAID  from tblsales  S ' + ' inner join tblsalesLines SL on S.SaleID = Sl.SaleID ' +
                  ' inner join tblPQA PQA on Sl.SAleLineID = PQA.TransLineID and Sl.SaleID= PQA.TransID and PQA.TransType = "TInvoiceLine"  and PQA.ProductId = SL.ProductID ' +
                  ' where  ifnull(S.boid,"") =""  and ifnull(PQA.Active,"T") = "F"';
      MakePQAActive('Invoice');
      { SalesOrder }
      s := 'Select PQA.PQAID from tblsales  S ' + ' inner join tblsalesLines SL on S.SaleID = Sl.SaleID ' +
                  ' inner join tblPQA PQA on Sl.SAleLineID = PQA.TransLineID and Sl.SaleID= PQA.TransID and PQA.TransType = "TSalesOrderLine"  and PQA.ProductId = SL.ProductID ' +
                  ' where  ifnull(S.boid,"") ="" and ifnull(PQA.Active,"T") = "F" and S.converted = "F"';
      MakePQAActive('Sales Order');
      connection.Commit;
      REsult := True;
    Except
      on E: Exception do begin
        Connection.Rollback;
        Result := false;
        AddErrmsg( e.Message);
      end;
    end;
    Result := True;
    AddInfoMsg('    PQA fix.. done');
  except
    on E: Exception do begin
        AddErrmsg( e.Message);
    end;
  end;
end;

function TDatafixObj.NewQuery(SQL: string): TERPQuery;
begin
  Result := TERPQuery.Create(nil);
  Result.Options.FlatBuffers := True;
  Result.Connection := Connection;
  if SQL <> '' then begin
    Result.SQL.add(SQL);
    Result.Open;
  end;
end;

function TDatafixObj.PPGCheknFix: Boolean;
var
  s:String;
  Qry:TERPQuery;
begin
  if not HasPPG then begin
    AddInfoMsg('    No PPG Transaction found for :' + Connection.database);
    Result := True;
    exit;
  end;
  if not TableExists(connection, 'tblPPGCheknFix') then begin
    ExecuteSQL('CREATE TABLE tblPPGCheknFix ( '+
               ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
               ' PPGCheknFixTablenamePrefix VARCHAR(255) NULL DEFAULT NULL, '+
               ' FixDatetime DATETIME NULL DEFAULT NULL, '+
               ' PRIMARY KEY (ID) ) ENGINE=MyISAM ; ');
    AddInfoMsg('      tblPPGCheknFix Created');
  end;
  Qry := NewQuery('Select * from tblPPGCheknFix order by ID desc limit 1');
  try
    if Qry.RecordCount =0 then begin
      Qry.Append;
      Qry.fieldbyname('PPGCheknFixTablenamePrefix').AsString := replacestr(TABLE_VERSION , '.','');
      Qry.fieldbyname('FixDatetime').AsDateTime := now;
      Qry.Post;
      AddInfoMsg('      tblPPGCheknFix New Record Created : ' + Qry.fieldbyname('PPGCheknFixTablenamePrefix').AsString );
    end;
    s:=Qry.fieldbyname('PPGCheknFixTablenamePrefix').AsString ;
    AddInfoMsg('      Fix table prefix : ' + s);

    if TableStructureMatch(connection, 'erpfix_tblprocprogress_'+s , 'tblprocprogress') and
       TableStructureMatch(connection, 'erpfix_tblpqa_'         +s , 'tblpqa'         ) and
       TableStructureMatch(connection, 'erpfix_tblpqadetails_'  +s , 'tblpqadetails'  ) then else begin
       s:= replacestr(TABLE_VERSION , '.','');
       if Qry.fieldbyname('PPGCheknFixTablenamePrefix').AsString <> s then begin
         Qry.Append;
         Qry.fieldbyname('PPGCheknFixTablenamePrefix').AsString := s;
         Qry.fieldbyname('FixDatetime').AsDateTime := now;
         Qry.Post;
         AddInfoMsg('      tblPPGCheknFix New Record Created : ' + Qry.fieldbyname('PPGCheknFixTablenamePrefix').AsString );
       end;
    end;
  finally
    Freeandnil(Qry);
  end;
  AddInfoMsg('      Fix table prefix : ' + s);

  s:=(* ' Drop table if exists erpfix_tblprocprogress_2018421; ' +chr(10)+chr(13)+*)
      ' create table if not Exists erpfix_tblprocprogress_'+ s +' like tblprocprogress; ' +chr(10)+chr(13)+
      ' insert ignore into erpfix_tblprocprogress_'+ s +' select * from  tblprocprogress ; ' +chr(10)+chr(13)+

      (*' Drop table if exists erpfix_tblpqa_'+ s +'; ' +chr(10)+chr(13)+*)
      ' create table if not Exists erpfix_tblpqa_'+ s +' like tblpqa; ' +chr(10)+chr(13)+
      ' insert ignore into erpfix_tblpqa_'+ s +' select * from  tblpqa ; ' +chr(10)+chr(13)+

      (*' Drop table if exists erpfix_tblpqadetails_'+ s +'; ' +chr(10)+chr(13)+*)
      ' create table if not Exists erpfix_tblpqadetails_'+ s +' like tblpqadetails; ' +chr(10)+chr(13)+
      ' insert ignore into erpfix_tblpqadetails_'+ s +' select * from  tblpqadetails ; ' +chr(10)+chr(13)+

      ' drop table if exists tmp_1; ' +chr(10)+chr(13)+
      ' create table tmp_1 ' +
      ' Select ' +
      ' s.saleId, ' +
      ' ppg.employeeId  , ptc.proctreeId, ptpc.ProcTreePartId , ptpc.ProductId , s.ClassID , DATE_ADD(ppg.Progressdate,INTERVAL -1 second) as progressdate , ' +
      ' 1 as qty , 1 as UOMQty , ptpc.UnitOfMeasure as uom , ptpc.UnitOfMeasureId UOMID, ptpc.UnitOfMeasureMultiplier UOMMultiplier, "OUT" as Alloctype ,  ' +
      ' ppg.BuildStatus, "T" as Active, ppg.ProcProgressID as inProcProgressID , p.AvgCost as productunitcost , pqad.value as Serialnumber ' +
      ' from tblsales s ' +
      ' inner join tblsaleslines sl on s.saleId = sl.saleId ' +
      ' inner join tblproctree pt on pt.MasterId = sl.saleLineId and pt.mastertype <> "mtProduct"    inner join tblparts p on pt.partsId = p.partsId and p.SNTracking ="T" ' +
      ' inner join tblproctree ptc on pt.ProcTreeId = ptc.ParentId   ' +
      ' inner join tblparts pc on ptc.partsId = pc.partsId and pc.SNTracking ="T"  ' +
      ' inner join tblproctreepart ptpc on ptc.proctreeid = ptpc.proctreeid ' +
      ' inner join tblproctreepart ptp on pt.ProcTreeId = ptp.ProcTreeId ' +
      ' inner join tblprocprogress ppg on ppg.ProcTreePartID = ptp.ProcTreePartId  ' +
      ' inner join tblpqa pqa on pqa.translineId = ppg.ProcProgressID and pqa.transtype in ("TProcProgressIn")  ' +
      ' inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid ' +
      ' left join (tblprocprogress ppgin inner join tblpqa pqain on pqain.translineId = ppgin.ProcProgressID and pqain.transtype in ("TProcProgressOUT") ' +
      '               inner join tblpqadetails pqadin on pqain.pqaid = pqadin.pqaid) on ppgin.inProcProgressID = ppg.ProcProgressID ' +
      ' where ifnull(pqadin.PQADetailID ,0)=0 ' +
      ' order by ppg.Progressdate; ' +chr(10)+chr(13)+

      ' drop table if exists tmp_2; ' +chr(10)+chr(13)+
      ' create table tmp_2 Select max(ProcProgressID)+1 as fromProcProgressID ,  max(ProcProgressID)+1 as toProcProgressID  from tblprocprogress; ' +chr(10)+chr(13)+

      ' insert ignore into tblprocprogress (EmployeeId , ProctreeId , proctreePartId ,ProductID , classId, Progressdate , qty, uomqty ,  ' +
      ' uom,UOMId, UOMMultiplier , alloctype, buildstatus , active , InProcProgressId  , ProductUnitCost) ' +
      ' select EmployeeId , ProctreeId , proctreePartId ,ProductID , classId, Progressdate , qty,  ' +
      ' uomqty , uom,UOMId, UOMMultiplier , alloctype, buildstatus , active , InProcProgressId  , ProductUnitCost from tmp_1; ' +chr(10)+chr(13)+

      ' update tmp_2  Set toProcProgressID = (Select max(ProcProgressID) from tblprocprogress); ' +chr(10)+chr(13)+
      ' select * from tmp_2  ; ' +chr(10)+chr(13)+
      ' Alter table tmp_1 add column ProcProgressID int(11); ' +chr(10)+chr(13)+
      ' update tmp_1 T inner join  tblprocprogress ppg on ' +
      ' T.EmployeeId  = ppg.EmployeeId  and ' +
      ' T.ProctreeId = ppg.ProctreeId  and ' +
      ' T.proctreePartId = ppg.proctreePartId  and ' +
      ' T.ProductID  = ppg.ProductID  and ' +
      ' T.classId  = ppg.classId and ' +
      ' T.Progressdate   = ppg.Progressdate  and ' +
      ' T.qty   =  ppg.qty  and ' +
      ' T.uomqty  = ppg.uomqty  and ' +
      ' T.uom   = ppg.uom and ' +
      ' T.UOMId   = ppg.UOMId and ' +
      ' T.UOMMultiplier  = ppg.UOMMultiplier  and ' +
      ' T.alloctype  = ppg.alloctype and ' +
      ' T.buildstatus  = ppg.buildstatus  and ' +
      ' T.active  = ppg.active  and ' +
      ' T.InProcProgressId  = ppg.InProcProgressId   and ' +
      ' T.ProductUnitCost = ppg.ProductUnitCost ' +
      ' Set T.ProcProgressID = ppg.ProcProgressID ' +
      ' where ppg.ProcProgressID between (Select fromProcProgressID from tmp_2) and (Select toProcProgressID from tmp_2) ; ' +chr(10)+chr(13)+

      ' Drop table if exists erpfix_procprogress; ' +chr(10)+chr(13)+
      ' create table erpfix_procprogress select * from tmp_2; ' +chr(10)+chr(13)+

      ' drop table if exists tmp_2; ' +chr(10)+chr(13)+
      ' create table tmp_2 Select max(pqaid)+1 as frompqaid ,  max(pqaid)+1 as topqaid  from tblpqa; ' +chr(10)+chr(13)+

      ' insert ignore into tblpqa (TransLineID , transtype , transdate, alloctype, isbo , qty, uomqty, uom, UOMMultiplier, uomid, departmentId, productId, Active , transID) ' +
      ' Select ProcProgressID as TransLineID , "TProcProgressOUT" as transtype ,Progressdate as  transdate, "OUT" alloctype, "F" as isbo , ' +
      ' qty, uomqty, uom, UOMMultiplier, uomid, classId as departmentId, productId, "T" Active , SaleId transID from tmp_1; ' +chr(10)+chr(13)+

      ' update tmp_2  Set topqaid = (Select max(pqaid) from tblpqa); ' +chr(10)+chr(13)+

      ' Alter table tmp_1 add column pqaid int(11); ' +chr(10)+chr(13)+

      ' update tmp_1 T inner join  tblpqa pqa on ' +
      ' T.ProcProgressID = pqa.TransLineID  and ' +
      ' pqa.transtype = "TProcProgressOUT"  and ' +
      ' T.Progressdate =  pqa.transdate and ' +
      ' pqa.alloctype = "OUT"  and ' +
      ' pqa.isbo  =  "F"  and ' +
      ' T.qty = pqa.Qty and ' +
      ' T.uomqty = pqa.uomqty and ' +
      ' T.uom = pqa.uom and ' +
      ' T.UOMMultiplier = pqa.UOMMultiplier and ' +
      ' T.uomid = pqa.uomid and ' +
      ' T.classId = pqa.departmentId and ' +
      ' T.productId = pqa.productId and ' +
      ' pqa.Active = "T"  and ' +
      ' T.SaleId = pqa.transID ' +
      ' set T.pqaid = pqa.pqaid ' +
      ' where pqa.pqaid between (Select frompqaid from tmp_2) and (Select topqaid from tmp_2) ; ' +chr(10)+chr(13)+

      ' insert ignore into tblpqadetails (pqaid, qty, uomqty, pqatype, Value, Active ) ' +
      ' Select  pqaid, qty, uomqty, "SN" as pqatype, Serialnumber as Value, "T" as Active  from tmp_1; ' +chr(10)+chr(13)+

      ' Drop table if exists erpfix_Srialswithissue; ' +chr(10)+chr(13)+
      ' create table erpfix_Srialswithissue select * from tmp_1; ' +chr(10)+chr(13)+

      ' Drop table if exists erpfix_pqas; ' +chr(10)+chr(13)+
      ' create table erpfix_pqas select * from tmp_2; ' +chr(10)+chr(13)+

      ' drop table if exists tmp_1; ' +chr(10)+chr(13)+
      ' drop table if exists tmp_2; ' ;
     try
      AddInfoMsg(s);
      AddInfoMsg('    PPG Transactions Checking :' + Connection.database);
      ExecuteSQL(S);
      AddInfoMsg('    PPG Transactions Checked - Done');
      Result := True;
     Except
      on E:Exception do begin
        AddErrMsg('    Eror in PPG Transactions Checking :' + Connection.database+ chr(10)+chr(13)+ E.Message);
        Result := False;
      end;
     end;
end;

function TDatafixObj.FixRequired(fixedVersiono:String):boolean;
begin
  REsult := true;

  if fixedVersiono = '' then begin
    Result := TRue;
    exit;
  end;

  with NewQuery('select * from tblupdateDetails') do try
      if VersionComp(fieldbyname('version').asString ,fixedVersiono)>=0 then begin
        Result :=  False;
//        AddInfomsg('This update is required for versions prior to 9.0.7.0.  ' + Connection.Server+'.' +Connection.Database+'(Version = ' +fieldbyname('version').asString+') - does not require this update');
      end;
    finally
      ClosenFree;
    end;
end;

//function TDatafixObj.FixReturns: Boolean;
//var
//  SQL:String;
//begin
//   Result := False;
//  try
//    if connection = nil then begin
//      AddErrmsg( 'Not enough paramteres for the Database Connection');
//      exit;
//    end;
//
//
//    with NewQuery('select * from tblupdateDetails') do try
//      if VersionComp(fieldbyname('version').asString ,' 9.2.2.0')<=0 then begin
//        Result :=  False;
//        AddInfomsg('This update is required for versions after  9.2.2.0 ' + Connection.Server+'.' +Connection.Database+'(Version = ' +fieldbyname('version').asString+') - does not require this update');
//        Exit;
//      end;
//    finally
//      ClosenFree;
//    end;
//
//    with NewQuery('select (select count( * ) from tblbasreportlines)  + (select count( * ) from tblnzreportlines) + (select count( * ) from tblvatreportlines) Ctr ') do try
//      if Fieldbyname('ctr').asInteger>0 then begin
//        Result :=  False;
//        AddInfomsg('This update is already done');
//        Exit;
//      end;
//    finally
//      ClosenFree;
//    end;
//
//    SQL:=   'Drop function if exists MonthNo; ' +
//            ' delimiter //; ' +
//            ' CREATE FUNCTION `MonthNo`(`sMonth` TEXT) ' +
//            ' 	RETURNS INT ' +
//            ' BEGIN ' +
//            ' if upper(sMonth) = "JANUARY" then  return 1; ' +
//            ' elseif upper(sMonth) = "FEBRUARY" then  return 2; ' +
//            ' elseif upper(sMonth) = "MARCH" then  return 3; ' +
//            ' elseif upper(sMonth) = "APRIL" then  return 4; ' +
//            ' elseif upper(sMonth) = "MAY" then  return 5; ' +
//            ' elseif upper(sMonth) = "JUNE" then  return 6; ' +
//            ' elseif upper(sMonth) = "JULY" then  return 7; ' +
//            ' elseif upper(sMonth) = "AUGUST" then  return 8; ' +
//            ' elseif upper(sMonth) = "SEPTEMBER" then  return 9; ' +
//            ' elseif upper(sMonth) = "OCTOBER" then  return 10; ' +
//            ' elseif upper(sMonth) = "NOVEMBER" then  return 1; ' +
//            ' elseif upper(sMonth) = "DECEMBER" then  return 12; ' +
//            ' end if; ' +
//            ' END;// ' +
//            ' delimiter ; ' ;
//    ExecuteSQL(SQL);
//    SQL := 'Drop function if exists CStoQuotedCS; ' +
//              ' delimiter //; ' +
//              ' CREATE FUNCTION `CStoQuotedCS`(`Data` text) 	RETURNS text ' +
//              ' BEGIN ' +
//              ' if ifnull(Data , "") = "" then return ""; ' +
//              ' else   return concat(''"'' , replace(data,'','' , ''","''),''"''); ' +
//              ' end if; ' +
//              ' END;// ' +
//              ' delimiter ; ' ;
//    ExecuteSQL(SQL);
//
//    connection.StartTransaction;
//    try
//      {Account - tab 1}
//      SQL:= 'Select ' +
//            ' CStoQuotedCS(w1selected) w1selected ,CStoQuotedCS(w2selected) w2selected ,CStoQuotedCS(w3selected) w3selected , ' +
//            ' convert(concat(BAS.Tab2_Year , "/" ,  monthno(BAS.Tab2_Month) ,  "/01") , datetime) DAteFrom, ' +
//            ' DATE_ADD(convert(concat(BAS.Tab2_Year , "/" ,  monthno(BAS.Tab2_Month) ,  "/01") , datetime),INTERVAL if(BAS.Tab2_Type = "Quarterly" , 3  ,1 ) MONTH) DateTo ' +
//            ' from tblbasreports BAS ' ;
//       with NewQuery(SQL) do try
//            if recordcount>0 then begin
//              first;
//              while Eof = False do begin
//                SQL:= '';
//                if fieldbyname('w1selected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "W1"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (T.AccountName in (' + fieldByname('w1selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('w2selected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "W2"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (T.AccountName in (' + fieldByname('w2selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('W3selected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "W3"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (T.AccountName in (' + fieldByname('W3selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('W4selected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "W4"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (T.AccountName in (' + fieldByname('W4selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if SQL<> '' then ExecuteSQL(SQL);
//                Next;
//              end;
//            end;
//       finally
//         ClosenFree;
//       end;
//       {Account - tab 3}
//       SQL:= 'Select ' +
//            ' CStoQuotedCS(T1selected) T1selected , ' +
//            ' convert(concat(BAS.Tab3_Year , "/" ,  monthno(BAS.Tab3_Month) ,  "/01") , datetime) DAteFrom, ' +
//            ' DATE_ADD(convert(concat(BAS.Tab3_Year , "/" ,  monthno(BAS.Tab3_Month) ,  "/01") , datetime),INTERVAL if(BAS.Tab3_Type = "Quarterly" , 3  ,1 ) MONTH) DateTo ' +
//            ' from tblbasreports BAS ' +
//            ' where ifnull(T1selected , "")<> ""';
//       with NewQuery(SQL) do try
//            if recordcount>0 then begin
//              first;
//              while Eof = False do begin
//                SQL:= '';
//                if fieldbyname('T1selected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "T1"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (T.AccountName in (' + fieldByname('T1selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//
//                if SQL<> '' then ExecuteSQL(SQL);
//                Next;
//              end;
//            end;
//       finally
//         ClosenFree;
//       end;
//
//       {Tax - tab 1}
//       sql:= 'Select' +
//            ' CStoQuotedCS(G1selected) G1selected ,' +
//            ' CStoQuotedCS(G2selected) G2selected ,' +
//            ' CStoQuotedCS(G3selected) G3selected ,' +
//            ' CStoQuotedCS(G4selected) G4selected ,' +
//            ' CStoQuotedCS(G7selected) G7selected ,' +
//            ' CStoQuotedCS(G10selected) G10selected ,' +
//            ' CStoQuotedCS(G11selected) G11selected ,' +
//            ' CStoQuotedCS(G13selected) G13selected ,' +
//            ' CStoQuotedCS(G14selected) G14selected ,' +
//            ' CStoQuotedCS(G15selected) G15selected ,' +
//            ' CStoQuotedCS(G18selected) G18selected ,' +
//            ' convert(concat(BAS.Tab1_Year , "/" ,  monthno(BAS.Tab1_Month) ,  "/01") , datetime) DAteFrom,' +
//            ' DATE_ADD(convert(concat(BAS.Tab1_Year , "/" ,  monthno(BAS.Tab1_Month) ,  "/01") , datetime),INTERVAL if(BAS.Tab1_Type = "Quarterly" , 3  ,1 ) MONTH) DateTo' +
//            ' from tblbasreports BAS';
//       with NewQuery(SQL) do try
//            if recordcount>0 then begin
//              first;
//              while Eof = False do begin
//                SQL:= '';
//                if fieldbyname('G1selected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G1"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G1selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G2selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G2"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G2selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G3selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G3"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G3selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//
//                if fieldbyname('G4selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G4"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G4selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//
//                if fieldbyname('G7selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G7"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G7selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G10selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G10"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G10selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G11selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G11"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G11selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G13selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G13"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G13selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G14selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G14"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G14selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G15selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G15"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G15selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('G18selected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "G18"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('G18selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if SQL<> '' then ExecuteSQL(SQL);
//                Next;
//              end;
//            end;
//       finally
//         ClosenFree;
//       end;
//
//       {Tax - tab 3}
//       sql:= 'Select' +
//            ' CStoQuotedCS(_1Cselected) _1Cselected ,' +
//            ' CStoQuotedCS(_1Eselected) _1Eselected ,' +
//            ' CStoQuotedCS(_1Dselected) _1Dselected ,' +
//            ' CStoQuotedCS(_1Fselected) _1Fselected ,' +
//            ' CStoQuotedCS(_1Gselected) _1Gselected ,' +
//            ' convert(concat(BAS.Tab3_Year , "/" ,  monthno(BAS.Tab3_Month) ,  "/01") , datetime) DAteFrom,' +
//            ' DATE_ADD(convert(concat(BAS.Tab3_Year , "/" ,  monthno(BAS.Tab3_Month) ,  "/01") , datetime),INTERVAL if(BAS.Tab3_Type = "Quarterly" , 3  ,1 ) MONTH) DateTo' +
//            ' from tblbasreports BAS';
//       with NewQuery(SQL) do try
//            if recordcount>0 then begin
//              first;
//              while Eof = False do begin
//                SQL:= '';
//                if fieldbyname('_1Cselected').asString <> '' then
//                  SQL := 'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "_1C"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('_1Cselected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('_1Eselected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "_1E"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('_1Eselected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('_1Dselected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "_1D"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('_1Dselected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//
//                if fieldbyname('_1Fselected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "_1F"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('_1Fselected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//
//                if fieldbyname('_1Gselected').asString <> '' then
//                  SQL := SQL +'insert into tblbasreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "_1G"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('_1Gselected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if SQL<> '' then ExecuteSQL(SQL);
//                Next;
//              end;
//            end;
//       finally
//         ClosenFree;
//       end;
//
//       {NZ Tax - tab 4}
//       sql:= 'Select' +
//            ' CStoQuotedCS(NZG5selected) NZG5selected ,' +
//            ' CStoQuotedCS(NZG6selected) NZG6selected ,' +
//            ' CStoQuotedCS(NZG11selected) NZG11selected ,' +
//            ' convert(concat(BAS.Tab4_Year , "/" ,  monthno(BAS.Tab4_Month) ,  "/01") , datetime) DAteFrom,' +
//            ' DATE_ADD(convert(concat(BAS.Tab4_Year , "/" ,  monthno(BAS.Tab4_Month) ,  "/01") , datetime),INTERVAL if(BAS.Tab4_Type = "Quarterly" , 3  ,1 ) MONTH) DateTo' +
//            ' from tblnzreturns BAS';
//       with NewQuery(SQL) do try
//            if recordcount>0 then begin
//              first;
//              while Eof = False do begin
//                SQL:= '';
//                if fieldbyname('NZG5selected').asString <> '' then
//                  SQL := 'insert into tblnzreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "NZG5"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('NZG5selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('NZG6selected').asString <> '' then
//                  SQL := SQL +'insert into tblnzreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "NZG6"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('NZG6selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if fieldbyname('NZG11selected').asString <> '' then
//                  SQL := SQL +'insert into tblnzreportlines (TransGlobalref , Transtype , TransSeqno , Amount, BasCode) ' +
//                        ' SELECT T.Globalref,  T.`Type` , T.SeqNo ,Sum(CreditsInc-DebitsInc)   as AmountInc , "NZG11"' +
//                        ' FROM tbltransactions T ' +
//                        ' WHERE (TaxCode in  in (' + fieldByname('NZG11selected').asString+ ' )) ' +
//                        ' AND Date Between ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('DateFrom').asDatetime)) +' AND ' +Quotedstr(FormatDateTime('yyyy-mm-dd' , FieldByname('Dateto').asDatetime))+' ' +
//                        ' group by Globalref,  `Type` , SeqNo;';
//                if SQL<> '' then ExecuteSQL(SQL);
//                Next;
//              end;
//            end;
//       finally
//         ClosenFree;
//       end;
//
//
//
//
//      connection.Commit;
//      REsult := True;
//    Except
//      on E: Exception do begin
//        Connection.Rollback;
//        Result := false;
//        AddErrmsg( e.Message);
//      end;
//    end;
//    Result := True;
//    AddInfoMsg('Returns Fix ... done');
//  except
//    on E: Exception do begin
//        AddErrmsg( e.Message);
//    end;
//  end;
//end;

function TDatafixObj.fields(Tablename1, tablename2:String):String;
var
  Qr1, qr2:TERPQuery;
begin
  Result := '';
  if (TableName1 = '') or (Tablename2='') then exit;
  Qr1:= Newquery('Desc ' +tablename1);
  Qr2:= Newquery('Desc ' +tablename2);
  Qr1.first;
  Result := '';
  while Qr1.Eof = False do begin
    if Qr2.Locate(Qr1.fields[0].Fieldname , Qr1.fields[0].asString , [loCaseInsensitive]) then begin
      if result <> '' then result := result +',';
      REsult := Result +Qr1.fields[0].asString;
    end;
    Qr1.Next;
  end;
end;
procedure TDatafixObj.AddErrMsg(const Value: String);
begin
  if errmsg <> '' then errmsg := errmsg + #13#10;
  errmsg :=errmsg + Value;
end;
procedure TDatafixObj.AddInfomsg(const Value: String);
begin
  if InfoMsg <> '' then InfoMsg := InfoMsg + #13#10;
  InfoMsg :=InfoMsg + Value;
end;

procedure TDatafixObj.Backuptable(TableName, versionNo: String);
var
  qryTemp: TERPQuery;
  sCreate:String;
  NewTablename :String;
  SQL:String;
  sfields:String;
begin
  if TableName= '' then Exit;
  DoProgressdialog('Backing up ' + tablename );
  SQL:= '';
  qryTemp := Newquery;
  try
    qryTemp.Sql.Add('SHOW TABLES LIKE ' + QuotedStr(TableName));
    qryTemp.Open;
    if qryTemp.IsEmpty then exit;

    NewTablename := 'Erpfix_' + tablename + replacestr(Versionno,'.', '');
    qryTemp.Close;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SHOW TABLES LIKE ' + QuotedStr(NewTablename));
    qryTemp.Open;
    if qryTemp.IsEmpty then begin
      QryTemp.close;
      Qrytemp.SQL.clear;
      qryTemp.Sql.Add('SHOW Create TABLE  ' + TableName);
      qryTemp.Open;
      if qryTemp.IsEmpty then exit;
      sCreate:= qryTemp.fields[1].asString;
      SQL := sCreate;
      SQL := ReplaceStr(uppercase(SQL), '`' + Trim(uppercase(Tablename))+'`','`'+uppercase(NewTablename)+'`' );
      SQL := ReplaceStr(uppercase(SQL), Trim(uppercase(Tablename))+' ' , '`'+uppercase(NewTablename)+'` ' );
      SQL := SQL+';';
      sfields:= '*';
    end else
      sfields :=fields(Newtablename , Tablename);

    SQL:= SQL +' insert ignore into ' +NewTablename ;
    if sfields <> '*' then SQL:= SQL + ' (' +sfields +') ';
    SQL:= SQL +' Select ' +sfields +' from ' +TableName +';';
    ExecuteSQL(SQL);

  finally
    FreeAndNil(qryTemp);
  end;
end;
function TDatafixObj.ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  Result := StringReplace(sString, sOldStr, sNewStr,[rfReplaceAll,rfIgnoreCase]);
end;

constructor TDatafixObj.Create(AOwner: TComponent);
begin
  inherited;
  fConnection   := nil;
  fsErrmsg      := '';
  fsinfoMsg     := '';
  fsServername  := '';
  fsdatabasename:= '';
  fProgressdialog := nil;
end;

procedure TDatafixObj.DeleteDeletedInvoiceLines;
var
  TransLineIDs:String;
  PQAIDs:sTring;
  SQL:String;
begin
  connection.StartTransaction;
  try
    SQL:= '';
    TRy
        ExecuteSQL('Drop table if exists tmp_1; ' +
                ' create table tmp_1 Select Sl.SaleId, SaleLineID  ' +
                ' from  tblsaleslines SL  ' +
                ' inner join tblSales S on S.SaleId = Sl.SaleId   ' +
                ' where Sl.deleted = "T" and S.IsInvoice ="T";');

        With NewQuery('Select SaleLineId from tmp_1') do try
          TransLineIDs:= GroupConcat('SaleLineId');
        finally closenFree; end;

        if TransLineIDs <> '' then begin
          With NewQuery('Select PQAID from tblPQa PQA  ' +
                ' inner join tmp_1 T on PQA.TransId = T.SaleId and PQA.TransLineId = t.SaleLineID  ' +
                ' and PQA.transtype =' +Quotedstr('TInvoiceLine')) do try
            PQAIDs:= GroupConcat('PQAID');
          finally closenFree; end;


          if PQAIDs <> '' then
            SQL := SQL +'Delete from tblPQaDetails where PQAId in (' +PQAIDs+');'+
                        'Delete from tblPQa where PQAId in (' +PQAIDs+');';
          SQL:= SQL +'Delete from tblSaleslines where SaleLineID in (' +TransLineIDs+') and ifnull(Deleted,"F") ="T";';
        end;
        SQL:= SQL +'Drop table if exists tmp_1; ';
        SQL:= SQL+'update tblsales Set Deleted = "T" where SaleID not in (select saleId from tblsaleslines);';
    Finally
      if SQL<> '' then ExecuteSQL(SQL);
    End;
    Connection.Commit;
    AddInfoMsg('    Deleted Invoice Lines are Deleted');
  Except
    on E:EXception do begin
      Connection.Rollback;
      AddErrMsg(e.Message);
    end;
  end;
end;

procedure TDatafixObj.DeleteDeletedPOLines;
var
  TransLineIDs:String;
  PQAIDs:sTring;
  SQL:String;
begin
  connection.StartTransaction;
  try
    SQL:= '';
    TRy
        ExecuteSQL('Drop table if exists tmp_1; ' +
                ' create table tmp_1 Select  PL.purchaseOrderId , PL.PurchaseLineID from tblpurchaselines PL inner join tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID where PO.IsPO = "T" and PL.Deleted = "T";');

        With NewQuery('Select PurchaseLineID from tmp_1') do try
          TransLineIDs:= GroupConcat('PurchaseLineID');
        finally closenFree; end;

        if TransLineIDs <> '' then begin
          With NewQuery('Select PQAID from tblPQa PQA  ' +
                ' inner join tmp_1 T on PQA.TransId = T.purchaseOrderId and PQA.TransLineId = t.PurchaseLineID  ' +
                ' and PQA.transtype =' +Quotedstr('TPurchaseOrderLine')) do try
            PQAIDs:= GroupConcat('PQAID');
          finally closenFree; end;


          if PQAIDs <> '' then
            SQL := SQL +'Delete from tblPQaDetails where PQAId in (' +PQAIDs+');'+
                        'Delete from tblPQa where PQAId in (' +PQAIDs+');';
          SQL:= SQL +'Delete from tblpurchaselines where PurchaseLineID in (' +TransLineIDs+') and ifnull(Deleted,"F") ="T";';
        end;
        SQL:= SQL +'Drop table if exists tmp_1; ';
        SQL:= SQL+'update tblpurchaseorders Set Deleted = "T" where PurchaseOrderID not in (select PurchaseOrderId from tblpurchaselines);';
    Finally
      if SQL<> '' then ExecuteSQL(SQL);
    End;
    Connection.Commit;
    AddInfoMsg('    Deleted Invoice Lines are Deleted');
  Except
    on E:EXception do begin
      Connection.Rollback;
      AddErrMsg(e.Message);
    end;
  end;
end;

procedure TDatafixObj.DeleteDeletedSOLines;
var
  TransLineIDs:String;
  PQAIDs:String;
  PTPQAIDs: String;
  PTProcTreePartIds: String;
  PTIds : String;
  SQL:String;
begin
  connection.StartTransaction;
  try
    SQL:= '';
    try
        ExecuteSQL('Drop table if exists tmp_1; ' +
                ' create table tmp_1 Select Sl.SaleId, SaleLineID  ' +
                ' from  tblsaleslines SL  ' +
                ' inner join tblSales S on S.SaleId = Sl.SaleId   ' +
                ' where Sl.deleted = "T" and S.IsSaleSOrder ="T";');

        With NewQuery('Select SaleLineId from tmp_1') do try
          TransLineIDs:= GroupConcat('SaleLineId');
        finally
          closenFree;
        end;
        if TransLineIDs <> '' then begin
          With NewQuery('Select PQAID from tblPQa PQA  ' +
                ' inner join tmp_1 T on PQA.TransId = T.SaleId and PQA.TransLineId = t.SaleLineID  and PQA.transtype =' +Quotedstr('TSalesOrderLine')) do try
            PQAIDs:= GroupConcat('PQAID');
          finally
            closenFree;
          end;
          With NewQuery('Select PT.ProctreeId, PTP.ProcTreePartId , PQa.PQAID '   +
                      ' from tblProcTree	PT	  '   +
                      ' Left join tblproctreePArt PTP on PT.proctreeId = PTP.proctreeId  '   +
                      ' Left join tblPQa PQA on PTP.ProcTreePartId = PQA.TransLineID and pqa.Active = "T" and  '   +
                      ' ( PQA.Transtype ="TprocTreePart"  or PQA.Transtype ="TprocTreePartIN" ) '   +
                      ' Where PT.masterID  in (' + TransLineIDs +'	) and 	PT.Mastertype <> "mtProduct"') do try
            PTPQAIDs:= GroupConcat('PQAID');
            PTProcTreePartIds := GroupConcat('ProcTreePartId');
            PTIds := GroupConcat('ProctreeId');
          finally
            ClosenFree;
          end;
          if PTPQAIDs<> '' then
              SQL := SQL +'Delete from tblPQaDetails where PQAId in (' +PTPQAIDs+');'+
                        'Delete from tblPQa where PQAId in (' +PTPQAIDs+');';
          if PQAIDs <> '' then
              SQL := SQL +'Delete from tblPQaDetails where PQAId in (' +PQAIDs+');'+
                        'Delete from tblPQa where PQAId in (' +PQAIDs+');';
          if PTProcTreePartIds <> '' then
            SQL := SQL +'Delete from tblproctreePArt where ProcTreePartId in (' +PTProcTreePartIds+');';
          if PTIds <> '' then
            SQL := SQL +'Delete from tblProcTree where ProctreeId in (' +PTIds+');';

          SQL:= SQL +'Delete from tblSaleslines where SaleLineID in (' +TransLineIDs+') and ifnull(Deleted,"F") ="T";';
        end;
        SQL:= SQL +'Drop table if exists tmp_1; ';
        SQL:= SQL+'update tblsales Set Deleted = "T" where SaleID not in (select saleId from tblsaleslines);';
    Finally
      if SQL<> '' then ExecuteSQL(SQL);
    End;
    Connection.Commit;
    AddInfoMsg('    Deleted SO Lines are Deleted');
  Except
    on E:EXception do begin
      Connection.Rollback;
      AddErrMsg(e.Message);
    end;
  end;
end;


destructor TDatafixObj.Destroy;
begin
  Freeandnil(fconnection);
  inherited;
end;

procedure TDatafixObj.DoProgressdialog(const Value: String);
function dbname:String;
begin
  REsult := '';
  if Assigned(fconnection) then
    Result := fconnection.Server +'.' +fconnection.Database+'->';
end;
begin
  if assigned(fProgressdialog) then fProgressdialog(dbname + Value);
end;

function TDatafixObj.ExecuteSQL(SQL: string): Boolean;
var
  Script: TERPScript;
begin
  Result := False;
  try
    Script := TERPScript.Create(nil);
    try
      Script.Connection := Connection;
      Script.SQL.add(SQL);
      Script.Execute;
      Result := True;
    finally
      Freeandnil(Script);
    end;
  except
    on E: Exception do begin
      AddErrmsg(E.Message);
    end;
  end;
end;

end.

