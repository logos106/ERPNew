unit BusObjPosEop;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TPosEop = class(TMSBusObj)
  private
    function GetStartDate: TDateTime;
    function GetEndDate: TDateTime;
    function GetTillID: Integer;
    function GetTillName: string;
    procedure SetStartDate(const Value: TDateTime);
    procedure SetEndDate(const Value: TDateTime);
    procedure SetTillID(const Value: Integer);
    procedure SetTillName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
  published
    property StartDate: TDateTime read GetStartDate write SetStartDate;
    property EndDate: TDateTime read GetEndDate write SetEndDate;
    property TillID: Integer read GetTillID write SetTillID;
    property TillName: string read GetTillName write SetTillName;
  end;

implementation

uses tcDataUtils, CommonLib, SysUtils, BusObjPosTill, BusObjSchemaLib;

{ TPosEop }

constructor TPosEop.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PosEop';
  fSQL := 'SELECT * FROM tblposeop';
end;

destructor TPosEop.Destroy;
begin
  inherited;
end;

procedure TPosEop.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node, 'StartDate');
  SetDateTimePropertyFromNode(node, 'EndDate');
  SetPropertyFromNode(node, 'TillID');
  SetPropertyFromNode(node, 'msUpdateSiteCode');
end;

procedure TPosEop.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'StartDate', StartDate);
  AddXMLNode(node, 'EndDate', EndDate);
  AddXMLNode(node, 'TillID', TillID);
  AddXMLNode(node, 'msUpdateSiteCode', msUpdateSiteCode);
end;

function TPosEop.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if (TillID < 1) then begin
    AddResult(false,rssWArning,0,'Till Name not found');
    exit;
  end;
  if (TillID = 0) then begin
    AddResult(false,rssWArning,0,'Till ID blank');
    exit;
  end;
  if StartDate = 0 then begin
    AddResult(false,rssWArning,0,'Start Date is blank');
    exit;
  end;
  if EndDate = 0 then begin
    AddResult(false,rssWArning,0,'End Date is blank');
    exit;
  end;
  if EndDate < StartDate then begin
    AddResult(false,rssWArning,0,'Start Date is greater than End Date');
    exit;
  end;
  Result := True;
end;

class function TPosEop._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(result,'TPosTill','TillObj','TillID','ID');
end;

function TPosEop.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TPosEop.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPosEop.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit;
  inherited;
end;

function TPosEop.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPosEop.GetIDField: string;
begin
  Result := 'PeriodID'
end;

class function TPosEop.GetBusObjectTablename: string;
begin
  Result := 'tblposeop';
end;

function TPosEop.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TPosEop.GetStartDate: TDateTime;
begin
  Result := GetDateTimeField('StartDate');
end;

function TPosEop.GetEndDate: TDateTime;
begin
  Result := GetDateTimeField('EndDate');
end;

function TPosEop.GetTillID: Integer;
begin
  Result := GetIntegerField('TillID');
end;

function TPosEop.GetTillName: string;
begin
  Result := TPosTill.IDToggle(TillId,Connection.Connection);
end;

procedure TPosEop.SetStartDate(const Value: TDateTime);
begin
  SetDateTimeField('StartDate', Value);
end;

procedure TPosEop.SetEndDate(const Value: TDateTime);
begin
  SetDateTimeField('EndDate', Value);
end;

procedure TPosEop.SetTillID(const Value: Integer);
begin
  SetIntegerField('TillID', Value);
end;

procedure TPosEop.SetTillName(const Value: string);
begin
  if Trim(Value) <> '' then begin
    TillId := TPosTill.IDToggle(Value,Connection.Connection);
    if TillId = 0 then
      TillId := -1;
  end
  else
    TillId := 0;
end;

initialization

RegisterClass(TPosEop);

end.
