unit SharedObjs;

interface

uses ERPdbComponents,  BusobjUOM, busobjProductbin , BusObjBase ;

var
  fSharedUOM_UnitProduct_Obj :TUnitOfMeasure;
  fsharedProductBinObj : TProductBin;
(*  fSharedQryobj :TERPQuery;
  fSharedScript : TERPScript;*)

  Function SharedUOM_UnitProduct_Obj(const UnitProductKeyname :String):TUnitOfMeasure;
  Function SharedProductBinObj : TProductBin;
(*  Function SharedQryObj(const fSQL:String='') :TERPQuery;
  function SharedScript(const fSQL:String='') :TERPScript;*)
  function ProductBinIDToggle(const fiDepartmentID: Integer; const FSBinLocation, FSbinNumber: string): Integer; overload;
  function ProductBinIDToggle(const iBinId: Integer; const GetLocation: Boolean): string; overload;
  function ERPFIXTablenameforCurVersion(const tablename:String;Sufix:String =''):String;
  Function ERPFixtableSQL(const tablename:String;Sufix:String ='';ignoreiftableExists :boolean =False):String;

implementation

uses
  sysutils, forms , CommonDbLib, CommonLib, AppDatabase, DbSharedObjectsObj,
  ERPVersionConst;

Function SharedProductBinObj : TProductBin;
begin
  if  fsharedProductBinObj = nil then begin
      fsharedProductBinObj :=  TProductBin.CreateWithNewConn(Application)
  end;
  result := fsharedProductBinObj;
end;


Function SharedUOM_UnitProduct_Obj(const UnitProductKeyname :String):TUnitOfMeasure;
begin
  if  fSharedUOM_UnitProduct_Obj = nil then begin
      fSharedUOM_UnitProduct_Obj :=  TUnitOfMeasure.CreateWithNewConn(Application);
    fSharedUOM_UnitProduct_Obj.LoadSelect('UnitProductKeyName = ' + QuotedStr(StringReplace(UnitProductKeyname,'\','\\',[rfReplaceAll])));
  end;
  if fSharedUOM_UnitProduct_Obj.UnitProductKeyName <> UnitProductKeyname then
    fSharedUOM_UnitProduct_Obj.LoadSelect('UnitProductKeyName = ' + QuotedStr(StringReplace(UnitProductKeyname,'\','\\',[rfReplaceAll])));
  REsult :=fSharedUOM_UnitProduct_Obj;
end;
function ProductBinIDToggle(const fiDepartmentID: Integer; const FSBinLocation, FSbinNumber: string): Integer;
var
  strSQL: string;
  Qry:TERPQuery;
begin
  strSQL := 'Select  BinID from Tblproductbin where ifnull(BinLocation,"") = ' + QuotedStr(FSBinLocation) + ' and ifnull(Binnumber,"") = ' + QuotedStr(FSbinNumber) +
    ' and ClassId = ' + IntToStr(fiDepartmentID);
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry  do begin
      SQL.text := strSQL;
      open;
      //with SharedQryobj(strSQL) do begin
      Result := FieldByname('BinID').asInteger;
      close;
    end;
  finally
    Dbsharedobj.releaseobj(Qry);
  end;
end;
function ProductBinIDToggle(const iBinId: Integer; const GetLocation: Boolean): string;
var
  strSQL: string;
  Qry:TERPQuery;
begin
  if iBinId = 0 then Exit;
  strSQL := 'Select  BinLocation, BinNumber from Tblproductbin where BinID = ' + IntToStr(iBinId);
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry  do begin
      SQL.text := strSQL;
      open;
      //with SharedQryobj(strSQL) do begin
        if GetLocation then Result := FieldByname('BinLocation').AsString
        else Result := FieldByname('Binnumber').AsString;
        close;
    end;
  finally
    Dbsharedobj.releaseobj(Qry);
  end;
end;
(*function SharedScript(const fSQL:String='') :TERPScript;
begin
  if fSharedScript = nil then fSharedScript := tempMyscript;
  if fSQL <> '' then if not(sametext(fSharedScript.SQL.Text , fSQL)) then fSharedScript.SQL.Text := fSQL;
  result :=fSharedScript;
end;*)
(*Function SharedQryobj(const fSQL:String='') :TERPQuery;
begin
  if  fSharedQryobj = nil then
    fSharedQryobj := TempMyQuery;

  if (fSharedQryobj.Active = False) or (not(SameTExt(trim(fSharedQryobj.SQL.Text) , trim(fSQL)))) then begin
    closedb(fSharedQryobj);
    fSharedQryobj.SQL.Clear;
    fSharedQryobj.SQL.Text := fSQL;
    if fSQL <> '' then openDB(fSharedQryobj);
  end;
  Result:= fSharedQryobj;
end;*)
function ERPFIXTablenameforCurVersion(const tablename:String;Sufix:String =''):String;
begin
  result:= 'erpfix_'+tablename+  iif(Sufix <> '' , '_'+Sufix , '') +'_' + replacestr(TABLE_VERSION, '.' , '');
end;
Function ERPFixtableSQL(const tablename:String;Sufix:String ='';ignoreiftableExists :boolean =False):String;
begin
  Result := ERPFIXTablenameforCurVersion(Tablename , Sufix);
  if ignoreiftableExists and tableexists(Result) then result := ''
  else REsult := 'create table if not exists ' + Result +' like ' + Tablename +';'+
                  'insert ignore into ' + Result +' select * from  ' + Tablename +' ;';

end;
initialization
  fSharedUOM_UnitProduct_Obj := nil;
  fsharedProductBinObj := nil;
  (*fSharedQryobj := nil;
  fSharedScript := nil;*)

Finalization
//  FreeandNil(fSharedUOM_UnitProduct_Obj);  { owned by application }
  FreeandNil(fsharedProductBinObj);
(*  FreeandNil(fSharedQryobj);
  FreeandNil(fSharedScript);*)

end.

