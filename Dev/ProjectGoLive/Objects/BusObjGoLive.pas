unit BusObjGoLive;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/04/18  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

const
  //ModuleST    = 0;
  AdditionST  = 1;
  SummaryST   = 2;
  TaskST      = 3;
  TrainingSt  = 4;
type
  tSteptype = ((*stModule =0,*) stTask = 3, stAddition = 1, stSummary = 2 , stTraining = 4);

  TGoLiveModules = class(TMSBusObj)
  private
    fsModuleEmployees :String;
    fsModuleEmployeeIds :String;
    function GetGoLiveId            : Integer   ;
    function GetEmployeeId          : Integer   ;
    function GetEmailDaily          : Integer   ;
    function GetAppointmentId       : Integer   ;
    Function GetEmployeename        : String;
    procedure SetGoLiveId            (const Value: Integer   );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetEmailDaily          (const Value: Integer   );
    procedure SetAppointmentId       (const Value: Integer   );
    Procedure SetEmployeename        (Const Value: String    );
    function getModuleEmployees: string;
    function getModuleEmployeeIds: string;
    procedure ModuleEmployeescallback(const Sender: TBusObj;var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoBeforeInsert(Sender: TDatasetBusObj): Boolean; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property ModuleEmployees :string read getModuleEmployees;
    Property ModuleEmployeeIds :string read getModuleEmployeeIds;
  published
    property GoLiveId             :Integer     read GetGoLiveId           write SetGoLiveId        ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property EmailDaily           :Integer     read GetEmailDaily         write SetEmailDaily      ;
    property AppointmentId        :Integer     read GetAppointmentId      write SetAppointmentId   ;
    Property Employeename         :String      read getEmployeename       write setEmployeename    ;

  end;

  TGoLive = class(TMSBusObj)
  private
    FiLastStepno :Integer;
    FiLastOrderno :Integer;
    function GetEmployeeId          : Integer   ;
    function GetEmployeeName        : string    ;
    function GetModuleEmployees     : string    ;
    function GetModuleName          : string    ;
    function GetModuleId            : Integer   ;
    function Getdays                : Double    ;
    function GetHours               : Double    ;
    function GetRequiredBy          : TDateTime ;
    function GetAddition            : string    ;
    function GetDescription         : string    ;
    function GetStepNo              : Integer   ;
    function GetOrderNo             : Integer   ;
    function GetCategoryno             : Integer   ;
    function GetDone                : Boolean ;
    function GetStarted             : Boolean ;
    function GetStepType            : Integer   ;
    function GetAttachmentName      : string    ;
    function GetDoneAt              : TDateTime ;
    function GetStartedAt           : TDateTime ;
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetModuleEmployees     (const Value: string    );
    procedure SetModuleName          (const Value: string    );
    procedure SetModuleId            (const Value: Integer   );
    procedure Setdays                (const Value: Double    );
    procedure SetHours               (const Value: Double    );
    procedure SetRequiredBy          (const Value: TDateTime );
    procedure SetAddition            (const Value: string    );
    procedure SetDescription         (const Value: string    );
    procedure SetStepNo              (const Value: Integer   );
    procedure SetOrderNo             (const Value: Integer   );
    procedure SetCategoryno             (const Value: Integer   );
    procedure SetDone                (const Value: Boolean   );
    procedure SetStarted             (const Value: Boolean   );
    procedure SetStepType            (const Value: Integer   );
    procedure SetAttachmentName      (const Value: string    );
    procedure SetDoneAt              (const Value: TDateTime );
    procedure SetStartedAt           (const Value: TDateTime );
    function getGoLiveModules: TGoLiveModules;
    function getModuleStepType: tSteptype;
    procedure SetModuleStepType(const Value: tSteptype);
    function StepTypetoInt(const Value: TSteptype): Integer;
    Function GetLastStepno:Integer;
    Function GetLastOrderno:Integer;
    function getAttachmentnames: String;
    function getSteptypeStr: String;
    function getCategory: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;Override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoBeforeInsert(Sender: TDatasetBusObj): Boolean; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property     ModuleStepType : tSteptype read getModuleStepType Write SetModuleStepType;
    Procedure NewItem(Const Value :tSteptype);
    function InstToSteptype(const Value: Integer): TSteptype;
    Property Attachmentnames :String read getAttachmentnames;
    Property SteptypeStr :String read getSteptypeStr;
    Property Category:String read getCategory;
  published
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    property ModuleEmployees      :string      read GetModuleEmployees    write SetModuleEmployees ;
    property ModuleName           :string      read GetModuleName         write SetModuleName ;
    property ModuleId             :Integer     read GetModuleId           write SetModuleId        ;
    property days                 :Double      read Getdays               write Setdays            ;
    property Hours                :Double      read GetHours              write SetHours           ;
    property RequiredBy           :TDateTime   read GetRequiredBy         write SetRequiredBy      ;
    property Addition             :string      read GetAddition           write SetAddition        ;
    property Description          :string      read GetDescription        write SetDescription     ;
    property StepNo               :Integer     read GetStepNo             write SetStepNo          ;
    property OrderNo              :Integer     read GetOrderNo            write SetOrderNo         ;
    property Categoryno           :Integer     read GetCategoryno         write SetCategoryno      ;
    property ItemDone             :Boolean     read GetDone               write SetDone            ;
    property ItemStarted          :Boolean     read GetStarted            write SetStarted         ;
    property StepType             :Integer     read GetStepType           write SetStepType        ;
    property AttachmentName       :string      read GetAttachmentName     write SetAttachmentName  ;
    property DoneAt               :TDateTime   read GetDoneAt             write SetDoneAt          ;
    property StartedAt            :TDateTime   read GetStartedAt          write SetStartedAt       ;
    Property GoLiveModules : TGoLiveModules read getGoLiveModules;
  end;


implementation


uses tcDataUtils, CommonLib, BusObjEmployee , SysUtils, BusobjTraining,
  AppEnvironment, DbSharedObjectsObj,ERPdbComponents;



  {TGoLive}

constructor TGoLive.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GoLive';
  fSQL := 'SELECT * FROM tblgolive';
  fSQLOrder := 'Categoryno, Orderno';
  FiLastStepno := 0;
  FiLastOrderno := 0;
end;


destructor TGoLive.Destroy;
begin
  inherited;
end;


procedure TGoLive.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'ModuleEmployees');
  SetPropertyFromNode(node,'ModuleName');
  SetPropertyFromNode(node,'ModuleId');
  SetPropertyFromNode(node,'days');
  SetPropertyFromNode(node,'Hours');
  SetDateTimePropertyFromNode(node,'RequiredBy');
  SetPropertyFromNode(node,'Addition');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'StepNo');
  SetPropertyFromNode(node,'OrderNo');
  SetPropertyFromNode(node,'Categoryno');
  SetBooleanPropertyFromNode(node,'ItemDone');
  SetBooleanPropertyFromNode(node,'ItemStarted');
  SetPropertyFromNode(node,'StepType');
  SetPropertyFromNode(node,'AttachmentName');
  SetDateTimePropertyFromNode(node,'DoneAt');
  SetDateTimePropertyFromNode(node,'StartedAt');
end;

procedure TGoLive.NewItem(const Value: tSteptype);
begin
  Postdb;
  New;
  ModuleStepType := Value;
  EmployeeId := Appenv.Employee.EmployeeID;
  PostDb;
end;

procedure TGoLive.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'ModuleEmployees' ,ModuleEmployees);
  AddXMLNode(node,'ModuleName' ,ModuleName);
  AddXMLNode(node,'ModuleId' ,ModuleId);
  AddXMLNode(node,'days' ,days);
  AddXMLNode(node,'Hours' ,Hours);
  AddXMLNode(node,'RequiredBy' ,RequiredBy);
  AddXMLNode(node,'Addition' ,Addition);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'StepNo' ,StepNo);
  AddXMLNode(node,'OrderNo' ,OrderNo);
  AddXMLNode(node,'Categoryno' ,Categoryno);
  AddXMLNode(node,'Done' ,ItemDone);
  AddXMLNode(node,'Started' ,ItemStarted);
  AddXMLNode(node,'StepType' ,StepType);
  AddXMLNode(node,'AttachmentName' ,AttachmentName);
  AddXMLNode(node,'DoneAt' ,DoneAt);
  AddXMLNode(node,'StartedAt' ,StartedAt);
end;


function TGoLive.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TGoLive.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if result then
    Dirty := false;
end;


procedure TGoLive.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  GoLiveModules;
end;

function TGoLive.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGoLive.GetIDField: string;
begin
  Result := 'GoLiveId'
end;


class function TGoLive.GetBusObjectTablename: string;
begin
  Result:= 'tblgolive';
end;


function TGoLive.getCategory: String;
var
  ctr:Integer;
begin
  REsult := Addition ;
  for ctr := 1 to 9 do
    result := replacestr(result ,'Phase ' +trim(inttostr(ctr))+':', '');
end;

function TGoLive.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Stepno      := FiLastStepno + 1;
  Orderno     := FiLastOrderno + 1;
end;

function TGoLive.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  GoLiveModules;
end;


function TGoLive.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoBeforeInsert(Sender);
  If Not Result Then Exit;
  FiLastStepno := GetLastStepno;
  FiLastOrderno := GetLastOrderno;

end;

function TGoLive.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  result := true;
  ModuleEmployees := GoLiveModules.ModuleEmployees;
  if days =0 then begin
    if Hours <> 0 then Hours :=0;
  end else if hours <> days *24 then hours := days *24;
end;

function TGoLive.getGoLiveModules: TGoLiveModules;
begin
  result := TGoLiveModules(GetContainerComponent(TGoLiveModules ,'GoLiveId = ' + IntToStr(ID) ));
end;

Function TGoLive.StepTypetoInt(Const Value :TSteptype):Integer;
begin
        (*if value = stModule   then result := Modulest
  else  *)if value = stTask     then result :=  Taskst
  else  if value = stAddition then result :=  Additionst
  else  if value = stSummary  then result :=  Summaryst
  else  if value = stTraining   then result := TrainingSt
  else result := Taskst;
end;

Function TGoLive.InstToSteptype(Const Value :Integer):TSteptype;
begin
        (*if value = Modulest   then result := stModule
  else  *)if value = TrainingSt then result := stTraining
  else  if value = Taskst     then result := stTask
  else  if value = Additionst then result := stAddition
  else  if value = Summaryst  then result := stSummary
  else result := stTask;
end;
function TGoLive.GetLastStepno: Integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    qry.SQL.text := 'Select max(Stepno) as stepno from tblgolive';
    qry.open;
    result := qry.fieldbyname('stepno').asInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TGoLive.GetLastOrderno: Integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    qry.SQL.text := 'Select max(Orderno) as Orderno from tblgolive';
    qry.open;
    result := qry.fieldbyname('Orderno').asInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TGoLive.getAttachmentnames: String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    qry.SQL.text := 'Select AttachmentName from tblattachments where TableName = '+quotedstr(BusObjectTablename) +' and TableId =' + inttostr(ID);
    qry.open;
    result := qry.groupconcat('AttachmentName');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TGoLive.getSteptypeStr: String;
begin
        (*if ModuleSteptype = stModule   then result := 'Module'
  else  *)if ModuleSteptype = stTraining then result := 'Training'
  else  if ModuleSteptype = stTask     then result := 'Task'
  else  if ModuleSteptype = stAddition then result := 'Addition'
  else  if ModuleSteptype = stSummary  then result := 'Summary'
  else result := 'Module';

end;

{Property Functions}
function  TGoLive.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TGoLive.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  TGoLive.GetModuleEmployees : string    ; begin Result := GetStringField('ModuleEmployees');end;
function  TGoLive.GetModuleName      : string    ; begin Result := GetStringField('ModuleName');end;
function  TGoLive.GetModuleId        : Integer   ; begin Result := GetIntegerField('ModuleId');end;
function  TGoLive.Getdays            : Double    ; begin Result := GetFloatField('days');end;
function  TGoLive.GetHours           : Double    ; begin Result := GetFloatField('Hours');end;
function  TGoLive.GetRequiredBy      : TDateTime ; begin Result := GetDateTimeField('RequiredBy');end;
function  TGoLive.GetAddition        : string    ; begin Result := GetStringField('Addition');end;
function  TGoLive.GetDescription     : string    ; begin Result := GetStringField('Description');end;
function  TGoLive.GetStepNo          : Integer   ; begin Result := GetIntegerField('StepNo');end;
function  TGoLive.GetOrderNo         : Integer   ; begin Result := GetIntegerField('OrderNo');end;
function  TGoLive.GetCategoryno      : Integer   ; begin Result := GetIntegerField('Categoryno');end;
function  TGoLive.GetDone            : Boolean   ; begin Result := GetBooleanField('Done');end;
function  TGoLive.GetStarted         : Boolean   ; begin Result := GetBooleanField('Started');end;
function  TGoLive.GetStepType        : Integer   ; begin Result := GetIntegerField('StepType');end;
function  TGoLive.GetAttachmentName  : string    ; begin Result := GetStringField('AttachmentName');end;
function  TGoLive.getModuleStepType  : tSteptype ; begin result := InstToSteptype(StepType);end;
function  TGoLive.GetDoneAt          : TDateTime ; begin Result := GetDateTimeField('DoneAt');end;
function  TGoLive.GetStartedAt       : TDateTime ; begin Result := GetDateTimeField('StartedAt');end;
procedure TGoLive.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TGoLive.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure TGoLive.SetModuleEmployees (const Value: string    ); begin SetStringField('ModuleEmployees'  , Value);end;
procedure TGoLive.SetModuleName      (const Value: string    ); begin SetStringField('ModuleName'  , Value);end;
procedure TGoLive.SetModuleId        (const Value: Integer   ); begin SetIntegerField('ModuleId'         , Value);end;
procedure TGoLive.Setdays            (const Value: Double    ); begin SetFloatField('days'             , Value);end;
procedure TGoLive.SetHours           (const Value: Double    ); begin SetFloatField('Hours'            , Value);end;
procedure TGoLive.SetRequiredBy      (const Value: TDateTime ); begin SetDateTimeField('RequiredBy'       , Value);end;
procedure TGoLive.SetAddition        (const Value: string    ); begin SetStringField('Addition'         , Value);end;
procedure TGoLive.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;
procedure TGoLive.SetStepNo          (const Value: Integer   ); begin SetIntegerField('StepNo'           , Value);end;
procedure TGoLive.SetOrderNo         (const Value: Integer   ); begin SetIntegerField('OrderNo'          , Value);end;
procedure TGoLive.SetCategoryno      (const Value: Integer   ); begin SetIntegerField('Categoryno'       , Value);end;
procedure TGoLive.SetDone            (const Value: Boolean   ); begin SetBooleanField('Done'             , Value);end;
procedure TGoLive.SetStarted         (const Value: Boolean   ); begin SetBooleanField('Started'          , Value);end;
procedure TGoLive.SetStepType        (const Value: Integer   ); begin SetIntegerField('StepType'         , Value);end;
procedure TGoLive.SetAttachmentName  (const Value: string    ); begin SetStringField('AttachmentName'   , Value);end;
procedure TGoLive.SetDoneAt          (const Value: TDateTime ); begin SetDateTimeField('DoneAt'          , Value);end;
procedure TGoLive.SetStartedAt       (const Value: TDateTime ); begin SetDateTimeField('StartedAt'        , Value);end;
procedure TGoLive.SetModuleStepType  (const Value: tSteptype ); begin Steptype := StepTypetoInt(Value);end;
procedure TGoLive.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.fieldname, 'Employeename') then begin
    EmployeeId:= TEmployee.idtoggle(EmployeeName);
  end else if sametext(Sender.fieldname, 'EmployeeId') then begin
   Employeename:= TEmployee.idtoggle(EmployeeId);
  end else if sametext(Sender.fieldname, 'Modulename') then begin
    ModuleId:= TTrainingModules.idtoggle(ModuleName);
  end else if sametext(Sender.fieldname, 'ModuleId') then begin
   Modulename:= TTrainingModules.idtoggle(ModuleId);
  end else if sametext(Sender.fieldname, 'Steptype') then begin
    if (moduleSteptype = stAddition) or (moduleSteptype = stSummary) then
      Stepno      := 0;
  end else if sametext(Sender.fieldname, 'done') then begin
    if ItemDone then DoneAt := now
    else DoneAt := 0;
  end else if sametext(Sender.fieldname, 'Started') then begin
    if ItemStarted then StartedAt := now
    else StartedAt := 0;
  end else if sametext(Sender.fieldname, 'doneAt') then begin
    if doneAt <> 0 then ItemDone  := True;
  end else if sametext(Sender.fieldname, 'Started') then begin
    if StartedAt <> 0 then ItemStarted  := True;
  end;
end;



  {TGoLiveModules}

constructor TGoLiveModules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GoLiveModules';
  fSQL := 'SELECT * FROM tblgolivemodules';
end;


destructor TGoLiveModules.Destroy;
begin
  inherited;
end;


procedure TGoLiveModules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'GoLiveId');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'EmailDaily');
  SetPropertyFromNode(node,'AppointmentId');
  SetPropertyFromNode(node,'Employeename');
end;


procedure TGoLiveModules.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'GoLiveId' ,GoLiveId);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'EmailDaily' ,EmailDaily);
  AddXMLNode(node,'AppointmentId' ,AppointmentId);
  AddXMLNode(node,'Employeename' ,Employeename);

end;


function TGoLiveModules.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TGoLiveModules.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TGoLiveModules.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TGoLiveModules.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.fieldname, 'Employeename') then begin
    EmployeeId:= TEmployee.idtoggle(EmployeeName);
  end else if sametext(Sender.fieldname, 'EmployeeId') then begin
   Employeename:= TEmployee.idtoggle(EmployeeId);
  end;
end;


function TGoLiveModules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGoLiveModules.GetIDField: string;
begin
  Result := 'GoLiveModuleId'
end;
function TGoLiveModules.getModuleEmployees: string;
begin
   fsModuleEmployees := '';
   IterateRecords(ModuleEmployeescallback);
   REsult :=fsModuleEmployees;

end;
function TGoLiveModules.getModuleEmployeeIds: string;
begin
   fsModuleEmployeeIds := '';
   IterateRecords(ModuleEmployeescallback);
   REsult :=fsModuleEmployeeIds;

end;
Procedure TGoLiveModules.ModuleEmployeescallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TGoLiveModules then begin
     if fsModuleEmployees <> '' then fsModuleEmployees := fsModuleEmployees +',' ;
     fsModuleEmployees := fsModuleEmployees + trim(EmployeeName);
     if fsModuleEmployeeIds <> '' then fsModuleEmployeeIds := fsModuleEmployeeIds +',' ;
     fsModuleEmployeeIds := fsModuleEmployeeIds + trim(inttostr(EmployeeID));
  end;
end;

class function TGoLiveModules.GetBusObjectTablename: string;
begin
  Result:= 'tblgolivemodules';
end;


function TGoLiveModules.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) and (Owner is TGoLive) then begin
       GoLiveId := TGoLive(Owner).ID;
  end;
end;

function TGoLiveModules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TGoLiveModules.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoBeforeInsert(Sender);
  If Not Result Then Exit;
end;

{Property Functions}
function  TGoLiveModules.GetGoLiveId        : Integer   ; begin Result := GetIntegerField('GoLiveId');end;
function  TGoLiveModules.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TGoLiveModules.GetEmailDaily      : Integer   ; begin Result := GetIntegerField('EmailDaily');end;
function  TGoLiveModules.GetAppointmentId   : Integer   ; begin Result := GetIntegerField('AppointmentId');end;
function  TGoLiveModules.GetEmployeename    : String    ; begin Result := GetStringField('Employeename');end;

procedure TGoLiveModules.SetGoLiveId        (const Value: Integer   ); begin SetIntegerField('GoLiveId'         , Value);end;
procedure TGoLiveModules.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TGoLiveModules.SetEmailDaily      (const Value: Integer   ); begin SetIntegerField('EmailDaily'       , Value);end;
procedure TGoLiveModules.SetAppointmentId   (const Value: Integer   ); begin SetIntegerField('AppointmentId'    , Value);end;
procedure TGoLiveModules.SetEmployeename    (const Value: String    ); begin SetStringField('Employeename'     , Value);end;



initialization
  RegisterClass(TGoLiveModules);
  RegisterClass(TGoLive);


end.
