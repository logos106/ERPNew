unit BusObjProcessStep;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  08/06/07  1.00.01  A  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf ,BusObjEmployee, MyAccess;


type
  TEmployeeProcessSteps = class(TMSBusObj)
  private
    function GetEmployeeID           : Integer   ;
    function GetEmployeeName         : string    ;
    function GetProcessStepID        : Integer   ;
    function GetProcessStep          : string    ;
    function GetActive               : Boolean   ;
    function GetIsDefault            : Boolean   ;
    procedure SetEmployeeID           (const Value: Integer   );
    procedure SetEmployeeName         (const Value: string    );
    procedure SetProcessStepID        (const Value: Integer   );
    procedure SetProcessStep          (const Value: string    );
    procedure SetActive               (const Value: Boolean   );
    procedure SetIsDefault            (const Value: Boolean   );
    function getEmployee: TEmployee;
    function getCleanEmployeeName: String;
    procedure CheckforDefaultEmployeeProcessSteps;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;           override;
    function  DoAfterOpen(Sender: TDatasetBusObj): Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Employee :TEmployee REad getEmployee;
    Property CleanEmployeeName :String read getCleanEmployeeName;
  published
    property EmployeeID            :Integer     read GetEmployeeID          write SetEmployeeID       ;
    property EmployeeName          :string      read GetEmployeeName        write SetEmployeeName     ;
    property ProcessStepID         :Integer     read GetProcessStepID       write SetProcessStepID    ;
    property ProcessStep           :string      read GetProcessStep         write SetProcessStep      ;
    property Active                :Boolean     read GetActive              write SetActive           ;
    property IsDefault             :Boolean     read GetIsDefault           write SetIsDefault        ;
  end;


  TProcessStep = class(TMSBusObj)
  private
    function GetDescription     : string    ;
    function GetExtraInfo     : string    ;
    function GetProcessTime     : TDateTime ;
    function GetActive          : Boolean   ;
    function GetQtyPerCoupon :Double;
    function GetRAtePercoupon :Double;
    function GetDefaultDuration :Double;
    function GetPName:            String;
    function GetDailyHours:       Integer;
    function GetHourlyLabourCost: Integer;
    function GetCOGS:             String;
    function GetExpenseAccount:   String;
    function GetOHourlyCost:      Integer;
    function GetOCOGS:            String;
    function GetOExpense:         String;
    function GetTotalHourlyCost:  Integer;
    function GetWastage:          String;

    procedure SetDescription     (const Value: string    );
    procedure SetExtraInfo       (const Value: string    );
    procedure SetProcessTime     (const Value: TDateTime );
    procedure SetActive          (const Value: Boolean   );
    procedure SetQtyPerCoupon(const Value :Double);
    procedure SetRAtePercoupon(const Value :Double);
    procedure SetDefaultDuration(const Value :Double);
    function DescriptionExists: Boolean;
    function GetEmployeeProcessSteps: TEmployeeProcessSteps;
    procedure CheckforDefaultEmployeeProcessSteps;
    procedure SetPName            (const Value: String);
    procedure SetDailyHours       (const Value: Integer);
    procedure SetHourlyLabourCost (const Value: Integer);
    procedure SetCOGS             (const Value: String);
    procedure SetExpenseAccount   (const Value: String);
    procedure SetOHourlyCost      (const Value: Integer);
    procedure SetOCOGS            (const Value: String);
    procedure SetOExpense         (const Value: String);
    procedure SetTotalHourlyCost  (const Value: Integer);
    procedure SetWastage          (const Value: String);

    //procedure InitDefaultEmployeeProcessS(const Sender: TBusObj;      var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
    function  DoAfterOpen(Sender: TDatasetBusObj): Boolean;              override;

  public
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function GetKeyStringField: string; override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean ;                                 override;
    function     Save: Boolean ;                                         override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Property EmployeeProcessteps :TEmployeeProcessSteps read getEmployeeProcessSteps;
    class function IdForDescription(const aDesc: string; Conn: TCustomMyConnection = nil; createifnotExists:Boolean=False): integer;
    Class function ValidateProcessStep(const aProcessStepId:Integer):Boolean;

  published
    property Description      :string      read GetDescription      write SetDescription ;
    property ExtraInfo        :string      read GetExtraInfo        write SetExtraInfo ;
    property ProcessTime      :TDateTime   read GetProcessTime      write SetProcessTime ;
    property Active           :Boolean     read GetActive           write SetActive      ;
    Property QtyPerCoupon     :Double      read getQtyPerCoupon     write SetQtyPerCoupon;
    Property RAtePercoupon    :Double      read getRAtePercoupon    write SetRAtePercoupon;
    Property DefaultDuration  :Double      read getDefaultDuration  write SetDefaultDuration;
    Property PName            :String      read GetPName            write SetPName;
    Property DailyHours       :Integer     read GetDailyHours       write SetDailyHours;
    Property HourlyLabourCost :Integer     read GetHourlyLabourCost write SetHourlyLabourCost;
    Property COGS             :String      read GetCOGS             write SetCOGS;
    Property ExpenseAccount   :String      read GetExpenseAccount   write SetExpenseAccount;
    Property OHourlyCost      :Integer     read GetOHourlyCost      write SetOHourlyCost;
    Property OCOGS            :String      read GetOCOGS            write SetOCOGS;
    Property OExpense         :String      read GetOExpense         write SetOExpense;
    Property TotalHourlyCost  :Integer     read GetTotalHourlyCost  write SetTotalHourlyCost;
    Property Wastage          :String      read GetWastage          write SetWastage;
  end;

implementation


uses
  CommonLib, ERPdbComponents, SysUtils, DbSharedObjectsObj, CommonDbLib , BusObjProcResource;



{TProcessStep}

constructor TProcessStep.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Process Step';
end;


destructor TProcessStep.Destroy;
begin
  inherited;
end;


procedure TProcessStep.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'QtyPerCoupon');
  SetPropertyFromNode(node,'RAtePercoupon');
  SetPropertyFromNode(node,'DefaultDuration');
  SetPropertyFromNode(node,'ExtraInfo');
  SetDateTimePropertyFromNode(node,'ProcessTime');
  SetPropertyFromNode(node,'Active');
end;


procedure TProcessStep.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'ExtraInfo' ,ExtraInfo);
  AddXMLNode(node,'ProcessTime' ,ProcessTime);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'QtyPerCoupon' ,QtyPerCoupon);
  AddXMLNode(node,'RAtePercoupon' ,RAtePercoupon);
  AddXMLNode(node,'DefaultDuration' ,DefaultDuration);
end;


function TProcessStep.ValidateData: Boolean ;
begin
  result:= inherited ValidateData;
  if not result then exit;
  if Trim(Description) = '' then begin
    Resultstatus.AddItem(false , rssWarning , 0,  'Description can not be blank' , True);
    Result := False;
    Exit;
  end
  else if (self.Id < 1) and DescriptionExists then begin
    Resultstatus.AddItem(false , rssWarning , 0,  'A nother Process Step exists with this description' , True );
    Result := False;
    Exit;
  end;
  CheckforDefaultEmployeeProcessSteps;
  Result:= True;
end;

Procedure TProcessStep.CheckforDefaultEmployeeProcessSteps;
var
  qry: TERPQuery;
  fiEmpProcessStepsID :Integer;
  s:String;
begin
  EmployeeProcessteps.PostDB;

  {no employees Assigned}
  if EmployeeProcessteps.count =0 then Exit;

  {only one Employee asigned}
  if EmployeeProcessteps.count =1 then begin
    if not EmployeeProcessteps.isdefault then begin
      EmployeeProcessteps.IsDefault := True;
      EmployeeProcessteps.PostDB;
    end;
    Exit;
  end;

  {having multiple Employees - checking for default more than one}
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(self.connection.connection);
  try
    qry.SQL.text := ' select count(*) ctr , '+
                    ' min(EmpProcessStepsID)  minID, '+
                    ' (Select EmpProcessStepsID from  tblemployeeprocesssteps where EmpProcessStepsID = '+ inttostr(EmployeeProcessteps.ID)+' and isdefault ="T") as currentID '+
                    '  from tblemployeeprocesssteps where ProcessStepID = '+ inttostr(self.ID)+' and  isdefault ="T"';

    qry.open;
    if qry.fieldbyname('ctr').asInteger = 1 then exit;

    if qry.fieldbyname('ctr').asInteger =0 then begin
      EmployeeProcessteps.first;
      EmployeeProcessteps.IsDefault := True;
      EmployeeProcessteps.PostDB;
      Exit;
    end;
    if   qry.fieldbyname('currentID').asInteger <> 0 then
      s:= 'update tblemployeeprocesssteps set isdefault ="F"  where ProcessStepID = '+ inttostr(self.ID)+' and   EmpProcessStepsID <> ' + inttostr(qry.fieldbyname('currentID').asInteger)
    else if   qry.fieldbyname('minID').asInteger <> 0 then
      s:= 'update tblemployeeprocesssteps set isdefault ="F"  where ProcessStepID = '+ inttostr(self.ID)+' and   EmpProcessStepsID <> ' + inttostr(qry.fieldbyname('minID').asInteger)
    else exit;
    commondblib.CloseDB(qry);
    qry.SQL.text := s;
    qry.Execute;
    fiEmpProcessStepsID  :=EmployeeProcessteps.ID;
    EmployeeProcessteps.closedb;
    EmployeeProcessteps.locate(EmployeeProcessteps.IDFieldname, fiEmpProcessStepsID , []);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TProcessStep.ValidateProcessStep(const aProcessStepId: Integer): Boolean;
var
  ProcessStep : TProcessStep;
begin
    Result := FAlse;
    ProcessStep := TProcessStep.CreateWithNewConn(nil);
    try
      ProcessStep.Load(aProcessStepId);
      if ProcessStep.count =0 then Exit;
      Result := TProcResource.ResourceForProcess(aProcessStepID) >0;
    finally
      Freeandnil(ProcessStep);
    end;
end;

class function TProcessStep._Schema: string;
begin
  result:= inherited;
end;

function TProcessStep.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcessStep.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcessStep.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProcessStep.GetSQL: string;
begin
  fSQL := 'SELECT * FROM tblprocessstep';
  Result := inherited GetSQL;
end;


class function TProcessStep.IdForDescription(const aDesc: string; Conn: TCustomMyConnection = nil; createifnotExists:Boolean=False): integer;
var
  ProcessStep : TProcessStep;
begin
  Result := TProcessStep.IDToggle(aDesc , Conn);
  if (result =0) and (createifnotExists) and (trim(aDesc) <> '') then begin
    ProcessStep := TProcessStep.create(nil);
    try
      ProcessStep.connection := TMyDAcDataconnection.Create(ProcessStep);
      if conn <> nil then ProcessStep.connection.connection := conn
      else ProcessStep.connection.connection := GetNewMyDacConnection(ProcessStep);
      ProcessStep.LoadSelect('Description = ' +quotedstr(aDesc));
      if ProcessStep.count =0 then begin
        ProcessStep.New;
        ProcessStep.Description := aDesc;
        ProcessStep.Active := True;
        ProcessStep.PostDb;
      end;
      result := ProcessStep.ID;
    finally
      Freeandnil(ProcessStep);
    end;
  end;
  TProcResource.ResourceForProcess(Result);
end;

class function TProcessStep.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProcessStep.GetBusObjectTablename: string;
begin
  Result := 'tblprocessstep';
end;


class function TProcessStep.GetKeyStringField: string;
begin
  result:= 'Description';
end;


class function TProcessStep.GetKeyStringProperty: string;
begin
  result:= 'Description';
end;

function TProcessStep.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  Active:= True;
end;

function TProcessStep.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterOpen(Sender);
  if not result then exit;
  //CheckforDefaultEmployeeProcessSteps;
end;

function TProcessStep.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;
                                                                                                              {Property functions}
function TProcessStep.getEmployeeProcessSteps: TEmployeeProcessSteps;
begin
  Result := TEmployeeProcessSteps(getContainerComponent(TEmployeeProcessSteps , 'ProcessStepID = ' +inttostr(ID) ));
end;
function TProcessStep.GetDescription : string    ;  begin Result := GetStringField('Description');end;
function TProcessStep.GetExtraInfo : string    ;    begin Result := GetStringField('ExtraInfo');end;
function TProcessStep.GetProcessTime : TDateTime ;  begin Result := GetDateTimeField('ProcessTime');end;
function TProcessStep.GetQtyPerCoupon: Double;      begin Result := Getfloatfield('QtyPerCoupon');end;
function TProcessStep.GetRAtePercoupon: Double;     begin Result := Getfloatfield('RAtePercoupon');end;
function TProcessStep.GetDefaultDuration: Double;   begin Result := Getfloatfield('DefaultDuration');end;
function TProcessStep.GetActive      : Boolean   ;  begin Result := GetBooleanField('Active');end;
function TProcessStep.GetPName           : String;  begin Result := GetStringField('PName'); end;
function TProcessStep.GetDailyHours     : Integer;  begin Result := GetIntegerField('DailyHours'); end;
function TProcessStep.GetHourlyLabourCost: Integer; begin Result := GetIntegerField('HourlyLabourCost'); end;
function TProcessStep.GetCOGS            : String;  begin Result := GetStringField('COGS'); end;
function TProcessStep.GetExpenseAccount  : String;  begin Result := GetStringField('ExpnseAccount'); end;
function TProcessStep.GetOHourlyCost     : Integer; begin Result := GetIntegerField('OHourlyCost'); end;
function TProcessStep.GetOCOGS           : String;  begin Result := GetStringField('OCOGS'); end;
function TProcessStep.GetOExpense        : String;  begin Result := GetStringField('OExpense'); end;
function TProcessStep.GetTotalHourlyCost : Integer; begin Result := GetIntegerField('TotalHourlyCost'); end;
function TProcessStep.GetWastage         : String;  begin Result := GetStringField('Wastage'); end;

procedure TProcessStep.SetDescription (const Value: string    );  begin SetStringField('Description'        , Value); end;
procedure TProcessStep.SetExtraInfo (const Value: string    );    begin SetStringField('ExtraInfo'          , Value); end;
procedure TProcessStep.SetProcessTime (const Value: TDateTime );  begin SetDateTimeField('ProcessTime'      , Value); end;
procedure TProcessStep.SetQtyPerCoupon(const Value: Double);      begin SetFloatField('QtyPerCoupon'        , Value); end;
procedure TProcessStep.SetRAtePercoupon(const Value: Double);     begin SetFloatField('RAtePercoupon'       , Value); end;
procedure TProcessStep.SetDefaultDuration(const Value: Double);   begin SetFloatField('DefaultDuration'     , Value); end;
procedure TProcessStep.SetActive      (const Value: Boolean   );  begin SetBooleanField('Active'            , Value); end;
procedure TProcessStep.SetPName           (const Value: String);  begin SetStringField('PName'              , Value); end;
procedure TProcessStep.SetDailyHours      (const Value: Integer); begin SetIntegerField('DailyHours'        , Value); end;
procedure TProcessStep.SetHourlyLabourCost(const Value: Integer); begin SetIntegerField('HourlyLabourCost'  , Value); end;
procedure TProcessStep.SetCOGS            (const Value: String);  begin SetStringField('COGS'               , Value); end;
procedure TProcessStep.SetExpenseAccount  (const Value: String);  begin SetStringField('ExpnseAccount'      , Value); end;
procedure TProcessStep.SetOHourlyCost     (const Value: Integer); begin SetIntegerField('OHourlyCost'       , Value); end;
procedure TProcessStep.SetOCOGS           (const Value: String);  begin SetStringField('OCOGS'              , Value); end;
procedure TProcessStep.SetOExpense        (const Value: String);  begin SetStringField('OExpense'           , Value); end;
procedure TProcessStep.SetTotalHourlyCost (const Value: Integer); begin SetIntegerField('TotalHourlyCost'   , Value); end;
procedure TProcessStep.SetWastage         (const Value: String);  begin SetStringField('Wastage'            , Value); end;


function TProcessStep.DescriptionExists: boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= self.Connection.Connection;
    qry.SQL.Add('select * from tblprocessstep');
    qry.SQL.Add('where description = ' + QuotedStr(Description));
    qry.SQL.Add('and id <> ' + IntToStr(Id));
    qry.Open;
    result:= qry.RecordCount > 0;
  finally
    qry.Free;
  end;
end;

  {TEmployeeProcessSteps}
constructor TEmployeeProcessSteps.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EmployeeProcessSteps';
  fSQL := 'SELECT * FROM tblemployeeprocesssteps';
end;


destructor TEmployeeProcessSteps.Destroy;
begin
  inherited;
end;


procedure TEmployeeProcessSteps.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'ProcessStepID');
  SetPropertyFromNode(node,'ProcessStep');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'IsDefault');
end;


procedure TEmployeeProcessSteps.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'ProcessStepID' ,ProcessStepID);
  AddXMLNode(node,'ProcessStep' ,ProcessStep);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'IsDefault' ,IsDefault);
end;


function TEmployeeProcessSteps.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be blank' , False );
    Exit;
  end;
  if ProcessStepID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcessStep should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TEmployeeProcessSteps.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TEmployeeProcessSteps.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TEmployeeProcessSteps.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sameText(Sender.fieldname , 'EmployeeName') then begin
    EmployeeId := TEmployee.IDtoggle(EmployeeName);
  end else if sameText(Sender.fieldname , 'EmployeeId') then begin
    EmployeeName := TEmployee.IDtoggle(EmployeeId);
  end else if sameText(Sender.fieldname , 'ProcessStep') then begin
    ProcessStepID := TProcessStep.IDtoggle(ProcessStep);
  end else if sameText(Sender.fieldname , 'IsDefault') then begin
        //CheckforDefaultEmployeeProcessSteps;
  end;
  if IsDefault and (EmployeeID<>0) then begin PostDB; editdb; end;
end;


function TEmployeeProcessSteps.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TEmployeeProcessSteps.GetIDField: string;
begin
  Result := 'EmpProcessStepsID'
end;


class function TEmployeeProcessSteps.GetBusObjectTablename: string;
begin
  Result:= 'tblemployeeprocesssteps';
end;


function TEmployeeProcessSteps.getCleanEmployeeName: String;
begin
    Result:= GetXMLNodestringValue(CleanXMLNode, 'Employee');
end;

function TEmployeeProcessSteps.getEmployee: TEmployee;
begin
  REsult := TEmployee(getcontainerComponent(TEmployee , 'EmployeeID = ' + inttostr(EmployeeID)))
end;

function TEmployeeProcessSteps.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) and (Owner is TEmployee) then
    employeeId := TEmployee(Owner).ID;
  if assigned(Owner) and (Owner is TProcessStep) then
    ProcessStepID := TProcessStep(Owner).ID;
  if count =0 then IsDefault := True;
end;

function TEmployeeProcessSteps.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterOpen(Sender);
  if not result then exit;

end;

function TEmployeeProcessSteps.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(Result) then exit;
  if (EmployeeName  ='') then
    if  (CleanEmployeeName ='') then
      Self.Delete
    else EmployeeName := CleanEmployeeName;
    CheckforDefaultEmployeeProcessSteps;
end;
Procedure TEmployeeProcessSteps.CheckforDefaultEmployeeProcessSteps;
begin
  if Assigned(Owner) and (Owner is TProcessStep) then
    if IsDefault and ((ID<>0) or (EmployeeID<>0)) then
      TProcessStep(Owner).CheckforDefaultEmployeeProcessSteps;
end;

{Property Functions}
function  TEmployeeProcessSteps.GetEmployeeID       : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TEmployeeProcessSteps.GetEmployeeName     : string    ; begin Result := GetStringField('EmployeeName');end;
function  TEmployeeProcessSteps.GetProcessStepID    : Integer   ; begin Result := GetIntegerField('ProcessStepID');end;
function  TEmployeeProcessSteps.GetProcessStep      : string    ; begin Result := GetStringField('ProcessStep');end;
function  TEmployeeProcessSteps.GetActive           : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TEmployeeProcessSteps.GetIsDefault        : Boolean   ; begin Result := GetBooleanField('IsDefault');end;
procedure TEmployeeProcessSteps.SetEmployeeID       (const Value: Integer   ); begin SetIntegerField('EmployeeID'        , Value);end;
procedure TEmployeeProcessSteps.SetEmployeeName     (const Value: string    ); begin SetStringField('EmployeeName'      , Value);end;
procedure TEmployeeProcessSteps.SetProcessStepID    (const Value: Integer   ); begin SetIntegerField('ProcessStepID'     , Value);end;
procedure TEmployeeProcessSteps.SetProcessStep      (const Value: string    ); begin SetStringField('ProcessStep'       , Value);end;
procedure TEmployeeProcessSteps.SetActive           (const Value: Boolean   ); begin SetBooleanField('Active'            , Value);end;
procedure TEmployeeProcessSteps.SetIsDefault        (const Value: Boolean   ); begin SetBooleanField('IsDefault'            , Value);end;


initialization
  RegisterClass(TEmployeeProcessSteps);
  RegisterClassOnce(TProcessStep);


end.
