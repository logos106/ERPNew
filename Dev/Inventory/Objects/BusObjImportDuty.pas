unit BusObjImportDuty;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  29/05/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TImportProductsDuty = class(TMSBusObj)
  private
    function GetSupplierId           : Integer   ;
    function GetProductId            : Integer   ;
    function GetCountryOfOriginId    : Integer   ;
    function GetDuty                 : Double    ;
    function GetHandling             : Double    ;
    procedure SetSupplierId           (const Value: Integer   );
    procedure SetProductId            (const Value: Integer   );
    procedure SetCountryOfOriginId    (const Value: Integer   );
    procedure SetDuty                 (const Value: Double    );
    procedure SetHandling             (const Value: Double    );
    function getSupplierName: String;
    procedure setSupplierName(const Value: String);
    function GetCountryOfOrigin: string;
    procedure SetCountryOfOrigin(const Value: string);
    procedure SetProductName(const Value: String);
    function GetProductName: String;
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
    property SupplierId            :Integer     read GetSupplierId          write SetSupplierId       ;
    property ProductId             :Integer     read GetProductId           write SetProductId        ;
    property CountryOfOriginId     :Integer     read GetCountryOfOriginId   write SetCountryOfOriginId;
  published
    Property SupplierName :String read getSupplierName write setSupplierName;
    property ProductName : String read GetProductName write SetProductName;
    property CountryOfOrigin : string read GetCountryOfOrigin write SetCountryOfOrigin;
    property Duty                  :Double      read GetDuty                write SetDuty             ;
    property Handling              :Double      read GetHandling            write SetHandling         ;
  end;


implementation


uses tcDataUtils, CommonLib,BusObjectListObj,
  busObjClient, busObjCountries, busObjStock;



  {TImportProductsDuty}

constructor TImportProductsDuty.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'importproducts';
  fSQL := 'SELECT * FROM tblimportproducts';
end;


destructor TImportProductsDuty.Destroy;
begin
  inherited;
end;


procedure TImportProductsDuty.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SupplierId');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'CountryOfOriginId');
  SetPropertyFromNode(node,'Duty');
  SetPropertyFromNode(node,'Handling');
end;


procedure TImportProductsDuty.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SupplierId' ,SupplierId);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'CountryOfOriginId' ,CountryOfOriginId);
  AddXMLNode(node,'Duty' ,Duty);
  AddXMLNode(node,'Handling' ,Handling);
end;


function TImportProductsDuty.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SupplierId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SupplierId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TImportProductsDuty.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TImportProductsDuty.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TImportProductsDuty.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TImportProductsDuty.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TImportProductsDuty.GetIDField: string;
begin
  Result := 'ID'
end;


class function TImportProductsDuty.GetBusObjectTablename: string;
begin
  Result:= 'tblimportproducts';
end;


function TImportProductsDuty.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TImportProductsDuty.GetSupplierId       : Integer   ; begin Result := GetIntegerField('SupplierId');end;
function TImportProductsDuty.getSupplierName: String;
begin
  result := Tsupplier.idtoggle(SupplierId);
end;

function  TImportProductsDuty.GetProductId        : Integer   ; begin Result := GetIntegerField('ProductId');end;
function TImportProductsDuty.GetProductName: String;
begin
  Result := TProduct.IDToggle(ProductId);
end;

function TImportProductsDuty.GetCountryOfOrigin: string;
begin
  Result := TCountries.IdToggle(CountryOfOriginId);
end;

function  TImportProductsDuty.GetCountryOfOriginId: Integer   ; begin Result := GetIntegerField('CountryOfOriginId');end;
function  TImportProductsDuty.GetDuty             : Double    ; begin Result := GetFloatField('Duty');end;
function  TImportProductsDuty.GetHandling         : Double    ; begin Result := GetFloatField('Handling');end;
procedure TImportProductsDuty.SetSupplierId       (const Value: Integer   ); begin SetIntegerField('SupplierId'        , Value);end;
procedure TImportProductsDuty.setSupplierName(const Value: String);
begin
  supplierId := Tsupplier.idtoggle(Value);
end;

procedure TImportProductsDuty.SetProductId        (const Value: Integer   ); begin SetIntegerField('ProductId'         , Value);end;
procedure TImportProductsDuty.SetCountryOfOrigin(const Value: string);
begin
  CountryOfOriginId := TCountries.IDToggle(Value);
end;

procedure TImportProductsDuty.SetProductName(const Value: String);
begin
  ProductId := TProduct.IDToggle(Value);
end;

procedure TImportProductsDuty.SetCountryOfOriginId(const Value: Integer   ); begin SetIntegerField('CountryOfOriginId' , Value);end;
procedure TImportProductsDuty.SetDuty             (const Value: Double    ); begin SetFloatField('Duty'              , Value);end;
procedure TImportProductsDuty.SetHandling         (const Value: Double    ); begin SetFloatField('Handling'          , Value);end;


initialization
  RegisterClass(TImportProductsDuty);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product Duty And Handling','TImportProductsDuty',''); //, [boImport]);

end.
