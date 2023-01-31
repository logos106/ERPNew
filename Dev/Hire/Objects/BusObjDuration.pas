unit BusObjDuration;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/02/16  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TDuration = class(TMSBusObj)
  private
    function GetDescription: string;
    function GetQty: Double;
    function GetDurationType: String;
    function GetActive: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetQty(const Value: Double);
    procedure SetDurationType(const Value: String);
    procedure SetActive(const Value: Boolean);
    function GetGraceDurationType: String;
    function GetGraceQty: double;
    function GetStepDurationType: String;
    function GetStepQty: double;
    procedure SetGraceDurationType(const Value: String);
    procedure SetGraceQty(const Value: double);
    procedure SetStepDurationType(const Value: String);
    procedure SetStepQty(const Value: double);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    Function DurationtypeDescription: String;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringField: string; Override;
  published
    property Description: string read GetDescription write SetDescription;
    property Qty: Double read GetQty write SetQty;
    property DurationType: String read GetDurationType write SetDurationType;
    property StepQty: double read GetStepQty write SetStepQty;
    property StepDurationType: String read GetStepDurationType write SetStepDurationType;
    property GraceQty: double read GetGraceQty write SetGraceQty;
    property GraceDurationType: String read GetGraceDurationType write SetGraceDurationType;
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

uses tcDataUtils, CommonLib, sysutils, dateutils;

{ TDuration }

constructor TDuration.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Duration';
  fSQL := 'SELECT * FROM tblduration';
end;

destructor TDuration.Destroy;
begin
  inherited;
end;

procedure TDuration.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Description');
  SetPropertyFromNode(node, 'Qty');
  SetPropertyFromNode(node, 'DurationType');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TDuration.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Qty', Qty);
  AddXMLNode(node, 'DurationType', DurationType);
  AddXMLNode(node, 'Active', Active);
end;

function TDuration.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Description = '' then begin
    AddResult(False, rssWarning, 0, 'Description should not be blank');
    Exit;
  end;
  if Qty = 0 then begin
    AddResult(False, rssWarning, 0, 'Duration should not be blank');
    Exit;
  end;
  if DurationType = '' then begin
    AddResult(False, rssWarning, 0, 'Duration type should not be blank');
    Exit;
  end;
  if not IsUnique(ID, 'Qty = ' + FloatTostr(Qty) + ' and Durationtype = ' + QuotedStr(DurationType))
  then begin
    self.AddResult(False, rssWarning, 0, 'Record already exists for Duration = ' + FloatTostr(Qty) +
      ' ' + QuotedStr(DurationtypeDescription));
    Exit;
  end;
  if (StepQty > 0) and (StepDurationType = '') then begin
    AddResult(False, rssWarning, 0, 'Step Duration type should not be blank');
    Exit;
  end;
  if (GraceQty > 0) and (StepDurationType = '') then begin
    AddResult(False, rssWarning, 0, 'Grace Duration type should not be blank');
    Exit;
  end;
  Result := True;
end;

function TDuration.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TDuration.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TDuration.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TDuration.DurationtypeDescription: String;
begin
  if DurationType = 'H' then
    Result := 'Hour(s)'
  else if DurationType = 'D' then
    Result := 'Day(s)'
  else if DurationType = 'W' then
    Result := 'Week(s)'
  else if DurationType = 'F' then
    Result := 'Fortnight(s)'
  else if DurationType = 'M' then
    Result := 'Month(s)'
  else if DurationType = 'Q' then
    Result := 'Quarter(s)'
  else if DurationType = 'Y' then
    Result := 'Year(s)'
  else
    Result := '';
end;

function TDuration.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TDuration.GetStepDurationType: String;
begin
  result := GetStringField('StepDurationType');
end;

function TDuration.GetStepQty: double;
begin
  result := GetFloatField('StepQty');
end;

class function TDuration.GetIDField: string;
begin
  Result := 'DurationId'
end;

class function TDuration.GetKeyStringField: string;
begin
  Result := 'Description';
end;

class function TDuration.GetBusObjectTablename: string;
begin
  Result := 'tblduration';
end;

function TDuration.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;
  Qty := 1;
  DurationType := 'H';
end;

function TDuration.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TDuration.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TDuration.GetQty: Double;
begin
  Result := GetFloatField('Qty');
end;

function TDuration.GetDurationType: string;
begin
  Result := GetStringField('DurationType');
end;

function TDuration.GetGraceDurationType: String;
begin
  result := GetStringField('GraceDurationType');
end;

function TDuration.GetGraceQty: double;
begin
  result := GetFloatField('GraceQty');
end;

function TDuration.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TDuration.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TDuration.SetQty(const Value: Double);
begin
  SetFloatField('Qty', Value);
end;

procedure TDuration.SetStepDurationType(const Value: String);
begin
  SetStringField('StepDurationType',Value);
end;

procedure TDuration.SetStepQty(const Value: double);
begin
  SetFloatField('StepQty',Value);
end;

procedure TDuration.SetDurationType(const Value: string);
begin
  SetStringField('DurationType', Value);
end;

procedure TDuration.SetGraceDurationType(const Value: String);
begin
  SetStringField('GraceDurationType',Value);
end;

procedure TDuration.SetGraceQty(const Value: double);
begin
  SetFloatField('GraceQty',Value);
end;

procedure TDuration.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

initialization

RegisterClass(TDuration);

end.
