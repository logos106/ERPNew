unit BusobjWalmartItems;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/12/18  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type

  Twalmartnamevalueattributevalues = class(TMSBusObj)
  private
    function GetWalmartItemID    : Integer   ;
    function GetValue            : string    ;
    function GetGroup            : string    ;
    function GetRank             : Integer   ;
    procedure SetWalmartItemID    (const Value: Integer   );
    procedure SetValue            (const Value: string    );
    procedure SetGroup            (const Value: string    );
    procedure SetRank             (const Value: Integer   );
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
    property WalmartItemID     :Integer     read GetWalmartItemID   write SetWalmartItemID;
    property Value             :string      read GetValue           write SetValue        ;
    property Group             :string      read GetGroup           write SetGroup        ;
    property Rank              :Integer     read GetRank            write SetRank         ;
  end;


  Twalmartitems = class(TMSBusObj)
  private
    function GetMart                        : string    ;
    function GetSku                         : string    ;
    function GetWpID                        : string    ;
    function GetUpc                         : string    ;
    function GetGtin                        : string    ;
    function GetProductName                 : string    ;
    function GetShelf                       : string    ;
    function GetProductType                 : string    ;
    function GetPrice_Currency              : string    ;
    function GetPrice_Amount                : string    ;
    function GetPublishedStatus             : string    ;
    function GetAvailabilityCode            : string    ;
    function GetSynched                     : Boolean   ;
    function GetNameValueAttributes_Name    : string    ;
    function GetNameValueAttributes_Type    : string    ;
    function GetERPProductId                : Integer   ;
    function GetfulfillmentLagTime          : Integer   ;
    function GetMinfulfillmentLagTime       : Integer   ;
    function GetUOMID                       : Integer   ;
    function GetUOM                         : string    ;
    function GetUOMMult                     : Double ;
    function GetUOMQty                      : Double ;
    function  getProductnameforERP          : String;
    function  getProductDescriptionforERP   : String;
    procedure SetMart                        (const Value: string    );
    procedure SetSku                         (const Value: string    );
    procedure SetWpID                        (const Value: string    );
    procedure SetUpc                         (const Value: string    );
    procedure SetGtin                        (const Value: string    );
    procedure SetProductName                 (const Value: string    );
    procedure SetShelf                       (const Value: string    );
    procedure SetProductType                 (const Value: string    );
    procedure SetPrice_Currency              (const Value: string    );
    procedure SetPrice_Amount                (const Value: string    );
    procedure SetPublishedStatus             (const Value: string    );
    procedure SetAvailabilityCode            (const Value: string    );
    procedure SetSynched                     (const Value: Boolean   );
    procedure SetNameValueAttributes_Name    (const Value: string    );
    procedure SetNameValueAttributes_Type    (const Value: string    );
    procedure SetERPProductId                (const Value: Integer   );
    procedure SetfulfillmentLagTime          (const Value: Integer   );
    procedure SetMinfulfillmentLagTime       (const Value: Integer   );
    procedure SetUOMID                       (const Value: Integer   );
    procedure SetUOM                         (const Value: string    );
    procedure SetUOMMult                     (const Value: Double     );
    procedure SetUOMQty                      (const Value: Double     );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj): Boolean;            override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function ProductSearchSQL:String;
    Property ProductnameforERP :String read getProductnameforERP;
    Property ProductDescriptionforERP :String read getProductDescriptionforERP;
    procedure ChecknMakeERPProduct(onCreateProduct:TNotifyEvent);
  published
    property Mart                         :string      read GetMart                       write SetMart                    ;
    property Sku                          :string      read GetSku                        write SetSku                     ;
    property WpID                         :string      read GetWpID                       write SetWpID                    ;
    property Upc                          :string      read GetUpc                        write SetUpc                     ;
    property Gtin                         :string      read GetGtin                       write SetGtin                    ;
    property ProductName                  :string      read GetProductName                write SetProductName             ;
    property Shelf                        :string      read GetShelf                      write SetShelf                   ;
    property ProductType                  :string      read GetProductType                write SetProductType             ;
    property Price_Currency               :string      read GetPrice_Currency             write SetPrice_Currency          ;
    property Price_Amount                 :string      read GetPrice_Amount               write SetPrice_Amount            ;
    property PublishedStatus              :string      read GetPublishedStatus            write SetPublishedStatus         ;
    property AvailabilityCode             :string      read GetAvailabilityCode           write SetAvailabilityCode        ;
    property Synched                      :Boolean     read GetSynched                    write SetSynched                 ;
    property NameValueAttributes_Name     :string      read GetNameValueAttributes_Name   write SetNameValueAttributes_Name;
    property NameValueAttributes_Type     :string      read GetNameValueAttributes_Type   write SetNameValueAttributes_Type;
    property ERPProductId                 :Integer     read GetERPProductId               write SetERPProductId            ;
    property fulfillmentLagTime           :Integer     read GetfulfillmentLagTime         write SetfulfillmentLagTime      ;
    property MinfulfillmentLagTime        :Integer     read GetMinfulfillmentLagTime      write SetMinfulfillmentLagTime   ;
    property UOMID                        :Integer     read GetUOMID                      write SetUOMID                   ;
    property UOM                          :string      read GetUOM                        write SetUOM                     ;
    property UOMMult                      :Double      read GetUOMMult                    write SetUOMMult                 ;
    property UOMQty                       :Double      read GetUOMQty                     write SetUOMQty                  ;
  end;



implementation


uses tcDataUtils, CommonLib, AppEnvironment, sysutils, BusObjectListObj,
  BusobjProduct;




  {Twalmartnamevalueattributevalues}

constructor Twalmartnamevalueattributevalues.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartnamevalueattributevalues';
  fSQL := 'SELECT * FROM tblwalmartnamevalueattributevalues';
end;


destructor Twalmartnamevalueattributevalues.Destroy;
begin
  inherited;
end;


procedure Twalmartnamevalueattributevalues.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WalmartItemID');
  SetPropertyFromNode(node,'Value');
  SetPropertyFromNode(node,'Group');
  SetPropertyFromNode(node,'Rank');
end;


procedure Twalmartnamevalueattributevalues.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WalmartItemID' ,WalmartItemID);
  AddXMLNode(node,'Value' ,Value);
  AddXMLNode(node,'Group' ,Group);
  AddXMLNode(node,'Rank' ,Rank);
end;


function Twalmartnamevalueattributevalues.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartnamevalueattributevalues.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartnamevalueattributevalues.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartnamevalueattributevalues.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartnamevalueattributevalues.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartnamevalueattributevalues.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartnamevalueattributevalues.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartnamevalueattributevalues';
end;


function Twalmartnamevalueattributevalues.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twalmartnamevalueattributevalues.GetWalmartItemID: Integer   ; begin Result := GetIntegerField('WalmartItemID');end;
function  Twalmartnamevalueattributevalues.GetValue        : string    ; begin Result := GetStringField('Value');end;
function  Twalmartnamevalueattributevalues.GetGroup        : string    ; begin Result := GetStringField('Group');end;
function  Twalmartnamevalueattributevalues.GetRank         : Integer   ; begin Result := GetIntegerField('Rank');end;
procedure Twalmartnamevalueattributevalues.SetWalmartItemID(const Value: Integer   ); begin SetIntegerField('WalmartItemID' , Value);end;
procedure Twalmartnamevalueattributevalues.SetValue        (const Value: string    ); begin SetStringField('Value'         , Value);end;
procedure Twalmartnamevalueattributevalues.SetGroup        (const Value: string    ); begin SetStringField('Group'         , Value);end;
procedure Twalmartnamevalueattributevalues.SetRank         (const Value: Integer   ); begin SetIntegerField('Rank'          , Value);end;


  {Twalmartitems}

constructor Twalmartitems.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartitems';
  fSQL := 'SELECT * FROM tblwalmartitems';
end;


destructor Twalmartitems.Destroy;
begin
  inherited;
end;


procedure Twalmartitems.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Mart');
  SetPropertyFromNode(node,'Sku');
  SetPropertyFromNode(node,'WpID');
  SetPropertyFromNode(node,'Upc');
  SetPropertyFromNode(node,'Gtin');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Shelf');
  SetPropertyFromNode(node,'ProductType');
  SetPropertyFromNode(node,'Price_Currency');
  SetPropertyFromNode(node,'Price_Amount');
  SetPropertyFromNode(node,'PublishedStatus');
  SetPropertyFromNode(node,'AvailabilityCode');
  SetBooleanPropertyFromNode(node,'Synched');
  SetPropertyFromNode(node,'NameValueAttributes_Name');
  SetPropertyFromNode(node,'NameValueAttributes_Type');
  SetPropertyFromNode(node,'ERPProductId');
  SetPropertyFromNode(node,'fulfillmentLagTime');
  SetPropertyFromNode(node,'MinfulfillmentLagTime');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMMult');
  SetPropertyFromNode(node,'UOMQty');
end;


procedure Twalmartitems.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Mart' ,Mart);
  AddXMLNode(node,'Sku' ,Sku);
  AddXMLNode(node,'WpID' ,WpID);
  AddXMLNode(node,'Upc' ,Upc);
  AddXMLNode(node,'Gtin' ,Gtin);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Shelf' ,Shelf);
  AddXMLNode(node,'ProductType' ,ProductType);
  AddXMLNode(node,'Price_Currency' ,Price_Currency);
  AddXMLNode(node,'Price_Amount' ,Price_Amount);
  AddXMLNode(node,'PublishedStatus' ,PublishedStatus);
  AddXMLNode(node,'AvailabilityCode' ,AvailabilityCode);
  AddXMLNode(node,'Synched' ,Synched);
  AddXMLNode(node,'NameValueAttributes_Name' ,NameValueAttributes_Name);
  AddXMLNode(node,'NameValueAttributes_Type' ,NameValueAttributes_Type);
  AddXMLNode(node,'ERPProductId' ,ERPProductId);
  AddXMLNode(node,'fulfillmentLagTime' ,fulfillmentLagTime);
  AddXMLNode(node,'MinfulfillmentLagTime' ,MinfulfillmentLagTime);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMMult' ,UOMMult);
  AddXMLNode(node,'UOMQty' ,UOMQty);
end;


function Twalmartitems.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
           if (Appenv.comPanyprefs.WALMART_ProductNameField ='P') and (ProductName = '' )  then begin
    Resultstatus.AddItem(False, rsswarning, 0, 'Product Name links Walmart Product To ERP Table. Product Name should not be Blank' ,True);
    Exit;
  end else if (Appenv.comPanyprefs.WALMART_ProductNameField ='S') and (SKU = '' )  then begin
    Resultstatus.AddItem(False, rsswarning, 0, 'SKU (Stock Keeping Unit) links Walmart Product To ERP Table. SKU (Stock Keeping Unit) should not be Blank' ,True);
    Exit;
(*  end else if (Appenv.comPanyprefs.WALMART_ProductNameField ='U') and (UPC = '' )  then begin
    Resultstatus.AddItem(False, rsswarning, 0, 'UPC (Universal Product Code) links Walmart Product To ERP Table. UPC (Universal Product Code) should not be Blank' ,True);
    Exit;
  end else if (Appenv.comPanyprefs.WALMART_ProductNameField ='G') and (GTIN = '' )  then begin
    Resultstatus.AddItem(False, rsswarning, 0, 'GTIN (Global Trade Item Number) links Walmart Product To ERP Table. GTIN (Global Trade Item Number) should not be Blank' ,True);
    Exit;
  end else if (Appenv.comPanyprefs.WALMART_ProductNameField ='W') and (WPID = '' )  then begin
    Resultstatus.AddItem(False, rsswarning, 0, 'WPID (Walmart Product ID) links Walmart Product To ERP Table. WPID (Walmart Product ID) should not be Blank' ,True);
    Exit;*)
  end else if (ProductName = '' ) then begin
    Resultstatus.AddItem(False, rsswarning, 0, 'Product Name links Walmart Product To ERP Table. Product Name should not be Blank' ,True);
    Exit;
  end;
  Result := True;
end;


function Twalmartitems.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartitems.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function Twalmartitems.ProductSearchSQL: String;
begin
  result := 'Partname = ' + quotedstr(ProductnameforERP);
end;

procedure Twalmartitems.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ERPProductId') then begin
    if (trim(Price_Amount)='') and (ERPProductId <> 0) then begin
      Price_Amount := floattostr(ProductPrice1inc(ERPProductId));
    end;
  end;
end;

function Twalmartitems.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartitems.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartitems.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartitems';
end;


function Twalmartitems.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Price_Currency := Appenv.RegionalOptions.ForeignExDefault;
end;

function Twalmartitems.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twalmartitems.GetMart                    : string    ; begin Result := GetStringField('Mart');end;
function  Twalmartitems.GetSku                     : string    ; begin Result := GetStringField('Sku');end;
function  Twalmartitems.GetWpID                    : string    ; begin Result := GetStringField('WpID');end;
function  Twalmartitems.GetUpc                     : string    ; begin Result := GetStringField('Upc');end;
function  Twalmartitems.GetGtin                    : string    ; begin Result := GetStringField('Gtin');end;
function  Twalmartitems.GetProductName             : string    ; begin Result := GetStringField('ProductName');end;
function  Twalmartitems.GetShelf                   : string    ; begin Result := GetStringField('Shelf');end;
function  Twalmartitems.GetProductType             : string    ; begin Result := GetStringField('ProductType');end;
function  Twalmartitems.GetPrice_Currency          : string    ; begin Result := GetStringField('Price_Currency');end;
function  Twalmartitems.GetPrice_Amount            : string    ; begin Result := GetStringField('Price_Amount');end;
function  Twalmartitems.GetPublishedStatus         : string    ; begin Result := GetStringField('PublishedStatus');end;
function  Twalmartitems.GetAvailabilityCode        : string    ; begin Result := GetStringField('AvailabilityCode');end;
function  Twalmartitems.GetSynched                 : Boolean   ; begin Result := GetBooleanField('Synched');end;
function  Twalmartitems.GetNameValueAttributes_Name: string    ; begin Result := GetStringField('NameValueAttributes_Name');end;
function  Twalmartitems.GetNameValueAttributes_Type: string    ; begin Result := GetStringField('NameValueAttributes_Type');end;
function  Twalmartitems.GetERPProductId            : Integer   ; begin Result := GetIntegerField('ERPProductId');end;
function  Twalmartitems.GetfulfillmentLagTime      : Integer   ; begin Result := GetIntegerField('fulfillmentLagTime');end;
function  Twalmartitems.GetMinfulfillmentLagTime   : Integer   ; begin Result := GetIntegerField('MinfulfillmentLagTime');end;
function  Twalmartitems.GetUOMID                   : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  Twalmartitems.GetUOM                     : string    ; begin Result := GetStringField('UOM');end;
function  Twalmartitems.GetUOMMult                 : Double    ; begin Result := GetfloatField('UOMMult');end;
function  Twalmartitems.GetUOMQty                  : Double    ; begin Result := GetfloatField('UOMQty');end;
procedure Twalmartitems.SetMart                    (const Value: string    ); begin SetStringField('Mart'                     , Value);end;
procedure Twalmartitems.SetSku                     (const Value: string    ); begin SetStringField('Sku'                      , Value);end;
procedure Twalmartitems.SetWpID                    (const Value: string    ); begin SetStringField('WpID'                     , Value);end;
procedure Twalmartitems.SetUpc                     (const Value: string    ); begin SetStringField('Upc'                      , Value);end;
procedure Twalmartitems.SetGtin                    (const Value: string    ); begin SetStringField('Gtin'                     , Value);end;
procedure Twalmartitems.SetProductName             (const Value: string    ); begin SetStringField('ProductName'              , Value);end;
procedure Twalmartitems.SetShelf                   (const Value: string    ); begin SetStringField('Shelf'                    , Value);end;
procedure Twalmartitems.SetProductType             (const Value: string    ); begin SetStringField('ProductType'              , Value);end;
procedure Twalmartitems.SetPrice_Currency          (const Value: string    ); begin SetStringField('Price_Currency'           , Value);end;
procedure Twalmartitems.SetPrice_Amount            (const Value: string    ); begin SetStringField('Price_Amount'             , Value);end;
procedure Twalmartitems.SetPublishedStatus         (const Value: string    ); begin SetStringField('PublishedStatus'          , Value);end;
procedure Twalmartitems.SetAvailabilityCode        (const Value: string    ); begin SetStringField('AvailabilityCode'         , Value);end;
procedure Twalmartitems.SetSynched                 (const Value: Boolean   ); begin SetBooleanField('Synched'                 , Value);end;
procedure Twalmartitems.SetNameValueAttributes_Name(const Value: string    ); begin SetStringField('NameValueAttributes_Name' , Value);end;
procedure Twalmartitems.SetNameValueAttributes_Type(const Value: string    ); begin SetStringField('NameValueAttributes_Type' , Value);end;
procedure Twalmartitems.SetERPProductId            (const Value: Integer   ); begin SetIntegerField('ERPProductId'            , Value);end;
procedure Twalmartitems.SetfulfillmentLagTime      (const Value: Integer   ); begin SetIntegerField('fulfillmentLagTime'      , Value);end;
procedure Twalmartitems.SetMinfulfillmentLagTime   (const Value: Integer   ); begin SetIntegerField('MinfulfillmentLagTime'   , Value);end;
procedure Twalmartitems.SetUOMID                   (const Value: Integer   ); begin SetIntegerField('UOMID'                   , Value);end;
procedure Twalmartitems.SetUOM                     (const Value: string    ); begin SetStringField('UOM'                      , Value);end;
procedure Twalmartitems.SetUOMMult                 (const Value: Double    ); begin SetFloatField('UOMMult'                   , Value);end;
procedure Twalmartitems.SetUOMQty                  (const Value: Double    ); begin SetFloatField('UOMQty'                    , Value);end;
function Twalmartitems.getProductnameforERP: String;
begin
       if Sametext(Appenv.comPanyprefs.WALMART_ProductNameField ,'P') then result := ProductName
  else if Sametext(Appenv.comPanyprefs.WALMART_ProductNameField ,'S') then result := SKU
  else REsult := ProductName;
end;
function Twalmartitems.getProductDescriptionforERP: String;
begin
       if Sametext(Appenv.comPanyprefs.WALMART_ProductNameField ,'s') then result := ProductName
  else if Sametext(Appenv.comPanyprefs.WALMART_ProductNameField ,'p') then result := SKU
  else REsult := sku;
end;
Procedure Twalmartitems.ChecknMakeERPProduct(onCreateProduct:TNotifyEvent);
var
  ProductSimple : TProductSimple;
begin
        ProductSimple := TProductSimple.create(nil);
        try
          with ProductSimple do begin
            connection :=connection;
            LoadSelect(ProductSearchSQL);
            if count =0 then begin
              new;
              try Productname         := ProductnameforERP;         Except end;
              try ProductPrintName    := Productname;                           Except end;
              try SalesDescription    :=  ProductDescriptionforERP; Except end;
              try PurchaseDescription :=  ProductDescriptionforERP; Except end;
              try SellQty1Price :=  strTofloat(Price_Amount);       Except on E:Exception do begin SellQty1Price :=  0; end; end;
              try PostDB; Except end;
              if Assigned(onCreateProduct) then onCreateProduct(ProductSimple);
            end;
            ERPProductId := ID;
            PostDB;
          end;
        finally
          Freeandnil(ProductSimple);
        end;

end;

initialization
  RegisterClass(Twalmartitems);
  RegisterClass(Twalmartnamevalueattributevalues);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Walmart Products','Twalmartitems','TWalmartItemsGUI');
end.
