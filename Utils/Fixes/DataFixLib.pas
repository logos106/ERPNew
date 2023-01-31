unit DataFixLib;

interface

uses ERPdbComponents, DatafixObj;

function DoDatafix(const Servername, databasename: string; var Errmsg: string; var infoMsg:String; Progressdialog:TGeneralStringProc = nil): Boolean;
(* function FixDeletedTranslines(Connection: TERPConnection; var Errmsg: string; var infoMsg:String): Boolean; *)
implementation

uses sysutils, DbConst, UtilsLib, classes;

{main function to be called from the Servive}
function DoDatafix(const Servername, databasename: string; var Errmsg: string; var infoMsg:String; Progressdialog:TGeneralStringProc = nil): Boolean;
var
  DatafixObj:TDatafixObj;
begin
  Result := False;
  try
      try
        DatafixObj:=TDatafixObj.create(nil);
        try
          DatafixObj.Servername := Servername;
          DatafixObj.databasename :=databasename;
          DatafixObj.Progressdialog := Progressdialog;
          //Result := DatafixObj.PPGCheknFix;
          Result := true;
          Result := Result and DatafixObj.FixInactivePQAs;
          Result := Result and DatafixObj.FixDeletedTranslines;
          result := result and DatafixObj.FixDeletedProductMovements;
          ErrMsg:= DatafixObj.errMsg;
          InfoMsg := DatafixObj.InfoMsg;
          {Call New Fix-functions from heere here }
        finally
          Freeandnil(DatafixObj);
        end;
      except
        on E: Exception do begin
          Errmsg := E.Message;
        end;
      end;
  except
    on E: Exception do begin
       Errmsg := E.Message;
    end;

  end;
end;
(* function FixDeletedTranslines(Connection: TERPConnection; var Errmsg: string; var infoMsg:String): Boolean;
var
  ctr:Integer;
  st:TStringList;
const
  tablestoBackup :Array [1..4] of String = ('tblsaleslines' , 'tblpurchaselines' , 'tblpqa' , 'tblpqadetails');
begin
  Result := False;
  st:=TStringList.create;
  try
    for ctr := low(tablestoBackup) to high(tablestoBackup) do begin

    end;
  finally
    Freeandnil(st);
  end;
end; *)
end.
