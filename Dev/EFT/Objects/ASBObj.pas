unit ASBObj;

interface

uses  EFTObj, ERPdbComponents, ATODataObj;

type

  TASBJsonRec = class(JsonATORec)
    Public
      constructor Create;Override;
  end;

  TASBMT9HeaderRec = class(TASBJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TASBMT9DetailRec = class(TASBJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TASBMT9TrailerRec = class(TASBJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TASBAFIHeaderRec = class(TASBJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TASBAFIDetailRec = class(TASBJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TASBAFITrailerRec = class(TASBJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;



 TASBObj =  class(TEFTObj)
    Private
      CheckTotal :Double;
      totalAmount:double;
      reccount:Integer;
      Function ValidateStrData(const Value:String):String;

      Function AddMT9HeaderRec:String;
      Function AddMT9DetailRec:String;
      function AddMT9TrailerRec: String;

      Function AddAFIHeaderRec:String;
      Function AddAFIDetailRec:String;
      function AddAFITrailerRec: String;


      function AccountBanknumber(const bsb: String): Integer;
      function AccountBranchnumber(const bsb: String): Integer;
      function Accountnumber(const AcNo: String): Integer;
      function Accountnumbersuffix(const AcNo: String): String;
      Function isPayrollTrans:Boolean;
    Protected
    Public
      constructor Create;
      Destructor Destroy;Override;
      function ValidateData:Boolean;Override;
      function DoExportCSV(Const Filename:String = '') :String;
      function DoExportMT9(Const Filename:String = '') :String;
      Function DoExportAFI(Const Filename:String = '') :String;
  end;
implementation

uses CommonLib, sysutils,classes, CommonDbLib, AppEnvironment, myaccess, AppEnvironmentVirtual;

{ TASBObj }
function TASBObj.AccountBanknumber(Const bsb:String)    :Integer;begin  result:= strtoInt(copy(bsb+'00' , 1,2))       ;end;
function TASBObj.AccountBranchnumber(Const bsb:String)  :Integer;begin  result:= strtoInt(copy(bsb+'000000' , 3,4))   ;end;
function TASBObj.Accountnumber(Const AcNo:String)       :Integer;begin  result:= strtoInt(copy(Acno+'0000000' , 1,7)) ;end;
function TASBObj.Accountnumbersuffix(Const AcNo:String) :String ;begin  result:= copy(acNo+'         ' , 8,2)+' '     ;end;

function TASBObj.AddMT9HeaderRec: String;
var
  fHeaderRec : TASBMT9HeaderRec;
begin
  fHeaderRec := TASBMT9HeaderRec.create;
  TRy
      {01..02}fHeaderRec.O['FileType'].I['Value']         := 12;
      {03..04}fHeaderRec.O['BankNumber'].I['Value']       := AccountBanknumber(GLAccount.BSB);
      {05..08}fHeaderRec.O['BranchNumber'].I['Value']     := AccountBranchnumber(GLAccount.BSB);
      {09..15}fHeaderRec.O['UniqueCustomerNo'].I['Value'] := Accountnumber(GLAccount.BankAccountNumber);
      {16..18}fHeaderRec.O['Suffix'].S['Value']           := Accountnumbersuffix(GLAccount.BankAccountNumber);
      {19..31}fHeaderRec.O['DueDate'].S['Value']          := formatdateTime('DDMMYYYY' , Date)+'     ';
      {32..51}fHeaderRec.O['ClientName'].S['Value']       := copy(Appenv.CompanyInfo.CompanyName+ replicateStr(' ', 20) , 1, 20);
      {52..160}fHeaderRec.O['Filler'].S['Value']          := Replicatestr(' ' , 109);
    Result:= fHeaderRec.RecordString;
  Finally
    FreeandNil(fHeaderRec);
  End;
end;
function TASBObj.AddAFIDetailRec: String;
var
  frec: TASBAFIDetailRec;
begin
  fRec:= TASBAFIDetailRec.Create;
  try
      fRec.O['Recordtype'].I['Value'] := 2;
      fRec.O['ToAccountnumber'].S['Value'] :=QryData.FieldByName('bsb').asString +  QryData.FieldByName('CreditDebitAccountNumber').asString;
      if isPayrollTrans then fRec.O['TransactionCode'].I['Value']:= 52 else fRec.O['TransactionCode'].I['Value'] := 50;
      fRec.O['TransactionAmt'].S['Value']   := FormatAmount(QryData.FieldByName('Amount').AsFloat,10,2);
      fRec.O['ToName'].S['Value']           := copy(ValidateStrData(QryData.fieldbyname('Accountname').AsString) + replicatestr(' ' , 20) ,1,20);
      fRec.O['ToReference'].S['Value']      := copy(ValidateStrData(QryData.fieldbyname('LodgementReferences').AsString) + replicatestr(' ' , 12) ,1,12);
      fRec.O['ToCode'].S['Value']           := '';
      fRec.O['ToAlphaRef'].S['Value']       := '';
      fRec.O['ToParticulars'].S['Value']    := '';
      fRec.O['Fromname'].S['Value']         := copy(ValidateStrData(Appenv.CompanyInfo.CompanyName)+ replicateStr(' ', 20) , 1, 20);
      fRec.O['FromCode'].S['Value']         := '';
      fRec.O['FromREference'].S['Value']    := '';
      fRec.O['FromParticulatrs'].S['Value'] := ' ';
      Result:= fRec.CSVRecordString;
      totalAmount := totalAmount + QryData.FieldByName('Amount').AsFloat;
      CheckTotal := CheckTotal +  strToFloat(copy(trim(QryData.FieldByName('bsb').asString +  QryData.FieldByName('CreditDebitAccountNumber').asString)+'0000000000000',3,11));
      reccount:= reccount+1;
  finally
    Freeandnil(fRec);
  end;
end;

function TASBObj.AddAFIHeaderRec: String;
var
  fHeaderRec :TASBAFIHeaderRec;
begin
  fHeaderRec := TASBAFIHeaderRec.Create;
  try
      fHeaderRec.O['Recordtype'].I['Value'] := 1;
      fHeaderRec.O['Spare1'].S['Value'] := '';
      fHeaderRec.O['Spare2'].S['Value'] := '1';
      fHeaderRec.O['Spare3'].S['Value'] := '0';
      fHeaderRec.O['FromAccountnumber'].S['Value'] := GLAccount.bsb +  GLAccount.BankAccountNumber;
      fHeaderRec.O['Filetype'].I['Value'] := 7;
      fHeaderRec.O['dueDate'].S['Value'] := formatdateTime('YYMMDD' , QryHeader.fieldByname('ProcessingDate').asDateTime);
      fHeaderRec.O['CreationDate'].S['Value'] := formatdateTime('YYMMDD' , Date);
      fHeaderRec.O['Indicator'].S['Value'] := '';
      Result:= fHeaderRec.CSVRecordString;
      reccount:=0;
      CheckTotal:=0;
  finally
    Freeandnil(fHeaderRec);
  end;
end;

function TASBObj.AddAFITrailerRec: String;
var
  frec : TASBAFITrailerRec;
begin
  fRec := TASBAFITrailerRec.create;
  try
        fRec.O['Recordtype'].I['Value']  := 3;
        fRec.O['Totalamount'].S['Value'] := FormatAmount(totalAmount, 10,2);
        fRec.O['Recordcount'].I['Value'] := reccount;
        fRec.O['Hashtotal'].S['Value']   := FormatAmount(CheckTotal, 1,0);
        Result:= fRec.CSVRecordString;
  finally
    Freeandnil(fRec);
  end;
end;

function TASBObj.AddMT9DetailRec: String;
var
  fDetailREc : TASBMT9DetailRec;
begin
  fDetailREc := TASBMT9DetailRec.create;
  TRy
    {001..002}fDetailREc.O['RecordType'].I['Value']       :=13;
    {003..004}fDetailREc.O['BankNumber'].I['Value']       := AccountBanknumber(QryData.FieldByName('bsb').asString); ;
    {005..008}fDetailREc.O['BranchNumber'].I['Value']     := AccountBranchnumber(QryData.FieldByName('bsb').asString);
    {009..015}fDetailREc.O['UniqueCustomerNo'].I['Value'] := Accountnumber(QryData.FieldByName('CreditDebitAccountNumber').asString);
    {016..018}fDetailREc.O['Suffix'].S['Value']           := Accountnumbersuffix(QryData.FieldByName('CreditDebitAccountNumber').asString);
    {019..021}fDetailREc.O['TransactionCode'].I['Value']  := RegionTransactionCode(QryData.FieldByName('TransactionCode').AsInteger) ;
    {022..031}fDetailREc.O['Amount'].S['Value']           := FormatAmount(QryData.FieldByName('Amount').AsFloat,10,2);
    {032..051}fDetailREc.O['PayeeName'].S['Value']        := copy(ValidateStrData(QryData.fieldbyname('Accountname').AsString) + replicatestr(' ' , 20) ,1,20);
    {052..063}fDetailREc.O['InternalRef'].S['Value']      := copy(ValidateStrData(QryData.fieldbyname('LodgementReferences').AsString) + replicatestr(' ' , 12) ,1,12);
    {064..075}fDetailREc.O['PayeeCode'].S['Value']        :='            ';
    {076..087}fDetailREc.O['PayeeRef'].S['Value']         := copy(ValidateStrData(Appenv.CompanyInfo.CompanyName)+ replicateStr(' ', 12) , 1, 12);
    {088..099}fDetailREc.O['PayeeParticulars'].S['Value'] :='            ';
    {100..100}fDetailREc.O['Filler1'].S['Value']          :=' ';
    {101..120}fDetailREc.O['PayerName'].S['Value']        := copy(ValidateStrData(Appenv.CompanyInfo.CompanyName)+ replicateStr(' ', 20) , 1, 20);
    {121..132}fDetailREc.O['PayerCode'].S['Value'] :='            ';
    {133..144}fDetailREc.O['PayerReference'].S['Value'] :='            ';
    {145..156}fDetailREc.O['PayerParticulars'].S['Value'] :='            ';
    {157..160}fDetailREc.O['Filler2'].S['Value'] :='    ';
    CheckTotal := CheckTotal + AccountBranchnumber(QryData.FieldByName('bsb').asString) +  Accountnumber(QryData.FieldByName('CreditDebitAccountNumber').asString);
    totalAmount := totalAmount + QryData.FieldByName('Amount').AsFloat;
    Result:= fDetailREc.RecordString;
  Finally
    Freeandnil(fDetailRec);
  End;
end;
function TASBObj.AddMT9TrailerRec: String;
var
  fTrailerRec :TASBMT9TrailerRec;
begin
  fTrailerRec:= TASBMT9TrailerRec.Create;
  try
    {01..002}fTrailerREc.O['RecordType'].I['Value'] := 13;
    {03..004}fTrailerREc.O['KeyField'].I['Value'] := 99;
    {05..015}fTrailerREc.O['CheckTotal'].S['Value'] := '00000000000' ; //formatNumber(trunc(CheckTotal), 11 ,False, ' ' , False);
    {16..021}fTrailerREc.O['Filler'].S['Value'] := '      ';
    {22..031}fTrailerREc.O['Totalamount'].S['Value'] := FormatAmount(totalAmount, 10,2);
    {32..160}fTrailerREc.O['Filler'].S['Value'] := replicateStr('  ' , 129);
    REsult:= fTrailerRec.RecordString;
  finally
    Freeandnil(fTrailerRec);
  end;

end;

constructor TASBObj.Create;
begin

end;

destructor TASBObj.Destroy;
begin

  inherited;
end;

function TASBObj.DoExportCSV(const Filename: String): String;
var
  st: TStringlist;
  s:string;
  function BankNumber(ACNo:String; BSBNo:String):String;
  begin

    BSBNo:= GLAccount.bsb;
    While length(BSBNo)<6 do BSBNo := '0' + BSBNo;
    if length(BSBNo)>6 then BSBNo := copy(BSBNo ,1, 6);

    ACNo := GLAccount.Accountnumber;
    While length(ACNo)<9 do ACNo := '0' + ACNo;
    if length(Acno)>13 then ACNo := copy(ACNo ,1, 13);

    Result:= BSBNo + ACNo;
  end;
  function TruncateStr(Const Value:String;stLength:Integer; Addblanks:Boolean =False ):String;
  begin
    if length( Value) >  stLength then result := copy(Value , 1, stLength)
    else if Addblanks then Result := copy(Value +replicatestr(' ' , stLength) ,1, StLength)
    else result := Value;
  end;
  function PayeeDesc:String;
  begin
    With TempMyQuery(TERPConnection(Qrydata.connection)) do try
      SQL.add('Select count(*) ctr from tblabadetailrecord where Apply ="T" and Accountname =' + quotedstr(Qrydata.fieldbyname('Accountname').asString));
      open;
      if fieldByname('ctr').asInteger >1 then
           Result := 'COMBINED #' +Qrydata.fieldbyname('Accountname').asString
      else result := Qrydata.fieldbyname('Accountname').asString;
    finally
      ClosenFree;
    end;
  end;
begin
  inherited  DoExport(Filename);
  st:= TStringlist.create;
  try
      if (Qrydata = nil) or (Qrydata.Active= False) or (QryData.RecordCount =0 ) or (Qrydata.FindField('Apply') = nil) then else begin
        QryData.First;
        While QryData.Eof = False do begin
          if (Qrydata.FieldByname('apply').AsBoolean) and (Qrydata.FieldByname('Amount').asFloat > 0) then begin
              {PaymentName}      S:= TruncateStr(ValidateStrData(QryHeader.fieldByname('TransactionDescription').asString) , 20) +',' ;
              {Date}             if QryHeader.fieldByname('ProcessingDate').asDateTime =0 then
                                    S:= S+ Formatdatetime('DD/MM/YYYY' , Date) +','
                                 else
                                    S:= S+ Formatdatetime('DD/MM/YYYY' , QryHeader.fieldByname('ProcessingDate').asDateTime) +',' ;
              {Deduction Account}S:= S+ BankNumber(GLAccount.BSB , GLAccount.Accountnumber) +',';
              {amount}           S:= S+ FormatAmount(Qrydata.FieldByname('Amount').asFloat , 0 , Appenv.RegionalOptions.CurrencyRoundPlaces , 0  ) +',';
              {Payee Particulars}S:= S+  ValidateStrData(PayeeDesc) +',' ;
              {Payee Code}       S:= S+  ValidateStrData(Qrydata.fieldByname('TransType').asString) +',' ;
              {Payee Reference}  S:= S+  ValidateStrData(inttostr(Qrydata.fieldByname('TransId').asInteger)) +',' ;
              {Dest Account}     S:= S+ BankNumber(QryData.FieldByname('BSB').asString  , QryData.FieldByname('CreditDebitAccountNumber').asString) +',';
              {Payer Particulars}S:= S+  ValidateStrData(Appenv.companyInfo.Companyname) +',' ;
              {Payer Code}       S:= S+  '' +',' ;
              {Payer Reference}  S:= S+ '' +',';
              {Payee Name}       S:= S+  TruncateStr(ValidateStrData(Qrydata.fieldbyname('NameofRemitter').asString), 32)  ;
              St.add(s);
          end;
          QryData.Next;
        end;
      if exportfilename <> '' then
        St.SaveToFile(ExportfileName);
      if not devmode then
        RemoveCompletedEFTRecord(Qrydata.fieldbyname('DescriptiveRecordID').asInteger);
      end;
  finally
    Freeandnil(st);
  end;

end;
Function TASBObj.DoExportAFI(Const Filename:String = '') :String;
var
  st: TStringlist;
begin
  inherited  DoExport(Filename);
  st:= TStringlist.Create;
  try
    if (Qrydata = nil) or (Qrydata.Active= False) or (QryData.RecordCount =0 ) or (Qrydata.FindField('Apply') = nil) then else begin
      QryData.First;
      St.add(AddAFIHeaderRec);
      CheckTotal:=0;
      totalAmount:= 0;
      While QryData.Eof = False do begin
            if Qrydata.FieldByname('apply').AsBoolean then begin
              St.add(AddAFIDetailRec);
            end;
        QryData.Next;
      end;
      St.add(AddAFITrailerRec);
      if exportfilename <> '' then
          St.SaveToFile(ExportfileName);
      if not devmode then
          RemoveCompletedEFTRecord(Qrydata.fieldbyname('DescriptiveRecordID').asInteger);
    end;
  finally
    Freeandnil(st);
  end;

end;
function TASBObj.DoExportMT9(const Filename: String): String;
var
  st: TStringlist;
begin
  inherited  DoExport(Filename);
  st:= TStringlist.Create;
  try
    if (Qrydata = nil) or (Qrydata.Active= False) or (QryData.RecordCount =0 ) or (Qrydata.FindField('Apply') = nil) then else begin
      QryData.First;
      St.add(AddMT9HeaderRec);
      CheckTotal:=0;
      totalAmount:= 0;
      While QryData.Eof = False do begin
            if Qrydata.FieldByname('apply').AsBoolean then begin
              St.add(AddMT9DetailRec);
            end;
        QryData.Next;
      end;
      St.add(AddMT9TrailerRec);
      if exportfilename <> '' then
          St.SaveToFile(ExportfileName);
      if not devmode then
          RemoveCompletedEFTRecord(Qrydata.fieldbyname('DescriptiveRecordID').asInteger);
    end;
  finally
    Freeandnil(st);
  end;
end;

function TASBObj.isPayrollTrans: Boolean;
begin
  REsult:= Sametext(QryHeader.fieldByname('TransactionDescription').asString , 'Payroll');
end;

function TASBObj.ValidateData: Boolean;
begin
  REsult:= true;
end;

function  TASBObj.ValidateStrData(const Value: String):String;
var
  x:Integer;
  s:String;
Const
  ValidChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()*+-=?[]_{}~/& '',.';
begin
  Result:= '';
  for x := 1 to length(value) do begin
    s:= upperCase(copy(value,x,1));
    if Pos(s , ValidChars)>0 then
      Result := Result + copy(value,x,1);
  end;
end;

{ TACHJsonRec }

constructor TASBJsonRec.Create;
begin
  inherited;
end;

{ TASBMT9HeaderRec }

procedure TASBMT9HeaderRec.PopulateFieldDefs;
begin
  inherited;
  AddField('FileType'           ,2 ,ffN ,ftM);
  AddField('BankNumber'         ,2 ,ffN ,ftM);
  AddField('BranchNumber'       ,4 ,ffN ,ftM);
  AddField('UniqueCustomerNo'   ,7 ,ffN ,ftM);
  AddField('Suffix'             ,3 ,ffAN ,ftM);
  AddField('DueDate'            ,13,ffAN ,ftM);
  AddField('ClientName'         ,20,ffAN ,ftM);
  AddField('Filler'             ,109,ffAN,ftM);
end;

{ TASBMT9DetailRec }

procedure TASBMT9DetailRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordType'         ,2 ,ffN ,ftM);
  AddField('BankNumber'         ,2 ,ffN ,ftM);
  AddField('BranchNumber'       ,4 ,ffN ,ftM);
  AddField('UniqueCustomerNo'   ,7 ,ffN ,ftM);
  AddField('Suffix'             ,3 ,ffAN ,ftM);
  AddField('TransactionCode'    ,3 ,ffN  ,ftM);
  AddField('Amount'             ,10,ffAN ,ftM);
  AddField('PayeeName'          ,20,ffAN,ftM);
  AddField('InternalRef'        ,12,ffAN,ftM);
  AddField('PayeeCode'          ,12,ffAN,ftM);
  AddField('PayeeRef'           ,12,ffAN,ftM);
  AddField('PayeeParticulars'   ,12,ffAN,ftM);
  AddField('Filler1'             ,1 ,ffAN,ftM);
  AddField('PayerName'          ,20,ffAN,ftM);
  AddField('PayerCode'          ,12,ffAN,ftM);
  AddField('PayerReference'     ,12,ffAN,ftM);
  AddField('PayerParticulars'   ,12,ffAN,ftM);
  AddField('Filler2'            ,4 ,ffAN,ftM);
end;

{ TASBMT9TrailerRec }

procedure TASBMT9TrailerRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordType'         ,2 ,ffN ,ftM);
  AddField('KeyField'           ,2 ,ffN ,ftM);
  AddField('CheckTotal'         ,11,ffAN,ftM);
  AddField('Filler'             ,6 ,ffAN ,ftM);
  AddField('Totalamount'        ,10,ffAN ,ftM);
  AddField('Filler'             ,129 ,ffAN ,ftM);
end;

{ TASBAFIHeaderRec }

procedure TASBAFIHeaderRec.PopulateFieldDefs;
begin
  inherited;
  AddField('Recordtype'       ,1  ,ffN  ,ftM);
  AddField('Spare1'           ,7  ,ffAN  ,ftM);
  AddField('Spare2'           ,2  ,ffAN  ,ftM);
  AddField('Spare3'           ,4  ,ffAN  ,ftM);
  AddField('FromAccountnumber',16 ,ffAN ,ftM);
  AddField('Filetype'         ,1  ,ffN  ,ftM);
  AddField('dueDate'          ,6  ,ffAN ,ftM);
  AddField('CreationDate'     ,6  ,ffAN ,ftM);
  AddField('Indicator'        ,1  ,ffAN ,ftM);
end;

{ TASBAFIDetailRec }

procedure TASBAFIDetailRec.PopulateFieldDefs;
begin
  inherited;
  AddField('Recordtype'       ,1  ,ffN  ,ftM);
  AddField('ToAccountnumber'  ,16 ,ffAN ,ftM);
  AddField('TransactionCode'  ,2  ,ffN  ,ftM);
  AddField('TransactionAmt'   ,12 ,ffAN ,ftM);
  AddField('ToName'           ,20 ,ffAN ,ftM);
  AddField('ToReference'      ,12 ,ffAN ,ftM);
  AddField('ToCode'           ,12 ,ffAN ,ftM);
  AddField('ToAlphaRef'       ,12 ,ffAN ,ftM);
  AddField('ToParticulars'    ,12 ,ffAN ,ftM);
  AddField('Fromname'         ,20 ,ffAN ,ftM);
  AddField('FromCode'         ,12 ,ffAN ,ftM);
  AddField('FromREference'    ,12 ,ffAN ,ftM);
  AddField('FromParticulatrs' ,12 ,ffAN ,ftM);
end;

{ TASBAFITrailerRec }

procedure TASBAFITrailerRec.PopulateFieldDefs;
begin
  inherited;
  AddField('Recordtype'         ,1  ,ffN  ,ftM);
  AddField('TotalAmount'        ,12 ,ffAN ,ftM);
  AddField('Recordcount'        ,6  ,ffN  ,ftM);
  AddField('Hashtotal'          ,11 ,ffAN ,ftM);
end;


end.

