unit BusObjShipContainerDetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/07/08  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf,IntegerListObj;


type
  TShipContainerDetails = class ;

  TShipContainerEvent  = procedure(const Sender: TShipContainerDetails; const EventType, Value: string) of object;

  TShipContainerDetails = class(TMSBusObj)
  private
    fOnContainerChange: TShipContainerEvent;
    fAuxilaryBillIDList: TIntegerList;
    fSettingPercentages:Boolean;
    fbNegativeDetected:Boolean;
    function GetShippingContainerID      : Integer   ;
    function GetCommercialInvNo          : string    ;
    function GetSupplierWorkOrderNo      : string    ;
    function GetPOLineID      : Integer   ;

    function GetTotalAuxilaryCosts        :double;
    function GetAuxilaryCostsPercentage   :double;
    function GetAuxilaryCostsPerItem      :double;
 
    procedure SetShippingContainerID      (const Value: Integer   );
    procedure SetCommercialInvNo          (const Value: string    );
    procedure SetSupplierWorkOrderNo      (const Value: string    );
    procedure SetPOLineID                 (const Value: Integer   );
    procedure SetTotalAuxilaryCosts       (const Value: double    );
    procedure SetAuxilaryCostsPercentage  (const Value: double    );
    procedure SetAuxilaryCostsPerItem     (const Value: double    );
    procedure RecalcPercentages(xPurchaseLineID:integer);
    procedure ModifyPercentages;
    Function RecalcPerItems(xPurchaseLineID:integer):Boolean;
    function getQtySold: double;
    function getreceivedqty: Double;
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
    property OnContainerChange: TShipContainerEvent read fOnContainerChange write fOnContainerChange;
    Property QtySold :Double read getQtySold;
    Property Receivedqty :Double Read getreceivedqty;
  published
    property ShippingContainerID        :Integer     read GetShippingContainerID     write SetShippingContainerID  ;
    property CommercialInvNo            :string      read GetCommercialInvNo         write SetCommercialInvNo      ;
    property SupplierWorkOrderNo        :string      read GetSupplierWorkOrderNo     write SetSupplierWorkOrderNo  ;
    property PurchaseLineID             :Integer     read GetPOLineID                write SetPOlineID;

    property TotalAuxilaryCosts         :double read GetTotalAuxilaryCosts      write SetTotalAuxilaryCosts;
    property AuxilaryCostsPercentage    :double read GetAuxilaryCostsPercentage write SetAuxilaryCostsPercentage;
    property AuxilaryCostsPerItem       :double read GetAuxilaryCostsPerItem    write SetAuxilaryCostsPerItem;

    property AuxilaryBillIDList: TIntegerList read fAuxilaryBillIDList write fAuxilaryBillIDList;
    property UserDataError: Boolean read fbNegativeDetected ;
  end;

implementation


uses tcDataUtils, CommonLib,BusObjShippingContainer, CommonDBLib,
    MyAccess,ERPdbComponents,SysUtils,Dialogs,DecimalRounding;


  {TShipContainerDetails}

constructor TShipContainerDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ShipContainerDetails';
  fSQL := 'SELECT * FROM tblshipcontainerdetails';
  fAuxilaryBillIDList:= TIntegerList.Create;
end;


destructor TShipContainerDetails.Destroy;
begin
  inherited;
  fAuxilaryBillIDList.Free; 
end;


procedure TShipContainerDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ShippingContainerID');
  SetPropertyFromNode(node,'CommercialInvNo');
  SetPropertyFromNode(node,'SupplierWorkOrderNo');

  SetPropertyFromNode(node,'TotalAuxilaryCosts');
  SetPropertyFromNode(node,'AuxilaryCostsPercentage');
  SetPropertyFromNode(node,'AuxilaryCostsPerItem');
end;


procedure TShipContainerDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ShippingContainerID' ,ShippingContainerID);
  AddXMLNode(node,'CommercialInvNo' ,CommercialInvNo);
  AddXMLNode(node,'SupplierWorkOrderNo' ,SupplierWorkOrderNo);

  AddXMLNode(node,'TotalAuxilaryCosts',TotalAuxilaryCosts);
  AddXMLNode(node,'AuxilaryCostsPercentage',AuxilaryCostsPercentage);
  AddXMLNode(node,'AuxilaryCostsPerItem',AuxilaryCostsPerItem);
end;


function TShipContainerDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Self.Dataset.RecordCount < 1 then begin  //no recs to validate yet
    Result := True;
    exit;
  end;

  if ShippingContainerID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ShippingContainerID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TShipContainerDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TShipContainerDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TShipContainerDetails.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
  if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName , 'AuxilaryCostsPercentage') then begin
    {adjust all recs so that the percentages add up to 100%}
    if not fSettingPercentages then begin
      fSettingPercentages := True;
      self.PostDb;
      if AuxilaryCostsPercentage > 100 then ShowMessage('Cant be more than 100 %'); {todo send a message to form instead of using dialog here}
      RecalcPercentages(PurchaseLineID);
      {maybe write the values to auxilary landedcosts/Item}

      {send message to frmShippingContainer to apply the percentages thru the PO to update LandedCosts/Item on the PO}
      if Assigned(fOnContainerChange) then fOnContainerChange(self,'Percentage ReCalc','');
    end;
  end;

  if Sysutils.SameText(Sender.FieldName , 'AuxilaryCostsPerItem') then begin
   {send message to frmShippingContainer  just update data}
    if not fSettingPercentages then begin
      fSettingPercentages := True;
      self.PostDb;
      if RecalcPerItems(PurchaseLineID) then
        if Assigned(fOnContainerChange) then fOnContainerChange(self,'LandedCostPerItemChanged',''); 
    end;
  end;
end;

function TShipContainerDetails.RecalcPerItems(xPurchaseLineID:integer):Boolean;
var
  dAdjustment,dDiff,dTotal:double;
  qry:TERPQuery;
begin
  Result := True;
  fbNegativeDetected := False;
  qry := TERPQuery.Create(nil);
  qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
  try
    qry.SQL.Add('SELECT  SD.PurchaseLineID,PL.QtySold,SD.AuxilaryCostsPerItem  FROM tblshipContainerDetails sd');
    qry.SQL.Add('INNER JOIN tblPurchaseLines PL ON SD.PurchaseLineID=PL.PurchaseLineID');
    qry.SQL.Add('WHERE SD.ShippingContainerID = ' + IntToStr(Self.ShippingContainerID));
    qry.Open;
    qry.First;
    dTotal := 0;
    while not qry.Eof do begin
      dTotal := dTotal + (qry.FieldByName('AuxilaryCostsPerItem').AsFloat * qry.FieldByName('QtySold').AsFloat);
      qry.Next;
    end;

    dAdjustment := Self.TotalAuxilaryCosts - dTotal;
    dDiff := divzer(dAdjustment,(Self.Count - 1));

    qry.First;
    while not qry.Eof do begin
      if qry.FieldByName('PurchaseLineId').AsInteger <> xPurchaseLineID then begin  {don't adjust value of the edited record}
        qry.Edit;
        qry.FieldByName('AuxilaryCostsPerItem').AsFloat := qry.FieldByName('AuxilaryCostsPerItem').AsFloat + divzer(dDiff,qry.FieldByName('QtySold').AsFloat);
        if qry.FieldByName('AuxilaryCostsPerItem').AsFloat < 0 then fbNegativeDetected := True;
        qry.Post;
      end;
      qry.Next;
    end;
    ModifyPercentages;
    if fbNegativeDetected then Result := False;
  finally
   fSettingPercentages := False;
   FreeAndNil(qry);
  end;
end;

procedure TShipContainerDetails.ModifyPercentages;
var
  qry,qry2:TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
  qry2 := TERPQuery.Create(nil);
  qry2.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
  try
    qry.SQL.Add('SELECT  SD.PurchaseLineID,SD.AuxilaryCostsPerItem * PL.QtySold as TotalLineAuxilaryCosts,');
    qry.SQL.Add('SD.TotalAuxilaryCosts,SD.AuxilaryCostsPercentage');
    qry.SQL.Add('FROM tblshipContainerDetails sd');
    qry.SQL.Add('INNER JOIN tblPurchaseLines PL ON SD.PurchaseLineID=PL.PurchaseLineID');
    qry.SQL.Add('WHERE SD.ShippingContainerID = ' + IntToStr(Self.ShippingContainerID));
    qry.Open;

    qry2.SQL.Add('SELECT SD.PurchaseLineID,SD.AuxilaryCostsPercentage');
    qry2.SQL.Add('FROM tblShipContainerDetails sd  ');
    qry2.SQL.Add('WHERE SD.ShippingContainerID = ' + IntToStr(Self.ShippingContainerID));
    qry2.Open;

    qry.First;
    while not qry.Eof do begin
      qry2.Locate('PurchaseLineID',qry.FieldByName('PurchaseLineID').asInteger,[]);
      qry2.Edit;
      qry2.FieldByName('AuxilaryCostsPercentage').AsFloat :=  Divzer(qry.FieldByName('TotalLineAuxilaryCosts').AsFloat,qry.FieldByName('TotalAuxilaryCosts').AsFloat)* 100;
      qry2.Post;
      qry.Next;
    end;
  finally
   FreeAndNil(qry);
   FreeAndNil(qry2);
  end;
end;

procedure TShipContainerDetails.RecalcPercentages(xPurchaseLineID:integer);
var
  dAdjustment,dDiff:double;
  qry:TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
  try
    qry.SQL.Add('SELECT Sum(SD.AuxilaryCostsPercentage) as Total,SD.shippingcontainerID');
    qry.SQL.Add('FROM tblshipcontainerdetails SD');
    qry.SQL.Add('Where SD.ShippingContainerID = ' + IntToStr(ShippingContainerID));
    qry.SQL.Add('Group By SD.shippingcontainerID');
    qry.Open;
    dAdjustment := 100 - qry.FieldByName('Total').asFloat;
    dDiff := divzer(dAdjustment,(Self.Count - 1));

    Self.First;
    while not Self.Eof do begin
      if PurchaseLineId <> xPurchaseLineID then begin  {don't adjust value of the edited record}
        AuxilaryCostsPercentage := AuxilaryCostsPercentage + dDiff;
        AuxilaryCostsPercentage := DecimalRounding.DecimalRoundDbl(AuxilaryCostsPercentage,2,drRndUp);
        Self.PostDb;
      end;
      Self.Next;
    end;
  finally
   fSettingPercentages := False;
   FreeAndNil(qry);
  end;
end;

function TShipContainerDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TShipContainerDetails.GetIDField: string;
begin
  Result := 'ShipContainerDetailID'
end;


class function TShipContainerDetails.GetBusObjectTablename: string;
begin
  Result:= 'tblshipcontainerdetails';
end;


function TShipContainerDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TShipContainerDetails.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
end;

Function  TShipContainerDetails.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    IF NOT RESULT THEN EXIT;
    if Assigned(Self.Owner) then
      if Self.Owner is TShippingContainer then
        ShippingContainerId := TShippingContainer(Self.Owner).ID;
end;

{Property Functions}
function  TShipContainerDetails.GetShippingContainerID  : Integer   ; begin Result := GetIntegerField('ShippingContainerID');end;
function  TShipContainerDetails.GetCommercialInvNo      : string    ; begin Result := GetStringField('CommercialInvNo');end;
function  TShipContainerDetails.GetSupplierWorkOrderNo  : string    ; begin Result := GetStringField('SupplierWorkOrderNo');end;
function  TShipContainerDetails.GetPOLineID  : Integer   ; begin Result := GetIntegerField('PurchaseLineID');end;

function  TShipContainerDetails.GetTotalAuxilaryCosts           :double ; begin Result := GetFloatField('TotalAuxilaryCosts');end;
function  TShipContainerDetails.GetAuxilaryCostsPercentage      :double ; begin Result := GetFloatField('AuxilaryCostsPercentage');end;
function  TShipContainerDetails.GetAuxilaryCostsPerItem         :double ; begin Result := GetFloatField('AuxilaryCostsPerItem');end;
function  TShipContainerDetails.getQtySold                      :Double ; begin Result := getfloatfield('QtySold');end;
function  TShipContainerDetails.getreceivedqty                  :Double ; begin REsult := Getfloatfield('RecievedQty');end;

procedure TShipContainerDetails.SetShippingContainerID  (const Value: Integer   ); begin SetIntegerField('ShippingContainerID'   , Value);end;
procedure TShipContainerDetails.SetCommercialInvNo      (const Value: string    ); begin SetStringField('CommercialInvNo'       , Value);end;
procedure TShipContainerDetails.SetSupplierWorkOrderNo  (const Value: string    ); begin SetStringField('SupplierWorkOrderNo'   , Value);end;
procedure TShipContainerDetails.SetPOLineID  (const Value: Integer   ); begin SetIntegerField('PurchaseLineID'   , Value);end;

procedure TShipContainerDetails.SetTotalAuxilaryCosts      (const Value: double);begin SetFloatField('TotalAuxilaryCosts',Value);end;
procedure TShipContainerDetails.SetAuxilaryCostsPercentage (const Value: double);begin SetFloatField('AuxilaryCostsPercentage',Value);end;
procedure TShipContainerDetails.SetAuxilaryCostsPerItem    (const Value: double);begin SetFloatField('AuxilaryCostsPerItem',Value);end;



initialization
  RegisterClass(TShipContainerDetails); 
end.
