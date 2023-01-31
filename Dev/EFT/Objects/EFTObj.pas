unit EFTObj;

interface

uses  BusObjGLAccount, ERPdbComponents, ATODataObj;

type
  TEFTObj = class(TObject)
    Private
      fiAccountId: Integer;
      fGLAccount : TAccount;
      fsInvalidMsg: String;
      fQryData: TERPQuery;
      fQryHeader: TERPQuery;
      fsExportfileName: String;
    Protected
      Function GLAccount: TAccount;
      function FormatAmount(const Value:Double;digits:Integer; roundto:Integer =2; fLength :Integer =10):String;
      function FormatNumber(const Value:Integer;fLength :Integer =10;Suffix:Boolean=True; fillchar:String ='0';trimfromright:Boolean=True):String;
      procedure RemoveCompletedEFTRecord(const RecordID: integer);
      Function RegionTransactionCode(const Value:Integer):Integer;virtual;
    Public
      constructor Create;
      Destructor Destroy;Override;
      Property AccountID:Integer read fiAccountId write fiAccountID;
      Property InvalidMsg:String read fsInvalidMsg write fsInvalidMsg;
      Property QryData : TERPQuery read fQryData write fQryData;
      Property QryHeader : TERPQuery read fQryHeader write fQryHeader;
      Property ExportfileName :String read fsExportfileName write fsExportfileName;
      function ValidateData:Boolean;Virtual;
      function DoExport(Const Filename:String = '') :String;Virtual;


  end;
implementation

uses Sysutils, CommonLib, CommonDbLib, AppEnvironment, tcTypes;

{ TEFTObj }

function TEFTObj.RegionTransactionCode(const Value: Integer): Integer;
begin
  if Appenv.RegionalOptions.RegionType = rUSA then begin
         if Value = 50 then  Result:= 22
    else if Value = 53 then  Result := 22 { payroll split -> cehque account deposit }
    else if Value = 13 then  Result := 27
    else Result:= Value;
  end else if Appenv.RegionalOptions.RegionType = rNz then begin
         if Value = 53 then  Result:= 52
    else Result:= 51;
  end else begin
    Result:= Value;
  end;
end;


function TEFTObj.GLAccount: TAccount;
begin
  if fGLAccount = nil then
    fGLAccount := TAccount.CreateWithNewConn(nil);
  fGLAccount.Load(AccountID);
  REsult:=fGLAccount;
end;

function TEFTObj.ValidateData: Boolean;
begin
  Result:= True;
end;

constructor TEFTObj.Create;
begin
  inherited;
  fiAccountId :=0;
  fsInvalidMsg := '';
  fsExportfileName :='';
  fglAccount := TAccount.CreateWithNewConn(nil);
  fQryData:= Nil;
  fQryHeader:= Nil;
end;

destructor TEFTObj.Destroy;
begin
  Freeandnil(fGLAccount);
  inherited;
end;

function TEFTObj.DoExport(const Filename: String): String;
begin
  ExportfileNAme:= Filename;
end;
function TEFTObj.FormatNumber(const Value:Integer;fLength :Integer =10;Suffix:Boolean=True; fillchar:String ='0';trimfromright:Boolean=True):String;
begin
  result:= inttostr(Value);
  while length(result) < flength do
    if suffix then result := result + fillchar else result := fillchar + result;
  if length(result) > flength then
    if trimfromright then
      result := copy(result , 1, flength)
    else result := copy(result , (length(result)-flength)+1, flength);
end;
function TEFTObj.FormatAmount(const Value: Double; digits, roundto, fLength: Integer): String;
begin
  result:= floattostr(round(value, roundto));
  if pos('.',result)=0 then result := result +ReplicateStr('0' , roundto)
  else while pos('.',result) >= length(result)-1 do result := result +'0';
  result:= replaceStr(result, '.' , '');
  if fLength >0 then
   While length(result)<fLength do
      result:= '0'+result;
end;
procedure TEFTObj.RemoveCompletedEFTRecord(const RecordID: integer);
begin
    ExecuteSQL('DELETE FROM tblabadetailrecord WHERE Apply ="T" and DescriptiveRecordID="' + IntToStr(RecordID) + '";' +
                'DELETE FROM tblabadescriptiverecord WHERE DescriptiveRecordID="' + IntToStr(RecordID) + '";', Qrydata.connection );
end;
end.

