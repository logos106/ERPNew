unit BusObjPayPaysplits;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   27/09/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes,  BusobjABA, XMLDoc, XMLIntf;


type
   Tpayssplits = class(TMSBusObj)
   private
      fRemainder1Found             :Boolean;
      fRemainder2Found             :Boolean;
      AmountLeft                   :Double;
      Function GetPayid            :Integer   ;
      Function GetType             :String    ;
      Function GetSplit            :String    ;
      Function GetBankid           :Integer   ;
      Function GetBranch           :String    ;
      Function GetBsb              :String    ;
      Function GetAccountno        :String    ;
      Function GetAmount           :Double    ;
      Function GetAccountname      :String    ;
      Function getNetPay           :Double;
      Function GetEmployeeId       :Integer;
      Function getFormatedEmployeeName :STring ;
      Function getABAObj           :TABADetailRecord;
      Procedure SetPayid            (Const Value :Integer   );
      Procedure SetType             (Const Value :String    );
      Procedure SetSplit            (Const Value :String    );
      Procedure SetBankid           (Const Value :Integer   );
      Procedure SetBranch           (Const Value :String    );
      Procedure SetBsb              (Const Value :String    );
      Procedure SetAccountno        (Const Value :String    );
      Procedure SetAmount           (Const Value :Double    );
      Procedure SetAccountname      (Const Value :String    );

      Procedure CallBackCheckRemainder(const Sender: TBusObj; var Abort: Boolean);
      Procedure AddToEFTCallBack(const Sender: TBusObj; var Abort: Boolean);
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function  GetIDField : String;                                 Override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      Function     DoAfterInsert(Sender :TDatasetBusObj ):Boolean;         Override;
      Function      ValidateSplits:boolean;
      Function      Valid4EFT:Boolean;
      Procedure     AddToEFT;
      procedure    AdjustBanking;

      Property Payid             :Integer      Read getPayid          Write SetPayid      ;
      Property SplitType         :String       Read getType           Write SetType       ;
      Property Split             :String       Read getSplit          Write SetSplit      ;
      Property Bankid            :Integer      Read getBankid         Write SetBankid     ;
      Property Branch            :String       Read getBranch         Write SetBranch     ;
      Property Bsb               :String       Read getBsb            Write SetBsb        ;
      Property Accountno         :String       Read getAccountno      Write SetAccountno  ;
      Property Amount            :Double       Read getAmount         Write SetAmount     ;
      Property Accountname       :String       Read getAccountname    Write SetAccountname;
      Property NetPay            :Double       read getNetPay;
      Property EmployeeID        :Integer      Read GetEmployeeID;
      Property FormatedEmployeeName :String    read getFormatedEmployeeName;
      Property ABAObj            :TABADetailRecord  Read getABAObj;
   End;


implementation


uses tcDataUtils, CommonLib,BusObjPaybase,BusObjConst,Dialogs,kbmMemTable,SysUtils,
  AppEnvironment, PayAccounts ;


{========================================================
         Tpayssplits
========================================================}

Function Tpayssplits.Valid4EFT:Boolean;
begin
    result := False;
    if count = 0 then begin
        REsultStatus.AddItem(False, rsswarning  , 0 , 'There was no Bank set up for this Pay.');
        exit;
    end else if not(Dataset.Locate('Split' , 'Bank' , [])) then begin
        REsultStatus.AddItem(False, rsswarning  , 0 , 'There was no Bank set up for this Pay.');
        Exit;
    end else
        try
            if BankId = 0 then Exit
            else if branch = '' then Exit
            else if BSB = '' then Exit
            else if accountno = '' then exit
            else REsult := True;
        finally
            if not result then
                REsultStatus.AddItem(False, rsswarning  , 0 , 'EFT ERROR: Employee has Invalid Bank Details.');
        end;
end;
Function Tpayssplits.ValidateSplits:boolean;
var
  memCopy: TkbmMemTable;
begin
  Result := True;
  if Self.Dataset.RecordCount > 0 then begin
    fRemainder1Found := False;
    fRemainder2Found := False;
    Self.IterateRecords(CallBackCheckRemainder);
  end;

  if (Amount = 100) and (SplitType = '%') then exit;
  if not fRemainder1Found then begin
    CommonLib.MessageDlgXP_Vista('It appears you do not have a remainder entry within your Banking Details.'#13#10#13#10 +
      'Please add this entry before saving details.', mtWarning, [mbOK], 0);
    Result := False;
    Exit;
  end;

  if fRemainder2Found then begin
    CommonLib.MessageDlgXP_Vista('It appears you have two(2) remainder entries within your Banking Details.'#13#10#13#10 +
      'Please Correct these entries before saving details.', mtWarning, [mbOK], 0);
    Result := False;
    Exit;
  end;

  ////////////////////////////////////////////////////////////////////////////////
  // It is important that the remainder
  // goes last as when adding to EFT the remainder entry is the finalisation
  // of calculations.
  ///////////////////////////////////////////////////////////////////////////////

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
          PayID         := memCopy.FieldByName('PayID').AsInteger;
          Split         := memCopy.FieldByName('Split').AsString;
          AccountName   := memCopy.FieldByName('AccountName').AsString;
          BankID        := memCopy.FieldByName('BankID').AsInteger;
          Branch        := memCopy.FieldByName('Branch').AsString;
          BSB           := memCopy.FieldByName('BSB').AsString;
          AccountNo     := memCopy.FieldByName('AccountNo').AsString;
          Amount        := memCopy.FieldByName('Amount').AsFloat;
          SplitType     := memCopy.FieldByName('Type').AsString;
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


procedure Tpayssplits.CallBackCheckRemainder(const Sender: TBusObj; var Abort: Boolean);
begin
  if Trim(SplitType) = 'Remainder' then begin
    fRemainder2Found := fRemainder1Found;
    fRemainder1Found := true;
  end;
end;

constructor Tpayssplits.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblpayssplits';
end;

Function  Tpayssplits.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then begin
                PayId := Tpaybase(Self.Owner).ID;
        end;
    Result := True;
end;

destructor Tpayssplits.Destroy;
begin
   inherited;
end;


procedure   Tpayssplits.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Payid');
  SetPropertyFromNode(Node,'Type');
  SetPropertyFromNode(Node,'Split');
  SetPropertyFromNode(Node,'Bankid');
  SetPropertyFromNode(Node,'Branch');
  SetPropertyFromNode(Node,'Bsb');
  SetPropertyFromNode(Node,'Accountno');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Accountname');
end;


procedure   Tpayssplits.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Payid' ,Payid);
  AddXMLNode(node,'Type' ,SplitType);
  AddXMLNode(node,'Split' ,Split);
  AddXMLNode(node,'Bankid' ,Bankid);
  AddXMLNode(node,'Branch' ,Branch);
  AddXMLNode(node,'Bsb' ,Bsb);
  AddXMLNode(node,'Accountno' ,Accountno);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Accountname' ,Accountname);
end;

function    Tpayssplits.ValidateData :Boolean ;
//var
//  tmpResultStatus: TResultStatusItem;
begin
   Result := False;
   Resultstatus.Clear;
   Try
     // they have a split so validate it.
     if (SplitType = 'Remainder') and (Self.Dataset.RecordCount = 1) then begin
       Resultstatus.AddItem(False , rssError , BOR_PaySplits_Err_RemainderWithOneRec,  'To have a remainder you need another record' );
       SendEvent(IntToStr(BOR_PaySplits_Err_RemainderWithOneRec),BusobjEventVal_FailedBankingValidateData);
       Exit;
     end;

     if Split = 'Bank' then begin
       if Bankid = 0 then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoBankID,  'Bank should not be Blank'  );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoBankID),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Branch = '' then begin
        AddResult(False , rssError , BOR_PaySplits_Err_NoBranch,  'Branch should not be blank'  );
        SendEvent(IntToStr(BOR_PaySplits_Err_NoBranch),BusobjEventVal_FailedBankingValidateData);
        Exit;
       end;
       if Bsb = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoBsb,  'Bsb should not be blank'  );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoBsb),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Accountname = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoAccountName,  'Account name should not be blank' );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoAccountName),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Accountno = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoAccountNo,  'Account No should not be blank' );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoAccountNo),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Split = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoSplit,  'Split should not be blank' );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoSplit),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Bsb = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoBsb,  'Bsb should not be blank'  );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoBsb),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Accountname = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoAccountName,  'Account name should not be blank' );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoAccountName),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
       if Accountno = '' then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoAccountNo,  'Account No should not be blank' );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoAccountNo),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
     end;

     if SplitType <> 'Remainder' then begin  //     Remainder can be zero
       if Amount = 0 then begin
          AddResult(False , rssError , BOR_PaySplits_Err_NoAmount,  'Amount should not be 0'  );
          SendEvent(IntToStr(BOR_PaySplits_Err_NoAmount),BusobjEventVal_FailedBankingValidateData);
          Exit;
       end;
     end;
     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedBankingValidateData);
//    end;
   end;
end;


function    Tpayssplits.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tpayssplits.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tpayssplits.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName , 'Amount') then begin
    If SplitType='%' then begin
      if Amount > 100 then Amount := 100;
    end else If SplitType='$' then begin
   //   if Amount > getNetPay then Amount := getNetPay;
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'Type') then begin
    If SplitType='%' then begin
      if Amount > 100 then Amount := 100;
    end else If SplitType='$' then begin
  //    if Amount > getNetPay then Amount := getNetPay;
    end;
  end;   
end;


Function Tpayssplits.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;

class function  Tpayssplits.GetIDField : String;
begin
   Result := 'Paysplitid'
end;
procedure Tpayssplits.AddToEFT;
var
    fsFilter :String;
begin
    AmountLeft := NetPay;
    fsFilter := Dataset.filter;
    try
        if fsFilter = '' then
            Dataset.Filter := 'split = ''Bank'''
        else Dataset.Filter := Dataset.Filter +'  and split = ''Bank''';
        Dataset.Filtered := True;
        AbaObj.deleteAll;
        IterateRecords(AddToEFTCallBack);
        REsultstatus.AddItem(False, rssWarning, 0 , 'EFT Payment Created for this Pay.');
  Finally
      dataset.filter := fsFilter;
      Dataset.Filtered := fsfilter <> '';
  end;
end;

procedure  Tpayssplits.AdjustBanking;
var
   AmountThisBank,dAmountLeft: double;
begin
  dAmountLeft := TPayBase(Self.Owner).Net;

  Self.First;
  while not Self.EOF do begin
    if SameText(SplitType,'Remainder') then begin //should always be the last record
      AmountThisBank := dAmountLeft;
    end else if SameText(SplitType , '$') then begin
      if (dAmountLeft - Amount) < 0.00      then AmountThisBank := dAmountLeft
        else AmountThisBank := Amount;
    end else if sameText(SplitType , '%') then begin
      AmountThisBank := dAmountLeft * (Amount / 100);
    end else begin
      AmountThisBank := dAmountLeft;
    end;
    Self.Amount := AmountThisBank;
    dAmountLeft := dAmountLeft - AmountThisBank;
    Self.PostDb;
    Self.Next;
  end;
end;

Procedure Tpayssplits.AddToEFTCallBack(const Sender: TBusObj; var Abort: Boolean);
var
   AmountThisBank: double;
begin
      if SameText(SplitType,'Remainder')    then begin AmountThisBank := AmountLeft;
      end else if SameText(SplitType , '$') then begin
        if (AmountLeft - Amount) < 0.00      then AmountThisBank := AmountLeft
        else AmountThisBank := Amount;
      end else if sameText(SplitType , '%') then begin AmountThisBank := AmountLeft * (Amount / 100);
      end else begin AmountThisBank := AmountLeft;
      end;
      AmountLeft                        := AmountLeft - AmountThisBank;
      abaObj.new;
      abaObj.RecordType                 := '1';
      abaObj.BSB                        := BSB;
      abaObj.CreditDebitAccountNumber   := AccountNo;
      abaObj.Indicator                  := ' ';
      abaObj.TransactionCode            := '53';
      abaObj.TransCodeDesc              := 'Pay';
      abaObj.Amount                     := AmountThisBank;
      abaObj.AccountName                := FormatedEmployeeName;
      abaObj.LodgementReferences        := 'Pay' + '  ' + IntToStr(ID);
      abaObj.LodgementReferences        := abaObj.LodgementReferences + ' ' + AppEnv.CompanyInfo.Name;
      abaObj.Apply                      := False;
      abaObj.AccountID                  := PayAccounts.BankAccountID(Self.EmployeeID);
      abaObj.TransType                  := 'Pay';
      abaObj.TransID                    := ID;
      ABAObj.NameofRemitter             := getemployeeName(Self.EmployeeID);
      abaObj.postDB;
end;

Function  Tpayssplits.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;
Function Tpayssplits.getABAObj:TABADetailRecord;
begin
       Result := TABADetailRecord(getContainerComponent(TABADetailRecord , 'TransID = ' + IntToStr(ID) + ' and TransType = ' + QuotedStr('Pay')));
end;

Function Tpayssplits.getFormatedEmployeeName:String;
begin
    REsult := '';
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then
            REsult := Tpaybase(Self.Owner).EmployeeDetails.FormatedEmployeeName;
end;

Function Tpayssplits.GetEmployeeID:Integer;
begin
    REsult := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then
            REsult := Tpaybase(Self.Owner).EmployeeID;
end;
Function Tpayssplits.getNetPay:Double;
begin
    Result := 0;
    if Assigned(Self.Owner) then
        if Self.Owner is Tpaybase then
            REsult := Tpaybase(Self.Owner).Net;
end;
{Property functions}
Function  Tpayssplits.GetPayid      :Integer   ; begin Result := GetIntegerField('Payid');End;
Function  Tpayssplits.GetType       :String    ; begin Result := GetStringField('Type');End;
Function  Tpayssplits.GetSplit      :String    ; begin Result := GetStringField('Split');End;
Function  Tpayssplits.GetBankid     :Integer   ; begin Result := GetIntegerField('Bankid');End;
Function  Tpayssplits.GetBranch     :String    ; begin Result := GetStringField('Branch');End;
Function  Tpayssplits.GetBsb        :String    ; begin Result := GetStringField('Bsb');End;
Function  Tpayssplits.GetAccountno  :String    ; begin Result := GetStringField('Accountno');End;
Function  Tpayssplits.GetAmount     :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tpayssplits.GetAccountname:String    ; begin Result := GetStringField('Accountname');End;
Procedure Tpayssplits.SetPayid      (Const Value :Integer   ); begin SetIntegerField('Payid'       , Value);End;
Procedure Tpayssplits.SetType       (Const Value :String    ); begin SetStringField('Type'        , Value);End;
Procedure Tpayssplits.SetSplit      (Const Value :String    ); begin SetStringField('Split'       , Value);End;
Procedure Tpayssplits.SetBankid     (Const Value :Integer   ); begin SetIntegerField('Bankid'      , Value);End;
Procedure Tpayssplits.SetBranch     (Const Value :String    ); begin SetStringField('Branch'      , Value);End;
Procedure Tpayssplits.SetBsb        (Const Value :String    ); begin SetStringField('Bsb'         , Value);End;
Procedure Tpayssplits.SetAccountno  (Const Value :String    ); begin SetStringField('Accountno'   , Value);End;
Procedure Tpayssplits.SetAmount     (Const Value :Double    ); begin SetFloatField('Amount'      , Value);End;
Procedure Tpayssplits.SetAccountname(Const Value :String    ); begin SetStringField('Accountname' , Value);End;

class function Tpayssplits.GetBusObjectTablename: string;
begin
  Result := 'tblpayssplits';
end;

initialization
RegisterClassOnce(Tpayssplits);


end.
