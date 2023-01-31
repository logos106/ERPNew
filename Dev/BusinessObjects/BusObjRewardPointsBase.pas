unit BusObjRewardPointsBase;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type

  TRewardPointsBase = class(TMSBusObj)
  private
    function GetActive: Boolean;
    function GetClientID: Integer;
    procedure SetActive(const Value: Boolean);
    procedure SetClientID(const Value: Integer);
    function GetPoints: double;
    function GetValuePerPoint: double;
    procedure SetPoints(const Value: double);
    procedure SetValuePerPoint(const Value: double);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
  published
    property Active: Boolean read GetActive write SetActive;
    property ClientID: Integer read GetClientID write SetClientID;
    property ValuePerPoint: double read GetValuePerPoint write SetValuePerPoint;
    property Points: double read GetPoints write SetPoints;
  end;

implementation

uses
  BusObjSaleBase, BusObjClient;

{ TRewardPointsBase }

constructor TRewardPointsBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblsaleslinespoints';
end;

function TRewardPointsBase.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  if Assigned(Owner) then begin
    if Self.Owner is TSalesBase then begin
      ClientID := TSalesBase(Owner).CustomerID;
    end
    else if Self.Owner is TClient then begin
      ClientID := TClient(Owner).ID;
    end;
  end;
  Active := True;
end;

function TRewardPointsBase.GetActive: Boolean;
begin
  result := GetBooleanField('Active');
end;

class function TRewardPointsBase.GetBusObjectTablename: string;
begin
  result := 'tblsaleslinespoints';
end;

function TRewardPointsBase.GetClientID: Integer;
begin
  result := GetIntegerField('clientID');
end;

class function TRewardPointsBase.GetIDField: string;
begin
  result := 'SalesLinesPointsId'
end;

function TRewardPointsBase.GetPoints: double;
begin
  result := GetFloatField('LinePoints');
end;

function TRewardPointsBase.GetValuePerPoint: double;
begin
  result := GetFloatField('ValueforRewardPoint');
end;

procedure TRewardPointsBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'ClientID');
  SetPropertyFromNode(node, 'ValuePerPoint');
  SetPropertyFromNode(node, 'Points');
end;

procedure TRewardPointsBase.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'clientID', ClientID);
  AddXMLNode(node, 'ValuePerPoint', ValuePerPoint);
  AddXMLNode(node, 'Points', Points);
end;

procedure TRewardPointsBase.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TRewardPointsBase.SetClientID(const Value: Integer);
begin
  SetIntegerField('clientID', Value);
end;

procedure TRewardPointsBase.SetPoints(const Value: double);
begin
  SetFloatField('LinePoints', Value);
end;

procedure TRewardPointsBase.SetValuePerPoint(const Value: double);
begin
  SetFloatField('ValueforRewardPoint', Value);
end;

function TRewardPointsBase.ValidateData: Boolean;
begin
  result := inherited;
  if not result then
    exit;
  if ClientID = 0 then begin
    AddResult(False, rssWarning, 0, 'Client should not be blank');
    exit;
  end;
  result := true;
end;

end.
