unit SyncReportTableObj;

{$I ERP.inc}

interface

uses ERPdbComponents, Classes, DAScript, MyScript, sysutils;

type
  TSQLtype = (stInsert = 1, stUpdate = 2);
  TStringProc = procedure(const Value: string) of object;

  TSyncReportTableObj = class(TComponent)
  private
    st: TStringList;
    ERPScript: TERPScript;
    ERPQuery: TERPQuery;
    fErrorLog: TStringProc;
    SyncingTable: string;
    MyConnection: TERPConnection;
    LstTables: TStringList;
    recno, reccount :Integer;

    function IsTableExists(const TableName: string): boolean;
    function Create_Table_SQL(var TableName: string; const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName: string = ''): string;
    function TablePrimarykey(const TableName: string): string;
    function NewQuery: TERPQuery;
    function NewScript: TERPScript;
    function IsFieldExists(const TableName, Fieldname: string): boolean;
    function create_Table_File_SQL(const TemplateTableName: string; const sSQL: string; const Fieldlist: string; var TableName: string; var tmpfilename: string; const TableNameSuffix: string = '';
      const EngineName: string = ''): string;
    function CopyfieldsSQL(Qry: TERPQuery): string;
    procedure Execute;
    function FieldNames(TableName: string): string;
    procedure MakeSQL(SQLtype: TSQLtype; TableName, sSQL, PrimaryKey: string);
    procedure AddSQL(const Value: string);
    procedure OnSQLError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure DeleteAllTables(Tablesuffix: string);
    procedure Autosync;
    function TableStructureSame(Tablename1, tablename2: string): boolean;
    function IsDevMode: Boolean;
    Procedure OnAfterExecuteScript(Sender: TObject; SQL: string);
//    procedure DoUpdateProductQtySum_SP(aProductID:Integer);
    procedure DoUpdateProductQtySum(aProductIDs:String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoMakeProductStockTable;
    procedure Dosync(TableName: string);
    procedure DosyncAll;
    procedure DosyncTables(Tablenames: string);
    property ErrorLog: TStringProc read fErrorLog write fErrorLog;
    procedure DeleteAllReportTables;
    function ChangeQuery(Query: string; var Changed: boolean): string;
    procedure DosyncSerialnumberlist;
    function DoUpdateProductQtySum_SQL(aProductIDs:String):String;

    (* Class Function ChangeQuery(Query:String):String; *)

  end;

var
  fSyncReportObj: TSyncReportTableObj;

function SyncReportObj: TSyncReportTableObj;

implementation

uses MySQLConst, {tcConst,} {Progressdialog,} db, Variants,
  {AppEnvironment, CommonDbLib, DNMLib,} forms,  JSONObject,
  AppEnvironmentVirtual, TempTableUtils, MySQLUtils, ProgressInfoObj, tcConst,
  ProductQtyLib,  PQALib, UtilsLib;

function SyncReportObj: TSyncReportTableObj;
begin
  if fSyncReportObj = nil then fSyncReportObj := TSyncReportTableObj.Create(Application);
  REsult := fSyncReportObj;
end;

procedure TSyncReportTableObj.Autosync;
begin
  with NewQuery do
    try
      SQL.add('show tables like "RPT_%"');
      Open;
      if recordcount < LstTables.count then begin
        DosyncAll;
      end;
    finally
      if active then close;
      Free;
    end;
end;

(* class function TSyncReportTableObj.ChangeQuery(Query: String): String;
  begin
  With TSyncReportTableObj.create(nil) do try
  Result := ChangeTables(Query);
  finally
  Free;
  end;
  end; *)

function TSyncReportTableObj.ChangeQuery(Query: string; var Changed: boolean): string;
var
  ctr: Integer;
  fstablename: string;
  cleanQuery: string;
const
  NL = #13#10;
begin
  cleanQuery := Query;
  for ctr := 0 to LstTables.count - 1 do begin
    fstablename := LstTables[ctr];
    Query := StringReplace(Query, '`' + fstablename + '`', '`rpt_' + fstablename + '`',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, ' ' + fstablename + ' ', ' `rpt_' + fstablename + '`',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, ' ' + fstablename + '.', ' `rpt_' + fstablename + '`.',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, '(' + fstablename + '.', ' (`rpt_' + fstablename + '`.',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, '(' + fstablename + ' ', ' (`rpt_' + fstablename + '` ',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, ',' + fstablename + '.', ' ,`rpt_' + fstablename + '`.',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, ',' + fstablename + ' ', ' ,`rpt_' + fstablename + '` ',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, '.' + fstablename + ' ', '.`rpt_' + fstablename + '` ',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, '=' + fstablename + '.', '=`rpt_' + fstablename + '`.',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, NL + fstablename + '.', NL + '`rpt_' + fstablename + '`.',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, NL + fstablename + ' ', NL + '`rpt_' + fstablename + '` ',[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, NL + fstablename + NL, NL + '`rpt_' + fstablename + '`' + NL,[rfReplaceAll, rfIgnoreCase]);
    Query := StringReplace(Query, ' ' + fstablename + NL, ' `rpt_' + fstablename + '`' + NL,[rfReplaceAll, rfIgnoreCase]);
  end;
  REsult := Query;
  Changed := cleanQuery <> Query;
end;

function TSyncReportTableObj.CopyfieldsSQL(Qry: TERPQuery): string;
var
  ctr: Integer;
begin
  REsult := '';
  for ctr := 0 to Qry.fieldcount - 1 do begin
    if REsult <> '' then REsult := REsult + ',';
         if Qry.Fields[ctr].Value = null then REsult := REsult + '`' + Qry.Fields[ctr].Fieldname + '` = NULL '
    else if (Qry.Fields[ctr].Datatype in [db.ftLargeint, db.ftInteger, db.ftSmallint]) then REsult := REsult + '`' + Qry.Fields[ctr].Fieldname + '` = ' + inttostr(Qry.Fields[ctr].asInteger)
    else if (Qry.Fields[ctr].Datatype in [db.ftFloat, db.ftCurrency]) then REsult := REsult + '`' + Qry.Fields[ctr].Fieldname + '` = ' + FloatToStr(Qry.Fields[ctr].asFloat)
    else if (Qry.Fields[ctr].Datatype in [db.ftDate, db.ftdatetime]) then
        REsult := REsult + '`' + Qry.Fields[ctr].Fieldname + '` = ' + Quotedstr(FormatDateTime(MysqlDateTimeFormat, Qry.Fields[ctr].AsDatetime))
    else REsult := REsult + '`' + Qry.Fields[ctr].Fieldname + '` =' + Quotedstr(EncodeString(Qry.Fields[ctr].asString));
  end;

end;

constructor TSyncReportTableObj.Create(AOwner: TComponent);
begin
  inherited;
  recno:= 0;
  reccount :=0;
  MyConnection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  st := TStringList.Create;
  ERPScript := NewScript;
  ERPQuery := NewQuery;
  ERPScript.OnError := OnSQLError;
  ERPScript.AfterExecute:=  OnAfterExecuteScript;

  LstTables := TStringList.Create;
  { not all tables need to be copied, but the selected tables }
  (* MyConnection.GetTableNames(LstTables);
    for ctr:= LstTables.count-1 downto 0 do
    if (Length(LstTables[ctr])<3) or (Pos('TBL' , uppercase(LstTables[ctr]))<> 1) then
    LstTables.delete(ctr); *)
  LstTables.add('tblsales');
  LstTables.add('tblsaleslines');
  LstTables.add('tblpqa');
  LstTables.add('tblpqadetails');
  LstTables.add('tblpurchaselines');
  LstTables.add('tblpurchaseorders');
  LstTables.add('tblbankdeposit');
  LstTables.add('tblbankdepositlines');
  LstTables.add('tblbankdepositlinessales');
  LstTables.add('tblprepayments');
  LstTables.add('tblwithdrawal');
  LstTables.add('tblwithdrawallines');
  LstTables.add('tbldepositline');
  LstTables.add('tbldeposits');
  LstTables.add('tblclients');
  LstTables.add('tblparts');
  LstTables.add('tblchartofaccounts');
  LstTables.add('tblpaymentmethods');
  LstTables.add('tblstockmovementlines');
  LstTables.add('tblproctreepart');
  LstTables.add('tblproctree');
  LstTables.add('tblProductClasses');
  LstTables.add('tblStockMovement');
  LstTables.add('tblrelatedsales');
  LstTables.add('tbltransactions');
  LstTables.add('tbltransactionsummarydetails');
  LstTables.add('tblclass');

  Autosync;
end;

function TSyncReportTableObj.TableStructureSame(Tablename1, tablename2: string): boolean;
var
  Qry1, qry2: TERPQuery;
  ctr: Integer;
  s1, s2: string;
begin
  Qry1 := NewQuery;
  qry2 := NewQuery;
  try
    Qry1.SQL.add('SHOW CREATE TABLE ' + Tablename1);
    Qry1.Open;
    s1 := StringReplace(Qry1.Fields[1].asString, Tablename1, '', [rfReplaceAll, rfIgnoreCase]);
    ctr := pos('AUTO_INCREMENT=', s1);
    if ctr > 0 then s1 := copy(s1, 1, ctr);

    qry2.SQL.add('SHOW CREATE TABLE  ' + tablename2);
    qry2.Open;
    s2 := StringReplace(qry2.Fields[1].asString, tablename2, '', [rfReplaceAll, rfIgnoreCase]);
    ctr := pos('AUTO_INCREMENT=', s2);
    if ctr > 0 then s2 := copy(s2, 1, ctr);

    REsult := SameTExt(s1, s2);
  finally
    if Qry1.active then Qry1.close;
    FreeandNil(Qry1);
    if qry2.active then qry2.close;
    FreeandNil(qry2);
  end;

end;

(*function TSyncReportTableObj.DevMode:Boolean;
begin
 {$IFDEF DevMode}
    Result := True;
 {$ELSE}
    Result := False;
 {$ENDIF}
end;*)
procedure TSyncReportTableObj.DoMakeProductStockTable;
begin

end;
procedure TSyncReportTableObj.Dosync(TableName: string);
var
  rptTabelname: string;
  PrimaryKey: string;
  s: string;
  rptTableExists: boolean;
  tmpfilename: string;
  Fieldlist: string;
begin
  if TableName = '' then exit;
  SyncingTable := TableName;
  rptTabelname := 'RPT_' + TableName;
  st.clear;
  if SameTExt(TableName, 'tbltransactions') then rptTableExists := False
  else rptTableExists := IsTableExists(rptTabelname);

  try
    if IsDevmode then  begin
      AddSQL('Drop table if exists ' + rptTabelname +  ';');
      AddSQL('Create table ' + rptTabelname +  ' like ' + tablename + ' ;');
      AddSQL('insert into ' + rptTabelname +  ' Select * from ' + tablename + ' ;');
    end else if (not(rptTableExists)) or (not(TableStructureSame(TableName, rptTabelname))) then begin
      AddSQL(Create_Table_SQL(rptTabelname, TableName, '', 'MyIsam') + ';');
      Fieldlist := FieldNames(TableName);
      AddSQL(create_Table_File_SQL('', 'Select ' + Fieldlist + ' from  ' + TableName, Fieldlist, rptTabelname, tmpfilename, '', 'MyIsam'));
    end else begin
      PrimaryKey := TablePrimarykey(TableName);
      if PrimaryKey <> '' then begin
        { insert }
        (* s := 'Select * from ' + TableName + ' where ' + PrimaryKey +
          ' not in (select ' + PrimaryKey + ' from  ' + rptTabelname + ')'; *)

        s := 'Select T.* from ' + TableName + ' T Left join ' + rptTabelname + ' R on T.' + PrimaryKey + '= R.' + PrimaryKey + ' where ifnull(R.' + PrimaryKey + ' , 0) =0';
        MakeSQL(stInsert, rptTabelname, s, '');

        { update }
        if IsFieldExists(TableName, 'mstimestamp') then begin
          s := 'Select M.* from ' + TableName + ' M inner join ' + rptTabelname + ' R on R.' + PrimaryKey + ' = M.' + PrimaryKey + ' where M.mstimeStamp > R.msTimeStamp';
          MakeSQL(stUpdate, rptTabelname, s, PrimaryKey);
        end;

        { Delete }
        AddSQL('Delete from ' + rptTabelname + ' where ' + PrimaryKey + ' not in (Select ' + PrimaryKey + ' from ' + TableName + ');');
      end;
    end;
    Execute;
  finally
    if not(rptTableExists) then AppEnvVirt.DeleteServerFiles(StringReplace(tmpfilename, '.tmp', '*.tmp', [rfReplaceAll, rfIgnoreCase]));
  end;
end;
Function TSyncReportTableObj.IsDEvmode :Boolean;
begin
  result := AppEnvVirt.Bool['CommonLib.DevMode'] ;
end;

//procedure TSyncReportTableObj.DoUpdateProductQtySum_SP(aProductID:Integer);
//begin
//      st.clear;
//      if IsDevMode then AddSQL( 'CALL ProductQtySumUpdate('+inttostr(aProductID)+',"T");')
//      else AddSQL( 'CALL ProductQtySumUpdate(0,"F");');
//      Execute;
//end;

procedure TSyncReportTableObj.DoUpdateProductQtySum(aProductIDs:string);
begin
  DoUpdateProductQtySum_SQL(aProductIDs);
  Execute;
end;
function TSyncReportTableObj.DoUpdateProductQtySum_SQL(aProductIDs:String):String;
begin
  st.clear;
  AddSQL('DROP TABLE if EXISTS tmp_tblProductQtySumQtys; ' );
  AddSQL('CREATE TABLE if not exists tmp_tblProductQtySumQtys ( '+
           ' ID int(11) NOT NULL AUTO_INCREMENT, '+
           ' productId int(11) null DEFAULT NULL, '+
           ' departmentId int(11) null DEFAULT NULL, '+
           ' uomId int(11) null DEFAULT NULL, '+
           ' SOBO Double null DEFAULT NULL, '+
           ' Available Double null DEFAULT NULL, '+
           ' InStock Double null DEFAULT NULL, '+
           ' AllocatedSO Double null DEFAULT NULL, '+
           ' InvBO Double null DEFAULT NULL, '+
           ' POBO Double null DEFAULT NULL, '+

           ' OnBuild Double null DEFAULT NULL, '+
           ' Building Double null DEFAULT NULL, '+
           ' OnTransitin Double null DEFAULT NULL, '+
           ' OnTransitout Double null DEFAULT NULL, '+
           ' PRIMARY KEY (ID), '+
           ' UNIQUE KEY productId_departmentId_UOMID (productId,departmentId,uomId) '+
           ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;');

  {Binny : Set Qty to null - as if PQA is deleted, the update query will not have any reqocrd}
  AddSQL('update tblProductQtySum '+
                ' Set  SOBO   =0, '+
                ' Available   =0, '+
                ' InStock     =0, '+
                ' AllocatedSO =0, '+
                ' InvBO       =0, '+
                ' POBO        =0, '+
                ' OnBuild     =0, '+
                ' Building    =0, '+
                ' OnTransitin =0, '+
                ' OnTransitout=0 ' +
                iif(aproductIDs<>'',' where ProductId in (' + aProductIDs+ ')', '')+';');

  AddSQL('insert ignore into  tmp_tblProductQtySumQtys (productId,departmentId,uomId,SOBO,Available,InStock,AllocatedSO,InvBO,POBO,OnBuild,Building)' + NL+
           '      SELECT P.PARTSID          As ProductId,  PQA.departmentId,  PQA.uomId, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tSOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As SOBO, ' + NL+
           iif(AppEnvVirt.Bool['CompanyPrefs.CountSOBOInAvailable'],
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tAvailable ) +' - ' +
                                                 ProductQtylib.SQL4Qty( tSoBo)       +',0.0) ,' +  IntToStr(tcConst.GeneralRoundPlaces)+')  as Available,',
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tAvailable ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as Available,')  + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tInstock)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As InStock, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tSO)         +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As AllocatedSO, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tInvBO)      +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As InvBO, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tPOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As POBO, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tOnBuild)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As OnBuild, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tBuilding)   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As Building ' + NL+

           '      FROM ' + trim(ProductTables(tProductList) ) + NL+
           iif(aproductIDs<>'' , ' Where P.partsId in (' + aProductIDs+')', '')+
           '      GROUP BY PQA.ProductId, PQA.DepartmentID, PQA.UOMID ;');

  AddSQL('insert ignore into  tblProductQtySum '+
           ' (productId,departmentId,uomId,SOBO,Available,InStock,AllocatedSO,InvBO,POBO,OnBuild,Building)  '+
           ' Select productId,departmentId,uomId,SOBO,Available,InStock,AllocatedSO,InvBO,POBO,OnBuild,Building  '+
           ' from tmp_tblProductQtySumQtys  T1  ' +
           ' ON DUPLICATE KEY UPDATE   SOBO       = T1.SOBO , '       +
                                     ' Available  = T1.Available , '  +
                                     ' InStock    = t1.InStock, '     +
                                     ' AllocatedSO= t1.AllocatedSO , '+
                                     ' InvBO      = t1.InvBO , '      +
                                     ' POBO       = t1.POBO , '       +
                                     ' OnBuild    = t1.OnBuild , '    +
                                     ' Building   = t1.Building;');
(*  AddSQL('update tblProductQtySum T1 inner join tmp_tblProductQtySumQtys  T2 on t1.productId = t2.productId and t1.departmentId = t2.departmentId and t1.uomId = t2.uomId  '+
           ' set  t1.OnTransitin = T2.OnTransitin , t1.OnTransitout = T2.OnTransitout;');*)


  AddSQL('truncate tmp_tblProductQtySumQtys; ' );
  AddSQL('insert ignore into  tmp_tblProductQtySumQtys (productId,departmentId,uomId,OnTransitin,OnTransitout)' + NL+
           '      SELECT  P.PARTSID          As ProductId,  PQA.departmentId, PQA.uomId, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +SQL4QtyField(tOnTransitin, '', 'QTY')  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As OnTransitin, ' + NL+
           '      Round(IF(P.PARTTYPE = "INV",' +SQL4QtyField(tOnTransitout, '', 'QTY')   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As OnTransitout ' + NL+
           '      FROM ' + trim(ProductTables(tProductList) ) + NL+
           iif(aproductIDs<>'' , ' Where P.partsId in (' + aProductIDs+')', '')+
           '      GROUP BY PQA.ProductId, PQA.DepartmentID, PQA.UOMID ;');

  AddSQL('insert ignore into  tblProductQtySum '+
           ' (productId,departmentId,uomId,OnTransitin , OnTransitout)  '+
           ' Select productId,departmentId,uomId,OnTransitin , OnTransitout '+
           ' from tmp_tblProductQtySumQtys T1  '+
           ' ON DUPLICATE KEY UPDATE   OnTransitin = T1.OnTransitin ,  '       +
                                     ' OnTransitout = T1.OnTransitout;');
  AddSQL('update tblProductQtySum  t inner join tblparts          p   on t.productid    = p.partsid   set t.productname   = P.partname ' +
                                    iif(aproductIDs<>'',' where P.PartsId in (' + aProductIDs+ ')', '')+';');
  AddSQL('update tblProductQtySum  t inner join tblunitsofmeasure uom on t.uomid        = uom.unitid  set t.uom           = concat(uom.unitname , "(" , uom.Multiplier , ")");');
  AddSQL('update tblProductQtySum  t inner join tblunitsofmeasure uom on t.uomid        = uom.unitid  set t.uomname       = uom.unitname;');
  AddSQL('update tblProductQtySum  t inner join tblclass          C   on t.DepartmentId = C.classid   set t.DepartmentName= c.classname;');
  result := st.Text;
end;
procedure TSyncReportTableObj.DosyncSerialnumberlist;
begin
  try
      st.clear;
      //AddSQL('call UpdateSerialnumberList(0,0,0,"", 0 ,"");');
      AddSQL('truncate tblupdate_serial_number_listlog;');
      AddSQL('truncate tblUpdate_Serial_NumberHistory;');
      AddSQL('truncate tblSerial_number_List;');
      (*AddSQL('call UpdateSerialnumberList;');*)
      Execute;
      AddSQL('call Update_Serial_Number_List;');
      Execute;
  finally
      AppEnvVirt.Float['CompanyPrefs.SerialNumberListUpdatedOn'] := Now;
      AppEnvVirt.DeleteServerFiles('tmp_SNL_pqa*.tmp');
  end;
end;
procedure TSyncReportTableObj.DosyncAll;
var
  ctr: Integer;
  TableName: string;
  PD: TProgressInfo;
begin
  inherited;
  try
    PD := TProgressInfo(AppEnvVirt.Obj['ProgressInfo']);
    PD.Caption := 'Creating Report DB.';
    PD.Message := AppEnvVirt.Str['TcConst.WAITMSG'];
    PD.MaxValue := LstTables.count + 2;
    PD.Step := 1;
    PD.Execute;
//    PD := TProgressDialog.NewProgressbar('Creating Report DB.  ' + AppEnvVirt.Str['TcConst.WAITMSG'], LstTables.count + 1);
    try
      for ctr := 0 to LstTables.count - 1 do begin
        TableName := LstTables[ctr];
        if IsDevmode then
          PD.Message := inttostr(ctr + 1) + ' of ' + inttostr(LstTables.count) +' -> ' + Tablename
        else
          PD.Message := inttostr(ctr + 1) + ' of ' + inttostr(LstTables.count);
        // Tablename;
        PD.StepIt;
        try
          Dosync(TableName);
          DoMakeProductStockTable;
        except
          on E: Exception do begin
            // ignore the exception
          end;
        end;
      end;
      if AppEnvVirt.Bool['CompanyPrefs.DosyncSerialnumberlist'] then begin
        PD.StepIt;
        PD.Message := 'Updating Serial No List';
        DosyncSerialnumberlist;
        PD.Message := 'Updated Serial No List';
        PD.StepIt;
      end;
      //if AppEnvVirt.Bool['CompanyPrefs.DoSynchProductQty'] then begin
      if AppEnvVirt.Bool['CompanyPrefs.doUpdateProductQtySum'] then begin
        PD.StepIt;
        PD.Message := 'Updating Product Qty';
        DoUpdateProductQtySum('');
        PD.Message := 'Updated Serial No List';
        PD.StepIt;
      end;
    finally
      PD.CloseDialog;
//      FreeandNil(PD);
    end;
  finally
    AppEnvVirt.Float['CompanyPrefs.ReportTablesLastUpdatedOn'] := Now;
  end;
end;

procedure TSyncReportTableObj.DosyncTables(Tablenames: string);
var
  s: string;
begin
  if Tablenames = '' then exit;
  s := LstTables.commaText;
  LstTables.commaText := Tablenames;
  try
    if LstTables.count = 0 then exit;
    DosyncAll;
  finally LstTables.commaText := s;
  end;
end;

function TSyncReportTableObj.FieldNames(TableName: string): string;
begin
  with ERPQuery do
    try
      SQL.add('desc ' + TableName);
      Open;
      first;
      REsult := '';
      while eof = False do begin
        if REsult <> '' then REsult := REsult + ',';
        REsult := REsult + '`' + FieldByname('field').asString + '`';
        NExt;
      end;
    finally
      close;
      SQL.clear;
    end;
end;

procedure TSyncReportTableObj.Execute;
begin
  if st.text = '' then exit;
  with ERPScript do begin
    SQL.clear;
    SQL.add(st.text);
    recno := 0;
    reccount := SQL.Count;
    try
      Execute;
    finally
      recno := 0;
      reccount := 0;
    end;
    st.clear;
  end;
  //DostepProgressbar;
  TProgressInfo(AppEnvVirt.Obj['ProgressInfo']).StepIt;
end;

procedure TSyncReportTableObj.DeleteAllReportTables;
begin
  DeleteAllTables('Rpt_');
end;

procedure TSyncReportTableObj.DeleteAllTables(Tablesuffix: string);
var
  DBTables: TStringList;
  ctr: Integer;
begin
  DBTables := TStringList.Create;
  try
    MyConnection.GetTableNames(DBTables);
    for ctr := DBTables.count - 1 downto 0 do
      if (Length(DBTables[ctr]) >= Length(Tablesuffix)) and (pos(Tablesuffix, uppercase(DBTables[ctr])) = 1) then AddSQL('Drop table if Exists ' + DBTables[ctr] + ';');
    Execute;
  finally FreeandNil(DBTables);
  end;
end;

destructor TSyncReportTableObj.Destroy;
begin
  FreeandNil(st);
  FreeandNil(ERPScript);
  FreeandNil(ERPQuery);
  FreeandNil(LstTables);
  inherited;
end;

procedure TSyncReportTableObj.MakeSQL(SQLtype: TSQLtype; TableName, sSQL, PrimaryKey: string);
var
  s: string;
  strSQL: string;
begin
  with ERPQuery do
    try
      SQL.add(sSQL);
      Open;
      if recordcount > 0 then begin
        first;
        if SQLtype = stInsert then s := 'insert into ' + TableName + ' SET %SQL% ;'
        else s := 'update ' + TableName + ' SET %SQL%  where `' + PrimaryKey + '` = %PKV% ;';
        while eof = False do begin
          strSQL := s;
          strSQL := StringReplace(strSQL, '%SQL%', CopyfieldsSQL(ERPQuery), [rfReplaceAll, rfIgnoreCase]);
          if SQLtype = stUpdate then strSQL := StringReplace(strSQL, '%PKV%', inttostr(ERPQuery.FieldByname(PrimaryKey).asInteger), [rfReplaceAll, rfIgnoreCase]);
          AddSQL(strSQL);
          NExt;
        end;
      end;
    finally
      if ERPQuery.active then ERPQuery.close;
      ERPQuery.SQL.clear;
    end;
end;

procedure TSyncReportTableObj.AddSQL(const Value: string);
begin
  st.add(Value);
  if st.count > 1000 then Execute;
end;

procedure TSyncReportTableObj.OnAfterExecuteScript(Sender: TObject;SQL: string);
begin
  if reccount <10 then exit;
  TProgressInfo(AppEnvVirt.Obj['ProgressInfo']).Message :=SyncingTable +' : ' +inttostr(recno) +' of ' + inttostr(reccount);
  recno := recno +1;
end;

procedure TSyncReportTableObj.OnSQLError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
//  ErrorLog(SyncingTable + ':' + E.Message + chr(13) + SQL);
  Action := eacontinue;
  inherited;
end;

function TSyncReportTableObj.create_Table_File_SQL(const TemplateTableName: string; const sSQL: string; const Fieldlist: string; var TableName: string; var tmpfilename: string;
  const TableNameSuffix: string = ''; const EngineName: string = ''): string;
begin
  REsult := TempTableUtils.CreateTemporaryTableusingfile(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']),
    TemplateTableName, sSQL, Fieldlist, TableName, tmpfilename, TableNameSuffix, EngineName);
end;

function TSyncReportTableObj.IsFieldExists(const TableName, Fieldname: string): boolean;
begin
  REsult := TempTableUtils.FieldExists(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']),TableName, Fieldname);
end;

function TSyncReportTableObj.NewQuery: TERPQuery;
begin
  REsult := TERPQuery.Create(nil);
  REsult.Options.FlatBuffers := True;
  REsult.Connection := MyConnection;
end;

function TSyncReportTableObj.NewScript: TERPScript;
begin
  REsult := TERPScript.Create(nil);
  REsult.Connection := MyConnection;
end;

function TSyncReportTableObj.IsTableExists(const TableName: string): boolean;
begin
  REsult := TempTableUtils.TableExists(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']),TableName);
end;

function TSyncReportTableObj.Create_Table_SQL(var TableName: string; const TemplateTableName: string; const TableNameSuffix: string = ''; const EngineName: string = ''): string;
begin
  REsult := TempTableUtils.CreateTableSQL(TableName, TemplateTableName, TableNameSuffix, EngineName);
end;

function TSyncReportTableObj.TablePrimarykey(const TableName: string): string;
var
  HasGlobalRef: boolean;
begin
  REsult := MySQLUtils.MySQLTablePrimaryKey(TableName,TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']),HasGlobalRef);
end;

initialization

  RegisterClass(TSyncReportTableObj);
  fSyncReportObj := nil;

end.
