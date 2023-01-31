unit ERPSysInfoObj;

interface

uses
  classes, JsonObject;

type

  TErpSysInfo = class(TPersistent)
  private
    fLicense: TJsonObject;
//    FetLicenceStatus: string;
    function GetCompanyName: string;
    function GetDatabaseName: string;
    function GetSiteCode: string;
    function GetVersion: string;
    function GetUTCOffset: double;
    function GetModuleFileVersion: string;
    function GetDbUTCOffset: double;
    function GetMySQLUTCOffset: double;
    function GetServerID: string;
    function GetLicenceConcurrentUsers: integer;
    function GetLicenceExpireDate: TDateTime;
    function GetLicenceStartDate: TDateTime;
    function GetLicenceStatusReason: string;
    function GetLicenceStatus: string;
    function GetLicenceOptions: string;
//    function GetLicence: string;
  published
    property DatabaseName: string read GetDatabaseName;
    property CompanyName: string read GetCompanyName;
    property Version: string read GetVersion;
    property ModuleVersion: string read GetModuleFileVersion;
    property SiteCode: string read GetSiteCode;
    property UTCOffset: double read GetUTCOffset;
    property MySQLUTCOffset: double read GetMySQLUTCOffset;
    property DbUTCOffset: double read GetDbUTCOffset;
    property ServerID: string read GetServerID;

    property LicenceStartDate: TDateTime read GetLicenceStartDate;
    property LicenceExpireDate: TDateTime read GetLicenceExpireDate;
    property LicenceStatus: string read GetLicenceStatus;
    property LicenceStatusReason: string read GetLicenceStatusReason;
    property LicenceConcurrentUsers: integer read GetLicenceConcurrentUsers;
    property LicenceOptions: string read GetLicenceOptions;
  end;

implementation

uses
  AppEnvironment, AppDatabase, windows, SystemLib, ErpDbComponents, CommonDbLib,
  MachineSignature, FileVersion;

function GetModuleNameStr: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

{ TErpSysInfo }

function TErpSysInfo.GetCompanyName: string;
begin
  result:= AppEnv.CompanyInfo.Companyname;
end;

function TErpSysInfo.GetDatabaseName: string;
begin
  result:= AppEnv.AppDb.Database;
end;

function TErpSysInfo.GetDbUTCOffset: double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select TimeZone from tblUpdateDetails';
    qry.Open;
    result := qry.FieldByName('TimeZone').AsFloat;
  finally
    qry.Free;
  end;
end;

function TErpSysInfo.GetLicenceConcurrentUsers: integer;
begin
  if not Assigned(fLicense) then begin
    fLicense := JO;
    fLicense.AsString := AppEnv.UtilsClient.GetLicense('ERP').AsString;
  end;
  result := fLicense.I['ConcurrentUsers'];
end;

function TErpSysInfo.GetLicenceExpireDate: TDateTime;
begin
  if not Assigned(fLicense) then begin
    fLicense := JO;
    fLicense.AsString := AppEnv.UtilsClient.GetLicense('ERP').AsString;
  end;
  result := fLicense.DT['ExpireDate'];
end;

function TErpSysInfo.GetLicenceOptions: string;
var
  Data: TJsonObject;
begin
  if not Assigned(fLicense) then begin
    fLicense := JO;
    fLicense.AsString := AppEnv.UtilsClient.GetLicense('ERP').AsString;
  end;
  Data := JO(fLicense.S['DataText']);
  try
    Data.FormatOutput := false;
    result := Data.O['Options'].AsString;
  finally
    Data.Free;
  end;
end;

function TErpSysInfo.GetLicenceStartDate: TDateTime;
begin
  if not Assigned(fLicense) then begin
    fLicense := JO;
    fLicense.AsString := AppEnv.UtilsClient.GetLicense('ERP').AsString;
  end;
  result := fLicense.DT['StartDate'];
end;

function TErpSysInfo.GetLicenceStatus: string;
begin
  if not Assigned(fLicense) then begin
    fLicense := JO;
    fLicense.AsString := AppEnv.UtilsClient.GetLicense('ERP').AsString;
  end;
  result := fLicense.S['Status'];
end;

function TErpSysInfo.GetLicenceStatusReason: string;
begin
  if not Assigned(fLicense) then begin
    fLicense := JO;
    fLicense.AsString := AppEnv.UtilsClient.GetLicense('ERP').AsString;
  end;
  result := fLicense.S['StatusReason'];
end;

//function TErpSysInfo.GetLicence: string;
//begin
//  result := AppEnv.UtilsClient.GetLicense('ERP').AsString;
//  with JO do begin
//    AsString := result;
//    savetofile('c:\temp\temp.json');
//  end;
//end;

function TErpSysInfo.GetServerID: string;
begin
  result := MachineSignature.GetMacAddress;
  if result = '' then
    result := MachineSignature.GetPCName
end;

function TErpSysInfo.GetModuleFileVersion: string;
begin
  result:= FileVersion.GetFileVersion(GetModuleNameStr);
end;

function TErpSysInfo.GetMySQLUTCOffset: double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select Time_To_Sec(TimeDiff(current_timestamp(),utc_timestamp())) / (24*60*60) as TimeZone from Dual';
    qry.Open;
    result := qry.FieldByName('TimeZone').AsFloat;
  finally
    qry.Free;
  end;
end;

function TErpSysInfo.GetSiteCode: string;
begin
  result:= AppEnv.Branch.SiteCode;
end;

function TErpSysInfo.GetUTCOffset: double;
var
  TimeZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TimeZone);
  result:=  -TimeZone.Bias * (1/24/60);
end;

function TErpSysInfo.GetVersion: string;
begin
  result:= FileVersion.GetFileVersion;
end;

initialization
  Classes.RegisterClass(TErpSysInfo);

end.
