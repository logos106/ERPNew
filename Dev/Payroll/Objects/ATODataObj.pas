unit ATODataObj;

interface

uses
  JsonObject;

type
  TATOFieldFormat = (
    ffA,   { Alphabetic (A-Z) left justified, blank filled }
    ffAN,  { Alphanumeric, left justified, blank filled }
    ffDT,  { Date, based on Dateformat property - default DDMMCCYY  }
    ffN    { Numeric (0-9), right justified, 0 filled}
 );

 TATOFieldType = (
   ftM,    { Mandatory, can not be blank }
   ftO,    { Optional }
   ftC,    { Conditional }
   ftS,     { ATO use only, must be blank }
   ftR    { Required }
 );

  JsonATORec = class(TJSONObject)
  private
    fsDateformat: String;
    fbTrimDatainCSV: Boolean;
    function GetRecordString: string;
    Function GetCSVRecordString:String;
    function getCSString: string;
    function PadNumber(fld: TJsonObject): string;
    function PadString(fld: TJsonObject): string;
    function GetFieldNames: String;
    function ReadasString(DelimeterStr: string=''): String;
  protected
    procedure AddField(aName: string; aLength: integer; aFormat: TATOFieldFormat; aType: TATOFieldType; aValue: string = '');
    procedure PopulateFieldDefs; virtual; abstract;
  public
    constructor Create; Override;
    property RecordString: string read GetRecordString;
    property CSVRecordString: string read GetCSVRecordString;
    Property CSString :String read getCSString;
    Property FieldNames :String read GetFieldNames;
    Property Dateformat:String read fsDateformat write fsDateformat;
    Property TrimDatainCSV:Boolean read fbTrimDatainCSV write fbTrimDatainCSV;
    function Validate(var msg: string): boolean;
  end;

  TETPSummmaryRec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TSupplierData1Rec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TSupplierData2Rec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TSupplierData3Rec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TPayerDataRec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TSoftwareRec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TPAYGSumRec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  TTotalRec = class(JsonATORec)
  protected
    procedure PopulateFieldDefs; override;
  end;

  function FieldFormatToStr(fmt: TATOFieldFormat): string;
  function StrToFieldFormat(fmtStr: string): TATOFieldFormat;

  function FieldTypeToStr(ft: TATOFieldType): string;
  function StrToFieldType(ftStr: string): TATOFieldType;

implementation

uses
  SysUtils, CommonLib;


function FieldFormatToStr(fmt: TATOFieldFormat): string;
begin
  case fmt of
    ffA:  result := 'A';
    ffAN: result := 'AN';
    ffDT: result := 'DT';
    ffN:  result := 'N';
    else raise exception.Create('Unknown Field Format');
  end;
end;

function StrToFieldFormat(fmtStr: string): TATOFieldFormat;
begin
  if fmtStr = 'A' then result := ffA
  else if fmtStr = 'AN' then result := ffAN
  else if fmtStr = 'DT' then result := ffDT
  else if fmtStr = 'N' then result := ffN
  else raise exception.Create('Unknown Field Format String');
end;

function FieldTypeToStr(ft: TATOFieldType): string;
begin
  case ft of
    ftM:  result := 'M';
    ftO: result := 'O';
    ftC: result := 'C';
    ftS:  result := 'S';
    ftR:  result := 'R';
    else raise exception.Create('Unknown Field Type');
  end;
end;

function StrToFieldType(ftStr: string): TATOFieldType;
begin
  if ftStr = 'M' then result := ftM
  else if ftStr = 'O' then result := ftO
  else if ftStr = 'C' then result := ftC
  else if ftStr = 'S' then result := ftS
  else if ftStr = 'R' then result := ftR
  else raise exception.Create('Unknown Field Type String');
end;


{ JsonATORec }

procedure JsonATORec.AddField(aName: string; aLength: integer; aFormat: TATOFieldFormat; aType: TATOFieldType; aValue: string = '');
var
  fld: TJsonObject;
begin
  fld := TJsonObject.Create;
  fld.I['Length'] := aLength;
  fld.S['Format'] := FieldFormatToStr(aFormat);
  fld.S['Type'] := FieldTypeToStr(aType);
  if aValue <> '' then
    //fld.ItemByName['Value'].Value.AsString := aValue;
    fld.S['Value'] := aValue;
  self.Add(aName,fld);
end;

constructor JsonATORec.Create;
begin
  inherited;
  PopulateFieldDefs;
  Dateformat :=  'ddmmyyyy';
  TrimDatainCSV := False;
end;

function JsonATORec.getCSString: string;
var
  x: integer;
  fld: TJsonObject;
begin
  result:= '';

  for x := 0 to Count -1 do begin
    if REsult <> '' then result := result+  ',';
    fld := self.Items[x].Value.AsObject;
    case StrToFieldFormat(fld.S['Format']) of
      ffA:  result := result + PadString(fld);   { Alphabetic (A-Z) left justified, blank filled }
      ffAN: result := result + PadString(fld);  { Alphanumeric, left justified, blank filled }
      ffDT: begin
        if fld.ItemByName['Value'].Value.AsDateTime = 0 then
          result := result + '00000000'
        else
          result := result + FormatDateTime(Dateformat,fld.ItemByName['Value'].Value.AsDateTime); { Date, DDMMCCYY }
      end;
      ffN: result := result + PadNumber(fld);    { Numeric (0-9), right justified, 0 filled}
    end;
  end;

end;

function JsonATORec.GetFieldNames: String;
var
  x: integer;
begin
  result:= '';
  for x := 0 to Count -1 do begin
    if result <> '' then result := result +',';
    REsult := result + self.Items[x].name;
  end;
end;
Function JsonATORec.GetCSVRecordString:String;
begin
   result:= ReadasString(',');
end;
function JsonATORec.GetRecordString: string;
begin
   result:= ReadasString;
end;
function JsonATORec.ReadasString(DelimeterStr: string =''):String;
var
  x: integer;
  fld: TJsonObject;
  fsREsult:String;
begin
  result:= '';
  for x := 0 to Count -1 do begin
    fsREsult:='';
    fld := self.Items[x].Value.AsObject;
    case StrToFieldFormat(fld.S['Format']) of
      ffA:  fsREsult:= PadString(fld);   { Alphabetic (A-Z) left justified, blank filled }
      ffAN: fsREsult:= PadString(fld);  { Alphanumeric, left justified, blank filled }
      ffDT: begin
        if fld.ItemByName['Value'].Value.AsDateTime = 0 then
          fsREsult:= '00000000'
        else
          fsREsult:= FormatDateTime(DateFormat,fld.ItemByName['Value'].Value.AsDateTime); { Date, DDMMCCYY }
      end;
      ffN: fsREsult:= PadNumber(fld);    { Numeric (0-9), right justified, 0 filled}
    end;
    fsREsult := Copy(fsResult,1,fld.I['Length']);
    if TrimDatainCSV and (DelimeterStr<> '') then fsREsult:= trim(fsREsult);
    if result <> '' then result := result + DelimeterStr;
    result := result + fsREsult;
  end;
end;

function JsonATORec.Validate(var msg: string): boolean;
var
  x: integer;
  pair, valPair: TJsonValuePair;
  fld: TJsonObject;
begin
  result := false;
  for x := 0 to Count -1 do begin
    pair := self.Items[x];
    if pair.ValueType = valObject then begin
      fld := pair.Value.AsObject;
      if StrToFieldType(fld.S['Type']) in [ftM, ftR] then begin
        valPair := fld.ItemByName['Value'];
        if not Assigned(valPair) then begin
          msg := 'Mandatory / Required field ' + pair.Name + ' is missing';
          exit;
        end;
        case valPair.ValueType of
          valNone: ;
          valString:
            begin
              if valPair.Value.AsString = '' then begin
                msg := 'Mandatory / Required string field ' + pair.Name + ' is blank';
                exit;
              end;
            end;
          valNumber:
            begin
//              if valPair.Value.AsFloat = 0 then begin
//                msg := 'Mandatory / Required number field ' + pair.Name + ' is zero';
//                exit;
//              end;
            end;
          valObject: ;
          valArray: ;
          valNull: ;
          valBoolean: ;
        end;


      end;
    end;


  end;
  result := true;
end;

function JsonATORec.PadNumber(fld: TJsonObject): string;
begin
  if fld.Exists('Value') then
    result := IntToStr(Trunc(fld.ItemByName['Value'].Value.AsFloat))
  else
    result := '0';
  while Length(result) < fld.I['Length'] do
    result := '0' + result;
end;

function JsonATORec.PadString(fld: TJsonObject): string;
begin
  REsult:= StripCR(fld.S['Value']);
  result := Copy(result,1,fld.I['Length']);
  while Length(result) < fld.I['Length'] do
    result := result + ' ';
end;

{ TETPSummmaryRec }

procedure TETPSummmaryRec.PopulateFieldDefs;
begin
  AddField('RecordLength',3,ffN,ftM,'628');
  AddField('RecordIdent',4,ffA,ftM,'DEMP');
  AddField('PayeeTaxFileNumber',9,ffN,ftM);
  AddField('PayeeSurname',30,ffAN,ftM);
  AddField('PayeeFirstName',15,ffAN,ftC);
  AddField('PayeeSecondName',15,ffAN,ftO);
  AddField('PayeeAddressLine1',38,ffAN,ftM);
  AddField('PayeeAddressLine2',38,ffAN,ftO);
  AddField('PayeeSuburb',27,ffAN,ftM);
  AddField('PayeeState',3,ffA,ftM);
  AddField('PayeePostcode',4,ffN,ftM);
  AddField('PayeeCountry',20,ffAN,ftC);
  AddField('PayeeDateOfBirth',8,ffDT,ftM);
  AddField('DateOfPayment',8,ffDT,ftM);
  AddField('TotalTaxWithheld',8,ffN,ftM);
  AddField('TaxableComponent',8,ffN,ftM);
  AddField('TaxFreeComponent',8,ffN,ftM);
  AddField('DethBenifit',1,ffA,ftM,'N');
  AddField('TypeOfDethBenifit',1,ffA,ftC,' ');
  AddField('TransitionalTerminationPayment',1,ffA,ftM,'N');
  AddField('PartOfPreviousYearETP',1,ffA,ftM,'N');
  AddField('AmenmentIndicator',1,ffA,ftM,'O');
  AddField('Filler',377,ffA,ftS);
end;

{ TSupplierData1Rec }

procedure TSupplierData1Rec.PopulateFieldDefs;
begin
  AddField('RecordLength',       3,   ffN,  ftM, '628');
  AddField('RecordIdent',        14,  ffA,  ftM, 'IDENTREGISTER1');
  AddField('SupplierABN',        11,  ffN,  ftM);
  AddField('RunType',            1,   ffA,  ftM, 'P');
  AddField('ReportEndDate',      8,   ffDT, ftM);
  AddField('DataType',           1,   ffA,  ftM, 'E');
  AddField('TypeOfReport',       1,   ffA,  ftM, 'A');
  AddField('FormatOfReturnMedia',1,   ffA,  ftM, 'P');
  AddField('VersionNumber',      10,  ffAN, ftM, 'FEMPA010.0');
  AddField('Filler',             578, ffA,  ftS);
end;

{ TSupplierData2Rec }

procedure TSupplierData2Rec.PopulateFieldDefs;
begin
  AddField('RecordLength',              3,   ffN,  ftM, '628');
  AddField('RecordIdent',               14,  ffA,  ftM, 'IDENTREGISTER2');
  AddField('SupplierName',              200, ffAN, ftM);
  AddField('SupplierContactName',       38,  ffAN, ftM, 'P');
  AddField('SupplierContactPhoneNumber', 15,  ffAN, ftM);
  AddField('SupplierContactFaxNumber',   15,  ffAN, ftO);
  AddField('SupplierFileRef',           16,  ffAN, ftM, 'O');
  AddField('Filler',                    327, ffA,  ftS);
end;

{ TSupplierData3Rec }

procedure TSupplierData3Rec.PopulateFieldDefs;
begin
  AddField('RecordLength',                3,  ffN,  ftM, '628');
  AddField('RecordIdent',                14,  ffA,  ftM, 'IDENTREGISTER3');

  AddField('SupplierStreetAddressLine1', 38,  ffAN, ftM);
  AddField('SupplierStreetAddressLine2', 38,  ffAN, ftO);
  AddField('SupplierSuburb',             27,  ffAN, ftM);
  AddField('SupplierState',               3,  ffA,  ftM);
  AddField('SupplierPostcode',            4,  ffN,  ftM);
  AddField('SupplierCountry',            20,  ffAN, ftC);

  AddField('SupplierPostalAddressLine1', 38,  ffAN, ftO);
  AddField('SupplierPostalAddressLine2', 38,  ffAN, ftC);
  AddField('SupplierPostalSuburb',       27,  ffAN, ftC);
  AddField('SupplierPostalState',         3,  ffA,  ftC);
  AddField('SupplierPostalPostcode',      4,  ffN,  ftC);
  AddField('SupplierPostalCountry',      20,  ffAN, ftC);

  AddField('SupplierEmailAddress',       76,  ffAN, ftO);
  AddField('Filler',                    275,  ffA,  ftS);
end;

{ TPayerDataRec }

procedure TPayerDataRec.PopulateFieldDefs;
begin
  AddField('RecordLength',                3,  ffN,  ftM, '628');
  AddField('RecordIdent',                 8,  ffA,  ftM, 'IDENTITY');

  AddField('PayerABN',                   11,  ffN,  ftM);
  AddField('BranchNumber',                3,  ffN,  ftM);
  AddField('FinancialYear',               4,  ffN,  ftM);

  AddField('PayerName',                 200,  ffAN, ftM);
  AddField('PayerTradingName',          200,  ffAN, ftO);

  AddField('PayerAddressLine1',          38,  ffAN, ftM);
  AddField('PayerAddressLine2',          38,  ffAN, ftO);
  AddField('PayerSuburb',                27,  ffAN, ftM);
  AddField('PayerState',                  3,  ffA,  ftM);
  AddField('PayerPostcode',               4,  ffN,  ftM);
  AddField('PayerCountry',               20,  ffAN, ftC);

  AddField('PayerContactName',           38,  ffAN, ftO);
  AddField('PayerContactPhoneNumber',    15,  ffAN, ftO);
  AddField('PayerContactFaxNumber',      15,  ffAN, ftO);
  AddField('Filler',                      1,  ffA,  ftS);
end;

{ TSoftwareRec }

procedure TSoftwareRec.PopulateFieldDefs;
begin
  AddField('RecordLength',                3,  ffN,  ftM, '628');
  AddField('RecordIdent',                 8,  ffA,  ftM, 'SOFTWARE');
  AddField('SoftwareProductType',        80,  ffAN, ftM, 'COMMERCIAL ERP Software Ver 9');
  AddField('ECITested',                   1,  ffA,  ftM, 'Y');
  AddField('Filler',                    536,  ffA,  ftS);
end;

{ TPAYGSumRec }

procedure TPAYGSumRec.PopulateFieldDefs;
begin
  AddField('RecordLength',                3,  ffN,  ftM, '628');
  AddField('RecordIdent',                 4,  ffA,  ftM, 'DINB');
  AddField('IncomeType',                  1,  ffA,  ftM, 'S');
  AddField('PayeeTaxFileNumber',          9,  ffN,  ftM);
  AddField('PayeeDOB',                    8, ffDT,  ftO);
  AddField('PayeeSurname',               30, ffAN,  ftM);
  AddField('PayeeFirstName',             15, ffAN,  ftC);
  AddField('PayeeSecondName',            15, ffAN,  ftO);
  AddField('PayeeAddressLine1',          38, ffAN,  ftM);
  AddField('PayeeAddressLine2',          38, ffAN,  ftO);
  AddField('PayeeSuburb',                27, ffAN,  ftM);
  AddField('PayeeState',                  3,  ffA,  ftM);
  AddField('PayeePostCode',               4,  ffN,  ftM);
  AddField('PayeeCountry',               20, ffAN,  ftC);
  AddField('PeriodStartDate',             8, ffDT,  ftM);
  AddField('PeriodEndDate',               8, ffDT,  ftM);
  AddField('TotalTaxWithheld',            8,  ffN,  ftM);
  AddField('GrossPayments',               8,  ffN,  ftM);
  AddField('TotalAllowances',             8,  ffN,  ftM);
  AddField('LumpSumPaymentA',             8,  ffN,  ftM);
  AddField('LumpSumPaymentB',             8,  ffN,  ftM);
  AddField('LumpSumPaymentD',             8,  ffN,  ftM);
  AddField('LumpSumPaymentE',             8,  ffN,  ftM);
  AddField('CommunityDevEmpProj',         8,  ffN,  ftM);
  AddField('ZeroFiller',                  8,  ffN,  ftM);
  AddField('ReportableFringeBenifits',    8,  ffN,  ftM);
  AddField('AmendmentIndicator',          1,  ffA,  ftM, 'O');
  AddField('ReportableEmpSuperContributions', 8,  ffN,  ftM);
  AddField('LumpSumPaymentAType',         1,  ffA,  ftC);
  AddField('WorkplaceGiving',             8,  ffN,  ftM);
  AddField('UnionProfFees',               8,  ffN,  ftM);
  AddField('ExemptForeignEmploymentIncome', 8,  ffN,  ftM);
  AddField('DeductableAmountOfTheUndeductedPurchasePriceOfTheAnnuity', 8,  ffN,  ftM);

  AddField('Filler',                    275,  ffA,  ftS);
end;

{ TTotalRec }

procedure TTotalRec.PopulateFieldDefs;
begin
  AddField('RecordLength',                3,  ffN,  ftM, '628');
  AddField('RecordIdent',                10, ffAN,  ftM, 'FILE-TOTAL');
  AddField('NumberOfRecords',             8,  ffN,  ftM);
  AddField('Filler',                    607,  ffA,  ftS);
end;

end.
