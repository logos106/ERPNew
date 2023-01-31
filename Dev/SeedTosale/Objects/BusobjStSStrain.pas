unit BusobjStSStrain;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  08/01/20  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TStSStrain = class(TMSBusObj)
  private
    fbCreateDefaultProducts           : Boolean;
    function GetImmatureProductID     : Integer   ;
    function GetVegetativeProductId   : Integer   ;
    function GetFloweringProductID    : Integer   ;
    function GetHarvestProductId      : Integer   ;
    function GetImmatureProductName   : String;
    function GetVegetativeProductName : String;
    function GetFloweringProductName  : String;
    function GetHarvestProductName    : String;
    function GetStrainname            : string    ;
    function GetTested                : Boolean   ;
    function GetTestedInHouse         : Boolean   ;
    function GetTestedByID            : Integer   ;
    function GetTestedBy              : string    ;
    function GetTHC_Content           : Double    ;
    function GetCBD_Content           : Double    ;
    function GetIndica                : Double    ;
    function GetSativa                : Double    ;
    procedure SetImmatureProductID    (const Value: Integer   );
    procedure SetVegetativeProductId  (const Value: Integer   );
    procedure SetFloweringProductID   (const Value: Integer   );
    procedure SetHarvestProductId     (const Value: Integer   );
    procedure SetImmatureProductName  (const Value: String    );
    procedure SetVegetativeProductName(const Value: String    );
    procedure SetFloweringProductName (const Value: String    );
    procedure SetHarvestProductName   (const Value: String    );
    procedure SetStrainname           (const Value: string    );
    procedure SetTested               (const Value: Boolean   );
    procedure SetTestedInHouse        (const Value: Boolean   );
    procedure SetTestedByID           (const Value: Integer   );
    procedure SetTestedBy             (const Value: string    );
    procedure SetTHC_Content          (const Value: Double    );
    procedure SetCBD_Content          (const Value: Double    );
    procedure SetIndica               (const Value: Double    );
    procedure SetSativa               (const Value: Double    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function ExcludeFromclone:String; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField             : string;              Override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function CopyStSDetails(CopyFromID:Integer):Integer;
    property ImmatureProductID    :Integer     read GetImmatureProductID    write SetImmatureProductID;
    property VegetativeProductId  :Integer     read GetVegetativeProductId  write SetVegetativeProductId;
    property FloweringProductID   :Integer     read GetFloweringProductID   write SetFloweringProductID;
    property HarvestProductId     :Integer     read GetHarvestProductId     write SetHarvestProductId;
    property TestedByID           :Integer     read GetTestedByID           write SetTestedByID      ;
    procedure DoCreateDefaultProducts(UseDefaultName:Boolean =true; IProductname:String = ''; VProductname:String = ''; Fproductname:String = '';HProductname :String = '');
  published
    property Strainname           :string      read GetStrainname            write SetStrainname      ;
    property Tested               :Boolean     read GetTested                write SetTested          ;
    property TestedInHouse        :Boolean     read GetTestedInHouse         write SetTestedInHouse   ;
    property TestedBy             :string      read GetTestedBy              write SetTestedBy        ;
    property THC_Content          :Double      read GetTHC_Content           write SetTHC_Content     ;
    property CBD_Content          :Double      read GetCBD_Content           write SetCBD_Content     ;
    property Indica               :Double      read GetIndica                write SetIndica          ;
    property Sativa               :Double      read GetSativa                write SetSativa          ;
    Property CreateDefaultProducts:Boolean     read fbCreateDefaultProducts  write fbCreateDefaultProducts;
    property ImmatureProductName  :string      read GetImmatureProductName   write setImmatureProductName  ;
    property VegetativeProductName:string      read GetVegetativeProductName write setVegetativeProductName;
    property FloweringProductName :string      read GetFloweringProductName  write setFloweringProductName ;
    property HarvestProductName   :string      read GetHarvestProductName    write setHarvestProductName   ;
  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib , Sysutils, BusobjProduct, BusObjConst,
  DbSharedObjectsObj, BusObjectListObj, BusObjClient,  BusObjEmployee,
  BusobjUOM, AppEnvironment;


  {TStSStrain}

Function  TStSStrain.CopyStSDetails(CopyFromID: Integer):Integer;
begin
  Result := 0;
  if CopyFromID =0 then exit;
  if CloneBusObj('', '', false) <> nil then
    result := ObjInstanceToClone.ID;
end;

constructor TStSStrain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'StSParts';
  fSQL := 'SELECT * FROM tblStSStrains';
  fbCreateDefaultProducts := False;
  ExportExcludeList.Add('CreateDefaultProducts');
end;


destructor TStSStrain.Destroy;
begin
  inherited;
end;


procedure TStSStrain.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ImmatureProductID');
  SetPropertyFromNode(node,'VegetativeProductId');
  SetPropertyFromNode(node,'FloweringProductID');
  SetPropertyFromNode(node,'HarvestProductId');
  SetPropertyFromNode(node,'Strainname');
  SetBooleanPropertyFromNode(node,'Tested');
  SetBooleanPropertyFromNode(node,'TestedInHouse');
  SetPropertyFromNode(node,'TestedByID');
  SetPropertyFromNode(node,'TestedBy');
  SetPropertyFromNode(node,'THC_Content');
  SetPropertyFromNode(node,'CBD_Content');
  SetPropertyFromNode(node,'Indica');
  SetPropertyFromNode(node,'Sativa');
end;


procedure TStSStrain.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Strainname' ,Strainname);
  AddXMLNode(node,'Tested' ,Tested);
  AddXMLNode(node,'TestedInHouse' ,TestedInHouse);
  AddXMLNode(node,'TestedByID' ,TestedByID);
  AddXMLNode(node,'TestedBy' ,TestedBy);
  AddXMLNode(node,'THC_Content' ,THC_Content);
  AddXMLNode(node,'CBD_Content' ,CBD_Content);
  AddXMLNode(node,'Indica' ,Indica);
  AddXMLNode(node,'Sativa' ,Sativa);
end;


function TStSStrain.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if StrainName = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Provide the Strain Name' , true );
    Exit;
  end;
  if CreateDefaultProducts then
    DoCreateDefaultProducts;
  if ImmatureProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Immature Product should not be blank' , true );
    Exit;
  end;
  if VegetativeProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Vegetative Product should not be blank' , true );
    Exit;
  end;
  if FloweringProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Flowering Product should not be blank' , true );
    Exit;
  end;
  if HarvestProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Harvest Product should not be blank' , true );
    Exit;
  end;
  TUnitofmeasure.CreateNewUOM(Self, HarvestProductId, Appenv.companyprefs.StsConfig.StsDEfaultWeightUOM);
  Result := True;
end;


function TStSStrain.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then exit;
end;
procedure TStSStrain.DoCreateDefaultProducts(UseDefaultName:Boolean =true;  IProductname:String = ''; VProductname:String = ''; Fproductname:String = '';HProductname :String = '');
procedure MakeProduct(var aProductname:String; aPhase:String);
begin
      if (trim(aProductname) = '') and UseDefaultName then aProductname := aPhase +' - '+trim(StrainName);
      if (trim(aProductname) <> '') then   TProductSimple.MakeProduct(aProductname,nil,False,Appenv.Companyprefs.StSUsesBins,true,False, '', aPhase +'^'+StrainName);
end;
begin
  if StrainName = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please Provide the Strain Name' , true );
    Exit;
  end;
    if ImmatureProductID    = 0 then MakeProduct(IProductname , 'Immature');
    if VegetativeProductId  = 0 then MakeProduct(VProductname , 'Vegitative');
    if FloweringProductID   = 0 then MakeProduct(Fproductname , 'Flowering');
    if HarvestProductID     = 0 then MakeProduct(HProductname , 'Harvest');

    if IProductname <> '' then ImmatureProductID  := TProductSimple.idtoggle(IProductname);
    if VProductname <> '' then VegetativeProductID:= TProductSimple.idtoggle(VProductname);
    if FProductname <> '' then FloweringProductID := TProductSimple.idtoggle(FProductname);
    if HProductname <> '' then HarvestProductID   := TProductSimple.idtoggle(HProductname);
end;

procedure TStSStrain.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStSStrain.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'THC_Content') then begin
    CBD_Content  := 100 - THC_Content;
  end else if Sysutils.SameText(Sender.fieldName, 'CBD_Content') then begin
     THC_Content := 100 - CBD_Content;
  end else if Sysutils.SameText(Sender.fieldName, 'TestedInHouse') then begin
    if TestedInHouse then begin
      TestedBy := '';
      TestedById := 0
    end;
  end else if Sysutils.SameText(Sender.fieldName, 'Indica') then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_sts_Indica);
  end else if Sysutils.SameText(Sender.fieldName, 'Sativa') then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_sts_Sativa);
  end else if Sysutils.SameText(Sender.fieldName, 'TestedByID') then begin
    if TestedByID <> 0 then
      TestedBy := TSupplier.idtoggle(TestedByID);
  end else if Sysutils.SameText(Sender.fieldName, 'TestedBy') then begin
    if TestedBy <> '' then
      TestedByID := TSupplier.idtoggle(TestedBy);
  end;
end;


function TStSStrain.ExcludeFromclone: String;
begin
  REsult :=  quotedstr('Strainname') ;
end;

function TStSStrain.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSStrain.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSStrain.GetBusObjectTablename: string;
begin
  Result:= 'tblStSStrains';
end;


function TStSStrain.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TStSStrain.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
class function TStSStrain.GetKeyStringField: string;
begin
  Result := 'Strainname';
end;

{Property Functions}
function  TStSStrain.GetImmatureProductID    : Integer  ; begin Result := GetIntegerField('ImmatureProductID');end;
function  TStSStrain.GetVegetativeProductId  : Integer  ; begin Result := GetIntegerField('VegetativeProductId');end;
function  TStSStrain.GetFloweringProductID   : Integer  ; begin Result := GetIntegerField('FloweringProductID');end;
function  TStSStrain.GetHarvestProductId     : Integer  ; begin Result := GetIntegerField('HarvestProductId');end;
function  TStSStrain.GetImmatureProductName  : string   ; begin Result := TProductsimple.IDToggle(ImmatureProductID);end;
function  TStSStrain.GetVegetativeProductName: string   ; begin Result := TProductsimple.IDToggle(VegetativeProductId);end;
function  TStSStrain.GetFloweringProductName : string   ; begin Result := TProductsimple.IDToggle(FloweringProductID);end;
function  TStSStrain.GetHarvestProductName   : string   ; begin Result := TProductsimple.IDToggle(HarvestProductId);end;
function  TStSStrain.GetStrainname           : string   ; begin Result := GetStringField('Strainname');end;
function  TStSStrain.GetTested               : Boolean  ; begin Result := GetBooleanField('Tested');end;
function  TStSStrain.GetTestedInHouse        : Boolean  ; begin Result := GetBooleanField('TestedInHouse');end;
function  TStSStrain.GetTestedByID           : Integer  ; begin Result := GetIntegerField('TestedByID');end;
function  TStSStrain.GetTestedBy             : string   ; begin Result := GetStringField('TestedBy');end;
function  TStSStrain.GetTHC_Content          : Double   ; begin Result := GetFloatField('THC_Content');end;
function  TStSStrain.GetCBD_Content          : Double   ; begin Result := GetFloatField('CBD_Content');end;
function  TStSStrain.GetIndica               : Double   ; begin Result := GetFloatField('Indica');end;
function  TStSStrain.GetSativa               : Double   ; begin Result := GetFloatField('Sativa');end;
procedure TStSStrain.SetImmatureProductID  (const Value: Integer   ); begin SetIntegerField('ImmatureProductID'         , Value);end;
procedure TStSStrain.SetVegetativeProductId(const Value: Integer   ); begin SetIntegerField('VegetativeProductId'       , Value);end;
procedure TStSStrain.SetFloweringProductID (const Value: Integer   ); begin SetIntegerField('FloweringProductID'        , Value);end;
procedure TStSStrain.SetHarvestProductId   (const Value: Integer   ); begin SetIntegerField('HarvestProductId'          , Value);end;
procedure TStSStrain.SetImmatureProductName  (const Value: String    ); begin (*SetIntegerField('ImmatureProductID'       , TProductsimple.IDToggle(Value));*) DoCreateDefaultProducts(False,           Value);  end;
procedure TStSStrain.SetVegetativeProductName(const Value: String    ); begin (*SetIntegerField('VegetativeProductId'     , TProductsimple.IDToggle(Value));*) DoCreateDefaultProducts(False, '',       Value);  end;
procedure TStSStrain.SetFloweringProductName (const Value: String    ); begin (*SetIntegerField('FloweringProductID'      , TProductsimple.IDToggle(Value));*) DoCreateDefaultProducts(False, '','',    Value);  end;
procedure TStSStrain.SetHarvestProductName   (const Value: String    ); begin (*SetIntegerField('HarvestProductId'        , TProductsimple.IDToggle(Value));*) DoCreateDefaultProducts(False, '','','', Value);  end;

procedure TStSStrain.SetStrainname         (const Value: string    ); begin SetStringField('Strainname'        , Value);end;
procedure TStSStrain.SetTested             (const Value: Boolean   ); begin SetBooleanField('Tested'           , Value);end;
procedure TStSStrain.SetTestedInHouse      (const Value: Boolean   ); begin SetBooleanField('TestedInHouse'    , Value);end;
procedure TStSStrain.SetTestedByID         (const Value: Integer   ); begin SetIntegerField('TestedByID'       , Value);end;
procedure TStSStrain.SetTestedBy           (const Value: string    ); begin SetStringField('TestedBy'          , Value);end;
procedure TStSStrain.SetTHC_Content        (const Value: Double    ); begin SetFloatField('THC_Content'        , Value);end;
procedure TStSStrain.SetCBD_Content        (const Value: Double    ); begin SetFloatField('CBD_Content'        , Value);end;
procedure TStSStrain.SetIndica             (const Value: Double    ); begin SetFloatField('Indica'             , Value);end;
procedure TStSStrain.SetSativa             (const Value: Double    ); begin SetFloatField('Sativa'             , Value);end;


initialization
  RegisterClass(TStSStrain);
end.
