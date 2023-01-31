unit BusObjProductBarcode ;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/04/09  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TProductBarcodeList = class;

  TProductBarcode = class(TMSBusObj)
  private
    fbupdatingPrimarybarcode :Boolean;
    function GetPartsID             : Integer   ;
    function GetBarCode             : string    ;
    function GetIsprimaryBarcode    : Boolean   ;
    function GetActive              : Boolean   ;
    procedure SetPartsID             (const Value: Integer   );
    procedure SetBarCode             (const Value: string    );
    procedure SetIsprimaryBarcode    (const Value: Boolean   );
    procedure SetActive              (const Value: Boolean   );
    function getProduct: TProductBarcodeList;
    procedure updatePrimarybarcode;
    function getProductName: String;
    procedure setProductname(const Value: String);
    function GetUnitOfMeasureId: integer;
    function GetUOMNameProductKey: string;
    procedure SetUnitOfMeasureId(const Value: integer);
    procedure SetUOMNameProductKey(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoBeforePost(Sender:TDatasetBusObj): Boolean;             override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);               override;
    procedure    SaveToXMLNode(const node: IXMLNode);                 override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Product : TProductBarcodeList read getProduct;
    property ProductID: Integer     read GetPartsID            write SetPartsID         ;
    property UnitOfMeasureId: integer read GetUnitOfMeasureId write SetUnitOfMeasureId;
    function ValidateUnique: boolean;
  published
    property BarCode              :string      read GetBarCode            write SetBarCode         ;
    property IsprimaryBarcode     :Boolean     read GetIsprimaryBarcode   write SetIsprimaryBarcode;
    property Active               :Boolean     read GetActive             write SetActive          ;
    Property Productname :String read getProductName write setProductname;
    property UOMNameProductKey: string read GetUOMNameProductKey write SetUOMNameProductKey;
  end;

  TProductBarcodeList = class(TMSBusObj)
  private
    AllLinesValid: boolean;
    fPrimaryBarcode: string;
    function GetProductID           : Integer   ;
    procedure ValidateCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure SetPrimaryCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure GetPrimaryCallback(Const Sender: TBusObj; var Abort: boolean);
    function GetPrimaryBarcode: string;
    procedure SetPrimaryBarcode(const Value: string);
    function GetLines: TProductBarcode;
    function GetBarcode: string;
    function GetProductName: string;
    procedure SetBarcode(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoBeforePost(Sender:TDatasetBusObj): Boolean;             override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);               override;
    procedure    SaveToXMLNode(const node: IXMLNode);                 override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property PrimaryBarcode: string read GetPrimaryBarcode write SetPrimaryBarcode;
    property Lines: TProductBarcode read GetLines;
    procedure AddBarcode(aBarcode: string);
  published
    property ProductID            :Integer     read GetProductID;
    property ProductName          :string      read GetProductName;
    Property Barcode              :string      read GetBarcode write SetBarcode;
  end;

implementation


uses
  tcDataUtils, CommonLib, SysUtils, MyAccess, ERPdbComponents, BusObjStock,
  BusobjProduct, BusObjectListObj, AppEnvironment, BusObjUOM;


  {TProductBarcode}

constructor TProductBarcode.Create(AOwner: TComponent);
begin
  fbupdatingPrimarybarcode := False;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProductBarcode';
  fSQL := 'SELECT * FROM tblpartbarcodes';
  fIsList:= true;
  ExportExcludeList.Add('productid');
end;


destructor TProductBarcode.Destroy;
begin
  inherited;
end;


procedure TProductBarcode.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'BarCode');
  SetBooleanPropertyFromNode(node,'IsprimaryBarcode');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TProductBarcode.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'BarCode' ,BarCode);
  AddXMLNode(node,'IsprimaryBarcode' ,IsprimaryBarcode);
  AddXMLNode(node,'Active' ,Active);
end;


function TProductBarcode.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := false;
  if Trim(BarCode) = ''then begin
    AddResult(False , rssError , 0,  'Barcode should not be blank');
    exit;
  end;

  if ProductID = 0 then begin
    AddResult(False , rssError , 0,  'ProductID should not be 0');
    exit;
  end;
  If aPPENV.CompanyPrefs.UseAlphaNumericBarcodes = False then
      if not IsNumeric(BarCode) then begin
        AddResult(False , rssError , 0,  'Barcode should be a number. Please change the Preference if you need to have alphanumeric barcodes');
        exit;
  end;


  if not ValidateUnique then begin
    exit;
  end;

  Result := true;
end;


function TProductBarcode.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProductBarcode.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

Procedure TProductBarcode.updatePrimarybarcode;
begin
  if Trim(BarCode) = ''then begin
    exit;
  end;
  if ProductID = 0 then begin
    exit;
  end;

//  if not validatedata then exit;
  if Assigned(Owner) and (Owner is TProductSimple) then begin
    if IsPrimaryBarcode then begin
          TProductSimple(Owner).BARCODE := BARCODE;
          TProductSimple(Owner).Postdb;
    end else begin
      if (TProductSimple(Owner).BARCODE = '') or (TProductSimple(Owner).BARCODE = BARCODE) then begin
         TProductSimple(Owner).BARCODE := BARCODE;
         TProductSimple(Owner).Postdb;
         IsPrimaryBarcode := True;
         PostDB;
      end;
    end;
  end else begin
    if IsPrimaryBarcode then begin
          if (product <> self.owner) then
            if not Product.Lock then begin
              IsPrimaryBarcode := false;
              Exit;
            end;
          TProductBarcodeList(Product).PrimaryBarcode := BARCODE;
          TProductBarcodeList(Product).BARCODE := BARCODE;
          TProductBarcodeList(Product).Postdb;
    end else begin
      if (TProductBarcodeList(Product).BARCODE = '') or (TProductBarcodeList(Product).BARCODE = BARCODE) then begin
         TProductBarcodeList(Product).BARCODE := BARCODE;
         IsPrimaryBarcode := True;
         TProductBarcodeList(Product).Postdb;
      end;
    end;
  end;
end;

procedure TProductBarcode.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'ProductId') then begin
    if Product.ID =0 then
      ProductId:= 0;
  end else if Sysutils.SameText(Sender.fieldName, 'BarCode') then begin
    //updatePrimarybarcode;
  end else if Sysutils.SameText(Sender.fieldName, 'IsPrimaryBarcode') then begin
    //updatePrimarybarcode;
  end
end;


function TProductBarcode.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TProductBarcode.GetUnitOfMeasureId: integer;
begin
  result := GetIntegerField('UnitOfMeasureId');
end;

function TProductBarcode.GetUOMNameProductKey: string;
begin
  result := TUnitOfMeasure.IDToggle(UnitOfMeasureId, Connection.Connection);
end;

class function TProductBarcode.GetIDField: string;
begin
  Result := 'ProductBarCodeID'
end;


class function TProductBarcode.GetBusObjectTablename: string;
begin
  Result:= 'tblpartbarcodes';
end;



{Property Functions}
function  TProductBarcode.GetPartsID         : Integer   ; begin Result := GetIntegerField('PartsID');end;
function TProductBarcode.getProduct: TProductBarcodeList;
begin
  if Assigned(Owner) and (Owner is TProductBarcodeList) then begin
      result :=  TProductBarcodeList(Owner);
  end else begin
      Result := TProductBarcodeList(getContainercomponent(TProductBarcodeList, 'PartsId = ' + inttostr(ProductId)));
  end;
end;

function TProductBarcode.getProductName: String;begin  Result := Product.ProductName;end;
function  TProductBarcode.GetBarCode         : string    ; begin Result := GetStringField('BarCode');end;
function  TProductBarcode.GetIsprimaryBarcode: Boolean   ; begin Result := GetBooleanField('IsprimaryBarcode');end;
function  TProductBarcode.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TProductBarcode.SetPartsID         (const Value: Integer   ); begin SetIntegerField('PartsID'         , Value);end;
procedure TProductBarcode.setProductname(const Value: String);begin  ProductId := tcdatautils.GetProduct(Value);end;

procedure TProductBarcode.SetUnitOfMeasureId(const Value: integer);
begin
  SetIntegerField('UnitOfMeasureId', Value);
end;

procedure TProductBarcode.SetUOMNameProductKey(const Value: string);
begin
  UnitOfMeasureId := TUnitOfMeasure.IDToggle(Value, Connection.Connection);
end;

procedure TProductBarcode.SetBarCode         (const Value: string    );begin  SetStringField('BarCode', Value);end;
procedure TProductBarcode.SetIsprimaryBarcode(const Value: Boolean   );begin  SetBooleanField('IsprimaryBarcode', Value);end;
procedure TProductBarcode.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'          , Value);end;

function TProductBarcode.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
end;

function TProductBarcode.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if not result then exit;
  if Assigned(Owner) then begin
    if (Owner is TProductSimple) then
      ProductID := TProductSimple(Owner).ID
    else if (Owner is TProductBarcodeList) then
      ProductID := TProductBarcodeList(Owner).ProductID;
  end;
end;

function TProductBarcode.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if not fbupdatingPrimarybarcode then begin
    fbupdatingPrimarybarcode := True;
    try
      updatePrimarybarcode;
    finally
      fbupdatingPrimarybarcode := False;
    end;
  end;
  (*if Assigned(Owner) and (Owner is TProductBarcodeList) then begin
    if IsprimaryBarcode then begin
      TProductBarcodeList(Owner).PrimaryBarcode:= Barcode;
    end else begin
      if TProductBarcodeList(Owner).PrimaryBarcode = '' then begin
        IsprimaryBarcode:= True;
        postdb;
      end;
    end;
  end;*)
end;

function TProductBarcode.ValidateUnique: boolean;
var
  qry: TERPQuery;
begin
  result:= true;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= self.Connection.Connection;
    qry.SQL.Add('select p.partname, p.partsdescription, pb.ProductBarcodeID');
    qry.SQL.Add('from tblparts p, tblpartbarcodes pb');
    qry.SQL.Add('where pb.PartsID = p.PartsID and pb.Barcode = ' + QuotedStr(Barcode));
    (*qry.SQL.Add('and pb.Active = "T"');*)
    qry.SQL.Add('and pb.ProductBarcodeID <> ' + IntToStr(Id));
    qry.Open;
    if not qry.IsEmpty then begin
      result:= false;
      self.ResultStatus.AddItem(False , rssError , 0,
        'Barcode "' + Barcode + '" is already in use for product: "' + qry.FieldByName('partname').AsString +
        '" - "' + qry.FieldByName('partsdescription').AsString + '"');
    end;
  finally
    qry.Free;
  end;
end;

{ TProductBarcodeList }

procedure TProductBarcodeList.AddBarcode(aBarcode: string);
begin
  //if TProductBarcode.IsUnique(0 , 'Barcode =' +quotedstr(Barcode), Lines.Connection.Connection) then begin
    Lines.New;
    Lines.BarCode:= aBarCode;
    Lines.ProductID:= self.ProductID;
    Lines.IsprimaryBarcode:= Lines.Count < 2;
    Lines.PostDb;
  //end;
end;

constructor TProductBarcodeList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProductBarcodeList';
  fSQL := 'SELECT * FROM tblparts';
end;

destructor TProductBarcodeList.Destroy;
begin

  inherited;
end;

function TProductBarcodeList.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);

end;

function TProductBarcodeList.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TProductBarcodeList.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
end;

procedure TProductBarcodeList.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TProductBarcodeList.GetBarcode: string;
begin
  result:= GetStringField('BARCODE');
end;

class function TProductBarcodeList.GetBusObjectTablename: string;
begin
  Result:= 'tblparts';
end;

class function TProductBarcodeList.GetIDField: string;
begin
  Result := 'PARTSID'
end;

function TProductBarcodeList.GetLines: TProductBarcode;
begin
  Result := TProductBarcode(getContainerComponent(TProductBarcode, 'PartsId = ' + IntToStr(ID)));
end;

function TProductBarcodeList.GetPrimaryBarcode: string;
begin
  fPrimaryBarcode:= '';
  Lines.IterateRecords(GetPrimaryCallback);
  result:= fPrimaryBarcode;
end;

procedure TProductBarcodeList.GetPrimaryCallback(const Sender: TBusObj;
  var Abort: boolean);
var
  Line: TProductBarcode;
begin
  Line:= TProductBarcode(Sender);
  if Line.IsprimaryBarcode then begin
    fPrimaryBarcode:= Line.BarCode;
    (*Abort:= true;*)
  end;
end;

function TProductBarcodeList.GetProductID: Integer;
begin
  Result:= GetIntegerField('PartsID');
end;

function TProductBarcodeList.GetProductName: string;
begin
  Result:= GetStringField('PARTNAME');
end;

function TProductBarcodeList.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TProductBarcodeList.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: integer;
begin
  inherited;

  { delete existing lines if they exist }
  while Lines.Count > 0 do Lines.Delete;
  LinesNode := node.ChildNodes.FindNode('lines');
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.Count - 1 do begin
      Lines.New;
      Lines.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      Lines.Postdb;
    end;
  end;
end;

procedure TProductBarcodeList.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TProductBarcodeList.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TProductBarcodeList.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductID', ProductID);
  AddXMLNode(node,'ProductName', ProductName);
  Lines.XMLPropertyNode := node.AddChild('lines');
  Lines.XMLPropertyName:= Lines.XMLNodeName;
  Lines.IterateRecords(GetPropertyXMLCallback);
end;

procedure TProductBarcodeList.SetBarcode(const Value: string);
begin
  SetStringField('BARCODE', Value);
end;

procedure TProductBarcodeList.SetPrimaryBarcode(const Value: string);
begin
  fPrimaryBarcode:= Value;
  Lines.IterateRecords(SetPrimaryCallback);
  Lines.PostDb;
  if not(sametext(barcode , fPrimaryBarcode)) then begin
    Barcode := fPrimaryBarcode;
    PostDB;
  end;
end;

procedure TProductBarcodeList.SetPrimaryCallback(const Sender: TBusObj;
  var Abort: boolean);
var
  Line: TProductBarcode;
begin
  Line:= TProductBarcode(Sender);
  if Line.Barcode = fPrimaryBarcode then begin
    if not Line.IsPrimaryBarcode then begin
      Line.IsPrimaryBarcode:= true;
      Line.PostDB;
    end;
  end else begin
    if Line.IsPrimaryBarcode then begin
      Line.IsPrimaryBarcode:= false;
      Line.PostDB;
    end;
  end;
end;

procedure TProductBarcodeList.ValidateCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  Abort:= not TProductBarcode(Sender).ValidateData;
  AllLinesValid:= not Abort;
end;

function TProductBarcodeList.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  AllLinesValid:= true;
  Lines.IterateRecords(ValidateCallback);
  Result := AllLinesValid;
end;

initialization
  RegisterClass(TProductBarcodeList);
  RegisterClass(TProductBarcode);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product Barcodes','TProductBarcode','TProductBarcodesGUI');

end.
