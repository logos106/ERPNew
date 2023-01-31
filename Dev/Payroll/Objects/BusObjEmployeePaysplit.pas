unit BusObjEmployeePaysplit;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/06/07   1.00.01   A.   Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TPaySplit = class(TMSBusObj)
  private
    fRemainder1Found: Boolean;
    fRemainder2Found: Boolean;
    fPercentageTotal: double;
    Function GetEmployeeid: Integer;
    Function GetSplit: String;
    Function GetBankid: Integer;
    Function GetBranch: String;
    Function GetBsb: String;
    Function GetAccountno: String;
    Function GetAmount: double;
    Function GetType: String;
    Function GetAccountname: String;
    Procedure SetEmployeeid(Const Value: Integer);
    Procedure SetSplit(Const Value: String);
    Procedure SetBankid(Const Value: Integer);
    Procedure SetBranch(Const Value: String);
    Procedure SetBsb(Const Value: String);
    Procedure SetAccountno(Const Value: String);
    Procedure SetAmount(Const Value: double);
    Procedure SetType(Const Value: String);
    Procedure SetAccountname(Const Value: String);
    Procedure CallBackCheckRemainder(const Sender: TBusObj; var Abort: Boolean);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function GetBankCode: string;
    procedure SetBankCode(const Value: string);
  Protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    procedure DoFieldOnChange(Sender: TField); Override;
    Function GetSQL: STring; Override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; Override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
  Public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    Procedure LoadFromXMLNode(Const node: IXMLNode); override;
    Procedure SaveToXMLNode(Const node: IXMLNode); override;
    Function ValidateData: Boolean; Override;
    Function Save: Boolean; Override;
    Function ValidateSplits: Boolean;

    Property EmployeeID: Integer Read GetEmployeeid Write SetEmployeeid;
    Property BankID: Integer Read GetBankid Write SetBankid;
  published
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    Property Split: String Read GetSplit Write SetSplit;
    property BankCode: string read GetBankCode write SetBankCode;
    Property Branch: String Read GetBranch Write SetBranch;
    Property Bsb: String Read GetBsb Write SetBsb;
    Property AccountNo: String Read GetAccountno Write SetAccountno;
    Property Amount: double Read GetAmount Write SetAmount;
    Property SplitType: String Read GetType Write SetType;
    Property AccountName: String Read GetAccountname Write SetAccountname;
  End;

implementation

uses
  SysUtils, Dialogs, kbmMemTable, BusObjConst, BusObjEmployeePay, CommonLib,
  BusObjEmployee, BusObjBankCode;

{ ========================================================
  TPaysplit
  ======================================================== }
constructor TPaySplit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpaysplit';
end;

destructor TPaySplit.Destroy;
begin
  inherited;
end;

procedure TPaySplit.CallBackCheckRemainder(const Sender: TBusObj; var Abort: Boolean);
begin
  if Trim(SplitType) = 'Remainder' then begin
    fRemainder2Found := fRemainder1Found;
    fRemainder1Found := true;
  end;
  if SplitType = '%' then
    fPercentageTotal := fPercentageTotal + Amount;
end;

Function TPaySplit.ValidateSplits: Boolean;
var
  memCopy: TkbmMemTable;
begin
  Result := true;
  if Self.Dataset.RecordCount > 0 then begin
    fRemainder1Found := False;
    fRemainder2Found := False;
    fPercentageTotal := 0;
    Self.IterateRecords(CallBackCheckRemainder);
    First;
  end;
  if fPercentageTotal > 100 then begin
    CommonLib.MessageDlgXP_Vista('It appears your total percentage is over 100.'#13#10#13#10 +
      'Please adjust to 100 or less before saving details.', mtWarning, [mbOK], 0);

    Result := False;
    Exit;
  end;

  if (Amount = 100) and (SplitType = '%') and (Self.Dataset.RecordCount = 1) then
    Exit;

  if (Amount = 100) and (SplitType = '%') and (Self.Dataset.RecordCount > 1) then begin
    CommonLib.MessageDlgXP_Vista('It appears you have a redundant entry.'#13#10#13#10 +
      'Please delete this entry before saving details.', mtWarning, [mbOK], 0);
    Result := False;
    Exit;
  end;

  if not fRemainder1Found then begin
    CommonLib.MessageDlgXP_Vista
      ('It appears you do not have a remainder entry within your Banking Details.'#13#10#13#10 +
      'Please add this entry before saving details.', mtWarning, [mbOK], 0);
    Result := False;
    Exit;
  end;

  if fRemainder2Found then begin
    CommonLib.MessageDlgXP_Vista
      ('It appears you have two(2) remainder entries within your Banking Details.'#13#10#13#10 +
      'Please Correct these entries before saving details.', mtWarning, [mbOK], 0);
    Result := False;
    Exit;
  end;

  /// /////////////////////////////////////////////////////////////////////////////
  // It is important that the remainder
  // goes last as when adding to EFT the remainder entry is the finalisation
  // of calculations.
  /// ////////////////////////////////////////////////////////////////////////////

  memCopy := TkbmMemTable.Create(nil);

  try
    memCopy.SortOptions := [mtcoCaseInsensitive, mtcoPartialKey, mtcoIgnoreNullKey];
    memCopy.LoadFromDataSet(Self.Dataset, [mtcpoStructure]);
    memCopy.SortFields := 'Type';
    memCopy.Sort([]);
    // Now delete the bank details in our backend.
    Self.Dataset.First;
    while not Self.Dataset.Eof do begin
      Self.Dataset.Delete;
    end;
    // Return our data and Save.
    memCopy.First;
    while not memCopy.Eof do begin
      with Self.Dataset do begin
        New;
        EmployeeID := memCopy.FieldByName('EmployeeID').AsInteger;
        Split := memCopy.FieldByName('Split').AsString;
        AccountName := memCopy.FieldByName('AccountName').AsString;
        BankID := memCopy.FieldByName('BankID').AsInteger;
        Branch := memCopy.FieldByName('Branch').AsString;
        Bsb := memCopy.FieldByName('BSB').AsString;
        AccountNo := memCopy.FieldByName('AccountNo').AsString;
        Amount := memCopy.FieldByName('Amount').AsFloat;
        SplitType := memCopy.FieldByName('Type').AsString;
        PostDb;
      end;
      memCopy.Next;
    end;
    memCopy.Close;
  finally
    if Assigned(memCopy) then
      FreeandNil(memCopy);
  end;
end;

Function TPaySplit.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TEmployeePay then
      EmployeeID := TEmployeePay(Self.Owner).EmployeeDetails.id;
  Result := inherited DoAfterInsert(Sender);
end;

procedure TPaySplit.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Employeeid');
  SetPropertyFromNode(node, 'Split');
  SetPropertyFromNode(node, 'Bankid');
  SetPropertyFromNode(node, 'Branch');
  SetPropertyFromNode(node, 'Bsb');
  SetPropertyFromNode(node, 'Accountno');
  SetPropertyFromNode(node, 'Amount');
  SetPropertyFromNode(node, 'SplitType');
  SetPropertyFromNode(node, 'Accountname');
end;

procedure TPaySplit.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Employeeid', EmployeeID);
  AddXMLNode(node, 'Split', Split);
  AddXMLNode(node, 'Bankid', BankID);
  AddXMLNode(node, 'Branch', Branch);
  AddXMLNode(node, 'Bsb', Bsb);
  AddXMLNode(node, 'Accountno', AccountNo);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'SplitType', SplitType);
  AddXMLNode(node, 'Accountname', AccountName);
end;

function TPaySplit.ValidateData: Boolean;
var
  tmpResultStatus: TResultStatusItem;
begin
  Result := False;
  Resultstatus.Clear;
  Try
    // they have a split so validate it.
    if (SplitType = 'Remainder') and (Self.Dataset.RecordCount = 1) then begin
      Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_RemainderWithOneRec,
        'To have a remainder you need another record');
      Exit;
    end;
    if EmployeeID = 0 then begin
      Resultstatus.AddItem(False, rssError, 0, 'Employeeid should not be 0');
      Exit;
    end;
    if Split = '' then begin
      Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoSplit, 'Select a Split.');
      Exit;
    end;
    if Split = 'Bank' then begin
      if AccountName = '' then begin
        Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoAccountName,
          'Enter an Account name. ');
        Exit;
      end;
      if BankID = 0 then begin
        Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoBank, 'Enter a Bank name.');
        Exit;
      end;
      if Bsb = '' then begin
        Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoBSBNumber, 'Enter a Bsb');
        Exit;
      end;
      if AccountNo = '' then begin
        Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoAccountNumber,
          'Enter an Account No');
        Exit;
      end;
    end;
    if SplitType = '' then begin
      Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoSplit, 'Select a Split Type');
      Exit;
    end;
    if SplitType <> 'Remainder' then
      if Amount = 0 then begin
        Resultstatus.AddItem(False, rssError, BOR_EmployeePay_Err_NoBankAmount,
          'if the Split Type is not "Remainder" enter an amount.');
        Exit;
      end;

    if not ValidateSplits then
      Exit;;
    Result := true;
  Finally
    If not Result then Begin
      tmpResultStatus := Resultstatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        TBusObj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),
          BusobjEventVal_FailedBankingValidateData);
    end;
  end;
end;

function TPaySplit.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := Inherited Save;
end;

procedure TPaySplit.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPaySplit.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'Amount') then begin
    If SplitType = '%' then begin
      if Amount > 100 then
        Amount := 100;
    end;
  end
  else if SysUtils.SameText(Sender.fieldName, 'Type') then begin
    If SplitType = '%' then begin
      if Amount > 100 then
        Amount := 100;
    end;
  end;
end;

Function TPaySplit.GetSQL: String;
begin
  Result := Inherited GetSQL;
end;

class function TPaySplit.GetIDField: String;
begin
  Result := 'Splitid'
end;

class function TPaySplit.GetBusObjectTablename: string;
begin
  Result := 'tblpaysplit';
end;

Function TPaySplit.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
End;

{ Property functions }
Function TPaySplit.GetEmployeeid: Integer;
begin
  Result := GetIntegerField('Employeeid');
End;

function TPaySplit.GetEmployeeName: string;
begin
  Result := TEmployee.IDToggle(EmployeeID, Connection.Connection);
end;

Function TPaySplit.GetSplit: String;
begin
  Result := GetStringField('Split');
End;

function TPaySplit.GetBankCode: string;
begin
  Result := TBankCode.IDToggle(BankID, Connection.Connection);
end;

Function TPaySplit.GetBankid: Integer;
begin
  Result := GetIntegerField('Bankid');
End;

Function TPaySplit.GetBranch: String;
begin
  Result := GetStringField('Branch');
End;

Function TPaySplit.GetBsb: String;
begin
  Result := GetStringField('Bsb');
End;

Function TPaySplit.GetAccountno: String;
begin
  Result := GetStringField('Accountno');
End;

Function TPaySplit.GetAmount: double;
begin
  Result := GetFloatField('Amount');
End;

Function TPaySplit.GetType: String;
begin
  Result := GetStringField('Type');
End;

Function TPaySplit.GetAccountname: String;
begin
  Result := GetStringField('Accountname');
End;

Procedure TPaySplit.SetEmployeeid(Const Value: Integer);
begin
  SetIntegerField('Employeeid', Value);
End;

procedure TPaySplit.SetEmployeeName(const Value: string);
begin
  EmployeeID := TEmployee.IDToggle(Value, Connection.Connection);
end;

Procedure TPaySplit.SetSplit(Const Value: String);
begin
  SetStringField('Split', Value);
End;

procedure TPaySplit.SetBankCode(const Value: string);
begin
  BankID := TBankCode.IDToggle(Value, Connection.Connection);
end;

Procedure TPaySplit.SetBankid(Const Value: Integer);
begin
  SetIntegerField('Bankid', Value);
End;

Procedure TPaySplit.SetBranch(Const Value: String);
begin
  SetStringField('Branch', Value);
End;

Procedure TPaySplit.SetBsb(Const Value: String);
begin
  SetStringField('Bsb', Value);
End;

Procedure TPaySplit.SetAccountno(Const Value: String);
begin
  SetStringField('Accountno', Value);
End;

Procedure TPaySplit.SetAmount(Const Value: double);
begin
  SetFloatField('Amount', Value);
End;

Procedure TPaySplit.SetType(Const Value: String);
begin
  SetStringField('Type', Value);
End;

Procedure TPaySplit.SetAccountname(Const Value: String);
begin
  SetStringField('Accountname', Value);
End;

initialization

RegisterClassOnce(TPaySplit);

end.
