unit BusobjProductQtySum;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/10/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TProductQtySum = class(TMSBusObj)
  private
    function GetProductId          : Integer   ;
    Function getProductname        : String    ;
    function GetDepartmentId       : Integer   ;
    Function getDepartmentName     : String    ;
    function GetUOMID              : Integer   ;
    Function getuomname            : String    ;
    Function getUOM                : String    ;
    function GetInStock            : Double    ;
    function GetAvailable          : Double    ;
    function GetAllocatedSO        : Double    ;
    function GetPOBO               : Double    ;
    function GetSOBO               : Double    ;
    function GetInvBO              : Double    ;
    function GetOnBuild            : Double    ;
    function GetBuilding           : Double    ;
    function GetOnTransitin        : Double    ;
    function GetOnTransitOut       : Double    ;
    function Getneedsupdate        : Boolean   ;
    procedure SetProductId          (const Value: Integer   );
    Procedure SetProductname        (Const Value: String    );
    procedure SetDepartmentId       (const Value: Integer   );
    Procedure SetDepartmentName     (Const Value: String    );
    procedure SetUOMID              (const Value: Integer   );
    Procedure Setuomname            (Const Value: String    );
    Procedure SetUOM                (Const Value: String    );
    procedure SetInStock            (const Value: Double    );
    procedure SetAvailable          (const Value: Double    );
    procedure SetAllocatedSO        (const Value: Double    );
    procedure SetPOBO               (const Value: Double    );
    procedure SetSOBO               (const Value: Double    );
    procedure SetInvBO              (const Value: Double    );
    procedure SetOnBuild            (const Value: Double    );
    procedure SetBuilding           (const Value: Double    );
    procedure SetOnTransitin        (const Value: Double    );
    procedure SetOnTransitOut       (const Value: Double    );
    procedure Setneedsupdate        (const Value: Boolean   );
    function getUpdateProductQtyPreferenceSelected: Boolean;
    function getUpdateProductQtyPreferenceMsg: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
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
    property needsupdate         :Boolean     read Getneedsupdate       write Setneedsupdate    ;
    procedure Load(const fIsReadonly: boolean = False); Override;
    function APIListDefaultProperties: string; override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property ProductId           :Integer     read GetProductId         write SetProductId      ;
    Property Productname         : String     read getProductname       write setProductname    ;
    property DepartmentId        :Integer     read GetDepartmentId      write SetDepartmentId   ;
    Property DepartmentName      : String     read getDepartmentName    write setDepartmentName ;
    property UOMID               :Integer     read GetUOMID             write SetUOMID          ;
    Property uomname             : String     read getuomname           write setuomname        ;
    Property UOM                 : String     read getUOM               write setUOM            ;
    property InStock             :Double      read GetInStock           write SetInStock        ;
    property Available           :Double      read GetAvailable         write SetAvailable      ;
    property AllocatedSO         :Double      read GetAllocatedSO       write SetAllocatedSO    ;
    property POBO                :Double      read GetPOBO              write SetPOBO           ;
    property SOBO                :Double      read GetSOBO              write SetSOBO           ;
    property InvBO               :Double      read GetInvBO             write SetInvBO          ;
    property OnBuild             :Double      read GetOnBuild           write SetOnBuild        ;
    property Building            :Double      read GetBuilding          write SetBuilding       ;
    property OnTransitin         :Double      read GetOnTransitin       write SetOnTransitin    ;
    property OnTransitOut        :Double      read GetOnTransitOut      write SetOnTransitOut   ;
    Property UpdateProductQtyPreferenceSelected :Boolean read getUpdateProductQtyPreferenceSelected;
    Property UpdateProductQtyPreferenceMsg :String read getUpdateProductQtyPreferenceMsg;
  end;
  TProductQtySumAPIGroup = class(TProductQtySum)
    Private
    Protected
    Public
      constructor  Create(AOwner: TComponent); override;
      function APIListDefaultProperties: string; override;
    published
  end;

implementation


uses tcDataUtils, CommonLib, BusObjectListObj, AppEnvironment;



  {TProductQtySum}

function TProductQtySum.APIListDefaultProperties: string;
begin
    result := result + 'ProductId,Productname,DepartmentName,uomname,UOM,InStock,Available,AllocatedSO,POBO,SOBO,InvBO,OnBuild,Building,OnTransitin,OnTransitOut';
end;

constructor TProductQtySum.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProductQtySum';
  fSQL := 'SELECT * FROM tblproductqtysum';
end;


destructor TProductQtySum.Destroy;
begin
  inherited;
end;


procedure TProductQtySum.Load(const fIsReadonly: boolean);
begin
  inherited;
end;

procedure TProductQtySum.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'DepartmentId');
  SetPropertyFromNode(node,'DepartmentName');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UnitName');
  SetPropertyFromNode(node,'InStock');
  SetPropertyFromNode(node,'Available');
  SetPropertyFromNode(node,'AllocatedSO');
  SetPropertyFromNode(node,'POBO');
  SetPropertyFromNode(node,'SOBO');
  SetPropertyFromNode(node,'InvBO');
  SetPropertyFromNode(node,'OnBuild');
  SetPropertyFromNode(node,'Building');
  SetPropertyFromNode(node,'OnTransitin');
  SetPropertyFromNode(node,'OnTransitOut');
  SetBooleanPropertyFromNode(node,'needsupdate');
end;


procedure TProductQtySum.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'DepartmentId' ,DepartmentId);
  AddXMLNode(node,'DepartmentName' ,DepartmentName);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'uomname' ,uomname);
  AddXMLNode(node,'InStock' ,InStock);
  AddXMLNode(node,'Available' ,Available);
  AddXMLNode(node,'AllocatedSO' ,AllocatedSO);
  AddXMLNode(node,'POBO' ,POBO);
  AddXMLNode(node,'SOBO' ,SOBO);
  AddXMLNode(node,'InvBO' ,InvBO);
  AddXMLNode(node,'OnBuild' ,OnBuild);
  AddXMLNode(node,'Building' ,Building);
  AddXMLNode(node,'OnTransitin' ,OnTransitin);
  AddXMLNode(node,'OnTransitOut' ,OnTransitOut);
  AddXMLNode(node,'needsupdate' ,needsupdate);
end;


function TProductQtySum.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TProductQtySum.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProductQtySum.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProductQtySum.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProductQtySum.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductQtySum.GetIDField: string;
begin
  Result := 'ProductId';
end;


class function TProductQtySum.GetBusObjectTablename: string;
begin
  Result:= 'tblproductqtysum';
end;


function TProductQtySum.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProductQtySum.GetProductId      : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TProductQtySum.GetProductname    : String    ; begin Result := GetStringfield('Productname');end;
function  TProductQtySum.GetDepartmentId   : Integer   ; begin Result := GetIntegerField('DepartmentId');end;
function  TProductQtySum.GetDepartmentName : String    ; begin Result := GetStringfield('DepartmentName');end;
function  TProductQtySum.GetUOMID          : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TProductQtySum.Getuomname        : String    ; begin Result := GetStringfield('uomname');end;
function  TProductQtySum.GetUOM            : String    ; begin Result := GetStringfield('UOM');end;
function  TProductQtySum.GetInStock        : Double    ; begin Result := GetFloatField('InStock');end;
function  TProductQtySum.GetAvailable      : Double    ; begin Result := GetFloatField('Available');end;
function  TProductQtySum.GetAllocatedSO    : Double    ; begin Result := GetFloatField('AllocatedSO');end;
function  TProductQtySum.GetPOBO           : Double    ; begin Result := GetFloatField('POBO');end;
function  TProductQtySum.GetSOBO           : Double    ; begin Result := GetFloatField('SOBO');end;
function  TProductQtySum.GetInvBO          : Double    ; begin Result := GetFloatField('InvBO');end;
function  TProductQtySum.GetOnBuild        : Double    ; begin Result := GetFloatField('OnBuild');end;
function  TProductQtySum.GetBuilding       : Double    ; begin Result := GetFloatField('Building');end;
function  TProductQtySum.GetOnTransitin    : Double    ; begin Result := GetFloatField('OnTransitin');end;
function  TProductQtySum.GetOnTransitOut   : Double    ; begin Result := GetFloatField('OnTransitOut');end;
function  TProductQtySum.Getneedsupdate    : Boolean   ; begin Result := GetBooleanField('needsupdate');end;
procedure TProductQtySum.SetProductId      (const Value: Integer   ); begin SetIntegerField('ProductId'       , Value);end;
procedure TProductQtySum.SetProductname    (Const Value: String    ); begin SetStringfield('Productname'      , Value); end;
procedure TProductQtySum.SetDepartmentId   (const Value: Integer   ); begin SetIntegerField('DepartmentId'    , Value);end;
procedure TProductQtySum.SetDepartmentName (Const Value: String    ); begin SetStringfield('DepartmentName'   , Value); end;
procedure TProductQtySum.SetUOMID          (const Value: Integer   ); begin SetIntegerField('UOMID'           , Value);end;
procedure TProductQtySum.Setuomname        (Const Value: String    ); begin SetStringfield('uomname'          , Value); end;
procedure TProductQtySum.SetUOM            (Const Value: String    ); begin SetStringfield('UOM'          , Value); end;
procedure TProductQtySum.SetInStock        (const Value: Double    ); begin SetFloatField('InStock'         , Value);end;
procedure TProductQtySum.SetAvailable      (const Value: Double    ); begin SetFloatField('Available'       , Value);end;
procedure TProductQtySum.SetAllocatedSO    (const Value: Double    ); begin SetFloatField('AllocatedSO'     , Value);end;
procedure TProductQtySum.SetPOBO           (const Value: Double    ); begin SetFloatField('POBO'            , Value);end;
procedure TProductQtySum.SetSOBO           (const Value: Double    ); begin SetFloatField('SOBO'            , Value);end;
procedure TProductQtySum.SetInvBO          (const Value: Double    ); begin SetFloatField('InvBO'           , Value);end;
procedure TProductQtySum.SetOnBuild        (const Value: Double    ); begin SetFloatField('OnBuild'         , Value);end;
procedure TProductQtySum.SetBuilding       (const Value: Double    ); begin SetFloatField('Building'        , Value);end;
procedure TProductQtySum.SetOnTransitin    (const Value: Double    ); begin SetFloatField('OnTransitin'     , Value);end;
procedure TProductQtySum.SetOnTransitOut   (const Value: Double    ); begin SetFloatField('OnTransitOut'    , Value);end;
procedure TProductQtySum.Setneedsupdate    (const Value: Boolean   ); begin SetBooleanField('needsupdate'     , Value);end;
function TProductQtySum.getUpdateProductQtyPreferenceSelected: Boolean;
begin
  Result := Appenv.CompanyPrefs.doUpdateProductQtySum;
end;
function TProductQtySum.getUpdateProductQtyPreferenceMsg: String;
begin
  REsult := '';
  if not Appenv.CompanyPrefs.doUpdateProductQtySum then
    REsult := 'The Preference to "Update Product Qty Sum for API List" is not Active ';
end;


function TProductQtySumAPIGroup.APIListDefaultProperties: string;
begin
    result := result + 'ProductId,Productname,InStock,Available,AllocatedSO,POBO,SOBO,InvBO,OnBuild,Building,OnTransitin,OnTransitOut';
end;

constructor TProductQtySumAPIGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  isreadonly := True;
  fBusObjectTypeDescription:= 'ProductQtySumAPI';
  fSQL :=  ' SELECT '+
           ' 0 as ProductQtySumId, '+
           ' ProductId, '+
           ' 0 AS UOMID, '+
           ' Productname, '+
           ' "" as DepartmentName, '+
           ' "" as UOM, '+
           ' "" unitname , '+
           ' sum(PQS.InStock) AS InStock, '+
           ' sum(PQS.Available) AS Available, '+
           ' sum(PQS.AllocatedSO) AS AllocatedSO, '+
           ' sum(PQS.POBO) AS POBO, '+
           ' sum(PQS.SOBO) AS SOBO, '+
           ' sum(PQS.InvBO) AS InvBO, '+
           ' sum(PQS.OnBuild) AS OnBuild, '+
           ' sum(PQS.Building) AS Building, '+
           ' sum(PQS.OnTransitin + PQS.OnTransitOut) AS OnTransit, '+
           ' Max(PQS.msTimestamp) AS ason '+
           ' FROM tblProductQtySum PQS ';
fSQLGroup := 'ProductID';
end;

initialization
  RegisterClass(TProductQtySum);
  RegisterClass(TProductQtySumAPIGroup);
  (*BusObjectListObj.TBusObjInfoList.Inst.Add('ProductQtySumAPI','TProductQtySumAPI','TProductSumQtyListGUI');
  BusObjectListObj.TBusObjInfoList.Inst.Add('ProductQtySumAPIGroup','TProductQtySumAPIGroup','TProductSumQtyListGUI');*)
end.
