unit BusObjSalesRedeemPoints;

interface

uses
  BusObjBase, DB, MyAccess, Classes, XMLDoc, XMLIntf;

type

  TSalesRedeemPoints = class(TMSBusObj)
  private
    function GetSalesLinesPointsId         : Integer   ;
    function GetUsedPoints                 : Double    ;
    function GetSaleID                     : Integer   ;
    function GetRedeemAmount               : Double    ;
    function GetActive                     : Boolean   ;
    procedure SetSalesLinesPointsId         (const Value: Integer   );
    procedure SetUsedPoints                 (const Value: Double    );
    procedure SetSaleID                     (const Value: Integer   );
    procedure SetRedeemAmount               (const Value: Double    );
    procedure SetActive                     (const Value: Boolean   );
    function getValueforRewardPoints: Double;
    procedure SetValueforRewardPoints(const Value: Double);
    function getPointsfromSaleId: Integer;
    function getPointsFromSalelineId: Integer;
    function GetProductID: Integer;
    function getProductName: String;
    procedure setPointsfromSaleId(const Value: Integer);
    procedure setPointsFromSalelineId(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    procedure setProductName(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function OpeneningBalanceRedeemedPoints(const aClientId: integer;  Conn: TCustomMyConnection = nil): double;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property SalesLinesPointsId          :Integer     read GetSalesLinesPointsId        write SetSalesLinesPointsId     ;
    property UsedPoints                  :Double      read GetUsedPoints                write SetUsedPoints             ;
    property SaleID                      :Integer     read GetSaleID                    write SetSaleID                 ;
    property RedeemAmount                :Double      read GetRedeemAmount              write SetRedeemAmount           ;
    Property PointsfromSaleId            :Integer     read getPointsfromSaleId          Write setPointsfromSaleId;
    Property PointsFromSalelineId        :Integer     Read getPointsFromSalelineId      Write setPointsFromSalelineId;
    Property ProductId                   :Integer     Read GetProductID                 Write SetProductID;
    Property ProductName                 :String      Read getProductName               Write setProductName;

    Property ValueforRewardPoints        :Double      read getValueforRewardPoints      Write SetValueforRewardPoints;
    property Active                      :Boolean     read GetActive                    write SetActive                 ;
  end;

implementation

uses
  Sysutils, CommonDbLib;

{TSalesRedeemPoints}

constructor TSalesRedeemPoints.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesLinesRedeemPoints';
  fSQL := 'SELECT * FROM tblsalesRedeemPoints';
end;


destructor TSalesRedeemPoints.Destroy;
begin
  inherited;
end;


procedure TSalesRedeemPoints.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SalesLinesPointsId');
  SetPropertyFromNode(node,'UsedPoints');
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'RedeemAmount');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSalesRedeemPoints.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SalesLinesPointsId' ,SalesLinesPointsId);
  AddXMLNode(node,'UsedPoints' ,UsedPoints);
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'RedeemAmount' ,RedeemAmount);
  AddXMLNode(node,'Active' ,Active);
end;


function TSalesRedeemPoints.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if UsedPoints = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UsedPoints should not be 0' , False );
    Exit;
  end;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesRedeemPoints.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesRedeemPoints.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesRedeemPoints.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName , 'UsedPoints') then begin
      RedeemAmount := UsedPoints * ValueforRewardPoints;
    end;
end;


function TSalesRedeemPoints.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesRedeemPoints.GetIDField: string;
begin
  Result := 'SaleslinesRedeemPointID'
end;


class function TSalesRedeemPoints.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesRedeemPoints';
end;


function TSalesRedeemPoints.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSalesRedeemPoints.GetSalesLinesPointsId     : Integer   ; begin Result := GetIntegerField('SalesLinesPointsId');end;
function  TSalesRedeemPoints.GetUsedPoints             : Double    ; begin Result := GetFloatField('UsedPoints');end;
function  TSalesRedeemPoints.GetSaleID                 : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TSalesRedeemPoints.GetRedeemAmount           : Double    ; begin Result := GetFloatField('RedeemAmount');end;
function  TSalesRedeemPoints.GetActive                 : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TSalesRedeemPoints.getValueforRewardPoints   : Double    ; begin result := GetFloatField('ValueforRewardPoints');end;
function TSalesRedeemPoints.getPointsfromSaleId: Integer;begin   result := GetIntegerField('PointsfromSaleId');end;
function TSalesRedeemPoints.getPointsFromSalelineId: Integer;begin   Result := GetIntegerField('PointsFromSalelineId');end;
function TSalesRedeemPoints.GetProductID: Integer;begin  result := GetIntegerField('ProductId');end;
function TSalesRedeemPoints.getProductName: String;begin   Result := GetStringField('ProductName');end;
procedure TSalesRedeemPoints.setPointsfromSaleId(const Value: Integer);begin  SetIntegerField('PointsfromSaleId' , value);end;
procedure TSalesRedeemPoints.setPointsFromSalelineId(const Value: Integer);begin  SetIntegerField('PointsFromSalelineId' , value);end;
procedure TSalesRedeemPoints.SetProductID(const Value: Integer);begin  SetIntegerField('ProductId' , value);end;
procedure TSalesRedeemPoints.setProductName(const Value: String);begin  SetStringField('Productname' , Value);end;
procedure TSalesRedeemPoints.SetValueforRewardPoints   (const Value: Double); begin   SetFloatField('ValueforRewardPoints' , Value);end;
procedure TSalesRedeemPoints.SetSalesLinesPointsId     (const Value: Integer   ); begin SetIntegerField('SalesLinesPointsId'      , Value);end;
procedure TSalesRedeemPoints.SetUsedPoints             (const Value: Double    ); begin SetFloatField('UsedPoints'              , Value);end;
procedure TSalesRedeemPoints.SetSaleID                 (const Value: Integer   ); begin SetIntegerField('SaleID'                  , Value);end;
procedure TSalesRedeemPoints.SetRedeemAmount           (const Value: Double    ); begin SetFloatField('RedeemAmount'            , Value);end;
procedure TSalesRedeemPoints.SetActive                 (const Value: Boolean   ); begin SetBooleanField('Active'                  , Value);end;

class function TSalesRedeemPoints.OpeneningBalanceRedeemedPoints(
  const aClientId: integer; Conn: TCustomMyConnection): double;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select sum(srp.UsedPoints) as OpeningUsedPoints');
    qry.SQL.Add('from tblsalesredeempoints srp, tblsaleslinespoints slp');
    qry.SQL.Add('where srp.SalesLinesPointsID = slp.SalesLinesPointsID');
    qry.SQL.Add('and srp.Active = "T"');
    qry.SQL.Add('and slp.ClientID = ' + IntToStr(aClientID));
    qry.SQL.Add('and slp.Active = "T" and slp.IsOpeningBalance = "T"');
    qry.Open;
    result:= qry.FieldByName('OpeningUsedPoints').AsFloat;
  finally
    qry.Free;
  end;
end;

function TSalesRedeemPoints.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  (*ValueforRewardPoints := appenv.CompanyPrefs.ValueforRewardPoints;*)
end;

initialization
  RegisterClass(TSalesRedeemPoints);


end.
