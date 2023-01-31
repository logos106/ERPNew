unit BusObjStateFreight;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;

type

  TStateFreight = class(TMSBusObj)
  private
    function GetActive: boolean;
    function GetFixedAmount: double;
    function GetPercent: double;
    function GetRegion: string;
    function GetRegionID: integer;
    function GetState: string;
    procedure SetActive(const Value: boolean);
    procedure SetFixedAmount(const Value: double);
    procedure SetPercent(const Value: double);
    procedure SetRegion(const Value: string);
    procedure SetRegionID(const Value: integer);
    procedure SetState(const Value: string);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function GetFreightForState(const aState: string; const aTotalInc: double;
      var FreightValue: double; var FreightDesc: string): boolean;
    class function FreightForState(const aState: string; const aTotalInc: double;
      var FreightValue: double; var FreightDesc: string;
      Conn: TCustomMyConnection = nil): boolean;
  published
    property State: string read GetState write SetState;
    property Percent: double read GetPercent write SetPercent;
    property FixedAmount: double read GetFixedAmount write SetFixedAmount;
    property RegionID: integer read GetRegionID write SetRegionID;
    property Region: string read GetRegion write SetRegion;
    property Active: boolean read GetActive write SetActive;
  end;

implementation

uses
  BusObjRegionalOptions, SysUtils, ERPDbComponents, DbSharedObjectsObj,
  AppEnvironment, CommonDbLib, CommonLib;

{ TStateFreight }

constructor TStateFreight.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'StateFreight';
  fSQL := 'SELECT * FROM tblstatefreight';
  ExportExcludeList.Add('regionid');
end;

destructor TStateFreight.Destroy;
begin

  inherited;
end;

function TStateFreight.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  RegionID := AppEnv.RegionalOptions.ID;
end;

class function TStateFreight.FreightForState(const aState: string;
  const aTotalInc: double; var FreightValue: double; var FreightDesc: string;
  Conn: TCustomMyConnection): boolean;
var
  sf: TStateFreight;
begin
  sf := TStateFreight.CreateWithNewConn(nil);
  try
    if Assigned(Conn) then begin
      sf.Connection.Connection := Conn;
    end
    else begin
      sf.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    end;
    sf.LoadSelect('RegionID = ' + IntToStr(Appenv.RegionalOptions.ID));
    result := sf.GetFreightForState(aState,aTotalInc,FreightValue,FreightDesc);
  finally
    sf.Free;
  end;
end;

function TStateFreight.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TStateFreight.GetBusObjectTablename: string;
begin
  result := 'tblstatefreight';
end;

function TStateFreight.GetFixedAmount: double;
begin
  result := GetFloatField('FixedAmount');
end;

function TStateFreight.GetFreightForState(const aState: string;
  const aTotalInc: double; var FreightValue: double;
  var FreightDesc: string): boolean;
begin
  FreightValue := 0;
  FreightDesc := '';
  result := self.Locate('State',aState,[loCaseInsensitive]);
  if result then begin
    if Percent > 0 then begin
      FreightValue := Round(aTotalInc * (Percent / 100),CurrencyRoundPlaces);
      FreightDesc := FloatToStr(Percent) + '%';
    end;
    if FixedAmount > 0 then begin
      FreightValue := FreightValue + FixedAmount;
      if FreightDesc <> '' then FreightDesc := FreightDesc + ' plus ';
      FreightDesc := FreightDesc + FloatToStrF(FixedAmount,ffCurrency,15,CurrencyRoundPlaces);
    end;
    FreightDesc := 'Freight ' + FreightDesc;
  end;
end;

class function TStateFreight.GetIDField: string;
begin
  result := 'ID';
end;

function TStateFreight.GetPercent: double;
begin
  result := GetFloatField('Percent');
end;

function TStateFreight.GetRegion: string;
begin
  result := TRegionalOptions.IDToggle(RegionID, Connection.Connection);
end;

function TStateFreight.GetRegionID: integer;
begin
  result := GetIntegerField('RegionID');
end;

function TStateFreight.GetState: string;
begin
  result := GetStringField('State');
end;

procedure TStateFreight.LoadFromXMLNode(const node: IXMLNode);
begin
  SetPropertyFromNode(node, 'State');
  SetPropertyFromNode(node, 'Percent');
  SetPropertyFromNode(node, 'FixedAmount');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'RegionID');
end;

function TStateFreight.Save: Boolean;
begin
  Result := False;
  ResultStatus.Clear;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TStateFreight.SaveToXMLNode(const node: IXMLNode);
begin
  AddXMLNode(node, 'State', State);
  AddXMLNode(node, 'Percent', State);
  AddXMLNode(node, 'FixedAmount', FixedAmount);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'RegionID', RegionID);
end;

procedure TStateFreight.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TStateFreight.SetFixedAmount(const Value: double);
begin
  SetFloatField('FixedAmount', Value);
end;

procedure TStateFreight.SetPercent(const Value: double);
begin
  SetFloatField('Percent', Value);
end;

procedure TStateFreight.SetRegion(const Value: string);
begin
  RegionID := TRegionalOptions.IDToggle(Value, Connection.Connection);
end;

procedure TStateFreight.SetRegionID(const Value: integer);
begin
  SetIntegerField('RegionID', Value);
end;

procedure TStateFreight.SetState(const Value: string);
begin
  SetStringField('Sate', Value);
end;

function TStateFreight.ValidateData: Boolean;
var
  qry: TERPQuery;
  msg: string;
begin
  self.PostDb;
  result := false;
  if Trim(State) = '' then begin
    AddResult(false,rssWarning,0,'State is Blank');
    exit;
  end;
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    qry.SQL.Add('select * from ' + self.GetBusObjectTablename);
    qry.SQL.Add('where ID <> ' + IntToStr(self.ID));
    qry.SQL.Add('and State = ' + QuotedStr(State));
    qry.Open;
    if not qry.IsEmpty then begin
      if qry.FieldByName('Active').AsBoolean then
        msg := 'There is already an existing record for State "' + State + '".'
      else
        msg := 'There is already an existing Inactive record for State "' + State + '", please make this record active.';

      AddResult(false,rssWarning,0,msg);
      exit;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  result := true;
end;

end.
