unit BusObjApprovals;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type

  TApprovals = class(TMSBusObj)
  private
    function GetEmployeeID      : Integer   ;
    //function GetLevel           : Integer   ;
    function GetApprovalType    : string    ;
    function GetApprovedID      : Integer   ;
    function GetApprovedRef     : string    ;
    procedure SetEmployeeID      (const Value: Integer   );
    //procedure SetLevel           (const Value: Integer   );
    procedure SetApprovalType    (const Value: string    );
    procedure SetApprovedID      (const Value: Integer   );
    procedure SetApprovedRef     (const Value: string    );
    (*function IsApproved: Boolean;*)
    function   GetApprovalDate: TDateTime;
    procedure  SetApprovalDate(const Value: TDateTime);
    function   GetActive: Boolean;
    procedure  SetActive(const Value: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  public
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean;                                  override;
    function     Save: Boolean;                                          override;

    // AddApproval returns True if the item is now approved, False if it requires more approvals
    class procedure AddApproval(const aOwner: TComponent; const sType: string;
      const (*iLevel, *)iEmployeeID, iApprovedID: Integer; const sApprovedRef: string);
    class Procedure Unapprove(const aOwner: TComponent; const sType: string; const iEmployeeID, iApprovedID: Integer);
  published
    property EmployeeID       :Integer     read GetEmployeeID     write SetEmployeeID  ;
    //property Level            :Integer     read GetLevel          write SetLevel       ;
    property ApprovalType     :string      read GetApprovalType   write SetApprovalType;
    property ApprovedID       :Integer     read GetApprovedID     write SetApprovedID  ;
    property ApprovedRef      :string      read GetApprovedRef    write SetApprovedRef ;
    Property ApprovalDate: TDateTime read getApprovalDate write setApprovalDate;
    Property Active: Boolean read getActive write setActive;
  end;

  TApprovalLevels = class(TMSBusObj)
  private
    //function GetLevel                  : Integer   ;
    function GetApprovalType           : string    ;
    function GetEmployeeID             : Integer   ;
    function GetEmployeeName           : string    ;
    function GetValueFrom              : Double    ;
    function GetValueTo                : Double    ;
    function GetEnteredByEmployeeID    : Integer   ;
    function GetEnteredByEmployeeName  : string    ;
    function GetActive                 : Boolean   ;
    //procedure SetLevel                  (const Value: Integer   );
    procedure SetApprovalType           (const Value: string    );
    procedure SetEmployeeID             (const Value: Integer   );
    procedure SetEmployeeName           (const Value: string    );
    procedure SetValueFrom              (const Value: Double    );
    procedure SetValueTo                (const Value: Double    );
    procedure SetEnteredByEmployeeID    (const Value: Integer   );
    procedure SetEnteredByEmployeeName  (const Value: string    );
    procedure SetActive                 (const Value: Boolean   );
  private
    //fGUIMode: Boolean;
    //fNotCommittedList: TList;
    fNotPostedYet: Boolean;
    //function GetIsCommitted: Boolean;
    //procedure SetIsCommitted(const Value: Boolean);
    //procedure SetGUIMode(const Value: Boolean);
    function GetValueLeeway: Double;
    procedure SetValueLeeway(const Value: Double);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoBeforePost(Sender: TDatasetBusObj): Boolean;             override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
  public
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    constructor  Create(AOwner: TComponent);                             override;
    destructor   Destroy;                                                override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    function     ValidateData: Boolean;                                  override;
    function     Save: Boolean;                                          override;
    procedure    DeleteLine; // Use this in a multi-line dataset
    //procedure    SetAllCommitted;

    class function CanApprove(const AType: string; const AValue: Currency(*; out ALevel: Integer*)): Boolean;
    class function CanVary(const AType: string; const AVarianceAmount: double): boolean;
    // The employee is in the authorised persons for this Type
    class function MayApprove(const AType : string) : boolean;
    class function Approve(const AType : string; const aValue : currency; AApprove : boolean) : boolean;

    //property IsCommitted: Boolean read GetIsCommitted write SetIsCommitted;
    //property GUIMode: Boolean read fGUIMode write SetGUIMode;
  published
    //property Level                   :Integer     read GetLevel                 write SetLevel                ;
    property ApprovalType            :string      read GetApprovalType          write SetApprovalType         ;
    property EmployeeID              :Integer     read GetEmployeeID            write SetEmployeeID           ;
    property EmployeeName            :string      read GetEmployeeName          write SetEmployeeName         ;
    property ValueFrom               :Double      read GetValueFrom             write SetValueFrom            ;
    property ValueTo                 :Double      read GetValueTo               write SetValueTo              ;
    property ValueLeeway             :Double      read GetValueLeeway           write SetValueLeeway          ;
    property EnteredByEmployeeID     :Integer     read GetEnteredByEmployeeID   write SetEnteredByEmployeeID  ;
    property EnteredByEmployeeName   :string      read GetEnteredByEmployeeName write SetEnteredByEmployeeName;
    property Active                  :Boolean     read GetActive                write SetActive               ;
  end;

  TApprovalReminders = class(TComponent)
  private
    fTableName: string;
    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;
    procedure InsertPurchaseOrders; // includes bills & credits
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetSQL(EmployeeID: Integer = 0): string;     // 0 = All reminders
    function GetSQLFromFromOnward(EmployeeID: Integer = 0): string;
  end;

  TTransApprovals = class(TMSBusObj)
  private
    fiTransApproverID :Integer;
    function GetTransType           : string    ;
    function GetTransID             : Integer   ;
    function GetEmployeeId          : Integer   ;
    function GetApproved            : Boolean   ;
    function GetApprovedOn          : TDateTime ;
    procedure SetTransType           (const Value: string    );
    procedure SetTransID             (const Value: Integer   );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetApproved            (const Value: Boolean   );
    procedure SetApprovedOn          (const Value: TDateTime );
    procedure SetTransApproverID(const Value: integer);
    procedure TransApproverIDCallback(const Sender: TBusObj;
      var Abort: Boolean);
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
    Class Function InitTrans(Atype:String; aBusobj:TDatasetBusObj; attoalAmount:double; aTransApproverID :Integer = 0):TTransApprovals;
  published
    property TransType            :string      read GetTransType          write SetTransType       ;
    property TransID              :Integer     read GetTransID            write SetTransID         ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property Approved             :Boolean     read GetApproved           write SetApproved        ;
    property ApprovedOn           :TDateTime   read GetApprovedOn         write SetApprovedOn      ;
    Property TransApproverID      :integer     Write SetTransApproverID;
  end;

const
  // When adding values here, do not forget to alter table tblApprovalLevels, sinse ApprovalType field is
  // enum
  ApprovalTypePurchaseOrder = 'Purchase Order';
  ApprovalTypeBill          = 'Bill';
  ApprovalTypeCredit        = 'Credit';
  ApprovalTypeExpenseClaim  = 'Expense Claim';
  ApprovalTypeJournalEntry  = 'Journal Entry';
  ApprovalTypeStockAdjustment  = 'Stock Adjustment';
  ApprovalTypeSmartOrder    = 'Smart Order';



implementation

uses
  tcDataUtils, CommonLib, AppEnvironment, SysUtils, MyAccess,ERPdbComponents,
  CommonDbLib, DbSharedObjectsObj, employeeaccesses;

Const
  cApprovalRemindersTableName = 'approvalreminders';
{ TApprovals }

constructor TApprovals.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Approvals';
  fSQL := 'SELECT * FROM tblapprovals';
end;


destructor TApprovals.Destroy;
begin
  inherited;
end;


procedure TApprovals.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  //SetPropertyFromNode(node,'Level');
  SetPropertyFromNode(node,'ApprovalType');
  SetPropertyFromNode(node,'ApprovedID');
  SetPropertyFromNode(node,'ApprovedRef');
  SetDatetimePropertyFromNode(node,'ApprovalDate');
  SetPropertyFromNode(node,'Active');
end;


procedure TApprovals.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  //AddXMLNode(node,'Level' ,Level);
  AddXMLNode(node,'ApprovalType' ,ApprovalType);
  AddXMLNode(node,'ApprovedID' ,ApprovedID);
  AddXMLNode(node,'ApprovedRef' ,ApprovedRef);
  AddXMLNode(node,'ApprovalDate' ,ApprovalDate);
  AddXMLNode(node,'Active' ,Active);
end;

function TApprovals.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0' , true );
    Exit;
  end;
(*  if Level = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Level should not be 0' , true );
    Exit;
  end;*)
  if ApprovedID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ApprovedID should not be 0' , true );
    Exit;
  end;
  Result := True;
end;


function TApprovals.Save: Boolean ;
begin
  PostDB;
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TApprovals.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TApprovals.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;



function TApprovals.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TApprovals.GetIDField: string;
begin
  Result := 'ID'
end;

class function TApprovals.GetBusObjectTablename: string;
begin
  Result := 'tblapprovals';
end;

function TApprovals.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TApprovals.GetEmployeeID  : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
//function  TApprovals.GetLevel       : Integer   ; begin Result := GetIntegerField('Level');end;
function  TApprovals.GetApprovalType: string    ; begin Result := GetStringField('ApprovalType');end;
function  TApprovals.GetApprovedID  : Integer   ; begin Result := GetIntegerField('ApprovedID');end;
function  TApprovals.GetApprovedRef : string    ; begin Result := GetStringField('ApprovedRef');end;
function  TApprovals.GetApprovalDate: TDateTime; begin Result := GetDateTimeField('ApprovalDate');end;
function  TApprovals.GetActive: Boolean; begin Result := GetBooleanField('Active');end;
procedure TApprovals.SetEmployeeID  (const Value: Integer   ); begin SetIntegerField('EmployeeID'   , Value);end;
//procedure TApprovals.SetLevel       (const Value: Integer   ); begin SetIntegerField('Level'        , Value);end;
procedure TApprovals.SetApprovalType(const Value: string    ); begin SetStringField('ApprovalType'  , Value);end;
procedure TApprovals.SetApprovedID  (const Value: Integer   ); begin SetIntegerField('ApprovedID'   , Value);end;
procedure TApprovals.SetApprovedRef (const Value: string    ); begin SetStringField('ApprovedRef'   , Value);end;
procedure  TApprovals.SetApprovalDate(const Value: TDateTime); begin SeTDateTimeField('ApprovalDate' , Value);end;
procedure  TApprovals.SetActive(const Value: Boolean); begin SetBooleanField('Active' , Value);end;

class Procedure TApprovals.unApprove(const aOwner: TComponent; const sType: string; const iEmployeeID, iApprovedID: Integer);
var
  approvals: TApprovals;
begin
  if aOwner is TDatasetBusObj then
    approvals := TApprovals.Create(aOwner)
  else if aOwner is TCustomMyConnection then begin
    approvals := TApprovals.Create(nil);
    approvals.Connection := TMyDacDataConnection.Create(approvals);
    approvals.Connection.Connection := TCustomMyConnection(aOwner);
  end else
    raise Exception.Create(aOwner.classname + ' is not of type TDatasetBusObj or TCustomMyConnection');
  try
    approvals.LoadSelect('(ApprovalType = ' + Quotedstr(sType) +') AND (ApprovedID = ' + inttostr(iApprovedID) +') and Active ="T"');
    //approvals.DeleteAll;
    if approvals.count >0 then begin
      approvals.Active := False;
      approvals.PostDB;
    end;
  finally
    FreeandNil(approvals);
  end;
end;

class procedure TApprovals.AddApproval(const aOwner: TComponent; const sType: string; const (*iLevel,*)
  iEmployeeID, iApprovedID: Integer; const sApprovedRef: string);
var
  approvals: TApprovals;
begin
  if aOwner is TDatasetBusObj then
    approvals := TApprovals.Create(aOwner)
  else if aOwner is TCustomMyConnection then begin
    approvals := TApprovals.Create(nil);
    approvals.Connection := TMyDacDataConnection.Create(approvals);
    approvals.Connection.Connection := TCustomMyConnection(aOwner);
  end else
    raise Exception.Create(aOwner.classname + ' is not of type TDatasetBusObj or TCustomMyConnection');
  try
    //approvals.SQLOrder := 'Level';
    approvals.LoadSelect('(ApprovalType = ' +quotedstr(sType) +') AND (ApprovedID = ' + inttostr(iApprovedID) +') and Active ="T"');
    if approvals.Dataset.Locate('EmployeeID', iEmployeeID, []) then begin
      (*if approvals.Level <> iLevel then begin
        approvals.Level := iLevel;
        approvals.Save;
      end;*)
    end else begin
      approvals.Dataset.Append;
      (*approvals.Level := iLevel;*)
      approvals.EmployeeID := iEmployeeID;
      approvals.ApprovalType := sType;
      approvals.ApprovedID := iApprovedID;
      approvals.ApprovedRef := sApprovedRef;
      approvals.approvaldate := now;
      approvals.Active := True;
      approvals.Save;
    end;
  finally
    FreeandNil(approvals);
  end;
end;

{ TApprovalLevels }

constructor TApprovalLevels.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'ApprovalLevels';
  fSQL := 'SELECT * FROM tblapprovallevels';
  //fNotCommittedList := TList.Create;
end;


destructor TApprovalLevels.Destroy;
begin
  //FreeAndNil(fNotCommittedList);
  inherited;
end;


procedure TApprovalLevels.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  //SetPropertyFromNode(node,'Level');
  SetPropertyFromNode(node,'ApprovalType');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'ValueFrom');
  SetPropertyFromNode(node,'ValueTo');
  SetPropertyFromNode(node,'EnteredByEmployeeID');
  SetPropertyFromNode(node,'EnteredByEmployeeName');
  SetBooleanPropertyFromNode(node,'Active');
end;


class function TApprovalLevels.MayApprove(const AType: string): boolean;
var
  qry: TERPQuery;
begin
  if (not AppEnv.CompanyPrefs.UseApprovalLevels) then begin
    Result := true;
    Exit;
  end;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    // Check whether we have rules for this employee and transaction
    qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
    qry.SQL.Add('where ApprovalType = ' + QuotedStr(AType));
    qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    Result := not qry.IsEmpty;
    if Result then
      exit;

    { try for leveles that apply for this employee and all types .. }
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
    qry.SQL.Add('where IfNull(ApprovalType,"") = ""');
    qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    Result := not qry.IsEmpty;
  finally
    qry.Close;
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TApprovalLevels.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  //AddXMLNode(node,'Level' ,Level);
  AddXMLNode(node,'ApprovalType' ,ApprovalType);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'ValueFrom' ,ValueFrom);
  AddXMLNode(node,'ValueTo' ,ValueTo);
  AddXMLNode(node,'EnteredByEmployeeID' ,EnteredByEmployeeID);
  AddXMLNode(node,'EnteredByEmployeeName' ,EnteredByEmployeeName);
  AddXMLNode(node,'Active' ,Active);
end;


function TApprovalLevels.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if count = 0 then begin
    result := true;
    exit;
  end;
(*  if Level = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Level should not be 0');
    Exit;
  end;*)
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeID should not be 0');
    Exit;
  end;
//  if ValueFrom < 0 then begin
//    Resultstatus.AddItem(False , rssError , 0,  'ValueFrom should not be less than $0.00');
//    Exit;
//  end;
//  if ValueTo <= 0 then begin
//    if ValueTo < 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'ValueTo should be greater than $0.00');
//      Exit;
//    end;
//    if ValueLeeway <= 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Either Value To or Value Leeway should be greater than $0.00');
//      Exit;
//    end;
//  end;
  if EnteredByEmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EnteredByEmployeeID should not be 0');
    Exit;
  end;
  if not self.IsUnique(ID,'EmployeeID = ' + inttostr(EmployeeID) +' and ApprovalType =' + Quotedstr(ApprovalType),Connection.Connection) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Approval Type : ' + quotedstr(ApprovalType) +' already exists for employee ' + Quotedstr(EmployeeName) , true);
    Exit;
  end;
  Result := True;
end;


function TApprovalLevels.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TApprovalLevels.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if (ChangeType = dcNew) then begin
    fNotPostedYet := True;
  end else if (ChangeType = dcLoad) then begin
    fNotPostedYet := False;
  end;
end;


procedure TApprovalLevels.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit;
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'EmployeeID') then
    EmployeeName := tcDataUtils.GetEmployeeName(Sender.AsInteger)
  else if Sysutils.SameText(Sender.FieldName, 'EmployeeName') then
    EmployeeID := tcDataUtils.GetEmployeeID(Sender.AsString)
  else if Sysutils.SameText(Sender.FieldName, 'EnteredByEmployeeID') then
    EnteredByEmployeeName := tcDataUtils.GetEmployeeName(Sender.AsInteger)
  else if Sysutils.SameText(Sender.FieldName, 'EnteredByEmployeeName') then
    EnteredByEmployeeID := tcDataUtils.GetEmployeeID(Sender.AsString);
end;


function TApprovalLevels.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TApprovalLevels.GetIDField: string;
begin
  Result := 'ID'
end;

class function TApprovalLevels.GetBusObjectTablename: string;
begin
  Result := 'tblapprovallevels';
end;



function TApprovalLevels.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  EnteredByEmployeeID := AppEnv.Employee.EmployeeID;
end;

function TApprovalLevels.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
//function  TApprovalLevels.GetLevel                : Integer   ; begin Result := GetIntegerField('Level');end;
function  TApprovalLevels.GetApprovalType         : string    ; begin Result := GetStringField('ApprovalType');end;
function  TApprovalLevels.GetEmployeeID           : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TApprovalLevels.GetEmployeeName         : string    ; begin Result := GetStringField('EmployeeName');end;
function  TApprovalLevels.GetValueFrom            : Double    ; begin Result := GetFloatField('ValueFrom');end;
function TApprovalLevels.GetValueLeeway: Double;
begin
  result := GetFloatField('ValueLeeway');
end;

function  TApprovalLevels.GetValueTo              : Double    ; begin Result := GetFloatField('ValueTo');end;
function  TApprovalLevels.GetEnteredByEmployeeID  : Integer   ; begin Result := GetIntegerField('EnteredByEmployeeID');end;
function  TApprovalLevels.GetEnteredByEmployeeName: string    ; begin Result := GetStringField('EnteredByEmployeeName');end;
function  TApprovalLevels.GetActive               : Boolean   ; begin Result := GetBooleanField('Active');end;
//procedure TApprovalLevels.SetLevel                (const Value: Integer   ); begin SetIntegerField('Level'               , Value);end;
procedure TApprovalLevels.SetApprovalType         (const Value: string    ); begin SetStringField('ApprovalType'         , Value);end;
procedure TApprovalLevels.SetEmployeeID           (const Value: Integer   ); begin SetIntegerField('EmployeeID'          , Value);end;
procedure TApprovalLevels.SetEmployeeName         (const Value: string    ); begin SetStringField('EmployeeName'         , Value);end;
procedure TApprovalLevels.SetValueFrom            (const Value: Double    ); begin SetFloatField('ValueFrom'             , Value);end;
procedure TApprovalLevels.SetValueLeeway(const Value: Double);
begin
  SetFloatField('ValueLeeway',Value);
end;

procedure TApprovalLevels.SetValueTo              (const Value: Double    ); begin SetFloatField('ValueTo'               , Value);end;
procedure TApprovalLevels.SetEnteredByEmployeeID  (const Value: Integer   ); begin SetIntegerField('EnteredByEmployeeID' , Value);end;
procedure TApprovalLevels.SetEnteredByEmployeeName(const Value: string    ); begin SetStringField('EnteredByEmployeeName', Value);end;
procedure TApprovalLevels.SetActive               (const Value: Boolean   ); begin SetBooleanField('Active'              , Value);end;


procedure TApprovalLevels.DeleteLine;
begin
  (*if not IsCommitted or CanDelete then begin
    Dataset.Delete;
    OnDataIdChange(dcDelete);
  end else
    ResultStatus.AddItem(false, rssWarning, 0, 'No rights to delete ' + BusObjectTypeDescription);*)
    Delete;
end;

(*function TApprovalLevels.GetIsCommitted: Boolean;
begin
  Result := (fNotCommittedList.IndexOf(Pointer(Id)) < 0);
end;

procedure TApprovalLevels.SetIsCommitted(const Value: Boolean);
begin
  if Value then
    fNotCommittedList.Remove(Pointer(Id))
  else if fNotCommittedList.IndexOf(Pointer(Id)) < 0 then
    fNotCommittedList.Add(Pointer(Id));
end;*)

(*procedure TApprovalLevels.SetAllCommitted;
begin
  fNotCommittedList.Clear;
end;*)

function TApprovalLevels.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := (ApprovalType <> '') or (ValueFrom <> 0) or (ValueTo <> 0) or (EmployeeID <> 0);
  if not Result then begin
    Dataset.Cancel;
    Abort;
  end;
  (*if EnteredByEmployeeID = 0 then
  try
    if GUIMode then
      FieldByName('EnteredByEmployeeName').ReadOnly := False;
    EnteredByEmployeeID := AppEnv.Employee.EmployeeID;
  finally
    if GUIMode then
      FieldByName('EnteredByEmployeeName').ReadOnly := True;
  end;*)
  inherited DoBeforePost(Sender);
end;

(*procedure TApprovalLevels.SetGUIMode(const Value: Boolean);
begin
  if Value then begin
    FieldByName('EnteredByEmployeeName').ReadOnly := True;
  end else begin
    FieldByName('EnteredByEmployeeName').ReadOnly := False;
  end;
  fGUIMode := Value;
end;*)

class function TApprovalLevels.Approve(const AType: string;
  const aValue: currency; AApprove: boolean): boolean;
begin
  Result := AApprove;  // existing value
  if (not AppEnv.CompanyPrefs.UseApprovalLevels) then
    exit;
//  if Result then
//    exit;
  if not CanApproveTran then
  begin
    Result := false;
    exit;
  end;

  if (AValue < 0) then //or (not AppEnv.CompanyPrefs.UseApprovalLevels) then
  begin
    Result := true;
    Exit;
  end;

  Result := {Result and} CanApprove(AType, AValue);


end;

class function TApprovalLevels.CanApprove(const AType: string; const AValue: Currency(*; out ALevel: Integer*)): Boolean;
var
  //levels: TApprovalLevels;
  qry: TERPQuery;
begin
  //result := false;
  if (AValue < 0) or (not AppEnv.CompanyPrefs.UseApprovalLevels) then begin
    Result := true;
    Exit;
  end;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    // Check whether we have rules for this employee and transaction
    qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
    qry.SQL.Add('where ApprovalType = ' + QuotedStr(AType));
    qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    if not qry.IsEmpty then begin
      { we have entries specific for this type and employee }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
      qry.SQL.Add('where ApprovalType = ' + QuotedStr(AType));
      qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
      qry.SQL.Add('and Active = "T"');
      qry.SQL.Add(Format('and (ValueFrom <= %f) AND (ValueTo >= %0:f)',[AValue]));
      qry.Open;
      result := not qry.IsEmpty;
    end
    else begin
      { try for leveles that apply for this employee and all types .. }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
      qry.SQL.Add('where IfNull(ApprovalType,"") = ""');
      qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
      qry.SQL.Add('and Active = "T"');
      // qry.SQL.Add(Format('and (ValueFrom <= %f) AND (ValueTo >= %0:f)',[AValue]));
      qry.Open;
      (*
      result := qry.IsEmpty; // No General rules for this employee
      if Result then
        Exit;
      *)
      if qry.IsEmpty then
      begin  // No general rules for the employee
        Result := false;
        exit;
      end;
      // Check for the range
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
      qry.SQL.Add('where IfNull(ApprovalType,"") = ""');
      qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
      qry.SQL.Add('and Active = "T"');
      qry.SQL.Add(Format('and (ValueFrom <= %f) AND (ValueTo >= %0:f)',[AValue]));
      qry.Open;
      result := not qry.IsEmpty;
    end;
  finally
    qry.Close;
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TApprovalLevels.CanVary(const AType: string;
  const AVarianceAmount: double): boolean;
var
  qry: TERPQuery;
begin
  if AVarianceAmount = 0 then begin
    result := true;
    exit;
  end;

  result := false;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    // Check whether we have rules for this employee and transaction
    qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
    qry.SQL.Add('where ApprovalType = ' + QuotedStr(AType));
    qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    if qry.FieldByName('ValueLeeway').AsFloat >= AVarianceAmount then begin
      result := true;
      exit;
    end;

    { try for leveles that apply for this employee and all types .. }
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('select * from ' + TApprovalLevels.GetBusObjectTablename);
    qry.SQL.Add('where IfNull(ApprovalType,"") = ""');
    qry.SQL.Add('and EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID));
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    if qry.FieldByName('ValueLeeway').AsFloat >= AVarianceAmount then begin
      result := true;
      exit;
    end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

{ TApprovalReminders }

constructor TApprovalReminders.Create(AOwner: TComponent);
begin
  inherited;
  fTableName := GetUserTemporaryTableName(cApprovalRemindersTableName);
  CreateTemporaryTable;
  InsertPurchaseOrders;
end;

procedure TApprovalReminders.CreateTemporaryTable;
var
  sl: TStringList;
begin
  DestroyTemporaryTable;
  sl := TStringList.Create;
  try
    sl.Text := 'CREATE TABLE `' + fTableName + '` ('
      + '`RecID` int(11) auto_increment, '
      + '`PurchaseOrderID` int(11), '
      + '`ItemType` varchar(10), '
      + '`ApprovalType` varchar(30), '
      + '`ClientID` int(11), '
      + '`Company` varchar(80), '
      + '`ExpenseClaimEmployeeID` int(11), '
      + '`ExpenseClaimEmployeeName` varchar(255), '
      + '`PurchaseOrderNumber` varchar(30), '
      + '`OrderDate` date, '
      + '`Approved` enum("T","F"), '
      + '`Paid` enum("T","F"), '
      + '`Invoiced` enum("T","F"), '
      + '`TotalAmountEx` double, '
      + '`TotalAmountInc` double, '
      + 'PRIMARY KEY (`RecID`)) ENGINE=MyISAM;';
    CreateUserTemporaryTable(sl);
  finally
    FreeandNil(sl);
  end;
end;

destructor TApprovalReminders.Destroy;
begin
  DestroyTemporaryTable;
  inherited;
end;

procedure TApprovalReminders.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(fTableName);
end;

function TApprovalReminders.GetSQL(EmployeeID: Integer): string;
begin
  Result := 'SELECT t.* ' + GetSQLFromFromOnward(EmployeeID);
end;

function TApprovalReminders.GetSQLFromFromOnward(EmployeeID: Integer): string;
begin
  Result := 'FROM ' + fTableName + ' t ';
  if EmployeeID > 0 then
    Result := Format('%s, tblapprovallevels a ' +
      'WHERE (t.ApprovalType = a.ApprovalType) AND (a.Active = "T") ' +
      'AND (a.EmployeeID = %d) ' +
      'AND (t.TotalAmountInc >= a.ValueFrom) AND (t.TotalAmountInc <= a.ValueTo) ' +
      'AND (%1:d NOT IN (SELECT EmployeeID FROM tblApprovals app' +
      '  WHERE (app.ApprovalType = t.ApprovalType) AND (app.ApprovedID = t.PurchaseOrderID)))',
      [Result, EmployeeID]);
end;

procedure TApprovalReminders.InsertPurchaseOrders;
var
  scr :TERPScript;
begin
    scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
    try
    scr.SQL.Text :=
        'INSERT INTO ' + fTableName
      + ' (PurchaseOrderID, ItemType, ApprovalType, ClientID, Company, '
      + '  ExpenseClaimEmployeeID, ExpenseClaimEmployeeName, PurchaseOrderNumber, '
      + '  OrderDate, Approved, Paid, Invoiced, TotalAmountEx, TotalAmountInc)'
      + 'SELECT '
      + 'PO.PurchaseOrderID as PurchaseOrderID, '
      + 'If(PO.IsBill="T","Bill",If(PO.IsCredit="T","Credit","PO")) AS ItemType, '
      + 'If(PO.ExpenseClaimEmployee <> 0, "Expense Claim", If(PO.IsBill="T","Bill",If(PO.IsCredit="T","Credit","Purchase Order"))) AS ApprovalType, '
      + 'tblClients.ClientID as ClientID, '
      + 'tblClients.Company as Company, '
      + 'tblemployees.EmployeeID as ExpenseClaimEmployeeID, '
      + 'tblemployees.EmployeeName as ExpenseClaimEmployeeName, '
      + 'PO.PurchaseOrderNumber as PurchaseOrderNumber, '
      + 'PO.OrderDate as OrderDate, '
      + 'PO.Approved as Approved, '
      + 'PO.Paid as Paid, '
      + 'tblPurchaseLines.Invoiced as Invoiced, '
      + 'PO.TotalAmount as TotalAmountEx, '
      + 'PO.TotalAmountInc as TotalAmountInc '
      + 'FROM tblpurchaseorders PO '
      + 'INNER JOIN tblPurchaseLines ON (PO.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID) '
      + 'LEFT JOIN tblClients ON  (PO.SupplierName = tblClients.Company) '
      + 'LEFT OUTER JOIN tblemployees ON (PO.ExpenseClaimEmployee = tblemployees.EmployeeID) '
      + 'WHERE tblPurchaseLines.AccountName <> "" AND PO.OrderDate '
      + ' AND (PO.IsBill = "T" OR PO.IsCredit = "T" OR PO.IsPO = "T") '
      + ' AND (PO.Approved = "F" AND PO.Paid = "F") '
      + 'GROUP BY PO.PurchaseOrderID ';
    scr.Execute;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(scr);
  end;
end;

  {TTransApprovals}

constructor TTransApprovals.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TransApprovals';
  fSQL := 'SELECT * FROM tbltransapprovals';
end;


destructor TTransApprovals.Destroy;
begin
  inherited;
end;


procedure TTransApprovals.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransType');
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'EmployeeId');
  SetBooleanPropertyFromNode(node,'Approved');
  SetDateTimePropertyFromNode(node,'ApprovedOn');
end;


procedure TTransApprovals.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransType' ,TransType);
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'Approved' ,Approved);
  AddXMLNode(node,'ApprovedOn' ,ApprovedOn);
end;


function TTransApprovals.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TransID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TransID should not be 0' , False );
    Exit;
  end;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TTransApprovals.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTransApprovals.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTransApprovals.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTransApprovals.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTransApprovals.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTransApprovals.GetBusObjectTablename: string;
begin
  Result:= 'tbltransapprovals';
end;


function TTransApprovals.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

class Function TTransApprovals.InitTrans(Atype:String; aBusobj:TDatasetBusObj; attoalAmount:double;aTransApproverID :Integer = 0):TTransApprovals;
var
  qry: TERPQuery;
  TransApprovals :TTransApprovals;
begin
  TransApprovals :=TTransApprovals.Create(aBusobj.Owner);
  try
      TransApprovals.connection  := aBusobj.Connection;
      TransApprovals.LoadSelect('TransType = ' +quotedstr(aType)+' and TransID =' + inttostr(aBusobj.ID));

      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(aBusobj.connection.connection);
      try
        qry.SQL.text := 'SELECT '+quotedstr(aType)+' as Type ,'+
                                inttostr(aBusobj.ID)+' as ID,'+
                                ' employeeId '+
                                ' from tblapprovallevels AL '+
                                ' where ApprovalType ='+quotedstr(aType) +
                                ' and Active = "T" '+
                                ' and '+floattostr(attoalAmount)+' BETWEEN  ValueFrom AND ValueTo '+
                                iif(aTransApproverID<>0, ' and employeeId = ' + inttostr(aTransApproverID), '') +
                                ' ORDER BY ValueTo';
        qry.open;
        if qry.recordcount >0 then begin
          Qry.first;
          While Qry.EOF = False do begin
            if TransApprovals.Locate('employeeId' , Qry.fieldbyname('EmployeeId').asInteger , []) = False then begin
              TransApprovals.New;
              TransApprovals.Transtype  := aType;
              TransApprovals.TransId    := aBusobj.ID;
              TransApprovals.EmployeeId :=Qry.fieldbyname('EmployeeId').asInteger;
              TransApprovals.Approved   := False;
              TransApprovals.PostDB;
            end;
            Qry.next;
          end;
        end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  finally
    Result := TransApprovals;
  end;
end;

{Property Functions}
function  TTransApprovals.GetTransType       : string    ; begin Result := GetStringField('TransType');end;
function  TTransApprovals.GetTransID         : Integer   ; begin Result := GetIntegerField('TransID');end;
function  TTransApprovals.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TTransApprovals.GetApproved        : Boolean   ; begin Result := GetBooleanField('Approved');end;
function  TTransApprovals.GetApprovedOn      : TDateTime ; begin Result := GetDateTimeField('ApprovedOn');end;
procedure TTransApprovals.SetTransType       (const Value: string    ); begin SetStringField('TransType'        , Value);end;
procedure TTransApprovals.SetTransID         (const Value: Integer   ); begin SetIntegerField('TransID'          , Value);end;
procedure TTransApprovals.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TTransApprovals.SetApproved        (const Value: Boolean   ); begin SetBooleanField('Approved'         , Value);end;
procedure TTransApprovals.SetApprovedOn      (const Value: TDateTime ); begin SetDateTimeField('ApprovedOn'       , Value);end;
procedure TTransApprovals.SetTransApproverID(const Value: integer);
begin
  fiTransApproverID := Value;
  if value <> 0 then
    Iteraterecords(TransApproverIDCallback);
end;
procedure TTransApprovals.TransApproverIDCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if EmployeeId = fiTransApproverID then begin
    Approved:= true;
  end else begin
    Approved:= False;
  end;
  PostDb;
end;

initialization
  RegisterClass(TTransApprovals);
  RegisterClassOnce(TApprovals);
  RegisterClassOnce(TApprovalLevels);
end.

