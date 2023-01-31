unit BusObjRoster;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  06/02/08  1.00.01  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusRosterBreaks;


type
  TRoster = class(TMSBusObj)
  private
    function GetPlannerID: string;
    function GetType: string;
    function GetEmployeeID: Integer;
    function GetClassID: Integer;
    function GetNotes: string;
    function GetDate: TDateTime;
    function GetStartTime: TDateTime;
    function GetEndTime: TDateTime;
    function GetClockedOff: Boolean;
    function GetStatus: string;
    function GetTimeStatus: string;
    function GetTypeCatagory: string;
    function GetHours: Double;
    function GetIsClocked: Boolean;

    procedure SetTimeStatus(const Value: string);
    procedure SetPlannerID(const Value: string);
    procedure SetType(const Value: string);
    procedure SetEmployeeID(const Value: Integer);
    procedure setClassID(const Value: Integer);
    procedure SetNotes(const Value: string);
    procedure SetDate(const Value: TDateTime);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetEndTime(const Value: TDateTime);
    procedure SetClockedOff(const Value: Boolean);
    procedure SetTypeCatagory(const Value: string);
    procedure SetHours(const Value: Double);
    procedure SetIsClocked(const Value: Boolean);
    function getTrainingModuleId: Integer;
    procedure setTrainingModuleId(const Value: Integer);
    function GetDeptClassName: string;
    function GetEmployeeName: string;
    procedure SetDeptClassName(const Value: string);
    procedure SetEmployeeName(const Value: string);
    function GetTrainingModuleGlobalRef: string;
    procedure SetTrainingModuleGlobalRef(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function PlannerIDIsUnique: boolean;
    class function _Schema: string; override;
  published
    property PlannerID: string read GetPlannerID write SetPlannerID;
    property RosterType: string read GetType write SetType;
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ClassID: Integer read GetClassID write setClassID;
    property DeptClassName: string read GetDeptClassName write SetDeptClassName;
    property Notes: string read GetNotes write SetNotes;
    property Date: TDateTime read GetDate write SetDate;
    property StartTime: TDateTime read GetStartTime write SetStartTime;
    property EndTime: TDateTime read GetEndTime write SetEndTime;
    property ClockedOff: Boolean read GetClockedOff write SetClockedOff;
    property Status: string read GetStatus;
    property TimeStatus: string read GetTimeStatus write SetTimeStatus;
    property TypeCatagory: string read GetTypeCatagory write SetTypeCatagory;
    property Hours: Double read GetHours write SetHours;
    property IsClocked: Boolean read GetIsClocked write SetIsClocked;
    property TrainingModuleID: Integer read getTrainingModuleId write setTrainingModuleId;
    property TrainingModuleGlobalRef: string read GetTrainingModuleGlobalRef write SetTrainingModuleGlobalRef;
  end;
  TClockedRoster = Class(TRoster)
  private
    function getCurrentRosterBreak: TCurrentRosterBreak;
    Protected
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
      function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
      Function DoBeforePost(Sender :TDatasetbusobj):Boolean ; override;
  published
    Public
      constructor Create(AOwner: TComponent); override;
      Property CurrentRosterBreak :TCurrentRosterBreak Read getCurrentRosterBreak;
  End;

  const
    rtClocked     = 'Clocked';
    rtAllocation  = 'Allocation';
    rtLeave       = 'Leave';
    rtOther       = 'Other';
    rtTraining    = 'Training' ;
    rtProcessStep = 'ProcessStep';
    rtBOMClocked  = 'BOMClocked';
implementation

uses CommonLib, BusObjEmployee, BusObjClass, BusObjSchemaLib, ERPDbComponents,
  SysUtils, BusobjTraining, AppEnvironment, dateutils;

{ Troster }

constructor TRoster.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'roster';
  fSQL := 'SELECT * FROM tblroster';
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('classid');
  ExportExcludeList.Add('trainingmoduleid');
end;

destructor TRoster.Destroy;
begin
  inherited;
end;

procedure TRoster.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PlannerID');
  SetPropertyFromNode(node, 'Type');
  SetPropertyFromNode(node, 'EmployeeID');
  SetPropertyFromNode(node, 'ClassID');
  SetPropertyFromNode(node, 'Notes');
  SetDateTimePropertyFromNode(node, 'Date'); // SetPropertyFromNode(node,'Date');
  SetDateTimePropertyFromNode(node, 'StartTime'); // SetPropertyFromNode(node,'StartTime');
  SetDateTimePropertyFromNode(node, 'EndTime'); // SetPropertyFromNode(node,'EndTime');
  SetBooleanPropertyFromnode(node, 'ClockedOff'); // SetPropertyFromNode(node,'ClockedOff');
  SetPropertyFromNode(node, 'TypeCatagory');
  SetPropertyFromNode(node, 'Hours');
  SetBooleanPropertyFromnode(node, 'IsClocked'); // SetPropertyFromNode(node,'IsClocked');
end;

procedure TRoster.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PlannerID', PlannerID);
  AddXMLNode(node, 'RosterType', RosterType);
  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'ClassID', ClassID);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Date', Date);
  AddXMLNode(node, 'StartTime', StartTime);
  AddXMLNode(node, 'EndTime', EndTime);
  AddXMLNode(node, 'ClockedOff', ClockedOff);
  AddXMLNode(node, 'TypeCatagory', TypeCatagory);
  AddXMLNode(node, 'Hours', Hours);
  AddXMLNode(node, 'IsClocked', IsClocked);
end;

function TRoster.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    AddResult(False, rssError, 0, 'Employee should not be blank');
    Exit;
  end;
  if EmployeeID < 0 then begin
    AddResult(False, rssError, 0, 'Linked Employee not found');
    Exit;
  end;
  if ClassID = 0 then begin
    AddResult(False, rssError, 0, 'Class/Department should not be blank');
    Exit;
  end;
  if ClassID < 0 then begin
    AddResult(False, rssError, 0, 'Linked Class/Department not found');
    Exit;
  end;
  if Date = 0 then begin
    AddResult(False, rssError, 0, 'Date should not be blank');
    Exit;
  end;
  if StartTime = 0 then begin
    AddResult(False, rssError, 0, 'StartTime should not be blank');
    Exit;
  end;
//  if EndTime = 0 then begin
//    AddResult(False, rssError, 0, 'EndTime should not be blank');
//    Exit;
//  end;
//  if Hours = 0 then begin
//    AddResult(False, rssError, 0, 'Hours should not be 0');
//    Exit;
//  end;
  if not PlannerIDIsUnique then begin
    AddResult(False, rssError, 0, 'PlannerID is not unique');
    Exit;
  end;
  if TrainingModuleID < 0 then begin
    AddResult(False, rssError, 0, 'Linked Training Module not found');
    Exit;
  end;
  Result := True;
end;

class function TRoster._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','ClassID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','ClassName','DeptClassName');
end;

function TRoster.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TRoster.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TRoster.PlannerIDIsUnique: boolean;
var
  qry: TERPQuery;
begin
  if ID < 1 then
    PostDB;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Self.Connection.Connection;
    qry.SQL.Add('select RosterID from tblRoster');
    qry.SQL.Add('where RosterID <> '  + IntToStr(ID));
    qry.SQL.Add('and PlannerID = ' + QuotedStr(PlannerID));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

procedure TRoster.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.fieldname, 'StartTime') or Sametext(Sender.fieldname, 'endtime') then begin
    if (Starttime <>0) and (Endtime<>0) then begin
      Hours := HourSpan(Endtime,Starttime);
      clockedOff := true;
    end;
  end;

end;

function TRoster.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRoster.GetIDField: string;
begin
  Result := 'RosterID'
end;

class function TRoster.GetBusObjectTablename: string;
begin
  Result := 'tblroster';
end;

function TRoster.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  clockedoff := False;
end;

function TRoster.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TRoster.GetPlannerID: string;
begin
  Result := GetStringField('PlannerID');
end;

function TRoster.GetType: string;
begin
  Result := GetStringField('Type');
end;

function TRoster.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TRoster.GetEmployeeName: string;
begin
  if EmployeeID > 0 then Result := TEmployee.IDToggle(EmployeeID, Connection.Connection)
  else Result := '';
end;

function TRoster.GetClassID: Integer;
begin
  Result := GetIntegerField('ClassID');
end;

function TRoster.GetDeptClassName: string;
begin
  if ClassID > 0 then Result := TDEptClass.IDToggle(ClassID, Connection.Connection)
  else Result := '';
end;

function TRoster.GetNotes: string;
begin
  Result := GetStringField('Notes');
end;

function TRoster.GetDate: TDateTime;
begin
  Result := GetDateTimeField('Date');
end;

function TRoster.GetStartTime: TDateTime;
begin
  Result := GetDateTimeField('StartTime');
end;

function TRoster.GetTrainingModuleGlobalRef: string;
begin
  if TrainingModuleID > 0 then
    result := TTrainingModules.IDGlobalRefToggle(TrainingModuleID, Connection.Connection)
  else
    result := '';
end;

function TRoster.GetEndTime: TDateTime;
begin
  Result := GetDateTimeField('EndTime');
end;

function TRoster.GetClockedOff: Boolean;
begin
  Result := GetBooleanField('ClockedOff');
end;

function TRoster.GetStatus: string;
begin
  if GetBooleanField('ClockedOff') then
    Result := 'Clocked-OFF'
  else
    Result := 'Clocked-ON';
end;

function TRoster.GetTimeStatus: string;
begin
  Result := GetStringField('TimeStatus');
end;

function TRoster.GetTypeCatagory: string;
begin
  Result := GetStringField('TypeCatagory');
end;

function TRoster.GetHours: Double;
begin
  Result := GetFloatField('Hours');
end;

function TRoster.GetIsClocked: Boolean;
begin
  Result := GetBooleanField('IsClocked');
end;

procedure TRoster.SetPlannerID(const Value: string);
begin
  SetStringField('PlannerID', Value);
end;

procedure TRoster.SetType(const Value: string);
begin
  SetStringField('Type', Value);
end;

procedure TRoster.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TRoster.SetEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    EmployeeID := TEmployee.IDToggle(Value, Connection.Connection);
    if EmployeeID = 0 then EmployeeID:= -1;
  end
  else EmployeeID := 0;
end;

procedure TRoster.setClassID(const Value: Integer);
begin
  SetIntegerField('ClassID', Value);
end;

procedure TRoster.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

procedure TRoster.SetDate(const Value: TDateTime);
begin
  SetDateTimeField('Date', Value);
end;

procedure TRoster.SetStartTime(const Value: TDateTime);
begin
  SetDateTimeField('StartTime', Value);
end;

procedure TRoster.SetTrainingModuleGlobalRef(const Value: string);
begin
  if Value <> '' then begin
    TrainingModuleID := TTrainingModules.IDGlobalRefToggle(Value, Connection.Connection);
    if TrainingModuleID = 0 then
      TrainingModuleID := -1;
  end
  else
    TrainingModuleID := 0;
end;

procedure TRoster.SetEndTime(const Value: TDateTime);
begin
  SetDateTimeField('EndTime', Value);
end;

procedure TRoster.SetDeptClassName(const Value: string);
begin
  if Value <> '' then begin
    ClassID := TDeptClass.IDToggle(Value, Connection.Connection);
    if ClassID = 0 then ClassID:= -1;
  end
  else ClassID := 0;
end;

procedure TRoster.SetClockedOff(const Value: Boolean);
begin
  SetBooleanField('ClockedOff', Value);
end;

procedure TRoster.SetTypeCatagory(const Value: string);
begin
  SetStringField('TypeCatagory', Value);
end;

procedure TRoster.SetTimeStatus(const Value: string);
begin
  SetStringField('TimeStatus', Value);
end;

procedure TRoster.SetHours(const Value: Double);
begin
  SetFloatField('Hours', Value);
end;

procedure TRoster.SetIsClocked(const Value: Boolean);
begin
  SetBooleanField('IsClocked', Value);
end;

function TRoster.getTrainingModuleId: Integer;
begin
  Result := GetIntegerField('TrainingModuleId');
end;

procedure TRoster.setTrainingModuleId(const Value: Integer);
begin
  SetIntegerField('TrainingModuleId', Value);
end;

{ TClockedRoster }

constructor TClockedRoster.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'roster';
  fSQL := 'SELECT * FROM tblroster Where Type = "Clocked"';
  NullWhenDateIs0           := False;
end;

function TClockedRoster.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  RosterType := rtAllocation;
  ClassId := AppEnv.DefaultClass.ClassId;
  endtime := 0;
  StartTime := now;
  IsClocked := True;
  //PlannerID := AppEnv.DefaultClass.DefaultClassName + FormatDateTime('yy:m:d:h:n:s:z', Now());
end;

function TClockedRoster.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(sender);
  if not result then exit;
end;

function TClockedRoster.DoBeforePost(Sender: TDatasetbusobj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  if (plannerId = '') and (StartTime<>0)  then
    PlannerID := AppEnv.DefaultClass.DefaultClassName + FormatDateTime('yy:m:d:h:n:s:z:', StartTime) ;
end;

function TClockedRoster.getCurrentRosterBreak: TCurrentRosterBreak;
begin
  Result := TCurrentRosterBreak(getContainercomponent(TCurrentRosterBreak, 'RosterId = ' + inttostr(ID)));
end;

initialization

RegisterClassOnce(TRoster);
RegisterClassOnce(TClockedRoster);

end.
