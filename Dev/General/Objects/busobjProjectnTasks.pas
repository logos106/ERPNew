unit busobjProjectnTasks;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  24/04/22  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
Tprojecttask_comments = class(TMSBusObj)
  private
    function GetProjectID               : Integer   ;
    function GetTaskID                  : Integer   ;
    function getTaskName                : String;
    function GetCommentsName            : string    ;
    function GetCommentsDescription     : string    ;
    function GetCommentsDate            : TDateTime ;
    function GetEnteredByID             : Integer   ;
    function GetEnteredBy               : string    ;
    function GetCommenttype             : string    ;
    function GetActive                  : Boolean   ;
    procedure SetProjectID               (const Value: Integer   );
    procedure SetTaskID                  (const Value: Integer   );
    procedure SetCommentsName            (const Value: string    );
    procedure SetCommentsDescription     (const Value: string    );
    procedure SetCommentsDate            (const Value: TDateTime );
    procedure SetEnteredByID             (const Value: Integer   );
    procedure SetEnteredBy               (const Value: string    );
    procedure SetCommenttype             (const Value: string    );
    procedure SetActive                  (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProjectID                :Integer     read GetProjectID              write SetProjectID           ;
    property TaskID                   :Integer     read GetTaskID                 write SetTaskID              ;
    Property TaskName                 :String      read getTaskname;
    property CommentsName             :string      read GetCommentsName           write SetCommentsName        ;
    property CommentsDescription      :string      read GetCommentsDescription    write SetCommentsDescription ;
    property CommentsDate             :TDateTime   read GetCommentsDate           write SetCommentsDate        ;
    property EnteredByID              :Integer     read GetEnteredByID            write SetEnteredByID         ;
    property EnteredBy                :string      read GetEnteredBy              write SetEnteredBy           ;
    property Commenttype              :string      read GetCommenttype            write SetCommenttype         ;
    property Active                   :Boolean     read GetActive                 write SetActive              ;
  end;
  Tprojecttask_activity = class(TMSBusObj)
  private
    function GetProjectID               : Integer   ;
    function GetTaskID                  : Integer   ;
    function getTaskName                : String;
    function GetActivityName            : string    ;
    function GetActivityDescription     : string    ;
    function GetActivityDateStartd      : TDateTime ;
    function GetActivityDateFinished    : TDateTime ;
    function GetDone                    : Boolean   ;
    function GetEnteredByID             : Integer   ;
    function GetEnteredBy               : string    ;
    function GetActive                  : Boolean   ;
    procedure SetProjectID               (const Value: Integer   );
    procedure SetTaskID                  (const Value: Integer   );
    procedure SetActivityName            (const Value: string    );
    procedure SetActivityDescription     (const Value: string    );
    procedure SetActivityDateStartd      (const Value: TDateTime );
    procedure SetActivityDateFinished    (const Value: TDateTime );
    procedure SetDone                    (const Value: Boolean   );
    procedure SetEnteredByID             (const Value: Integer   );
    procedure SetEnteredBy               (const Value: string    );
    procedure SetActive                  (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;             override;
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
  published
    property ProjectID                :Integer     read GetProjectID              write SetProjectID           ;
    property TaskID                   :Integer     read GetTaskID                 write SetTaskID              ;
    Property TaskName                 :String      read getTaskname;
    property ActivityName             :string      read GetActivityName           write SetActivityName        ;
    property ActivityDescription      :string      read GetActivityDescription    write SetActivityDescription ;
    property ActivityDateStartd       :TDateTime   read GetActivityDateStartd     write SetActivityDateStartd  ;
    property ActivityDateFinished     :TDateTime   read GetActivityDateFinished   write SetActivityDateFinished;
    property Done                     :Boolean     read GetDone                   write SetDone                ;
    property EnteredByID              :Integer     read GetEnteredByID            write SetEnteredByID         ;
    property EnteredBy                :string      read GetEnteredBy              write SetEnteredBy           ;
    property Active                   :Boolean     read GetActive                 write SetActive              ;
  end;
  Tprojecttask_TaskLabel = class(TMSBusObj)
  private
    function GetProjectID               : Integer   ;
    function GetTaskID                  : Integer   ;
    function getTaskName                : String;
    function GetTaskLabelName            : string    ;
    function GetTaskLabelDescription     : string    ;
    function GetEnteredByID             : Integer   ;
    function GetEnteredBy               : string    ;
    function GetActive                  : Boolean   ;
    function GetColor                   : String;
    procedure SetProjectID               (const Value: Integer   );
    procedure SetTaskID                  (const Value: Integer   );
    procedure SetTaskLabelName            (const Value: string    );
    procedure SetTaskLabelDescription     (const Value: string    );
    procedure SetEnteredByID             (const Value: Integer   );
    procedure SetEnteredBy               (const Value: string    );
    procedure SetActive                  (const Value: Boolean   );
    procedure SetColor                   (const Value: String    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;             override;
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
  published
    property ProjectID                :Integer     read GetProjectID              write SetProjectID           ;
    property TaskID                   :Integer     read GetTaskID                 write SetTaskID              ;
    Property TaskName                 :String      read getTaskname;
    property TaskLabelName             :string      read GetTaskLabelName           write SetTaskLabelName        ;
    property TaskLabelDescription      :string      read GetTaskLabelDescription    write SetTaskLabelDescription ;
    property EnteredByID              :Integer     read GetEnteredByID            write SetEnteredByID         ;
    property EnteredBy                :string      read GetEnteredBy              write SetEnteredBy           ;
    property Active                   :Boolean     read GetActive                 write SetActive              ;
    property Color                    :String      read GetColor                  write SetColor               ;
  end;

(*
  Tprojecttask_subtasks = class(TMSBusObj)
  private
    function GetProjectID               : Integer   ;
    function GetTaskID                  : Integer   ;
    function getTaskName                : String;
    function GetSubTaskName             : string    ;
    function GetSubTaskDescription      : string    ;
    function GetSubTaskDate             : TDateTime ;
    function GetActive                  : Boolean   ;
    procedure SetProjectID               (const Value: Integer   );
    procedure SetTaskID                  (const Value: Integer   );
    procedure SetSubTaskName             (const Value: string    );
    procedure SetSubTaskDescription      (const Value: string    );
    procedure SetSubTaskDate             (const Value: TDateTime );
    procedure SetActive                  (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProjectID                :Integer     read GetProjectID              write SetProjectID           ;
    property TaskID                   :Integer     read GetTaskID                 write SetTaskID              ;
    Property TaskName                 :String      read getTaskname;
    property SubTaskName              :string      read GetSubTaskName            write SetSubTaskName         ;
    property SubTaskDescription       :string      read GetSubTaskDescription     write SetSubTaskDescription  ;
    property SubTaskDate              :TDateTime   read GetSubTaskDate            write SetSubTaskDate         ;
    property Active                   :Boolean     read GetActive                 write SetActive              ;
  end;
*)

  Tprojecttasks = class;

  Tprojecttask_subtasks = class;

  Tprojectlist = class;

  Tprojecttasks = class(TMSBusObj)
  private
    function GetProjectID           : Integer   ;
    function Getpriority            : Integer   ;
    function GetPosition            : Integer   ;
    function GetTaskName            : string    ;
    function GetTaskDescription     : string    ;
    function GetEnteredByID         : Integer   ;
    function GetEnteredBy           : string    ;
    function GetActive              : Boolean   ;
    function GetCompleted           : Boolean   ;
    function getdue_date            : Tdatetime;
    function GetTaskID              : Integer;
    function GetCustomerID          : Integer;
    function GetLeadID              : Integer;
    function GetSupplierID          : Integer;
    function GetJobID               : Integer;
    function GetContactName         : String;
    function GetContactEmail        : String;
    function GetContactPhone        : String;
    function GetAssignID            : Integer;
    function GetAssignName          : String;
    function GetAssignEmail         : String;
    function GetAssignPhone         : String;
    function GetFixedAssetID        : Integer;
    function GetFixedAssetName      : String;

    procedure SetProjectID           (const Value: Integer   );
    procedure Setpriority            (const Value: Integer   );
    procedure SetPosition            (const Value: Integer   );
    procedure SetTaskName            (const Value: string    );
    procedure SetTaskDescription     (const Value: string    );
    procedure SetEnteredByID         (const Value: Integer   );
    procedure SetEnteredBy           (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    procedure SetCompleted           (const Value: Boolean   );
    Procedure Setdue_date            (const Value: TDatetime );
    procedure SetTaskID              (const Value: Integer   );
    procedure SetCustomerID          (const Value: Integer   );
    procedure SetLeadID              (const Value: Integer   );
    procedure SetSupplierID          (const Value: Integer   );
    procedure SetJobID               (const Value: Integer   );
    procedure SetAssignID            (const Value: Integer   );
    procedure SetContactName         (const Value: String    );
    procedure SetAssignName          (const Value: String    );
    procedure SetFixedAssetID        (const Value: Integer   );
    procedure SetFixedAssetName      (const Value: String    );

    function GetTaskactivity: Tprojecttask_activity;
    function GetTaskTaskLabel: Tprojecttask_TaskLabel;
    function getTaskcomments: Tprojecttask_comments;
    function getTasksubtasks: Tprojecttask_subtasks;
    function getproject: Tprojectlist;
    function getProjectName: String;
    procedure SetProjectname(const Value: String);
    procedure UpdateProjectIDCallback(const Sender: TBusObj;var Abort: boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property project              : Tprojectlist read getproject;
    Property TaskID               : Integer     read GetTaskID             write SetTaskID          ;

  published
    property ProjectID            : Integer     read GetProjectID          write SetProjectID       ;
    property priority             : Integer     read Getpriority           write Setpriority        ;
    property Position             : Integer     read GetPosition           write SetPosition        ;
    Property ProjectName          : String      read getProjectName        write SetProjectname;
    property TaskName             : String      read GetTaskName           write SetTaskName        ;
    property TaskDescription      : String      read GetTaskDescription    write SetTaskDescription ;
    property EnteredByID          : Integer     read GetEnteredByID        write SetEnteredByID     ;
    property EnteredBy            : String      read GetEnteredBy          write SetEnteredBy       ;
    property Active               : Boolean     read GetActive             write SetActive          ;
    Property due_date             : TdateTime   read getdue_date           write Setdue_date        ;
    property Completed            : Boolean     read GetCompleted          write SetCompleted       ;
    property subtasks             : Tprojecttask_subtasks read getTasksubtasks;
    property activity             : Tprojecttask_activity read GetTaskactivity;
    property TaskLabel            : Tprojecttask_TaskLabel read GetTaskTaskLabel;
    property comments             : Tprojecttask_comments read getTaskcomments;
    property CustomerID           : Integer read GetCustomerID   write SetCustomerID;
    property LeadID               : Integer read GetLeadID       write SetLeadID;
    property SupplierID           : Integer read GetSupplierID   write SetSupplierID;
    property JobID                : Integer read GetJobID        write SetJobID;
    property ContactName          : String  read GetContactName  write SetContactName;
    property ContactEmail         : String  read GetContactEmail;
    property ContactPhone         : String  read GetContactPhone;
    property AssignID             : Integer read GetAssignID     write SetAssignID;
    property AssignName           : String  read GetAssignName   write SetAssignName;
    property AssignEmail          : String  read GetAssignEmail;
    property AssignPhone          : String  read GetAssignPhone;
    property FixedAssetID         : Integer read GetFixedAssetID   write SetFixedAssetID;
    property FixedAssetName       : String  read GetFixedAssetName write SetFixedAssetName;
  end;

  Tprojecttask_subtasks = class(Tprojecttasks)
  end;

  Tprojectlist = class(TMSBusObj)
  private
    function GetProjectName         : string    ;
    function GetDescription         : string    ;
    function GetProjectColour       : string   ;
    function GetGradIntensity       : Integer   ;
    function GetProjectPosition     : Integer   ;
    function GetEnteredByID         : Integer   ;
    function GetEnteredBy           : string    ;
    function GetProjectStatedon     : TDateTime ;
    function GetActive              : Boolean   ;
    function GetArchive             : Boolean   ;
    function GetCompleted           : Boolean   ;
    function GetAddToFavourite      : Boolean   ;

    procedure SetProjectName         (const Value: string    );
    procedure SetDescription         (const Value: string    );
    procedure SetProjectColour       (const Value: string   );
    procedure SetGradIntensity       (const Value: Integer   );
    procedure SetProjectPosition     (const Value: Integer   );
    procedure SetEnteredByID         (const Value: Integer   );
    procedure SetEnteredBy           (const Value: string    );
    procedure SetProjectStatedon     (const Value: TDateTime );
    procedure SetActive              (const Value: Boolean   );
    procedure SetArchive             (const Value: Boolean   );
    procedure SetCompleted           (const Value: Boolean   );
    procedure SetAddToFavourite      (const Value: Boolean   );


    function Getprojecttasks: Tprojecttasks;
    function GetTaskactivity: Tprojecttask_activity;
    function GetTaskTaskLabel: Tprojecttask_TaskLabel;
    function getTaskcomments: Tprojecttask_comments;
    function getTasksubtasks: Tprojecttask_subtasks;  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj):Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ProjectName          :string      read GetProjectName        write SetProjectName     ;
    property Description          :string      read GetDescription        write SetDescription     ;
    property ProjectColour        :string      read GetProjectColour      write SetProjectColour   ;
    property GradIntensity        :Integer     read GetGradIntensity      write SetGradIntensity   ;
    property ProjectPosition      :Integer     read GetProjectPosition    write SetProjectPosition ;
    property EnteredByID          :Integer     read GetEnteredByID        write SetEnteredByID     ;
    property EnteredBy            :string      read GetEnteredBy          write SetEnteredBy       ;
    property ProjectStatedon      :TDateTime   read GetProjectStatedon    write SetProjectStatedon ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property Archive              :Boolean     read GetArchive            write SetArchive         ;
    property Completed            :Boolean     read GetCompleted          write SetCompleted       ;
    property AddToFavourite       :Boolean     read GetAddToFavourite     write SetAddToFavourite  ;
    Property projecttasks         :Tprojecttasks  read Getprojecttasks;
    property subtasks             :Tprojecttask_subtasks read getTasksubtasks;
    property activity             :Tprojecttask_activity read GetTaskactivity;
    property TaskLabel            :Tprojecttask_TaskLabel read GetTaskTaskLabel;
    property comments             :Tprojecttask_comments read getTaskcomments;

  end;


implementation


uses tcDataUtils, CommonLib, sysutils, BusObjEmployee, AppEnvironment,
  ERPdbComponents,  DbSharedObjectsObj, tcConst;



  {Tprojectlist}

constructor Tprojectlist.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'projectlist';
  fSQL := 'SELECT * FROM tblprojectlist';
end;


destructor Tprojectlist.Destroy;
begin
  inherited;
end;


procedure Tprojectlist.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProjectName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'ProjectColour');
  SetPropertyFromNode(node,'GradIntensity');
  SetPropertyFromNode(node,'ProjectPosition');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'EnteredBy');
  SetDateTimePropertyFromNode(node,'ProjectStatedon');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'Archive');
  SetBooleanPropertyFromNode(node,'Completed');
  SetBooleanPropertyFromNode(node,'AddToFavourite');
end;


procedure Tprojectlist.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProjectName', ProjectName);
  AddXMLNode(node,'Description', Description);
  AddXMLNode(node,'ProjectColour', ProjectColour);
  AddXMLNode(node,'GradIntensity', GradIntensity);
  AddXMLNode(node,'ProjectPosition', ProjectPosition);
  AddXMLNode(node,'EnteredByID', EnteredByID);
  AddXMLNode(node,'EnteredBy', EnteredBy);
  AddXMLNode(node,'ProjectStatedon', ProjectStatedon);
  AddXMLNode(node,'Active', Active);
  AddXMLNode(node,'Archive', Archive);
  AddXMLNode(node,'Completed', Completed);
  AddXMLNode(node,'AddToFavourite', AddToFavourite);
end;


function Tprojectlist.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tprojectlist.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprojectlist.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tprojectlist.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if sametext(Sender.fieldname,  'EnteredBy') then begin
    EnteredByID := TEmployee.IDtoggle(EnteredBy);
  end else if sametext(Sender.fieldname,  'EnteredByID')then begin
    EnteredBy := TEmployee.IDtoggle(EnteredByID);
    DoFieldOnChange(Dataset.findfield('EnteredBy'));
  end;
end;


function Tprojectlist.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tprojectlist.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tprojectlist.GetKeyStringField: string;
begin
  Result := 'Projectname';
end;

class function Tprojectlist.GetBusObjectTablename: string;
begin
  Result:= 'tblprojectlist';
end;


function Tprojectlist.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Tprojectlist.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Active := true;
  EnteredByID  := AppEnv.Employee.employeeId;
  ProjectStatedon := Date;
end;
{Property Functions}
function  Tprojectlist.GetProjectName     : string    ; begin Result := GetStringField('ProjectName');end;
function  Tprojectlist.GetDescription     : string    ; begin Result := GetStringField('Description');end;
function  Tprojectlist.GetProjectColour   : string    ; begin Result := GetstringField('ProjectColour');end;
function  Tprojectlist.GetGradIntensity   : Integer   ; begin Result := GetIntegerField('GradIntensity');end;
function  Tprojectlist.GetProjectPosition : Integer   ; begin Result := GetIntegerField('ProjectPosition');end;
function  Tprojectlist.GetEnteredByID     : Integer   ; begin Result := GetIntegerField('EnteredByID');end;
function  Tprojectlist.GetEnteredBy       : string    ; begin Result := GetStringField('EnteredBy');end;
function  Tprojectlist.GetProjectStatedon : TDateTime ; begin Result := GetDateTimeField('ProjectStatedon');end;
function  Tprojectlist.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  Tprojectlist.GetArchive         : Boolean   ; begin Result := GetBooleanField('Archive');end;
function  Tprojectlist.GetCompleted       : Boolean   ; begin Result := GetBooleanField('Completed');end;
function  Tprojectlist.GetAddToFavourite  : Boolean   ; begin Result := GetBooleanField('AddToFavourite');end;

procedure Tprojectlist.SetProjectName     (const Value: string    ); begin SetStringField('ProjectName'      ,  Value);end;
procedure Tprojectlist.SetDescription     (const Value: string    ); begin SetStringField('Description'      ,  Value);end;
procedure Tprojectlist.SetProjectColour   (const Value: string    ); begin SetstringField('ProjectColour'   ,  Value);end;
procedure Tprojectlist.SetGradIntensity   (const Value: Integer   ); begin SetIntegerField('GradIntensity'   ,  Value);end;
procedure Tprojectlist.SetProjectPosition (const Value: Integer   ); begin SetIntegerField('ProjectPosition' ,  Value);end;
procedure Tprojectlist.SetEnteredByID     (const Value: Integer   ); begin SetIntegerField('EnteredByID'     ,  Value);end;
procedure Tprojectlist.SetEnteredBy       (const Value: string    ); begin SetStringField('EnteredBy'        ,  Value);end;
procedure Tprojectlist.SetProjectStatedon (const Value: TDateTime ); begin SetDateTimeField('ProjectStatedon',  Value);end;
procedure Tprojectlist.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'          ,  Value);end;
procedure Tprojectlist.SetArchive         (const Value: Boolean   ); begin SetBooleanField('Archive'         ,  Value);end;
procedure Tprojectlist.SetCompleted       (const Value: Boolean   ); begin SetBooleanField('Completed'       ,  Value);end;
procedure Tprojectlist.SetAddToFavourite  (const Value: Boolean   ); begin SetBooleanField('AddToFavourite'  ,  Value);end;

function Tprojectlist.Getprojecttasks: Tprojecttasks;
begin
  Result := Tprojecttasks(getContainerComponent(Tprojecttasks, 'ProjectID = ' + IntToStr(ID)));
end;
function Tprojectlist.getTaskcomments: Tprojecttask_comments;
begin
  Result := Tprojecttask_comments(getContainerComponent(Tprojecttask_comments, 'ProjectID = ' + IntToStr(ID)));
end;
function Tprojectlist.getTasksubtasks: Tprojecttask_subtasks;
begin
  Result := Tprojecttask_subtasks(getContainerComponent(Tprojecttask_subtasks, 'ProjectID = ' + IntToStr(ID)));
end;
function Tprojectlist.GetTaskactivity: Tprojecttask_activity;
begin
  Result := Tprojecttask_activity(getContainerComponent(Tprojecttask_activity, 'ProjectID = ' + IntToStr(ID)));
end;
function Tprojectlist.GetTaskTaskLabel: Tprojecttask_TaskLabel;
begin
  Result := Tprojecttask_TaskLabel(getContainerComponent(Tprojecttask_TaskLabel, 'ProjectID = ' + IntToStr(ID)));
end;


{Tprojecttask_comments}

constructor Tprojecttask_comments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'projecttask_comments';
  fSQL := 'SELECT * FROM tblprojecttask_comments';
end;


destructor Tprojecttask_comments.Destroy;
begin
  inherited;
end;


procedure Tprojecttask_comments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProjectID');
  SetPropertyFromNode(node,'TaskID');
  SetPropertyFromNode(node,'CommentsName');
  SetPropertyFromNode(node,'CommentsDescription');
  SetDateTimePropertyFromNode(node,'CommentsDate');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'EnteredBy');
  SetPropertyFromNode(node,'Commenttype');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure Tprojecttask_comments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProjectID', ProjectID);
  AddXMLNode(node,'TaskID', TaskID);
  AddXMLNode(node,'CommentsName', CommentsName);
  AddXMLNode(node,'CommentsDescription', CommentsDescription);
  AddXMLNode(node,'CommentsDate', CommentsDate);
  AddXMLNode(node,'EnteredByID', EnteredByID);
  AddXMLNode(node,'EnteredBy', EnteredBy);
  AddXMLNode(node,'Commenttype', Commenttype);
  AddXMLNode(node,'Active', Active);
end;


function Tprojecttask_comments.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  {
  if TaskID = 0 then begin
    Resultstatus.AddItem(False,  rssError,  0,  'TaskID should not be 0',  False );
    Exit;
  end;
  }
  Result := True;
end;


function Tprojecttask_comments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprojecttask_comments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tprojecttask_comments.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if sametext(Sender.fieldname,  'EnteredBy') then begin
    EnteredByID := TEmployee.IDtoggle(EnteredBy);
  end else if sametext(Sender.fieldname,  'EnteredByID')then begin
    EnteredBy := TEmployee.IDtoggle(EnteredByID);
    DoFieldOnChange(Dataset.findfield('EnteredBy'));
  end;
end;


function Tprojecttask_comments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tprojecttask_comments.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tprojecttask_comments.GetKeyStringField: string;
begin
  Result := 'commentsname';
end;

class function Tprojecttask_comments.GetBusObjectTablename: string;
begin
  Result:= 'tblprojecttask_comments';
end;


function Tprojecttask_comments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function Tprojecttask_comments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TProjectTasks then begin
      ProjectID  := TProjectTasks(Owner).ProjectId;
      TaskID     := TProjectTasks(Owner).ID;
    end;
  Active := true;
  CommentsDate := date;
  EnteredByID  := AppEnv.Employee.employeeId;
end;

{Property Functions}
function  Tprojecttask_comments.GetProjectID           : Integer   ; begin Result := GetIntegerField('ProjectID');end;
function  Tprojecttask_comments.GetTaskID              : Integer   ; begin Result := GetIntegerField('TaskID');end;
function  Tprojecttask_comments.getTaskName            : String    ; begin if Assigned(Owner) and (Owner is TProjectTasks) then result := TProjectTasks(Owner).Taskname else Result := TProjectTasks.idToggle(TaskID); end;
function  Tprojecttask_comments.GetCommentsName        : string    ; begin Result := GetStringField('CommentsName');end;
function  Tprojecttask_comments.GetCommentsDescription : string    ; begin Result := GetStringField('CommentsDescription');end;
function  Tprojecttask_comments.GetCommentsDate        : TDateTime ; begin Result := GetDateTimeField('CommentsDate');end;
function  Tprojecttask_comments.GetEnteredByID         : Integer   ; begin Result := GetIntegerField('EnteredByID');end;
function  Tprojecttask_comments.GetEnteredBy           : string    ; begin Result := GetStringField('EnteredBy');end;
function  Tprojecttask_comments.GetCommenttype         : string    ; begin Result := GetStringField('Commenttype');end;
function  Tprojecttask_comments.GetActive              : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure Tprojecttask_comments.SetProjectID           (const Value: Integer   ); begin SetIntegerField('ProjectID'           ,  Value);end;
procedure Tprojecttask_comments.SetTaskID              (const Value: Integer   ); begin SetIntegerField('TaskID'              ,  Value);end;
procedure Tprojecttask_comments.SetCommentsName        (const Value: string    ); begin SetStringField('CommentsName'        ,  Value);end;
procedure Tprojecttask_comments.SetCommentsDescription (const Value: string    ); begin SetStringField('CommentsDescription',  Value);end;
procedure Tprojecttask_comments.SetCommentsDate        (const Value: TDateTime ); begin SetDateTimeField('CommentsDate'        ,  Value);end;
procedure Tprojecttask_comments.SetEnteredByID         (const Value: Integer   ); begin SetIntegerField('EnteredByID'         ,  Value);end;
procedure Tprojecttask_comments.SetEnteredBy           (const Value: string    ); begin SetStringField('EnteredBy'           ,  Value);end;
procedure Tprojecttask_comments.SetCommenttype         (const Value: string    ); begin SetStringField('Commenttype'         ,  Value);end;
procedure Tprojecttask_comments.SetActive              (const Value: Boolean   ); begin SetBooleanField('Active'              ,  Value);end;


(*
  {Tprojecttask_subtasks}

constructor Tprojecttask_subtasks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'projecttask_subtasks';
  fSQL := 'SELECT * FROM tblprojecttask_subtasks';
end;


destructor Tprojecttask_subtasks.Destroy;
begin
  inherited;
end;


procedure Tprojecttask_subtasks.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProjectID');
  SetPropertyFromNode(node,'TaskID');
  SetPropertyFromNode(node,'SubTaskName');
  SetPropertyFromNode(node,'SubTaskDescription');
  SetDateTimePropertyFromNode(node,'SubTaskDate');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure Tprojecttask_subtasks.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProjectID', ProjectID);
  AddXMLNode(node,'TaskID', TaskID);
  AddXMLNode(node,'SubTaskName', SubTaskName);
  AddXMLNode(node,'SubTaskDescription', SubTaskDescription);
  AddXMLNode(node,'SubTaskDate', SubTaskDate);
  AddXMLNode(node,'Active', Active);
end;


function Tprojecttask_subtasks.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  {
  if TaskID = 0 then begin
    Resultstatus.AddItem(False,  rssError,  0,  'TaskID should not be 0',  False );
    Exit;
  end;
  }
  Result := True;
end;


function Tprojecttask_subtasks.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprojecttask_subtasks.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tprojecttask_subtasks.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tprojecttask_subtasks.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tprojecttask_subtasks.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tprojecttask_subtasks.GetKeyStringField: string;
begin
  Result := 'SubTaskName';
end;

class function Tprojecttask_subtasks.GetBusObjectTablename: string;
begin
  Result:= 'tblprojecttask_subtasks';
end;


function Tprojecttask_subtasks.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Tprojecttask_subtasks.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TProjectTasks then begin
      ProjectID  := TProjectTasks(Owner).ProjectId;
      TaskID     := TProjectTasks(Owner).ID;
    end;
  Active := true;
  SubTaskDate := date;
end;


{Property Functions}
function  Tprojecttask_subtasks.GetProjectID           : Integer   ; begin Result := GetIntegerField('ProjectID');end;
function  Tprojecttask_subtasks.GetTaskID              : Integer   ; begin Result := GetIntegerField('TaskID');end;
function  Tprojecttask_subtasks.getTaskName            : String    ; begin if Assigned(Owner) and (Owner is TProjectTasks) then result := TProjectTasks(Owner).Taskname else Result := TProjectTasks.idToggle(TaskID); end;
function  Tprojecttask_subtasks.GetSubTaskName         : string    ; begin Result := GetStringField('SubTaskName');end;
function  Tprojecttask_subtasks.GetSubTaskDescription  : string    ; begin Result := GetStringField('SubTaskDescription');end;
function  Tprojecttask_subtasks.GetSubTaskDate         : TDateTime ; begin Result := GetDateTimeField('SubTaskDate');end;
function  Tprojecttask_subtasks.GetActive              : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure Tprojecttask_subtasks.SetProjectID           (const Value: Integer   ); begin SetIntegerField('ProjectID'           ,  Value);end;
procedure Tprojecttask_subtasks.SetTaskID              (const Value: Integer   ); begin SetIntegerField('TaskID'              ,  Value);end;
procedure Tprojecttask_subtasks.SetSubTaskName         (const Value: string    ); begin SetStringField('SubTaskName'         ,  Value);end;
procedure Tprojecttask_subtasks.SetSubTaskDescription  (const Value: string    ); begin SetStringField('SubTaskDescription'  ,  Value);end;
procedure Tprojecttask_subtasks.SetSubTaskDate         (const Value: TDateTime ); begin SetDateTimeField('SubTaskDate'         ,  Value);end;
procedure Tprojecttask_subtasks.SetActive              (const Value: Boolean   ); begin SetBooleanField('Active'              ,  Value);end;
*)

{Tprojecttask_activity}

constructor Tprojecttask_activity.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'projecttask_activity';
  fSQL := 'SELECT * FROM tblprojecttask_activity';
end;


destructor Tprojecttask_activity.Destroy;
begin
  inherited;
end;


procedure Tprojecttask_activity.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProjectID');
  SetPropertyFromNode(node,'TaskID');
  SetPropertyFromNode(node,'ActivityName');
  SetPropertyFromNode(node,'ActivityDescription');
  SetDateTimePropertyFromNode(node,'ActivityDateStartd');
  SetDateTimePropertyFromNode(node,'ActivityDateFinished');
  SetBooleanPropertyFromNode(node,'Done');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'EnteredBy');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure Tprojecttask_activity.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProjectID', ProjectID);
  AddXMLNode(node,'TaskID', TaskID);
  AddXMLNode(node,'ActivityName', ActivityName);
  AddXMLNode(node,'ActivityDescription', ActivityDescription);
  AddXMLNode(node,'ActivityDateStartd', ActivityDateStartd);
  AddXMLNode(node,'ActivityDateFinished', ActivityDateFinished);
  AddXMLNode(node,'Done', Done);
  AddXMLNode(node,'EnteredByID', EnteredByID);
  AddXMLNode(node,'EnteredBy', EnteredBy);
  AddXMLNode(node,'Active', Active);
end;


function Tprojecttask_activity.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  {
  if TaskID = 0 then begin
    Resultstatus.AddItem(False,  rssError,  0,  'TaskID should not be 0',  False );
    Exit;
  end;
  }
  Result := True;
end;


function Tprojecttask_activity.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprojecttask_activity.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tprojecttask_activity.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if sametext(Sender.fieldname,  'EnteredBy') then begin
    EnteredByID := TEmployee.IDtoggle(EnteredBy);
  end else if sametext(Sender.fieldname,  'EnteredByID')then begin
    EnteredBy := TEmployee.IDtoggle(EnteredByID);
    DoFieldOnChange(Dataset.findfield('EnteredBy'));
  end;
end;


function Tprojecttask_activity.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tprojecttask_activity.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tprojecttask_activity.GetKeyStringField: string;
begin
  Result := 'Activityname';
end;

class function Tprojecttask_activity.GetBusObjectTablename: string;
begin
  Result:= 'tblprojecttask_activity';
end;


function Tprojecttask_activity.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Tprojecttask_activity.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TProjectTasks then begin
      ProjectID  := TProjectTasks(Owner).ProjectId;
      TaskID     := TProjectTasks(Owner).ID;
    end;
  Active := true;
  ActivityDateStartd := date;
  EnteredByID  := AppEnv.Employee.employeeId;
  Done := False;
end;
{Property Functions}
function  Tprojecttask_activity.GetProjectID           : Integer   ; begin Result := GetIntegerField('ProjectID');end;
function  Tprojecttask_activity.GetTaskID              : Integer   ; begin Result := GetIntegerField('TaskID');end;
function  Tprojecttask_activity.GetTaskName            : String    ; begin if Assigned(Owner) and (Owner is TProjectTasks) then result := TProjectTasks(Owner).Taskname else Result := TProjectTasks.idToggle(TaskID); end;
function  Tprojecttask_activity.GetActivityName        : string    ; begin Result := GetStringField('ActivityName');end;
function  Tprojecttask_activity.GetActivityDescription : string    ; begin Result := GetStringField('ActivityDescription');end;
function  Tprojecttask_activity.GetActivityDateStartd  : TDateTime ; begin Result := GetDateTimeField('ActivityDateStartd');end;
function  Tprojecttask_activity.GetActivityDateFinished: TDateTime ; begin Result := GetDateTimeField('ActivityDateFinished');end;
function  Tprojecttask_activity.GetDone                : Boolean   ; begin Result := GetBooleanField('Done');end;
function  Tprojecttask_activity.GetEnteredByID         : Integer   ; begin Result := GetIntegerField('EnteredByID');end;
function  Tprojecttask_activity.GetEnteredBy           : string    ; begin Result := GetStringField('EnteredBy');end;
function  Tprojecttask_activity.GetActive              : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure Tprojecttask_activity.SetProjectID           (const Value: Integer   ); begin SetIntegerField('ProjectID'           ,  Value);end;
procedure Tprojecttask_activity.SetTaskID              (const Value: Integer   ); begin SetIntegerField('TaskID'              ,  Value);end;
procedure Tprojecttask_activity.SetActivityName        (const Value: string    ); begin SetStringField('ActivityName'        ,  Value);end;
procedure Tprojecttask_activity.SetActivityDescription (const Value: string    ); begin SetStringField('ActivityDescription',  Value);end;
procedure Tprojecttask_activity.SetActivityDateStartd  (const Value: TDateTime ); begin SetDateTimeField('ActivityDateStartd'  ,  Value);end;
procedure Tprojecttask_activity.SetActivityDateFinished(const Value: TDateTime ); begin SetDateTimeField('ActivityDateFinished',  Value);end;
procedure Tprojecttask_activity.SetDone                (const Value: Boolean   ); begin SetBooleanField('Done'                ,  Value);end;
procedure Tprojecttask_activity.SetEnteredByID         (const Value: Integer   ); begin SetIntegerField('EnteredByID'         ,  Value);end;
procedure Tprojecttask_activity.SetEnteredBy           (const Value: string    ); begin SetStringField('EnteredBy'           ,  Value);end;
procedure Tprojecttask_activity.SetActive              (const Value: Boolean   ); begin SetBooleanField('Active'              ,  Value);end;

{Tprojecttask_TaskLabel}

constructor Tprojecttask_TaskLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'projecttask_TaskLabel';
  fSQL := 'SELECT * FROM tblprojecttask_TaskLabel';
end;


destructor Tprojecttask_TaskLabel.Destroy;
begin
  inherited;
end;


procedure Tprojecttask_TaskLabel.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProjectID');
  SetPropertyFromNode(node,'TaskID');
  SetPropertyFromNode(node,'TaskLabelName');
  SetPropertyFromNode(node,'TaskLabelDescription');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'EnteredBy');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node, 'Color');
end;


procedure Tprojecttask_TaskLabel.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProjectID', ProjectID);
  AddXMLNode(node,'TaskID', TaskID);
  AddXMLNode(node,'TaskLabelName', TaskLabelName);
  AddXMLNode(node,'TaskLabelDescription', TaskLabelDescription);
  AddXMLNode(node,'EnteredByID', EnteredByID);
  AddXMLNode(node,'EnteredBy', EnteredBy);
  AddXMLNode(node,'Active', Active);
  AddXMLNode(node,'Color', Active);
end;


function Tprojecttask_TaskLabel.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  {
  if TaskID = 0 then begin
    Resultstatus.AddItem(False,  rssError,  0,  'TaskID should not be 0',  False );
    Exit;
  end;
  }
  Result := True;
end;


function Tprojecttask_TaskLabel.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprojecttask_TaskLabel.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tprojecttask_TaskLabel.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if sametext(Sender.fieldname,  'EnteredBy') then begin
    EnteredByID := TEmployee.IDtoggle(EnteredBy);
  end else if sametext(Sender.fieldname,  'EnteredByID')then begin
    EnteredBy := TEmployee.IDtoggle(EnteredByID);
    DoFieldOnChange(Dataset.findfield('EnteredBy'));
  end;
end;


function Tprojecttask_TaskLabel.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tprojecttask_TaskLabel.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tprojecttask_TaskLabel.GetKeyStringField: string;
begin
  Result := 'TaskLabelname';
end;

class function Tprojecttask_TaskLabel.GetBusObjectTablename: string;
begin
  Result:= 'tblprojecttask_TaskLabel';
end;


function Tprojecttask_TaskLabel.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Tprojecttask_TaskLabel.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TProjectTasks then begin
      ProjectID  := TProjectTasks(Owner).ProjectId;
      TaskID     := TProjectTasks(Owner).ID;
    end;
  Active := true;
  EnteredByID  := AppEnv.Employee.employeeId;
end;

{Property Functions}
function  Tprojecttask_TaskLabel.GetProjectID           : Integer   ; begin Result := GetIntegerField('ProjectID');end;
function  Tprojecttask_TaskLabel.GetTaskID              : Integer   ; begin Result := GetIntegerField('TaskID');end;
function  Tprojecttask_TaskLabel.GetTaskName            : String    ; begin if Assigned(Owner) and (Owner is TProjectTasks) then result := TProjectTasks(Owner).Taskname else Result := TProjectTasks.idToggle(TaskID); end;
function  Tprojecttask_TaskLabel.GetTaskLabelName       : string    ; begin Result := GetStringField('TaskLabelName');end;
function  Tprojecttask_TaskLabel.GetTaskLabelDescription: string    ; begin Result := GetStringField('TaskLabelDescription');end;
function  Tprojecttask_TaskLabel.GetEnteredByID         : Integer   ; begin Result := GetIntegerField('EnteredByID');end;
function  Tprojecttask_TaskLabel.GetEnteredBy           : string    ; begin Result := GetStringField('EnteredBy');end;
function  Tprojecttask_TaskLabel.GetActive              : Boolean   ; begin Result := GetBooleanField('Active');end;
function  Tprojecttask_TaskLabel.GetColor               : String    ; begin Result := GetStringField('Color');end;
procedure Tprojecttask_TaskLabel.SetProjectID           (const Value: Integer   ); begin SetIntegerField('ProjectID'           ,  Value);end;
procedure Tprojecttask_TaskLabel.SetTaskID              (const Value: Integer   ); begin SetIntegerField('TaskID'              ,  Value);end;
procedure Tprojecttask_TaskLabel.SetTaskLabelName       (const Value: string    ); begin SetStringField('TaskLabelName'        ,  Value);end;
procedure Tprojecttask_TaskLabel.SetTaskLabelDescription(const Value: string    ); begin SetStringField('TaskLabelDescription'        ,  Value);end;
procedure Tprojecttask_TaskLabel.SetEnteredByID         (const Value: Integer   ); begin SetIntegerField('EnteredByID'         ,  Value);end;
procedure Tprojecttask_TaskLabel.SetEnteredBy           (const Value: string    ); begin SetStringField('EnteredBy'           ,  Value);end;
procedure Tprojecttask_TaskLabel.SetActive              (const Value: Boolean   ); begin SetBooleanField('Active'              ,  Value);end;
procedure Tprojecttask_TaskLabel.SetColor               (const Value: String    ); begin SetStringField('Color'           ,  Value);end;


{Tprojecttasks}

constructor Tprojecttasks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'projecttasks';
  fSQL := 'SELECT pt.*, e.Email AS AssignEmail, e.Phone AS AssignPhone, c.Email AS ContactEmail, c.Phone AS ContactPhone ' +
          'FROM tblprojecttasks pt ' +
          'LEFT JOIN tblemployees e ON pt.AssignID=e.EmployeeID ' +
          'LEFT JOIN tblclients c ON pt.CustomerID=c.ClientID ';
end;


destructor Tprojecttasks.Destroy;
begin
  inherited;
end;


procedure Tprojecttasks.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProjectID');
  SetPropertyFromNode(node,'priority');
  SetPropertyFromNode(node,'Position');
  SetPropertyFromNode(node,'TaskName');
  SetPropertyFromNode(node,'TaskDescription');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'EnteredBy');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'Completed');
  SetDateTimePropertyFromNode(node,'due_date');
  // SetPropertyFromNode(node,'TaskID');
end;


procedure Tprojecttasks.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProjectID', ProjectID);
  AddXMLNode(node,'priority', priority);
  AddXMLNode(node,'Position', Position);
  AddXMLNode(node,'TaskName', TaskName);
  AddXMLNode(node,'TaskDescription', TaskDescription);
  AddXMLNode(node,'EnteredByID', EnteredByID);
  AddXMLNode(node,'EnteredBy', EnteredBy);
  AddXMLNode(node,'Active', Active);
  AddXMLNode(node,'Completed', Completed);
  AddXMLNode(node,'due_date', due_date);
  // AddXMLNode(node,'TaskID', TaskID);
end;


function Tprojecttasks.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  {
  if TaskName = '' then begin
    Resultstatus.AddItem(False,  rssError,  0,  'TaskName should not be blank',  False );
    Exit;
  end;
  }
  Result := True;
end;


function Tprojecttasks.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprojecttasks.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;



procedure Tprojecttasks.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if sametext(Sender.fieldname,  'EnteredBy') then begin
    EnteredByID := TEmployee.IDtoggle(EnteredBy);
  end else if sametext(Sender.fieldname,  'EnteredByID')then begin
    EnteredBy := TEmployee.IDtoggle(EnteredByID);
    DoFieldOnChange(Dataset.findfield('EnteredBy'));
  end else if sametext(Sender.fieldname,  'ProjectID')then begin
    Position := 0;
    subtasks.iteraterecords(UpdateProjectIDCallback);
    activity.iteraterecords(UpdateProjectIDCallback);
    TaskLabel.iteraterecords(UpdateProjectIDCallback);
    comments.iteraterecords(UpdateProjectIDCallback);
  end;
end;
Procedure Tprojecttasks.UpdateProjectIDCallback(Const Sender: TBusObj; var Abort: boolean);
begin
    if Sender is Tprojecttask_subtasks then begin
      // Tprojecttask_subtasks(Sender).TaskID:= ID;
      Tprojecttask_subtasks(Sender).ProjectID:= ProjectID;
    end;
//    if Sender is Tprojecttasks then begin
//      // Tprojecttasks(Sender).TaskID:= ID;
//      Tprojecttasks(Sender).ProjectID:= ProjectID;
//    end;

    if Sender is Tprojecttask_activity then begin
      Tprojecttask_activity(Sender).ProjectID:= ProjectID;
    end;

    if Sender is Tprojecttask_TaskLabel then begin
      Tprojecttask_TaskLabel(Sender).ProjectID:= ProjectID;
    end;

    if Sender is Tprojecttask_comments then begin
      Tprojecttask_comments(Sender).ProjectID:= ProjectID;
     end;
end;

function Tprojecttasks.GetSQL: string;
begin
  Result := inherited GetSQL;
end;
class function Tprojecttasks.GetIDField: string;
begin
  Result := 'ID'
end;
class function Tprojecttasks.GetKeyStringField: string;
begin
  Result := 'Taskname';
end;

class function Tprojecttasks.GetBusObjectTablename: string;
begin
  Result:= 'tblprojecttasks';
end;
function Tprojecttasks.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;
function Tprojecttasks.DoBeforePost(Sender: TDatasetBusObj): Boolean;
Function NextPostionofProject :Integer;
var
  qry :TERPQuery;
begin
  Qry := SharedQuery;
  try
    Qry.SQL.text := 'Select Max(position)  as position from tblprojecttasks where projectId = ' + inttostr(projectID);
    Qry.open;
    result := Qry.fieldbyname('position').asInteger+1;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;

  if (Position =0) then
    Position := NextPostionofProject;
  if projectId =0 then
    ProjectName := Default_projectFortasks;
end;

function Tprojecttasks.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
  begin
    if owner is TProjectList then begin
      ProjectID  := TProjectList(Owner).ID;
    end;
    if owner is Tprojecttasks then begin
      TaskID  := TProjectList(Owner).ID;
    end;
  end;
  if projectId = 0 then
      ProjectName := Default_projectFortasks;
  Active := true;
end;
function Tprojecttasks.getTaskcomments: Tprojecttask_comments;
begin
  Result := Tprojecttask_comments(getContainerComponent(Tprojecttask_comments, 'TaskID = ' + IntToStr(ID)));
end;
function Tprojecttasks.getTasksubtasks: Tprojecttask_subtasks;
begin
  Result := Tprojecttask_subtasks(getContainerComponent(Tprojecttask_subtasks, 'TaskID = ' + IntToStr(ID)));
end;
function Tprojecttasks.GetTaskactivity: Tprojecttask_activity;
begin
  Result := Tprojecttask_activity(getContainerComponent(Tprojecttask_activity, 'TaskID = ' + IntToStr(ID)));
end;
function Tprojecttasks.GetTaskTaskLabel: Tprojecttask_TaskLabel;
begin
  Result := Tprojecttask_TaskLabel(getContainerComponent(Tprojecttask_TaskLabel, 'TaskID = ' + IntToStr(ID)));
end;
function Tprojecttasks.getproject: Tprojectlist;
begin
  Result := Tprojectlist(getContainerComponent(Tprojectlist, 'ID = ' + IntToStr(ProjectID)));
end;

{Property Functions}
function  Tprojecttasks.GetProjectID       : Integer    ; begin Result := GetIntegerField('ProjectID');end;
function  Tprojecttasks.Getpriority        : Integer    ; begin Result := GetIntegerField('priority');end;
function  Tprojecttasks.GetPosition        : Integer    ; begin Result := GetIntegerField('Position');end;
function  Tprojecttasks.getProjectName     : String     ; begin if Assigned(Owner) and (Owner is Tprojectlist) then result := Tprojectlist(owner).projectname else  Result := Tprojectlist.idtoggle(ProjectID);end;
function  Tprojecttasks.GetTaskName        : string     ; begin Result := GetStringField('TaskName');end;
function  Tprojecttasks.GetTaskDescription : string     ; begin Result := GetStringField('TaskDescription');end;
function  Tprojecttasks.GetEnteredByID     : Integer    ; begin Result := GetIntegerField('EnteredByID');end;
function  Tprojecttasks.GetEnteredBy       : string     ; begin Result := GetStringField('EnteredBy');end;
function  Tprojecttasks.GetActive          : Boolean    ; begin Result := GetBooleanField('Active');end;
function  Tprojecttasks.GetCompleted       : Boolean    ; begin Result := GetBooleanField('Completed');end;
function  Tprojecttasks.Getdue_date        : TdateTime  ; begin Result := GetDatetimeField('due_date');end;
function  Tprojecttasks.GetTaskID          : Integer    ; begin Result := GetIntegerField('TaskID');end;
function  Tprojecttasks.GetCustomerID      : Integer    ; begin Result := GetIntegerField('CustomerID');end;
function  Tprojecttasks.GetLeadID          : Integer    ; begin Result := GetIntegerField('LeadID');end;
function  Tprojecttasks.GetSupplierID      : Integer    ; begin Result := GetIntegerField('SupplierID');end;
function  Tprojecttasks.GetJobID           : Integer    ; begin Result := GetIntegerField('JobID');end;
function  Tprojecttasks.GetContactName     : String     ; begin Result := GetStringField('ContactName');end;
function  Tprojecttasks.GetContactEmail    : String     ; begin Result := GetStringField('ContactEmail');end;
function  Tprojecttasks.GetContactPHone    : String     ; begin Result := GetStringField('ContactPhone');end;
function  Tprojecttasks.GetAssignID        : Integer    ; begin Result := GetIntegerField('AssignID');end;
function  Tprojecttasks.GetAssignName      : String     ; begin Result := GetStringField('AssignName');end;
function  Tprojecttasks.GetAssignEmail     : String     ; begin Result := GetStringField('AssignEmail');end;
function  Tprojecttasks.GetAssignPhone     : String     ; begin Result := GetStringField('AssignPhone');end;
function  Tprojecttasks.GetFixedAssetID    : Integer    ; begin Result := GetIntegerField('FixedAssetID');end;
function  Tprojecttasks.GetFixedAssetName  : String     ; begin Result := GetStringField('FixedAssetName');end;

procedure Tprojecttasks.SetProjectID       (const Value: Integer   ); begin SetIntegerField('ProjectID'     ,  Value);end;
procedure Tprojecttasks.Setpriority        (const Value: Integer   ); begin SetIntegerField('priority'      ,  Value);end;
procedure Tprojecttasks.SetPosition        (const Value: Integer   ); begin SetIntegerField('Position'      ,  Value);end;
procedure Tprojecttasks.SetProjectname     (const Value: String    ); begin if Assigned(Owner) and (Owner is Tprojectlist) then ProjectId :=Tprojectlist(owner).ID else  ProjectId := Tprojectlist.IDToggle(Value);end;
procedure Tprojecttasks.SetTaskName        (const Value: string    ); begin SetStringField('TaskName'       ,  Value);end;
procedure Tprojecttasks.SetTaskDescription (const Value: string    ); begin SetStringField('TaskDescription',  Value);end;
procedure Tprojecttasks.SetEnteredByID     (const Value: Integer   ); begin SetIntegerField('EnteredByID'   ,  Value);end;
procedure Tprojecttasks.SetEnteredBy       (const Value: string    ); begin SetStringField('EnteredBy'      ,  Value);end;
procedure Tprojecttasks.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'        ,  Value);end;
procedure Tprojecttasks.SetCompleted       (const Value: Boolean   ); begin SetBooleanField('Completed'     ,  Value);end;
procedure Tprojecttasks.Setdue_date        (const Value: TdateTime ); begin SetdatetimeField('due_date'     ,  Value);end;
procedure Tprojecttasks.SetTaskID          (const Value: Integer   ); begin SetIntegerField('TaskID'        ,  Value);end;
procedure Tprojecttasks.SetCustomerID      (const Value: Integer    ); begin SetIntegerField('CustomerID'   ,  Value);end;
procedure Tprojecttasks.SetLeadID          (const Value: Integer    ); begin SetIntegerField('LeadID'       ,  Value);end;
procedure Tprojecttasks.SetSupplierID      (const Value: Integer    ); begin SetIntegerField('SupplierID'   ,  Value);end;
procedure Tprojecttasks.SetJobID          (const Value: Integer    ); begin SetIntegerField('JobID'        ,  Value);end;
procedure Tprojecttasks.SetAssignID       (const Value: Integer    ); begin SetIntegerField('AssignID'     ,  Value);end;
procedure Tprojecttasks.SetContactName    (const Value: string     ); begin SetStringField('ContactName'   ,  Value);end;
procedure Tprojecttasks.SetAssignName     (const Value: string     ); begin SetStringField('AssignName'    ,  Value);end;
procedure Tprojecttasks.SetFixedAssetID   (const Value: Integer    ); begin SetIntegerField('FixedAssetID'  ,  Value);end;
procedure Tprojecttasks.SetFixedAssetName (const Value: string     ); begin SetStringField('FixedAssetName' ,  Value);end;

initialization
  RegisterClass(Tprojecttasks);
  RegisterClass(Tprojecttask_activity);
  RegisterClass(Tprojecttask_TaskLabel);
  RegisterClass(Tprojecttask_subtasks);
  RegisterClass(Tprojecttask_comments);
  RegisterClass(Tprojectlist);


end.

