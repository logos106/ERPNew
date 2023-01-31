unit CurrentUsersObj;

{ML - 08/2002 - This object can be used to get a list of current users. The GetCurrentUsers
class method returns a TStringList that can be used to count the active users or populate
any TStrings based control.

Usage : lstUsers := TCurrentUsersObj.GetCurrentUsers;

}

interface

uses
  DB, Classes, MyAccess,ERPdbComponents, SysUtils;

type
  TCurrentUsersObj = class(TObject)
  private

  public
    class function GetCurrentUsers(ExcludeSelf: boolean): TStringList;
  end;

function GetCurrentUserCount: integer;
procedure GetCurrentUserList(Const SL: TStringList);

implementation

uses
  DNMLib, CommonDbLib, FastFuncs;

const
  LOCALHOST: string = 'LOCALHOST';

function GetCurrentUserCount: integer;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Assign(TCurrentUsersObj.GetCurrentUsers(false));
    Result := SL.Count;
  finally
    FreeAndNil(SL);
  end;
end;

procedure GetCurrentUserList(Const SL: TStringList);
begin
  SL.Assign(TCurrentUsersObj.GetCurrentUsers(false));
end;

class function TCurrentUsersObj.GetCurrentUsers(ExcludeSelf: boolean): TStringList;
var
  oData: TERPQuery;
  sUser: string;
  sDB: string;
begin
  oData := TERPQuery.Create(nil);
  try
    Result           := TStringList.Create;
    Result.Sorted    := true;
    Result.Duplicates := dupIgnore;
    try
      oData.Connection := CommonDbLib.GetSharedMyDacConnection;
      oData.SQL.Text   := 'Show ProcessList';
      If not oData.Connection.connected then Begin {DB Lost - Remove DB}
        Exit;
      end;
      oData.Open;
      oData.First;
      while not oData.Eof do begin
        sUser := FastFuncs.UpperCase(ExtractStrPortion(oData.FieldByName('Host').AsString, ':', 1));
        sDB := FastFuncs.UpperCase(oData.FieldByName('DB').AsString);
        if FastFuncs.SameText(sUser, LOCALHOST) then begin
          sUser := 'ERP SERVER';
        end;
        if FastFuncs.SameText(oData.Connection.Database, sDB) and not FastFuncs.SameText(sDB, 'services') then begin
          if not (ExcludeSelf and FastFuncs.SameText(oData.FieldByName('Info').AsString, 'SHOW PROCESSLIST')) then
            Result.Add(sUser);
        end;

       // and not FastFuncs.SameText(oData.FieldByName('Info').AsString, 'SHOW PROCESSLIST')}
//        then Result.Add(sUser);
        oData.Next;
      end;
    except // For Mysql Stopped & Try to Exit ERP Crash on oData.Open
    end;
  finally
    FreeAndNil(oData);
  end;
end;

end.

