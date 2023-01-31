unit busobjPhoneSupportLog;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  05/09/11  1.00.00  A.  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLIntf, BusObjToDo , BusObjSimpleTypes,
  BusObjAttachment;


type

  TPhoneSupportLogLines = class(TMSBusObj)
  private
    function GetSupportID           : Integer   ;
    function GetDate                : TDateTime ;
    function GetEmployeeID          : Integer   ;
    function GetEmployeeName        : string    ;
    function GetComments            : string    ;
    function GetAssignToID          : Integer   ;
    function GetAssignTo            : string    ;
    function getDeleted             : Boolean;
    function getIsFollowupCall      : Boolean;
    function getActive              : Boolean;
    procedure SetSupportID           (const Value: Integer   );
    procedure SetDate                (const Value: TDateTime );
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetComments            (const Value: string    );
    procedure SetAssignToID          (const Value: Integer   );
    procedure SetAssignTo            (const Value: string    );
    procedure setDeleted             (const Value: Boolean);
    procedure setIsFollowupCall      (const Value: Boolean);
    procedure setActive              (const Value: Boolean);
    function getCustomField1: String;
    function getCustomField2: String;
    function getCustomField3: String;
    function getCustomField4: String;
    function getCustomField5: String;
    function getCustomField6: String;
    function getCustomField7: String;
    function getCustomField8: String;
    function getCustomField9: String;
    function getCustomField10: String;
    procedure SetCustomField1(const Value: String);
    procedure SetCustomField2(const Value: String);
    procedure SetCustomField3(const Value: String);
    procedure SetCustomField4(const Value: String);
    procedure SetCustomField5(const Value: String);
    procedure SetCustomField6(const Value: String);
    procedure SetCustomField7(const Value: String);
    procedure SetCustomField8(const Value: String);
    procedure SetCustomField9(const Value: String);
    procedure SetCustomField10(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property SupportID            :Integer     read GetSupportID          write SetSupportID       ;
    property LinesDate            :TDateTime   read GetDate               write SetDate            ;
    property EmployeeID           :Integer     read GetEmployeeID         write SetEmployeeID      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    property Comments             :string      read GetComments           write SetComments        ;
    property AssignToID           :Integer     read GetAssignToID         write SetAssignToID      ;
    property SupportAssignTo      :string      read GetAssignTo           write SetAssignTo        ;
    Property Deleted              :Boolean     read getDeleted            write setDeleted         ;
    Property IsFollowupCall       :Boolean     read getIsFollowupCall     write setIsFollowupCall  ;
    Property Active               :Boolean     read getActive             write setActive         ;
    Property CustomField1         :String      read getCustomField1       Write SetCustomField1   ;
    Property CustomField2         :String      read getCustomField2       Write SetCustomField2   ;
    Property CustomField3         :String      read getCustomField3       Write SetCustomField3   ;
    Property CustomField4         :String      read getCustomField4       Write SetCustomField4   ;
    Property CustomField5         :String      read getCustomField5       Write SetCustomField5   ;
    Property CustomField6         :String      read getCustomField6       Write SetCustomField6   ;
    Property CustomField7         :String      read getCustomField7       Write SetCustomField7   ;
    Property CustomField8         :String      read getCustomField8       Write SetCustomField8   ;
    Property CustomField9         :String      read getCustomField9       Write SetCustomField9   ;
    Property CustomField10        :String      read getCustomField10      Write SetCustomField10  ;
  end;


  TPhoneSupportLog = class(TMSBusObj)
  private
    fitoDoemployeeID:Integer;
    fsComments :String;
    fbCompleteToDo :Boolean;
    function GetClientID          : Integer   ;
    function GetCompany           : string    ;
    function GetContact           : string    ;
    function GetEmployeeID        : Integer   ;
    function GetDateCreated       : TDateTime ;
    function GetForm              : string    ;
    function GetIssue             : string    ;
    function GetType              : string    ;
    function GetSolution          : string    ;
    function GetCallSecs          : Integer   ;
    function GetCallTime          : string    ;
    function GetFinished          : Boolean   ;
    function GetActive            : Boolean   ;
    function GetContactID         : Integer   ;
    function GetVersion           : string    ;
    function GetStatus            : string    ;
    function GetToEmployeeID      : Integer   ;
    function GetFromEmployeeID    : Integer   ;
    function GetFromDate          : TDateTime ;
    procedure SetClientID          (const Value: Integer   );
    procedure SetCompany           (const Value: string    );
    procedure SetContact           (const Value: string    );
    procedure SetEmployeeID        (const Value: Integer   );
    procedure SetDateCreated       (const Value: TDateTime );
    procedure SetForm              (const Value: string    );
    procedure SetIssue             (const Value: string    );
    procedure SetType              (const Value: string    );
    procedure SetSolution          (const Value: string    );
    procedure SetCallSecs          (const Value: Integer   );
    procedure SetCallTime          (const Value: string    );
    procedure SetFinished          (const Value: Boolean   );
    procedure SetActive            (const Value: Boolean   );
    procedure SetContactID         (const Value: Integer   );
    procedure SetVersion           (const Value: string    );
    procedure SetStatus            (const Value: string    );
    procedure SetToEmployeeID      (const Value: Integer   );
    procedure SetFromEmployeeID    (const Value: Integer   );
    procedure SetFromDate          (const Value: TDateTime );
    function getTToDo: TToDo;
    function GetEmployeeName: string;
    function GetFromEmployeeName: string;
    function GetToEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    procedure SetFromEmployeeName(const Value: string);
    procedure SetToEmployeeName(const Value: string);
    function getLines: TPhoneSupportLogLines;
    function getComments: String;
    Procedure getCommentsCallback(Const Sender: TBusObj; var Abort: boolean);
    function getPhsupportStatus: TPhsupportStatus;
    function GetTaskId: integer;
    procedure SetTaskId(const Value: integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure CompleteToDoCallback(Const Sender: TBusObj; var Abort: boolean);
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure Addtodo;
    Function CompleteToDo(toDoemployeeID:Integer):Boolean;
    class function _Schema: string; override;
    Property Comments :String read getComments;
    Property PhsupportStatus : TPhsupportStatus read getPhsupportStatus;
  published
    property ToDoObj: TToDo read GetTToDo;
    property ClientID           :Integer     read GetClientID         write SetClientID      ;
    property Company            :string      read GetCompany          write SetCompany       ;
    property Contact            :string      read GetContact          write SetContact       ;
    property EmployeeID         :Integer     read GetEmployeeID       write SetEmployeeID    ;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property DateCreated        :TDateTime   read GetDateCreated      write SetDateCreated   ;
    property Module               :string      read GetForm             write SetForm          ;
    property Issue              :string      read GetIssue            write SetIssue         ;
    property SupportType   :string      read GetType             write SetType          ;
    property Solution           :string      read GetSolution         write SetSolution      ;
    property CallSecs           :Integer     read GetCallSecs         write SetCallSecs      ;
    property CallTime           :string      read GetCallTime         write SetCallTime      ;
    property Finished           :Boolean     read GetFinished         write SetFinished      ;
    property Active             :Boolean     read GetActive           write SetActive        ;
    property ContactID          :Integer     read GetContactID        write SetContactID     ;
    property Version            :string      read GetVersion          write SetVersion       ;
    property Status             :string      read GetStatus           write SetStatus        ;
    property ToEmployeeID       :Integer     read GetToEmployeeID     write SetToEmployeeID  ;
    property ToEmployeeName: string read GetToEmployeeName write SetToEmployeeName;
    property FromEmployeeID     :Integer     read GetFromEmployeeID   write SetFromEmployeeID;
    property FromEmployeeName: string read GetFromEmployeeName write SetFromEmployeeName;
    property FromDate           :TDateTime   read GetFromDate         write SetFromDate      ;
    property TaskId : integer read GetTaskId write SetTaskId;
    Property Lines : TPhoneSupportLogLines read getLines;
  end;

  TPhoneSupportLogEx = class(TPhoneSupportLog)
  private
    function Getattachments: TAttachment;
  published
    property Attachments: TAttachment read Getattachments;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, AppEnvironment, BusObjEmployee,
  BusObjSchemaLib, BusObjClient, BusObjectListObj,
  ERPdbComponents, AppEnvVirtualObj, BusObjConst, CommonDbLib;



  {TPhoneSupportLog}

procedure TPhoneSupportLog.Addtodo;
begin
  PostDB;
  ToDoobj.New;
  ToDoobj.Todotype := 'Support';
  ToDoobj.OtherID :=  Id;
  ToDoobj.CreatedDate :=  Now;
  ToDoobj.EmployeeID :=  ToEmployeeID; //  EmployeeID;
  if contact <> '' then ToDoobj.Description :=  company +' (' +contact+')'
    else ToDoobj.Description :=  company ;
  ToDoobj.ToDoByDate := Now;
  ToDoobj.CreatedByEmployeeID := AppEnv.Employee.EmployeeID;
  ToDoObj.MsUpdateSiteCode:= AppEnv.Branch.SiteCode;
  ToDoobj.PostDB;
end;

Function  TPhoneSupportLog.CompleteToDo(toDoemployeeID:Integer):Boolean ;
begin
  fitoDoemployeeID := toDoemployeeID;
  fbCompleteToDo:= False;
  TodoObj.Iteraterecords(CompleteToDoCallback);
  REsult := fbCompleteToDo;
end;

procedure TPhoneSupportLog.CompleteToDoCallback(const Sender: TBusObj;  var Abort: boolean);
begin
  if not(Sender is TTodo) then exit;
  {Todo is completed for all employees - Dene/Ian}
  if (*(TTodo(sender).employeeId = fitoDoemployeeID) and*) (TTodo(sender).Completed = False) then begin
    TTodo(sender).Completed:= True;
    TTodo(sender).PostDB;
    fbCompleteToDo := True;
    Abort := True;
  end;
end;

constructor TPhoneSupportLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PhoneSupportLog';
  fSQL := 'SELECT * FROM tblphonesupportlog';
end;


destructor TPhoneSupportLog.Destroy;
begin
  inherited;
end;


procedure TPhoneSupportLog.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'Company');
  SetPropertyFromNode(node,'Contact');
  SetPropertyFromNode(node,'EmployeeID');
  SetDateTimePropertyFromNode(node,'DateCreated');
  SetPropertyFromNode(node,'Module');
  SetPropertyFromNode(node,'Issue');
  SetPropertyFromNode(node,'SupportType');
  SetPropertyFromNode(node,'Solution');
  SetPropertyFromNode(node,'CallSecs');
  SetPropertyFromNode(node,'CallTime');
  SetBooleanPropertyFromNode(node,'Finished');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'ContactID');
  SetPropertyFromNode(node,'Version');
  SetPropertyFromNode(node,'Status');
  SetPropertyFromNode(node,'ToEmployeeID');
  SetPropertyFromNode(node,'FromEmployeeID');
  SetDateTimePropertyFromNode(node,'FromDate');
end;


procedure TPhoneSupportLog.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'Company' ,Company);
  AddXMLNode(node,'Contact' ,Contact);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'DateCreated' ,DateCreated);
  AddXMLNode(node,'Module' ,Module);
  AddXMLNode(node,'Issue' ,Issue);
  AddXMLNode(node,'SupportType' ,SupportType);
  AddXMLNode(node,'Solution' ,Solution);
  AddXMLNode(node,'CallSecs' ,CallSecs);
  AddXMLNode(node,'CallTime' ,CallTime);
  AddXMLNode(node,'Finished' ,Finished);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'ContactID' ,ContactID);
  AddXMLNode(node,'Version' ,Version);
  AddXMLNode(node,'Status' ,Status);
  AddXMLNode(node,'ToEmployeeID' ,ToEmployeeID);
  AddXMLNode(node,'FromEmployeeID' ,FromEmployeeID);
  AddXMLNode(node,'FromDate' ,FromDate);
end;


function TPhoneSupportLog.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeId = 0  then employeeId := AppEnv.Employee.EmployeeID;

  if ClientID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Client should not be 0' , True );
    Exit;
  end;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be 0' , True );
    Exit;
  end;
  if Module = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'You must Provide a Module', True);
    Exit;
  end ;
  if Issue = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'You must Provide an Issue', True);
    Exit;
  end;
  if solution= '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'You must Provide a Solution', True);
    Exit;
  end;
  if SupportType = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'You must Provide a Type', True);
    Exit;
  end ;
  if TPhoneSupportType.IDToggle(SupportType,Connection.Connection) < 1 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Unknown Type "' + SupportType + '"', True);
    Exit;
  end;
  if Version = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'You must Provide a Version', True);
    Exit;
  end ;
  if TPhoneSupportVersion.IDToggle(Version,Connection.Connection) < 1 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Unknown Version "' + Version + '"', True);
    Exit;
  end;
 Result := True;
end;


class function TPhoneSupportLog._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp', 'EmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp', 'EmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'from_emp', 'FromEmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'from_emp', 'FromEmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'to_emp', 'ToEmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'to_emp', 'ToEmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TCustomer', 'cust', 'ClientID', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomer', 'cust', 'Company', 'ClientName');
  TBOSchema.AddRefType(Result, 'TPhoneSupportType', 'SuppTypeObj', 'SupportType', 'TypeName');
  TBOSchema.AddRefType(Result, 'TPhoneSupportVersion', 'SuppVersionObj', 'Version', 'TypeName');
end;

function TPhoneSupportLog.Save: Boolean ;
begin
  Result := False;
  PostDB;
  Lines.PostDb;
  ResultStatus.Clear;
  Lines.First;
  if not ValidateData then Exit;
  Result := inherited Save;
  while not Lines.EOF do begin
    if not Lines.Save then begin
      result := false;
      break;
    end;
    Lines.Next;
  end;
end;


procedure TPhoneSupportLog.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPhoneSupportLog.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'Company') then begin
    ClientID:= TClient.IDToggle(Sender.AsString, Connection.Connection);
  end else if SysUtils.SameText(Sender.fieldName, 'ClientID') then begin
    Company:= TClient.IDToggle(Sender.AsInteger, Connection.Connection);
  end else if SysUtils.SameText(Sender.fieldName, 'Status') then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_status, self);
  end;
end;


function TPhoneSupportLog.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPhoneSupportLog.GetIDField: string;
begin
  Result := 'SupportLogID'
end;


class function TPhoneSupportLog.GetBusObjectTablename: string;
begin
  Result:= 'tblphonesupportlog';
end;


function TPhoneSupportLog.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited    DoAfterInsert(sender);
  if not result then exit;
  DateCreated:= Now;
  Module := appenv.CompanyPrefs.DefualtModuleNameforPhSupport;
  EmployeeID := Appenv.Employee.employeeId;
  EmployeeName:=Appenv.Employee.employeeName;
  if Appenv.CompanyPrefs.SupportAutoAssign then
    self.ToEmployeeID:= AppEnv.Employee.EmployeeID;
end;

function TPhoneSupportLog.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TPhoneSupportLog.getLines: TPhoneSupportLogLines;
begin
  Result := TPhoneSupportLogLines(getContainercomponent(TPhoneSupportLogLines ,'SupportID = ' +inttostr(ID)));
end;

class function TPhoneSupportLog.GetKeyStringField: string;
begin
  result:= '';
end;

function TPhoneSupportLog.getPhsupportStatus: TPhsupportStatus;
begin
  Result := TPhsupportStatus(getContainercomponent(TPhsupportStatus , 'Name = ' +Quotedstr(Status)));
end;

function TPhoneSupportLog.getTToDo: TToDo;
begin
  Result := TToDo(getContainercomponent(TToDo ,'OtherID = ' +inttostr(ID)+' and type = '+Quotedstr('Support')));
end;
function TPhoneSupportLog.getComments: String;
begin
  fsComments := '';
  Lines.iterateRecords(getCommentsCallback);
  result := fsComments;
end;

Procedure TPhoneSupportLog.getCommentsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TPhoneSupportLogLines) then exit;

  if fsComments <> '' then fsComments := fsComments +   #13#10 + #13#10 ;
  fsComments := fsComments + inttostr(TPhoneSupportLogLines(Sender).dataset.recno) +':' ;
  if TPhoneSupportLogLines(Sender).LinesDate <> 0 then fsComments := fsComments + ' on ' + Formatdatetime(FormatSettings.ShortDateFormat+' hh:nn:ss am/pm',  TPhoneSupportLogLines(Sender).LinesDate)+' ';
  if TPhoneSupportLogLines(Sender).EmployeeName <> '' then fsComments := fsComments + ', From :' + Quotedstr(TPhoneSupportLogLines(Sender).EmployeeName);
  fsComments := fsComments + ', '+ TPhoneSupportLogLines(Sender).comments ;
  if TPhoneSupportLogLines(Sender).SupportAssignTo <> '' then fsComments := fsComments + ', Assign To : ' + Quotedstr(TPhoneSupportLogLines(Sender).SupportAssignTo);

end;

{Property Functions}
function  TPhoneSupportLog.GetClientID      : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TPhoneSupportLog.GetCompany       : string    ; begin Result := GetStringField('Company');end;
function  TPhoneSupportLog.GetContact       : string    ; begin Result := GetStringField('Contact');end;
function  TPhoneSupportLog.GetEmployeeID    : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TPhoneSupportLog.GetDateCreated   : TDateTime ; begin Result := GetDateTimeField('DateCreated');end;
function  TPhoneSupportLog.GetForm          : string    ; begin Result := GetStringField('Form');end;
function  TPhoneSupportLog.GetIssue         : string    ; begin Result := GetStringField('Issue');end;
function  TPhoneSupportLog.GetType          : string    ; begin Result := GetStringField('Type');end;
function  TPhoneSupportLog.GetSolution      : string    ; begin Result := GetStringField('Solution');end;
function  TPhoneSupportLog.GetCallSecs      : Integer   ; begin Result := GetIntegerField('CallSecs');end;
function  TPhoneSupportLog.GetCallTime      : string    ; begin Result := GetStringField('CallTime');end;
function  TPhoneSupportLog.GetFinished      : Boolean   ; begin Result := GetBooleanField('Finished');end;
function  TPhoneSupportLog.GetActive        : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TPhoneSupportLog.GetContactID     : Integer   ; begin Result := GetIntegerField('ContactID');end;
function  TPhoneSupportLog.GetVersion       : string    ; begin Result := GetStringField('Version');end;
function  TPhoneSupportLog.GetStatus        : string    ; begin Result := GetStringField('Status');end;
function TPhoneSupportLog.GetTaskId: integer;
begin
  Result := GetIntegerField('TaskId');
end;

function  TPhoneSupportLog.GetToEmployeeID  : Integer   ; begin Result := GetIntegerField('ToEmployeeID');end;
function TPhoneSupportLog.GetToEmployeeName : string    ; begin result := TEmployee.IDToggle(ToEmployeeID,Connection.Connection);end;
function  TPhoneSupportLog.GetFromEmployeeName: string  ; begin result := TEmployee.IDToggle(FromEmployeeID,Connection.Connection);end;
function  TPhoneSupportLog.GetFromDate      : TDateTime ; begin Result := GetDateTimeField('FromDate');end;
function  TPhoneSupportLog.GetFromEmployeeID: Integer   ; begin Result := GetIntegerField('FromEmployeeID');end;
function TPhoneSupportLog.GetEmployeeName   : string    ; begin result := TEmployee.IDToggle(EmployeeID,Connection.Connection);end;


procedure TPhoneSupportLog.SetClientID      (const Value: Integer   ); begin SetIntegerField('ClientID'       , Value);end;
procedure TPhoneSupportLog.SetCompany       (const Value: string    ); begin SetStringField('Company'        , Value);end;
procedure TPhoneSupportLog.SetContact       (const Value: string    ); begin SetStringField('Contact'        , Value);end;
procedure TPhoneSupportLog.SetEmployeeID    (const Value: Integer   ); begin SetIntegerField('EmployeeID'     , Value);end;
procedure TPhoneSupportLog.SetDateCreated   (const Value: TDateTime ); begin SetDateTimeField('DateCreated'    , Value);end;
procedure TPhoneSupportLog.SetForm          (const Value: string    ); begin SetStringField('Form'           , Value);end;
procedure TPhoneSupportLog.SetIssue         (const Value: string    ); begin SetStringField('Issue'          , Value);end;
procedure TPhoneSupportLog.SetType          (const Value: string    ); begin SetStringField('Type'           , Value);end;
procedure TPhoneSupportLog.SetSolution      (const Value: string    ); begin SetStringField('Solution'       , Value);end;
procedure TPhoneSupportLog.SetCallSecs      (const Value: Integer   ); begin SetIntegerField('CallSecs'       , Value);end;
procedure TPhoneSupportLog.SetCallTime      (const Value: string    ); begin SetStringField('CallTime'       , Value);end;
procedure TPhoneSupportLog.SetFinished      (const Value: Boolean   ); begin SetBooleanField('Finished'       , Value);end;
procedure TPhoneSupportLog.SetActive        (const Value: Boolean   ); begin SetBooleanField('Active'         , Value);end;
procedure TPhoneSupportLog.SetContactID     (const Value: Integer   ); begin SetIntegerField('ContactID'      , Value);end;
procedure TPhoneSupportLog.SetVersion       (const Value: string    ); begin SetStringField('Version'        , Value);end;
procedure TPhoneSupportLog.SetStatus        (const Value: string    ); begin SetStringField('Status'        , Value);end;
procedure TPhoneSupportLog.SetTaskId(const Value: integer);
begin
  SetIntegerField('TaskId', Value);
end;

procedure TPhoneSupportLog.SetToEmployeeID  (const Value: Integer   ); begin SetIntegerField('ToEmployeeID'   , Value);end;
procedure TPhoneSupportLog.SetFromEmployeeID(const Value: Integer   ); begin SetIntegerField('FromEmployeeID' , Value);end;
procedure TPhoneSupportLog.SetFromEmployeeName(const Value: string);begin  FromEmployeeID:= TEmployee.IDToggle(Value,Connection.Connection);end;
procedure TPhoneSupportLog.SetFromDate      (const Value: TDateTime ); begin SetDateTimeField('FromDate'       , Value);end;
procedure TPhoneSupportLog.SetEmployeeName  (const Value: string);begin  EmployeeID:= TEmployee.IDToggle(Value,Connection.Connection);end;
procedure TPhoneSupportLog.SetToEmployeeName(const Value: string);begin  ToEmployeeID:= TEmployee.IDToggle(Value,Connection.Connection);end;

{TPhoneSupportLogLines}

constructor TPhoneSupportLogLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PhoneSupportLogLines';
  fSQL := 'SELECT * FROM tblphonesupportloglines';
end;


destructor TPhoneSupportLogLines.Destroy;
begin
  inherited;
end;


procedure TPhoneSupportLogLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SupportID');
  SetDateTimePropertyFromNode(node,'Date');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'Comments');
  SetPropertyFromNode(node,'AssignToID');
  SetPropertyFromNode(node,'SupportAssignTo');
end;


procedure TPhoneSupportLogLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SupportID' ,SupportID);
  AddXMLNode(node,'Date' ,Date);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'AssignToID' ,AssignToID);
  AddXMLNode(node,'SupportAssignTo' ,SupportAssignTo);
end;


function TPhoneSupportLogLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Date = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date should not be blank' , true );
    Exit;
  end;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0' , true );
    Exit;
  end;
  (*if self.Comments = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Comment should not be blank' , true );
    Exit;
  end;*)
  if not(deleted) and (Isrecordnotempty(TERPQuery(dataset) , 'Comments,CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10,AssignTo') = false)  then begin
    Resultstatus.AddItem(False , rssError , 0,  'All Fields in the Record Are Blank' , true );
    Exit;
  end;
  Result := True;
end;


function TPhoneSupportLogLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPhoneSupportLogLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPhoneSupportLogLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'EmployeeID') then begin
    EmployeeName:= TEmployee.IDToggle(EmployeeID,Connection.Connection);
  end else if SysUtils.SameText(Sender.fieldName, 'EmployeeName') then begin
    EmployeeID:= TEmployee.IDToggle(EmployeeName,Connection.Connection);
  end else if SysUtils.SameText(Sender.fieldName, 'AssignToID') then begin
    SupportAssignTo:= TEmployee.IDToggle(AssignToID,Connection.Connection);
  end else if SysUtils.SameText(Sender.fieldName, 'AssignTo') then begin
    AssignToID:= TEmployee.IDToggle(SupportAssignTo,Connection.Connection);
  end;
end;


function TPhoneSupportLogLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPhoneSupportLogLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TPhoneSupportLogLines.GetBusObjectTablename: string;
begin
  Result:= 'tblphonesupportloglines';
end;


function TPhoneSupportLogLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if Owner is TPhoneSupportLog then begin
      TPhoneSupportLog(Owner).PostDB;
      SupportId := TPhoneSupportLog(Owner).ID;
    end;
  LinesDate := Now;
  EmployeeId := Appenv.Employee.EmployeeID;
end;

function TPhoneSupportLogLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TPhoneSupportLogLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
  if not IsRecordNotEmpty(TERPQuery(dataset) , 'Comments,CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10,AssignTo') then
    Deleted := True;
end;

{Property Functions}
function  TPhoneSupportLogLines.GetSupportID       : Integer   ; begin Result := GetIntegerField('SupportID');end;
function  TPhoneSupportLogLines.GetDate            : TDateTime ; begin Result := GetDateTimeField('Date');end;
function TPhoneSupportLogLines.getDeleted          : Boolean   ; begin Result := GetBooleanField('Deleted'); end;
function TPhoneSupportLogLines.getIsFollowupCall   : Boolean   ; begin Result := GetBooleanField('IsFollowupCall'); end;
function TPhoneSupportLogLines.getActive           : Boolean   ; begin Result := GetBooleanField('Active'); end;
function  TPhoneSupportLogLines.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TPhoneSupportLogLines.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  TPhoneSupportLogLines.GetComments        : string    ; begin Result := GetStringField('Comments');end;
function TPhoneSupportLogLines.getCustomField1     : String    ; begin REsult := GetStringfield('CustomField1');end;
function TPhoneSupportLogLines.getCustomField2     : String    ; begin REsult := GetStringfield('CustomField2');end;
function TPhoneSupportLogLines.getCustomField3     : String    ; begin REsult := GetStringfield('CustomField3');end;
function TPhoneSupportLogLines.getCustomField4     : String    ; begin REsult := GetStringfield('CustomField4');end;
function TPhoneSupportLogLines.getCustomField5     : String    ; begin REsult := GetStringfield('CustomField5');end;
function TPhoneSupportLogLines.getCustomField6     : String    ; begin REsult := GetStringfield('CustomField6');end;
function TPhoneSupportLogLines.getCustomField7     : String    ; begin REsult := GetStringfield('CustomField7');end;
function TPhoneSupportLogLines.getCustomField8     : String    ; begin REsult := GetStringfield('CustomField8');end;
function TPhoneSupportLogLines.getCustomField9     : String    ; begin REsult := GetStringfield('CustomField9');end;
function TPhoneSupportLogLines.getCustomField10    : String    ; begin REsult := GetStringfield('CustomField10');end;
function  TPhoneSupportLogLines.GetAssignToID      : Integer   ; begin Result := GetIntegerField('AssignToID');end;
function  TPhoneSupportLogLines.GetAssignTo        : string    ; begin Result := GetStringField('AssignTo');end;
procedure TPhoneSupportLogLines.SetSupportID       (const Value: Integer   ); begin SetIntegerField('SupportID'        , Value);end;
procedure TPhoneSupportLogLines.SetDate            (const Value: TDateTime ); begin SetDateTimeField('Date'             , Value);end;
procedure TPhoneSupportLogLines.setDeleted         (const Value: Boolean   ); begin SetBooleanfield('Deleted'           , Value);end;
procedure TPhoneSupportLogLines.setIsFollowupCall  (const Value: Boolean   ); begin SetBooleanfield('IsFollowupCall'    , Value);end;
procedure TPhoneSupportLogLines.setActive          (const Value: Boolean   ); begin SetBooleanfield('Active'           , Value);end;
procedure TPhoneSupportLogLines.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure TPhoneSupportLogLines.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure TPhoneSupportLogLines.SetComments        (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TPhoneSupportLogLines.SetCustomField1    (const Value: String    ); begin SetStringfield('CustomField1'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField2    (const Value: String    ); begin SetStringfield('CustomField2'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField3    (const Value: String    ); begin SetStringfield('CustomField3'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField4    (const Value: String    ); begin SetStringfield('CustomField4'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField5    (const Value: String    ); begin SetStringfield('CustomField5'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField6    (const Value: String    ); begin SetStringfield('CustomField6'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField7    (const Value: String    ); begin SetStringfield('CustomField7'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField8    (const Value: String    ); begin SetStringfield('CustomField8'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField9    (const Value: String    ); begin SetStringfield('CustomField9'     , Value);end;
procedure TPhoneSupportLogLines.SetCustomField10   (const Value: String    ); begin SetStringfield('CustomField10'    , Value);end;
procedure TPhoneSupportLogLines.SetAssignToID      (const Value: Integer   ); begin SetIntegerField('AssignToID'       , Value);end;
procedure TPhoneSupportLogLines.SetAssignTo        (const Value: string    ); begin SetStringField('AssignTo'         , Value);end;


{ TPhoneSupportLogEx }

function TPhoneSupportLogEx.Getattachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment,
    'Tablename = ' + Quotedstr(GetBusObjectTablename) + ' and TableID =' + IntToStr(ID)));
end;

initialization
  RegisterClass(TPhoneSupportLogLines);
  RegisterClass(TPhoneSupportLog);
  RegisterClass(TPhoneSupportLogEx);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Phone Suppport log','TPhoneSupportLog','TPhSupportLogListGUI');
end.
