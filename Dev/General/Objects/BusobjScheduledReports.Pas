unit BusobjScheduledReports;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  04/11/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjEmployee;


type
  TReportSchedules = class(TMSBusObj)
  private
    function GetFormID              : Integer;
    function GetEmployeeId          : Integer;
    function GetStartDate           : TDateTime;
    function GetEndDate             : TDateTime;
    function GetFrequency           : String;
    function GetEvery               : Integer;
    function GetWeekDay             : Integer;
    function GetMonthDays           : Integer;
    function GetBeginFromOption     : String;
    function GetEmployeename        : String;
    function GetSatAction           : String;
    function GetSunAction           : String;
    function GetHolidayAction       : String;
    function GetContinueIndefinitely: Boolean;
    function GetActive              : Boolean;
    function GetNextDueDate         : TDateTime ;
    function GetLastEmaileddate     : TDateTime ;
    function GetBasedOnType         : String;
    function GetRecipients          : String;
    function GetFrequencyType       : String;
    function GetEmployeeEmail       : String;
    function GetEmployee            : TEmployee;
    function CalcNextdueDate        : TDatetime;

    procedure SetFormID              (const Value: Integer);
    procedure SetEmployeeId          (const Value: Integer);
    procedure SetStartDate           (const Value: TDateTime);
    procedure SetEndDate             (const Value: TDateTime);
    procedure SetFrequency           (const Value: String);
    procedure SetEvery               (const Value: Integer);
    procedure SetWeekDay             (const Value: Integer);
    procedure SetMonthDays           (const Value: Integer);
    procedure SetBeginFromOption     (const Value: String);
    Procedure SetEmployeename        (const Value: String);
    Procedure SetSatAction           (const Value: String);
    Procedure SetSunAction           (const Value: String);
    Procedure SetHolidayAction       (const Value: String);
    Procedure SetContinueIndefinitely(const Value: Boolean);
    Procedure SetActive              (const Value: Boolean);
    procedure SetNextDueDate         (const Value: TDateTime);
    procedure SetLastEmaileddate     (const Value: TDateTime);
    Procedure SetBasedOnType         (const Value: String);
    Procedure SetRecipients          (const Value: String);
    Procedure SetFrequencyType       (const Value: String);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor     Create(AOwner: TComponent);                            override;
    destructor      Destroy;                                               override;
    procedure       LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure       SaveToXMLNode(const node: IXMLNode);                   override;
    function        ValidateData: Boolean;                                override;
    function        Save: Boolean;                                        override;
    Function        ScheduleReportName: String;
    Property        Employee: TEmployee read GetEmployee;

  published
    property FormID               :Integer     read GetFormID               write SetFormID          ;
    property EmployeeID           :Integer     read GetEmployeeId           write SetEmployeeId      ;
    property StartDate            :TDateTime   read GetStartDate            write SetStartDate       ;
    property EndDate              :TDateTime   read GetEndDate              write SetEndDate         ;
    property Frequency            :String      read GetFrequency            write SetFrequency       ;
    property Every                :Integer     read GetEvery                write SetEvery           ;
    property WeekDay              :Integer     read GetWeekDay              write SetWeekDay         ;
    property MonthDays            :Integer     read GetMonthDays            write SetMonthDays         ;
    property BeginFromOption      :String      read GetBeginFromOption      write SetBeginFromOption ;
    property EmployeeName         :String      read GetEmployeename         write SetEmployeename;
    property SatAction            :String      read GetSatAction            write SetSatAction;
    property SunAction            :String      read GetSunAction            write SetSunAction;
    property HolidayAction        :String      read GetHolidayAction        write SetHolidayAction;
    property ContinueIndefinitely :Boolean     read GetContinueIndefinitely write SetContinueIndefinitely;
    property Active               :Boolean     read GetActive               write SetActive;
    property NextDueDate          :TDateTime   read GetNextDueDate          write SetNextDueDate       ;
    property LastEmailedDate      :TDateTime   read GetLastEmailedDate      write SetLastEmailedDate       ;
    Property EmployeeEmail        :String      read GetEmployeeEmail;
    property BasedOnType          :String      read GetBasedOnType          write SetBasedOnType;
    property Recipients           :String      read GetRecipients           write SetRecipients;
    property FrequencyType        :String      read GetFrequencyType        write SetFrequencyType;
  end;

  TERPForms = class(TMSBusObj)
  private
    function GetFormName              : string    ;
    function GetBusinessObjectName    : string    ;
    function GetDescription           : string    ;
    function GetTabGroup              : Integer   ;
    function GetIsForm                : Boolean   ;
    function GetAccessLevels          : Boolean   ;
    function GetSkinsGroup            : string    ;
    procedure SetFormName              (const Value: string    );
    procedure SetBusinessObjectName    (const Value: string    );
    procedure SetDescription           (const Value: string    );
    procedure SetTabGroup              (const Value: Integer   );
    procedure SetIsForm                (const Value: Boolean   );
    procedure SetAccessLevels          (const Value: Boolean   );
    procedure SetSkinsGroup            (const Value: string    );
    function getReportSchedules: TReportSchedules;
    function getScheduleforEmployee(fiEmployeeID: Integer): TReportSchedules;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property ScheduleforEmployee[fiEmployeeID:Integer]: TReportSchedules read getScheduleforEmployee; default;
  published
    property FormName               :string      read GetFormName             write SetFormName          ;
    property BusinessObjectName     :string      read GetBusinessObjectName   write SetBusinessObjectName;
    property Description            :string      read GetDescription          write SetDescription       ;
    property TabGroup               :Integer     read GetTabGroup             write SetTabGroup          ;
    property IsForm                 :Boolean     read GetIsForm               write SetIsForm            ;
    property AccessLevels           :Boolean     read GetAccessLevels         write SetAccessLevels      ;
    property SkinsGroup             :string      read GetSkinsGroup           write SetSkinsGroup        ;
    Property Schedules :TReportSchedules read getReportSchedules;
  end;

implementation


uses tcDataUtils, CommonLib, sysutils, BusObjConst, AppEnvironment;



  {TReportSchedules}

constructor TReportSchedules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ReportSchedules';
  fSQL := 'SELECT * FROM tblscheduledreports';
end;


destructor TReportSchedules.Destroy;
begin
  inherited;
end;

procedure TReportSchedules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'FormID');
  SetPropertyFromNode(node, 'EmployeeId');
  SetDateTimePropertyFromNode(node, 'StartDate');
  SetDateTimePropertyFromNode(node, 'EndDate');
  SetPropertyFromNode(node, 'Frequency');
  SetPropertyFromNode(node, 'Every');
  SetPropertyFromNode(node, 'WeekDay');
  SetPropertyFromNode(node, 'MonthDays');
  SetPropertyFromNode(node, 'BeginFromOption');
  SetPropertyFromNode(node, 'Employeename');
  SetPropertyFromNode(node, 'SatAction');
  SetPropertyFromNode(node, 'SunAction');
  SetPropertyFromNode(node, 'HolidayAction');
  SetBooleanPropertyFromNode(node, 'ContinueIndefinitely');
  SetBooleanPropertyFromNode(node, 'Active');
  SetDateTimePropertyFromNode(node, 'NextDueDate');
  SetDateTimePropertyFromNode(node, 'LastEmaileddate');

end;


procedure TReportSchedules.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormID', FormID);
  AddXMLNode(node,'EmployeeId', EmployeeId);
  AddXMLNode(node,'StartDate', StartDate);
  AddXMLNode(node,'EndDate', EndDate);
  AddXMLNode(node,'Frequency', Frequency);
  AddXMLNode(node,'Every', Every);
  AddXMLNode(node,'WeekDay', WeekDay);
  AddXMLNode(node,'MonthDays', MonthDays);
  AddXMLNode(node,'BeginFromOption', BeginFromOption);
  AddXMLNode(node,'Employeename', Employeename);
  AddXMLNode(node,'SatAction', SatAction);
  AddXMLNode(node,'SunAction', SunAction);
  AddXMLNode(node,'HolidayAction', HolidayAction);
  AddXMLNode(node,'ContinueIndefinitely', ContinueIndefinitely);
  AddXMLNode(node,'Active', Active);
  AddXMLNode(node,'NextDueDate', NextDueDate);
  AddXMLNode(node,'LastEmaileddate', LastEmaileddate);
end;


function TReportSchedules.ScheduleReportName: String;
begin
  Result := '';
  if formId = 0 then Exit;
  Result := tcDatautils.GetFormName(FormId);
end;

function TReportSchedules.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if FormID = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Please select a report' , True );
    Exit;
  end;

  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Please select an employee' , True );
    Exit;
  end;

  if StartDate = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Start Date should not be blank' , True );
    Exit;
  end;

  if Every = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Every should not be 0' , True );
    Exit;
  end;

  if not IsUnique(ID, 'EmployeeId = ' + inttostr(EmployeeId)+' and FormID= ' + inttostr(FormID)) then begin
    self.AddResult(false, rssWarning, 0, 'Schedule already exists for "' + EmployeeName + '"');
    Exit;
  end;

  Result := True;
end;


function TReportSchedules.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TReportSchedules.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TReportSchedules.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;

  if Sysutils.SameText(Sender.FieldName, 'EmployeeName') then begin
    EmployeeId := tcdatautils.getemployeeID(EmployeeName);
    if not IsUnique(ID, 'EmployeeId = ' + IntToStr(EmployeeId) + ' AND FormID= ' + IntToStr(FormID), Connection.Connection) then
    begin
      Self.AddResult(false, rssWarning, 0, 'Schedule already exists for "' + EmployeeName + '"');
      CancelDB;
      Exit;
    end;
    PostDB;
    EditDB;
  end else if Sysutils.SameText(Sender.FieldName, 'NextDueDate') then begin
    if NextDueDate > EndDate then
      if ContinueIndefinitely =False then
        Active := False;
  end else if Sysutils.SameText(Sender.FieldName, 'LastEmaileddate') then begin
    NextDueDate := CalcNextdueDate;
    DoFieldOnChange(Dataset.FindField('NextDueDate'));
  end;
end;

Function TReportSchedules.CalcNextdueDate:TDatetime;
begin
  with GetNewDataset('Select NextScheduleDueDate(ID) as NextDate from tblscheduledreports where Id = ' + inttostr(ID), true) do try
    REsult := Fieldbyname('NextDate').asDateTime;
  finally
    if active then close;
    Free;
  end;
end;

function TReportSchedules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TReportSchedules.GetIDField: string;
begin
  Result := 'ID'
end;

class function TReportSchedules.GetBusObjectTablename: string;
begin
  Result := 'tblscheduledreports';
end;

function TReportSchedules.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  if Assigned(Owner) then
    if Owner is TERPForms then
      FormID := TERPForms(Owner).ID;
  Startdate := Date;
  EndDate := IncMonth(StartDate, 1);
  Frequency := 'W';
  Every := 1;
  Sendevent(BusObjEvent_Dataset, BusObjEvent_AfterInsert, Self);
end;

function TReportSchedules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;

  if EmployeeID = 0 then begin
    Delete;
  end;
end;


function TReportSchedules.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
end;

{Property Functions}
function  TReportSchedules.GetFormID              : Integer   ; begin Result := GetIntegerField('FormID');end;
function  TReportSchedules.GetEmployeeId          : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TReportSchedules.GetStartDate           : TDateTime ; begin Result := GetDateTimeField('StartDate');end;
function  TReportSchedules.GetEndDate             : TDateTime ; begin Result := GetDateTimeField('EndDate');end;
function  TReportSchedules.GetFrequency           : String    ; begin Result := GetStringField('Frequency');end;
function  TReportSchedules.GetEvery               : Integer   ; begin Result := GetIntegerField('Every');end;
function  TReportSchedules.GetWeekDay             : Integer   ; begin Result := GetIntegerField('WeekDay');end;
function  TReportSchedules.GetMonthDays           : Integer   ; begin Result := GetIntegerField('MonthDays');end;
function  TReportSchedules.GetBeginFromOption     : String    ; begin Result := GetStringField('BeginFromOption');end;
function  TReportSchedules.GetEmployeeName        : String    ; begin Result := GetStringField('Employeename');end;
function  TReportSchedules.GetSatAction           : String    ; begin Result := GetStringField('SatAction');end;
function  TReportSchedules.GetSunAction           : String    ; begin Result := GetStringField('SunAction');end;
function  TReportSchedules.GetHolidayAction       : String    ; begin Result := GetStringField('HolidayAction');end;
function  TReportSchedules.GetContinueIndefinitely: Boolean    ; begin Result := GetBooleanField('ContinueIndefinitely');end;
function  TReportSchedules.GetActive              : Boolean    ; begin Result := GetBooleanField('Active');end;
function  TReportSchedules.GetNextDueDate         : TDateTime ; begin Result := GetDateTimeField('NextDueDate');end;
function  TReportSchedules.GetLastEmaileddate     : TDateTime ; begin Result := GetDateTimeField('LastEmaileddate');end;
function  TReportSchedules.GetBasedOnType         : String    ; begin Result := GetStringField('BasedOnType');end;
function  TReportSchedules.GetRecipients          : String    ; begin Result := GetStringField('Recipients');end;
function  TReportSchedules.GetFrequencyType       : String    ; begin Result := GetStringField('FrequencyType');end;

procedure TReportSchedules.SetFormID                (const Value: Integer   ); begin SetIntegerField('FormID'           , Value);end;
procedure TReportSchedules.SetEmployeeId            (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TReportSchedules.SetStartDate             (const Value: TDateTime ); begin SetDateTimeField('StartDate'        , Value);end;
procedure TReportSchedules.SetEndDate               (const Value: TDateTime ); begin SetDateTimeField('EndDate'          , Value);end;
procedure TReportSchedules.SetFrequency             (const Value: String    ); begin SetStringField('Frequency'       , Value);end;
procedure TReportSchedules.SetEvery                 (const Value: Integer   ); begin SetIntegerField('Every'            , Value);end;
procedure TReportSchedules.SetWeekDay               (const Value: Integer   ); begin SetIntegerField('WeekDay'          , Value);end;
procedure TReportSchedules.SetMonthDays             (const Value: Integer   ); begin SetIntegerField('MonthDays'          , Value);end;
procedure TReportSchedules.SetBeginFromOption       (const Value: String    ); begin SetStringField('BeginFromOption' , Value);end;
procedure TReportSchedules.SetEmployeeName          (const Value: String    ); begin SetStringField('Employeename'     , Value);end;
procedure TReportSchedules.SetSatAction             (const Value: String    ); begin SetStringField('SatAction'     , Value);end;
procedure TReportSchedules.SetSunAction             (const Value: String    ); begin SetStringField('SunAction'     , Value);end;
procedure TReportSchedules.SetHolidayAction         (const Value: String    ); begin SetStringField('HolidayAction'     , Value);end;
procedure TReportSchedules.SetContinueIndefinitely  (const Value: Boolean   ); begin SetBooleanField('ContinueIndefinitely'     , Value);end;
procedure TReportSchedules.SetActive                (const Value: Boolean   ); begin SetBooleanField('Active'     , Value);end;
procedure TReportSchedules.SetNextDueDate           (const Value: TDateTime ); begin SetDateTimeField('NextDueDate'        , Value);end;
procedure TReportSchedules.SetLastEmaileddate       (const Value: TDateTime ); begin SetDateTimeField('LastEmaileddate'        , Value);end;
procedure TReportSchedules.SetBasedOnType           (const Value: String    ); begin SetStringField('BasedOnType'     , Value);end;
procedure TReportSchedules.SetRecipients            (const Value: String    ); begin SetStringField('Recipients'     , Value);end;
procedure TReportSchedules.SetFrequencyType         (const Value: String    ); begin SetStringField('FrequencyType'     , Value);end;

function TReportSchedules.GetEmployee: TEmployee;
begin
  Result := TEmployee(getContainerComponent(TEmployee, 'EmployeeID = ' + IntToStr(EmployeeID)));
end;

function TReportSchedules.GetEmployeeEmail: String;
begin
  Result := '';
  if EmployeeId = 0 then Exit;
  if Employee.EmailsFromEmployeeAddress and (Trim(Employee.Email) <> '') then Result := Employee.Email
  Else Result := Appenv.Companyinfo.ContactEmail;
end;


  {TERPForms}

constructor TERPForms.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Report Scheduling';
  fSQL := 'SELECT * FROM tblforms';
end;


destructor TERPForms.Destroy;
begin
  inherited;
end;


procedure TERPForms.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormName');
  SetPropertyFromNode(node,'BusinessObjectName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'TabGroup');
  SetBooleanPropertyFromNode(node,'IsForm');
  SetBooleanPropertyFromNode(node,'AccessLevels');
  SetPropertyFromNode(node,'SkinsGroup');
end;


procedure TERPForms.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormName' ,FormName);
  AddXMLNode(node,'BusinessObjectName' ,BusinessObjectName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'TabGroup' ,TabGroup);
  AddXMLNode(node,'IsForm' ,IsForm);
  AddXMLNode(node,'AccessLevels' ,AccessLevels);
  AddXMLNode(node,'SkinsGroup' ,SkinsGroup);
end;


function TERPForms.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TERPForms.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TERPForms.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TERPForms.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TERPForms.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TERPForms.GetIDField: string;
begin
  Result := 'FormID'
end;


class function TERPForms.GetBusObjectTablename: string;
begin
  Result:= 'tblforms';
end;


function TERPForms.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TERPForms.GetFormName          : string    ; begin Result := GetStringField('FormName');end;
function  TERPForms.GetBusinessObjectName: string    ; begin Result := GetStringField('BusinessObjectName');end;
function  TERPForms.GetDescription       : string    ; begin Result := GetStringField('Description');end;
function  TERPForms.GetTabGroup          : Integer   ; begin Result := GetIntegerField('TabGroup');end;
function  TERPForms.GetIsForm            : Boolean   ; begin Result := GetBooleanField('IsForm');end;
function TERPForms.getReportSchedules: TReportSchedules;
begin
  result := TReportSchedules(getContainerComponent(TReportSchedules, 'FormID = ' + inttostr(ID)));
end;

function TERPForms.getScheduleforEmployee(fiEmployeeID: Integer): TReportSchedules;
begin
  result := TReportSchedules(getContainerComponent(TReportSchedules, 'FormID = ' + inttostr(ID)+' and EmployeeId = ' +inttostr(fiEmployeeID)));
end;


function  TERPForms.GetAccessLevels      : Boolean   ; begin Result := GetBooleanField('AccessLevels');end;
function  TERPForms.GetSkinsGroup        : string    ; begin Result := GetStringField('SkinsGroup');end;
procedure TERPForms.SetFormName          (const Value: string    ); begin SetStringField('FormName'           , Value);end;
procedure TERPForms.SetBusinessObjectName(const Value: string    ); begin SetStringField('BusinessObjectName' , Value);end;
procedure TERPForms.SetDescription       (const Value: string    ); begin SetStringField('Description'        , Value);end;
procedure TERPForms.SetTabGroup          (const Value: Integer   ); begin SetIntegerField('TabGroup'           , Value);end;
procedure TERPForms.SetIsForm            (const Value: Boolean   ); begin SetBooleanField('IsForm'             , Value);end;
procedure TERPForms.SetAccessLevels      (const Value: Boolean   ); begin SetBooleanField('AccessLevels'       , Value);end;
procedure TERPForms.SetSkinsGroup        (const Value: string    ); begin SetStringField('SkinsGroup'         , Value);end;

initialization
  RegisterClass(TReportSchedules);
  RegisterClass(TERPForms);


end.
