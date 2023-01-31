unit BusobjcolumnHeadings;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/01/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TColumnHeadings = class(TMSBusObj)
  private
    function GetFirstColumn           : string    ;
    function GetSecondColumnName      : string    ;
    function GetThirdColumnName       : string    ;
    function GetPartColumnName        : string    ;
    function GetCustomerColumnName    : string    ;
    function GetSupplierColumnName    : string    ;
    function GetProspectColumnName    : string    ;
    function GetDefaultClass          : string    ;
    function GetDefaultUOM            : string    ;
    function GetClassHeading          : string    ;
    function GetAllocationBatchnoName : String   ;
    function GetAllocationExpiryDateName : String   ;
    function GetAllocationTruckLoadNoName : String   ;
    function GetEquipmentName : String   ;
    function GetHireName : String   ;
    procedure SetFirstColumn          (const Value: string    );
    procedure SetSecondColumnName     (const Value: string    );
    procedure SetThirdColumnName      (const Value: string    );
    procedure SetPartColumnName       (const Value: string    );
    procedure SetCustomerColumnName   (const Value: string    );
    procedure SetSupplierColumnName   (const Value: string    );
    procedure SetProspectColumnName   (const Value: string    );
    procedure SetDefaultClass         (const Value: string    );
    procedure SetDefaultUOM           (const Value: string    );
    procedure SetClassHeading         (const Value: string    );
    procedure SetAllocationBatchnoName(const Value: String   );
    procedure SetAllocationExpiryDateName(const Value: String   );
    procedure SetAllocationTruckLoadNoName(const Value: String   );
    procedure SetEquipmentName(const Value: String   );
    procedure SetHireName(const Value: String   );
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
    property FirstColumn          :string     read GetFirstColumn           write SetFirstColumn     ;
    property SecondColumnName     :string     read GetSecondColumnName      write SetSecondColumnName;
    property ThirdColumnName      :string     read GetThirdColumnName       write SetThirdColumnName ;
    property PartColumnName       :string     read GetPartColumnName        write SetPartColumnName  ;
    property CustomerColumnName   :string     read GetCustomerColumnName    write SetCustomerColumnName;
    property SupplierColumnName   :string     read GetSupplierColumnName    write SetSupplierColumnName;
    property ProspectColumnName   :string     read GetProspectColumnName    write SetProspectColumnName;
    property DefaultClass         :string     read GetDefaultClass          write SetDefaultClass    ;
    property DefaultUOM           :string     read GetDefaultUOM            write SetDefaultUOM      ;
    property ClassHeading         :string     read GetClassHeading          write SetClassHeading    ;
    property AllocationBatchNoName:String     read GetAllocationBatchnoName write SetAllocationBatchnoName ;
    property AllocationExpiryDateName:String     read GetAllocationExpiryDateName write SetAllocationExpiryDateName ;
    property AllocationTruckLoadNoName:String     read GetAllocationTruckLoadNoName write SetAllocationTruckLoadNoName ;
    property EquipmentName:String     read GetEquipmentName write SetEquipmentName ;
    property HireName:String     read GetHireName write SetHireName ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tcolumnheadings}

constructor Tcolumnheadings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'columnheadings';
  fSQL := 'SELECT * FROM tblcolumnheadings';
end;


destructor Tcolumnheadings.Destroy;
begin
  inherited;
end;


procedure Tcolumnheadings.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FirstColumn');
  SetPropertyFromNode(node,'SecondColumnName');
  SetPropertyFromNode(node,'ThirdColumnName');
  SetPropertyFromNode(node,'PartColumnName');
  SetPropertyFromNode(node,'CustomerColumnName');
  SetPropertyFromNode(node,'SupplierColumnName');
  SetPropertyFromNode(node,'ProspectColumnName');
  SetPropertyFromNode(node,'DefaultClass');
  SetPropertyFromNode(node,'DefaultUOM');
  SetPropertyFromNode(node,'ClassHeading');
  SetPropertyFromNode(node,'AllocationBatchnoName');
  SetPropertyFromNode(node,'AllocationExpiryDateName');
  SetPropertyFromNode(node,'AllocationTruckLoadNoName');
  SetPropertyFromNode(node,'EquipmentName');
  SetPropertyFromNode(node,'HireName');
end;


procedure Tcolumnheadings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FirstColumn' ,FirstColumn);
  AddXMLNode(node,'SecondColumnName' ,SecondColumnName);
  AddXMLNode(node,'ThirdColumnName' ,ThirdColumnName);
  AddXMLNode(node,'PartColumnName' ,PartColumnName);
  AddXMLNode(node,'CustomerColumnName' ,CustomerColumnName);
  AddXMLNode(node,'SupplierColumnName' ,SupplierColumnName);
  AddXMLNode(node,'ProspectColumnName' ,ProspectColumnName);
  AddXMLNode(node,'DefaultClass' ,DefaultClass);
  AddXMLNode(node,'DefaultUOM' ,DefaultUOM);
  AddXMLNode(node,'ClassHeading' ,ClassHeading);
  AddXMLNode(node,'AllocationBatchnoName' ,AllocationBatchnoName);
  AddXMLNode(node,'AllocationExpiryDateName' ,AllocationExpiryDateName);
  AddXMLNode(node,'AllocationTruckLoadNoName' ,AllocationTruckLoadNoName);
  AddXMLNode(node,'EquipmentName' ,EquipmentName);
  AddXMLNode(node,'HireName' ,HireName);
end;


function Tcolumnheadings.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Tcolumnheadings.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tcolumnheadings.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tcolumnheadings.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tcolumnheadings.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tcolumnheadings.GetIDField: string;
begin
  Result := 'ColumnheadingsID'
end;


class function Tcolumnheadings.GetBusObjectTablename: string;
begin
  Result:= 'tblcolumnheadings';
end;


function Tcolumnheadings.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tcolumnheadings.GetFirstColumn            : string    ; begin Result := GetStringField('FirstColumn');end;
function  Tcolumnheadings.GetSecondColumnName       : string    ; begin Result := GetStringField('SecondColumnName');end;
function  Tcolumnheadings.GetThirdColumnName        : string    ; begin Result := GetStringField('ThirdColumnName');end;
function  Tcolumnheadings.GetPartColumnName         : string    ; begin Result := GetStringField('PartColumnName');end;
function  Tcolumnheadings.GetCustomerColumnName     : string    ; begin Result := GetStringField('CustomerColumnName');end;
function  Tcolumnheadings.GetSupplierColumnName     : string    ; begin Result := GetStringField('SupplierColumnName');end;
function  Tcolumnheadings.GetProspectColumnName     : string    ; begin Result := GetStringField('ProspectColumnName');end;
function  Tcolumnheadings.GetDefaultClass           : string    ; begin Result := GetStringField('DefaultClass');end;
function  Tcolumnheadings.GetDefaultUOM             : string    ; begin Result := GetStringField('DefaultUOM');end;
function  Tcolumnheadings.GetClassHeading           : string    ; begin Result := GetStringField('ClassHeading');end;
function  Tcolumnheadings.GetAllocationBatchnoName  : String    ; begin Result := GetStringField('AllocationBatchnoName'); if result = '' then result := 'Batch No';end;
function  Tcolumnheadings.GetAllocationExpiryDateName   : String; begin Result := GetStringField('AllocationExpiryDateName'); if result = '' then result := 'Expiry Date';end;
function  Tcolumnheadings.GetAllocationTruckLoadNoName  : String; begin Result := GetStringField('AllocationTruckLoadNoName'); if result = '' then result := 'Truck Load No';end;
function  Tcolumnheadings.GetEquipmentName          : String    ; begin Result := GetStringField('EquipmentName'); if result = '' then result := 'Equipment';end;
function  Tcolumnheadings.GetHireName               : String    ; begin Result := GetStringField('HireName'); if result = '' then result := 'Hire';end;
procedure Tcolumnheadings.SetFirstColumn            (const Value: string    ); begin SetStringField('FirstColumn'      , Value);end;
procedure Tcolumnheadings.SetSecondColumnName       (const Value: string    ); begin SetStringField('SecondColumnName' , Value);end;
procedure Tcolumnheadings.SetThirdColumnName        (const Value: string    ); begin SetStringField('ThirdColumnName' , Value);end;
procedure Tcolumnheadings.SetPartColumnName         (const Value: string    ); begin SetStringField('PartColumnName'   , Value);end;
procedure Tcolumnheadings.SetCustomerColumnName     (const Value: string    ); begin SetStringField('CustomerColumnName'   , Value);end;
procedure Tcolumnheadings.SetSupplierColumnName     (const Value: string    ); begin SetStringField('SupplierColumnName'   , Value);end;
procedure Tcolumnheadings.SetProspectColumnName     (const Value: string    ); begin SetStringField('ProspectColumnName'   , Value);end;
procedure Tcolumnheadings.SetDefaultClass           (const Value: string    ); begin SetStringField('DefaultClass'     , Value);end;
procedure Tcolumnheadings.SetDefaultUOM             (const Value: string    ); begin SetStringField('DefaultUOM'     , Value);end;
procedure Tcolumnheadings.SetClassHeading           (const Value: string    ); begin SetStringField('ClassHeading'     , Value);end;
procedure Tcolumnheadings.SetAllocationBatchnoName  (const Value: String   ); begin SetStringField('AllocationBatchnoName', Value);end;
procedure Tcolumnheadings.SetAllocationExpiryDateName  (const Value: String); begin SetStringField('AllocationExpiryDateName', Value);end;
procedure Tcolumnheadings.SetAllocationTruckLoadNoName (const Value: String); begin SetStringField('AllocationTruckLoadNoName', Value);end;
procedure Tcolumnheadings.SetEquipmentName (const Value: String); begin SetStringField('EquipmentName', Value);end;
procedure Tcolumnheadings.SetHireName      (const Value: String); begin SetStringField('HireName', Value);end;

initialization
  RegisterClass(TColumnHeadings);

end.
