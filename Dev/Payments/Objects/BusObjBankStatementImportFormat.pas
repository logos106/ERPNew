unit BusObjBankStatementImportFormat;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type

  TBankStatementImportFormat = class(TMSBusObj)
  private
    function GetAccountID: integer;
    function GetAutoDetect: boolean;
    function GetCreditColumnNo: integer;
    function GetDateColumnNo: integer;
    function GetDebitColumnNo: integer;
    function GetDescriptionColumnNo: integer;
    function GetFirstLineColumnNames: boolean;
    function GetSeperator: string;
    procedure SetAccountID(const Value: integer);
    procedure SetAutoDetect(const Value: boolean);
    procedure SetCreditColumnNo(const Value: integer);
    procedure SetDateColumnNo(const Value: integer);
    procedure SetDebitColumnNo(const Value: integer);
    procedure SetDescriptionColumnNo(const Value: integer);
    procedure SetFirstLineColumnNames(const Value: boolean);
    procedure SetSeperator(const Value: string);
    function GetDateFormat: string;
    procedure SetDateFormat(const Value: string);
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    Procedure DoFieldOnChange(Sender: TField); override;
    Function GetSQL: string; override;
    Function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; Override;
  Public
    Class Function GetIDField: string; override;
    Class Function GetBusObjectTablename: string; override;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    Procedure LoadFromXMLNode(const node: IXMLNode); override;
    Procedure SaveToXMLNode(const node: IXMLNode); override;
    Function ValidateData: Boolean; override;
    Function Save: Boolean; override;
  Published
    property AccountID: integer read GetAccountID write SetAccountID;
    property AutoDetect: boolean read GetAutoDetect write SetAutoDetect;
    property FirstLineColumnNames: boolean read GetFirstLineColumnNames write SetFirstLineColumnNames;
    property Seperator: string read GetSeperator write SetSeperator;
    property DateColumnNo: integer read GetDateColumnNo write SetDateColumnNo;
    property DebitColumnNo: integer read GetDebitColumnNo write SetDebitColumnNo;
    property CreditColumnNo: integer read GetCreditColumnNo write SetCreditColumnNo;
    property DescriptionColumnNo: integer read GetDescriptionColumnNo write SetDescriptionColumnNo;
    property DateFormat: string read GetDateFormat write SetDateFormat;
  end;

implementation

{ TBankStatementImportFormat }

constructor TBankStatementImportFormat.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BankStatementImportFormat';
  fSQL := 'SELECT * FROM tblbankstatementimportformat';
end;

destructor TBankStatementImportFormat.Destroy;
begin

  inherited;
end;

function TBankStatementImportFormat.DoAfterInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

function TBankStatementImportFormat.DoAfterPost(
  Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TBankStatementImportFormat.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TBankStatementImportFormat.GetAccountID: integer;
begin
  result := GetIntegerField('AccountID');
end;

function TBankStatementImportFormat.GetAutoDetect: boolean;
begin
  result := GetBooleanField('AutoDetect');
end;

class function TBankStatementImportFormat.GetBusObjectTablename: string;
begin
  result := 'tblbankstatementimportformat';
end;

function TBankStatementImportFormat.GetCreditColumnNo: integer;
begin
  result := GetIntegerField('CreditColumnNo');
end;

function TBankStatementImportFormat.GetDateColumnNo: integer;
begin
  result := GetIntegerField('DateColumnNo');
end;

function TBankStatementImportFormat.GetDateFormat: string;
begin
  result := GetStringField('DateFormat');
end;

function TBankStatementImportFormat.GetDebitColumnNo: integer;
begin
  result := GetIntegerField('DebitColumnNo');
end;

function TBankStatementImportFormat.GetDescriptionColumnNo: integer;
begin
  result := GetIntegerField('DescriptionColumnNo');
end;

function TBankStatementImportFormat.GetFirstLineColumnNames: boolean;
begin
  result := GetBooleanField('FirstLineColumnNames');
end;

class function TBankStatementImportFormat.GetIDField: string;
begin
  result := 'ID';
end;

function TBankStatementImportFormat.GetSeperator: string;
begin
  result := GetStringField('Seperator');
end;

function TBankStatementImportFormat.GetSQL: string;
begin
  result := inherited;
end;

procedure TBankStatementImportFormat.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TBankStatementImportFormat.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TBankStatementImportFormat.Save: Boolean;
begin
  self.ResultStatus.Clear;
  result := ValidateData;
  if not result then exit;
  result := inherited;
end;

procedure TBankStatementImportFormat.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TBankStatementImportFormat.SetAccountID(const Value: integer);
begin
  SetIntegerField('AccountID', Value);
end;

procedure TBankStatementImportFormat.SetAutoDetect(const Value: boolean);
begin
  SetBooleanField('AutoDetect', Value);
end;

procedure TBankStatementImportFormat.SetCreditColumnNo(const Value: integer);
begin
  SetIntegerField('CreditColumnNo', Value);
end;

procedure TBankStatementImportFormat.SetDateColumnNo(const Value: integer);
begin
  SetIntegerField('DateColumnNo', Value);
end;

procedure TBankStatementImportFormat.SetDateFormat(const Value: string);
begin
  SetStringField('DateFormat', Value);
end;

procedure TBankStatementImportFormat.SetDebitColumnNo(const Value: integer);
begin
  SetIntegerField('DebitColumnNo', Value);
end;

procedure TBankStatementImportFormat.SetDescriptionColumnNo(
  const Value: integer);
begin
  SetIntegerField('DescriptionColumnNo', Value);
end;

procedure TBankStatementImportFormat.SetFirstLineColumnNames(
  const Value: boolean);
begin
  SetBooleanField('FirstLineColumnNAmes', Value);
end;

procedure TBankStatementImportFormat.SetSeperator(const Value: string);
begin
  SetStringField('Seperator', Value);
end;

function TBankStatementImportFormat.ValidateData: Boolean;
begin
  result := false;
  if AccountID < 1 then begin
    AddResult(false,rssError,0,'Account ID is Blank');
    exit;
  end;
  if AutoDetect then begin


  end
  else begin
    if Seperator = '' then begin
      AddResult(false,rssError,0,'Seperator charactor is not defined.');
      exit;
    end;
    if DateColumnNo < 0 then begin
      AddResult(false,rssError,0,'Date Column Number is missing.');
      exit;
    end;
    if DebitColumnNo < 0 then begin
      AddResult(false,rssError,0,'Debit Amount Column Number is missing.');
      exit;
    end;
    if CreditColumnNo < 0 then begin
      AddResult(false,rssError,0,'Credit Amount Column Number is missing.');
      exit;
    end;
    if DescriptionColumnNo < 0 then begin
      AddResult(false,rssError,0,'Description Column Number is missing.');
      exit;
    end;
    if DateFormat = '' then begin
      AddResult(false,rssError,0,'Date Format is missing.');
      exit;
    end;
  end;
  result := true;
end;

end.
