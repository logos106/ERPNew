unit BusobjEmpskills;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/01/11  1.00.00  BJ  Initial Version.
  }


interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TEmployeeSkills = class(TMSBusObj)
  private
    function GetEmployeeID         : Integer   ;
    function GetSkillID            : Integer   ;
    function GetSkillName          : string    ;
    function GetSkillLevelName     : string    ;
    function GetSkillLevel         : Integer   ;
    function GetSkillExpDate       : TDateTime ;
    function GetSecurityLevel      : Integer   ;
    function GetSecurityExpDate    : TDateTime ;
    function GetProviderID         : Integer   ;
    function GetProviderName       : string    ;
    function GetTestMethod         : Boolean   ;
    function GetCertificate        : string    ;
    function GetScheduledDate      : TDateTime ;
    function GetCompletedDate      : TDateTime ;
    function GetRenewalDate        : TDateTime ;
    function GetRenewalOptions     : Integer   ;
    function GetRenewed            : Boolean   ;
    function GetComments           : string    ;
    procedure SetEmployeeID         (const Value: Integer   );
    procedure SetSkillID            (const Value: Integer   );
    procedure SetSkillName          (const Value: string    );
    procedure SetSkillLevelName     (const Value: string    );
    procedure SetSkillLevel         (const Value: Integer   );
    procedure SetSkillExpDate       (const Value: TDateTime );
    procedure SetSecurityLevel      (const Value: Integer   );
    procedure SetSecurityExpDate    (const Value: TDateTime );
    procedure SetProviderID         (const Value: Integer   );
    procedure SetProviderName       (const Value: string    );
    procedure SetTestMethod         (const Value: Boolean   );
    procedure SetCertificate        (const Value: string    );
    procedure SetScheduledDate      (const Value: TDateTime );
    procedure SetCompletedDate      (const Value: TDateTime );
    procedure SetRenewalDate        (const Value: TDateTime );
    procedure SetRenewalOptions     (const Value: Integer   );
    procedure SetRenewed            (const Value: Boolean   );
    procedure SetComments           (const Value: string    );
    function GetReminderDays: integer;
    procedure SetReminderDays(const Value: integer);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property EmployeeID          :Integer     read GetEmployeeID        write SetEmployeeID     ;
    property SkillID             :Integer     read GetSkillID           write SetSkillID        ;
    property SkillName           :string      read GetSkillName         write SetSkillName      ;
    property SkillLevelName      :string      read GetSkillLevelName    write SetSkillLevelName ;
    property SkillLevel          :Integer     read GetSkillLevel        write SetSkillLevel     ;
    property SkillExpDate        :TDateTime   read GetSkillExpDate      write SetSkillExpDate   ;
    property ReminderDays: integer read GetReminderDays write SetReminderDays;
    property SecurityLevel       :Integer     read GetSecurityLevel     write SetSecurityLevel  ;
    property SecurityExpDate     :TDateTime   read GetSecurityExpDate   write SetSecurityExpDate;
    property ProviderID          :Integer     read GetProviderID        write SetProviderID     ;
    property ProviderName        :string      read GetProviderName      write SetProviderName   ;
    property TestMethod          :Boolean     read GetTestMethod        write SetTestMethod     ;
    property Certificate         :string      read GetCertificate       write SetCertificate    ;
    property ScheduledDate       :TDateTime   read GetScheduledDate     write SetScheduledDate  ;
    property CompletedDate       :TDateTime   read GetCompletedDate     write SetCompletedDate  ;
    property RenewalDate         :TDateTime   read GetRenewalDate       write SetRenewalDate    ;
    property RenewalOptions      :Integer     read GetRenewalOptions    write SetRenewalOptions ;
    property Renewed             :Boolean     read GetRenewed           write SetRenewed        ;
    property Comments            :string      read GetComments          write SetComments       ;
  end;

(*  TSkillProviderSkills = class(TMSBusObj)
  private
    function GetProviderID     : Integer   ;
    function GetskillID        : Integer   ;
    function GetActive         : Boolean   ;
    procedure SetProviderID     (const Value: Integer   );
    procedure SetskillID        (const Value: Integer   );
    procedure SetActive         (const Value: Boolean   );
    function getskillName: String;
    procedure setskillName(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
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
    property ProviderID      :Integer     read GetProviderID    write SetProviderID ;
    property SkillID         :Integer     read GetskillID       write SetskillID    ;
    property  SkillName      :String      read getskillName   write setskillName;
    property Active          :Boolean     read GetActive        write SetActive     ;
  end;

  TSkillProvider = class(TMSBusObj)
  private
    AllLinesValid:boolean;
    function GetSkillProviderName    : string    ;
    function GetActive               : Boolean   ;
    procedure SetSkillProviderName    (const Value: string    );
    procedure SetActive               (const Value: Boolean   );
    function getSkills: TSkillProviderSkills;
    Procedure Validatecallback(Const Sender: TBusObj; var Abort: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property    Skills :TSkillProviderSkills  read getSkills;
  published
    property SkillProviderName     :string      read GetSkillProviderName   write SetSkillProviderName;
    property Active                :Boolean     read GetActive              write SetActive           ;
  end;*)

  TSkills = class(TMSBusObj)
  private
    function GetSkill          : string    ;
    function GetActive         : Boolean   ;
    procedure SetSkill          (const Value: string    );
    procedure SetActive         (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property Skill           :string      read GetSkill         write SetSkill      ;
    property Active          :Boolean     read GetActive        write SetActive     ;
  end;



implementation

uses tcDataUtils, CommonLib, BusObjConst, sysutils, BusObjEmployeePay,
  dateutils, ERPDBComponents, BusObjClient;

{TSkills}

constructor TSkills.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Skills';
  fSQL := 'SELECT * FROM tblskills';
end;


destructor TSkills.Destroy;
begin
  inherited;
end;


procedure TSkills.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Skill');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSkills.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Skill' ,Skill);
  AddXMLNode(node,'Active' ,Active);
end;


function TSkills.ValidateData: Boolean ;
var
  qry: TERPQuery;
begin
  Result := False;
  Resultstatus.Clear;
  PostDb;
  if self.Active then begin
    if Skill = '' then begin
      AddResult(False , rssError , 0,  'Skill Name should not be Blank');
      Exit;
    end;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := self.Connection.Connection;
      qry.SQL.Add('select * from tblskills where SkillID <> ' + IntToStr(ID));
      qry.SQL.Add('and Skill = ' + QuotedStr(Skill));
      qry.Open;
      if not qry.IsEmpty then begin
        AddResult(False , rssError , 0,  'Skill Name already exists.');
        exit;
      end;
    finally
      qry.Free;
    end;
  end;
  Result := True;
end;


function TSkills.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSkills.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSkills.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSkills.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSkills.GetIDField: string;
begin
  Result := 'SkillID'
end;


class function TSkills.GetKeyStringField: string;
begin
  result := 'Skill';
end;

class function TSkills.GetKeyStringProperty: string;
begin
  result := 'Skill';
end;

class function TSkills.GetBusObjectTablename: string;
begin
  Result:= 'tblskills';
end;


function TSkills.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSkills.GetSkill      : string    ; begin Result := GetStringField('Skill');end;
function  TSkills.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSkills.SetSkill      (const Value: string    ); begin SetStringField('Skill'       , Value);end;
procedure TSkills.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;


(*  {TSkillProvider}

constructor TSkillProvider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SkillProvider';
  fSQL := 'SELECT * FROM tblskillprovider';
end;


destructor TSkillProvider.Destroy;
begin
  inherited;
end;


procedure TSkillProvider.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SkillProviderName');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSkillProvider.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SkillProviderName' ,SkillProviderName);
  AddXMLNode(node,'Active' ,Active);
end;


procedure TSkillProvider.Validatecallback(const Sender: TBusObj;  var Abort: boolean);
begin
  if not (sender is tSkills) then exit;
  if not TSkills(Sender).ValidateData then begin
    abort := True;
    alllinesvalid := false;
  end;
end;

function TSkillProvider.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SkillProviderName = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProviderName should not be Blank' , True );
    Exit;
  end;
  AllLinesValid := True;
  skills.IterateRecords(Validatecallback);
  result := AllLinesValid;
end;


function TSkillProvider.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSkillProvider.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSkillProvider.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSkillProvider.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSkillProvider.GetIDField: string;
begin
  Result := 'skillProviderId'
end;


class function TSkillProvider.GetKeyStringField: string;
begin
  result := 'SkillProviderName';
end;

class function TSkillProvider.GetKeyStringProperty: string;
begin
  result := 'SkillProviderName';
end;

class function TSkillProvider.GetBusObjectTablename: string;
begin
  Result:= 'tblskillprovider';
end;


function TSkillProvider.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSkillProvider.GetSkillProviderName: string    ; begin Result := GetStringField('SkillProviderName');end;
function TSkillProvider.getSkills: TSkillProviderSkills;
begin
  result := TSkillProviderSkills(getContainerComponent(TSkillProviderSkills , 'ProviderId = ' + intToStr(ID) ));
end;

function  TSkillProvider.GetActive           : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSkillProvider.SetSkillProviderName(const Value: string    ); begin SetStringField( 'SkillProviderName', Value);end;
procedure TSkillProvider.SetActive           (const Value: Boolean   ); begin SetBooleanField('Active'            , Value);end;


  {TSkillProviderSkills}

constructor TSkillProviderSkills.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SkillProviderSkills';
  fSQL := 'SELECT * FROM tblskillproviderskills';
end;


destructor TSkillProviderSkills.Destroy;
begin
  inherited;
end;


procedure TSkillProviderSkills.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProviderID');
  SetPropertyFromNode(node,'skillID');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'skillName');
end;


procedure TSkillProviderSkills.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProviderID' ,ProviderID);
  AddXMLNode(node,'skillID' ,skillID);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'skillName' ,skillName);

end;


function TSkillProviderSkills.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProviderID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Provider should not be Blank' , True );
    Exit;
  end;
  if skillID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Skill should not be Blank' , True );
    Exit;
  end;
  Result := True;
end;


function TSkillProviderSkills.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSkillProviderSkills.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSkillProviderSkills.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if SameText(Sender.FieldName,'SkillName') then begin
      if not RawMode then begin
        SkillId := TSkills.IDToggle(SkillName, Connection.Connection);
      end;
    end
    else if SameText(Sender.FieldName,'SkillId') then begin
      if not RawMode then begin
        SkillName := TSkills.IDToggle(SkillId, Connection.Connection);
      end;
    end;
end;


function TSkillProviderSkills.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSkillProviderSkills.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSkillProviderSkills.GetBusObjectTablename: string;
begin
  Result:= 'tblskillproviderskills';
end;


function TSkillProviderSkills.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.owner) then
    if self.owner is TSkillProvider then
      ProviderID := TSkillProvider(Self.Owner).ID;
end;

function TSkillProviderSkills.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TSkillProviderSkills.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if skillID = 0 then begin
    canceldb;
    abort;
  end;
end;

{Property Functions}
function  TSkillProviderSkills.GetProviderID : Integer   ; begin Result := GetIntegerField('ProviderID');end;
function  TSkillProviderSkills.GetskillID    : Integer   ; begin Result := GetIntegerField('skillID');end;
function TSkillProviderSkills.getskillName: String;
begin
  REsult := getStringfield('skillName');
end;

function  TSkillProviderSkills.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSkillProviderSkills.SetProviderID (const Value: Integer   ); begin SetIntegerField( 'ProviderID', Value);end;
procedure TSkillProviderSkills.SetskillID    (const Value: Integer   ); begin SetIntegerField('skillID'     , Value);end;
procedure TSkillProviderSkills.setskillName(const Value: String);
begin
  SetStringfield('skillName' , Value);
end;

procedure TSkillProviderSkills.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;*)


  {TEmployeeSkills}

constructor TEmployeeSkills.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EmployeeSkills';
  fSQL := 'SELECT * FROM tblemployeeskills';
  NullWhenDateIs0 := true;
end;


destructor TEmployeeSkills.Destroy;
begin
  inherited;
end;


procedure TEmployeeSkills.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'SkillID');
  SetPropertyFromNode(node,'SkillName');
  SetPropertyFromNode(node,'SkillLevelName');
  SetPropertyFromNode(node,'SkillLevel');
  SetDateTimePropertyFromNode(node,'SkillExpDate');
  SetPropertyFromNode(node,'SecurityLevel');
  SetDateTimePropertyFromNode(node,'SecurityExpDate');
  SetPropertyFromNode(node,'ProviderID');
  SetPropertyFromNode(node,'ProviderName');
  SetBooleanPropertyFromNode(node,'TestMethod');
  SetPropertyFromNode(node,'Certificate');
  SetDateTimePropertyFromNode(node,'ScheduledDate');
  SetDateTimePropertyFromNode(node,'CompletedDate');
  SetDateTimePropertyFromNode(node,'RenewalDate');
  SetPropertyFromNode(node,'RenewalOptions');
  SetBooleanPropertyFromNode(node,'Renewed');
  SetPropertyFromNode(node,'Comments');
  SetPropertyFromNode(node,'ReminderDays');
end;


procedure TEmployeeSkills.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'SkillID' ,SkillID);
  AddXMLNode(node,'SkillName' ,SkillName);
  AddXMLNode(node,'SkillLevelName' ,SkillLevelName);
  AddXMLNode(node,'SkillLevel' ,SkillLevel);
  AddXMLNode(node,'SkillExpDate' ,SkillExpDate);
  AddXMLNode(node,'SecurityLevel' ,SecurityLevel);
  AddXMLNode(node,'SecurityExpDate' ,SecurityExpDate);
  AddXMLNode(node,'ProviderID' ,ProviderID);
  AddXMLNode(node,'ProviderName' ,ProviderName);
  AddXMLNode(node,'TestMethod' ,TestMethod);
  AddXMLNode(node,'Certificate' ,Certificate);
  AddXMLNode(node,'ScheduledDate' ,ScheduledDate);
  AddXMLNode(node,'CompletedDate' ,CompletedDate);
  AddXMLNode(node,'RenewalDate' ,RenewalDate);
  AddXMLNode(node,'RenewalOptions' ,RenewalOptions);
  AddXMLNode(node,'Renewed' ,Renewed);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'ReminderDays' ,ReminderDays);
end;


function TEmployeeSkills.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProviderID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee Skills : Provider should not be Blank' , True );
    Exit;
  end;
  if SkillID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee Skills : Skill should not be Blank' , True );
    Exit;
  end;
  Result := True;
end;


function TEmployeeSkills.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TEmployeeSkills.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusobjEvent_ToDo,BusobjEvent_IDChange,Self);
end;


procedure TEmployeeSkills.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    {fieldnames are all prefixed with 'Field' and followed by a number}
    if SameText(Sender.FieldName,'SkillName') then begin
      SkillID := TSkills.IDToggle(SkillName, Connection.Connection);
      self.ProviderID := 0;
      self.ProviderName := '';
    end
    else if sameText(Sender.fieldname , 'CompletedDate') then begin
        if CompletedDate <> 0 then begin
          if CompletedDate >= SkillExpDate then begin
            SkillExpDate := incmonth(CompletedDate , 1);
          end;
        end;
    end else if sameText(Sender.fieldname , 'SkillExpDate') then begin
      if SkillExpDate <> 0 then begin
        if CompletedDate >= SkillExpDate then begin
          SkillExpDate := incmonth(CompletedDate , 1);
        end;
        if (RenewalDate=0) and (RenewalOptions=0) then begin
          RenewalDate :=SkillExpDate;
        end;
      end;
    end else if sameText(Sender.fieldname , 'RenewalDate') then begin
       if RenewalDate <> 0 then
        if (RenewalOptions <> 0) then RenewalOptions :=0;
    end else if sameText(Sender.fieldname , 'RenewalOptions') then begin
       if RenewalOptions <> 0 then
        if (RenewalDate <> 0) then RenewalDate :=0;
    end
    else if sameText(Sender.fieldname , 'ProviderName') then begin
      if not RawMode then
        ProviderId := Tclient.IDToggle(ProviderName, Connection.Connection);
    end
    else if sameText(Sender.fieldname , 'ProviderId') then begin
      if not RawMode then
        ProviderName := Tclient.IDToggle(ProviderId, Connection.Connection);

    end
end;


function TEmployeeSkills.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TEmployeeSkills.GetIDField: string;
begin
  Result := 'EmpSkillID'
end;


class function TEmployeeSkills.GetBusObjectTablename: string;
begin
  Result:= 'tblemployeeskills';
end;


function TEmployeeSkills.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.owner) then
    if self.owner is TEmployeepay then
      Employeeid := TEmployeepay(Owner).EmployeeDetails.ID;
end;

function TEmployeeSkills.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TEmployeeSkills.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if (skillID = 0) and (ProviderID =0) then begin
    canceldb;
    abort;
  end;
end;


{Property Functions}
function  TEmployeeSkills.GetEmployeeID     : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TEmployeeSkills.GetSkillID        : Integer   ; begin Result := GetIntegerField('SkillID');end;
function  TEmployeeSkills.GetSkillName      : string    ; begin Result := GetStringField('SkillName');end;
function  TEmployeeSkills.GetSkillLevelName : string    ; begin Result := GetStringField('SkillLevelName');end;
function  TEmployeeSkills.GetSkillLevel     : Integer   ; begin Result := GetIntegerField('SkillLevel');end;
function  TEmployeeSkills.GetSkillExpDate   : TDateTime ; begin Result := GetDateTimeField('SkillExpDate');end;
function  TEmployeeSkills.GetSecurityLevel  : Integer   ; begin Result := GetIntegerField('SecurityLevel');end;
function  TEmployeeSkills.GetSecurityExpDate: TDateTime ; begin Result := GetDateTimeField('SecurityExpDate');end;
function  TEmployeeSkills.GetProviderID     : Integer   ; begin Result := GetIntegerField('ProviderID');end;
function  TEmployeeSkills.GetProviderName   : string    ; begin Result := GetStringField('ProviderName');end;
function  TEmployeeSkills.GetTestMethod     : Boolean   ; begin Result := GetBooleanField('TestMethod');end;
function  TEmployeeSkills.GetCertificate    : string    ; begin Result := GetStringField('Certificate');end;
function  TEmployeeSkills.GetScheduledDate  : TDateTime ; begin Result := GetDateTimeField('ScheduledDate');end;
function  TEmployeeSkills.GetCompletedDate  : TDateTime ; begin Result := GetDateTimeField('CompletedDate');end;
function TEmployeeSkills.GetReminderDays: integer;
begin
  result := GetIntegerField('ReminderDays');
end;

function  TEmployeeSkills.GetRenewalDate    : TDateTime ; begin Result := GetDateTimeField('RenewalDate');end;
function  TEmployeeSkills.GetRenewalOptions : Integer   ; begin Result := GetIntegerField('RenewalOptions');end;
function  TEmployeeSkills.GetRenewed        : Boolean   ; begin Result := GetBooleanField('Renewed');end;
function  TEmployeeSkills.GetComments       : string    ; begin Result := GetStringField('Comments');end;
procedure TEmployeeSkills.SetEmployeeID     (const Value: Integer   ); begin SetIntegerField('EmployeeID'      , Value);end;
procedure TEmployeeSkills.SetSkillID        (const Value: Integer   ); begin SetIntegerField('SkillID'         , Value);end;
procedure TEmployeeSkills.SetSkillName      (const Value: string    ); begin SetStringField('SkillName'       , Value);end;
procedure TEmployeeSkills.SetSkillLevelName (const Value: string    ); begin SetStringField('SkillLevelName'  , Value);end;
procedure TEmployeeSkills.SetSkillLevel     (const Value: Integer   ); begin SetIntegerField('SkillLevel'      , Value);end;
procedure TEmployeeSkills.SetSkillExpDate   (const Value: TDateTime ); begin SetDateTimeField('SkillExpDate'    , Value);end;
procedure TEmployeeSkills.SetSecurityLevel  (const Value: Integer   ); begin SetIntegerField('SecurityLevel'   , Value);end;
procedure TEmployeeSkills.SetSecurityExpDate(const Value: TDateTime ); begin SetDateTimeField('SecurityExpDate'   , Value);end;
procedure TEmployeeSkills.SetProviderID     (const Value: Integer   ); begin SetIntegerField('ProviderID'      , Value);end;
procedure TEmployeeSkills.SetProviderName   (const Value: string    ); begin SetStringField('ProviderName'    , Value);end;
procedure TEmployeeSkills.SetTestMethod     (const Value: Boolean   ); begin SetBooleanField('TestMethod'      , Value);end;
procedure TEmployeeSkills.SetCertificate    (const Value: string    ); begin SetStringField('Certificate'     , Value);end;
procedure TEmployeeSkills.SetScheduledDate  (const Value: TDateTime ); begin SetDateTimeField('ScheduledDate'   , Value);end;
procedure TEmployeeSkills.SetCompletedDate  (const Value: TDateTime ); begin SetDateTimeField('CompletedDate'   , Value);end;
procedure TEmployeeSkills.SetReminderDays(const Value: integer);
begin
  SetIntegerField('ReminderDays', Value);
end;

procedure TEmployeeSkills.SetRenewalDate    (const Value: TDateTime ); begin SetDateTimeField('RenewalDate'     , Value);end;
procedure TEmployeeSkills.SetRenewalOptions (const Value: Integer   ); begin SetIntegerField('RenewalOptions'     , Value);end;
procedure TEmployeeSkills.SetRenewed        (const Value: Boolean   ); begin SetBooleanField('Renewed'         , Value);end;
procedure TEmployeeSkills.SetComments       (const Value: string    ); begin SetStringField('Comments'        , Value);end;


initialization
  RegisterClass(TEmployeeSkills);
  (*RegisterClass(TSkillProviderSkills);
  RegisterClass(TSkillProvider);*)
  RegisterClass(TSkills);

end.
