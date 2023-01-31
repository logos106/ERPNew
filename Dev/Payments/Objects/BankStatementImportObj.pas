unit BankStatementImportObj;

interface

uses
  CSVReaderObj, classes, ERPDbComponents;

type

  TBankTransImport = class(TObject)
  private
    Reader: TCSVReader;
    fDebitColumnNo: integer;
    fDateColumnNo: integer;
    fDescriptionColumnNo: integer;
    fDateFormat: string;
    fCreditColumnNo: integer;
    fFirstLineColumnNames: boolean;
    fSeperator: string;
    fDbConnection: TERPConnection;
    cmd: TErpCommand;
    FBankAccountName: string;
    FBankAccountId: integer;
    fDateTo: TDateTime;
    fDateFrom: TDateTime;
    fRecordsProcessedCount: integer;
    fRecordsReadCount: integer;
    procedure DoOnReadLine(Sender: TObject);
    function ColumnsConfigured: boolean;
    function HeadersOnly: boolean;
    procedure ProcessLine;
    procedure SetBankAccountId(const Value: integer);
    procedure SetBankAccountName(const Value: string);
    procedure SetCreditColumnNo(const Value: integer);
    procedure SetDateColumnNo(const Value: integer);
    procedure SetDateFormat(const Value: string);
    procedure SetDebitColumnNo(const Value: integer);
    procedure SetDescriptionColumnNo(const Value: integer);
    function GetCreditColumnNo: integer;
    function GetDateColumnNo: integer;
    function GetDateFormat: string;
    function GetDebitColumnNo: integer;
    function GetDescriptionColumnNo: integer;
    function GetFirstLineColumnNames: boolean;
    function GetSeperator: string;
    procedure SetFirstLineColumnNames(const Value: boolean);
    procedure SetSeperator(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    function ReadFromStream(stream: TStream; var msg: string): boolean;
    function ReadFromFile(const aFileName: string; var msg: string): boolean;

    property Seperator: string read GetSeperator write SetSeperator;
    property FirstLineColumnNames: boolean read GetFirstLineColumnNames write SetFirstLineColumnNames;
    property DateColumnNo: integer read GetDateColumnNo write SetDateColumnNo;
    property DateFormat: string read GetDateFormat write SetDateFormat;
    property DebitColumnNo: integer read GetDebitColumnNo write SetDebitColumnNo;
    property CreditColumnNo: integer read GetCreditColumnNo write SetCreditColumnNo;
    property DescriptionColumnNo: integer read GetDescriptionColumnNo write SetDescriptionColumnNo;
    property DbConnection: TERPConnection read fDbConnection write fDbConnection;
    property BankAccountId: integer read FBankAccountId write SetBankAccountId;
    property BankAccountName: string read FBankAccountName write SetBankAccountName;
    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;
    property RecordsReadCount: integer read fRecordsReadCount;
    property RecordsProcessedCount: integer read fRecordsProcessedCount;
  end;


implementation

uses
  SysUtils, Character, DateTimeConvert;

function DateToMySQLDate(const aDate, aFormat: string): string;
var
  dateSave: string;
begin
  dateSave := FormatSettings.ShortDateFormat;
  try
    FormatSettings.ShortDateFormat := aFormat;
    result := FormatDateTime('yyyy-mm-dd', StrToDateTime(aDate));

  finally
    FormatSettings.ShortDateFormat := dateSave;
  end;

end;

function FileDateStrToDateTime(const aDate, aFormat: string): TDateTime;
var
  dateSave: string;
begin
  dateSave := FormatSettings.ShortDateFormat;
  try
    FormatSettings.ShortDateFormat := aFormat;
    result := StrToDateTime(aDate);
  finally
    FormatSettings.ShortDateFormat := dateSave;
  end;
end;


{ TBankTransImport }

function TBankTransImport.ColumnsConfigured: boolean;
begin
  result :=
    (fDebitColumnNo > -1) and
    (fDateColumnNo > -1) and
    (fDateColumnNo > -1) and
    (fDescriptionColumnNo > -1) and
    (fCreditColumnNo > -1);
end;

constructor TBankTransImport.Create;
begin
  Reader := TCSVReader.Create;
  Reader.OnReadLine := DoOnReadLine;
  fDebitColumnNo := -1;
  fDateColumnNo := -1;
  fDescriptionColumnNo := -1;
  fDateFormat := '';
  fCreditColumnNo := -1;
  fDateFrom := 0;
  fDateTo := MaxDateTime;
end;

destructor TBankTransImport.Destroy;
begin
  Reader.Free;
  inherited;
end;

procedure TBankTransImport.DoOnReadLine(Sender: TObject);
var
  x: integer;
begin
  if Reader.CurrentLineNo = 0 then begin
    { the first line }
    if not ColumnsConfigured then begin
      { try and figure out columns }
      for x := 0 to Reader.FirstLine.Count -1 do begin
        if Pos('date',Lowercase(Reader.FirstLine[x])) > 0 then begin
          if fDateColumnNo < 0 then
            fDateColumnNo := x
          else
            raise Exception.Create('Could not determin column, more than one header column is labled as Date');
        end
        else if Pos('description',Lowercase(Reader.FirstLine[x])) > 0 then begin
          if fDescriptionColumnNo < 0 then
            fDescriptionColumnNo := x
          else
            raise Exception.Create('Could not determin column, more than one header column is labled as Description');
        end
        else if Pos('debit',Lowercase(Reader.FirstLine[x])) > 0 then begin
          if fDebitColumnNo < 0 then
            fDebitColumnNo := x
          else
            raise Exception.Create('Could not determin column, more than one header column is labled as Debit');
        end
        else if Pos('credit',Lowercase(Reader.FirstLine[x])) > 0 then begin
          if fCreditColumnNo < 0 then
            fCreditColumnNo := x
          else
            raise Exception.Create('Could not determin column, more than one header column is labled as Credit');
        end;
      end;
      if not ColumnsConfigured then
        raise Exception.Create('Could not determin which input columns to read from.');
    end
    else begin
      { colums are configured but does first row contain headings .. }
      if HeadersOnly then
        ProcessLine;
    end;

  end
  else begin
    { not the first row .. }
    ProcessLine;
  end;
end;

function TBankTransImport.GetCreditColumnNo: integer;
begin
  result := fCreditColumnNo;
end;

function TBankTransImport.GetDateColumnNo: integer;
begin
  result := fDateColumnNo;
end;

function TBankTransImport.GetDateFormat: string;
begin
  result := fDateFormat;
end;

function TBankTransImport.GetDebitColumnNo: integer;
begin
  result := fDebitColumnNo;
end;

function TBankTransImport.GetDescriptionColumnNo: integer;
begin
  result := fDescriptionColumnNo;
end;

function TBankTransImport.GetFirstLineColumnNames: boolean;
begin
  result := fFirstLineColumnNames;
end;

function TBankTransImport.GetSeperator: string;
begin
  result := fSeperator;
end;

function TBankTransImport.HeadersOnly: boolean;
var
  x, y: integer;
  val: string;
//  HasLetter,
  HasNumber, HasDecimalSeparator: boolean;
begin
  { return true if first line is headers only }
  result := true;
  for x := 0 to Reader.FirstLine.Count -1 do begin
    val := Reader.FirstLine[x];
    //HasLetter := false;
    HasNumber := false;
    HasDecimalSeparator := false;
    for y := 1 to Length(val) do begin
      if val[y] = FormatSettings.DecimalSeparator then
        HasDecimalSeparator := true
//      else if IsLetter(val[y]) then
//        HasLetter := true
      else if IsNumber(val[y]) then
        HasNumber := true;
    end;
    if HasNumber and HasDecimalSeparator then begin
      { probably a currency amount .. }
      result := false;
      exit;
    end;
  end;
end;

procedure TBankTransImport.ProcessLine;
var
  aDate: TDateTime;
begin
  { do we know about the date format yet .. }
  if fDateFormat = '' then begin
    { assume region format }
    fDateFormat := FormatSettings.ShortDateFormat;
  end;
  if (Reader.CurrentLineNo = 0) and FirstLineColumnNames  then exit;

  Inc(fRecordsReadCount);

  aDate := FileDateStrToDateTime(Reader.CurrentLine[DateColumnNo],DateFormat);

  if (aDate >= DateFrom) and (aDate <= DateTo) then begin
    cmd.SQL.Clear;
    cmd.SQL.Add('insert into tblbankstatementline');
    cmd.SQL.Add('(Source,Amount,BaseType,TransactionDate,DescriptionSimple,AccountName,AccountID)');
    cmd.SQL.Add(' values (');
    cmd.SQL.Add(QuotedStr('Import'));
    if Reader.CurrentLine[DebitColumnNo] <> '' then begin
      cmd.SQL.Add(',' + Reader.CurrentLine[DebitColumnNo]);
      cmd.SQL.Add(',' + QuotedStr('DEBIT'));
    end
    else if Reader.CurrentLine[CreditColumnNo] <> '' then begin
      cmd.SQL.Add(',' + Reader.CurrentLine[CreditColumnNo]);
      cmd.SQL.Add(',' + QuotedStr('CREDIT'));
    end
    else
      raise Exception.Create('Line does not contain a Debit or Credit Amount for Date: ' + Reader.CurrentLine[DateColumnNo]);

    cmd.SQL.Add(',' + QuotedStr(FormatDateTime('yyyy-mm-dd', aDate)));
    cmd.SQL.Add(',' + QuotedStr(Reader.CurrentLine[DescriptionColumnNo]));
    cmd.SQL.Add(',' + QuotedStr(BankAccountName));
    cmd.SQL.Add(',' + IntToStr(BankAccountID));
    cmd.SQL.Add(');');
    cmd.Execute;
    Inc(fRecordsProcessedCount);
  end;
end;

function TBankTransImport.ReadFromFile(const aFileName: string; var msg: string): boolean;
begin
  result := true;
  fRecordsProcessedCount := 0;
  fRecordsReadCount := 0;
  cmd := TErpCommand.Create(nil);
  try
    cmd.Connection := DbConnection;
    try
      Reader.ReadFromFile(aFileName);
    except
      on e: exception do begin
        result := false;
        msg := e.Message;
      end;
    end;
  finally
    cmd.Free;
  end;
end;

function TBankTransImport.ReadFromStream(stream: TStream; var msg: string): boolean;
begin
  result := true;
  fRecordsProcessedCount := 0;
  fRecordsReadCount := 0;
  cmd := TErpCommand.Create(nil);
  try
    cmd.Connection := DbConnection;
    try
      Reader.ReadFromStream(stream);
    except
      on e: exception do begin
        result := false;
        msg := e.Message;
      end;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TBankTransImport.SetBankAccountId(const Value: integer);
begin
  FBankAccountId := Value;
end;

procedure TBankTransImport.SetBankAccountName(const Value: string);
begin
  FBankAccountName := Value;
end;

procedure TBankTransImport.SetCreditColumnNo(const Value: integer);
begin
  fCreditColumnNo := Value;
end;

procedure TBankTransImport.SetDateColumnNo(const Value: integer);
begin
  fDateColumnNo := Value;
end;

procedure TBankTransImport.SetDateFormat(const Value: string);
begin
  fDateFormat := Value;
end;

procedure TBankTransImport.SetDebitColumnNo(const Value: integer);
begin
  fDebitColumnNo := Value;
end;

procedure TBankTransImport.SetDescriptionColumnNo(const Value: integer);
begin
  fDescriptionColumnNo := Value;
end;

procedure TBankTransImport.SetFirstLineColumnNames(const Value: boolean);
begin
  fFirstLineColumnNames := Value;
end;

procedure TBankTransImport.SetSeperator(const Value: string);
begin
  fSeperator := Value;
  Reader.FieldSeperator := Value;
end;

end.
