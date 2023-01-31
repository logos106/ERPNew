unit Busobjpartsforexcelprice;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/05/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TPartsForExcelPrice = class(TMSBusObj)
  private
    fbMakeNewProductIfMissing: Boolean;
    function GetProductId           : Integer   ;
    function GetExcelPopupOption    : String   ;
    function GetExcelFilename       : String   ;
    function GetPriceRow            : Integer   ;
    function GetPriceCol            : Integer   ;
    function GetCostRow             : Integer   ;
    function GetCostCol             : Integer   ;
    function GetQtyRow              : Integer   ;
    function GetQtyCol              : Integer   ;
    function GetActive              : Boolean   ;
    function GetExcelPriceOverrides : Boolean   ;
    function GetUseCostInSales      : Boolean   ;
    procedure SetProductId           (const Value: Integer   );
    procedure SetExcelPopupOption    (const Value: String    );
    procedure SetExcelFilename       (const Value: String    );
    procedure SetPriceRow            (const Value: Integer   );
    procedure SetPriceCol            (const Value: Integer   );
    procedure SetCostRow             (const Value: Integer   );
    procedure SetCostCol             (const Value: Integer   );
    procedure SetQtyRow              (const Value: Integer   );
    procedure SetQtyCol              (const Value: Integer   );
    procedure SetActive              (const Value: Boolean   );
    procedure SetExcelPriceOverrides (const Value: Boolean   );
    procedure SetUseCostInSales      (const Value: Boolean   );
    function GetProductname: String;
    procedure SetProductName(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;           override;
    procedure AddNewifMissing(const fHeader,fDataline:TStringList);Override;
    Procedure OnAfterJsonToBusObjectNew ;Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property     ProductId            :Integer     read GetProductId          write SetProductId       ;
    Property MakeNewProductIfMissing : Boolean read fbMakeNewProductIfMissing write fbMakeNewProductIfMissing;
  published
    property ProductName          :String      read GetProductname        write SetProductName       ;
    property ExcelPopupOption     :String      read GetExcelPopupOption   write SetExcelPopupOption;
    property ExcelFilename        :String      read GetExcelFilename      write SetExcelFilename;
    property PriceRow             :Integer     read GetPriceRow           write SetPriceRow        ;
    property PriceCol             :Integer     read GetPriceCol           write SetPriceCol        ;
    property CostRow              :Integer     read GetCostRow            write SetCostRow         ;
    property CostCol              :Integer     read GetCostCol            write SetCostCol         ;
    property QtyRow               :Integer     read GetQtyRow             write SetQtyRow          ;
    property QtyCol               :Integer     read GetQtyCol             write SetQtyCol          ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property ExcelPriceOverrides  :Boolean     read GetExcelPriceOverrides write SetExcelPriceOverrides;
    property UseCostInSales       :Boolean     read GetUseCostInSales     write SetUseCostInSales;
  end;


implementation


uses tcDataUtils, CommonLib, BusobjProduct, BusObjectListObj, AppEnvironment;



  {TPartsForExcelPrice}

procedure TPartsForExcelPrice.AddNewifMissing(const fHeader,fDataline:TStringList);
begin
  inherited;
  MakeNewProductIfMissing := true;
end;


constructor TPartsForExcelPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PartsForExcelPrice';
  fSQL := 'SELECT * FROM tblpartsforexcelprice';
  MakeNewProductIfMissing := False;
end;


destructor TPartsForExcelPrice.Destroy;
begin
  inherited;
end;


procedure TPartsForExcelPrice.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'ExcelPopupOption');
  SetPropertyFromNode(node,'ExcelFilename');
  SetPropertyFromNode(node,'PriceRow');
  SetPropertyFromNode(node,'PriceCol');
  SetPropertyFromNode(node,'CostRow');
  SetPropertyFromNode(node,'CostCol');
  SetPropertyFromNode(node,'QtyRow');
  SetPropertyFromNode(node,'QtyCol');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'ExcelPriceOverrides');
  SetBooleanPropertyFromNode(node,'UseCostInSales');
end;


procedure TPartsForExcelPrice.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'ExcelPopupOption' ,ExcelPopupOption);
  AddXMLNode(node,'ExcelFilename' ,ExcelFilename);
  AddXMLNode(node,'PriceRow' ,PriceRow);
  AddXMLNode(node,'PriceCol' ,PriceCol);
  AddXMLNode(node,'CostRow' ,CostRow);
  AddXMLNode(node,'CostCol' ,CostCol);
  AddXMLNode(node,'QtyRow' ,QtyRow);
  AddXMLNode(node,'QtyCol' ,QtyCol);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'ExcelPriceOverrides' ,ExcelPriceOverrides);
  AddXMLNode(node,'UseCostInSales' ,UseCostInSales);
end;


function TPartsForExcelPrice.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product should not be Blank' , False );
    Exit;
  end;
  Result := True;
end;


function TPartsForExcelPrice.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if result then Appenv.CompanyPrefs.CheckForHasExcelPrices;
end;


procedure TPartsForExcelPrice.OnAfterJsonToBusObjectNew;
begin
  inherited;
  MakeNewProductIfMissing := True;
end;

procedure TPartsForExcelPrice.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPartsForExcelPrice.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPartsForExcelPrice.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPartsForExcelPrice.GetIDField: string;
begin
  Result := 'ID'
end;


class function TPartsForExcelPrice.GetBusObjectTablename: string;
begin
  Result:= 'tblpartsforexcelprice';
end;


function TPartsForExcelPrice.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TProductsimple then
      ProductId := TProductsimple(Owner).Id;
  ExcelPopupOption := 'C';
  Active := True;
  ExcelPriceOverrides:= False;
  UseCostInSales:= Appenv.companyprefs.CostEditableinSales;
end;

function TPartsForExcelPrice.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPartsForExcelPrice.GetProductId       : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TPartsForExcelPrice.GetProductname     : String    ; begin Result := TProductSimple.IDToggle(ProductID);end;
function  TPartsForExcelPrice.GetExcelPopupOption: String    ; begin Result := GetStringField('ExcelPopupOption');end;
function  TPartsForExcelPrice.GetExcelFilename   : String    ; begin Result := GetStringField('ExcelFilename');end;
function  TPartsForExcelPrice.GetPriceRow        : Integer   ; begin Result := GetIntegerField('PriceRow');end;
function  TPartsForExcelPrice.GetPriceCol        : Integer   ; begin Result := GetIntegerField('PriceCol');end;
function  TPartsForExcelPrice.GetCostRow         : Integer   ; begin Result := GetIntegerField('CostRow');end;
function  TPartsForExcelPrice.GetCostCol         : Integer   ; begin Result := GetIntegerField('CostCol');end;
function  TPartsForExcelPrice.GetQtyRow          : Integer   ; begin Result := GetIntegerField('QtyRow');end;
function  TPartsForExcelPrice.GetQtyCol          : Integer   ; begin Result := GetIntegerField('QtyCol');end;
function  TPartsForExcelPrice.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TPartsForExcelPrice.GetExcelPriceOverrides: Boolean   ; begin Result := GetBooleanField('ExcelSellPriceOverridesOtherPrices');end;
function  TPartsForExcelPrice.GetUseCostInSales  : Boolean   ; begin Result := GetBooleanField('UseCostInSales');end;
procedure TPartsForExcelPrice.SetProductId       (const Value: Integer   ); begin SetIntegerField('ProductId'        , Value);end;
procedure TPartsForExcelPrice.SetExcelPopupOption(const Value: String    ); begin SetStringField('ExcelPopupOption' , Value);end;
procedure TPartsForExcelPrice.SetExcelFilename   (const Value: String    ); begin SetStringField('ExcelFilename' , Value);end;
procedure TPartsForExcelPrice.SetPriceRow        (const Value: Integer   ); begin SetIntegerField('PriceRow'         , Value);end;
procedure TPartsForExcelPrice.SetPriceCol        (const Value: Integer   ); begin SetIntegerField('PriceCol'         , Value);end;
procedure TPartsForExcelPrice.SetCostRow         (const Value: Integer   ); begin SetIntegerField('CostRow'          , Value);end;
procedure TPartsForExcelPrice.SetCostCol         (const Value: Integer   ); begin SetIntegerField('CostCol'          , Value);end;
procedure TPartsForExcelPrice.SetQtyRow          (const Value: Integer   ); begin SetIntegerField('QtyRow'          , Value);end;
procedure TPartsForExcelPrice.SetQtyCol          (const Value: Integer   ); begin SetIntegerField('QtyCol'          , Value);end;
procedure TPartsForExcelPrice.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TPartsForExcelPrice.SetExcelPriceOverrides(const Value: Boolean   ); begin SetBooleanField('ExcelSellPriceOverridesOtherPrices'           , Value);end;
procedure TPartsForExcelPrice.SetUseCostInSales  (const Value: Boolean   ); begin SetBooleanField('UseCostInSales'           , Value);end;
procedure TPartsForExcelPrice.SetProductName     (const Value: String    );
var
  fi:Integer;
begin
  fi := TProductSimple.IDToggle(Value,connection.connection);
  if MakeNewProductIfMissing and (fi =0) then begin
    with TProductsimple.create(self) do try
      Load(0);
      New;
      Productname := Value;
      PostDB;
      fi := ID;
    finally
      Free;
    end;
  end;
  ProductId := fi;
end;



initialization
  RegisterClass(TPartsForExcelPrice);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product Excel Price','TPartsForExcelPrice','TPartsForExcelPriceGUI');


end.
