unit BusObjAudit;

{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/11/05  1.00.00 IJB  Initial version.
}

interface

uses BusObjBase, Classes, MyAccess, ERPdbComponents, AuditTrailPurgeObj;

type

  TAuditLines = class(TMSBusObj)
  private
    function GetAuditID: Integer;
    function getSeqno: Integer;
    function GetDescription: string;
    function GetfieldName: string;
    function GetOldValue: string;
    function GetNewValue: string;
    procedure SetAuditID(const Value: Integer);
    procedure SetDescription(const Value: string);
    procedure SetfieldName(const Value: string);
    procedure SetOldValue(const Value: string);
    procedure SetNewValue(const Value: string);
    procedure SetSeqno(const Value: Integer);
  protected
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property AuditID: Integer read GetAuditID write SetAuditID;
    property Seqno: Integer read getSeqno write SetSeqno;
    property Description: string read GetDescription write SetDescription;
    property fieldName: string read GetfieldName write SetfieldName;
    property OldValue: string read GetOldValue write SetOldValue;
    property NewValue: string read GetNewValue write SetNewValue;
  end;

  TAudit = class(TMSBusObj)
  private
    fAuditTrailPurge: TAuditTrailPurge;
    function AuditTrailPurge: TAuditTrailPurge;
    function GetAuditDate: TDateTime;
    function GetAuditID: Integer;
    function GetChangeDescription: string;
    function GetEmployeeID: Integer;
    procedure SetAuditDate(const Value: TDateTime);
    procedure SetChangeDescription(const Value: string);
    procedure SetEmployeeID(const Value: Integer);
    function GetDataDescription: string;
    procedure SetDataDescription(const Value: string);
    function GetTransType: string;
    procedure SetTransType(const Value: string);
    function getTransGlobalref: string;
    procedure SetTansGlobalref(const Value: string);
    function getapplicationVersion: string;
    procedure setapplicationVersion(const Value: string);
    function getLines: TAuditLines;
    function GetProcessActive: boolean;
    procedure SetProcessActive(const Value: boolean);
    function GetCurrentProcess: string;
    function GetRecordNumber: integer;
    function GetRecordCount: integer;
    function GetOnExportProgres: TNotifyEvent;
    procedure SetOnExportProgres(const Value: TNotifyEvent);
  protected
    procedure InitializeNewObject; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure New; override;
    function GetId: Integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    property AuditID: Integer read GetAuditID;
    function Save: Boolean; override;
    class procedure AddEntry(DataDescription: string; TransGlobalRef, ChangeDescription: string; diffList: TStringlist; TransType: string; Connection: TERPConnection; ISNewRec :Boolean);
    property Lines: TAuditLines read getLines;
    procedure LogDetails(sl: TStringlist);
    property OnExportProgres: TNotifyEvent read GetOnExportProgres write SetOnExportProgres;
    function ExportData(const DtFrom, dtTo: TDateTime; FileName: string; var msg: string): boolean;
    function PurgeData(const DtFrom, dtTo: TDateTime; var msg: string): boolean;
    property RecordCount: integer read GetRecordCount;
    property RecordNumber: integer read GetRecordNumber;
    property CurrentProcess: string read GetCurrentProcess;
    property ProcessActive : boolean read GetProcessActive write SetProcessActive;
  published
    property TransGlobalRef: string read getTransGlobalref write SetTansGlobalref;
    property TransType: string read GetTransType write SetTransType;
    property DataDescription: string read GetDataDescription write SetDataDescription;
    property AuditDate: TDateTime read GetAuditDate write SetAuditDate;
    property applicationVersion: string read getapplicationVersion write setapplicationVersion;
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property ChangeDescription: string read GetChangeDescription write SetChangeDescription;
  end;

implementation

uses AppEnvironment, sysutils, BusobjBranch, AppDatabase, StrUtils, tcConst,
  CommonLib, CommonDbLib, FileVersion;

{ TAudit }

function TAudit.AuditTrailPurge: TAuditTrailPurge;
begin
  if not Assigned(fAuditTrailPurge) then begin
    fAuditTrailPurge := TAuditTrailPurge.Create(nil);
    fAuditTrailPurge.Connection := CommonDbLib.GetNewMyDacConnection(fAuditTrailPurge);
  end;
  result := fAuditTrailPurge;
end;

constructor TAudit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblAuditTrail';
  LogChangesOnSave := False; // don;t remove it as the Save will go into an infinite loop
end;

destructor TAudit.Destroy;
begin
  //AuditTrailPurge.Connection.Free;
  fAuditTrailPurge.Free;
  inherited;
end;

procedure TAudit.InitializeNewObject;
begin
  inherited;
  EmployeeID := AppEnv.Employee.EmployeeID;
end;

procedure TAudit.LogDetails(sl: TStringlist);
var
  ctr: Integer;
  s: string;
  sDescription: string;
  sfieldName: string;
  sOldValue: string;
  sNewValue: string;
  fiSeqno: Integer;
begin
  PostDB;
  Lines.DeleteAll;
  fiSeqno := 0;
  for ctr := 0 to sl.count - 1 do begin
    s := sl[ctr];
    if s = '' then continue;
    fiSeqno := fiSeqno + 1;
    if (pos(AuditTrialOldValue, s) = 0) and (pos(AuditTrialNewValue, s) = 0) then begin
      sDescription := s;
      continue;
    end else begin
      if pos('Record No = ', s) <> 0 then begin
        sDescription := sDescription + ' ' + copy(s, 1, pos(',', s) - 1);
        s := copy(s, pos(',', s) + 1, Length(s));
      end;
      sfieldName := copy(s, 1, pos(AuditTrialOldValue, s) - 1);
      s := replacestr(s, sfieldName, '');
      s := replacestr(s, trim(AuditTrialOldValue), '');
      sOldValue := trim(copy(s, 1, pos(AuditTrialNewValue, s) - 1));
      s := replacestr(s, sOldValue, '');
      s := replacestr(s, trim(AuditTrialNewValue), '');
      s := copy(s, 1, Length(s) - 1); // trim the last ; off
      sNewValue := trim(s);
    end;
    Lines.New;
    Lines.AuditID := Self.id;
    Lines.Description := sDescription;
    Lines.fieldName := sfieldName;
    Lines.OldValue := sOldValue;
    Lines.NewValue := sNewValue;
    Lines.Seqno := fiSeqno;
    Lines.PostDB;

    sDescription := '';
    sfieldName := '';
    sOldValue := '';
    sNewValue := '';
  end;
end;

procedure TAudit.New;
begin
  inherited;
  InitializeNewObject;
end;

function TAudit.GetAuditDate: TDateTime;
begin
  Result := GetDateTimeField('AuditDate');
end;

function TAudit.GetAuditID: Integer;
begin
  Result := GetIntegerField('AuditID');
end;

function TAudit.GetChangeDescription: string;
begin
  Result := GetStringField('ChangedFields');
end;

function TAudit.GetCurrentProcess: string;
begin
  result := AuditTrailPurge.CurrentProcess;
end;

function TAudit.GetDataDescription: string;
begin
  Result := GetStringField('DataDescription');
end;

function TAudit.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TAudit.GetId: Integer;
begin
  Result := AuditID;
end;

class function TAudit.GetIDField: string;
begin
  Result := 'AuditID';
end;

class function TAudit.GetBusObjectTablename: string;
begin
  Result := 'tblAuditTrail';
end;

procedure TAudit.SetAuditDate(const Value: TDateTime);
begin
  SetDateTimeField('AuditDate', Value);
end;

procedure TAudit.SetChangeDescription(const Value: string);
begin
  SetStringField('ChangedFields', Value);
end;

procedure TAudit.SetDataDescription(const Value: string);
begin
  SetStringField('DataDescription', Value);
end;

procedure TAudit.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TAudit.SetOnExportProgres(const Value: TNotifyEvent);
begin
  AuditTrailPurge.OnExportProgres := Value;
end;

procedure TAudit.SetProcessActive(const Value: boolean);
begin
  AuditTrailPurge.ProcessActive := Value;
end;

function TAudit.GetTransType: string;
begin
  Result := GetStringField('TransType');
end;

procedure TAudit.SetTransType(const Value: string);
begin
  SetStringField('TransType', Value);
end;

function TAudit.Save: Boolean;
begin
  Result := inherited Save;
  if not Result then exit;
  PostDB;
end;

function TAudit.getLines: TAuditLines;
begin
  Result := TAuditLines(Getcontainercomponent(TAuditLines, 'AuditId  = ' + inttostr(id)));
end;

function TAudit.GetOnExportProgres: TNotifyEvent;
begin
  result := AuditTrailPurge.OnExportProgres;
end;

function TAudit.GetProcessActive: boolean;
begin
  result := AuditTrailPurge.ProcessActive;
end;

function TAudit.GetRecordCount: integer;
begin
  result := AuditTrailPurge.RecordCount;
end;

function TAudit.GetRecordNumber: integer;
begin
  result := AuditTrailPurge.RecordNumber;
end;

function TAudit.getTransGlobalref: string;
begin
  Result := GetStringField('TransGlobalref');
end;

procedure TAudit.SetTansGlobalref(const Value: string);
begin
  SetStringField('TransGlobalref', Value);
end;

class procedure TAudit.AddEntry(DataDescription: string; TransGlobalRef, ChangeDescription: string; diffList: TStringlist; TransType: string; Connection: TERPConnection; ISNewRec :Boolean);
var
  inst: TAudit;
begin
  inst := TAudit.Create(nil);
  try
    if Assigned(Connection) then begin
      inst.Connection := TMyDacDataConnection.Create(inst);
      inst.Connection.Connection := Connection;
    end;
    inst.Load(0);
    inst.New;
    inst.DataDescription := DataDescription;
    inst.TransGlobalRef := TransGlobalRef;
    inst.ChangeDescription := ChangeDescription; // LeftStr(ChangeDescription,255);
    if ISNewRec then TransType := 'New ' + TransType  else TransType := TransType +' Update';
    inst.TransType := TransType;
    inst.AuditDate := now;
    if diffList <> nil then inst.LogDetails(diffList);
    inst.Save;
  finally inst.Free;
  end;
end;

function TAudit.getapplicationVersion: string;
begin
  Result := GetStringField('applicationVersion');
end;

procedure TAudit.setapplicationVersion(const Value: string);
begin
  SetStringField('applicationVersion', Value);
end;

function TAudit.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  applicationVersion := FileVersion.GetFileVersion;
end;

function TAudit.ExportData(const DtFrom, DtTo: TDateTime; FileName: string;
  var msg: string): boolean;
begin
  result := AuditTrailPurge.ExportData(DtFrom,DtTo,FileName,msg);
end;

function TAudit.PurgeData(const DtFrom, dtTo: TDateTime;
  var msg: string): boolean;
begin
  result := AuditTrailPurge.PurgeData(DtFrom,DtTo,msg);
end;

{ TAuditTrialLines }

constructor TAuditLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'AuditLines';
  fSql := 'SELECT * FROM tblaudittriallines';
end;

destructor TAuditLines.Destroy;
begin
  inherited;
end;

function TAuditLines.ValidateData: Boolean;
begin
  Result := True;
end;

function TAuditLines.Save: Boolean;
begin
  Result := False;
  if not ValidateData then exit;
  Result := inherited Save;
end;

function TAuditLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TAuditLines.GetIDField: string;
begin
  Result := 'ID'
end;

class function TAuditLines.GetBusObjectTablename: string;
begin
  Result := 'tblaudittriallines';
end;

function TAuditLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TAudit then AuditID := TAudit(Self.Owner).id;
end;

function TAuditLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TAuditLines.GetAuditID: Integer;
begin
  Result := GetIntegerField('AuditID');
end;

function TAuditLines.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TAuditLines.GetfieldName: string;
begin
  Result := GetStringField('fieldName');
end;

function TAuditLines.GetOldValue: string;
begin
  Result := GetStringField('OldValue');
end;

function TAuditLines.getSeqno: Integer;
begin
  Result := GetIntegerField('Seqno');
end;

function TAuditLines.GetNewValue: string;
begin
  Result := GetStringField('NewValue');
end;

procedure TAuditLines.SetAuditID(const Value: Integer);
begin
  SetIntegerField('AuditID', Value);
end;

procedure TAuditLines.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TAuditLines.SetfieldName(const Value: string);
begin
  SetStringField('fieldName', Value);
end;

procedure TAuditLines.SetOldValue(const Value: string);
begin
  SetStringField('OldValue', Value);
end;

procedure TAuditLines.SetSeqno(const Value: Integer);
begin
  SetIntegerField('Seqno', Value);
end;

procedure TAuditLines.SetNewValue(const Value: string);
begin
  SetStringField('NewValue', Value);
end;

end.

