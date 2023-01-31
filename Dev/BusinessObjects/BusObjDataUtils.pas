unit BusObjDataUtils;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 21/11/05  1.00.00 IJB  Initial version.
 06/06/06  1.00.01 IJB  Modified UpdateAccounts to use TCustomConnection.
 11/08/06  1.00.02 BJ   UpdateAccounts : posting SO balance in client WAS updating
                        Both SOBALANCE and BALANCE in the client. NOW SO updates
                        the SOBalance and Invoice updates the Balance.
}

interface

uses DB;

function GetTablePrimaryKeyName(const TableName: string): string;

implementation

uses
  CommonDbLib, MyAccess,ERPdbComponents,  SysUtils;


function GetTablePrimaryKeyName(const TableName: string): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'DESCRIBE ' + TableName;
    qry.Open;
    if qry.Locate('Key', 'PRI', [loCaseInsensitive]) then Result := qry.FieldByName('Field').AsString;
  finally
    FreeAndNil(qry);
  end;
end;


end.

