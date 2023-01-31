Unit busobjMessages;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  23/05/11  1.00.00  bs  Initial Version.
}

Interface

Uses BusObjBase, DB, Classes, XMLIntf;

Type
  TMessageLines = Class(TMSBusObj)
    Private
      Function GeTMessagesID: Integer;
      Function GetEmployeeId: Integer;
      Function GetEnteredBy: Integer;
      Function GetEmployeeName: String;
      Function GetEnteredbyname: String;
      Function GetDetails: String;
      Function GetCallPriority: Integer;
      Function GetResponsedueOn: TDateTime;
      Function GetResponsedueTimeFrom: TDateTime;
      Function GetResponsedueTimeTo: TDateTime;
      Procedure SeTMessagesID(Const Value: Integer);
      Procedure SetEmployeeId(Const Value: Integer);
      Procedure SetEnteredBy(Const Value: Integer);
      Procedure SetEmployeeName(Const Value: String);
      Procedure SetEnteredbyname(Const Value: String);
      Procedure SetDetails(Const Value: String);
      Procedure SetCallPriority(Const Value: Integer);
      Procedure SetResponsedueOn(Const Value: TDateTime);
      Procedure SetResponsedueTimeFrom(Const Value: TDateTime);
      Procedure SetResponsedueTimeTo(Const Value: TDateTime);
      Function GetDateAndTime: TDateTime;
      Procedure SetDateAndTime(Const Value: TDateTime);
      Function getDeptId: Integer;
      Procedure setDeptId(Const Value: Integer);
      Function getTypeID: Integer;
      Procedure setTypeID(Const Value: Integer);
      Function GetDone: Boolean;
      Procedure SetDone(Const Value: Boolean);
      Function getDeptName: String;
      Function getTypeName: String;
      Procedure setDeptName(Const Value: String);
      Procedure setTypeName(Const Value: String);
      Function getMessageType: String;
      Procedure setMessageType(Const Value: String);
      Function getActiontype: String;
      Procedure setActiontype(Const Value: String);
    function GetTimeSinceLast: TDateTime;
    procedure SetTimeSinceLast(const Value: TDateTime);
    function GetPeriodSinceLast: string;
    function GetSupportLogID: integer;
    procedure SetSupportLogID(const Value: integer);

    Protected
      Procedure OnDataIdChange(Const ChangeType
        : TBusObjDataChangeType); Override;
      Procedure DoFieldOnChange(Sender: TField); Override;
      Function GetSQL: String; Override;
      Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
      Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
    Public
      Class Function GetIDField: String; Override;
      Class Function GetBusObjectTablename: String; Override;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      Procedure LoadFromXMLNode(Const node: IXMLNode); Override;
      Procedure SaveToXMLNode(Const node: IXMLNode); Override;
      Function ValidateData: Boolean; Override;
      Function Save: Boolean; Override;
    Published
      Property MessagesID  : Integer Read GeTMessagesID Write SeTMessagesID;
      Property EmployeeId  : Integer Read GetEmployeeId Write SetEmployeeId;
      Property EnteredBy  : Integer Read GetEnteredBy Write SetEnteredBy;
      Property EmployeeName: String Read GetEmployeeName Write SetEmployeeName;
      Property Enteredbyname: String Read GetEnteredbyname Write SetEnteredbyname;
      Property Details     : String Read GetDetails Write SetDetails;
      Property CallPriority: Integer Read GetCallPriority Write SetCallPriority;
      Property ResponsedueOn: TDateTime Read GetResponsedueOn
        Write SetResponsedueOn;
      Property ResponsedueTimeFrom: TDateTime Read GetResponsedueTimeFrom
        Write SetResponsedueTimeFrom;
      Property ResponsedueTimeTo: TDateTime Read GetResponsedueTimeTo
        Write SetResponsedueTimeTo;
      Property DateAndTime: TDateTime Read GetDateAndTime Write SetDateAndTime;
      Property DeptId     : Integer Read getDeptId Write setDeptId;
      Property TypeID     : Integer Read getTypeID Write setTypeID;
      Property Done       : Boolean Read GetDone Write SetDone;
      Property DeptName   : String Read getDeptName Write setDeptName;
      Property TypeName   : String Read getTypeName Write setTypeName;
      Property MessageType: String Read getMessageType Write setMessageType;
      Property Actiontype : String Read getActiontype Write setActiontype;
      property TimeSinceLast: TDateTime read GetTimeSinceLast write SetTimeSinceLast;
      property PeriodSinceLast: string read GetPeriodSinceLast;
      property SupportLogId: integer read GetSupportLogID write SetSupportLogID;
  End;

  TMessages = Class(TMSBusObj)
    Private
      AllLinesValid: Boolean;
      fsDetails:String;

      Function GetFromId: Integer;
      Function GetNameId: Integer;
      Function GetContactName: String;
      Function GetDone: Boolean;
      Function GetDoneDateTime: TDateTime;
      Function GetLastName: String;
      Function GetPhone: String;
      Function GetMobile: String;
      Function GetEmail: String;
      Function GetFax: String;
      Function GetSource: String;
      Function GetCompany: String;
      Function GetCreateDateAndtime: TDateTime;
      Function GetcontactType: String;
      Function GetContactID: Integer;
      Function GetDefaultContactMethod: String;

      Procedure SetFromId(Const Value: Integer);
      Procedure SetNameId(Const Value: Integer);
      Procedure SetContactName(Const Value: String);
      Procedure SetDone(Const Value: Boolean);
      Procedure SetDoneDateTime(Const Value: TDateTime);
      Procedure SetLastName(Const Value: String);
      Procedure SetPhone(Const Value: String);
      Procedure SetMobile(Const Value: String);
      Procedure SetEmail(Const Value: String);
      Procedure SetFax(Const Value: String);
      Procedure SetSource(Const Value: String);
      Procedure SetCompany(Const Value: String);
      Procedure SetCreateDateAndtime(Const Value: TDateTime);
      Procedure SetcontactType(Const Value: String);
      Procedure SetContactID(Const Value: Integer);
      Procedure SetDefaultContactMethod(Const Value: String);
      Procedure ValidateCallback(Const Sender: TBusObj; Var Abort: Boolean);
      Procedure GetDetailsCallback(Const Sender: TBusObj; Var Abort: Boolean);
      Function geTMessageLines: TMessageLines;
      Function GetRepID: Integer;
      Function GetRepName: String;
      Procedure SetRepID(Const Value: Integer);
      Procedure SetRepName(Const Value: String);
      Function getIsFromCustomer: Boolean;
      Function getIsFromEmployee: Boolean;
      Function getIsFromJob: Boolean;
      Function getIsFromMarketingContact: Boolean;
      Function getIsFromProspect: Boolean;
      Function getIsFromSupplier: Boolean;
      function getDetails: String;
    Protected
      Procedure OnDataIdChange(Const ChangeType
        : TBusObjDataChangeType); Override;
      Procedure DoFieldOnChange(Sender: TField); Override;
      Function GetSQL: String; Override;
      Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
      Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
      Function ExportsubClasses(Const node: IXMLNode): Boolean; Override;
    Public
      Class Function GetIDField: String; Override;
      Class Function GetBusObjectTablename: String; Override;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      Procedure LoadFromXMLNode(Const node: IXMLNode); Override;
      Procedure SaveToXMLNode(Const node: IXMLNode); Override;
      Function ValidateData: Boolean; Override;
      Function Save: Boolean; Override;
      Property Lines: TMessageLines Read geTMessageLines;
      Procedure Alldone;
      Procedure AlldoneCallback(Const Sender: TBusObj; Var Abort: Boolean);
      Property IsFromCustomer: Boolean Read getIsFromCustomer;
      Property IsFromSupplier: Boolean Read getIsFromSupplier;
      Property IsFromJob: Boolean Read getIsFromJob;
      Property IsFromProspect: Boolean Read getIsFromProspect;
      Property IsFromMarketingContact: Boolean Read getIsFromMarketingContact;
      Property IsFromEmployee: Boolean Read getIsFromEmployee;
      Property Details :String read getDetails;

    Published

      Property FromId      : Integer Read GetFromId Write SetFromId;
      Property NameId      : Integer Read GetNameId Write SetNameId;
      Property ContactName : String Read GetContactName Write SetContactName;
      Property Done        : Boolean Read GetDone Write SetDone;
      Property DoneDateTime: TDateTime Read GetDoneDateTime
        Write SetDoneDateTime;
      Property LastName         : String Read GetLastName Write SetLastName;
      Property Phone            : String Read GetPhone Write SetPhone;
      Property Mobile           : String Read GetMobile Write SetMobile;
      Property Email            : String Read GetEmail Write SetEmail;
      Property Fax              : String Read GetFax Write SetFax;
      Property Source           : String Read GetSource Write SetSource;
      Property Company          : String Read GetCompany Write SetCompany;
      Property CreateDateAndtime: TDateTime Read GetCreateDateAndtime
        Write SetCreateDateAndtime;
      Property contactType: String Read GetcontactType Write SetcontactType;
      Property ContactID  : Integer Read GetContactID Write SetContactID;
      Property DefaultContactMethod: String Read GetDefaultContactMethod
        Write SetDefaultContactMethod;
      Property RepName: String Read GetRepName Write SetRepName;
      Property RepID  : Integer Read GetRepID Write SetRepID;
  End;

Implementation

Uses
  tcDataUtils, CommonLib, BusObjConst, sysutils, AppEnvironment,
  BusObjEmployeeDetails, tcconst, DateUtils, ERPDbComponents,
  BusObjEmployee;

{ TMessages }

Procedure TMessages.Alldone;
Begin
  Lines.PostDB;
  Lines.Iteraterecords(AlldoneCallback);
End;

Procedure TMessages.AlldoneCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TMessageLines) Then
    exit;
  TMessageLines(Sender).Done := True;
  TMessageLines(Sender).PostDB;
End;

Constructor TMessages.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  fBusObjectTypeDescription := 'messages';
  fSQL                      := 'SELECT * FROM tblmessages';
End;

Destructor TMessages.Destroy;
Begin
  Inherited;
End;

Procedure TMessages.LoadFromXMLNode(Const node: IXMLNode);
Begin
  Inherited;

  SetPropertyFromNode(node, 'FromId');
  SetPropertyFromNode(node, 'NameId');
  SetPropertyFromNode(node, 'ContactName');
  SetBooleanPropertyFromNode(node, 'Done');
  SetDateTimePropertyFromNode(node, 'DoneDateTime');
  SetPropertyFromNode(node, 'LastName');
  SetPropertyFromNode(node, 'Phone');
  SetPropertyFromNode(node, 'Mobile');
  SetPropertyFromNode(node, 'Email');
  SetPropertyFromNode(node, 'Fax');
  SetPropertyFromNode(node, 'Source');
  SetPropertyFromNode(node, 'Company');
  SetDateTimePropertyFromNode(node, 'CreateDateAndtime');
  SetPropertyFromNode(node, 'contactType');
  SetPropertyFromNode(node, 'ContactID');
  SetPropertyFromNode(node, 'DefaultContactMethod');
End;

Procedure TMessages.SaveToXMLNode(Const node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(node, 'FromId', FromId);
  AddXMLNode(node, 'NameId', NameId);
  AddXMLNode(node, 'ContactName', ContactName);
  AddXMLNode(node, 'Done', Done);
  AddXMLNode(node, 'DoneDateTime', DoneDateTime);
  AddXMLNode(node, 'LastName', LastName);
  AddXMLNode(node, 'Phone', Phone);
  AddXMLNode(node, 'Mobile', Mobile);
  AddXMLNode(node, 'Email', Email);
  AddXMLNode(node, 'Fax', Fax);
  AddXMLNode(node, 'Source', Source);
  AddXMLNode(node, 'Company', Company);
  AddXMLNode(node, 'CreateDateAndtime', CreateDateAndtime);
  AddXMLNode(node, 'contactType', contactType);
  AddXMLNode(node, 'ContactID', ContactID);
  AddXMLNode(node, 'DefaultContactMethod', DefaultContactMethod);
  AddXMLNode(node, 'Details', Details);
  ExportsubClasses(node);
End;

Function TMessages.ValidateData: Boolean;
Begin
  Result := False;
  Resultstatus.Clear;
  If ContactName = '' Then Begin
    Resultstatus.AddItem(False, rssError, BOR_No_Message_Name,
      'Name should not be blank');
    exit;
  End;

  AllLinesValid := True;
  Lines.Iteraterecords(ValidateCallback);
  Result := AllLinesValid;
End;

Procedure TMessages.ValidateCallback(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TMessageLines) Then
    exit;
  If Not TMessageLines(Sender).ValidateData Then Begin
    AllLinesValid := False;
    Abort         := True;
  End;
End;

Function TMessages.ExportsubClasses(Const node: IXMLNode): Boolean;
Begin
  Result                := True;
  Lines.XMLPropertyNode := node.AddChild(Lines.XMLBranchName);
  Lines.XMLPropertyName := Lines.XMLNodeName;
  Lines.Iteraterecords(GetPropertyXMLCallback);
End;

Function TMessages.Save: Boolean;
Begin
  Result := False;
  PostDB;
  Lines.PostDB;
  If Not ValidateData Then
    exit;
  Result := Inherited Save;
End;

Procedure TMessages.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
End;

Procedure TMessages.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> fkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then
      exit; // we are only interested in data fields.
  Inherited;
  If sysutils.SameText(Sender.fieldname, 'ToId') Then Begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_ToID, self);
  End
  Else If sysutils.SameText(Sender.fieldname, 'FromID') Then Begin
  End
  Else If sysutils.SameText(Sender.fieldname, 'contacttype') Then Begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_contacttype, self);
  End
  Else If sysutils.SameText(Sender.fieldname, 'done') Then Begin
    If Done Then Begin
      DoneDateTime := now;
      Alldone;
    End;
  End
  Else If sysutils.SameText(Sender.fieldname, 'RepID') Then Begin
    RepName := TEmployeeDetails.IDToggle(Sender.AsInteger,
      Connection.Connection);
  End
  Else If sysutils.SameText(Sender.fieldname, 'RepName') Then Begin
    RepID := TEmployeeDetails.IDToggle(Sender.AsString, Connection.Connection);
  End;
End;

Function TMessages.GetSQL: String;
Begin
  Result := Inherited GetSQL;
End;

Class Function TMessages.GetIDField: String;
Begin
  Result := 'MessagesID'
End;

Function TMessages.getIsFromCustomer: Boolean;
Begin
  Result := Pos('Customer', contactType) <> 0;
End;

Function TMessages.getIsFromEmployee: Boolean;
Begin
  Result := Pos('Supplier', contactType) <> 0;
End;

Function TMessages.getIsFromJob: Boolean;
Begin
  Result := Pos('Job', contactType) <> 0;
End;

Function TMessages.getIsFromMarketingContact: Boolean;
Begin
  Result := Pos('Prospect', contactType) <> 0;
End;

Function TMessages.getIsFromProspect: Boolean;
Begin
  Result := Pos('Marketing Contact', contactType) <> 0;
End;

Function TMessages.getIsFromSupplier: Boolean;
Begin
  Result := Pos('Employee', contactType) <> 0;
End;

Class Function TMessages.GetBusObjectTablename: String;
Begin
  Result := 'tblmessages';
End;

Function TMessages.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then
    exit;
End;

Function TMessages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterPost(Sender);
  If Not Result Then
    exit;
End;
Function TMessages.geTMessageLines: TMessageLines;
begin
 PostDB;
  Result := TMessageLines(getcontainercomponent(TMessageLines,
    'MessagesID = ' + inttostr(ID)));
End;

{ Property Functions }
Function TMessages.GetFromId: Integer;Begin  Result := GetIntegerField('FromId');End;
Function TMessages.GetNameId: Integer;Begin  Result := GetIntegerField('NameId');End;
Function TMessages.GetContactName: String;Begin  Result := GetStringField('Name');End;

Function TMessages.GetDone: Boolean;Begin  Result := GetBooleanField('Done');End;
Function TMessages.GetDoneDateTime: TDateTime;Begin  Result := GetDateTimeField('DoneDateTime');End;
Function TMessages.GetLastName: String;Begin  Result := GetStringField('LastName');End;
Function TMessages.GetPhone: String;Begin  Result := GetStringField('Phone');End;
Function TMessages.GetRepID: Integer;Begin  Result := GetIntegerField('RepID');End;
Function TMessages.GetRepName: String;Begin  Result := GetStringField('RepName');End;
Function TMessages.GetMobile: String;Begin  Result := GetStringField('Mobile');End;
Function TMessages.GetEmail: String;Begin  Result := GetStringField('Email');End;
Function TMessages.GetFax: String;Begin  Result := GetStringField('Fax');End;
Function TMessages.GetSource: String;Begin  Result := GetStringField('Source');End;
Function TMessages.GetCompany: String;Begin  Result := GetStringField('Company');End;
Function TMessages.GetCreateDateAndtime: TDateTime;Begin  Result := GetDateTimeField('CreateDateAndtime');End;
Function TMessages.GetcontactType: String;Begin  Result := GetStringField('contactType');End;
Function TMessages.GetContactID: Integer;Begin  Result := GetIntegerField('ContactID');End;
Function TMessages.GetDefaultContactMethod: String;Begin  Result := GetStringField('DefaultContactMethod');End;
function TMessages.getDetails: String;
begin
  fsDetails := '';
  Lines.Iteraterecords(GetDetailsCallback);
  result := fsDetails;
end;
procedure TMessages.GetDetailsCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not (Sender is TMessageLines) then exit;
  if TMessageLines(Sender).details = '' then exit;
  fsDetails := fsDetails + chr(13) +    TMessageLines(Sender).Details;
end;

Procedure TMessages.SetFromId(Const Value: Integer);Begin  SetIntegerField('FromId', Value);End;
Procedure TMessages.SetNameId(Const Value: Integer);Begin  SetIntegerField('NameId', Value);End;
Procedure TMessages.SetContactName(Const Value: String);Begin  SetStringField('Name', Value);End;
Procedure TMessages.SetDone(Const Value: Boolean);Begin  SetBooleanField('Done', Value);End;
Procedure TMessages.SetDoneDateTime(Const Value: TDateTime);Begin  SetDateTimeField('DoneDateTime', Value);End;
Procedure TMessages.SetLastName(Const Value: String);Begin  SetStringField('LastName', Value);End;
Procedure TMessages.SetPhone(Const Value: String);Begin  SetStringField('Phone', Value);End;
Procedure TMessages.SetRepID(Const Value: Integer);Begin  SetIntegerField('RepID', Value);End;
Procedure TMessages.SetRepName(Const Value: String);Begin  SetStringField('RepName', Value);End;
Procedure TMessages.SetMobile(Const Value: String);Begin  SetStringField('Mobile', Value);End;
Procedure TMessages.SetEmail(Const Value: String);Begin  SetStringField('Email', Value);End;
Procedure TMessages.SetFax(Const Value: String);Begin  SetStringField('Fax', Value);End;
Procedure TMessages.SetSource(Const Value: String);Begin  SetStringField('Source', Value);End;
Procedure TMessages.SetCompany(Const Value: String);Begin  SetStringField('Company', Value);End;
Procedure TMessages.SetCreateDateAndtime(Const Value: TDateTime);Begin  SetDateTimeField('CreateDateAndtime', Value);End;
Procedure TMessages.SetcontactType(Const Value: String);begin  SetStringField('contactType', Value);End;
Procedure TMessages.SetContactID(Const Value: Integer);Begin  SetIntegerField('ContactID', Value);End;
Procedure TMessages.SetDefaultContactMethod(Const Value: String);Begin  SetStringField('DefaultContactMethod', Value);End;

{ TMessageLines }

Constructor TMessageLines.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  fBusObjectTypeDescription := 'messagelines';
  fSQL                      := 'SELECT * FROM tblmessagelines';
End;

Destructor TMessageLines.Destroy;
Begin
  Inherited;
End;

Procedure TMessageLines.LoadFromXMLNode(Const node: IXMLNode);
Begin
  Inherited;
  SetPropertyFromNode(node, 'MessagesID');
  SetPropertyFromNode(node, 'EmployeeId');
  SetPropertyFromNode(node, 'EnteredBy');
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'Enteredbyname');
  SetPropertyFromNode(node, 'Details');
  SetPropertyFromNode(node, 'CallPriority');
  SetPropertyFromNode(node, 'DeptId');
  SetPropertyFromNode(node, 'TypeID');
  SetPropertyFromNode(node, 'DeptName');
  SetPropertyFromNode(node, 'TypeName');
  SetDateTimePropertyFromNode(node, 'ResponsedueOn');
  SetDateTimePropertyFromNode(node, 'ResponsedueTimeFrom');
  SetDateTimePropertyFromNode(node, 'ResponsedueTimeTo');
  SetDateTimePropertyFromNode(node, 'DateAndTime');
  SetBooleanPropertyFromNode(node, 'Done');
  SetPropertyFromNode(node, 'Actiontype');
  SetPropertyFromNode(node, 'MessageType');
End;

Procedure TMessageLines.SaveToXMLNode(Const node: IXMLNode);
Begin
  Inherited;
  AddXMLNode(node, 'MessagesID', MessagesID);
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'EnteredBy', EnteredBy);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'Enteredbyname', Enteredbyname);
  AddXMLNode(node, 'Details', Details);
  AddXMLNode(node, 'CallPriority', CallPriority);
  AddXMLNode(node, 'DeptId', DeptId);
  AddXMLNode(node, 'TypeID', TypeID);
  AddXMLNode(node, 'DeptName', DeptName);
  AddXMLNode(node, 'TypeName', TypeName);
  AddXMLNode(node, 'Actiontype', Actiontype);
  AddXMLNode(node, 'MessageType', MessageType);
  AddXMLNode(node, 'ResponsedueOn', ResponsedueOn);
  AddXMLNode(node, 'ResponsedueTimeFrom', ResponsedueTimeFrom);
  AddXMLNode(node, 'ResponsedueTimeTo', ResponsedueTimeTo);
  AddXMLNode(node, 'DateAndTime', DateAndTime);
  AddXMLNode(node, 'Done', Done);

End;

Procedure TMessageLines.setActiontype(Const Value: String);
Begin
  SetStringField('Actiontype', Value);
End;

Function TMessageLines.ValidateData: Boolean;
Begin
  Result := False;
  Resultstatus.Clear;
  If DateAndTime = 0 Then
    DateAndTime := now;

  If (EmployeeId = 0) And (DeptId = 0) Then Begin
    Resultstatus.AddItem(False, rssError, BOR_No_Message_To,
      'Select which person/' + appenv.Defaultclass.Classheading +
      ' message will go to.');
    exit;
  End;

  Result := True;
End;

Function TMessageLines.Save: Boolean;
Begin
  Result := False;
  If Not ValidateData Then
    exit;
  Result := Inherited Save;
End;

Procedure TMessageLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
Begin
  Inherited;
End;

Procedure TMessageLines.DoFieldOnChange(Sender: TField);
Begin
  If (Sender.FieldKind <> fkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then
      exit; // we are only interested in data fields.
  Inherited;
  If sysutils.SameText(Sender.fieldname, 'Actiontype') Then Begin
    //if Actiontype = 'R' then begin
      if ResponsedueOn = 0 then ResponsedueOn := Date;
      if ResponsedueTimeFrom =0 then ResponsedueTimeFrom := now;
      if ResponsedueTimeTo =0 then ResponsedueTimeTo := inchour(now,2);
    //end;
  End
  else If sysutils.SameText(Sender.fieldname, 'EmployeeId') then begin
    self.EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
  end
  else If sysutils.SameText(Sender.fieldname, 'EmployeeName') then begin
    self.EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end;


End;

Function TMessageLines.getActiontype: String;
Begin
  Result := GetStringField('Actiontype');
End;

Function TMessageLines.GetSQL: String;
Begin
  Result := Inherited GetSQL;
End;

function TMessageLines.GetSupportLogID: integer;
begin
  result := GetIntegerField('SupportLogID');
end;

function TMessageLines.GetTimeSinceLast: TDateTime;
begin
  result := GetDateTimeField('TimeSinceLast');
end;

Class Function TMessageLines.GetIDField: String;
Begin
  Result := 'ID'
End;

Class Function TMessageLines.GetBusObjectTablename: String;
Begin
  Result := 'tblmessagelines';
End;

Function TMessageLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
Begin
  Result := Inherited DoAfterPost(Sender);
  If Not Result Then
    exit;
  If Not(Done) Then
    If Assigned(self.Owner) Then
      If self.Owner Is TMessages Then
        If TMessages(self.Owner).Done Then Begin
          TMessages(self.Owner).Done := False;
          TMessages(self.Owner).PostDB;
        End;
End;

Function TMessageLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
var
  qry: TERPQuery;
Begin
  Result := Inherited DoAfterInsert(Sender);
  If Not Result Then
    exit;
  If Assigned(Owner) Then
    If Owner Is TMessages Then
      MessagesID := TMessages(self.Owner).ID;
  DateAndTime    := now;
  CallPriority   := 5;
  DeptId         := appenv.Defaultclass.ClassID;
  DeptName       := appenv.Defaultclass.DefaultClassName;
  TypeName       := tcDataUtils.GetSimpleTypeDefaultStr(SimpleTypes_MessageType);
  TypeID         := tcDataUtils.GetSimpleType(typename , SimpleTypes_MessageType );
  Done           := False;
  EnteredBy      :=AppEnv.Employee.EmployeeID;
  EnteredByName  :=tcDatautils.getemployeeName(AppEnv.Employee.EmployeeID);
  Actiontype     := 'R';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('select Max(DateAndTime) as DateAndTime from tblmessagelines');
    qry.SQL.Add('where MessagesID = '  + IntToStr(MessagesID));
    qry.Open;
    if qry.FieldByName('DateAndTime').AsDateTime > 0 then
      TimeSinceLast :=  now - qry.FieldByName('DateAndTime').AsDateTime;

  finally
    qry.Free;
  end;
  PostDB;
End;

{ Property Functions }
Function TMessageLines.GeTMessagesID: Integer; Begin  Result := GetIntegerField('MessagesID');End;
Function TMessageLines.getMessageType: String;Begin  Result := GetStringField('MessageType');End;
Function TMessageLines.GetEmployeeId: Integer;Begin  Result := GetIntegerField('EmployeeId');End;
Function TMessageLines.GetEnteredBy: Integer;Begin  Result := GetIntegerField('EnteredBy');End;
Function TMessageLines.GetEmployeeName: String;Begin  Result := GetStringField('EmployeeName');End;
Function TMessageLines.GetEnteredbyname: String;Begin  Result := GetStringField('Enteredbyname');End;
Function TMessageLines.GetDetails: String;Begin  Result := GetStringField('Details');End;
Function TMessageLines.GetCallPriority: Integer;Begin  Result := GetIntegerField('CallPriority');End;
function TMessageLines.GetPeriodSinceLast: string;
begin
  result := '';
  if TimeSinceLast > 0 then begin
    if TimeSinceLast >= 1 then
      result := IntToStr(Trunc(TimeSinceLast)) + ' ';
    result := result + FormatDateTime('hh:nn:ss',TimeSinceLast);
  end;
end;

Function TMessageLines.GetResponsedueOn: TDateTime;Begin  Result := GetDateTimeField('ResponsedueOn');End;
Function TMessageLines.GetResponsedueTimeFrom: TDateTime;Begin  Result := GetDateTimeField('ResponsedueTimeFrom');End;
Function TMessageLines.GetResponsedueTimeTo: TDateTime;Begin  Result := GetDateTimeField('ResponsedueTimeTo');End;
Function TMessageLines.GetDateAndTime: TDateTime;Begin  Result := GetDateTimeField('DateAndTime');End;
Function TMessageLines.getDeptId: Integer;Begin  Result := GetIntegerField('DeptId');End;
Function TMessageLines.getTypeID: Integer;Begin  Result := GetIntegerField('TypeID');End;
Function TMessageLines.getDeptName: String;Begin  Result := GetStringField('DeptName');End;
Function TMessageLines.getTypeName: String;Begin  Result := GetStringField('TypeName');End;
Function TMessageLines.GetDone: Boolean;Begin  Result := GetBooleanField('Done');End;
Procedure TMessageLines.SeTMessagesID(Const Value: Integer);Begin  SetIntegerField('MessagesID', Value);End;
Procedure TMessageLines.setMessageType(Const Value: String);Begin  SetStringField('MessageType', Value);End;
Procedure TMessageLines.SetEmployeeId(Const Value: Integer);Begin  SetIntegerField('EmployeeId', Value);End;
Procedure TMessageLines.SetEnteredBy(Const Value: Integer);Begin  SetIntegerField('EnteredBy', Value);End;
Procedure TMessageLines.SetEmployeeName(Const Value: String);Begin  SetStringField('EmployeeName', Value);End;
Procedure TMessageLines.SetEnteredbyname(Const Value: String);Begin  SetStringField('Enteredbyname', Value);End;
Procedure TMessageLines.SetDetails(Const Value: String);Begin  SetStringField('Details', Value);End;
Procedure TMessageLines.SetCallPriority(Const Value: Integer);Begin  SetIntegerField('CallPriority', Value);End;
Procedure TMessageLines.SetResponsedueOn(Const Value: TDateTime);Begin  SetDateTimeField('ResponsedueOn', Value);End;
Procedure TMessageLines.SetResponsedueTimeFrom(Const Value: TDateTime);Begin  SetDateTimeField('ResponsedueTimeFrom', Value);End;
Procedure TMessageLines.SetResponsedueTimeTo(Const Value: TDateTime);Begin  SetDateTimeField('ResponsedueTimeTo', Value);End;
procedure TMessageLines.SetSupportLogID(const Value: integer);
begin
  SetIntegerField('SupportLogID',Value);
end;

procedure TMessageLines.SetTimeSinceLast(const Value: TDateTime);
begin
  SetDateTimeField('TimeSinceLast', Value);
end;

Procedure TMessageLines.SetDateAndTime(Const Value: TDateTime);Begin  SetDateTimeField('DateAndTime', Value);End;
Procedure TMessageLines.setDeptId(Const Value: Integer);Begin  SetIntegerField('DeptId', Value);End;
Procedure TMessageLines.setTypeID(Const Value: Integer);Begin  SetIntegerField('TypeID', Value);End;
Procedure TMessageLines.setDeptName(Const Value: String);Begin  SetStringField('DeptName', Value);End;
Procedure TMessageLines.setTypeName(Const Value: String);Begin  SetStringField('TypeName', Value);End;
Procedure TMessageLines.SetDone(Const Value: Boolean);Begin  SetBooleanField('Done', Value);End;

Initialization

RegisterClass(TMessageLines);
RegisterClass(TMessages);

End.
