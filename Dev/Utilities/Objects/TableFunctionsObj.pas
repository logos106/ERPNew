unit TableFunctionsObj;

interface

uses
  MyAccess;

type
  TTableFunctionsObj = class(TObject)
  public
    procedure OptimizeTables;
    procedure RepairTables(const ExtendedMode: boolean = false);
    function ChangeTableType(const TableName, TableType: string): boolean;
    function OptimizeTable(const TableName: string; Conn: TMyConnection = nil): boolean;
    function RepairTable(const TableName: string; const ExtendedMode: boolean = false; Conn: TMyConnection = nil): boolean;
    function RemoveListCustomisation(const EmployeeID: string): boolean;
  end;

implementation

uses
  DB,ERPdbComponents, Forms, SysUtils, Controls,
  //ERP
  AppEnvironmentVirtual;

{ TTableFunctionsObj }

function TTableFunctionsObj.ChangeTableType(const TableName, TableType: string): boolean;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    with qryTemp do try
        sql.Clear;
        //Application.ProcessMessages;
        sql.Add('ALTER TABLE `' + TableName + '` TYPE = ' + TableType + ';'); //TableType =  InnoDB Or  MyISAM
        Execute;
        Result := true;
      finally
        FreeAndNil(qryTemp);
      end;
  except
    Result := false;
  end;
end;


function TTableFunctionsObj.OptimizeTable(const TableName: string; Conn: TMyConnection = nil): boolean;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  if Assigned(Conn) then
    qryTemp.Connection := Conn
  else
    qryTemp.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    with qryTemp do try
        sql.Clear;
        sql.Add('OPTIMIZE TABLE `' + Trim(TableName) + '`;');
        Execute;
        Result := true;
      finally
        FreeAndNil(qryTemp);
      end;
  except
    Result := false;
  end;
end;




function TTableFunctionsObj.RemoveListCustomisation(const EmployeeID: string): boolean;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    with qryTemp do try
//        sql.Clear;
//        sql.Add('DELETE FROM tblcustomizedlists WHERE char_length(Report)=0 AND EmployeeID =' + EmployeeID + ';');
//        Execute;
        sql.Clear;
        sql.Add('DELETE FROM tblpersonaltabs WHERE EmployeeID =' + EmployeeID + ';');
        Execute;
        Result := true;
      finally
        FreeAndNil(qryTemp);
      end;
  except
    Result := false;
  end;
end;

function TTableFunctionsObj.RepairTable(const TableName: string; const ExtendedMode: boolean = false; Conn: TMyConnection = nil): boolean;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  if Assigned(Conn) then
    qryTemp.Connection := Conn
  else
    qryTemp.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    with qryTemp do try
        SQL.Clear;
        SQL.Add('CHECK TABLE `' + Trim(TableName) + '`  QUICK;');
        Execute;

        SQL.Clear;
        if ExtendedMode then SQL.Add('REPAIR TABLE `' + Trim(TableName) + '` USE_FRM;')
        else SQL.Add('REPAIR TABLE `' + Trim(TableName) + '`;');
        Execute;

        Result := true;
      finally
        FreeAndNil(qryTemp);
      end;
  except
    Result := false;
  end;
end;

procedure TTableFunctionsObj.OptimizeTables;
var
  dsTables: TERPQuery;
begin
  try
    //Setup Query/Dataset
    dsTables := TERPQuery.Create(nil);
    dsTables.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    try
      dsTables.Options.FlatBuffers := True;
      dsTables.SQL.Text := 'Show Tables;';
      dsTables.Open;
      with dsTables do begin
        if RecordCount > 0 then begin
          First;
          while not dsTables.Eof do begin
            OptimizeTable(dsTables.Fields[0].AsString);
            //Application.ProcessMessages;
            Next;
          end;
        end;
      end;
    finally
      FreeandNil(dsTables);
    end;
  except
    raise;
  end;
end;

procedure TTableFunctionsObj.RepairTables(const ExtendedMode: boolean);
var
  dsTables: TERPQuery;
begin
  try
    //Setup Query/Dataset
    dsTables := TERPQuery.Create(nil);
    dsTables.Connection := TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    try
      dsTables.Options.FlatBuffers := True;
      dsTables.SQL.Text := 'Show Tables;';
      dsTables.Open;
      with dsTables do begin
        if RecordCount > 0 then begin
          First;
          while not dsTables.Eof do begin
            RepairTable(dsTables.Fields[0].AsString, ExtendedMode);
            //Application.ProcessMessages;
            Next;
          end;
        end;
      end;
    finally
      FreeandNil(dsTables);
    end;
  except
    raise;
  end;
end;

end.
