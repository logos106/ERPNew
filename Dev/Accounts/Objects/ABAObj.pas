unit ABAObj;

interface

uses
  MyAccess,ERPdbComponents,DB;

type
  TABAObj = class(TObject)
  private
    F: TextFile;
    qryTemp: TERPQuery;
    IncludeBalanceRecord,
    IncludeNetTotal,
    IncludeCreditTotal,
    IncludeDebitTotal: boolean;
    fConnection: TERPConnection;
    procedure GetAccountDetail(var BankAccountName: string; var BSB: string; var AccountNo: string; RecordID: integer);
    function BSBString(const Str: string):string;
    procedure MakeExportFile(const FileName: string);
    procedure CloseExportFile;
    procedure AddLinetoFile(const StrData: string);
    procedure GetSupplierEFTDetails(var BankAccountName, BSB, AccountNo: string; ClientID: integer);
    procedure RemoveOldEFTDetails(const TransType: string; const TransID: integer);
    procedure RemoveCompletedEFTRecord(const RecordID: integer);
    (*function FormatedEmployeeName(const EmployeeID: integer): string;*)
    procedure ShowAccountForm(iAccountID : integer);
    Procedure initcon(qry:TERPQuery);

  public
    procedure AddABADetailsRecord(const ClientID, AccountID: integer; const Amount: double;
      const TransType: string; const TransID: integer); overload;
    procedure AddABADetailsRecord(const EmployeeID:Integer;PaySplitDataSet:TDataSet; AccountID: integer; const NetAmount: double;
      const TransID: integer; const TransType: string); overload;
    function ValidEFTAccount(const AccountID: integer): boolean;
    function ValidEFTSupplier(const ClientID: integer): boolean;
    function ValidEFTEmployee(const PayID: integer): boolean;
    function HasValidEFTEmployeeAccountInfo(const PayID: integer): boolean;
    function ExportABAFile(const Filename:string;const RecordID: integer): boolean;
    Property Connection :TERPConnection read fConnection write fConnection;
  end;

implementation
  
uses
  Classes, CommonDbLib, Dialogs, SysUtils, StrUtils,Forms,CommonLib,BaseInputForm,
  FastFuncs, windows, tcConst;

{ TABAObj }

procedure TABAObj.AddLinetoFile(const StrData: string);
begin
  Writeln(F, StrData);
end;

procedure TABAObj.CloseExportFile;
begin
  try
    Flush(F);
    CloseFile(F);
  except
  end;
end;

procedure TABAObj.MakeExportFile(const FileName: string);
begin
  if FileExists(FileName) then SysUtils.DeleteFile(FileName);
  {$I-}
  AssignFile(F, FileName);
  Rewrite(F);
  IOResult;
  {$I+}
end;

function TABAObj.ExportABAFile(const Filename:string;const RecordID: integer): boolean;
var
  BankAccountName, BSB, AccountNo, TempLine: string;
  CreditTotalAmount, DebitTotalAmount: double;
  FileRecordCount: integer;

  function ValidationForblank(const Data:String ;Fldlabel:String):String;
  begin
    result := '';
    if Trim(Data) = '' then begin
      result := Fldlabel + ' should not be blank.';
    end;
  end;

  function LengthValidation(const Data:String ; dataLen:Integer;Fldlabel:String; checkifshort :Boolean =False):String;
  begin
    result:= '';
    if length(Data) <> datalen then
      result := Fldlabel + ' ' + Quotedstr(data) +' should be of [' + inttostr(Datalen) +'] char(s) but is ' + inttostr(Length(data)) +' char(s)'(*
    else if checkifshort then
      if length(Data) < datalen then result := Fldlabel + ' ' + Quotedstr(data) +' should be of [' + inttostr(Datalen) +'] char(s) but only ' + inttostr(Length(data)) +' char(s)'*);
  end;

  Function validateHeader :String;
  var
    s:String;
  begin
    result:= '';
    s:= LengthValidation(qryTemp.FieldByName('RecordType').asString             , 1 , 'Record Type'         , true)       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(qryTemp.FieldByName('Blank1').asString                 , 17, 'Filler'              , true)       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(qryTemp.FieldByName('ReelSequenceNumber').asString     , 2 , 'Reel Sequence Number', true)       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(qryTemp.FieldByName('UserBankName').asString           , 3 , '"Bank Code" in the Account Form'           , true)       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(qryTemp.FieldByName('Blank2').asString                 , 7 , 'Filler'             , True)       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('DirectEntryUserName').asString    , '"Bank Account Name" in the Account Form') ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('DirectEntryUserID').asString       , '"APCA No"  in the Account Form') ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('TransactionDescription').asString , '"Transaction Description"'      )       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(qryTemp.FieldByName('Blank3').asString                 , 39, 'Filler'              , True)       ;if s<> '' then begin  if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(FormatDateTime('DDMMYY', qryTemp.FieldByName('ProcessingDate').AsDateTime) , 6,'Processign Date' , true);if s<> '' then begin  if result <> '' then result := result + NL;       result := result + s;     end;
  end;

  Function validateDetails :String;
  var
    s:String;
  begin
    result:= '';
    s:= LengthValidation(qryTemp.FieldByName('RecordType').asString               , 1 , 'Record type'   , true);          if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(BSBString(qryTemp.FieldByName('BSB').asString)           , 7 , 'BSB'           , true);          if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('CreditDebitAccountNumber').asString ,  'Account number');          if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(FillString(qryTemp.FieldByName('CreditDebitAccountNumber').asString,9,#32,True),9,'Acount number',true); if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(qryTemp.FieldByName('TransactionCode').asString          , 2 , 'Transaction Code', true);        if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
//    s:= LengthValidation(ReplaceStr(Trim(Format('%8.2f',[qryTemp.FieldByName('Amount').asCurrency])),'.',''), 10, 'Amount', true); if s<> '' then begin if result <> '' then result := result + NL;       result := result + s;     end;
    s:= ValidationForblank(qryTemp.FieldByName('AccountName').asString              ,  'Account name'  );      if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('LodgementReferences').asString      ,  'Reference'     );      if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(BSBString(qryTemp.FieldByName('UsersBSB').asString)      , 7 , 'USer BSB'          , true);      if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('UsersAccountNumber').asString       , 'User Account number');      if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('NameofRemitter').asString           ,  'Name of Remitter'  );      if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
//    s:= ValidationForblank(qryTemp.FieldByName('AmountOfWithholdingTax').asString   ,  'Amount Withholding Tax');  if s<> '' then begin   if result <> '' then result := result + NL; result := result + s;end;
  end;
  Function Validatefooter :String;
  var
    s:String;
  begin
    result:= '';
    s:= LengthValidation(qryTemp.FieldByName('RecordType').AsString             ,1 ,'Record type'         , true); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(BSBString(BSB)                                         ,7 ,'BSB'                 , true); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(AccountNo                                              ,'Account Number'      ); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
//    s:= LengthValidation(ReplaceStr(Trim(Format('%8.2f', [CreditTotalAmount])), '.', '') , 10, 'Amount'   , true); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(BankAccountName + FillString('', 18, #32,false)        ,'Account Name'        ); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
    s:= LengthValidation(BSBString(qryTemp.FieldByName('UsersBSB').AsString)    ,7 , 'User BSB'           , true); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('UsersAccountNumber').AsString      , 'User Account Number'); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
    s:= ValidationForblank(qryTemp.FieldByName('NameofRemitter').AsString         , 'Remitter'           ); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
//    s:= ValidationForblank(qryTemp.FieldByName('AmountOfWithholdingTax').AsString  , 'withholding Tax'   ); if s<> '' then begin if result <> '' then result := result + NL; result := result + s;end;
  end;
begin
  Result := false;

  if Empty(FileName) then Exit;

  DebitTotalAmount := 0.00;
  CreditTotalAmount := 0.00;
  FileRecordCount := 0;
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    try

      //##  Header Line  ##################################################
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('SELECT DescriptiveRecordID,RecordType, Blank1, ReelSequenceNumber, UserBankName, Blank2,');
      qryTemp.Sql.Add('DirectEntryUserName, DirectEntryUserID, TransactionDescription, ProcessingDate, ProcessingIndicator,');
      qryTemp.Sql.Add('Blank3, AccountID,IncludeBalanceRecord,IncludeNetTotal,IncludeCreditTotal,IncludeDebitTotal  FROM tblabadescriptiverecord Where DescriptiveRecordID='
        + IntToStr(RecordID) + ';');
      qryTemp.Open;

      // Set Options
      IncludeBalanceRecord := qryTemp.FieldByName('IncludeBalanceRecord').AsBoolean;
      IncludeNetTotal := qryTemp.FieldByName('IncludeNetTotal').AsBoolean;
      IncludeCreditTotal := qryTemp.FieldByName('IncludeCreditTotal').AsBoolean;
      IncludeDebitTotal := qryTemp.FieldByName('IncludeDebitTotal').AsBoolean;

      //Set Permanent Fields
      qryTemp.Edit;
      qryTemp.FieldByName('RecordType').AsString := '0';
      qryTemp.FieldByName('Blank1').AsString := StringOfChar(#32, 17);
      qryTemp.FieldByName('ReelSequenceNumber').AsString := '01';
      qryTemp.FieldByName('Blank2').AsString := StringOfChar(#32, 7);
      qryTemp.FieldByName('Blank3').AsString := StringOfChar(#32, 39);
      qryTemp.FieldByName('ProcessingIndicator').AsString := ' '; //StringOfChar(#32, 1); //stringOfchar changed?
      qryTemp.Post;

      //Start Header Construction
      TempLine := qryTemp.FieldByName('RecordType').asString+  {1}
                  qryTemp.FieldByName('Blank1').asString+     {17}
                  qryTemp.FieldByName('ReelSequenceNumber').asString +{2}
                  qryTemp.FieldByName('UserBankName').asString+         {3}
                  qryTemp.FieldByName('Blank2').asString+               {7}
                  FillString(qryTemp.FieldByName('DirectEntryUserName').asString,26,#32,False) +{26}
                  FillString(qryTemp.FieldByName('DirectEntryUserID').asString,6,'0',True)+   {6}
                  FillString(qryTemp.FieldByName('TransactionDescription').asString,12,#32,False) + {12}
                  FormatDateTime('DDMMYY', qryTemp.FieldByName('ProcessingDate').AsDateTime)+  ' ' +{6}
              //    qryTemp.FieldByName('ProcessingIndicator').asString+
                  qryTemp.FieldByName('Blank3').asString;{40}

      if not (char_length(TempLine) = 120) then begin
        CommonLib.MessageDlgXP_Vista('The Selected Bank Account is Missing Data !' + NL+validateHeader, mtWarning, [mbOK], 0);
        ShowAccountForm(qryTemp.FieldByName('AccountID').AsInteger);
        Result := false;
        Exit;
      end;
      

      MakeExportFile(FileName);
      AddLinetoFile(TempLine);

      //####  Details Lines  ################################################
      qryTemp.Close;
      qryTemp.Sql.Clear;
      qryTemp.Sql.Add('SELECT DetailRecordID,DescriptiveRecordID, RecordType, BSB, CreditDebitAccountNumber, Indicator,');
      qryTemp.Sql.Add('TransactionCode, Amount, AccountName, LodgementReferences, UsersBSB, UsersAccountNumber, ');
      qryTemp.Sql.Add('NameofRemitter, AmountOfWithholdingTax, Apply, AccountID  FROM tblabadetailrecord Where Apply="T" and DescriptiveRecordID='
        + IntToStr(RecordID) + ' ORDER BY DescriptiveRecordID;');
      qryTemp.Open;
      qryTemp.First;
      while not qryTemp.Eof do begin
        //Set Permanent Fields
        qryTemp.Edit;
        qryTemp.FieldByName('RecordType').AsString := '1';
        qryTemp.FieldByName('Indicator').AsString := ' '; //StringOfChar(#32, 1);
        qryTemp.Post;
        //Start Line Construction

        TempLine := qryTemp.FieldByName('RecordType').asString+  {1}
                    BSBString(qryTemp.FieldByName('BSB').asString)+{7}
                    FillString(qryTemp.FieldByName('CreditDebitAccountNumber').asString,9,#32,True) +{9}
                    ' ' +    //qryTemp.FieldByName('Indicator').asString+ {1}
                    qryTemp.FieldByName('TransactionCode').asString+{2}
                    FillString(ReplaceStr(Trim(Format('%8.2f',[qryTemp.FieldByName('Amount').asCurrency])),'.',''),10,'0',True)+{10}
                    FillString(qryTemp.FieldByName('AccountName').asString,32,#32,False) +{32}
                    FillString(qryTemp.FieldByName('LodgementReferences').asString,18,#32,False) +{18}
                    BSBString(qryTemp.FieldByName('UsersBSB').asString)+{7}
                    FillString(qryTemp.FieldByName('UsersAccountNumber').asString,9,#32,True) +{9}
                    FillString(qryTemp.FieldByName('NameofRemitter').asString,16,#32,False) +{16}
                    FillString(qryTemp.FieldByName('AmountOfWithholdingTax').asString,8,'0',True);{8}

        CreditTotalAmount := CreditTotalAmount + qryTemp.FieldByName('Amount').AsCurrency;
        FileRecordCount := FileRecordCount + 1;


        if not (char_length(TempLine) = 120) then begin
          CommonLib.MessageDlgXP_Vista('Detail record is missing Data !' + NL+ValidateDetails, mtWarning, [mbOK], 0);
          Result := false;
          Exit;
        end;
        AddLinetoFile(TempLine);
        qryTemp.Next;
      end;

      if IncludeBalanceRecord then begin
        //####  Final Details Line  ################################################
        GetAccountDetail(BankAccountName, BSB, AccountNo, RecordID);

        TempLine := qryTemp.FieldByName('RecordType').AsString +
            BSBString(BSB) +
          FillString(AccountNo, 9,#32, true) +
          ' ' +       //Indicator
          '13' +//TransactionCode Debit
          FillString(ReplaceStr(Trim(Format('%8.2f', [CreditTotalAmount])), '.', ''), 10, '0',true) +
          FillString(Copy(BankAccountName,1,32), 32, #32, false) + FillString('', 18, #32,false) +
          BSBString(qryTemp.FieldByName('UsersBSB').AsString) +
          FillString(qryTemp.FieldByName('UsersAccountNumber').AsString, 9,#32, true) +
          FillString(qryTemp.FieldByName('NameofRemitter').AsString, 16, #32,false) +
          FillString(qryTemp.FieldByName('AmountOfWithholdingTax').AsString, 8, '0', true);

        DebitTotalAmount := DebitTotalAmount + CreditTotalAmount;
        FileRecordCount := FileRecordCount + 1;
        if not (char_length(TempLine) = 120) then begin
          CommonLib.MessageDlgXP_Vista('Detail record is missing Data !'+ NL+Validatefooter  , mtWarning, [mbOK], 0);

          Result := false;
          Exit;
        end;
        AddLinetoFile(TempLine);
      end;

      //####  File Total Line  ################################################
      TempLine := '7' +// RecordType
        '999-999' +//BSB
         StringOfChar(#32, 12);//Blank1
      //Net Total
      if IncludeNetTotal then begin
        TempLine := TempLine + FillString(ReplaceStr(Trim(Format('%8.2f', [CreditTotalAmount - DebitTotalAmount])), '.', ''),
          10, '0', true);
      end else begin
        TempLine := TempLine + FillString('', 10, '0', true);
      end;
      //Credit Total
      if IncludeCreditTotal then begin
        TempLine := TempLine + FillString(ReplaceStr(Trim(Format('%8.2f', [CreditTotalAmount])), '.', ''), 10, '0', true);
      end else begin
        TempLine := TempLine + FillString('', 10, '0', true);
      end;
      //Debit Total
      if IncludeDebitTotal then begin
        TempLine := TempLine + FillString(ReplaceStr(Trim(Format('%8.2f', [DebitTotalAmount])), '.', ''), 10, '0', true);
      end else begin
        TempLine := TempLine + FillString('', 10, '0', true);
      end;
      TempLine := TempLine + StringOfChar(#32, 24) +//Blank2
        FillString(IntToStr(FileRecordCount), 6, '0', true) +//Record Count
        StringOfChar(#32, 40);//Blank2

      if not (char_length(TempLine) = 120) then begin
        CommonLib.MessageDlgXP_Vista('Detail record Missing Data !', mtWarning, [mbOK], 0);
        Result := false;
        Exit;
      end;
      AddLinetoFile(TempLine);
      Result := true;
      RemoveCompletedEFTRecord(RecordID);
    finally
      CloseExportFile;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TABAObj.ShowAccountForm(iAccountID:integer);
var
  frmAccount: TComponent;
begin
  if FormStillOpen('TfrmChartOfAccounts') then TForm(FindExistingComponent('TfrmChartOfAccounts')).Destroy;
  frmAccount := GetComponentByClassName('TfrmChartOfAccounts');
  TBaseInputGUI(frmAccount).KeyID := iAccountID;
  with TForm(frmAccount) do begin

    Show;
    BringToFront;
  end;
end;


{account.properties}
procedure TABAObj.GetAccountDetail(var BankAccountName: string; var BSB: string; var AccountNo: string; RecordID: integer);
var
  qryTemp: TERPQuery;
  AccountID: integer;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT DescriptiveRecordID,AccountID  FROM tblabadescriptiverecord Where DescriptiveRecordID=' +
      IntToStr(RecordID) + ';');
    qryTemp.Active := true;
    AccountID := qryTemp.FieldByName('AccountID').AsInteger;
    qryTemp.Close;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT AccountID, BankAccountName, BSB,BankAccountNumber  FROM tblchartofaccounts Where AccountID=' +
      IntToStr(AccountID) + ';');
    qryTemp.Active := true;
    BankAccountName := qryTemp.FieldByName('BankAccountName').AsString;
    BSB       := qryTemp.FieldByName('BSB').AsString;
    AccountNo := qryTemp.FieldByName('BankAccountNumber').AsString;
  finally
    FreeAndNil(qryTemp);
  end;
end;
{GLAccount.ValidEFTAccount}
function TABAObj.ValidEFTAccount(const AccountID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT AccountID, BankAccountName, BSB,BankAccountNumber ');
    qryTemp.Sql.Add('FROM tblchartofaccounts Where AccountID=' + IntToStr(AccountID) + ';');
    qryTemp.Active := true;
    if qryTemp.RecordCount = 0 then Exit;
    with qryTemp do begin
      if (not Empty(qryTemp.FieldByName('BankAccountName').AsString)) and
        (not Empty(qryTemp.FieldByName('BSB').AsString)) and
        (not Empty(qryTemp.FieldByName('BankAccountNumber').AsString)) then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;
function TABAObj.ValidEFTEmployee(const PayID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT PaySplitID, BSB,AccountNo ');
    qryTemp.Sql.Add('FROM tblpayssplits Where Split="Bank" AND PayID=' + IntToStr(PayID) + ';');
    qryTemp.Active := true;
    if qryTemp.RecordCount = 0 then Exit;      
    Result := true;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TABAObj.HasValidEFTEmployeeAccountInfo(const PayID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT PaySplitID,BankID,Branch,BSB,AccountNo ');
    qryTemp.Sql.Add('FROM tblpayssplits Where Split="Bank" AND PayID=' + IntToStr(PayID) + ';');
    qryTemp.Active := true;
    if qryTemp.RecordCount = 0 then begin
      Exit;
    end else begin
      if qryTemp.FieldByName('BankID').AsInteger = 0 then begin
        Result := false;
        Exit;
      end;
      if Empty(qryTemp.FieldByName('Branch').AsString) then begin
        Result := false;
        Exit;
      end;
      if Empty(qryTemp.FieldByName('BSB').AsString) then begin
        Result := false;
        Exit;
      end;
      if Empty(qryTemp.FieldByName('AccountNo').AsString) then begin
        Result := false;
        Exit;
      end;
      Result := true;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;
procedure TABAObj.initcon(qry: TERPQuery);
begin
  if connection <> nil then
    Qry.connection := Connection
  else
    Qry.connection :=CommonDbLib.GetSharedMyDACConnection;
end;

{supplier.ValidEFTSupplier}
function TABAObj.ValidEFTSupplier(const ClientID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ClientID, BankAccountName, BankAccountBSB,BankAccountNo ');
    qryTemp.Sql.Add('FROM tblclients Where ClientID=' + IntToStr(ClientID) + ';');
    qryTemp.Active := true;
    if qryTemp.RecordCount = 0 then Exit;
    with qryTemp do begin
      if (not Empty(qryTemp.FieldByName('BankAccountName').AsString)) and
        (not Empty(qryTemp.FieldByName('BankAccountBSB').AsString)) and
        (not Empty(qryTemp.FieldByName('BankAccountNo').AsString)) then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TABAObj.AddABADetailsRecord(const ClientID, AccountID: integer; const Amount: double;
  const TransType: string; const TransID: integer);
var
  qryInsertTemp: TERPQuery;
  BankAccountName, BSB, AccountNo: string;
begin
  qryInsertTemp := TERPQuery.Create(nil);
  try
    initcon(Qrytemp);//qryInsertTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    RemoveOldEFTDetails(TransType, TransID);
    GetSupplierEFTDetails(BankAccountName, BSB, AccountNo, ClientID);
    //#### Add Details Lines  ################################################
    qryInsertTemp.Sql.Clear;
    qryInsertTemp.Sql.Add('SELECT DetailRecordID,DescriptiveRecordID, RecordType, BSB, CreditDebitAccountNumber, Indicator,');
    qryInsertTemp.Sql.Add('TransactionCode, Amount, AccountName, LodgementReferences, UsersBSB, UsersAccountNumber, ');
    qryInsertTemp.Sql.Add
    ('NameofRemitter, AmountOfWithholdingTax, Apply, AccountID,TransType,TransID,TransCodeDesc  FROM tblabadetailrecord Where DescriptiveRecordID=0;');
    qryInsertTemp.Active := true;

    //Set Fields
    qryInsertTemp.Append;
    qryInsertTemp.FieldByName('RecordType').AsString    := '1';
    qryInsertTemp.FieldByName('BSB').AsString           := BSB;
    qryInsertTemp.FieldByName('CreditDebitAccountNumber').AsString := AccountNo;
    qryInsertTemp.FieldByName('Indicator').AsString     := ' ';
    qryInsertTemp.FieldByName('TransactionCode').AsString := '50';
    qryInsertTemp.FieldByName('TransCodeDesc').AsString := 'Credit Items';
    qryInsertTemp.FieldByName('Amount').AsCurrency      := Amount;
    qryInsertTemp.FieldByName('AccountName').AsString   := BankAccountName;
    qryInsertTemp.FieldByName('LodgementReferences').AsString := TransType + '  ' + IntToStr(TransID);
    qryInsertTemp.FieldByName('LodgementReferences').AsString := qryInsertTemp.FieldByName('LodgementReferences').AsString + ' ' +
                                                                 GetCompanyName;
    qryInsertTemp.FieldByName('Apply').AsString         := 'F';
    qryInsertTemp.FieldByName('AccountID').AsInteger    := AccountID;
    qryInsertTemp.FieldByName('TransType').AsString     := TransType;
    qryInsertTemp.FieldByName('TransID').AsInteger      := TransID;
    qryInsertTemp.Post;

  finally
    FreeandNil(qryInsertTemp);
  end;
end;

procedure TABAObj.AddABADetailsRecord(const EmployeeID:Integer;PaySplitDataSet:TDataSet; AccountID: integer; const NetAmount: double;
  const TransID: integer; const TransType: string);
var
  qryInsertTemp: TERPQuery;
  //  TransType: String;
//  qryTempEmpBanks: TERPQuery;
  AmountLeft, AmountThisBank: double;
begin
  AmountLeft := NetAmount;
  //    TransType:='Pay';
//  qryTempEmpBanks := TERPQuery.Create(nil);
//  qryTempEmpBanks.Connection := CommonDbLib.GetSharedMyDACConnection;
  qryInsertTemp := TERPQuery.Create(nil);
  try
    initcon(qryInsertTemp);//qryInsertTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    RemoveOldEFTDetails(TransType, TransID);
//    qryTempEmpBanks.Sql.Clear;
//    qryTempEmpBanks.Sql.Add('SELECT SplitID,Split, BSB, AccountNo, Amount, Type ');
 //   qryTempEmpBanks.Sql.Add('FROM tblpaysplit Where EmployeeID=' + IntToStr(EmployeeID) + ' Order By SplitID;');
//    qryTempEmpBanks.Active := true;
//    qryTempEmpBanks.First;
    PaySplitDataSet.First;
    while not PaySplitDataSet.Eof do begin
      //#### Do Calcs
      if (Trim(PaySplitDataSet.FieldByName('Type').AsString) = 'Remainder') then begin
        AmountThisBank := AmountLeft;
      end else if (Trim(PaySplitDataSet.FieldByName('Type').AsString) = '$') then begin
        if (AmountLeft - PaySplitDataSet.FieldByName('Amount').AsCurrency) < 0.00 then begin
          AmountThisBank := AmountLeft;
        end else begin
          //               AmountThisBank := AmountLeft;
          AmountThisBank := PaySplitDataSet.FieldByName('Amount').AsCurrency;
        end;
      end else if (Trim(PaySplitDataSet.FieldByName('Type').AsString) = '%') then begin
        AmountThisBank := AmountLeft * (PaySplitDataSet.FieldByName('Amount').AsCurrency / 100);
      end else begin
        AmountThisBank := AmountLeft;
      end;
      AmountLeft := AmountLeft - AmountThisBank;

      //#### Add Details Lines  ################################################
      if PaySplitDataSet.FieldByName('Split').AsString = 'Bank' then begin
        qryInsertTemp.Sql.Clear;
        qryInsertTemp.Sql.Add('SELECT DetailRecordID,DescriptiveRecordID, RecordType, BSB, CreditDebitAccountNumber, Indicator,');
        qryInsertTemp.Sql.Add('TransactionCode, Amount, AccountName, LodgementReferences, UsersBSB, UsersAccountNumber, ');
        qryInsertTemp.Sql.Add(
          'NameofRemitter, AmountOfWithholdingTax, Apply, AccountID,TransType,TransID,TransCodeDesc  FROM tblabadetailrecord Where DescriptiveRecordID=0;');
        qryInsertTemp.Active := true;
        //Set Fields
        qryInsertTemp.Append;
        qryInsertTemp.FieldByName('RecordType').AsString := '1';
        qryInsertTemp.FieldByName('BSB').AsString := PaySplitDataSet.FieldByName('BSB').AsString;
        qryInsertTemp.FieldByName('CreditDebitAccountNumber').AsString := PaySplitDataSet.FieldByName('AccountNo').AsString;
        qryInsertTemp.FieldByName('Indicator').AsString := ' ';
        qryInsertTemp.FieldByName('TransactionCode').AsString := '53';
        qryInsertTemp.FieldByName('TransCodeDesc').AsString := 'Pay';
        qryInsertTemp.FieldByName('Amount').AsCurrency := AmountThisBank;
        qryInsertTemp.FieldByName('AccountName').AsString := PaySplitDataSet.fieldbyname('Accountname').asString;//FormatedEmployeeName(EmployeeID);
        qryInsertTemp.FieldByName('LodgementReferences').AsString := TransType + '  ' + IntToStr(TransID);
        qryInsertTemp.FieldByName('LodgementReferences').AsString := qryInsertTemp.FieldByName('LodgementReferences').AsString + ' ' +
                                                                     GetCompanyName;
        qryInsertTemp.FieldByName('Apply').AsString := 'F';
        qryInsertTemp.FieldByName('AccountID').AsInteger := AccountID;
        qryInsertTemp.FieldByName('TransType').AsString := TransType;
        qryInsertTemp.FieldByName('TransID').AsInteger := TransID;
        qryInsertTemp.Post;
      end;
      PaySplitDataSet.Next;
    end;
  finally
    FreeandNil(qryInsertTemp);
  end;
end;

procedure TABAObj.GetSupplierEFTDetails(var BankAccountName, BSB, AccountNo: string; ClientID: integer);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(qryTemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ClientID, BankAccountName, BankAccountBSB,BankAccountNo ');
    qryTemp.Sql.Add('FROM tblclients Where ClientID=' + IntToStr(ClientID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      BankAccountName := qryTemp.FieldByName('BankAccountName').AsString;
      BSB := qryTemp.FieldByName('BankAccountBSB').AsString;
      AccountNo := qryTemp.FieldByName('BankAccountNo').AsString;
    end else begin
      BankAccountName := '';
      BSB := '';
      AccountNo := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TABAObj.RemoveOldEFTDetails(const TransType: string; const TransID: integer);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(qryTemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DELETE FROM tblabadetailrecord WHERE TransType="' + TransType + '" ');
    qryTemp.Sql.Add('AND TransID= "' + IntToStr(TransID) + '";');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TABAObj.RemoveCompletedEFTRecord(const RecordID: integer);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    initcon(qryTemp);//qryTemp.Connection := Connection;//CommonDbLib.GetSharedMyDACConnection;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DELETE FROM tblabadetailrecord WHERE DescriptiveRecordID="' + IntToStr(RecordID) + '";');
    qryTemp.Execute;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DELETE FROM tblabadescriptiverecord WHERE DescriptiveRecordID="' + IntToStr(RecordID) + '";');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

(*function TABAObj.FormatedEmployeeName(const EmployeeID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDACConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT EmployeeID, Concat_ws(" ",Concat(LastName,"."),FirstName,MiddleName) as Name FROM tblemployees WHERE EmployeeID = ' +
      IntToStr(EmployeeID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('Name').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;*)

function TABAObj.BSBString(const Str: string): string;
Var
  F3 :String;
  L3 :String;
begin
  F3 := FastFuncs.LeftStr(Str,3);
  L3 := FastFuncs.RightStr(Str,3);
  Result := F3+'-'+L3;
end;

end.

