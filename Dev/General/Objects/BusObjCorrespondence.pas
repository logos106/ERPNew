unit BusObjCorrespondence;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdMessage, JsonObject,
  SMSMessageObj;

type

  TCorrespondence = class(TMSBusObj)
  private
    fIdMessage: TIdMessage;
    fSMS: TSMSMessage;
    Function GetContactid: Integer;
    Function GetCusid: Integer;
    Function GetSupid: Integer;
    Function GetEmployeeid: Integer;
    Function GetRef_type: String;
    Function GetReferencetxt: String;
    Function GetRef_date: TDatetime;
    Function GetOthercontactid: Integer;
    Function GetRepairID: Integer;
    Function GetHRFormID: Integer;
    Function GetLoyaltyprogram: Boolean;
    Procedure SetContactid(Const Value: Integer);
    Procedure SetCusid(Const Value: Integer);
    Procedure SetSupid(Const Value: Integer);
    Procedure SetEmployeeid(Const Value: Integer);
    Procedure SetRef_type(Const Value: String);
    Procedure SetReferencetxt(Const Value: String);
    Procedure SetRef_date(Const Value: TDatetime);
    Procedure SetOthercontactid(Const Value: Integer);
    Procedure SetRepairID(Const Value: Integer);
    Procedure SetHRFormID(Const Value: Integer);
    Procedure SetLoyaltyprogram(Const Value: Boolean);
    function GetMessageId: string;
    procedure SetMessageId(const Value: string);
    function GetIdMessage: TIdMessage;
    function GetMessageAsString: string;
    procedure SetMessageAsString(const Value: string);
    function GetMessageFrom: string;
    function GetMessageTo: string;
    procedure SetMessageFrom(const Value: string);
    procedure SetMessageTo(const Value: string);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetMarketingContactId: integer;
    procedure SetMarketingContactId(const Value: integer);
    function GetSMS: TSMSMessage;
    function GetStatus: string;
    procedure SetStatus(const Value: string);
    function GetUsedOn: string;
    procedure SetUsedOn(const Value: string);

  protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Function GetSQL: STring; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;

  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    procedure DoFieldOnChange(Sender: TField); Override;
    Procedure LoadFromXMLNode(Const node: IXMLNode); override;
    Procedure SaveToXMLNode(Const node: IXMLNode); override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    property IdMessage: TIdMessage read GetIdMessage;
    { perminently delete records prior to PurgePriorDate of types in comma list
      PurgeTypeList. Will purge all types if PurgeTypeList is empty }
    class procedure Purge(PurgePriorDate: TDate; PurgeTypeList: string);
    property SMS: TSMSMessage read GetSMS;

  published
    Property ContactId: Integer Read GetContactid Write SetContactid;
    Property CusId: Integer Read GetCusid Write SetCusid;
    Property SupId: Integer Read GetSupid Write SetSupid;
    property MarketingContactId: integer read GetMarketingContactId write SetMarketingContactId;
    Property EmployeeId: Integer Read GetEmployeeid Write SetEmployeeid;
    Property Ref_Type: String Read GetRef_type Write SetRef_type;
    Property ReferenceTxt: String Read GetReferencetxt Write SetReferencetxt;
    Property Ref_Date: TDatetime Read GetRef_date Write SetRef_date;
    Property OtherContactId: Integer Read GetOthercontactid Write SetOthercontactid;
    Property RepairID: Integer Read GetRepairID Write SetRepairID;
    Property HRFormID: Integer Read GetHRFormID Write SetHRFormID;
    Property Loyaltyprogram: Boolean Read GetLoyaltyprogram Write SetLoyaltyprogram;
    property MessageId: string read GetMessageId write SetMessageId;
    property MessageAsString: string read GetMessageAsString write SetMessageAsString;
    property MessageFrom: string read GetMessageFrom write SetMessageFrom;
    property MessageTo: string read GetMessageTo write SetMessageTo;
    property Active: boolean read GetActive write SetActive;
    property Status: string read GetStatus write SetStatus;
    property UseOn: string read GetUsedOn write SetUsedOn;

  end;

implementation

uses
  BusObjEmployeePay, CommonLib, BusObjConst, sysutils, ERPDbComponents,
  CommonDbLib, MySQLConst;

{ TCorrespondence }

Function TCorrespondence.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TEmployeePay then
      Employeeid := TEmployeePay(Self.Owner).EmployeePaySettings.Employeeid;
  Result := inherited DoAfterInsert(Sender);
end;

constructor TCorrespondence.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblreference';
end;

destructor TCorrespondence.Destroy;
begin
  fSMS.Free;
  inherited;
end;

procedure TCorrespondence.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'ContactId');
  SetPropertyFromNode(node, 'CusId');
  SetPropertyFromNode(node, 'SupId');
  SetPropertyFromNode(node, 'EmployeeId');
  SetPropertyFromNode(node, 'Ref_Type');
  SetPropertyFromNode(node, 'ReferenceTxt');
  SetDateTimePropertyFromNode(node, 'Ref_Date');
  SetPropertyFromNode(node, 'OthercontactId');
  SetPropertyFromNode(node, 'RepairID');
  SetPropertyFromNode(node, 'HRFormID');
  SetBooleanPropertyFromNode(node, 'Loyaltyprogram');
  SetPropertyFromNode(node, 'MessageId');
  SetPropertyFromNode(node, 'Status');
end;

procedure TCorrespondence.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'ContactId', ContactId);
  AddXMLNode(node, 'CusId', CusId);
  AddXMLNode(node, 'SupId', SupId);
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'Ref_Type', Ref_Type);
  AddXMLNode(node, 'ReferenceTxt', ReferenceTxt);
  AddXMLNode(node, 'Ref_Date', Ref_date);
  AddXMLNode(node, 'OthercontactId', OthercontactId);
  AddXMLNode(node, 'RepairID', RepairID);
  AddXMLNode(node, 'HRFormID', HRFormID);
  AddXMLNode(node, 'Loyaltyprogram', Loyaltyprogram);
  AddXMLNode(node, 'MessageId', MessageId);
  AddXMLNode(node, 'Status', Status);
end;

function TCorrespondence.ValidateData: Boolean;
var
  tmpResultStatus: TResultStatusItem;
begin
  Result := False;
  Resultstatus.Clear;
  Try
//    if Employeeid = 0 then begin
//      AddResult(False, rssError, 0, 'Employee ID should not be 0');
//      Exit;
//    end;
  if ACtive then begin
    if Ref_type = '' then begin
      AddResult(False, rssError, 0, 'Type should not be blank');
      Exit;
    end;
    if Referencetxt = '' then begin
      AddResult(False, rssError, 0, 'Reference should not be blank');
      Exit;
    end;
    if Ref_date = 0 then begin
      AddResult(False, rssError, 0, 'Date should not be blank');
      Exit;
    end;
  end;
    Result := true;
  Finally
    If (not Result) and Assigned(Owner) then Begin
      tmpResultStatus := Resultstatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),
          BusobjEventVal_FailedDocumentsValidateData);
    end;
  end;
end;

function TCorrespondence.Save: Boolean;
var
  stream: TStream;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := Inherited Save;
  if not result then exit;

  if Assigned(fIdMessage) then begin
    EditDb;
    stream:= Dataset.CreateBlobStream(Dataset.FieldByName('ReferenceData'),bmWrite);
    try
      fIdMessage.SaveToStream(stream);
    finally
      stream.Free;
    end;
    MessageId:= StringReplace(StringReplace(fIdMessage.MsgId,'<','',[rfReplaceAll]),'>','',[rfReplaceAll]);
    PostDb;
  end
  else if Assigned(fSMS) then begin
    EditDb;
    stream:= Dataset.CreateBlobStream(Dataset.FieldByName('ReferenceData'),bmWrite);
    try
      fSMS.SaveToStream(Stream);
    finally
      stream.Free;
    end;
    PostDb;
  end;
end;

procedure TCorrespondence.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  FreeAndNil(fSMS);
  inherited;
end;

class procedure TCorrespondence.Purge(PurgePriorDate: TDate;
  PurgeTypeList: string);
var
  cmd: TERPCommand;
  s: string;
  x: integer;
  sl: TStringList;
begin
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.SQL.Add('delete from ' + self.GetBusObjectTablename);
    cmd.SQL.Add('where Ref_Date < ' + QuotedStr(FormatDateTime(MysqlDateFormat,PurgePriorDate)));
    if PurgeTypeList <> '' then begin
      s:= '';
      sl:= TStringList.Create;
      try
        sl.CommaText := PurgeTypeList;
        for x := 0 to sl.Count -1 do begin
          if s <> '' then s := s + ',';
          s:= s + '"' + sl[x] + '"';
        end;
      finally
        sl.Free;
      end;
      cmd.SQL.Add('and Ref_type in (' + s + ')');
    end;
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

procedure TCorrespondence.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TCorrespondence.GetSMS: TSMSMessage;
var
  Stream: TStream;
begin
  if self.Ref_Type = '' then
    raise Exception.Create(ClassName + ' - Ref Type not defined.');
  result:= nil;
  if SameText(self.Ref_Type, 'SMS') then begin
    if not assigned(fSMS) then begin
      fSMS := TSMSMessage.Create;
      Stream := Dataset.CreateBlobStream(Dataset.FieldByName('ReferenceData'),bmRead);
      try
        fSMS.ReadFromStream(Stream);
      finally
        Stream.Free;
      end;

    end;
    result := fSMS;
  end;
end;

Function TCorrespondence.GetSQL: String;
begin
  Result := Inherited GetSQL;
end;

function TCorrespondence.GetStatus: string;
begin
  result := GetStringField('Status');
end;

function TCorrespondence.GetUsedOn: string;
begin
  result := GetStringField('UseOn');
end;

class function TCorrespondence.GetIDField: String;
begin
  Result := 'Refid'
end;

function TCorrespondence.GetIdMessage: TIdMessage;
var
  Stream: TStream;
begin
  if self.Ref_Type = '' then
    raise Exception.Create(ClassName + ' - Ref Type not defined.');
  if SameText(self.Ref_Type,'Email') and (MessageId <> '') then begin
    if not Assigned(fIdMessage) then
      fIdMessage := TIdMessage.Create(self);
    if Pos(MessageId,fIdMessage.MsgId) = 0  then begin
      Stream := Dataset.CreateBlobStream(Dataset.FieldByName('ReferenceData'),bmRead);
      try
        fIdMessage.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end;
  end
  else begin
    if Assigned(fIdMessage) then
      FreeAndNil(fIdMessage);
  end;
  result := fIdMessage;
end;

function TCorrespondence.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TCorrespondence.GetBusObjectTablename: string;
begin
  Result := 'tblreference';
end;

Function TCorrespondence.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
End;

{ Property functions }
Function TCorrespondence.GetContactid: Integer;
begin
  Result := GetIntegerField('Contactid');
End;

Function TCorrespondence.GetCusid: Integer;
begin
  Result := GetIntegerField('Cusid');
End;

Function TCorrespondence.GetSupid: Integer;
begin
  Result := GetIntegerField('Supid');
End;

Function TCorrespondence.GetEmployeeid: Integer;
begin
  Result := GetIntegerField('Employeeid');
End;

Function TCorrespondence.GetRef_type: String;
begin
  Result := GetStringField('Ref_type');
End;

Function TCorrespondence.GetReferencetxt: String;
begin
  Result := GetStringField('Referencetxt');
End;

Function TCorrespondence.GetRef_date: TDatetime;
begin
  Result := GetDatetimeField('Ref_date');
End;

Function TCorrespondence.GetOthercontactid: Integer;
begin
  Result := GetIntegerField('Othercontactid');
End;
Function TCorrespondence.GetRepairID: Integer;
begin
  Result := GetIntegerField('RepairID');
End;
Function TCorrespondence.GetHRFormID: Integer;
begin
  Result := GetIntegerField('HRFormID');
End;

Function TCorrespondence.GetLoyaltyprogram: Boolean;
begin
  Result := GetBooleanField('Loyaltyprogram');
End;

function TCorrespondence.GetMarketingContactId: integer;
begin
  result := GetIntegerField('MarketingContactID');
end;

function TCorrespondence.GetMessageAsString: string;
var
  StringStream: TStringStream;
  Stream: TStream;
  Reader: TStreamReader;
begin
  result := '';
  if self.Ref_Type = '' then
    raise Exception.Create(ClassName + ' - Ref Type not defined.');
  if SameText(self.Ref_Type,'Email') then begin
    if Assigned(IdMessage) then begin
      StringStream := TStringStream.Create;
      try
        IdMessage.SaveToStream(StringStream);
        StringStream.Position := 0;
        result := StringStream.DataString;
      finally
        StringStream.Free;
      end;
    end;
  end
  else begin
    Stream := Dataset.CreateBlobStream(Dataset.FieldByName('ReferenceData'),bmRead);
    Reader := TStreamReader.Create(Stream,TEncoding.UTF8);
    try
      Result := Reader.ReadToEnd
    finally
      Reader.Free;
      Stream.Free;
    end;
  end;
end;

function TCorrespondence.GetMessageFrom: string;
begin
  result := GetStringField('MessageFrom');
end;

function TCorrespondence.GetMessageId: string;
begin
  result := GetStringField('MessageId');
end;

function TCorrespondence.GetMessageTo: string;
begin
  result := GetStringField('MessageTo');
end;

procedure TCorrespondence.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

Procedure TCorrespondence.SetContactid(Const Value: Integer);
begin
  SetIntegerField('Contactid', Value);
End;

Procedure TCorrespondence.SetCusid(Const Value: Integer);
begin
  SetIntegerField('Cusid', Value);
End;

procedure TCorrespondence.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

procedure TCorrespondence.SetUsedOn(const Value: string);
begin
  SetStringField('UsdeOn', Value);
end;

Procedure TCorrespondence.SetSupid(Const Value: Integer);
begin
  SetIntegerField('Supid', Value);
End;

Procedure TCorrespondence.SetEmployeeid(Const Value: Integer);
begin
  SetIntegerField('Employeeid', Value);
End;

Procedure TCorrespondence.SetRef_type(Const Value: String);
begin
  SetStringField('Ref_type', Value);
End;

Procedure TCorrespondence.SetReferencetxt(Const Value: String);
begin
  SetStringField('Referencetxt', Value);
End;

Procedure TCorrespondence.SetRef_date(Const Value: TDatetime);
begin
  SetDatetimeField('Ref_date', Value);
End;

Procedure TCorrespondence.SetOthercontactid(Const Value: Integer);
begin
  SetIntegerField('Othercontactid', Value);
End;
Procedure TCorrespondence.SetRepairID(Const Value: Integer);
begin
  SetIntegerField('RepairID', Value);
End;
Procedure TCorrespondence.SetHRFormID(Const Value: Integer);
begin
  SetIntegerField('HRFormID', Value);
End;

Procedure TCorrespondence.SetLoyaltyprogram(Const Value: Boolean);
begin
  SetBooleanField('Loyaltyprogram', Value);
End;

procedure TCorrespondence.SetMarketingContactId(const Value: integer);
begin
  SetIntegerField('MarketingContactID', Value);
end;

procedure TCorrespondence.SetMessageAsString(const Value: string);
var
  StringStream: TStringStream;
  Stream: TStream;
  Writer: TStreamWriter;
begin
  if self.Ref_Type = '' then
    raise Exception.Create(ClassName + ' - Ref Type not defined.');
  if SameText(self.Ref_Type,'Email') then begin
    if not Assigned(IdMessage) then
      fIdMessage:= TIdMessage.Create(self);
    StringStream := TStringStream.Create;
    try
      StringStream.WriteString(Value);
      StringStream.Position := 0;
      fIdMessage.LoadFromStream(StringStream);
      MessageId:= StringReplace(StringReplace(fIdMessage.MsgId,'<','',[rfReplaceAll]),'>','',[rfReplaceAll]);
    finally
      StringStream.Free;
    end;
  end
  else begin
    if Length(Value) > 0 then begin
      Stream := Dataset.CreateBlobStream(Dataset.FieldByName('ReferenceData'),bmReadWrite);
      Writer := TStreamWriter.Create(Stream,TEncoding.UTF8);
      try
        Writer.Write(Value);
      finally
        Writer.Free;
        Stream.Free;
      end;
    end
    else
      Dataset.FieldByName('ReferenceData').Clear;
  end;
end;

procedure TCorrespondence.SetMessageFrom(const Value: string);
begin
  SetStringField('MessageFrom', Value);
end;

procedure TCorrespondence.SetMessageId(const Value: string);
begin
  SetStringField('MessageId', Value);
end;

procedure TCorrespondence.SetMessageTo(const Value: string);
begin
  SetStringField('MessageTo', Value);
end;

{ TSMSMessage }


initialization

  RegisterClassOnce(TCorrespondence);

end.
