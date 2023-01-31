unit ERPLicenceUtils;

interface

uses
  MyAccess, MyScript;

function DeleteClient(const aClientId: integer; aConn: TMyConnection): boolean;
function DeleteComputer(const aComputerId: integer; aConn: TMyConnection): boolean;
function DeleteLicence(const aLicenceId: integer; aConn: TMyConnection): boolean;
function DeleteConfig(const aConfigId: integer; aConn: TMyConnection): boolean;


implementation

uses
  sysutils, dialogs;


function DeleteClient(const aClientId: integer; aConn: TMyConnection): boolean;
var
  script: TMyScript;
begin
  result := true;
  script := TMyScript.Create(nil);
  try
    script.Connection := aConn;
    script.SQL.Add('delete from tsoftwarelicence where computerid in (select id from tcomputer where clientid = ' + IntToStr(aClientId) + ');');
    script.SQL.Add('delete from tcomputerconfig  where computerid in (select id from tcomputer where clientid = ' + IntToStr(aClientId) + ');');
    script.SQL.Add('delete from tcomputer where clientid = ' + IntToStr(aClientId) + ';');
    script.SQL.Add('delete from tclientconfig where id = ' + IntToStr(aClientId) + ';');
    try
      script.Execute;
    except
      on e: exception do begin
        result := false;
        ShowMessage('Error: ' + e.Message);
      end;
    end;
  finally
    script.Free;
  end;
end;

function DeleteComputer(const aComputerId: integer; aConn: TMyConnection): boolean;
var
  script: TMyScript;
begin
  result := true;
  script := TMyScript.Create(nil);
  try
    script.Connection := aConn;
    script.SQL.Add('update tclientconfig set user = "ERP", datetime = UTC_TIMESTAMP()');
    script.SQL.Add('where tclientconfig.id = (select clientid from tcomputer where id = ' + IntToStr(aComputerId) + ');');
    script.SQL.Add('delete from tcomputer where id = ' + IntToStr(aComputerId) + ';');
    script.SQL.Add('delete from tsoftwarelicence where computerid = ' + IntToStr(aComputerId) + ';');
    script.SQL.Add('delete from tcomputerconfig where computerid = ' + IntToStr(aComputerId) + ';');
    try
      script.Execute;
    except
      on e: exception do begin
        result := false;
        ShowMessage('Error: ' + e.Message);
      end;
    end;
  finally
    script.Free;
  end;
end;

function DeleteLicence(const aLicenceId: integer; aConn: TMyConnection): boolean;
var
  script: TMyScript;
begin
  result := true;
  script := TMyScript.Create(nil);
  try
    script.Connection := aConn;
    script.SQL.Add('update tclientconfig set user = "ERP", datetime = UTC_TIMESTAMP()');
    script.SQL.Add('where tclientconfig.id = ');
    script.SQL.Add('(select tcomputer.clientid from tcomputer,tsoftwarelicence where tsoftwarelicence.id = ' + IntToStr(aLicenceId) + ' and tsoftwarelicence.ComputerId = tcomputer.id);');
    script.SQL.Add('update tcomputer set user = "ERP", datetime = UTC_TIMESTAMP()');
    script.SQL.Add('where tcomputer.id = (select computerid from tsoftwarelicence where tsoftwarelicence.id = ' + IntToStr(aLicenceId) + ');');
    script.SQL.Add('delete from tsoftwarelicence where id = ' + IntToStr(aLicenceId) + ';');
    try
      script.Execute;
    except
      on e: exception do begin
        result := false;
        ShowMessage('Error: ' + e.Message);
      end;
    end;
  finally
    script.Free;
  end;
end;

function DeleteConfig(const aConfigId: integer; aConn: TMyConnection): boolean;
var
  script: TMyScript;
begin
  result := true;
  script := TMyScript.Create(nil);
  try
    script.Connection := aConn;
    script.SQL.Add('update tclientconfig set user = "ERP", datetime = UTC_TIMESTAMP()');
    script.SQL.Add('where tclientconfig.id = ');
    script.SQL.Add('(select tcomputer.clientid from tcomputer,tcomputerconfig where tcomputerconfig.id = ' + IntToStr(aConfigId) + ' and tcomputerconfig.ComputerId = tcomputer.id);');
    script.SQL.Add('update tcomputer set user = "ERP", datetime = UTC_TIMESTAMP()');
    script.SQL.Add('where tcomputer.id = (select computerid from tcomputerconfig where tcomputerconfig.id = ' + IntToStr(aConfigId) + ');');
    script.SQL.Add('delete from tcomputerconfig where id = ' + IntToStr(aConfigId) + ';');
    try
      script.Execute;
    except
      on e: exception do begin
        result := false;
        ShowMessage('Error: ' + e.Message);
      end;
    end;
  finally
    script.Free;
  end;
end;

end.
