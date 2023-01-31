Unit BusObjMarketingLeads;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/02/08  1.00.01  Binny  Initial Version.
}

Interface

Uses
  BusObjBase, DB, Classes, BusobjMarketingcontacts, BusObjClient, XMLDoc, XMLIntf, MyAccess;

Type
  TLeadActions = (Latnone = 0, LatFollowUp = 1, LatAppointment = 2, LatRescheduled = 3, LatAppointmentSat = 4, LatQuote = 5, LatSalesOrder = 6, LatInvoice = 7, LatEmail = 8, LatToDo = 9);

  TLeadLines = Class(
    TMSBusObj)
  Private
    (* AllNotDone                     : Boolean; *)
    LastFollowupdate: TDatetime;
    lastEntryCount :Integer;
    Function GetLeadID: Integer;
    Function GetActionType: Integer;
    Function GetActiontypename: String;
    Function GetActionID: Integer;
    Function GetActionRef: String;
    Function GetCreationDate: TDatetime;
    Function GetUpdateDate: TDatetime;
    Function GetActionDate: TDatetime;
    Function GetFollowUpDate: TDatetime;
    Function GetStatusID: Integer;
    Function GetPriority: Integer;
    Function GetEmployeeID: Integer;
    Function GetEmployeeName: String;
    Function GetDuration: String;
    // function GetTypeId             : Integer   ;
    // function GetTypeName           : string    ;
    Function GetHours: Double;
    Function GetResultTypeId: Integer;
    Function GetResultTypeName: String;
    Function GetIsPhoneFollowUp: Boolean;
    Function GetEntryCount: Integer;
    Function GetCreatedByID: Integer;
    Function GetCreatedBy: String;
    Function GetDone: Boolean;
    Function GetIsLead: Boolean;
    Function GetIsMarketing: Boolean;
    Function GetNotes: String;
    Function GetIsTransationREcord: Boolean;
    // function getActionName: string;
    Procedure SetLeadID(Const Value: Integer);
    Procedure SetActionType(Const Value: Integer);
    Procedure SetActionTypeName(Const Value: String);
    // procedure SetActionname(const Value: string);
    Procedure SetActionID(Const Value: Integer);
    Procedure SetActionRef(Const Value: String);
    Procedure SetCreationDate(Const Value: TDatetime);
    Procedure SetUpdateDate(Const Value: TDatetime);
    Procedure SetActionDate(Const Value: TDatetime);
    Procedure SetFollowUpDate(Const Value: TDatetime);
    Procedure SetStatusID(Const Value: Integer);
    Procedure SetPriority(Const Value: Integer);
    Procedure SetEmployeeID(Const Value: Integer);
    Procedure SetEmployeeName(Const Value: String);
    Procedure SetDuration(Const Value: String);
    // procedure SetTypeId             (const Value: Integer   );
    // procedure SetTypeName           (const Value: string    );
    Procedure SetHours(Const Value: Double);
    Procedure SetResultTypeId(Const Value: Integer);
    Procedure SetResultTypeName(Const Value: String);
    Procedure SetIsPhoneFollowUp(Const Value: Boolean);
    Procedure SetEntryCount(Const Value: Integer);
    Procedure SetCreatedByID(Const Value: Integer);
    Procedure SetCreatedBy(Const Value: String);
    Procedure SetDone(Const Value: Boolean);
    Procedure SetIsMarketing(Const Value: Boolean);
    Procedure SetIsLead(Const Value: Boolean);
    Procedure SetNotes(Const Value: String);
    (* procedure SetAlldone            (Const Sender: TBusObj; var Abort: boolean); *)
    Procedure UpdateLastrep;
    function getTransactionDetails: String;
    function AppointmentDetails: String;
    function FollowUpDetails: String;
    function SalesDetails: String;
    function ToDoDetails: String;

  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Function GetSQL: String; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforePost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function GetIsList: Boolean; Override;
    Function DoAfteropen(Sender: TDatasetBusObj): Boolean; Override;
    Function DoBeforeopen(Sender: TDatasetBusObj): Boolean; Override;
  Public
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Property IsTransationRecord: Boolean Read GetIsTransationREcord;
    Class Function GetIDField: String; Override;
    Class Function GetKeyStringField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
    Class Function _Schema: String; Override;
    Property LeadID: Integer Read GetLeadID Write SetLeadID;
    Property TransactionDetails :String read getTransactionDetails;
  Published
    Property ActionType    : Integer Read GetActionType Write SetActionType;
    Property ActionTypeName: String Read GetActiontypename Write SetActionTypeName;
    // property ActionName: string read getActionName write SetActionname;
    Property ActionID       : Integer Read GetActionID Write SetActionID;
    Property ActionRef      : String Read GetActionRef Write SetActionRef;
    Property CreationDate   : TDatetime Read GetCreationDate Write SetCreationDate;
    Property UpdateDate     : TDatetime Read GetUpdateDate Write SetUpdateDate;
    Property ActionDate     : TDatetime Read GetActionDate Write SetActionDate;
    Property FollowUpDate   : TDatetime Read GetFollowUpDate Write SetFollowUpDate;
    Property StatusID       : Integer Read GetStatusID Write SetStatusID;
    Property Priority       : Integer Read GetPriority Write SetPriority;
    Property EmployeeID     : Integer Read GetEmployeeID Write SetEmployeeID;
    Property EmployeeName   : String Read GetEmployeeName Write SetEmployeeName;
    Property Duration       : String Read GetDuration Write SetDuration;
    Property Hours          : Double Read GetHours Write SetHours;
    Property ResultTypeId   : Integer Read GetResultTypeId Write SetResultTypeId;
    Property ResultTypeName : String Read GetResultTypeName Write SetResultTypeName;
    Property IsPhoneFollowUp: Boolean Read GetIsPhoneFollowUp Write SetIsPhoneFollowUp;
    Property EntryCount     : Integer Read GetEntryCount Write SetEntryCount;
    Property CreatedByID    : Integer Read GetCreatedByID Write SetCreatedByID;
    Property CreatedBy      : String Read GetCreatedBy Write SetCreatedBy;
    Property IsMarketing    : Boolean Read GetIsMarketing Write SetIsMarketing;
    Property IsLead         : Boolean Read GetIsLead Write SetIsLead;
    Property Done           : Boolean Read GetDone Write SetDone;
    Property Notes          : String Read GetNotes Write SetNotes;

    { NOTE: the following have been removed from this object because they don't
      seem to be used any where }
    // property TypeId              :Integer     read GetTypeId            write SetTypeId         ;
    // property TypeName            :string      read GetTypeName          write SetTypeName       ;
    // property FollowUpID: integer;
  End;

  TLeads = Class(
    TMSBusObj)
  Private
    FsMarketingcontactfilter: String;
    AllLinesValid           : Boolean;
    fEditStartTime: TDateTime;
    (* fNewAppointment                    : TGeneralProc; *)
    // fsEnteredBy                        : String;
    // fsRepname                          : String;
    Function GetMarketingContactID: Integer;
    Function Getcompany: String;
    Function GetClientID: Integer;
    Function GetIsLead: Boolean;
    Function GetRepID: Integer;
    Function GetRepName: String;
    // function GetEnteredBy              : String ;
    Function GetEnteredByEmployee: String;
    Function GetEnteredByEmployeeID: Integer;
    Function GetMarketingContacts: TMarketingContact;
    Function GetClient: Tclient;
    Function GetMarketingcontactfilter: String;
    Function GetDaysSinceLastAction: Integer;
    Function GetNotes: String;
    Function GetLeadStatus: String;
    Procedure SetMarketingContactID(Const Value: Integer);
    Procedure Setcompany(Const Value: String);
    Procedure SetClientID(Const Value: Integer);
    Procedure SetIsLead(Const Value: Boolean);
    Procedure SetRepID(Const Value: Integer);
    Procedure SetRepName(Const Value: String);
    Procedure SetNotes(Const Value: String);
    // Procedure SetEnteredBy              (const Value: String    );
    Procedure SetEnteredByEmployee(Const Value: String);
    Procedure SetEnteredByEmployeeID(Const Value: Integer);
    Procedure SetLeadStatus(Const Value: String);
    Procedure ValidateLines(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure SaveLines(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure UpdateLinesDuration(Const Sender: TBusObj; Var Abort: Boolean);
    Function GetCustomerName: String;
    Function GetOtherContactName: String;
    Procedure SetCustomerName(Const Value: String);
    Procedure SetOtherContactName(Const Value: String);
    Function HasOtherMarketingRecord: Boolean;
    function GetCreatedOn: TDateTime;
    procedure SetCreatedOn(const Value: TDateTime);
  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Procedure DoFieldOnChange(Sender: TField); Override;
    Function GetSQL: String; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Function GetLines: TLeadLines;virtual;
  Public
    Function GetStatus(ActionType: TLeadActions): String;
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure LoadFromXMLNode(Const Node: IXMLNode); Override;
    Procedure SaveToXMLNode(Const Node: IXMLNode); Override;
    Procedure NewFollowup;
    Procedure UpdateStatusofLastLine(ActionType: TLeadActions);
    Procedure DeleteCurLines;
    Function IsOktoDeleteLine: Boolean;
    Function NewAction(ActionType: TLeadActions): Boolean;
    Function LockTRans: Boolean;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Class Function GetIDField: String; Override;
    Class Function GetKeyStringField: String; Override;
    Class Function GetBusObjectTablename: String; Override;
(*    Class Procedure AddProgressionRecord(Const AClientID, AActionType, AActionID: Integer; Const AActionRef, ANotes: String; Const Transdate: TDatetime; Const NewActionId: Integer;
      Const NewActionref: String; Const ADone: Boolean = True; Const AEmployeeID: Integer = 0; Const AStatusID: Integer = 0; Const APriority: Integer = -1);*)
    Class Procedure UpdateStatus(SLeadStatus: String; IClientID: Integer);
    Property Marketingcontactfilter: String Read GetMarketingcontactfilter Write FsMarketingcontactfilter;
    Property DaysSinceLastAction: Integer Read GetDaysSinceLastAction;
    Class Function _Schema: String; Override;
    Class Function GetKeyStringProperty: String; Override;
    Property Client: TClient Read GetClient;
    Property ClientID: Integer Read GetClientID Write SetClientID;
    Procedure CheckforOtherMarketingRecord(Var LeadId: Integer; Var IsLead: Boolean);
    Class Function MakeLead(const MCID:Integer):Integer;
  Published
    Property MarketingContactID: Integer Read GetMarketingContactID Write SetMarketingContactID;
    Property Company           : String Read Getcompany Write Setcompany;
    Property IsLead            : Boolean Read GetIsLead Write SetIsLead;
    Property RepID             : Integer Read GetRepID Write SetRepID;
    Property RepName           : String Read GetRepName Write SetRepName;
    Property Notes             : String Read GetNotes Write SetNotes;
    // Property EnteredBy               :String      Read getEnteredBy             Write SetEnteredBy          ;
    Property EnteredByEmployee  : String Read GetEnteredByEmployee Write SetEnteredByEmployee;
    Property EnteredByEmployeeID: Integer Read GetEnteredByEmployeeID Write SetEnteredByEmployeeID;
    Property LeadStatus         : String Read GetLeadStatus Write SetLeadStatus;
    Property Lines              : TLeadLines Read GetLines;
    Property MarketingContacts  : TMarketingContact Read GetMarketingContacts;
    Property OtherContactName   : String Read GetOtherContactName Write SetOtherContactName;
    Property CustomerName       : String Read GetCustomerName Write SetCustomerName;
    property CreatedOn: TDateTime read GetCreatedOn write SetCreatedOn;
  End;

  TLeadToAddProgressionRecord = class(TLeads)
  Private
    //Function LastLeadLineID:Integer;
  Protected
      Function GetLines: TLeadLines;Override;
  Public
    class procedure AddProgressionRecord(Const AClientID, AActionType, AActionID: Integer; Const AActionRef, ANotes: String; Const Transdate: TDatetime; Const NewActionId: Integer;
      Const NewActionref: String; Const ADone: Boolean = True; Const AEmployeeID: Integer = 0; Const AStatusID: Integer = 0; Const APriority: Integer = -1);
  end;

Implementation

Uses
  TcDataUtils, CommonLib, BusObjConst, SysUtils, AppEnvironment, GlobalEventsObj, Dateutils, Variants, ErpDbComponents, CommonDbLib, BusObjEmployee, JsonObject, BusObjSchemaLib, tcconst,BusObjSimpleTypes,
  UserLockObj;

{ TLeadLines }

Constructor TLeadLines.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  FBusObjectTypeDescription := 'MarketingLeadLines';
  FSQL                      := 'SELECT * FROM tblMarketingleadlines';
End;

Class Function TLeadLines.GetIDField: String;
Begin
  Result := 'LeadLineID'
End;

Class Function TLeadLines.GetKeyStringField: String;
Begin
  Result := ''
End;

Class Function TLeadLines.GetBusObjectTablename: String;
Begin
  Result := 'tblMarketingleadlines'
End;

Destructor TLeadLines.Destroy;
Begin
  Inherited;
End;

Procedure TLeadLines.LoadFromXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  SetPropertyFromNode(Node, 'LeadID');
  SetPropertyFromNode(Node, 'ActionType');
  SetPropertyFromNode(Node, 'ActionName');
  SetPropertyFromNode(Node, 'ActionID');
  SetPropertyFromNode(Node, 'ActionRef');
  Self.SetDateTimePropertyFromNode(Node, 'CreationDate');
  Self.SetDateTimePropertyFromNode(Node, 'UpdateDate');
  Self.SetDateTimePropertyFromNode(Node, 'ActionDate');
  // SetPropertyFromNode(node,'CreationDate');
  // SetPropertyFromNode(node,'UpdateDate');
  SetDateTimePropertyFromNode(Node, 'FollowUpDate');
  SetPropertyFromNode(Node, 'StatusID');
  SetPropertyFromNode(Node, 'Priority');
  SetPropertyFromNode(Node, 'EmployeeID');
  SetPropertyFromNode(Node, 'EmployeeName');
  SetPropertyFromNode(Node, 'Duration');
  SetPropertyFromNode(Node, 'TypeId');
  SetPropertyFromNode(Node, 'ActionTypeName');
  SetPropertyFromNode(Node, 'Hours');
  SetPropertyFromNode(Node, 'ResultTypeId');
  SetPropertyFromNode(Node, 'ResultTypeName');
  SetBooleanPropertyFromNode(Node, 'IsPhoneFollowUp');
  SetPropertyFromNode(Node, 'EntryCount');
  SetPropertyFromNode(Node, 'CreatedByID');
  SetPropertyFromNode(Node, 'CreatedBy');
  SetBooleanPropertyFromNode(Node, 'IsMarketing');
  SetBooleanPropertyFromNode(Node, 'IsLead');
  SetBooleanPropertyFromNode(Node, 'Done');
  SetPropertyFromNode(Node, 'Notes');
End;

Procedure TLeadLines.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'LeadID', LeadID);
  AddXMLNode(Node, 'ActionType', ActionType);
  AddXMLNode(Node, 'ActionTypeName', ActionTypeName);
  AddXMLNode(Node, 'ActionID', ActionID);
  AddXMLNode(Node, 'ActionRef', ActionRef);
  AddXMLNode(Node, 'CreationDate', CreationDate);
  AddXMLNode(Node, 'UpdateDate', UpdateDate);
  AddXMLNode(Node, 'ActionDate', ActionDate);
  AddXMLNode(Node, 'FollowUpDate', FollowUpDate);
  AddXMLNode(Node, 'StatusID', StatusID);
  AddXMLNode(Node, 'Priority', Priority);
  AddXMLNode(Node, 'EmployeeID', EmployeeID);
  AddXMLNode(Node, 'EmployeeName', EmployeeName);
  AddXMLNode(Node, 'Duration', Duration);
  // AddXMLNode(node,'TypeId' ,TypeId);
  // AddXMLNode(node,'TypeName' ,TypeName);
  AddXMLNode(Node, 'Hours', Hours);
  AddXMLNode(Node, 'ResultTypeId', ResultTypeId);
  AddXMLNode(Node, 'ResultTypeName', ResultTypeName);
  AddXMLNode(Node, 'IsPhoneFollowUp', IsPhoneFollowUp);
  AddXMLNode(Node, 'EntryCount', EntryCount);
  AddXMLNode(Node, 'CreatedByID', CreatedByID);
  AddXMLNode(Node, 'CreatedBy', CreatedByID);
  AddXMLNode(Node, 'Done', Done);
  AddXMLNode(Node, 'IsMarketing', IsMarketing);
  AddXMLNode(Node, 'IsLead', IsLead);
  AddXMLNode(Node, 'Notes', Notes);
End;

Function TLeadLines.ValidateData: Boolean;
Begin
  Result := False;
  Resultstatus.Clear;
  If ActionDate = 0 Then Begin
    AddResult(False, RssWarning, 0, 'Date should not be blank');
    Exit;
  End;
  If EmployeeID = 0 Then Begin
    AddResult(False, RssWarning, 0, 'Employee should not be blank');
    Exit;
  End;
  If ActionType = 0 Then Begin
    AddResult(False, RssWarning, 0, 'Action type should not be blank');
    Exit;
  End;
  Result := True;
End;

Class Function TLeadLines._Schema: String;
Begin
  Result := Inherited;
  TBOSchema.AddRefType(Result, 'TLeadActionType', 'LeadActionType_1', 'ActionType', 'ID');
  TBOSchema.AddRefType(Result, 'TLeadActionType', 'LeadActionType_1', 'ActionTypeName', 'TypeName');
  TBOSchema.AddRefType(Result, 'TAppointmentStatusType', 'AppointmentStatusType_1', 'StatusID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'Employee_1', 'EmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'Employee_1', 'EmployeeName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TLeadActionType', 'LeadActionType_2', 'ResultTypeID', 'ID');
  TBOSchema.AddRefType(Result, 'TLeadActionType', 'LeadActionType_2', 'ResultTypeName', 'TypeName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'Employee_2', 'CreatedByID', 'ID');

End;

Function TLeadLines.Save: Boolean;
Begin
  Result := False;
  If Not ValidateData Then Exit;
  Result := Inherited Save;
End;

Procedure TLeadLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
End;

Procedure TLeadLines.UpdateLastrep;
Var
  StrSQL: String;
Begin
  PostDB;
  If EmployeeID <> 0 Then
    If Assigned(Self.Owner) Then
      If Self.Owner Is TLeads Then Begin
        // PostDB;
        StrSQL := 'SELECT a.EmployeeID, a.ActionDate FROM tblMarketingLeadLines a where LeadID = ' + IntToStr(Self.LeadID) + ' ORDER BY a.ActionDate DESC LIMIT 1';
        With GetNewDataset(StrSQL, True) Do
          Try
            If Recordcount > 0 Then Begin
              TLeads(Self.Owner).RepID := FieldByname('EmployeeID').AsInteger;
              TLeads(Self.Owner).PostDB;
            End;
          Finally
            If Active Then Close;
            Free;
          End;
      End;
End;

Procedure TLeadLines.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  Inherited;
  If SysUtils.SameText(Sender.FieldName, 'EmployeeName') Then Begin
    EmployeeID := TcDataUtils.GetEmployeeID(EmployeeName);
    If Not RawMode Then Begin
      UpdateLastrep;
    End;
  End
  Else If SysUtils.SameText(Sender.FieldName, 'AccountTypeName') Then Begin
  End
  Else If SysUtils.SameText(Sender.FieldName, 'AccountType') Then Begin
  End
  Else If SysUtils.SameText(Sender.FieldName, 'EmployeeId') Then Begin
    EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
    If Not RawMode Then Begin
      UpdateLastrep;
    End;
  End
  Else If SysUtils.SameText(Sender.FieldName, 'ResultTypeId') Then Begin
    ResultTypeName := GetSimpleType(ResultTypeId);
  End
  Else If SysUtils.SameText(Sender.FieldName, 'ResultTypeName') Then Begin
    ResultTypeId := GetSimpleType(ResultTypeName, SimpleTypes_LeadActionType);
  End;
End;

Function TLeadLines.GetSQL: String;
Begin
  Result := Inherited GetSQL;
End;

(* procedure TLeadLines.SetAlldone(Const Sender: TBusObj; var Abort: boolean);
  begin
  if not(Sender is  TLeadLines) then Exit;
  if not(TLeadLines(Sender).ValidateData) then begin
  Abort := true;
  AllNotDone := true;
  exit;
  end;
  TLeadLines(Sender).Done := True;
  TLeadLines(Sender).PostDB;
  end; *)
Function TLeadLines.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoBeforeInsert(Sender);
  If Not(Result) Then Exit;
  (* AllNotDone := False;
    IterateRecords(SetAlldone);
    if AllNotDone then begin
    DoFieldChange := True;
    Abort;
    Exit;
    end; *)
  If Count = 0 Then Exit;
  Last;
  Done := True;
  PostDB;
  If Not(ValidateData) Then Begin
    DoFieldChange := True;
    Abort;
    Exit;
  End;
  LastFollowupdate := FollowUpDate;
  LastEntryCount := EntryCount;
End;

function TLeadLines.DoBeforeopen(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoBeforeopen(Sender);
  If Not(Result) Then Exit;
end;

Function TLeadLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not(Result) Then Exit;

  If Assigned(Self.Owner) Then
    If Self.Owner Is TLeads Then Begin
      LeadID := TLeads(Self.Owner).ID;
      IsLead := TLeads(Self.Owner).IsLead;
    End;
  // followupdate:= Dateof(Now);
  EmployeeID    := Appenv.Employee.EmployeeID;
  ActionType    := TcDataUtils.LeadActionFollowup;
  CreatedByID   := Appenv.Employee.EmployeeID;
  IsMarketing   := Not(IsLead);
  CreationDate  := Now;
  if LastEntryCount   <> 0 then EntryCount := LastEntryCount+1  else EntryCount := count+1;
  If LastFollowupdate =  0 Then ActionDate := Dateof(Now)       Else ActionDate := LastFollowupdate;
End;

function TLeadLines.DoAfteropen(Sender: TDatasetBusObj): Boolean;
begin
  Result := Inherited DoAfteropen(Sender);
  If Not(Result) Then Exit;
end;

Function TLeadLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
(*Var
  DtResponded                      : TDatetime;
  DtCreated                        : TDatetime;
  IDays, IHours, IMinutes, ISeconds: Integer;
  SDays, SHours, SMins, SSecs      : String;*)

Begin
  Result := Inherited DoBeforePost(Sender);
  If Not Result Then Exit;
  If UpdateDate = 0 Then UpdateDate := Now;
  If ActionDate = 0 Then ActionDate := Now;

  IsPhoneFollowUp := (ActionType <> LeadActionFollowup);

(*
  If (ResultTypeId <> 0) And (Duration = '') Then Begin
    DtResponded := Now;
    DtCreated   := CreationDate;
    IDays       := DaysBetween(DtResponded, DtCreated);
    IHours      := HoursBetween(DtResponded, DtCreated);
    IHours      := IHours Mod 24;
    IMinutes    := MinutesBetween(DtResponded, DtCreated);
    IMinutes    := IMinutes Mod 60;
    ISeconds    := SecondsBetween(DtResponded, DtCreated);
    ISeconds    := ISeconds Mod 60;
    SDays       := IntToStr(IDays) + 'D ';
    If IHours < 10 Then Begin
      SHours := '0' + IntToStr(IHours);
    End Else Begin
      SHours := IntToStr(IHours);
    End;
    If IMinutes < 10 Then Begin
      SMins := '0' + IntToStr(IMinutes);
    End Else Begin
      SMins := IntToStr(IMinutes);
    End;
    If ISeconds < 10 Then Begin
      SSecs := '0' + IntToStr(ISeconds);
    End Else Begin
      SSecs := IntToStr(ISeconds);
    End;
    Duration := SDays + SHours + ':' + SMins + ':' + SSecs;
  End;
*)
End;

Function TLeadLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Var
  Bm     : TBookmarkRec;
  Acttype: Integer;
  Actdate: TDatetime;
Begin
  Result := Inherited DoAfterPost(Sender);
  If Not Result Then Exit;
  If (EmployeeID = 0) And (ResultTypeId = 0) And (FollowUpDate = 0) Then Delete
  Else Begin
    // if Assigned(Owner) and (Owner is TLeads) then
    // self.LeadID:= TLeads(Owner).ID;
    If (ActionType <> 0) And (ActionDate <> 0) And (Dataset.Recno > 1) Then Begin
      If GetBookmarkRec(Bm, False) Then
        Try
          Acttype := ActionType;
          Actdate := ActionDate;
          Prior;
          If ResultTypeId <> Acttype Then ResultTypeId                         := Acttype;
          If FollowUpDate <> Actdate Then FollowUpDate                         := Actdate;
          If ResultTypeName <> GetSimpleType(ResultTypeId) Then ResultTypeName := GetSimpleType(ResultTypeId);
          PostDB;
        Finally RestoreBookmarkRec(Bm, False);
        End;
    End;
  End;
End;

{ Property functions }
Function TLeadLines.GetLeadID: Integer;
Begin
  Result := GetIntegerField('LeadID');
End;

Function TLeadLines.GetActionType: Integer;
Begin
  Result := GetIntegerField('ActionType');
End;

Function TLeadLines.GetActiontypename: String;
Begin
  Result := TLeadActionType.IDToggle(ActionType, Connection.Connection);
End;

Function TLeadLines.GetActionID: Integer;
Begin
  Result := GetIntegerField('ActionID');
End;

Function TLeadLines.GetActionRef: String;
Begin
  Result := GetStringField('ActionRef');
End;

Function TLeadLines.GetCreationDate: TDatetime;
Begin
  Result := GetDateTimeField('CreationDate');
End;

Function TLeadLines.GetUpdateDate: TDatetime;
Begin
  Result := GetDateTimeField('UpdateDate');
End;

Function TLeadLines.GetActionDate: TDatetime;
Begin
  Result := GetDateTimeField('ActionDate');
End;

Function TLeadLines.GetFollowUpDate: TDatetime;
Begin
  Result := GetDateTimeField('FollowUpDate');
End;

Function TLeadLines.GetStatusID: Integer;
Begin
  Result := GetIntegerField('StatusID');
End;
function TLeadLines.AppointmentDetails:String;
begin
  REsult :=formatDateTime(formatSettings.ShortDateFormat , ActionDate ) +' at ' + formatDateTime('hh:nn am/pm'  , ActionDate )+' ('  + LocalTimezoneInfo.StandardName +')';

      //REsult :=' Appointment Date: ' + formatDateTime(formatSettings.ShortDateFormat+' - hh:nn am/pm'  , ActionDate )+ chr(10)+chr(13)+ 'Person To Contact : ' + EmployeeName;
    (*With GetNewdataset('Select A.AppointID, A.starttime, a.EndTime, E.EmployeeName '+
                      ' from tblappointments A inner join tblEmployees E on A.trainerID = E.EmployeeId  '+
                      ' where A.AppointID = '+ inttostr(ActionID) , true) do try
      if recordcount =0 then exit;
      REsult := 'Appointment #' + inttostr(fieldbyname('AppointID').AsInteger) +  NL+
                ' Date ' + formatDateTime(formatSettings.ShortDateFormat +' hh:nn am/pm' , fieldbyname('startTime').AsDateTime )+ ' - ' + formatDateTime(formatSettings.ShortDateFormat +' hh:nn am/pm' , fieldbyname('endtime').AsDateTime )+ Nl +
                ' Rep : ' + Fieldbyname('employeeName').AsString;
    finally
      if active then close;
      Free;
    end;*)
end;
function TLeadLines.FollowUpDetails:String;
begin
      REsult := 'Followup  :' + formatDateTime(formatSettings.ShortDateFormat +' hh:nn am/pm' , ActionDate );
end;
function TLeadLines.ToDoDetails:String;
begin
  REsult := 'To Do #' + inttostr(ActionID)+ NL +
            Notes;
end;
function TLeadLines.SalesDetails:String;
begin
    with GetNewDataset('Select SaleId , customername, ShipTo, isInvoice, IsQuote, isSalesorder from tblsales where saleID =' +inttostr(ActionID) , true) do try
      if recordcount =0 then exit;
      REsult := iif(fieldbyname('isInvoice').AsBoolean , 'Invoice' ,iif(fieldbyname('IsQuote').AsBoolean , 'Quote' , iif(fieldbyname('isSalesorder').AsBoolean , 'Sales Order' , 'Sale'))) +'#' +
                inttostr(Fieldbyname('SaleId').AsInteger)+NL+
                fieldbyname('customername').AsString +NL +
                fieldbyname('ShipTo').AsString ;
    finally
      if active then close;
      Free;
    end;

end;

function TLeadLines.getTransactionDetails: String;
begin
           if ActionType = tcDataUtils.LeadActionAppointment     then Result := AppointmentDetails
      else if ActionType = tcDataUtils.LeadActionFollowup        then Result := FollowUpDetails
      else if ActionType = tcDataUtils.LeadActionQuote           then Result := SalesDetails
      else if ActionType = tcDataUtils.LeadActionToDo            then Result := ToDoDetails
      else if ActionType = tcDataUtils.LeadActionSalesOrder      then Result := SalesDetails
      else if ActionType = tcDataUtils.LeadActionInvoice         then Result := SalesDetails
      else Result := '';

  //quotedstr(formatDateTime(FormatSettings.ShortDateFormat,
end;

Function TLeadLines.GetPriority: Integer;
Begin
  Result := GetIntegerField('Priority');
End;

Function TLeadLines.GetEmployeeID: Integer;
Begin
  Result := GetIntegerField('EmployeeID');
End;

Function TLeadLines.GetEmployeeName: String;
Begin
  Result := GetStringField('EmployeeName');
End;

Function TLeadLines.GetDuration: String;
Begin
  Result := GetStringField('Duration');
End;

// function  TLeadLines.GetTypeId         : Integer   ; begin Result := GetIntegerField('TypeId');end;
// function  TLeadLines.GetTypeName       : string    ; begin Result := GetStringField('TypeName');end;
Function TLeadLines.GetHours: Double;
Begin
  Result := GetFloatField('Hours');
End;

Function TLeadLines.GetResultTypeId: Integer;
Begin
  Result := GetIntegerField('ResultTypeId');
End;

Function TLeadLines.GetResultTypeName: String;
Begin
  Result := GetStringField('ResultTypeName');
End;

Function TLeadLines.GetIsPhoneFollowUp: Boolean;
Begin
  Result := GetBooleanField('IsPhoneFollowUp');
End;

Function TLeadLines.GetEntryCount: Integer;
Begin
  Result := GetIntegerField('EntryCount');
End;

Function TLeadLines.GetCreatedByID: Integer;
Begin
  Result := GetIntegerField('CreatedByID');
End;

Function TLeadLines.GetCreatedBy: String;
Begin
  Result := TEmployee.IDToggle(CreatedByID, Connection.Connection);
End;

Function TLeadLines.GetDone: Boolean;
Begin
  Result := GetBooleanField('Done');
End;

Function TLeadLines.GetIsMarketing: Boolean;
Begin
  Result := GetBooleanField('IsMarketing');
End;

Function TLeadLines.GetIsLead: Boolean;
Begin
  Result := GetBooleanField('IsLead');
End;

Function TLeadLines.GetIsList: Boolean;
Begin
  Result := True;
End;

Function TLeadLines.GetNotes: String;
Begin
  Result := GetStringField('Notes');
End;

// function TLeadLines.getActionName: string;
// begin
// Result := tcDataUtils.GetSimpleType(ActionType);
// end;

Procedure TLeadLines.SetLeadID(Const Value: Integer);
Begin
  SetIntegerField('LeadID', Value);
End;

Procedure TLeadLines.SetActionType(Const Value: Integer);
Begin
  SetIntegerField('ActionType', Value);
End;

Procedure TLeadLines.SetActionTypeName(Const Value: String);
Begin
  ActionType := TLeadActionType.IDToggle(Value, Connection.Connection);
  SendEvent(BusObjEvent_Change, BusObjEvent_ActionTypeChanged, Self);
End;

// procedure TLeadLines.SetActionname(const Value: string);
// begin
// ActionType := tcDataUtils.GetSimpleType(Value, SimpleTypes_LeadActionType);
// end;

Procedure TLeadLines.SetActionID(Const Value: Integer);
Begin
  SetIntegerField('ActionID', Value);
End;

Procedure TLeadLines.SetActionRef(Const Value: String);
Begin
  SetStringField('ActionRef', Value);
End;

Procedure TLeadLines.SetCreationDate(Const Value: TDatetime);
Begin
  SetDateTimeField('CreationDate', Value);
End;

Procedure TLeadLines.SetUpdateDate(Const Value: TDatetime);
Begin
  SetDateTimeField('UpdateDate', Value);
End;

Procedure TLeadLines.SetActionDate(Const Value: TDatetime);
Begin
  SetDateTimeField('ActionDate', Value);
End;

Procedure TLeadLines.SetFollowUpDate(Const Value: TDatetime);
Begin
  SetDateTimeField('FollowUpDate', Value);
End;

Procedure TLeadLines.SetStatusID(Const Value: Integer);
Begin
  SetIntegerField('StatusID', Value);
End;

Procedure TLeadLines.SetPriority(Const Value: Integer);
Begin
  SetIntegerField('Priority', Value);
End;

Procedure TLeadLines.SetEmployeeID(Const Value: Integer);
Begin
  SetIntegerField('EmployeeID', Value);
End;

Procedure TLeadLines.SetEmployeeName(Const Value: String);
Begin
  SetStringField('EmployeeName', Value);
End;

Procedure TLeadLines.SetDuration(Const Value: String);
Begin
  SetStringField('Duration', Value);
End;

// procedure TLeadLines.SetTypeId         (const Value: Integer   ); begin SetIntegerField('TypeId'          , Value);end;
// procedure TLeadLines.SetTypeName       (const Value: string    ); begin SetStringField('TypeName'        , Value);end;
Procedure TLeadLines.SetHours(Const Value: Double);
Begin
  SetFloatField('Hours', Value);
End;

Procedure TLeadLines.SetResultTypeId(Const Value: Integer);
Begin
  SetIntegerField('ResultTypeId', Value);
End;

Procedure TLeadLines.SetResultTypeName(Const Value: String);
Begin
  SetStringField('ResultTypeName', Value);
End;

Procedure TLeadLines.SetIsPhoneFollowUp(Const Value: Boolean);
Begin
  SetBooleanField('IsPhoneFollowUp', Value);
End;

Procedure TLeadLines.SetEntryCount(Const Value: Integer);
Begin
  SetIntegerField('EntryCount', Value);
End;

Procedure TLeadLines.SetCreatedByID(Const Value: Integer);
Begin
  SetIntegerField('CreatedByID', Value);
End;

Procedure TLeadLines.SetCreatedBy(Const Value: String);
Begin
  CreatedByID := TEmployee.IDToggle(Value, Connection.Connection);
End;

Procedure TLeadLines.SetDone(Const Value: Boolean);
Begin
  SetBooleanField('Done', Value);
End;

Procedure TLeadLines.SetIsMarketing(Const Value: Boolean);
Begin
  SetBooleanField('IsMarketing', Value);
End;

Procedure TLeadLines.SetIsLead(Const Value: Boolean);
Begin
  SetBooleanField('IsLead', Value);
End;

Procedure TLeadLines.SetNotes(Const Value: String);
Begin
  SetStringField('Notes', Value);
End;

{ TLeads }

Constructor TLeads.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  FBusObjectTypeDescription := 'MarketingLeads';
  FSQL                      := 'SELECT * FROM tblmarketingleads';
  FsMarketingcontactfilter  := '';
End;

Class Function TLeads.GetIDField: String;
Begin
  Result := 'LeadID'
End;

Class Function TLeads.GetKeyStringField: String;
Begin
  Result := 'company'
End;

Class Function TLeads.GetKeyStringProperty: String;
Begin
  Result := 'Company';
End;

Class Function TLeads.GetBusObjectTablename: String;
Begin
  Result := 'tblmarketingleads'
End;

procedure TLeads.UpdateLinesDuration(const Sender: TBusObj; var Abort: Boolean);
var
  s: string;
begin
  if (TLeadLines(Sender).Duration = '') and (TLeadLines(Sender).CreationDate >= fEditStartTime) then begin
    s := IntToStr(DaysBetween(now, fEditStartTime)) + 'D ' +
      FormatDateTime('hh:nn:ss', now - fEditStartTime);
    TLeadLines(Sender).Duration := s;
  end;
end;

Class Procedure TLeads.UpdateStatus(SLeadStatus: String; IClientID: Integer);
Var
  LLead: TLeads;
  Comp : TComponent;
Begin
  Comp := FindExistingComponent('TLeads', 0);
  If Not(Assigned(Comp)) Then Begin
    LLead := TLeads.Create(Nil);
    LLead.LoadSelect('ClientID = ' + QuotedStr(IntToStr(IClientID)));
  End
  Else LLead := TLeads(Comp);
  Try
    If LLead.Count = 0 Then Exit;
    LLead.LeadStatus := SLeadStatus;
    LLead.PostDB;
  Finally
    // if created here, the owner will be nil, otherwise the form is open and is the form's object
    If LLead.Owner = Nil Then Freeandnil(LLead);
  End;
End;

{Class Procedure TLeads.AddProgressionRecord(Const AClientID, AActionType, AActionID: Integer; Const AActionRef, ANotes: String; Const Transdate: TDatetime; Const NewActionId: Integer;
  Const NewActionref: String; Const ADone: Boolean; Const AEmployeeID, AStatusID, APriority: Integer);
Var
  (* lLeadID: Integer; *)
  (* lLine: TLeadLines; *)
  LLead: TLeads;
  (* strSQL:STring; *)
  Comp: TComponent;
  MCID: Integer;
  Function ClientMCID: Integer;
  Begin
    With TempMyquery Do
      Try
        SQL.Text := 'Select ID from tblmarketingcontacts where ifnull(clientId,0) = ' + Inttostr(AClientID);
        Open;
        REsult := FieldByname('ID').AsInteger;
      Finally ClosenFree;
      End;
  End;

Begin
  // lLead :=TLeads.create(nil);
  Comp := FindExistingComponent('TLeads', 0);
  If Not(Assigned(Comp)) Then Begin

    MCID := ClientMCID;
    If MCID = 0 Then Exit; // Marketing Contact record doesn't exists for this client

    LLead := TLeads.Create(Nil);
    LLead.LoadSelect('marketingcontactId = ' + QuotedStr(IntToStr(MCID)));
  End
  Else LLead := TLeads(Comp);
  Try
    If LLead.Count = 0 Then Exit;

    If Not(LLead.Lines.Dataset.Locate('LeadId;ActionType;ActionID', VarArrayof([LLead.ID, AActionType, AActionID]), [])) Then Begin
      LLead.Lines.New;
      // lLead.Lines.LeadID          := lLeadID;
      LLead.Lines.ActionType                          := AActionType;
      If AEmployeeID <> 0 Then LLead.Lines.EmployeeID := AEmployeeID
      Else LLead.Lines.EmployeeID                     := Appenv.Employee.EmployeeID;
    End;

    If AEmployeeID <> 0 Then LLead.Lines.EmployeeID := AEmployeeID;
    LLead.Lines.ActionRef                           := NewActionref;
    LLead.Lines.ActionID                            := NewActionId;
    LLead.Lines.Notes                               := ANotes;
    If Not LLead.Lines.Done Then LLead.Lines.Done   := ADone;
    LLead.Lines.StatusID                            := AStatusID;
    LLead.Lines.IsLead                              := True;
    LLead.Lines.ActionDate                          := Transdate;
    If APriority >= 0 Then LLead.Lines.Priority     := APriority;
    LLead.Lines.PostDB;
    LLead.Save;
    GlobalEvents.Notify(LLead.Lines, GEVENT_LEAD_REFRESH);
  Finally
    // if created here, the owner will be nil, otherwise the form is open and is the form's object
    If LLead.Owner = Nil Then Freeandnil(LLead);
  End;
  (* strSqL := 'SELECT LeadID FROM tblMarketingLeads WHERE ClientID = ' + QuotedStr(IntToStr(aClientID));
    With GetDataSet(strSQL) do try
    lLeadID := FieldByName('LeadID').AsInteger;
    finally
    if active then close;
    Free;
    end;
    if lLeadID = 0 then exit;
    lLead :=TLeads.create(nil);
    lLine := TLeadLines.Create(nil);
    try
    strSQL := ' LeadID = ' + IntToStr(lLeadID) +
    ' AND ActionType = ' + IntToStr(aActionType) +
    ' AND ActionID = ' + IntToStr(aActionID) ;
    lLine.LoadSelect(strSQL);
    if lLine.EOF then begin
    lLine.New;
    lLine.LeadID      := lLeadID;
    lLine.ActionType  := aActionType;
    if    aEmployeeID <> 0 then lLine.EmployeeID := aEmployeeID
    else  lLine.EmployeeID := AppEnv.Employee.EmployeeID;
    end;
    if aEmployeeID      <> 0 then
    lLine.EmployeeID:= aEmployeeID;
    lLine.ActionRef     := NewActionref;
    lLine.ActionID      := NewActionID;
    lLine.Notes         := aNotes;
    lLine.Done          := aDone;
    lLine.StatusID      := aStatusID;
    lLine.IsLead        := true;
    lLine.ActionDate  := transDate;
    if aPriority >= 0 then
    lLine.Priority    := aPriority;
    lLine.PostDB;
    lLine.Save;
    GlobalEvents.Notify(lLine, GEVENT_LEAD_REFRESH);
    finally
    FreeAndNil(lLine);
    end; *)
End;}

Destructor TLeads.Destroy;
Begin
  Inherited;
End;

Procedure TLeads.LoadFromXMLNode(Const Node: IXMLNode);
Var
  LinesNode: IXMLNode;
  X        : Integer;
Begin
  Inherited;
  SetPropertyFromNode(Node, 'MarketingContactID');
  SetPropertyFromNode(Node, 'company');
  SetPropertyFromNode(Node, 'ClientID');
  SetBooleanPropertyFromNode(Node, 'IsLead');
  SetPropertyFromNode(Node, 'RepID');
  SetPropertyFromNode(Node, 'Repname');
  SetPropertyFromNode(Node, 'Notes');
  SetPropertyFromNode(Node, 'EnteredBy');
  SetPropertyFromNode(Node, 'EnteredByEmployeeID');
  SetPropertyFromNode(Node, 'LeadStatus');

  { delete existing lines if they exist }
  While Lines.Count > 0 Do Lines.Delete;
  LinesNode := Node.ChildNodes.FindNode('lines');
  If Assigned(LinesNode) Then Begin
    For X := 0 To LinesNode.ChildNodes.Count - 1 Do Begin
      Lines.New;
      Lines.LoadFromXMLNode(LinesNode.ChildNodes[X]);
      Lines.PostDB;
    End;
  End;
End;

Procedure TLeads.SaveToXMLNode(Const Node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(Node, 'MarketingContactID', MarketingContactID);
  AddXMLNode(Node, 'company', Company);
  AddXMLNode(Node, 'ClientID', ClientID);
  AddXMLNode(Node, 'IsLead', IsLead);
  AddXMLNode(Node, 'RepID', RepID);
  AddXMLNode(Node, 'EnteredByEmployeeID', EnteredByEmployeeID);
  AddXMLNode(Node, 'LeadStatus', LeadStatus);
  Self.Lines.XMLPropertyNode := Node.AddChild('lines');
  Self.Lines.XMLPropertyName := XMLNodeName + 'Line';
  Self.Lines.IterateRecords(GetPropertyXMLCallback);
End;

Procedure TLeads.NewFollowup;
Begin
  Lines.New;
  Lines.ActionID       := TcDataUtils.LeadActionFollowup;
  Lines.ActionTypeName := GetStatus(LatFollowUp);
  Lines.IsLead         := IsLead;

End;

Function TLeads.GetStatus(ActionType: TLeadActions): String;
Begin
  If ActionType = LatFollowUp Then Result         := 'Follow-up'
  Else If ActionType = LatAppointment Then Result := 'Appointment'
  Else If ActionType = LatQuote Then Result       := 'Quote'
  Else If ActionType = LatInvoice Then Result     := 'Invoice'
  Else If ActionType = LatSalesOrder Then Result  := 'SalesOrder'
  Else If ActionType = LatEmail Then Result       := 'Email'
  Else Result                                     := '';
End;

Procedure TLeads.UpdateStatusofLastLine(ActionType: TLeadActions);
Begin
  If Lines.Count = 0 Then Exit;
  Lines.Last;
  Lines.ResultTypeId := TcDataUtils.GetSimpleType(GetStatus(ActionType), SimpleTypes_LeadActionType);
  Lines.PostDB;
End;

Function TLeadLines.GetIsTransationREcord: Boolean;
Begin
  Result := (ActionType = LeadActionAppointment) Or (ActionType = LeadActionInvoice) Or (ActionType = LeadActionSalesOrder) Or (ActionType = LeadActionQuote);
End;

Function TLeads.IsOktoDeleteLine: Boolean;
Begin
  If Lines.IsTransationRecord Then Begin
    AddResult(False, RssWarning, 0, 'Linked Transaction should be deleted before deleting the Lead');
    Result := False;
    Exit;
  End;
  If Lines.ActionType = LeadActionLead Then Begin
    AddResult(False, RssWarning, 0, 'This is a conversion record(Telemarketing to Lead).Its not possible to delete it.');
    Result := False;
    Exit;
  End;
  Result := True;
End;

Procedure TLeads.DeleteCurLines;
Begin
  Lines.Delete;
  Dirty := True;
End;

Function TLeads.NewAction(ActionType: TLeadActions): Boolean;
Begin
  Result := False;
  // if not(Save) then exit;
  PostDB;
  Lines.PostDB;
  If Not Save Then Exit;
  If ActionType = LatFollowUp Then Begin
    UpdateStatusofLastLine(ActionType);
    NewFollowup;
  End Else Begin
    If Not MarketingContacts.ConvertToClient((ActionType = LatQuote) Or (ActionType = LatInvoice) Or (ActionType = LatSalesOrder)) Then Exit;
    ClientID := MarketingContacts.ClientID;
    PostDB;
    Connection.CommitTransaction; // new transaction uses a different action, so should be commited
    Connection.BeginTransaction;
    UpdateStatusofLastLine(ActionType);
    If ActionType = LatAppointment Then Begin
      GlobalEvents.Notify(Self, GEVENT_LEAD_CREATEAPPOINTMENT);
    End else If ActionType = LatToDo Then Begin
      GlobalEvents.Notify(Self, GEVENT_LEAD_CREATETODO);
    End Else If ActionType = LatQuote Then Begin
      GlobalEvents.Notify(Self, GEVENT_LEAD_CREATEQUOTE);
    End Else If ActionType = LatInvoice Then Begin
      GlobalEvents.Notify(Self, GEVENT_LEAD_CREATEINVOICE);
    End Else If ActionType = LatSalesOrder Then Begin
      GlobalEvents.Notify(Self, GEVENT_LEAD_CREATESALESORDER);
    End;
    PostDB;
  End;
  Result := True;
End;

Function TLeads.LockTRans: Boolean;
Var
  FLockFailed: Boolean;
Begin
  Result      := True;
  FLockFailed := False;
  Try
    If Not(Self.Lock) Then FLockFailed                   := False
    Else If Not(Lines.Lock) Then FLockFailed             := False
    Else If Not(MarketingContacts.Lock) Then FLockFailed := False;
  Finally
    If FLockFailed Then Begin
      Userlock.UnLock(LockGroupName);
      Result := False;
    End;
  End;
End;

class function TLeads.MakeLead(const MCID: Integer): Integer;
begin
  REsult:= 0;
  if MCID =0 then exit;
  With TLeads.CreateWithNewConn(nil) do try
    LoadSelect('MarketingContactID = ' + inttostr(MCID));
    if count > 0 then begin
      REsult := ID;
      Exit;
    end;
    New;
    MarketingContactID := MCID;
    PostDB;
    REsult := ID;
  finally
    Free;
  end;
end;

Procedure TLeads.ValidateLines(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TLeadLines) Then Exit;
  If Not TLeadLines(Sender).ValidateData Then Begin
    Abort         := True;
    AllLinesValid := False;
  End;
End;

Class Function TLeads._Schema: String;
Begin
  Result := Inherited;
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_1', 'RepID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_1', 'RepName', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_2', 'EnteredByEmployeeID', 'ID');
  TBOSchema.AddRefType(Result, 'TEmployee', 'emp_2', 'EnteredByEmployee', 'EmployeeName');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'CustomerName', 'ClientName');
  TBOSchema.AddRefType(Result, 'TOtherContact', 'OtherContactObj', 'CustomerName', 'ClientName');
  TBOSchema.AddRefType(Result, 'TMarketingContact', 'MarketingContacts', 'MarketingContactID', 'ID');
  TBOSchema.AddRefType(Result, 'TMarketingContact', 'MarketingContacts', 'Company', 'Company');

End;

Function TLeads.ValidateData: Boolean;
Begin
  Result := False;
  Resultstatus.Clear;

  If MarketingContactID = 0 Then Begin
    If (MarketingContacts.Count > 0) And (MarketingContacts.ID > 0) Then MarketingContactID := MarketingContacts.ID
    Else Begin
      AddResult(False, RssWarning, 0, 'Marketing contact should not be blank');
      Exit;
    End;
  End;
  If HasOtherMarketingrecord Then Exit;

  AllLinesValid := True;
  Lines.IterateRecords(ValidateLines);
  If AllLinesValid = False Then Exit;

  If Lines.Count = 0 Then Begin
    If Not(IsLead) Then Begin
      AddResult(False, RssWarning, 0, 'Please add a follow-up line first.');
      Exit;
    End;
  End;
  If IsLead Then
    If RepID = 0 Then Begin
      AddResult(False, RssWarning, 0, 'Rep should not be blank.');
      Exit;
    End;
  Result := True;
End;

Procedure TLeads.CheckforOtherMarketingRecord(Var LeadId: Integer; Var IsLead: Boolean);
Begin
  With TempMyQuery(TERPConnection(Self.Connection.Connection)) Do
    Try
      SQL.Add('select LeadId, IsLead from tblMarketingLeads');
      SQL.Add('where MarketingContactId = ' + IntToStr(MarketingContactID));
      SQL.Add('and LeadID <>  ' + IntToStr(ID));
      Open;
      LeadId := FieldByName('LeadId').AsInteger;
      IsLead := FieldByName('IsLead').AsBoolean;
    Finally ClosenFree;
    End;
End;

Function TLeads.HasOtherMarketingRecord: Boolean;
Var
  LeadId: Integer;
  IsLead: Boolean;
Begin
  CheckforOtherMarketingRecord(LeadId, IsLead);
  REsult := LeadId <> 0;
  If LeadId <> 0 Then Begin
    If IsLead Then AddResult(False, RssWarning, 0, 'Another Lead record already exists for this marketing contact')
    Else AddResult(False, RssWarning, 0, 'Another Telemarketing record already exists for this marketing contact');
  End;
End;

Function TLeads.Save: Boolean;
Begin
  Result := False;
  If Not ValidateData Then Exit;
  PostDB;
  // Lines.PostDB;
  AllLinesValid := True;
  Lines.IterateRecords(SaveLines);
  If Not(AllLinesValid) Then Begin
    Result := False;
    Exit;
  End;

  Lines.IterateRecords(UpdateLinesDuration);
  Lines.PostDb;

  MarketingContacts.PostDB;
  Client.PostDB;
  Result               := Inherited Save;
  If Result Then Dirty := False;
End;

Procedure TLeads.SaveLines(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not TLeadLines(Sender).Save Then Begin
    Abort         := True;
    AllLinesValid := False;
  End;
End;

Procedure TLeads.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
  fEditStartTime := now;
End;

Procedure TLeads.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  Inherited;
  If SysUtils.SameText(Sender.FieldName, 'company') Then Begin
    If Not RawMode Then Begin
      PostDB;
      If Company = '' Then MarketingContactID := 0
      Else MarketingContactID                 := TMarketingContact.IDToggle(Company, Self.Connection.Connection); // tcDatautils.GetMarketingcontactId(Company);
      If MarketingContactID = 0 Then AddEvent(BusObjEvent_Change, BusObjEventVal_Marketingcontact_ClientSelected, Self.ID)
      Else AddEvent(BusObjEvent_Change, BusObjEventVal_MarketingcontactChanged, Self.ID);
    End;
  End
  Else If SysUtils.SameText(Sender.FieldName, 'MarketingcontactId') Then Begin
    If Not RawMode Then Begin
      If Company <> TMarketingContact.IDToggle(MarketingContactID, Self.Connection.Connection) Then Begin // tcDatautils.GetMarketingContactName(MarketingcontactId) then  begin
        If MarketingcontactId = 0 Then Company := ''
        Else Company                           := TMarketingContact.IDToggle(MarketingContactID, Self.Connection.Connection); // tcDatautils.GetMarketingContactName(MarketingcontactId);
        DoFieldOnChange(Dataset.Findfield('company'));
      End;
    End;
  End;
End;

Function TLeads.GetSQL: String;
Begin
  Result := Inherited GetSQL;
End;

Function TLeads.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterPost(Sender);
End;

Function TLeads.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then Exit;
  EnteredByEmployeeID := Appenv.Employee.EmployeeID;
  LeadStatus          := TcDataUtils.GetSimpleTypeDefaultStr('LeadStatusType');
  RepID               := Appenv.Employee.EmployeeID;
  RepName             := Appenv.Employee.EmployeeName;
  CreatedOn := now;
End;

Function TLeads.GetLines: TLeadLines;
Begin
  PostDb;
  Result := TLeadLines(GetContainerComponent(TLeadLines, ' LeadID = ' + IntToStr(Self.ID)));
End;

Function TLeads.GetDaysSinceLastAction: Integer;
Var
  StrSQL: String;
Begin
  Result := 0;
  StrSQL := 'SELECT Datediff(CURDATE() , if(ifnull(ActionDate,0)>ifnull(Followupdate,0) ,ActionDate, Followupdate)) as DiffinDays ' + ' FROM tblMarketingLeadLines ' + ' WHERE LeadID = ' + IntToStr(ID)
    + ' ORDER BY ActionDate DESC LIMIT 1';
  With GetNewDataset(StrSQL, True) Do
    Try
      If Recordcount = 0 Then Exit;
      Result := FieldByname('DiffinDays').AsInteger;
    Finally
      If Active Then Close;
      Free;
    End;
End;

Function TLeads.GetMarketingcontactfilter: String;
Begin
  If FsMarketingcontactfilter <> '' Then
  Else If MarketingContactID <> 0 Then FsMarketingcontactfilter := ' ID = ' + IntToStr(Self.MarketingContactID)
  Else FsMarketingcontactfilter                                 := ' ID not in (Select marketingcontactId from tblMarketingleads ML)';

  Result := FsMarketingcontactfilter;
End;

Function TLeads.GetMarketingContacts: TMarketingContact;
Begin
  Result := TMarketingContact(GetContainerComponent(TMarketingContact, ' ID = ' + IntToStr(Self.MarketingContactID)));
End;

Function TLeads.GetClient: Tclient;
Begin
  Result := Tclient(GetContainerComponent(Tclient, ' ClientID = ' + IntToStr(Self.ClientID)));
End;

{ Property functions }
Function TLeads.GetMarketingContactID: Integer;
Begin
  Result := GetIntegerField('MarketingContactID');
End;

Function TLeads.Getcompany: String;
Begin
  Result := GetStringField('company');
End;

function TLeads.GetCreatedOn: TDateTime;
begin
  result := GetDateTimeField('CreatedOn');
end;

Function TLeads.GetCustomerName: String;
Begin
  If Client.IsCustomer Then Result := Client.ClientName
  Else Result                      := '';
End;

Function TLeads.GetClientID: Integer;
Begin
  Result := GetIntegerField('ClientID');
End;

Function TLeads.GetIsLead: Boolean;
Begin
  Result := GetBooleanField('IsLead');
End;

Function TLeads.GetRepID: Integer;
Begin
  Result := GetIntegerField('RepID');
End;

Function TLeads.GetRepName: String;
Begin
  Result := TEmployee.IDToggle(RepID, Connection.Connection);
End;

Function TLeads.GetEnteredByEmployee: String;
Begin
  Result := TEmployee.IDToggle(EnteredByEmployeeID, Connection.Connection);
End;

Function TLeads.GetNotes: String;
Begin
  Result := GetStringField('Notes');
End;

Function TLeads.GetOtherContactName: String;
Begin
  If Client.IsOtherContact Then Result := Client.ClientName
  Else Result                          := '';
End;

Function TLeads.GetEnteredByEmployeeID: Integer;
Begin
  Result := GetIntegerField('EnteredByEmployeeID');
End;

Function TLeads.GetLeadStatus: String;
Begin
  Result := GetStringField('LeadStatus');
End;

Procedure TLeads.SetMarketingContactID(Const Value: Integer);
Begin
  SetIntegerField('MarketingContactID', Value);
End;

Procedure TLeads.Setcompany(Const Value: String);
Begin
  SetStringField('company', Value);
End;

procedure TLeads.SetCreatedOn(const Value: TDateTime);
begin
  SetDateTimeField('CreatedOn', Value);
end;

Procedure TLeads.SetCustomerName(Const Value: String);
Begin
  ClientID := TCustomer.IDToggle(Value, Connection.Connection);
End;

Procedure TLeads.SetNotes(Const Value: String);
Begin
  SetStringField('Notes', Value);
End;

Procedure TLeads.SetOtherContactName(Const Value: String);
Begin
  ClientID := TOtherContact.IDToggle(Value, Connection.Connection);
End;

Procedure TLeads.SetClientID(Const Value: Integer);
Begin
  SetIntegerField('ClientID', Value);
End;

Procedure TLeads.SetIsLead(Const Value: Boolean);
Begin
  SetBooleanField('IsLead', Value);
End;

Procedure TLeads.SetRepID(Const Value: Integer);
Begin
  SetIntegerField('RepID', Value);
End;

Procedure TLeads.SetRepName(Const Value: String);
Begin
  RepID := TEmployee.IDToggle(Value, Connection.Connection);
End;

Procedure TLeads.SetEnteredByEmployee(Const Value: String);
Begin
  EnteredByEmployeeID := TEmployee.IDToggle(Value, Connection.Connection);
End;

Procedure TLeads.SetEnteredByEmployeeID(Const Value: Integer);
Begin
  SetIntegerField('EnteredByEmployeeID', Value);
End;

Procedure TLeads.SetLeadStatus(Const Value: String);
Begin
  SetStringField('LeadStatus', Value);
End;

{ TLeadToAddProgressionRecord }

function TLeadToAddProgressionRecord.GetLines: TLeadLines;
begin
  PostDb;
//  Result := TLeadLines(GetContainerComponent(TLeadLines, ' LeadID = ' + IntToStr(Self.ID)+' and LeadLineID >= '  + inttostr(LastLeadLineID)));
  Result := TLeadLines(GetContainerComponent(TLeadLines, ' LeadID = ' + IntToStr(Self.ID)));
end;

(*function TLeadToAddProgressionRecord.LastLeadLineID: Integer;
begin
  With getNewDataset('Select max(leadlineId) as leadlineId from tblmarketingleadlines  where LeadId = ' + inttostr(ID) , false) do try
    result := Fieldbyname('leadlineId').asInteger;
  finally
    if active then close;
    Free;
  end;
end;*)
Class Procedure TLeadToAddProgressionRecord.AddProgressionRecord(Const AClientID, AActionType, AActionID: Integer; Const AActionRef, ANotes: String; Const Transdate: TDatetime; Const NewActionId: Integer;
  Const NewActionref: String; Const ADone: Boolean; Const AEmployeeID, AStatusID, APriority: Integer);
Var
  LeadToAddProgressionRecord: TLeads;
  Comp: TComponent;
  MCID: Integer;
  Newentry:Boolean;
  Function ClientMCID: Integer;
  Begin
    With TempMyquery Do
      Try
        SQL.Text := 'Select ID from tblmarketingcontacts where ifnull(clientId,0) = ' + Inttostr(AClientID);
        Open;
        REsult := FieldByname('ID').AsInteger;
      Finally ClosenFree;
      End;
  End;

Begin
  Newentry:=False;
  Comp := FindExistingComponent('TLeads', 0);//FindExistingComponent('TLeadToAddProgressionRecord', 0);
  If Not(Assigned(Comp)) Then Begin
    if AClientID =0 then exit;
    MCID := ClientMCID;
    If MCID = 0 Then Exit; // Marketing Contact record doesn't exists for this client
    LeadToAddProgressionRecord := TLeadToAddProgressionRecord.Create(Nil);
    LeadToAddProgressionRecord.LoadSelect('marketingcontactId = ' + QuotedStr(IntToStr(MCID)));
  End  Else LeadToAddProgressionRecord := TLeads(Comp);

  Try
    If LeadToAddProgressionRecord.Count = 0 Then Exit;

    if not (LeadToAddProgressionRecord.Lock) then exit;
    With LeadToAddProgressionRecord.Lines do begin
        If Not(Dataset.Locate('LeadId;ActionType;ActionID', VarArrayof([LeadToAddProgressionRecord.ID, AActionType, AActionID]), [])) Then Begin
          Newentry:=True;
          New;
          ActionType                          := AActionType;
          If AEmployeeID <> 0 Then EmployeeID := AEmployeeID Else EmployeeID                     := Appenv.Employee.EmployeeID;
        End;

        If AEmployeeID <> 0 Then EmployeeID := AEmployeeID;
        ActionRef                           := NewActionref;
        ActionID                            := NewActionId;
        Notes                               := ANotes;
        If Not Done         Then Done       := ADone;
        StatusID                            := AStatusID;
        IsLead                              := True;
        ActionDate                          := Transdate;
        If APriority >= 0   Then Priority   := APriority;
        PostDB;
    end;
    LeadToAddProgressionRecord.SendEvent(BusobjEvent_Event, BusObjEvent_NewLeadActionRecord, LeadToAddProgressionRecord);
    LeadToAddProgressionRecord.Save;
    GlobalEvents.Notify(LeadToAddProgressionRecord.Lines, GEVENT_LEAD_REFRESH);
    LeadToAddProgressionRecord.SendEvent(BusobjEvent_Event, BusObjEvent_NewLeadActionRecordCreated, LeadToAddProgressionRecord);
    if NewEntry then
      if AActiontype =  LeadActionAppointment then
        LeadToAddProgressionRecord.SendEvent(BusobjEvent_Event, BusObjEvent_NewLeadAppointmentRecord, LeadToAddProgressionRecord);

  Finally
    If LeadToAddProgressionRecord.Owner = Nil Then Freeandnil(LeadToAddProgressionRecord);
  End;
end;

Initialization

RegisterClassOnce(TLeads);
RegisterClassOnce(TLeadLines);

End.
