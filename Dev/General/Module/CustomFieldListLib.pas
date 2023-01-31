unit CustomFieldListLib;

interface

uses ERPdbComponents, Busobjcustomfields;

type
  TCustomFieldSQLProc    = Procedure (const Fields : String=''; Tables: String='') of Object;

Procedure CustomfieldlistSQL(Listtype:TListType; SQLQry:TERPQuery; MasterIDField:String ; AddCustomFields:TCustomFieldSQLProc ;  MasterID:Integer=0);

implementation

uses DbSharedObjectsObj, CommonDbLib, CommonLib, sysutils, db, tcConst;

Procedure CustomfieldlistSQL(Listtype:TListType; SQLQry:TERPQuery; MasterIDField:String ; AddCustomFields:TCustomFieldSQLProc ;  MasterID:Integer=0);
var
  qry: TERPQuery;
  fsFields ,fstables,  fsCFVTablename, fsFieldname :String;
begin
  fsCFVTablename:= ListTypetoTablename(Listtype);
  if fsCFVTablename ='' then exit;

  closedb(SQLQry);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'select * from tblcustomfieldlist where listtype =  ' + quotedstr(ListTypetoString(Listtype));
    Qry.open;
    if Qry.recordcount =0 then exit;
    Qry.First;
    fsFields:='';
    fstables := '';
    While Qry.Eof = False do begin
      fsFieldname :='CF' +trim (inttostr(qry.recno));
      fsFields := fsFields + 'convert((select Value from ' + fsCFVTablename +'  where CustomFieldlistId = ' + inttostr(Qry.fieldbyname('CFID').asInteger)+
                iif(MasterID<>0 , ' and MasterId = ' + inttostr(MasterID) ,' and MasterId = ' + MasterIDField  )  +') , char(255))'+
                ' as ' + fsFieldname + ',';

      {make field in main qry}
      if SQLQry.findfield(fsFieldname) = nil then begin
        with TWideStringField.Create(SQLQry.Owner) do begin
          fieldKind := fkData;
          fieldname := fsFieldname;
          name := 'Qrymain'+fsFieldname;
          DataSet := SQLQry;
          Displaylabel := Qry.fieldbyname('Description').asString;
          DisplayWidth := 255;
          visible := True;
        end;
      end;

    Qry.Next;
    end;
  finally
    AddCustomFields(fsFields , fstables);
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
end.
