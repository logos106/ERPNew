unit BusobjTransactionPQACOGSDetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  25/11/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTransactionPQACOGSDetails = class(TMSBusObj)
  private
    function GetPQAID1          : Integer   ;
    function GetPQAID2          : Integer   ;
    function GetProductId       : Integer   ;
    function GetTransType1      : string    ;
    function GetTransType2      : string    ;
    function GetProductName     : string    ;
    function GetQty             : Double    ;
    function GetUnitCostex      : Double    ;
    function GetUnitcostInc     : Double    ;
    function GettotalcostEx     : Double    ;
    function GetTotalCostInc    : Double    ;
    procedure SetPQAID1          (const Value: Integer   );
    procedure SetPQAID2          (const Value: Integer   );
    procedure SetProductID       (const Value: Integer   );
    procedure SetTransType1      (const Value: string    );
    procedure SetTransType2      (const Value: string    );
    procedure SetProductName     (const Value: string    );
    procedure SetQty             (const Value: Double    );
    procedure SetUnitCostex      (const Value: Double    );
    procedure SetUnitcostInc     (const Value: Double    );
    procedure SettotalcostEx     (const Value: Double    );
    procedure SetTotalCostInc    (const Value: Double    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property PQAID1           :Integer     read GetPQAID1         write SetPQAID1      ;
    property PQAID2           :Integer     read GetPQAID2         write SetPQAID2      ;
    property ProductId        :Integer     read GetProductId      write SetProductID   ;
    property TransType1       :string      read GetTransType1     write SetTransType1  ;
    property TransType2       :string      read GetTransType2     write SetTransType2  ;
    property ProductName      :string      read GetProductName    write SetProductName ;
    property Qty              :Double      read GetQty            write SetQty         ;
    property UnitCostex       :Double      read GetUnitCostex     write SetUnitCostex  ;
    property UnitcostInc      :Double      read GetUnitcostInc    write SetUnitcostInc ;
    property totalcostEx      :Double      read GettotalcostEx    write SettotalcostEx ;
    property TotalCostInc     :Double      read GetTotalCostInc   write SetTotalCostInc;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TTransactionPQACOGSDetails}

constructor TTransactionPQACOGSDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TransactionPQACOGSDetails';
  fSQL := 'SELECT * FROM tbltransactionpqacogsdetails';
end;


destructor TTransactionPQACOGSDetails.Destroy;
begin
  inherited;
end;


procedure TTransactionPQACOGSDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PQAID1');
  SetPropertyFromNode(node,'PQAID2');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'TransType1');
  SetPropertyFromNode(node,'TransType2');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UnitCostex');
  SetPropertyFromNode(node,'UnitcostInc');
  SetPropertyFromNode(node,'totalcostEx');
  SetPropertyFromNode(node,'TotalCostInc');
end;


procedure TTransactionPQACOGSDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PQAID1' ,PQAID1);
  AddXMLNode(node,'PQAID2' ,PQAID2);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'TransType1' ,TransType1);
  AddXMLNode(node,'TransType2' ,TransType2);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UnitCostex' ,UnitCostex);
  AddXMLNode(node,'UnitcostInc' ,UnitcostInc);
  AddXMLNode(node,'totalcostEx' ,totalcostEx);
  AddXMLNode(node,'TotalCostInc' ,TotalCostInc);
end;


function TTransactionPQACOGSDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PQAID1 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PQAID1 should not be 0' , False );
    Exit;
  end;
  if PQAID2 = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PQAID2 should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TTransactionPQACOGSDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTransactionPQACOGSDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTransactionPQACOGSDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTransactionPQACOGSDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTransactionPQACOGSDetails.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTransactionPQACOGSDetails.GetBusObjectTablename: string;
begin
  Result:= 'tbltransactionpqacogsdetails';
end;


function TTransactionPQACOGSDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TTransactionPQACOGSDetails.GetPQAID1      : Integer   ; begin Result := GetIntegerField('PQAID1');end;
function  TTransactionPQACOGSDetails.GetPQAID2      : Integer   ; begin Result := GetIntegerField('PQAID2');end;
function  TTransactionPQACOGSDetails.GetProductId   : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TTransactionPQACOGSDetails.GetTransType1  : string    ; begin Result := GetStringField('TransType1');end;
function  TTransactionPQACOGSDetails.GetTransType2  : string    ; begin Result := GetStringField('TransType2');end;
function  TTransactionPQACOGSDetails.GetProductName : string    ; begin Result := GetStringField('ProductName');end;
function  TTransactionPQACOGSDetails.GetQty         : Double    ; begin Result := GetFloatField('Qty');end;
function  TTransactionPQACOGSDetails.GetUnitCostex  : Double    ; begin Result := GetFloatField('UnitCostex');end;
function  TTransactionPQACOGSDetails.GetUnitcostInc : Double    ; begin Result := GetFloatField('UnitcostInc');end;
function  TTransactionPQACOGSDetails.GettotalcostEx : Double    ; begin Result := GetFloatField('totalcostEx');end;
function  TTransactionPQACOGSDetails.GetTotalCostInc: Double    ; begin Result := GetFloatField('TotalCostInc');end;
procedure TTransactionPQACOGSDetails.SetPQAID1      (const Value: Integer   ); begin SetIntegerField('PQAID1'       , Value);end;
procedure TTransactionPQACOGSDetails.SetPQAID2      (const Value: Integer   ); begin SetIntegerField('PQAID2'       , Value);end;
procedure TTransactionPQACOGSDetails.SetProductID   (const Value: Integer   ); begin SetIntegerField('ProductId'       , Value);end;
procedure TTransactionPQACOGSDetails.SetTransType1  (const Value: string    ); begin SetStringField('TransType1'   , Value);end;
procedure TTransactionPQACOGSDetails.SetTransType2  (const Value: string    ); begin SetStringField('TransType2'   , Value);end;
procedure TTransactionPQACOGSDetails.SetProductName (const Value: string    ); begin SetStringField('ProductName'  , Value);end;
procedure TTransactionPQACOGSDetails.SetQty         (const Value: Double    ); begin SetFloatField('Qty'          , Value);end;
procedure TTransactionPQACOGSDetails.SetUnitCostex  (const Value: Double    ); begin SetFloatField('UnitCostex'   , Value);end;
procedure TTransactionPQACOGSDetails.SetUnitcostInc (const Value: Double    ); begin SetFloatField('UnitcostInc' , Value);end;
procedure TTransactionPQACOGSDetails.SettotalcostEx (const Value: Double    ); begin SetFloatField('totalcostEx' , Value);end;
procedure TTransactionPQACOGSDetails.SetTotalCostInc(const Value: Double    ); begin SetFloatField('TotalCostInc' , Value);end;


initialization
  RegisterClass(TTransactionPQACOGSDetails);


end.
