unit PoolData;

interface

uses
  dialogs, MyAccess;

type
  TPoolData = class
  private
    FAlgae: string;
    FAlkalineDemand: single;
    FCalciumHardness: single;
    FConstructionType: string;
    FFreeSanitizer: single;
    FIsSpa: boolean;
    FLocation: string;
    FMetals: single;
    FMSAUsed: boolean;
    FpH: single;
    FPhosphate: single;
    FPoolType: string;
    FSalt: integer;
    FSanitizer: string;
    FSanitizerLvl: integer;
    FStabilizerLvl: single;
    FTDS: integer;
    FTemperature: single;
    FTotalAlkaline: single;
    FTotalSanitizer: single;
    FTurbidity: boolean;
    FVolume: integer;

    function GetAlgae: string;
    function GetAlkalineDemand: single;
    function GetCalciumHardness: single;
    function GetConstructionType: string;
    function GetFreeSanitizer: single;
    function GetLocation: string;
    function GetMetals: single;
    function GetMSAUsed: boolean;
    function GetpH: single;
    function GetPhosphate: single;
    function GetPoolType: string;
    function GetSanitizer: string;
    function GetSanitizerLvl: integer;
    function GetStabilizerLvl: single;
    function GetTDS: integer;
    function GetTemperature: single;
    function GetTotalAlkaline: single;
    function GetTotalSanitizer: single;
    function GetTurbidity: boolean;
    function GetVolume: integer;
    procedure SetAlgae(const Value: string);
    procedure SetAlkalineDemand(const Value: single);
    procedure SetCalciumHardness(const Value: single);
    procedure SetConstructionType(const Value: string);
    procedure SetFreeSanitizer(const Value: single);
    procedure SetLocation(const Value: string);
    procedure SetMetals(const Value: single);
    procedure SetMSAUsed(const Value: boolean);
    procedure SetpH(const Value: single);
    procedure SetPhosphate(const Value: single);
    procedure SetPoolType(const Value: string);
    procedure SetSanitizer(const Value: string);
    procedure SetSanitizerLvl(const Value: integer);
    procedure SetStabilizerLvl(const Value: single);
    procedure SetTDS(const Value: integer);
    procedure SetTemperature(const Value: single);
    procedure SetTotalAlkaline(const Value: single);
    procedure SetTotalSanitizer(const Value: single);
    procedure SetTurbidity(const Value: boolean);
    procedure SetVolume(const Value: integer);
    function GetSalt: integer;
    procedure SetSalt(const Value: integer);
    function GetIsSpa: boolean;
    procedure SetIsSpa(const Value: boolean);
  protected
  public
    constructor Create;
    procedure Validate;
    procedure LoadFromDatabase(const ClientName: string);
    procedure SaveToDatabase;

    property Volume: integer read GetVolume write SetVolume;
    property PoolType: string read GetPoolType write SetPoolType;
    property Location: string read GetLocation write SetLocation;
    property ConstructionType: string read GetConstructionType write SetConstructionType;
    property Salt: integer read GetSalt write SetSalt;
    property Sanitizer: string read GetSanitizer write SetSanitizer;
    property SanitizerLvl: integer read GetSanitizerLvl write SetSanitizerLvl;
    property MSAUsed: boolean read GetMSAUsed write SetMSAUsed;
    property IsSpa: boolean read GetIsSpa write SetIsSpa;
    property Temperature: single read GetTemperature write SetTemperature;
    property TDS: integer read GetTDS write SetTDS;
    property StabilizerLvl: single read GetStabilizerLvl write SetStabilizerLvl;
    property TotalSanitizer: single read GetTotalSanitizer write SetTotalSanitizer;
    property FreeSanitizer: single read GetFreeSanitizer write SetFreeSanitizer;
    property pH: single read GetpH write SetpH;
    property AlkalineDemand: single read GetAlkalineDemand write SetAlkalineDemand;
    property TotalAlkaline: single read GetTotalAlkaline write SetTotalAlkaline;
    property CalciumHardness: single read GetCalciumHardness write SetCalciumHardness;
    property Metals: single read GetMetals write SetMetals;
    property Turbidity: boolean read GetTurbidity write SetTurbidity;
    property Algae: string read GetAlgae write SetAlgae;
    property Phosphate: single read GetPhosphate write SetPhosphate;
  published
  end;

implementation

uses CommonDbLib, CommonLib, SysUtils;


{ TPoolData }

constructor TPoolData.Create;
begin
  inherited;
  FAlgae := 'EMPTY';
  FAlkalineDemand := -1.0;
  FCalciumHardness := -1.0;
  FConstructionType := 'EMPTY';
  FFreeSanitizer := -1.0;
  FIsSpa := false;
  FLocation := 'EMPTY';
  FMetals := -1.0;
  FMSAUsed := false;
  FpH := -1.0;
  FPhosphate := -1.0;
  FPoolType := 'EMPTY';
  FSalt := -1;
  FSanitizer := 'EMPTY';
  FSanitizerLvl := -1;
  FStabilizerLvl := -1.0;
  FTDS := -1;
  FTemperature := -1.0;
  FTotalAlkaline := -1.0;
  FTotalSanitizer := -1.0;
  FTurbidity := false;
  FVolume := -1;
end;

function TPoolData.GetAlgae: string;
begin
  Result := FAlgae;
end;

function TPoolData.GetAlkalineDemand: single;
begin
  Result := FAlkalineDemand;
end;

function TPoolData.GetCalciumHardness: single;
begin
  Result := FCalciumHardness;
end;

function TPoolData.GetConstructionType: string;
begin
  Result := FConstructionType;
end;

function TPoolData.GetFreeSanitizer: single;
begin
  Result := FFreeSanitizer;
end;

function TPoolData.GetIsSpa: boolean;
begin
  Result := FIsSpa;
end;

function TPoolData.GetLocation: string;
begin
  Result := FLocation;
end;

function TPoolData.GetMetals: single;
begin
  Result := FMetals;
end;

function TPoolData.GetMSAUsed: boolean;
begin
  Result := FMSAUsed;
end;

function TPoolData.GetpH: single;
begin
  Result := FpH;
end;

function TPoolData.GetPhosphate: single;
begin
  Result := FPhosphate;
end;

function TPoolData.GetPoolType: string;
begin
  Result := FPoolType;
end;

function TPoolData.GetSalt: integer;
begin
  Result := FSalt;
end;

function TPoolData.GetSanitizer: string;
begin
  Result := FSanitizer;
end;

function TPoolData.GetSanitizerLvl: integer;
begin
  Result := FSanitizerLvl;
end;

function TPoolData.GetStabilizerLvl: single;
begin
  Result := FStabilizerLvl;
end;

function TPoolData.GetTDS: integer;
begin
  Result := FTDS;
end;

function TPoolData.GetTemperature: single;
begin
  Result := FTemperature;
end;

function TPoolData.GetTotalAlkaline: single;
begin
  Result := FTotalAlkaline;
end;

function TPoolData.GetTotalSanitizer: single;
begin
  Result := FTotalSanitizer;
end;

function TPoolData.GetTurbidity: boolean;
begin
  Result := FTurbidity;
end;

function TPoolData.GetVolume: integer;
begin
  Result := FVolume;
end;

procedure TPoolData.LoadFromDatabase(Const ClientName: string);
var
  qryTest: TMyQuery;
begin
  qryTest := TMyQuery.Create(nil);
  try
    qryTest.Options.FlatBuffers := True;
    //qryTest.Connection := fmPoolProfileTest.MyConnection;
    qryTest.Connection := GetSharedMyDacConnection;
    qryTest.SQL.Add('select *');
    qryTest.SQL.Add('from tblPoolProfile');
    qryTest.SQL.Add('where Client = "' + ClientName + '"');

    qryTest.Open;
    FConstructionType := qryTest.FieldByName('Construction').AsString;
    FLocation         := qryTest.FieldByName('Location').AsString;
    FMSAUsed          := (qryTest.FieldByName('UsesMSA').AsString = 'T');
    FSanitizer        := qryTest.FieldByName('Sanitizer').AsString;
    FSanitizerLvl     := qryTest.FieldByName('SaltRequired').AsInteger;
    FVolume           := qryTest.FieldByName('Volume').AsInteger;
    qryTest.Close;
  finally
    SysUtils.FreeAndNil(qryTest)
  end;
end;

procedure TPoolData.SaveToDatabase;
begin
end;

procedure TPoolData.SetAlgae(const Value: string);
begin
  FAlgae := Value;
end;

procedure TPoolData.SetAlkalineDemand(const Value: single);
begin
  FAlkalineDemand := Value;
end;

procedure TPoolData.SetCalciumHardness(const Value: single);
begin
  FCalciumHardness := Value;
end;

procedure TPoolData.SetConstructionType(const Value: string);
begin
  FConstructionType := Value;
end;

procedure TPoolData.SetFreeSanitizer(const Value: single);
begin
  FFreeSanitizer := Value;
end;

procedure TPoolData.SetIsSpa(const Value: boolean);
begin
  FIsSpa := Value;
end;

procedure TPoolData.SetLocation(const Value: string);
begin
  FLocation := Value;
end;

procedure TPoolData.SetMetals(const Value: single);
begin
  FMetals := Value;
end;

procedure TPoolData.SetMSAUsed(const Value: boolean);
begin
  FMSAUsed := Value;
end;

procedure TPoolData.SetpH(const Value: single);
begin
  FpH := Value;
end;

procedure TPoolData.SetPhosphate(const Value: single);
begin
  FPhosphate := Value;
end;

procedure TPoolData.SetPoolType(const Value: string);
begin
  FPoolType := Value;
end;

procedure TPoolData.SetSalt(const Value: integer);
begin
  FSalt := Value;
end;

procedure TPoolData.SetSanitizer(const Value: string);
begin
  FSanitizer := Value;
end;

procedure TPoolData.SetSanitizerLvl(const Value: integer);
begin
  FSanitizerLvl := Value;
end;

procedure TPoolData.SetStabilizerLvl(const Value: single);
begin
  FStabilizerLvl := Value;
end;

procedure TPoolData.SetTDS(const Value: integer);
begin
  FTDS := Value;
end;

procedure TPoolData.SetTemperature(const Value: single);
begin
  FTemperature := Value;
end;

procedure TPoolData.SetTotalAlkaline(const Value: single);
begin
  FTotalAlkaline := Value;
end;

procedure TPoolData.SetTotalSanitizer(const Value: single);
begin
  FTotalSanitizer := Value;
end;

procedure TPoolData.SetTurbidity(const Value: boolean);
begin
  FTurbidity := Value;
end;

procedure TPoolData.SetVolume(const Value: integer);
begin
  if Value > 0 then FVolume := Value;
end;

procedure TPoolData.Validate;
begin
  if (FAlgae = 'EMPTY') then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FAlkalineDemand = -1.0) then CommonLib.MessageDlgXP_Vista('Alkaline Algae type not chosen', mtError, [mbOK], 0);

  if (FCalciumHardness = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FConstructionType = 'EMPTY') then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FFreeSanitizer = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FLocation = 'EMPTY') then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FMetals = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FpH = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FPhosphate = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FPoolType = 'EMPTY') then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FSanitizer = 'EMPTY') then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FSanitizerLvl = -1) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FStabilizerLvl = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FTDS = -1) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FTemperature = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FTotalAlkaline = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FTotalSanitizer = -1.0) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);

  if (FVolume = -1) then CommonLib.MessageDlgXP_Vista('Algae type not chosen', mtError, [mbOK], 0);
end;

end.
