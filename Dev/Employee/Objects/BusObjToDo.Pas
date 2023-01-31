unit BusObjToDo;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  09/12/09  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TToDoLines = class(TMSBusObj)
  private
    function GetToDoID         : Integer   ;
    function GetDateCreated    : TDateTime ;
    function GetResponded      : TDateTime ;
    function GetResults        : string    ;
    function GetDone           : Boolean   ;
    function GetDeleted           : Boolean   ;
    Function GetTotal:String;
    procedure SetToDoID         (const Value: Integer   );
    procedure SetDateCreated    (const Value: TDateTime );
    procedure SetResponded      (const Value: TDateTime );
    procedure SetResults        (const Value: string    );
    procedure SetDone           (const Value: Boolean   );
    procedure SetDeleted           (const Value: Boolean   );
    Procedure SetTotal(const Value:String);
    Procedure InitDateCretedFromHeader;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
    function GetIsList: Boolean; override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    class function _Schema: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property ToDoID          :Integer     read GetToDoID        write SetToDoID     ;
  published
    property DateCreated     :TDateTime   read GetDateCreated   write SetDateCreated;
    property Responded       :TDateTime   read GetResponded     write SetResponded  ;
    property Results         :string      read GetResults       write SetResults    ;
    property Done            :Boolean     read GetDone          write SetDone       ;
    property Deleted            :Boolean     read GetDeleted          write SetDeleted       ;
    Property Total :String read getTotal Write setTotal;
  end;

  TToDo = class(TMSBusObj)
  private
    dtLastResponsedate:TDatetime;
    fitotalTime:Integer;
    AllLinesok:Boolean;
    function GetCreatedDate            : TDateTime ;
    function GetEmployeeID             : Integer   ;
    function GetDescription            : string    ;
    function GetToDoByDate             : TDateTime ;
    function GetDone                   : Boolean   ;
    function GetAppearDays             : Integer   ;
    function GetResult                 : string    ;
    function GetCreatedByEmployeeID    : Integer   ;
    function GetPOID                   : Integer   ;
    function GetCompleted              : Boolean   ;
    function GetActive                 : Boolean   ;
    function GetTodotype               : string    ;
    function GetOtherID                : Integer   ;
    procedure SetCreatedDate            (const Value: TDateTime );
    procedure SetEmployeeID             (const Value: Integer   );
    procedure SetDescription            (const Value: string    );
    procedure SetToDoByDate             (const Value: TDateTime );
    procedure SetDone                   (const Value: Boolean   );
    procedure SetAppearDays             (const Value: Integer   );
    procedure SetResult                 (const Value: string    );
    procedure SetCreatedByEmployeeID    (const Value: Integer   );
    procedure SetPOID                   (const Value: Integer   );
    procedure SetCompleted              (const Value: Boolean   );
    procedure SetActive                 (const Value: Boolean   );
    procedure SetTodotype               (const Value: string    );
    procedure SetOtherID                (const Value: Integer   );
    function getTToDoLines: TToDoLines;
    function AnyLineDone :Boolean;
    Procedure AnyLineDoneCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ValidateCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure DeleteFlaggedLines;
    function getClientID: Integer;
    procedure setClientID(const Value: Integer);
    function GetClientName: string;
    procedure SetClientName(const Value: string);
    function GetCreatedByEmployeeName: string;
    function GetEmployeeName: string;
    function GetPhoneSupportLogID: integer;
    procedure SetCreatedByEmployeeName(const Value: string);
    procedure SetEmployeeName(const Value: string);
    procedure SetPhoneSupportLogID(const Value: integer);
    procedure LastResponsedateCallback(const Sender: TBusObj;var Abort: Boolean);
    procedure totalTimeCallback(const Sender: TBusObj;var Abort: Boolean);
    function GetShowReminder: boolean;
    procedure SetShowReminder(const Value: boolean);
    function GetLinkTo: string;
    function GetLinkToID: integer;
    procedure SetLinkTo(const Value: string);
    procedure SetLinkToID(const Value: integer);
    function getisSmartorPurchaseOrderToDO: Boolean;
    function getIsSmartOrderApprovalRequest: Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
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
    class function _Schema: string; override;
    function LastResponsedate :TDateTime;
    function totalTime :Integer;
    property Lines: TToDoLines read GetTToDoLines;
    Property isSmartorPurchaseOrderToDO :Boolean read getisSmartorPurchaseOrderToDO;
    Property IsSmartOrderApprovalRequest :Boolean read getIsSmartOrderApprovalRequest;
  published
    property CreatedDate             :TDateTime   read GetCreatedDate           write SetCreatedDate        ;
    property EmployeeID              :Integer     read GetEmployeeID            write SetEmployeeID         ;
    property EmployeeName            :string      read GetEmployeeName          write SetEmployeeName;
    property Description             :string      read GetDescription           write SetDescription        ;
    property ToDoByDate              :TDateTime   read GetToDoByDate            write SetToDoByDate         ;
    property Done                    :Boolean     read GetDone                  write SetDone               ;
    property AppearDays              :Integer     read GetAppearDays            write SetAppearDays         ;
    property Result                  :string      read GetResult                write SetResult             ;
    property CreatedByEmployeeID     :Integer     read GetCreatedByEmployeeID   write SetCreatedByEmployeeID;
    property CreateedByEmployeeName  :string      read GetCreatedByEmployeeName write SetCreatedByEmployeeName;
    property POID                    :Integer     read GetPOID                  write SetPOID               ;
    property Completed               :Boolean     read GetCompleted             write SetCompleted          ;
    property Active                  :Boolean     read GetActive                write SetActive             ;
    property ToDoType                :string      read GetTodotype              write SetTodotype           ;
    property OtherID                 :Integer     read GetOtherID               write SetOtherID            ;
    property PhoneSupportLogID       :integer     read GetPhoneSupportLogID     write SetPhoneSupportLogID;
    property ShowReminder            :boolean     read GetShowReminder          write SetShowReminder;
    property ClientID                :Integer     read getClientID              write setClientID;
    property ClientName              :string      read GetClientName            write SetClientName;
    property LinkTo                  :string      read GetLinkTo                write SetLinkTo;
    property LinkToID                :integer     read GetLinkToID              write SetLinkToID;
  end;


implementation


uses
  tcDataUtils, CommonLib, AppEnvironment, {EmployeeObj,} sysutils,
  BusObjSchemaLib, BusObjEmployee, BusObjClient, BusObjPhoneSupportLog , dateutils, BusObjMarketingLeads,
  BusObjectListObj, tcConst;


  {TToDo}

constructor TToDo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ToDo';
  fSQL := 'SELECT * FROM tbltodo';
  ExportExcludeList.Add('POID');
  ExportExcludeList.Add('OtherID');
end;


destructor TToDo.Destroy;
begin
  inherited;
end;


function TToDo.LastResponsedate: TDateTime;
begin
  dtLastResponsedate := 0;
  Lines.IterateRecords(LastResponsedatecallback);
  result := dtLastResponsedate;
end;
Procedure TToDo.LastResponsedateCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTODoLines) then exit;
  if dtLastResponsedate < TTodoLines(Sender).Responded then
    dtLastResponsedate :=TTodoLines(Sender).Responded ;
end;

procedure TToDo.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'CreatedDate');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'Description');
  SetDateTimePropertyFromNode(node,'ToDoByDate');
  SetBooleanPropertyFromNode(node,'Done');
  SetPropertyFromNode(node,'AppearDays');
  SetPropertyFromNode(node,'Result');
  SetPropertyFromNode(node,'CreatedByEmployeeID');
  SetPropertyFromNode(node,'POID');
  SetBooleanPropertyFromNode(node,'Completed');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'Todotype');
  SetPropertyFromNode(node,'OtherID');
  SetBooleanPropertyFromNode(node,'ShowReminder');
end;


procedure TToDo.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CreatedDate' ,CreatedDate);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'ToDoByDate' ,ToDoByDate);
  AddXMLNode(node,'Done' ,Done);
  AddXMLNode(node,'AppearDays' ,AppearDays);
  AddXMLNode(node,'Result' ,Result);
  AddXMLNode(node,'CreatedByEmployeeID' ,CreatedByEmployeeID);
  AddXMLNode(node,'POID' ,POID);
  AddXMLNode(node,'Completed' ,Completed);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Todotype' ,Todotype);
  AddXMLNode(node,'OtherID' ,OtherID);
  AddXMLNode(node,'ShowReminder', ShowReminder);
end;


function TToDo.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Description = ''  then begin
    Resultstatus.AddItem(False , rssError , 0,  'Description should not be blank' , true );
    Exit;
  end;
  if employeeId = 0  then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be blank' , true );
    Exit;
  end;
  if ToDoByDate =0 then ToDoByDate:= incday(CreatedDate , 1);
  AllLinesok := true;
  Lines.IterateRecords(ValidateCallback);
  DeleteFlaggedLines;
  if allLinesok = False then Exit;

  Result := True;
end;


class function TToDo._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp', 'EmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp', 'EmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_2', 'CreatedByEmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_2', 'CreatedByEmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TClient', 'client', 'ClientID', 'ID');
  TBOSchema.AddRefType(Result, 'TClient', 'client', 'ClientName', 'ClientName');
//  TBOSchema.AddRefType(Result, 'TPhoneSupportLog', 'support_log', 'PhoneSupportLogID', 'ID');
end;

function TToDo.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  done := AnyLineDone;
  PostDB;
  Result := inherited Save;
  if not result then exit;
  TLeadToAddProgressionRecord.AddProgressionRecord(ClientID, LeadActionToDo, Id, GlobalRef, Description, CreatedDate, Id, globalref, true, EmployeeId);
end;


procedure TToDo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TToDo.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  If Sysutils.SameText(Sender.FieldName , 'CreatedDate') then begin
      ToDoByDate:= incday(CreatedDate , 1);
  end;
end;


function TToDo.GetShowReminder: boolean;
begin
  result := GetBooleanField('ShowReminder');
end;

function TToDo.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TToDo.GetIDField: string;
begin
  Result := 'ToDoID'
end;

function TToDo.getisSmartorPurchaseOrderToDO: Boolean;
begin
  REsult := False;
  if LinkTo = 'Smart Order' then
    if (pos(APPROVALREQUESTDESC     , Description)> 0) Or
       (pos(NOTAPPROVEDREMINDERDESC , Description)> 0) then begin
      Result := True;
      Exit;
    end;
  if (LinkTo = 'Purchase Order')  then
    if (pos(POCREATEDFORSO     , Description)> 0)  then begin
      REsult := True;
      Exit;
    end;

  if  (Linkto = 'Purchase Order Change') then
    if (pos('Changes to Purchase Order'     , Description)> 0)  then begin
      REsult := True;
      Exit;
    end;

end;
function TToDo.getIsSmartOrderApprovalRequest: Boolean;
begin
  REsult := False;
  if LinkTo = 'Smart Order' then
    if (pos(APPROVALREQUESTDESC     , Description)> 0) Or
       (pos(NOTAPPROVEDREMINDERDESC , Description)> 0) then begin
      Result := True;
      Exit;
    end;
end;


class function TToDo.GetKeyStringField: string;
begin
  result:= '';
end;

function TToDo.GetLinkTo: string;
begin
  result := GetStringField('LinkTo');
end;

function TToDo.GetLinkToID: integer;
begin
  result := GetIntegerField('LinkToID');
end;

class function TToDo.GetBusObjectTablename: string;
begin
  Result:= 'tbltodo';
end;


function TToDo.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TToDo.GetCreatedDate        : TDateTime ; begin Result := GetDateTimeField('CreatedDate');end;
function  TToDo.GetEmployeeID         : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TToDo.GetDescription        : string    ; begin Result := GetStringField('Description');end;
function  TToDo.GetToDoByDate         : TDateTime ; begin Result := GetDateTimeField('ToDoByDate');end;
function  TToDo.GetDone               : Boolean   ; begin Result := GetBooleanField('Done');end;
function  TToDo.GetAppearDays         : Integer   ; begin Result := GetIntegerField('AppearDays');end;
function  TToDo.GetResult             : string    ; begin Result := GetStringField('Result');end;
function  TToDo.GetCreatedByEmployeeID: Integer   ; begin Result := GetIntegerField('CreatedByEmployeeID');end;
function  TToDo.GetPOID               : Integer   ; begin Result := GetIntegerField('POID');end;
function  TToDo.GetClientName         : string    ; begin result:= TClient.IDToggle(ClientID,Connection.Connection);end;
function  TToDo.GetCompleted          : Boolean   ; begin Result := GetBooleanField('Completed');end;
function  TToDo.GetActive             : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TToDo.GetTodotype           : string    ; begin Result := GetStringField('Type');end;
function  TToDo.GetOtherID            : Integer   ; begin Result := GetIntegerField('OtherID');end;
function  TToDo.GetEmployeeName       : string    ; begin result := TEmployee.IDToggle(EmployeeID,Connection.Connection);end;
function  TToDo.getClientID           : Integer   ; begin Result := getintegerfield('ClientID');end;
function  TToDo.GetCreatedByEmployeeName: string;begin  result:= TEmployee.IDToggle(CreatedByEmployeeID,Connection.Connection);end;
procedure TToDo.SetCreatedDate        (const Value: TDateTime ); begin SetDateTimeField('CreatedDate'         , Value);end;
procedure TToDo.SetEmployeeID         (const Value: Integer   ); begin SetIntegerField('EmployeeID'          , Value);end;
procedure TToDo.SetEmployeeName       (const Value: string);begin  EmployeeID:= TEmployee.IDToggle(Value,Connection.Connection);end;
procedure TToDo.SetLinkTo(const Value: string);
begin
  SetStringField('LinkTo', Value);
end;

procedure TToDo.SetLinkToID(const Value: integer);
begin
  SetIntegerField('LinkToID', Value);
end;

procedure TToDo.SetDescription        (const Value: string    ); begin SetStringField('Description'         , Value);end;
procedure TToDo.SetToDoByDate         (const Value: TDateTime ); begin SetDateTimeField('ToDoByDate'          , Value);end;
procedure TToDo.SetDone               (const Value: Boolean   ); begin SetBooleanField('Done'                , Value);end;
procedure TToDo.SetAppearDays         (const Value: Integer   ); begin SetIntegerField('AppearDays'          , Value);end;
procedure TToDo.SetResult             (const Value: string    ); begin SetStringField('Result'              , Value);end;
procedure TToDo.SetCompleted          (const Value: Boolean   ); begin SetBooleanField('Completed'           , Value);end;
procedure TToDo.SetActive             (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TToDo.SetTodotype           (const Value: string    ); begin SetStringField('Type'                , Value);end;
procedure TToDo.SetShowReminder       (const Value: boolean   ); begin SetBooleanField('ShowReminder',Value);end;
procedure TToDo.SetCreatedByEmployeeID(const Value: Integer   ); begin SetIntegerField('CreatedByEmployeeID'              , Value);end;
procedure TToDo.SetCreatedByEmployeeName(const Value: string  ); begin CreatedByEmployeeID:= TEmployee.IDToggle(Value,Connection.Connection);end;
procedure TToDo.SetPOID               (const Value: Integer   ); begin SetIntegerField('POID'                , Value);end;
procedure TToDo.SetOtherID            (const Value: Integer   ); begin SetIntegerField('OtherID'             , Value);end;
procedure TToDo.setClientID           (const Value: Integer   ); begin SetIntegerField('ClientID',value);end;

function TToDo.GetPhoneSupportLogID: integer;
begin
  result:= 0;
  if SameText(ToDoType,'Support') then
    result:= self.GetOtherID;
end;


procedure TToDo.SetPhoneSupportLogID(const Value: integer);
begin
  self.OtherID:= Value;
  if Value > 0 then
    self.ToDoType:= 'Support';
end;


procedure TToDo.SetClientName(const Value: string);
begin
  ClientID:= TClient.IDToggle(Value,Connection.Connection);
end;

function TToDo.totalTime: Integer;
begin
  fitotalTime :=0;
  Lines.IterateRecords(totalTimeCallback);
  result := fitotalTime;
end;

procedure TToDo.totalTimeCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTODoLines) then exit;
    fitotalTime :=fitotalTime + secondsBetween(TTodoLines(Sender).DateCreated,  TTodoLines(Sender).Responded );
end;

function TToDo.getTToDoLines: TToDoLines;
begin
  Result := TToDoLines(getContainerComponent(TToDoLines, 'ToDoID = '+ IntToStr(Self.Id)));
end;

function TToDo.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  Completed := False;
  Active := TRue;
  CreatedByEmployeeID := Appenv.Employee.EmployeeID;
  EmployeeID := Appenv.Employee.EmployeeID;
  CreatedDate:= Now;
  ToDoByDate:= incday(Now() , 1);
  Done := False;
  if Assigned(self.Owner) then
    if self.Owner is TPhoneSupportLog then begin
      self.PhoneSupportLogID:= TPhoneSupportLog(Owner).ID;
    end;
end;

function TToDo.AnyLineDone: Boolean;
begin
  AllLinesok := False;
  Lines.IterateRecords(AnyLineDoneCallback);
  result := AllLinesok;
end;

procedure TToDo.AnyLineDoneCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (sender is TToDoLines) then exit;
  if TTodoLines(SendeR).Done then begin
      AllLinesok:= true;
      abort := True;
  end;
end;

procedure TToDo.ValidateCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (sender is TToDoLines) then exit;
  if not TTodoLines(SendeR).ValidateData then begin
      AllLinesok:= False;
      abort := True;
  end;
end;

procedure TToDo.DeleteFlaggedLines;
begin
  if Lines.count = 0 then exit;
  Lines.first;
  while Lines.Eof = False do begin
    if Lines.Deleted then begin
        Lines.Delete;
    end else begin
        Lines.Next;
    end;
    Lines.Next;
  end;
end;


{TToDoLines}

constructor TToDoLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ToDoLines';
  fSQL := 'SELECT * FROM tbltodolines';
end;


destructor TToDoLines.Destroy;
begin
  inherited;
end;


procedure TToDoLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ToDoID');
  SetDateTimePropertyFromNode(node,'DateCreated');
  SetDateTimePropertyFromNode(node,'Responded');
  SetPropertyFromNode(node,'Results');
  SetBooleanPropertyFromNode(node,'Done');
  SetBooleanPropertyFromNode(node,'Deleted');
end;


procedure TToDoLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ToDoID' ,ToDoID);
  AddXMLNode(node,'DateCreated' ,DateCreated);
  AddXMLNode(node,'Responded' ,Responded);
  AddXMLNode(node,'Results' ,Results);
  AddXMLNode(node,'Done' ,Done);
  AddXMLNode(node,'Deleted' ,Deleted);
end;


function TToDoLines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  if results = '' then
    if done = False then Deleted:= true;
  if Responded > now then Responded := now;
  if Datecreated > now then Datecreated := now;
  if Responded    < Datecreated then Responded:= Datecreated ;
  Result := True;
end;


class function TToDoLines._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TTODo', 'Todo', 'TODoID', 'ID');
end;

function TToDoLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TToDoLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TToDoLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  If Sysutils.SameText(Sender.FieldName , 'REsults') then begin
    if not RawMode then begin
      InitDateCretedFromHeader;
    end;
  end else If Sysutils.SameText(Sender.FieldName , 'Datecreated') then begin
    if Datecreated  > now         then Datecreated := now;
    if Responded    < Datecreated then Responded := Datecreated ;
  end else If Sysutils.SameText(Sender.FieldName , 'Responded') then begin
    if Responded >  now         then Responded := now;
    if Responded <  Datecreated then Datecreated := Responded ;
  end;
end;


function TToDoLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TToDoLines.GetIDField: string;
begin
  Result := 'ID'
end;


function TToDoLines.GetIsList: Boolean;
begin
  result:= true;
end;

class function TToDoLines.GetKeyStringField: string;
begin
  result:= '';
end;

class function TToDoLines.GetBusObjectTablename: string;
begin
  Result:= 'tbltodolines';
end;

function TToDoLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  InitDateCretedFromHeader;
end;


{Property Functions}
function  TToDoLines.GetToDoID     : Integer   ; begin Result := GetIntegerField('ToDoID');end;
function  TToDoLines.GetDateCreated: TDateTime ; begin Result := GetDateTimeField('DateCreated');end;
function  TToDoLines.GetResponded  : TDateTime ; begin Result := GetDateTimeField('Responded');end;
function  TToDoLines.GetResults    : string    ; begin Result := GetStringField('Results');end;
function  TToDoLines.GetDone       : Boolean   ; begin Result := GetBooleanField('Done');end;
function  TToDoLines.GetDeleted    : Boolean   ; begin Result := GetBooleanField('Deleted');end;
procedure TToDoLines.SetToDoID     (const Value: Integer   ); begin SetIntegerField('ToDoID'      , Value);end;
procedure TToDoLines.SetDateCreated(const Value: TDateTime ); begin SetDateTimeField('DateCreated'      , Value);end;
procedure TToDoLines.SetResponded  (const Value: TDateTime ); begin SetDateTimeField('Responded'   , Value);end;
procedure TToDoLines.SetResults    (const Value: string    ); begin SetStringField('Results'     , Value);end;
procedure TToDoLines.SetDone       (const Value: Boolean   ); begin SetBooleanField('Done'        , Value);end;
procedure TToDoLines.SetDeleted    (const Value: Boolean   ); begin SetBooleanField('Deleted'        , Value);end;
function TToDoLines.GetTotal: String;begin  result := getStringfield('Total');end;
procedure TToDoLines.SetTotal(const Value: String);begin  SetStringField('Total' , Value);end;

function TToDoLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  if assigned(Self.Owner) then
    if self.owner is TToDo then
      TODOID := TTODo(Self.Owner).ID;
end;

procedure TToDoLines.InitDateCretedFromHeader;
begin
    if DateCreated = 0 then
      if (assigned(Self.Owner)) and (Self.Owner is tTodo) then
        DateCreated := TToDo(self.Owner).CreatedDate;
end;

initialization
  RegisterClass(TToDoLines);
  RegisterClass(TToDo);
  BusObjectListObj.TBusObjInfoList.Inst.Add('To Do','TToDo','TToDoListGUI');
end.
