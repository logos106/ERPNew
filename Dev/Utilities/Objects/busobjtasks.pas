unit busobjtasks;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/12/11  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLIntf;



type


  TTasksPages = class(TMSBusObj)
  private
    function GetTaskID              : Integer   ;
    function GetPageName            : string    ;
    Function GetActive              : Boolean;
    procedure SetTaskID              (const Value: Integer   );
    procedure SetPageName            (const Value: string    );
    Procedure SetActive              (Const Value :Boolean);
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
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property TaskID               :Integer     read GetTaskID             write SetTaskID          ;
    property PageName             :string      read GetPageName           write SetPageName        ;
    Property Active               :Boolean     read getActive             write setActive;
  end;

  TTasks = class(TMSBusObj)
  private
    function GetTasktype          : string    ;
    function GetVersionNo         : string    ;
    function GetClientCode        : string    ;
    function GetCustomerName      : string    ;
    function GetCreatedOn         : TDateTime ;
    function GetEnteredByID       : Integer   ;
    function GetSeqno             : Integer   ;
    function GetTaskno            : Integer   ;
    function GetEnteredBy         : string    ;
    function GetSubject           : string    ;
    function GetDetails           : string    ;
    function GeterphelpdocDesc    : string    ;
    //function GetPagename          : string    ;
    function GetEstimatedHrs      : Double    ;
    function GetPercentagedone    : Double    ;
    procedure SetTasktype          (const Value: string    );
    procedure SetVersionNo         (const Value: string    );
    procedure SetClientCode        (const Value: string    );
    procedure SetCustomerName      (const Value: string    );
    procedure SetCreatedOn         (const Value: TDateTime );
    procedure SetEnteredByID       (const Value: Integer   );
    procedure SetSeqno             (const Value: Integer   );
    procedure SetTaskno            (const Value: Integer   );
    procedure SetEnteredBy         (const Value: string    );
    procedure SetSubject           (const Value: string    );
    procedure SetDetails           (const Value: string    );
    procedure SeterphelpdocDesc    (const Value: string    );
    //procedure SetPagename          (const Value: string    );
    procedure SetEstimatedHrs      (const Value: Double    );
    procedure SetPercentagedone    (const Value: Double    );
    function getTasksPages: TTasksPages;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
    Function PreviousVersion :String;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    class function _Schema: string; override;
    function nextTasknoforVersion:Integer;
  published
    property TaskType           :string      read GetTasktype         write SetTasktype      ;
    property VersionNo          :string      read GetVersionNo        write SetVersionNo     ;
    property ClientCode         :string      read GetClientCode       write SetClientCode    ;
    property CustomerName       :string      read GetCustomerName     write SetCustomerName  ;
    property CreatedOn          :TDateTime   read GetCreatedOn        write SetCreatedOn     ;
    property EnteredByID        :Integer     read GetEnteredByID      write SetEnteredByID   ;
    property Seqno              :Integer     read GetSeqno            write SetSeqno         ;
    property Taskno             :Integer     read GetTaskno           write SetTaskno         ;
    property EnteredBy          :string      read GetEnteredBy        write SetEnteredBy     ;
    property Subject            :string      read GetSubject          write SetSubject       ;
    property Details            :string      read GetDetails          write SetDetails       ;
    property erphelpdocDesc     :string      read GeterphelpdocDesc   write SeterphelpdocDesc;
    //property Pagename           :string      read GetPagename         write SetPagename      ;
    property EstimatedHrs       :Double      read GetEstimatedHrs     write SetEstimatedHrs  ;
    property PercentageDone     :Double      read GetPercentagedone   write SetPercentagedone;
    Property TasksPages :TTasksPages read getTasksPages;
  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib, Sysutils, AppEnvironment, AppDatabase, BusObjSchemaLib,
  ERPMessageTypes, DbSharedObjectsObj, CommonDbLib, BusObjConst, FileVersion;


  {TTasks}

constructor TTasks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Tasks';
  fSQL := 'SELECT * FROM tbltasks';
  ExportExcludeList.Add('enteredbyid');
end;


destructor TTasks.Destroy;
begin
  inherited;
end;


procedure TTasks.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Tasktype');
  SetPropertyFromNode(node,'VersionNo');
  SetPropertyFromNode(node,'ClientCode');
  SetPropertyFromNode(node,'CustomerName');
  SetDateTimePropertyFromNode(node,'CreatedOn');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'Taskno');
  SetPropertyFromNode(node,'EnteredBy');
  SetPropertyFromNode(node,'Subject');
  SetPropertyFromNode(node,'Details');
  SetPropertyFromNode(node,'erphelpdocDesc');
  //SetPropertyFromNode(node,'Pagename');
  SetPropertyFromNode(node,'EstimatedHrs');
  SetPropertyFromNode(node,'Percentagedone');
end;


function TTasks.nextTasknoforVersion: Integer;
var
  Qry:TERPQuery;
begin
  Qry:= GetSharedDataSet('Select Max(TaskNo) TaskNo from tblTasks where Versionno =' +quotedstr(Versionno) , true);
  try
    REsult := Qry.FieldByName('TaskNo').asInteger +1;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TTasks.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Tasktype' ,Tasktype);
  AddXMLNode(node,'VersionNo' ,VersionNo);
  AddXMLNode(node,'ClientCode' ,ClientCode);
  AddXMLNode(node,'CustomerName' ,CustomerName);
  AddXMLNode(node,'CreatedOn' ,CreatedOn);
  AddXMLNode(node,'EnteredByID' ,EnteredByID);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'Taskno' ,Taskno);
  AddXMLNode(node,'EnteredBy' ,EnteredBy);
  AddXMLNode(node,'Subject' ,Subject);
  AddXMLNode(node,'Details' ,Details);
  AddXMLNode(node,'erphelpdocDesc' ,erphelpdocDesc);
  //AddXMLNode(node,'Pagename' ,Pagename);
  AddXMLNode(node,'EstimatedHrs' ,EstimatedHrs);
  AddXMLNode(node,'Percentagedone' ,Percentagedone);
end;


function TTasks.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if CreatedOn = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'CreatedOn should not be blank' , True );
    Exit;
  end;
  if subject = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Subject should not be blank' , True );
    Exit;
  end;
  if Details = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Details should not be blank' , True );
    Exit;
  end;
  if TasksPages.Count =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Choose the "Module" before creating the Video' , True );
    Exit;
  end;
  Result := True;
end;


class function TTasks._Schema: string;
begin
  TBOSchema.AddRefType(result,'TEmployee','EmpObj','EnteredByID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmpObj','EnteredBy','EmployeeName');
end;

function TTasks.Save: Boolean ;
begin
  Result := False;
  PostDB;
  TasksPages.PostDb;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTasks.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function TTasks.PreviousVersion: String;
begin
  With GetNewDataset('Select ID, versionno from tblTasks order by id desc limit 1' , true) do try
    Result := fieldbyname('versionno').asString;
  finally
    if active then close;
    free;
  end;
end;

procedure TTasks.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
  if Sametext(Sender.fieldname , 'Percentagedone') then begin
    if Percentagedone>100 then Percentagedone :=100 else if Percentagedone <0 then Percentagedone := 0;
  end else if Sametext(Sender.fieldname , 'CustomerName') then begin
       ClientCode := tcdatautils.GetClientCode(CustomerName);
  end else if Sametext(Sender.fieldname , 'Versionno') then begin
    if (Versionno<> '') and (CleanId =0) and (Taskno =0 ) then
        Taskno := nextTasknoforVersion;
  end else if Sametext(Sender.fieldname , 'Taskno') then begin
        SendEvent(BusObjEvent_Change, BusObjEventVal_Taskno);
  end;
end;


function TTasks.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTasks.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTasks.GetBusObjectTablename: string;
begin
  Result:= 'tbltasks';
end;


function TTasks.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  VersionNo := PreviousVersion;
  if versionno = '' then Versionno := FileVersion.GetFileVersion;
  CreatedOn := now;
  Enteredby :=Appenv.employee.EmployeeName;
  EnteredbyID :=Appenv.employee.EmployeeId;
  Tasktype := ERPMessageTypeToStr(mtFeature);
  Seqno :=strtoInt(GetSequenceNumber(BusObjectTablename));
end;
function TTasks.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then exit;
end;


function TTasks.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(sender);
  if not result then exit;
end;

{Property Functions}
function  TTasks.GetTasktype      : string    ; begin Result := GetStringField('Tasktype');end;
function  TTasks.GetVersionNo     : string    ; begin Result := GetStringField('VersionNo');end;
function  TTasks.GetClientCode    : string    ; begin Result := GetStringField('ClientCode');end;
function  TTasks.GetCustomerName  : string    ; begin Result := GetStringField('CustomerName');end;
function  TTasks.GetCreatedOn     : TDateTime ; begin Result := GetDateTimeField('CreatedOn');end;
function  TTasks.GetEnteredByID   : Integer   ; begin Result := GetIntegerField('EnteredByID');end;
function  TTasks.GetSeqno         : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TTasks.GetTaskno        : Integer   ; begin Result := GetIntegerField('Taskno');end;
function  TTasks.GetEnteredBy     : string    ; begin Result := GetStringField('EnteredBy');end;
function  TTasks.GetSubject       : string    ; begin Result := GetStringField('Subject');end;
function  TTasks.GetDetails       : string    ; begin Result := GetStringField('Details');end;
function  TTasks.GeterphelpdocDesc: string    ; begin Result := GetStringField('erphelpdocDesc');end;
//function  TTasks.GetPagename      : string    ; begin Result := GetStringField('Pagename');end;
function  TTasks.GetEstimatedHrs  : Double    ; begin Result := GetFloatField('EstimatedHrs');end;
function  TTasks.GetPercentagedone: Double    ; begin Result := GetFloatField('Percentagedone');end;
procedure TTasks.SetTasktype      (const Value: string    ); begin SetStringField('Tasktype'       , Value);end;
procedure TTasks.SetVersionNo     (const Value: string    ); begin SetStringField('VersionNo'      , Value);end;
procedure TTasks.SetClientCode    (const Value: string    ); begin SetStringField('ClientCode'      , Value);end;
procedure TTasks.SetCustomerName  (const Value: string    ); begin SetStringField('CustomerName'   , Value);end;
procedure TTasks.SetCreatedOn     (const Value: TDateTime ); begin SetDateTimeField('CreatedOn'      , Value);end;
procedure TTasks.SetEnteredByID   (const Value: Integer   ); begin SetIntegerField('EnteredByID'    , Value);end;
procedure TTasks.SetSeqno         (const Value: Integer   ); begin SetIntegerField('Seqno'          , Value);end;
procedure TTasks.SetTaskno        (const Value: Integer   ); begin SetIntegerField('Taskno'         , Value);end;
procedure TTasks.SetEnteredBy     (const Value: string    ); begin SetStringField('EnteredBy'      , Value);end;
procedure TTasks.SetSubject       (const Value: string    ); begin SetStringField('Subject'        , Value);end;
procedure TTasks.SetDetails       (const Value: string    ); begin SetStringField('Details'        , Value);end;
procedure TTasks.SeterphelpdocDesc(const Value: string    ); begin SetStringField('erphelpdocDesc' , Value);end;
//procedure TTasks.SetPagename      (const Value: string    ); begin SetStringField('Pagename'        , Value);end;
procedure TTasks.SetEstimatedHrs  (const Value: Double    ); begin SetFloatField('EstimatedHrs'   , Value);end;
procedure TTasks.SetPercentagedone(const Value: Double    ); begin SetFloatField('Percentagedone' , Value);end;
function TTasks.getTasksPages: TTasksPages;
begin
  Result := TTasksPages(Getcontainercomponent(TTasksPages, 'TaskID = ' + IntToStr(Self.ID)))
end;

  {TTasksPages}
constructor TTasksPages.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TasksPages';
  fSQL := 'SELECT * FROM tbltaskspages';
end;


destructor TTasksPages.Destroy;
begin
  inherited;
end;


procedure TTasksPages.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TaskID');
  SetPropertyFromNode(node,'PageName');
  SetBooleanPropertyFromNode(node , 'Active');
end;


procedure TTasksPages.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TaskID' ,TaskID);
  AddXMLNode(node,'PageName' ,PageName);
  AddXMLNode(node,'Active' ,Active);
end;


function TTasksPages.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TaskID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TaskID should not be 0' , True );
    Exit;
  end;
  if Pagename = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Pagename should not be blank' , True );
    Exit;
  end;
  Result := True;
end;


function TTasksPages.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTasksPages.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTasksPages.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTasksPages.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTasksPages.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTasksPages.GetBusObjectTablename: string;
begin
  Result:= 'tbltaskspages';
end;


function TTasksPages.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  if Assigned(Owner) then
    if Owner is TTasks then
      TaskId := TTasks(Owner).ID;
end;

function TTasksPages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function  TTasksPages.DoBeforePost(Sender:TDatasetBusObj) : Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if Pagename = '' then begin
      CancelDB;
      abort;
  end;
end;

{Property Functions}
function  TTasksPages.GetTaskID          : Integer   ; begin Result := GetIntegerField('TaskID');end;
function  TTasksPages.GetPageName        : string    ; begin Result := GetStringField('PageName');end;
function  TTasksPages.GetActive          : Boolean   ; begin Result := GetBooleanfield('Active');end;
procedure TTasksPages.SetTaskID          (const Value: Integer   ); begin SetIntegerField('TaskID'           , Value);end;
procedure TTasksPages.SetPageName        (const Value: string    ); begin SetStringField('PageName'         , Value);end;
Procedure TTasksPages.SetActive         (Const Value: Boolean   ); begin SetBooleanField('Active'          , Value);end;

initialization
  RegisterClass(TTasksPages);
  RegisterClass(TTasks);
end.
