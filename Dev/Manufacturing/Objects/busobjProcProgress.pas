unit busobjProcProgress;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/10/16  1.00.00  A.  Initial Version.
  }


interface


uses DNMAccessManager, BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjpqa;


type
  TProcProgress = class(TProdQty)
  private
    function GetEmployeeId          : Integer   ;
    function GetReasonID            : Integer   ;
    function GetProcTreeId          : Integer   ;
    function GetProcTreePartID      : Integer   ;
    function GetProgressdate        : TDateTime ;
    function GetUOMID               : Integer   ;
    function GetInProcProgressId    : Integer   ;
    Function getBuildStatus         : String;
    Function getProductUnitCost     : double;
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetReasonID            (const Value: Integer   );
    procedure SetProcTreeId          (const Value: Integer   );
    procedure SetProcTreePartID      (const Value: Integer   );
    procedure SetProgressdate        (const Value: TDateTime );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetAlloctype           (const Value: string    );
    procedure SetClassId             (const Value: Integer);
    procedure SetInProcProgressId    (const Value: Integer   );
    Procedure SetBuildStatus         (Const Value: String);
    Procedure SetProductUnitCost     (Const Value: Double);
    Function ISWastage:Boolean;
    function IsOutitem:Boolean;
    function getOutAmount:Double;
    function getInAmount:Double;
    function ProcTreeCost: Double;
    function ProcTreeQuantity: Double;
    procedure CalcCostnPrice;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DefaultAlloctype:String;Virtual;Abstract;

    function GetQty             : Double;   override;
    function GetUOMQty          : Double;   override;
    function GetUOMMultiplier   : Double;   override;
    Function GetAllocType       : String;   override;
    function GetClassID         : Integer;  override;
    function GetUnitOfMeasure   : String;   override;

    procedure SetQty          (const Value: Double);override;
    procedure SetUOMQty       (const Value: Double);override;
    procedure SetUOMMultiplier(const Value: Double);override;


    function GetSerialnos       : String;   override;
    function GetCleanClassID   : Integer;  override;
    function GetcleanProductId  : Integer;  override;
    function GetHeaderID       : Integer;  override;
    function GetUnitOfMeasureID: Integer;  override;
    function GetTransDate       : TDatetime; override;
    procedure SetSerialNos(const Value: String);        override;
    procedure SetUnitOfMeasure(const Value: String);    override;
    procedure SetUnitOfMeasureID(const Value: Integer); override;
    Function  GetIsPQAItem       :Boolean;   override;
    function GetActive: boolean; override;
    procedure SetActive(const Value: Boolean); override;
    function GetProductID :Integer; override;
    function GetProductName :String; override;
    function GetMatrixDesc: String;override;
    function GetMatrixPrice: Double;override;
    function GetMatrixRef: String;override;

    procedure SetProductID(const Value: Integer); override;
    procedure SetProductName(const Value: String); override;
    function GetBOQty: double; override;
    function GetBOUOMQty: double; override;
    procedure SetBOQty(const Value: Double); override;
    procedure SetBOUOMQty(const Value: Double); override;
    function GetEnableAllocation :Boolean; override;
    function GetOrderQty         :Double; override;
    function GetUOMOrderQty      :Double; override;
    procedure SetOrderQty(const Value: Double); override;
    procedure SetUOMOrderQty(const Value: Double); override;
    function GetProductType: string;override;
    procedure SetProductType(const Value: string);override;
    procedure SetTransDate(const Value: TDatetime); override;
    procedure SetMatrixDesc(const Value: String);  override;
    procedure SetMatrixPrice(const Value: Double);override;
    procedure SetMatrixRef(const Value: String);override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function     Logdata:String;
    Procedure InOutamt(var fdInamt, fdOutamt: Double);
    Property inAmount:Double read getInAmount;
    Property OutAmount:Double read getOutAmount;
  published
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property ReasonID             :Integer     read GetReasonID           write SetReasonID        ;
    property ProcTreeId           :Integer     read GetProcTreeId         write SetProcTreeId      ;
    property ClassID              :Integer     read GetClassID            write SetClassID         ;
    property ProcTreePartID       :Integer     read GetProcTreePartID     write SetProcTreePartID  ;
    property Progressdate         :TDateTime   read GetProgressdate       write SetProgressdate    ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property UOMMultiplier        :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    property Alloctype            :string      read GetAlloctype          write SetAlloctype       ;
    property InProcProgressId     :Integer     read GetInProcProgressId   write SetInProcProgressId;
    Property BuildStatus          :String      read getBuildStatus        write SetBuildStatus;
    Property ProductUnitCost      :Double      read getProductUnitCost    write setProductUnitCost;
  end;
  TProcProgressIn = class(TProcProgress)
    Protected
      function  DefaultAlloctype:String;Override;
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Public
      function Save:boolean ; Override;
  end;
  TProcProgressOUT = class(TProcProgress)
    Protected
      function  DefaultAlloctype:String;Override;
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  end;

implementation


uses tcDataUtils, CommonLib, BusObjProcTreePart, BusObjProcess,sysutils,
  ERPdbComponents, AppEnvironment, LogLib, BusObjConst, BusobjProctree, BusObjStock,
  DbSharedObjectsObj, BusObjProcPrefs, tcConst;



  {TProcProgress}

constructor TProcProgress.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'procprogress';
  fSQL := 'SELECT * FROM tblprocprogress';
end;


destructor TProcProgress.Destroy;
begin
  inherited;
end;


procedure TProcProgress.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'ReasonID');
  SetPropertyFromNode(node,'ProcTreeId');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'ProcTreePartID');
  SetDateTimePropertyFromNode(node,'Progressdate');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'Alloctype');
  SetPropertyFromNode(node,'InProcProgressId');
  SetPropertyFromNode(node,'BuildStatus');
  SetPropertyFromNode(node,'ProductUnitCost');
end;


function TProcProgress.Logdata: String;
begin
  Result := inttostr(ID) +',' +
       ProductName+','+
       formatDatetime('dd/mm/yyyy hh:nn:ss am/pm' , Progressdate )+',' +
       Floattostr(Qty)+','+
       Alloctype+',' +
       BuildStatus +','+
       Booltostr(Active)+','+
       inttostr(InProcProgressId);
end;

procedure TProcProgress.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'ReasonID' ,ReasonID);
  AddXMLNode(node,'ProcTreeId' ,ProcTreeId);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'ProcTreePartID' ,ProcTreePartID);
  AddXMLNode(node,'Progressdate' ,Progressdate);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'Alloctype' ,Alloctype);
  AddXMLNode(node,'InProcProgressId' ,InProcProgressId);
  AddXMLNode(node,'BuildStatus' ,BuildStatus);
  AddXMLNode(node,'ProductUnitCost' ,ProductUnitCost);
end;


function TProcProgress.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TProcProgress.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  SendEvent(BusobjEvent_ToDo , BusObjEventVal_OnAfterSave, self);
end;

procedure TProcProgress.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcProgress.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'UOMQty') then begin
    Qty:= UOMQty * UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'Qty') then begin
    UOMQty:= Qty / UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ProctreeID') then begin
    CalcCostnPrice;
  end  else if Sysutils.SameText(Sender.FieldName, 'ProductID') then begin
    CalcCostnPrice;
  end;
end;
Procedure TProcProgress.CalcCostnPrice;
var
  qry: TERPQuery;
begin
  if (ProctreeID=0) or (ProductID=0) then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.connection);
  try
    Qry.SQL.text := 'Select * from tblproctree where proctreeId =' + inttostr(ProctreeID);
    Qry.open;
    if Qry.recordcount =1 then begin
      if ProcPrefs.UseCurrentCostforProgressBuild and not(Qry.Fieldbyname('TreePricechanged').asBoolean) then begin
          productunitcost  := Round(TProduct.AvgCost(ProductId, Self.Connection.Connection),GeneralRoundPlaces);
          if productunitcost =0 then productunitcost  := TProduct.CalcAvgCost(ProductId); // if product card's avg cost is not updated, then calculate it
          if productunitcost =0 then  productunitcost  := Qry.Fieldbyname('productunitcost').AsFloat; // if product's avg cost is blank, then use the tree cost
      end else begin
          productunitcost  := Qry.Fieldbyname('productunitcost').AsFloat;
      end;
    end else begin
      productunitcost  := Qry.Fieldbyname('productunitcost').AsFloat;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function TProcProgress.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcProgress.GetIDField: string;
begin
  Result := 'ProcProgressID'
end;


class function TProcProgress.GetBusObjectTablename: string;
begin
  Result:= 'tblprocprogress';
end;


function TProcProgress.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if Owner is TProcTreePart then begin
      AllocType       := DefaultAlloctype;
      ProcTreePartID  := TProcTreePart(owner).Id;
      ProcTreeId      := TProcTreePart(owner).ProcTreeId;
      EmployeeId      := appenv.Employee.EmployeeID;
      ProductID       := TProcTreePart(owner).ProductId;
      ClassID         := TProcTreePart(owner).ClassID;
      Unitofmeasure   := TProcTreePart(owner).Unitofmeasure;
      UOMID           := TProcTreePart(owner).UnitofmeasureID;
      UOMMultiplier   := TProcTreePart(owner).UOMMultiplier;
    end;
end;

function TProcProgress.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if isPQAItem then begin
    if pqa.count >0 then begin
      if (*(BuildStatus = 'W') or *)(BuildStatus = 'H') or (BuildStatus = 'B') then pqa.active := False else pqa.active := TRue;
      pqa.PostDB;
    end;
  end;
end;

{Property Functions}
function  TProcProgress.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TProcProgress.GetReasonID        : Integer   ; begin Result := GetIntegerField('ReasonID');end;
function  TProcProgress.GetProcTreeId      : Integer   ; begin Result := GetIntegerField('ProcTreeId');end;
function  TProcProgress.GetClassID         : Integer   ; begin Result := GetIntegerField('ClassID');end;
function  TProcProgress.GetProcTreePartID  : Integer   ; begin Result := GetIntegerField('ProcTreePartID');end;
function  TProcProgress.GetProductId       : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TProcProgress.GetProgressdate    : TDateTime ; begin Result := GetDateTimeField('Progressdate');end;
function  TProcProgress.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function  TProcProgress.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function TProcProgress.IsOutitem           : Boolean   ; begin Result := Alloctype ='OUT';end;
function TProcProgress.ISWastage           : Boolean   ; begin Result :=BuildStatus ='W';end;
function  TProcProgress.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TProcProgress.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TProcProgress.GetAlloctype       : string    ; begin Result := GetStringField('Alloctype');end;
function  TProcProgress.GetInProcProgressId: Integer   ; begin Result := GetIntegerField('InProcProgressId');end;
function  TProcProgress.getBuildStatus     : String    ; begin Result := GetStringField('BuildStatus');end;
function  TProcProgress.GetProductUnitCost : Double    ; begin Result := GetFloatField('ProductUnitCost');end;
procedure TProcProgress.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TProcProgress.SetReasonID        (const Value: Integer   ); begin SetIntegerField('ReasonID'       , Value);end;
procedure TProcProgress.SetProcTreeId      (const Value: Integer   ); begin SetIntegerField('ProcTreeId'       , Value);end;
procedure TProcProgress.SetClassID         (const Value: Integer   ); begin SetIntegerField('ClassID'       , Value);end;
procedure TProcProgress.SetProcTreePartID  (const Value: Integer   ); begin SetIntegerField('ProcTreePartID'   , Value);end;
procedure TProcProgress.SetProductId       (const Value: Integer   ); begin SetIntegerField('ProductId'   , Value);end;
procedure TProcProgress.SetProgressdate    (const Value: TDateTime ); begin SetDateTimeField('Progressdate'     , Value);end;
procedure TProcProgress.SetQty             (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;
procedure TProcProgress.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'           , Value);end;
procedure TProcProgress.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure TProcProgress.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TProcProgress.SetAlloctype       (const Value: string    ); begin SetStringField('Alloctype'        , Value);end;
procedure TProcProgress.SetInProcProgressId(const Value: Integer   ); begin SetIntegerField('InProcProgressId', Value);end;
procedure TProcProgress.SetBuildStatus     (const Value: String    ); begin SetStringField('BuildStatus', Value);end;
procedure TProcProgress.SetProductUnitCost (const Value: Double    ); begin SetFloatField('ProductUnitCost', Value);end;
Function TProcProgress.GetSerialnos       : String;   begin Result := '';end;
Function TProcProgress.GetCleanClassID    : Integer;  begin Result:= GetXMLNodeIntegerValue(CleanXMLNode, 'ClassId');end;
Function TProcProgress.GetcleanProductId  : Integer;  begin Result:= GetXMLNodeIntegerValue(CleanXMLNode, 'ProductId');end;
Function TProcProgress.GetUnitOfMeasure   : String;   begin Result:= GetStringField('UOM');end;
Function TProcProgress.GetUnitOfMeasureID : Integer;  begin Result:= GetIntegerField('UOMID');end;
Function TProcProgress.GetTransDate       : TDatetime;begin Result:= GetdateTimefield('Progressdate'); end;
Function TProcProgress.GetActive          : boolean;  begin Result := getBooleanField('Active'); end;
Function TProcProgress.GetProductName     : String;   begin Result := getProduct(ProductID); end;
Function TProcProgress.GetBOQty           : double;   begin Result :=0; end;
Function TProcProgress.GetBOUOMQty        : double;   begin Result :=0; end;
Function TProcProgress.GetEnableAllocation: Boolean;  begin Result:= false;end;
Function TProcProgress.GetOrderQty        : Double;   begin Result:= self.Qty;end;
Function TProcProgress.GetUOMOrderQty     : Double;   begin Result:= self.UOMQty;end;
function TProcProgress.GetProductType     : string;   begin Result := Product.ProductType ; end;
function TProcProgress.GetMatrixRef       : String;   begin Result := '';end;
function TProcProgress.GetMatrixDesc      : String;   begin Result := '';end;
function TProcProgress.GetMatrixPrice     : Double;   begin Result := 0;end;
Function TProcProgress.GetIsPQAItem       : Boolean;
begin
  REsult := (not(IsWastage) or IsOutitem );
  if not result then exit;

  if getContainerComponentifExists(TProduct)<> nil then result:= Commonlib.IsInvProduct(Product.ProductType)
  else if ProductID   <> 0  then result:= tcDataUtils.Is_Inv_Product(ProductID)
  else if ProductName <> '' then result:= tcDataUtils.Is_Inv_Product(ProductName)
  else result := False;

  //Result:= Commonlib.IsInvProduct(Product.ProductType) and (not(IsWastage) or IsOutitem );
end;

procedure TProcProgress.SetActive         (const Value: Boolean   ); begin SetbooleanField('Active' , Value);end;
procedure TProcProgress.SetBOQty          (const Value: Double    ); begin end;
procedure TProcProgress.SetBOUOMQty       (const Value: Double    ); begin end;
procedure TProcProgress.SetProductName    (const Value: String    ); begin ProductId := GetProduct(Value); end;
Procedure TProcProgress.SetSerialNos      (const Value: String    ); begin end;
Procedure TProcProgress.SetUnitOfMeasure  (const Value: String    ); begin SetStringField('UOM', Value);end;
Procedure TProcProgress.SetUnitOfMeasureID(const Value: Integer   ); begin SetIntegerField('UOMID', Value); end;
Procedure TProcProgress.SetOrderQty       (const Value: Double    ); begin self.Qty:= Value;end;
Procedure TProcProgress.SetUOMOrderQty    (const Value: Double    ); begin self.UOMQty:= Value;end;
Procedure TProcProgress.SetProductType    (const Value: string    ); begin end;
Procedure TProcProgress.SetTransDate      (const Value: TDatetime ); begin SetdateTimefield('Progressdate', Value);end;
Procedure TProcProgress.SetMatrixDesc     (const Value: String    );begin end;
Procedure TProcProgress.SetMatrixPrice    (const Value: Double    );begin end;
Procedure TProcProgress.SetMatrixRef      (const Value: String    );begin end;
Function TProcProgress.GetHeaderID        : Integer;
begin
  Result:= 0;
  if owner is TProcTreePart then
    Result := TProcTreePart(owner).headerID
  else  if Owner is TSalesLineProcTree then
    Result:= TSalesLineProcTree(Owner).SalesLine.SaleId;
end;
function TProcProgress.getInAmount:Double;
begin
  REsult := 0;
    if alloctype = 'IN' then
      result:= (Qty * ProcTreeCost /ProcTreeQuantity);
end;
function TProcProgress.ProcTreeCost:Double;
var
  aProctree :TProctree;
begin
  REsult := 0;
  if Assigned(Owner) then
    if (Owner is TProctree) then aProctree := TProctree(Owner)
  else if (owner is TProctreePart) and (Assigned(Owner.owner))  and (owner.owner is TProctree ) then aProctree:= TProctree(Owner.Owner)
  else exit;
  result := aProctree.cost;
end;
function TProcProgress.ProcTreeQuantity:Double;
var
  aProctree :TProctree;
begin
  REsult := 0;
  if Assigned(Owner) then
    if (Owner is TProctree) then aProctree := TProctree(Owner)
  else if (owner is TProctreePart) and (Assigned(Owner.owner))  and (owner.owner is TProctree ) then aProctree:= TProctree(Owner.Owner)
  else exit;
  if aProctree.ParentId <> 0 then result := aProctree.Quantity else result := aProctree.totalQty;
end;

function TProcProgress.getOutAmount:Double;
begin
  REsult := 0;
    if alloctype = 'OUT' then
      result:= (Qty * ProcTreeCost /ProcTreeQuantity);

end;

procedure TProcProgress.InOutamt(var fdInamt, fdOutamt: Double);
begin
  fdInAmt := fdInAmt + inamount;
  fdoutAmt := fdoutAmt + outamount;
end;

{ TProcProgressIn }

function TProcProgressIn.DefaultAlloctype: String;
begin
  REsult := 'IN';
end;

function TProcProgressIn.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
end;

function TProcProgressIn.Save: boolean;
var
  TempCost : Double;
begin
  result := Inherited Save;
  if not result then exit;
  UpdateproductAverageCost(Tempcost , True);
end;

{ TProcProgressOUT }

function TProcProgressOUT.DefaultAlloctype: String;
begin
  Result :='OUT'
end;

function TProcProgressOUT.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
end;

initialization
  RegisterClass(TProcProgress);


end.
