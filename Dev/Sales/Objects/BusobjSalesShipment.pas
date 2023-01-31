unit BusobjSalesShipment;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/03/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSalesLinesShipments = class(TMSBusObj)
  private
    function GetShipAddressID       : Integer   ;
    function GetSaleID              : Integer   ;
    function GetSaleLineID          : Integer   ;
    function GetUOMQty              : Double    ;
    procedure SetShipAddressID       (const Value: Integer   );
    procedure SetSaleID              (const Value: Integer   );
    procedure SetSaleLineID          (const Value: Integer   );
    procedure SetUOMQty              (const Value: Double    );
    function getShipAddressName: String;
    function getShipmentStatus: String;
    procedure setShipAddressName(const Value: String);
    procedure setShipmentStatus(const Value: String);
    function getTotalQtyShippedtoAddressesExthis: Double;
    function getTotalSalesShippedQty: double;
    function getActive: Boolean;
    procedure setActive(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property     TotalSalesShippedQty :double read getTotalSalesShippedQty;
    Property     TotalQtyShippedtoAddressesExthis :Double read getTotalQtyShippedtoAddressesExthis;
  published
    property ShipAddressID        :Integer     read GetShipAddressID      write SetShipAddressID   ;
    property SaleID               :Integer     read GetSaleID             write SetSaleID          ;
    property SaleLineID           :Integer     read GetSaleLineID         write SetSaleLineID      ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    Property ShipAddressName      :String      read getShipAddressName    write setShipAddressName ;
    Property ShipmentStatus       :String      read getShipmentStatus     write setShipmentStatus  ;
    Property Active               :Boolean     read getActive             write setActive;
  end;

implementation

uses tcDataUtils, CommonLib, sysutils, BusObjSales, BusObjConst;

  {TSalesLinesShipments}

constructor TSalesLinesShipments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesLinesShipments';
  fSQL := 'SELECT * FROM tblsaleslinesshipments';
end;


destructor TSalesLinesShipments.Destroy;
begin
  inherited;
end;


procedure TSalesLinesShipments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ShipAddressID');
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'SaleLineID');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'ShipAddressName');
  SetPropertyFromNode(node,'ShipmentStatus');
  SetBooleanPropertyFromNode(node,'Active');

end;


procedure TSalesLinesShipments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ShipAddressID' ,ShipAddressID);
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'SaleLineID' ,SaleLineID);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'ShipAddressName' ,ShipAddressName);
  AddXMLNode(node,'ShipmentStatus' ,ShipmentStatus);
  AddXMLNode(node,'Active' ,Active);
end;


procedure TSalesLinesShipments.setActive(const Value: Boolean);begin  SetBooleanfield('Active', Value);end;

function TSalesLinesShipments.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sale / Product should not be blank' , False );
    Exit;
  end;
  if SaleLineID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sale / Product should not be blank' , False );
    Exit;
  end;
  if ShipAddressID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Address should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesLinesShipments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesLinesShipments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesLinesShipments.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;


function TSalesLinesShipments.getActive: Boolean;begin  Result := GetBooleanField('Active');end;

function TSalesLinesShipments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TSalesLinesShipments.getTotalQtyShippedtoAddressesExthis: Double;
begin
  result := 0;
  if Assigned(Owner) then
    if owner is TSalesline then
        result:= TSalesline(Owner).TotalQtyShippedtoAddresses[ID];
end;

function TSalesLinesShipments.getTotalSalesShippedQty: double;
begin
  result := 0;
  if Assigned(Owner) then
    if owner is TSalesline then
      result:= TSalesline(Owner).UOMQtyShipped;
end;

class function TSalesLinesShipments.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesLinesShipments.GetBusObjectTablename: string;
begin
  Result:= 'tblsaleslinesshipments';
end;


function TSalesLinesShipments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if assigned(Owner) then
    if owner is TSalesline then begin
      SaleId    := TSalesline(owner).SaleId;
      SalelineId:= TSalesline(owner).ID;
    end;
  ShipmentStatus := 'N';
end;

function TSalesLinesShipments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  SendEvent(BusobjEvent_Event, BusObjEventDataset_AfterPost, Self);
end;


function TSalesLinesShipments.DoBeforePost(Sender: TDatasetBusObj): Boolean;
var
  fd:Double;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  fd:= TotalQtyShippedtoAddressesExthis;
  if fd + UOMQty > TotalSalesShippedQty then
    UOMQty :=  TotalSalesShippedQty - fd;
end;

{Property Functions}
function  TSalesLinesShipments.GetShipAddressID   : Integer   ; begin Result := GetIntegerField('ShipAddressID');end;
function  TSalesLinesShipments.getShipAddressName : String;begin  REsult := getStringfield('ShipAddressName');end;
function  TSalesLinesShipments.getShipmentStatus  : String;begin  REsult := getStringfield('ShipmentStatus');end;
function  TSalesLinesShipments.GetSaleID          : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TSalesLinesShipments.GetSaleLineID      : Integer   ; begin Result := GetIntegerField('SaleLineID');end;
function  TSalesLinesShipments.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
procedure TSalesLinesShipments.SetShipAddressID   (const Value: Integer   ); begin SetIntegerField('ShipAddressID'    , Value);end;
procedure TSalesLinesShipments.setShipAddressName (const Value: String);begin  SetStringfield('ShipAddressName' , Value);end;
procedure TSalesLinesShipments.setShipmentStatus  (const Value: String);begin  SetStringfield('ShipmentStatus' , Value);end;
procedure TSalesLinesShipments.SetSaleID          (const Value: Integer   ); begin SetIntegerField('SaleID'           , Value);end;
procedure TSalesLinesShipments.SetSaleLineID      (const Value: Integer   ); begin SetIntegerField('SaleLineID'       , Value);end;
procedure TSalesLinesShipments.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'           , Value);end;


initialization
  RegisterClass(TSalesLinesShipments);

end.

