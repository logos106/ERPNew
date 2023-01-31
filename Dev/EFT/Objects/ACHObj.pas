unit ACHObj;

interface

uses  EFTObj, ERPdbComponents, ATODataObj;

const
  ACH_FILEHEADERRECORD         = 1;
  ACH_BATCHHEADERRECORD        = 5;
  ACH_ENTRYDETAILRECORD        = 6;
  ACH_ENTRYDETAILADDENDARECORD = 7;
  ACH_BATCHCONTROLTOTAL        = 8;
  ACH_FILECONTROLRECORD        = 9;

type
  TACHExtraInfo = Class(TObject)
    Private
      fsFileHEaderREcord_Reference          : String;
      fsBatchHeaderRecord_DescretionaryData : String;
      fsBatchHeaderRecord_StandardEntryClass: String;
      fsBatchHeaderRecord_CompanyEntryDesc  : String;
      fsBatchHeaderRecord_OriginatorStatusCode: String;
      fiAddendaRecordIndicator: Integer;
      fsMessageAuthenticationCode: String;
    Public
      constructor Create;
      Property FileHEaderREcord_Reference          : String read fsFileHEaderREcord_Reference           write fsFileHEaderREcord_Reference;
      Property BatchHeaderRecord_DescretionaryData : String read fsBatchHeaderRecord_DescretionaryData  write fsBatchHeaderRecord_DescretionaryData;
      Property BatchHeaderRecord_StandardEntryClass: String read fsBatchHeaderRecord_StandardEntryClass write fsBatchHeaderRecord_StandardEntryClass;
      Property BatchHeaderRecord_CompanyEntryDesc  : String read fsBatchHeaderRecord_CompanyEntryDesc   write fsBatchHeaderRecord_CompanyEntryDesc;
      Property BatchHeaderRecord_OriginatorStatusCode: String read fsBatchHeaderRecord_OriginatorStatusCode write fsBatchHeaderRecord_OriginatorStatusCode;
      Property AddendaRecordIndicator: Integer read fiAddendaRecordIndicator write fiAddendaRecordIndicator;
      Property MessageAuthenticationCode: String read fsMessageAuthenticationCode write fsMessageAuthenticationCode;
      Procedure PopulateMe;
  End;

  TACHJsonRec = class(JsonATORec)
    Public
      constructor Create;Override;
  end;
(*File Header Record : This record includes your company name and	 company number. It also designates the immediate destination (LaSalle Bank
N.A. or Standard Federal Bank) of the entries contained within the file.
=============================================================================*)
  TACHFileHeaderRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
(*=============================================================================*)



(*Batch Header Record : This record indicates the effective entry date (the	 date you request the deposits/debits to be settled). In addition, this record
identifies your company and provides an entry description for the credit and debits in this batch.
=============================================================================*)
  TACHBatchHeaderRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
(*=============================================================================*)


(*Entry Detail Record : This record contains the information necessary to post	 a deposit to/withdrawal from an account, such as recipient’s name, account
number, dollar amount of the payment.
=============================================================================*)
  TACHPPDEntryRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TACHCDDEntryDetailRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TACHTELEntryDetailRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TACHWEBEntryDetailRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TACHCTXEntryDetailRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
(*=============================================================================*)




(*Entry Detail Addenda Record - This record is optional. This record contains	additional information relating to the prior entry detail record. It is primarily
used for CCD+ and CTX, which are corporate to corporate transactions.
=============================================================================*)
  TACHAddendaRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
  TACHCCDAddendaRec = class(TACHAddendaRec)
    Protected
  end;
  TACHCTXAddendaRec = class(TACHAddendaRec)
    Protected
  end;
(*=============================================================================*)



(*Batch Control Total : This record appears at the end of each batch and	contains totals for the batch.
=============================================================================*)
  TACHBatchcontrolRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
(*=============================================================================*)


(*File Control Record - This record provides a final check on the data	submitted. It contains block and batch count(s) and totals for each type of
entry.
=============================================================================*)

  TACHFilecontrolRec = class(TACHJsonRec)
  protected
    procedure PopulateFieldDefs; override;
  end;
(*=============================================================================*)

  TACHObj =  class(TEFTObj)
    Private
      fsServiceClasscode: Integer;
      fACHExtraInfo :TACHExtraInfo;
      BatchNumber :Integer;
      TotalBSB:int64;
      TotalAmount :double;
      fiTraceNo:Integer;
      Recordcount :Integer;

      Function AddFileHeaderRec:String;
      Function AddBatchHeaderRec:String;
      Function AddPPDEntryDEtailRecord:String;
      //function AddPPDCreditDetailRecord: String;
      Function AddBAtchControlRecord:String;
      Function AddFilecontrolRecord:String;


      Function NextTraceNumber:String;
      function EntryHashnumber: Integer;
    Protected
    Public
      constructor Create;
      Destructor Destroy;Override;
      function ValidateData:Boolean;Override;
      Property ServiceClasscode:Integer read fsServiceClasscode write fsServiceClasscode;
      function DoExport(Const Filename:String = '') :String;override;

  end;
implementation

uses
  sysutils, CommonDbLib, AppEnvironment, Dateutils, CommonLib, classes,
  tcTypes, DbSharedObjectsObj, Dialogs, controls;

{ TACHFileHeaderRec }

procedure TACHFileHeaderRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordTypeCode'           ,1 ,ffN ,ftM(*,'1'*));
  AddField('PriorityCode'             ,2 ,ffN ,ftR(*,'01'*));
  AddField('ImmediateDestination'     ,10,ffAN,ftM);
  AddField('ImmediateOrigin'          ,10,ffAN ,ftM);
  AddField('FileCreationDate'         ,6 ,ffDT,ftM);
  AddField('FileCreationTime'         ,4 ,ffN ,ftO);
  AddField('FileIDModifier'           ,1 ,ffAN,ftM);
  AddField('RecordSize'               ,3 ,ffN ,ftM(*,'094'*));
  AddField('BlockingFactor'           ,2 ,ffN ,ftM(*,'10'*));
  AddField('FormatCode'               ,1 ,ffN ,ftM(*,'1'*));
  AddField('ImmediateDestinationName',23,ffAN,ftO);
  AddField('ImmediateOriginName'      ,23,ffAN,ftO);
  AddField('ReferenceCode'            ,8 ,ffAN,ftO);
end;

{ TACHBatchHeaderRec }

procedure TACHBatchHeaderRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'5'*));
  AddField('ServiceClassCode'         ,3 ,ffN ,ftM);
  AddField('CompanyName'              ,16,ffAN,ftM);
  AddField('DiscretionaryData'        ,20,ffAN,ftO);
  AddField('CompanyIdentification'    ,10,ffAN ,ftM);
  AddField('StandardEntryClass'       ,3 ,ffAN,ftM);
  AddField('CompanyEntryDescription'  ,10,ffAN,ftM);
  AddField('CompanyDescriptiveDate'   ,6 ,ffAN,ftO);
  AddField('EffectiveEntryDate'       ,6 ,ffDT,ftR);
  AddField('SettlemnetDate'           ,3 ,ffAN,ftO,'   ');
  AddField('OriginatorStatusCode'     ,1 ,ffAN,ftM,'1');
  AddField('OriginatingDFIID'         ,8 ,ffAN ,ftM);
  AddField('BatchNumber'              ,7 ,ffN ,ftM);
end;

{ TACHPPDEntryRec }

procedure TACHPPDEntryRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'6'*));
  AddField('TransactionCode'          ,2 ,ffN ,ftM);
  AddField('ReceivingDFI'             ,8 ,ffAN,ftM);
  AddField('CheckDigit'               ,1 ,ffN ,ftM);
  AddField('DFIAccountNumber'         ,17,ffAN,ftM);
  AddField('Amount'                   ,10,ffAN ,ftM);
  AddField('IndividualIDNumber'       ,15,ffAN,ftM);
  AddField('IndividualName'           ,22,ffAN,ftM);
  AddField('DiscretionaryData'        ,2 ,ffAN,ftM);
  AddField('AddendaRecordIndicator'   ,1 ,ffN ,ftM);
  AddField('TraceNumber'              ,15,ffAN ,ftM);
end;

{ TACHCDDEntryDetailRec }

procedure TACHCDDEntryDetailRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'6'*));
  AddField('TransactionCode'          ,2 ,ffN ,ftM);
  AddField('ReceivingDFI'             ,8 ,ffAN,ftM);
  AddField('CheckDigit'               ,1 ,ffN ,ftM);
  AddField('DFIAccountNumber'         ,17,ffAN,ftM);
  AddField('Amount'                   ,10,ffN ,ftM);
  AddField('IdentificationNumber'     ,15,ffAN,ftM);
  AddField('ReceivingCompanyName'     ,22,ffAN,ftM);
  AddField('DiscretionaryData'        ,2 ,ffAN,ftM);
  AddField('AddendaRecordIndicator'   ,1 ,ffN ,ftM);
  AddField('TraceNumber'              ,15,ffAN ,ftM);
end;

{ TACHTELEntryDetailRec }

procedure TACHTELEntryDetailRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'6'*));
  AddField('TransactionCode'          ,2 ,ffN ,ftM);
  AddField('ReceivingDFI'             ,8 ,ffAN,ftM);
  AddField('CheckDigit'               ,1 ,ffN ,ftM);
  AddField('DFIAccountNumber'         ,17,ffAN,ftM);
  AddField('Amount'                   ,10,ffN ,ftM);
  AddField('IndividualIDNumber'       ,15,ffAN,ftM);
  AddField('IndividualName'           ,22,ffAN,ftM);
  AddField('DiscretionaryData'        ,2 ,ffAN,ftM);
  AddField('AddendaRecordIndicator'   ,1 ,ffN ,ftM);
  AddField('TraceNumber'              ,15,ffAN ,ftM);
end;

{ TACHWEBEntryDetailRec }

procedure TACHWEBEntryDetailRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'6'*));
  AddField('TransactionCode'          ,2 ,ffN ,ftM);
  AddField('ReceivingDFI'             ,8 ,ffAN,ftM);
  AddField('CheckDigit'               ,1 ,ffN ,ftM);
  AddField('DFIAccountNumber'         ,17,ffAN,ftM);
  AddField('Amount'                   ,10,ffN ,ftM);
  AddField('IndividualIDNumber'       ,15,ffAN,ftM);
  AddField('IndividualName'           ,22,ffAN,ftM);
  AddField('PaymenttypeCode'          ,2 ,ffAN,ftM);
  AddField('AddendaRecordIndicator'   ,1 ,ffN ,ftM);
  AddField('TraceNumber'              ,15,ffAN ,ftM);
end;

{ TACHAddendaRec }

procedure TACHAddendaRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'7'*));
  AddField('Addendatypecode'          ,2 ,ffN ,ftM(*,'05'*));
  AddField('PaymentRelatedInformation',80,ffAN,ftO);
  AddField('AddendaSequenceNumber'    ,4 ,ffN ,ftM);
  AddField('EntryDetailSequenceNo'    ,7 ,ffN ,ftM);
end;

{ TACHCTXEntryDetailRec }

procedure TACHCTXEntryDetailRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'6'*));
  AddField('TransactionCode'          ,2 ,ffN ,ftM);
  AddField('ReceivingDFIID'           ,8 ,ffAN ,ftM);
  AddField('CehckDigit'               ,1 ,ffN  ,ftM);
  AddField('DFIAccountNumber'         ,17,ffAN ,ftR);
  AddField('TotalAmount'              ,10,ffN  ,ftM);
  AddField('IdentificationNumber'     ,15,ffAN ,ftO);
  AddField('NoofAddendaRecords'       ,4 ,ffN ,ftM);
  AddField('ReceivingCompanyName'     ,16,ffAN ,ftR);
  AddField('Reserved'                 ,2, ffAN ,ftO, '  ');
  AddField('DiscretionaryData'        ,2, ffAN ,ftO);
  AddField('AddendaRecordIndicator'   ,1, ffN ,ftM);
  AddField('Tracenumber'              ,15,ffAN ,ftM);
end;

{ TACHBatchcontrolRec }

procedure TACHBatchcontrolRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'8'*));
  AddField('ServiceClassCode'         ,3 ,ffN ,ftM);
  AddField('EntryAddendaCount'        ,6 ,ffN ,ftM);
  AddField('EntryHash'                ,10,ffN ,ftM);
  AddField('TotalDebitEntryAmount'    ,12,ffAN ,ftM);
  AddField('TotalCreditEntryAmount'   ,12,ffAN ,ftM);
  AddField('CompanyIdentification'    ,10,ffAN ,ftR);
  AddField('MessageAuthenticationCode',19,ffAN ,ftO, '                   ');
  AddField('Reserved'                 ,6 ,ffAN ,ftO, '      ');
  AddField('OriginatingDFIID'         ,8 ,ffAN ,ftM);
  AddField('BatchNumber'              ,7 ,ffN ,ftM);
end;

{ TACHFilecontrolRec }

procedure TACHFilecontrolRec.PopulateFieldDefs;
begin
  inherited;
  AddField('RecordtypeCode'           ,1 ,ffN ,ftM(*,'9'*));
  AddField('BatchCount'               ,6 ,ffN ,ftM);
  AddField('BlockCount'               ,6 ,ffN ,ftM);
  AddField('EntryAddendaCount'        ,8 ,ffN ,ftM);
  AddField('EntryHash'                ,10,ffN ,ftM);
  AddField('TotalDebitEntryAmount'    ,12,ffAN ,ftM);
  AddField('TotalCreditEntryAmount'   ,12,ffAN ,ftM);
  AddField('Reserved'                 ,39 ,ffAN ,ftO, '                                       ');
end;

{ TACHObj }

function TACHObj.EntryHashnumber:Integer;
var
  s:String;
begin
  if totalbsb <= 9999999999 then result := Totalbsb
  else begin
    //result:= totalbsb - int64(totalbsb/10000000000) * 10000000000;
    s:= inttostr(totalbsb);
    result:= strtoint(copy( s , length(s)-10, 10));
  end;
end;

function TACHObj.AddFileHeaderRec: String;
var
  ffileHeaderRec : TACHFileHeaderRec;
  s: string;
begin
  ffileHeaderRec := TACHFileHeaderRec.create;
  TRy
    With GLAccount do begin
      {01..01}  ffileHeaderRec.O['RecordTypeCode'].I['Value']       := 1;
      {02..03}  ffileHeaderRec.O['PriorityCode'].I['Value']         := 1;
      {04..13}  ffileHeaderRec.O['ImmediateDestination'].S['Value'] := ' ' +Appenv.AchInfo.ImmediateDestinationBSB ;//GLAccount.BSB;
      {14..23}  ffileHeaderRec.O['ImmediateOrigin'].S['Value']      := ' ' + Appenv.AchInfo.ImmediateOriginNumber; // FillString(Appenv.CompanyInfo.CompanyNumber, 10 , ' ', True);
      {24..29}  ffileHeaderRec.O['FileCreationDate'].DT['Value']    := Date;
      {30..33}  ffileHeaderRec.O['FileCreationTime'].S['Value']     := FormatDateTime('HHMM' , Now);
      {34..34}  ffileHeaderRec.O['FileIDModifier'].S['Value']       := 'A';
      {35..37}  ffileHeaderRec.O['RecordSize'].I['Value']           := 94;
      {38..39}  ffileHeaderRec.O['BlockingFactor'].I['Value']       := 10;
      {40..40}  ffileHeaderRec.O['FormatCode'].I['Value']           := 1;
      {41..63}  ffileHeaderRec.O['ImmediateDestinationName'].S['Value'] := Appenv.AchInfo.ImmediateDestination_Name ;//GLAccount.Bank_Code.BankName;
      {64..86}  ffileHeaderRec.O['ImmediateOriginName'].S['Value']  := Appenv.AchInfo.ImmediateOriginName; //Appenv.CompanyInfo.CompanyName;
      {87..94}  ffileHeaderRec.O['ReferenceCode'].S['Value']        := fACHExtraInfo.FileHEaderREcord_Reference;
    end;
    if not ffileHeaderRec.Validate(s) then
      self.InvalidMsg := 'Error creating Header (1) Record: ' +s;
    Result:= ffileHeaderRec.RecordString;
  Finally
    FreeandNil(ffileHeaderRec);
  End;
end;

function TACHObj.AddBatchHeaderRec: String;
var
  fBatchHeaderRec : TACHBatchHeaderRec;
  s: string;
begin
  fBatchHeaderRec := TACHBatchHeaderRec.create;
  TRy
    {01..01}fBatchHeaderRec.O['RecordtypeCode'].I['Value']         := 5;
    {02..04}fBatchHeaderRec.O['ServiceClassCode'].I['Value']       := ServiceClasscode;
    {05..20}fBatchHeaderRec.O['CompanyName'].S['Value']            := Appenv.CompanyInfo.CompanyName;
    {21..40}fBatchHeaderRec.O['DiscretionaryData'].S['Value']      := fACHExtraInfo.BatchHeaderRecord_DescretionaryData;
    {41..50}fBatchHeaderRec.O['CompanyIdentification'].S['Value']  := '1' + (*Appenv.AchInfo.TaxID; // *)Appenv.CompanyInfo.CompanyNumber;
    {51..53}fBatchHeaderRec.O['StandardEntryClass'].S['Value']     := fACHExtraInfo.BatchHeaderRecord_StandardEntryClass;
    {54..63}fBatchHeaderRec.O['CompanyEntryDescription'].S['Value']:= Copy(QryHeader.FieldByName('TransactionDescription').AsString,1,10); //fACHExtraInfo.BatchHeaderRecord_CompanyEntryDesc;
    {64..69}fBatchHeaderRec.O['CompanyDescriptiveDate'].S['Value'] := FormatDateTime(replacestr(FormatSettings.shortDAteFormat, FormatSettings.DateSeparator, '') , date); // date in normal format without the separator
    {70..75}fBatchHeaderRec.O['EffectiveEntryDate'].DT['Value']    := Date;
    {76..78}fBatchHeaderRec.O['SettlemnetDate'].S['Value']         := '   ';
    {79..79}fBatchHeaderRec.O['OriginatorStatusCode'].S['Value']   := fACHExtraInfo.BatchHeaderRecord_OriginatorStatusCode;
    {80..87}fBatchHeaderRec.O['OriginatingDFIID'].S['Value']       := copy(Appenv.AchInfo.ImmediateOriginNumber +'        ' , 1, 8);  //trim(GLAccount.BSB);
    {88..94}fBatchHeaderRec.O['BatchNumber'].I['Value']            := BAtchNumber;
    if not fBatchHeaderRec.Validate(s) then
      self.InvalidMsg := 'Error creating Batch Header (5) Record: ' +s;

    Result:= fBatchHeaderRec.RecordString;
  Finally
    FreeandNil(fBatchHeaderRec);
  End;
end;
function TACHObj.AddPPDEntryDEtailRecord: String;
var
  fPPDEntryRec : TACHPPDEntryRec;
  s: string;
  IndividualName: string;
  qry: TERPQuery;
begin
  IndividualName := QryData.FieldByName('Accountname').AsString;
  if SameText(QryData.FieldByName('TransType').AsString,'Pay') then begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(QryData.Connection);
    try
      qry.SQL.Add('select tblemployees.EmployeeName');
      qry.SQL.Add('from tblemployees, tblpays'{, tblpayssplits'});
      qry.SQL.Add('where tblpays.PayID = ' + IntToStr(QryData.FieldByName('TransID').AsInteger));
      //qry.SQL.Add('and tblpayssplits.BSB = ' + QuotedStr(QryData.FieldByName('BSB').AsString));
      //qry.SQL.Add('and tblpayssplits.AccountNo = ' + QuotedStr(QryData.FieldByName('CreditDebitAccountNumber').AsString));
      //qry.SQL.Add('and tblpayssplits.PayID = tblpays.PayID');
      qry.SQL.Add('and tblpays.EmployeeID = tblEmployees.EmployeeId');
      qry.Open;
      if not qry.IsEmpty then
        IndividualName := qry.FieldByName('EmployeeName').AsString
      else
        IndividualName := 'Unknown';
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;

      fPPDEntryRec := TACHPPDEntryRec.create;
      Try
         {01..01}fPPDEntryRec.O['RecordtypeCode'].I['Value']        := 6;
         {02..03}fPPDEntryRec.O['TransactionCode'].I['Value']       := RegionTransactionCode(QryData.FieldByName('TransactionCode').AsInteger) ;//
         {04..11}fPPDEntryRec.O['ReceivingDFI'].S['Value']          := Copy(QryData.FieldByName('BSB').AsString +'        ' , 1,8);
         {12..12}fPPDEntryRec.O['CheckDigit'].I['Value']            := strtoint(Copy(Trim(QryData.FieldByName('BSB').AsString)+'000000000' , 9,1));
         {13..29}fPPDEntryRec.O['DFIAccountNumber'].S['Value']      := QryData.FieldByName('CreditDebitAccountNumber').AsString ;
         {30..39}fPPDEntryRec.O['Amount'].S['Value']                := FormatAmount(QryData.FieldByName('Amount').AsFloat,10,2);
         {40..54}fPPDEntryRec.O['IndividualIDNumber'].S['Value']    := QryData.FieldByName('LodgementReferences').AsString ;
         {55..76}fPPDEntryRec.O['IndividualName'].S['Value']        := IndividualName;
         {77..78}fPPDEntryRec.O['DiscretionaryData'].S['Value']     := fACHExtraInfo.BatchHeaderRecord_DescretionaryData;
         {79..79}fPPDEntryRec.O['AddendaRecordIndicator'].I['Value']:= fACHExtraInfo.AddendaRecordIndicator;
         {80..94}fPPDEntryRec.O['TraceNumber'].S['Value']           := NextTraceNumber;
         if ISInteger(trim(QryData.FieldByName('BSB').AsString)) then TotalBSB:= TotalBSB + strToint(trim(Copy(QryData.FieldByName('BSB').AsString +'        ' , 1,8)));
         TotalAmount:= TotalAmount +QryData.FieldByName('Amount').AsFloat;
         if not fPPDEntryRec.Validate(s) then
           self.InvalidMsg := 'Error creating Entry (6) Record: ' +s;
         Result:= fPPDEntryRec.RecordString;
      Finally
        FreeandNil(fPPDEntryRec);
      End;
end;

(*
function TACHObj.AddPPDCreditDetailRecord:String;
var
  fPPDEntryRec : TACHPPDEntryRec;
  s: string;
begin
      fPPDEntryRec := TACHPPDEntryRec.create;
      Try
         {01..01}fPPDEntryRec.O['RecordtypeCode'].I['Value']        := 6;
         {02..03}fPPDEntryRec.O['TransactionCode'].I['Value']       := RegionTransactionCode(13) ;//
         {04..11}fPPDEntryRec.O['ReceivingDFI'].S['Value']          := Copy(GLAccount.BSB +'        ' , 1,8);
         {12..12}fPPDEntryRec.O['CheckDigit'].I['Value']            := strToint(Copy(Trim(GLAccount.BSB)+'000000000' , 9,1));
         {13..29}fPPDEntryRec.O['DFIAccountNumber'].S['Value']      := GLAccount.BankAccountNumber ;
         {30..39}fPPDEntryRec.O['Amount'].S['Value']                := FormatAmount(TotalAmount, 10, 2);
         {40..54}fPPDEntryRec.O['IndividualIDNumber'].S['Value']    := 'TotalDebit';
         {55..76}fPPDEntryRec.O['IndividualName'].S['Value']        := Appenv.CompanyInfo.CompanyName;
         {77..78}fPPDEntryRec.O['DiscretionaryData'].S['Value']     := fACHExtraInfo.BatchHeaderRecord_DescretionaryData;
         {79..79}fPPDEntryRec.O['AddendaRecordIndicator'].I['Value']:= fACHExtraInfo.AddendaRecordIndicator;
         {80..94}fPPDEntryRec.O['TraceNumber'].S['Value']           :=NextTraceNumber;
         if ISInteger(trim(GLAccount.BSB)) then TotalBSB:= TotalBSB + strtoInt(trim(Copy(GLAccount.BSB +'        ' , 1,8)));
         if not fPPDEntryRec.Validate(s) then
           self.InvalidMsg := 'Error creating Credit Entry (6) Record: ' +s;
         Result:= fPPDEntryRec.RecordString;
      Finally
        FreeandNil(fPPDEntryRec);
      End;
end;
*)

function TACHObj.AddBAtchControlRecord: String;
var
  fBatchcontrolRec : TACHBatchcontrolRec;
  s: string;
begin
  fBatchcontrolRec := TACHBatchcontrolRec.create;
  TRy
    {01..01}fBatchcontrolRec.O['RecordtypeCode'].I['Value']           :=  8;
    {02..04}fBatchcontrolRec.O['ServiceClassCode'].I['Value']         :=  ServiceClasscode;
    {05..10}fBatchcontrolRec.O['EntryAddendaCount'].I['Value']        :=  Recordcount;
    {11..20}fBatchcontrolRec.O['EntryHash'].I['Value']                :=  EntryHashnumber;
    {21..32}fBatchcontrolRec.O['TotalDebitEntryAmount'].S['Value']    :=  FormatAmount(0,10,2, 12);
    {33..44}fBatchcontrolRec.O['TotalCreditEntryAmount'].S['Value']   :=  FormatAmount(TotalAmount,10,2, 12);
    {45..54}fBatchcontrolRec.O['CompanyIdentification'].S['Value']    :=  '1' + (*Appenv.AchInfo.TaxID; // *)Appenv.CompanyInfo.CompanyNumber;
    {55..73}fBatchcontrolRec.O['MessageAuthenticationCode'].S['Value']:=  fACHExtraInfo.MessageAuthenticationCode;
    {74..79}fBatchcontrolRec.O['Reserved'].S['Value']                 :=  '';
    {80..87}fBatchcontrolRec.O['OriginatingDFIID'].S['Value']         :=  copy(Appenv.AchInfo.ImmediateOriginNumber +'        ' , 1, 8);  //trim(GLaccount.BSB);
    {88..94}fBatchcontrolRec.O['BatchNumber'].I['Value']              := 1;
    if not fBatchcontrolRec.Validate(s) then
      self.InvalidMsg := 'Error creating Batch Control (8) Record: ' +s;
    Result:= fBatchcontrolRec.RecordString;
  Finally
    FreeandNil(fBatchcontrolRec);
  End;
end;
function TACHObj.AddFilecontrolRecord: String;
var
  fFilecontrolRec : TACHFilecontrolRec;
  s: string;
begin
  fFilecontrolRec := TACHFilecontrolRec.create;
  TRy
    {01..01}fFilecontrolRec.O['RecordtypeCode'].I['Value']        := 9;
    {02..07}fFilecontrolRec.O['BatchCount'].I['Value']            := 1;
    {08..13}fFilecontrolRec.O['BlockCount'].I['Value']            := 5;
    {14..21}fFilecontrolRec.O['EntryAddendaCount'].I['Value']     := REcordcount;
    {22..31}fFilecontrolRec.O['EntryHash'].I['Value']             := EntryHashnumber;
    {32..43}fFilecontrolRec.O['TotalDebitEntryAmount'].S['Value'] := FormatAmount(0,10,2, 12);
    {44..55}fFilecontrolRec.O['TotalCreditEntryAmount'].S['Value']:= FormatAmount(TotalAmount,10,2, 12);
    {56..94}fFilecontrolRec.O['Reserved'].S['Value']              := '';
    if not fFilecontrolRec.Validate(s) then
      self.InvalidMsg := 'Error creating File Control (9) Record: ' +s;
    Result:= fFilecontrolRec.RecordString;
  Finally
    FreeandNil(fFilecontrolRec);
  End;

end;




constructor TACHObj.Create;
begin
  fiTraceNo :=0;
  fsServiceClasscode :=200;
  fACHExtraInfo := TACHExtraInfo.Create;
  fACHExtraInfo.PopulateMe;
  BAtchNumber :=1;
end;

destructor TACHObj.Destroy;
begin
  inherited;
end;


function TACHObj.DoExport(Const Filename:String = '') :String;
var
  st: TStringlist;
begin
  inherited  DoExport(Filename);
  if not(Validatedata) then exit;
  Recordcount :=0;
  TotalAmount:=0;
  TotalBSB:=0;
  st:= TStringlist.create;
  try
      St.add(AddFileHeaderRec);
      St.add(AddBatchHeaderRec);
      if (Qrydata = nil) or (Qrydata.Active= False) or (QryData.RecordCount =0 ) or (Qrydata.FindField('Apply') = nil) then else begin
        QryData.First;
        While QryData.Eof = False do begin
          if Qrydata.FieldByname('apply').AsBoolean then begin
            St.add(AddPPDEntryDEtailRecord);
            Recordcount := Recordcount +1;
          end;
          QryData.Next;
        end;
        { When tested by client "Federal Wage and Labour" we needed to remove
          the Credit Detail record to be accepted bu their bank }
        (*
        if CommonLib.MessageDlgXP_Vista('Do you wish to include a Total Debit line in the ACH file?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
          st.Add(AddPPDCreditDetailRecord);
          Recordcount := Recordcount +1;
        end;
        *)
      end;
      st.Add(AddBAtchControlRecord);
      st.Add(AddFilecontrolRecord);
      while Frac(st.Count/10) >0 do
        st.Add(ReplicateStr('9',94));
      Result:= St.text;
      if exportfilename <> '' then
        St.SaveToFile(ExportfileName);
      Appenv.AchInfo.RecordsExported := Appenv.AchInfo.RecordsExported + recordcount;
      Appenv.AchInfo.PostDB;
      Appenv.resetAchinfo;
      if not devmode then
        RemoveCompletedEFTRecord(Qrydata.fieldbyname('DescriptiveRecordID').asInteger);
  finally
    Freeandnil(St);
  end;
end;


function TACHObj.NextTraceNumber: String;
var
  s:String;
begin
  fiTraceno:= Appenv.AchInfo.RecordsExported+  fiTraceNo +1;
  s:= trim(inttostr(fiTraceNo));
  result := copy(Appenv.AchInfo.ImmediateOriginNumber +'        ' , 1, 8);
  While length(result) < 15 do begin
    s:=  '0' + s;
    result := copy(Appenv.AchInfo.ImmediateOriginNumber +'        ' , 1, 8) + s;
  end;

end;

function TACHObj.ValidateData: Boolean;
begin
  Result:= False;
  InvalidMsg  := '';
  if AccountId =0 then begin
    InvalidMsg := ' Select an account ';
    exit;
  end;
  if GLaccount.BSB = '' then begin
    InvalidMsg := 'Account ' + Quotedstr(GLaccount.AccountName) +' doesn''t have ' + Appenv.RegionalOptions.BSBName +'.' ;
    exit;
  end;
  if Appenv.CompanyInfo.CompanyNumber = '' then begin
    InvalidMsg := 'Company number is blank.' ;
    exit;
  end;
  if AppEnv.RegionalOptions.RegionType = rUSA then begin
    { USA Format }
    if not(ISInteger(Appenv.CompanyInfo.CompanyNumber)) or (strToInt(Appenv.CompanyInfo.CompanyNumber)> 999999999 ) then begin
      InvalidMsg := 'Company number ' + Quotedstr(Appenv.CompanyInfo.CompanyNumber) +' is in the wrong format -  Expects a 10 digit number' ;
      exit;
    end;
  end
  else if AppEnv.RegionalOptions.RegionType = rCAN then begin
    { different format for Canida }

  end;

  Result:= True;
end;


{ TACHJsonRec }

constructor TACHJsonRec.Create;
begin
  inherited;
  Dateformat :=  'yymmdd';
end;

{ TACHExtraInfo }

constructor TACHExtraInfo.Create;
begin
      FileHEaderREcord_Reference            := '        ';
      BatchHeaderRecord_DescretionaryData   := 'A                   ';
      BatchHeaderRecord_StandardEntryClass  := 'PPD';
      BatchHeaderRecord_CompanyEntryDesc    := ''; //'          ';
      BatchHeaderRecord_OriginatorStatusCode  := '1';
      AddendaRecordIndicator  := 0;
      MessageAuthenticationCode  := '';
end;

procedure TACHExtraInfo.PopulateMe;
begin

end;

end.

