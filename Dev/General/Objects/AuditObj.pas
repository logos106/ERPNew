unit AuditObj;

interface

uses
  SysUtils;

type
  TAuditObj = class(TObject)
  private
    foAuditFile: TextFile;
  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure AddEntry(const oEx: Exception; const AffectedObj: TObject); overload;
    procedure AddEntry(const oEx: Exception; const AdditionalText: string; const AffectedObj: TObject); overload;
  end;

var
  Audit: TAuditObj;

implementation

uses
  Forms,  DNMLib, AppEnvironment, SystemLib;

const
  AUDIT_FILE = 'ERPError.log';

constructor TAuditObj.Create;
var
  sFile: string;
begin
  inherited;
  sFile := SystemLib.ExeDir + AUDIT_FILE;
  AssignFile(foAuditFile, sFile);
  //  {$IOCHECKS OFF}
  //   Reset(foAuditFile);
  //  {$IOCHECKS ON}
  if FileExists(sFile) then begin
    {$IOCHECKS OFF}
    Append(foAuditFile);
    {$IOCHECKS ON}
  end else begin
    {$IOCHECKS OFF}
    Rewrite(foAuditFile);
    {$IOCHECKS ON}
  end;
end;

destructor TAuditObj.Destroy;
begin
  {$IOCHECKS OFF}
  CloseFile(foAuditFile);
  {$IOCHECKS ON}
  inherited;
end;

procedure TAuditObj.AddEntry(const oEx: Exception; const AffectedObj: TObject);
begin
  if Assigned(AppEnv.Employee) and Assigned(AffectedObj) then {$IOCHECKS OFF}
    Writeln(foAuditFile, DateTimeToStr(Now) + ' = ' +
      AppEnv.Employee.LogonName + '(' + GetPCName + ')' + ' = ' + oEx.Message +
      ' in class = ' + AffectedObj.ClassName);
  {$IOCHECKS ON}
end;

procedure TAuditObj.AddEntry(const oEx: Exception; const AdditionalText: string; const AffectedObj: TObject);

  function GetExceptionMessage: string;
  begin
    Result := '';
    if oEx <> nil then begin
      Result := oEx.Message;
    end;
  end;
begin
  if Assigned(AppEnv.Employee) and Assigned(AffectedObj) then {$IOCHECKS OFF}
    Writeln(foAuditFile, DateTimeToStr(Now) + ' = ' +
      AppEnv.Employee.LogonName + '(' + GetPCName + ')' + ' = ' + GetExceptionMessage +
      AdditionalText + ' in class = ' + AffectedObj.ClassName);
  {$IOCHECKS ON}
end;

initialization
  if not Assigned(Audit) then begin
    Audit := TAuditObj.Create;
  end;

finalization
  if Assigned(Audit) then begin
    FreeandNil(Audit);
  end;
end.
