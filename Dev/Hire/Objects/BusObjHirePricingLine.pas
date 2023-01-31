unit BusObjHirePricingLine;

interface

uses
  BusObjBase, DB, XMLIntf, Classes, BusObjConst, ERPDbComponents, MyAccess;

type

  THirePricingLine = class(TMSBusObj)
  private
    function GetAssetHireID: Integer;
    function GetDurationID: Integer;
    function GetDurationName: string;
    function GetRate: Double;
    function GetActive: Boolean;
  protected
    procedure SetAssetHireID(const Value: Integer); Virtual;
    procedure SetDurationID(const Value: Integer); Virtual;
    procedure SetDurationName(const Value: string); Virtual;
    procedure SetRate(const Value: Double); Virtual;
    procedure SetActive(const Value: Boolean); Virtual;

    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    procedure OnBeforeDataIdChange; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function DurationIdListForAsset(aAssetId: integer; Conn: TCustomMyConnection = nil): string;
    class function RateForAssetAndDuration(aAssetId, aDurationId: integer;  Conn: TCustomMyConnection = nil): double;
  published
    property AssetHireID: Integer read GetAssetHireID write SetAssetHireID;
    property DurationID: Integer read GetDurationID write SetDurationID;
    property DurationName: string read GetDurationName write SetDurationName;
    property Rate: Double read GetRate write SetRate;
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

uses
  SysUtils, BusObjAssetHire, BusObjDuration, DbSharedObjectsObj, CommonDbLib,
  BusObjFixedAsset;

{ THirePricingLine }

constructor THirePricingLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'HirePricing';
  fSQL := 'SELECT * FROM tblhirepricingLines';
end;

destructor THirePricingLine.Destroy;
begin
  inherited;
end;

procedure THirePricingLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AssetHireID');
  SetPropertyFromNode(node, 'DurationID');
  SetPropertyFromNode(node, 'DurationName');
  SetPropertyFromNode(node, 'Rate');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure THirePricingLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AssetHireID', AssetHireID);
  AddXMLNode(node, 'DurationID', DurationID);
  AddXMLNode(node, 'DurationName', DurationName);
  AddXMLNode(node, 'Rate', Rate);
  AddXMLNode(node, 'Active', Active);
end;

function THirePricingLine.ValidateData: Boolean;
var
  msg: string;
begin
  PostDB;
  if self.Count = 0 then begin
    result := true;
    exit;
  end;
  result := False;
  Resultstatus.Clear;
  if not IsUnique(ID, 'AssetHireId = ' + inttostr(AssetHireID) + ' and ' + ' DurationID = ' +
    inttostr(DurationID), self.connection.connection) then begin
    msg := 'A Hire Pricing Record already exists For this Duration.';
    if Assigned(Owner) and (Owner is TAssetHire) and Assigned(Owner.Owner) and (Owner.Owner is TFixedAssets) then begin
      msg := msg + ' Asset Name "' + TFixedAssets(Owner.Owner).AssetName + '" Asset Code "' + TFixedAssets(Owner.Owner).AssetCode +
      '"' + #13#10 + 'Please Correct this in the Hire Section of the Fixed Asset Form.';
    end;
    AddResult(False, rssWarning, BOR_General_Err,msg);
    Exit;
  end;
  if Rate = 0 then begin
    msg := 'Rate should not be blank.';
    if Assigned(Owner) and (Owner is TAssetHire) and Assigned(Owner.Owner) and (Owner.Owner is TFixedAssets) then begin
      msg := msg + ' Asset Name "' + TFixedAssets(Owner.Owner).AssetName + '" Asset Code "' + TFixedAssets(Owner.Owner).AssetCode +
      '"';
    end;
    msg := msg + ' Duration "' + self.DurationName + '"' +
    #13#10 + 'Please Correct this in the Hire Section of the Fixed Asset Form.';
    AddResult(False, rssWarning, 0, msg);
    Exit;
  end;
  result := True;
end;

function THirePricingLine.Save: Boolean;
begin
  PostDb;
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure THirePricingLine.OnBeforeDataIdChange;
begin
  inherited;
end;

procedure THirePricingLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

class function THirePricingLine.RateForAssetAndDuration(aAssetId,
  aDurationId: integer; Conn: TCustomMyConnection): double;
var
  qry: TERPQuery;
begin
  result := 0;
  if (aDurationId = 0) or (aAssetId = 0) then exit;
  
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select Rate from tblhirepricinglines');
    qry.SQL.Add('inner join tblassethire on tblassethire.AssetHireId = tblhirepricinglines.AssetHireId');
    qry.SQL.Add('where tblassethire.AssetId = ' + IntToStr(aAssetId));
    qry.SQL.Add('and tblhirepricinglines.DurationId = ' + IntToStr(aDurationId));
    qry.SQL.Add('and tblhirepricinglines.Active = "T"');
    qry.SQL.Add('and tblassethire.Active = "T"');
    qry.Open;
    result := qry.FieldByName('Rate').AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure THirePricingLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then
      Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.FieldName, 'DurationName') then begin
    DurationID := TDuration.IDToggle(DurationName);
  end
  else if SysUtils.SameText(Sender.FieldName, 'DurationID') then begin
    DurationName := TDuration.IDToggle(DurationID);
  end;

end;

class function THirePricingLine.DurationIdListForAsset(aAssetId: integer;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  result := '';
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select DurationId from tblhirepricinglines');
    qry.SQL.Add('inner join tblassethire on tblassethire.AssetHireId = tblhirepricinglines.AssetHireId');
    qry.SQL.Add('where tblassethire.AssetId = ' + IntToStr(aAssetId));
    qry.SQL.Add('and tblhirepricinglines.Active = "T"');
    qry.SQL.Add('and tblassethire.Active = "T"');
    qry.Open;
    while not qry.Eof do begin
      if result <> '' then result := result + ',';
      result := result + IntToStr(qry.FieldByName('DurationId').AsInteger);
      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function THirePricingLine.GetSQL: string;
begin
  REsult := inherited GetSQL;
end;

class function THirePricingLine.GetIDField: string;
begin
  REsult := 'HirePriceLineID'
end;

class function THirePricingLine.GetBusObjectTablename: string;
begin
  REsult := 'tblhirepricingLines';
end;

function THirePricingLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not REsult then
    Exit;
  Active := True;
  if Assigned(Owner) then
    if Owner is TAssetHire then begin
      AssetHireID := TAssetHire(Owner).ID;
    end;
end;

function THirePricingLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

function THirePricingLine.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not REsult then
    Exit;
end;

function THirePricingLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  if (DurationName = '') and (Rate = 0) then begin
//    result := false;
    CancelDb;
    Abort;
  end;

  result := inherited DoBeforePost(Sender);
  if not result then
    Exit;
  // if not(ValidateData) then abort;

end;

{ Property Functions }
function THirePricingLine.GetAssetHireID: Integer;
begin
  REsult := GetIntegerField('AssetHireID');
end;

function THirePricingLine.GetDurationID: Integer;
begin
  REsult := GetIntegerField('DurationID');
end;

function THirePricingLine.GetDurationName: string;
begin
  REsult := GetStringField('DurationName');
end;

function THirePricingLine.GetRate: Double;
begin
  REsult := GetFloatField('Rate');
end;

function THirePricingLine.GetActive: Boolean;
begin
  REsult := GetBooleanField('Active');
end;

procedure THirePricingLine.SetAssetHireID(const Value: Integer);
begin
  SetIntegerField('AssetHireID', Value);
end;

procedure THirePricingLine.SetDurationID(const Value: Integer);
begin
  SetIntegerField('DurationID', Value);
end;

procedure THirePricingLine.SetDurationName(const Value: string);
begin
  SetStringField('DurationName', Value);
end;

procedure THirePricingLine.SetRate(const Value: Double);
begin
  SetFloatField('Rate', Value);
end;

procedure THirePricingLine.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

end.
