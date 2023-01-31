unit BusObjManifest;

interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  Tmanifestvehicles = class(TMSBusObj)
  private
    function GetVehicleName         : string    ;
    function GetOwnerName           : string    ;
    function GetDriver              : string    ;
    function GetPhone               : string    ;
    function GetRegistrationNo      : string    ;
    function GetTrailer             : string    ;
    function GetNotes               : string    ;
    function GetActive              : Boolean   ;
    function GetSupplierID          : Integer   ;
    function GetPercentageRate      : Double    ;
    procedure SetVehicleName         (const Value: string    );
    procedure SetOwnerName           (const Value: string    );
    procedure SetDriver              (const Value: string    );
    procedure SetPhone               (const Value: string    );
    procedure SetRegistrationNo      (const Value: string    );
    procedure SetTrailer             (const Value: string    );
    procedure SetNotes               (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    procedure SetSupplierID          (const Value: Integer   );
    procedure SetPercentageRate      (const Value: Double    );
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
    property VehicleName          :string      read GetVehicleName        write SetVehicleName     ;
    property OwnerName            :string      read GetOwnerName          write SetOwnerName       ;
    property Driver               :string      read GetDriver             write SetDriver          ;
    property Phone                :string      read GetPhone              write SetPhone           ;
    property RegistrationNo       :string      read GetRegistrationNo     write SetRegistrationNo  ;
    property Trailer              :string      read GetTrailer            write SetTrailer         ;
    property Notes                :string      read GetNotes              write SetNotes           ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property SupplierID           :Integer     read GetSupplierID         write SetSupplierID      ;
    property PercentageRate       :Double      read GetPercentageRate     write SetPercentageRate  ;
  end;

  Tmanifestroutes = class(TMSBusObj)
  private
    function GetRouteFrom           : string    ;
    function GetRouteTo             : string    ;
    function GetRouteDesc           : string    ;
    function GetDistance            : Integer   ;
    function GetPaletteRate         : Double    ;
    procedure SetRouteFrom           (const Value: string    );
    procedure SetRouteTo             (const Value: string    );
    procedure SetRouteDesc           (const Value: string    );
    procedure SetDistance            (const Value: Integer   );
    procedure SetPaletteRate         (const Value: Double    );
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
    property RouteFrom            :string      read GetRouteFrom          write SetRouteFrom       ;
    property RouteTo              :string      read GetRouteTo            write SetRouteTo         ;
    property RouteDesc            :string      read GetRouteDesc          write SetRouteDesc       ;
    property Distance             :Integer     read GetDistance           write SetDistance        ;
    property PaletteRate          :Double      read GetPaletteRate        write SetPaletteRate     ;
  end;
  Tmanifestlines = class(TMSBusObj)
  private
    function GetManifestID          : Integer   ;
    function GetSaleLineID          : Integer   ;
    function GetInvoiceLineID          : Integer   ;
    //function GetSaleID              : Integer   ;
    function GetDeleted             : Boolean;
    function GetETA                 : TDateTime ;
    function GetPageNo              : Integer   ;
    procedure SetManifestID          (const Value: Integer   );
    procedure SetSaleLineID          (const Value: Integer   );
    procedure SetInvoiceLineID          (const Value: Integer   );
    //procedure SetSaleID              (const Value: Integer   );
    Procedure SetDeleted             (const Value :Boolean);
    procedure SetETA                 (const Value: TDateTime );
    procedure SetPageNo              (const Value: Integer   );
    function getInvoiceID: Integer;
    function getSOID: Integer;
    function getSaleId: Integer;
    procedure SetInvoiceId(const Value: integer);
    procedure SetSOID(const Value: integer);
    (*function getSalesLine: TSalesLine;
    function getSale: TSales;*)
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
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
//    Property  InvoiceID:Integer read getInvoiceID;
//    Property  SOID:Integer read getSOID;
    Property SaleID :Integer read getSaleId;

    (*Property    Salesline :TSalesLine read getSalesLine;
    Property    Sale :TSales read getSale;*)
  published
    property ManifestID           :Integer     read GetManifestID         write SetManifestID      ;
    property SaleLineID           :Integer     read GetSaleLineID         write SetSaleLineID      ;
    property InvoiceLineID           :Integer     read GetInvoiceLineID         write SetInvoiceLineID      ;
    //property SaleID               :Integer     read GetSaleID             write SetSaleID      ;
    Property Deleted              :Boolean     read getDeleted            write SetDeleted;
    property ETA                  :TDateTime   read GetETA                write SetETA             ;
    property PageNo               :Integer     read GetPageNo             write SetPageNo          ;
    property SOID : integer read GetSOID write SetSOID;
    property InvoiceId : integer read GetInvoiceId write SetInvoiceId;

  end;
  TManifest = class(TMSBusObj)
  private
    function GetDespatchDate        : TDateTime ;
    function GetOwnerName           : string    ;
    function GetDriver              : string    ;
    function GetPhone               : string    ;
    function GetNotes               : string    ;
    function GetVehicleID           : Integer   ;
    function GetTrailer             : string    ;
    function GetFromCity            : string    ;
    function GetFromState           : string    ;
    function GetFromPostcode        : string    ;
    function GetToCity              : string    ;
    function GetToState             : string    ;
    function GetToPostcode          : string    ;
    function GetCompleted           : Boolean   ;
    function GetEmployeeId          : Integer   ;
    function GetFinalETA            : TDateTime ;
    function GetManifestRouteID     : Integer   ;
    function GetDistance            : Integer   ;
    function GetVehicleName         : string    ;
    function GetBillID              : Integer   ;
    procedure SetDespatchDate        (const Value: TDateTime );
    procedure SetOwnerName           (const Value: string    );
    procedure SetDriver              (const Value: string    );
    procedure SetPhone               (const Value: string    );
    procedure SetNotes               (const Value: string    );
    procedure SetVehicleID           (const Value: Integer   );
    procedure SetTrailer             (const Value: string    );
    procedure SetFromCity            (const Value: string    );
    procedure SetFromState           (const Value: string    );
    procedure SetFromPostcode        (const Value: string    );
    procedure SetToCity              (const Value: string    );
    procedure SetToState             (const Value: string    );
    procedure SetToPostcode          (const Value: string    );
    procedure SetCompleted           (const Value: Boolean   );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetFinalETA            (const Value: TDateTime );
    procedure SetManifestRouteID     (const Value: Integer   );
    procedure SetDistance            (const Value: Integer   );
    procedure SetVehicleName         (const Value: string    );
    procedure SetBillID              (const Value: Integer   );
    function getLines: Tmanifestlines;
    function getManifestroute: Tmanifestroutes;
    function getmanifestvehicle: Tmanifestvehicles;
    function DeleteFlaggedLines: boolean;
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
    Property Manifestroute :Tmanifestroutes read getManifestroute;
    Property Manifestvehicle :Tmanifestvehicles REad getmanifestvehicle;

  published
    property DespatchDate         :TDateTime   read GetDespatchDate       write SetDespatchDate    ;
    property OwnerName            :string      read GetOwnerName          write SetOwnerName       ;
    property Driver               :string      read GetDriver             write SetDriver          ;
    property Phone                :string      read GetPhone              write SetPhone           ;
    property Notes                :string      read GetNotes              write SetNotes           ;
    property VehicleID            :Integer     read GetVehicleID          write SetVehicleID       ;
    property Trailer              :string      read GetTrailer            write SetTrailer         ;
    property FromCity             :string      read GetFromCity           write SetFromCity        ;
    property FromState            :string      read GetFromState          write SetFromState       ;
    property FromPostcode         :string      read GetFromPostcode       write SetFromPostcode    ;
    property ToCity               :string      read GetToCity             write SetToCity          ;
    property ToState              :string      read GetToState            write SetToState         ;
    property ToPostcode           :string      read GetToPostcode         write SetToPostcode      ;
    property Completed            :Boolean     read GetCompleted          write SetCompleted       ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property FinalETA             :TDateTime   read GetFinalETA           write SetFinalETA        ;
    property ManifestRouteID      :Integer     read GetManifestRouteID    write SetManifestRouteID ;
    property Distance             :Integer     read GetDistance           write SetDistance        ;
    property VehicleName          :string      read GetVehicleName        write SetVehicleName     ;
    property BillID               :Integer     read GetBillID             write SetBillID          ;
    Property Lines                :Tmanifestlines read getLines;
  end;


implementation


uses tcDataUtils, CommonLib, SysUtils, AppEnvironment;



  {Tmanifestvehicles}

constructor Tmanifestvehicles.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'manifestvehicles';
  fSQL := 'SELECT * FROM tblmanifestvehicles';
end;


destructor Tmanifestvehicles.Destroy;
begin
  inherited;
end;


procedure Tmanifestvehicles.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'VehicleName');
  SetPropertyFromNode(node,'OwnerName');
  SetPropertyFromNode(node,'Driver');
  SetPropertyFromNode(node,'Phone');
  SetPropertyFromNode(node,'RegistrationNo');
  SetPropertyFromNode(node,'Trailer');
  SetPropertyFromNode(node,'Notes');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'SupplierID');
  SetPropertyFromNode(node,'PercentageRate');
end;


procedure Tmanifestvehicles.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'VehicleName' ,VehicleName);
  AddXMLNode(node,'OwnerName' ,OwnerName);
  AddXMLNode(node,'Driver' ,Driver);
  AddXMLNode(node,'Phone' ,Phone);
  AddXMLNode(node,'RegistrationNo' ,RegistrationNo);
  AddXMLNode(node,'Trailer' ,Trailer);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'SupplierID' ,SupplierID);
  AddXMLNode(node,'PercentageRate' ,PercentageRate);
end;


function Tmanifestvehicles.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Tmanifestvehicles.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tmanifestvehicles.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tmanifestvehicles.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tmanifestvehicles.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tmanifestvehicles.GetIDField: string;
begin
  Result := 'VehicleID'
end;


class function Tmanifestvehicles.GetBusObjectTablename: string;
begin
  Result:= 'tblmanifestvehicles';
end;


function Tmanifestvehicles.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tmanifestvehicles.GetVehicleName     : string    ; begin Result := GetStringField('VehicleName');end;
function  Tmanifestvehicles.GetOwnerName       : string    ; begin Result := GetStringField('OwnerName');end;
function  Tmanifestvehicles.GetDriver          : string    ; begin Result := GetStringField('Driver');end;
function  Tmanifestvehicles.GetPhone           : string    ; begin Result := GetStringField('Phone');end;
function  Tmanifestvehicles.GetRegistrationNo  : string    ; begin Result := GetStringField('RegistrationNo');end;
function  Tmanifestvehicles.GetTrailer         : string    ; begin Result := GetStringField('Trailer');end;
function  Tmanifestvehicles.GetNotes           : string    ; begin Result := GetStringField('Notes');end;
function  Tmanifestvehicles.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  Tmanifestvehicles.GetSupplierID      : Integer   ; begin Result := GetIntegerField('SupplierID');end;
function  Tmanifestvehicles.GetPercentageRate  : Double    ; begin Result := GetFloatField('PercentageRate');end;
procedure Tmanifestvehicles.SetVehicleName     (const Value: string    ); begin SetStringField('VehicleName'      , Value);end;
procedure Tmanifestvehicles.SetOwnerName       (const Value: string    ); begin SetStringField('OwnerName'        , Value);end;
procedure Tmanifestvehicles.SetDriver          (const Value: string    ); begin SetStringField('Driver'           , Value);end;
procedure Tmanifestvehicles.SetPhone           (const Value: string    ); begin SetStringField('Phone'            , Value);end;
procedure Tmanifestvehicles.SetRegistrationNo  (const Value: string    ); begin SetStringField('RegistrationNo'   , Value);end;
procedure Tmanifestvehicles.SetTrailer         (const Value: string    ); begin SetStringField('Trailer'          , Value);end;
procedure Tmanifestvehicles.SetNotes           (const Value: string    ); begin SetStringField('Notes'            , Value);end;
procedure Tmanifestvehicles.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure Tmanifestvehicles.SetSupplierID      (const Value: Integer   ); begin SetIntegerField('SupplierID'       , Value);end;
procedure Tmanifestvehicles.SetPercentageRate  (const Value: Double    ); begin SetFloatField('PercentageRate'   , Value);end;


  {Tmanifestroutes}

constructor Tmanifestroutes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'manifestroutes';
  fSQL := 'SELECT * FROM tblmanifestroutes';
end;


destructor Tmanifestroutes.Destroy;
begin
  inherited;
end;


procedure Tmanifestroutes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RouteFrom');
  SetPropertyFromNode(node,'RouteTo');
  SetPropertyFromNode(node,'RouteDesc');
  SetPropertyFromNode(node,'Distance');
  SetPropertyFromNode(node,'PaletteRate');
end;


procedure Tmanifestroutes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RouteFrom' ,RouteFrom);
  AddXMLNode(node,'RouteTo' ,RouteTo);
  AddXMLNode(node,'RouteDesc' ,RouteDesc);
  AddXMLNode(node,'Distance' ,Distance);
  AddXMLNode(node,'PaletteRate' ,PaletteRate);
end;


function Tmanifestroutes.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Tmanifestroutes.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tmanifestroutes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tmanifestroutes.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tmanifestroutes.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tmanifestroutes.GetIDField: string;
begin
  Result := 'ManifestRouteID'
end;


class function Tmanifestroutes.GetBusObjectTablename: string;
begin
  Result:= 'tblmanifestroutes';
end;


function Tmanifestroutes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tmanifestroutes.GetRouteFrom       : string    ; begin Result := GetStringField('RouteFrom');end;
function  Tmanifestroutes.GetRouteTo         : string    ; begin Result := GetStringField('RouteTo');end;
function  Tmanifestroutes.GetRouteDesc       : string    ; begin Result := GetStringField('RouteDesc');end;
function  Tmanifestroutes.GetDistance        : Integer   ; begin Result := GetIntegerField('Distance');end;
function  Tmanifestroutes.GetPaletteRate     : Double    ; begin Result := GetFloatField('PaletteRate');end;
procedure Tmanifestroutes.SetRouteFrom       (const Value: string    ); begin SetStringField('RouteFrom'        , Value);end;
procedure Tmanifestroutes.SetRouteTo         (const Value: string    ); begin SetStringField('RouteTo'          , Value);end;
procedure Tmanifestroutes.SetRouteDesc       (const Value: string    ); begin SetStringField('RouteDesc'        , Value);end;
procedure Tmanifestroutes.SetDistance        (const Value: Integer   ); begin SetIntegerField('Distance'         , Value);end;
procedure Tmanifestroutes.SetPaletteRate     (const Value: Double    ); begin SetFloatField('PaletteRate'      , Value);end;


  {Tmanifestlines}

constructor Tmanifestlines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'manifestlines';
//  fSQL := 'SELECT * FROM tblmanifestlines';
//  fSQL := 'select ML.GlobalRef, ML.ManifestLineId, ML.ManifestId, cast(ML.SaleLineId as signed) as SaleLineId,' +
//          'cast(ML.InvoiceLineId as Signed) as InvoiceLineId,ML.ETA,ML.PageNo,ML.EditedFlag,ML.msTimeStamp,'+
//          'ML.Deleted,ML.msUpdateSiteCode from tblManifestLines ML';
  fSQL := 'select ML.GlobalRef, ML.ManifestLineId, ML.ManifestId, ML.SaleLineId,' +
          'ML.InvoiceLineId,ML.ETA,ML.PageNo,ML.EditedFlag,ML.msTimeStamp,'+
          'ML.Deleted,ML.msUpdateSiteCode, ML.SOID, ML.InvoiceId from tblManifestLines ML';
//Where ML.ManifestID= :ID
end;


destructor Tmanifestlines.Destroy;
begin
  inherited;
end;


procedure Tmanifestlines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ManifestID');
  SetPropertyFromNode(node,'SaleLineID');
  SetPropertyFromNode(node,'InvoiceLineID');
  //SetPropertyFromNode(node,'SaleID');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetDateTimePropertyFromNode(node,'ETA');
  SetPropertyFromNode(node,'PageNo');
end;


procedure Tmanifestlines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ManifestID' ,ManifestID);
  AddXMLNode(node,'SaleLineID' ,SaleLineID);
  AddXMLNode(node,'InvoiceLineID' ,InvoiceLineID);
  //AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'ETA' ,ETA);
  AddXMLNode(node,'PageNo' ,PageNo);
end;


function Tmanifestlines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ManifestID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ManifestID should not be 0' , True );
    Exit;
  end;
  if ((SaleLineID = 0) and (InvoiceLineID=0)) (*or (SaleId =0)*) then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sale should not be blank' , True );
    Exit;
  end;
  Result := True;
end;


function Tmanifestlines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tmanifestlines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tmanifestlines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tmanifestlines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tmanifestlines.GetIDField: string;
begin
  Result := 'ManifestLineID'
end;


function Tmanifestlines.getInvoiceID: Integer;
begin
(*
  Result := 0;
  if invoicelineId =0 then exit;
  with GetNewdataset('Select SaleId from tblsaleslines where SaleLineId = ' + inttostr(InvoiceLineID) , true) do try
    REsult := fieldbyname('SAleID').AsInteger;
  finally
    if active then close;
    free;
  end;
*)
  Result := GetIntegerField('InvoiceId');
end;

class function Tmanifestlines.GetBusObjectTablename: string;
begin
  Result:= 'tblmanifestlines';
end;


function Tmanifestlines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TManifest then
      ManifestId := TManifest(Owner).ID;
end;

function Tmanifestlines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tmanifestlines.GetManifestID      : Integer   ; begin Result := GetIntegerField('ManifestID');end;
function  Tmanifestlines.GetSaleLineID      : Integer   ; begin Result := GetIntegerField('SaleLineID');end;
function Tmanifestlines.getSOID: Integer;
begin
(*
  Result := 0;
  if SaleLineId =0 then exit;
  with GetNewdataset('Select SaleId from tblsaleslines where SaleLineId = ' + inttostr(saleLineId) , true) do try
    REsult := fieldbyname('SAleID').AsInteger;
  finally
    if active then close;
    free;
  end;
*)
  Result := GetIntegerField('SOID');
end;

function  Tmanifestlines.GetInvoiceLineID      : Integer   ; begin Result := GetIntegerField('InvoiceLineID');end;
//function  Tmanifestlines.GetSaleID          : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  Tmanifestlines.GetDeleted         : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  Tmanifestlines.GetETA             : TDateTime ; begin Result := GetDateTimeField('ETA');end;
function  Tmanifestlines.GetPageNo          : Integer   ; begin Result := GetIntegerField('PageNo');end;

function Tmanifestlines.getSaleId: Integer;
begin
  Result := InvoiceID;
  if result = 0 then result := SOID;
end;

(*function Tmanifestlines.getSale: TSales;begin  Result := TSales(getContainercomponent(TSales, 'SaleID = ' + inttostr(SaleId)));end;*)
procedure Tmanifestlines.SetManifestID      (const Value: Integer   ); begin SetIntegerField('ManifestID'       , Value);end;
procedure Tmanifestlines.SetSaleLineID      (const Value: Integer   ); begin SetIntegerField('SaleLineID'       , Value);end;
procedure Tmanifestlines.SetInvoiceId(const Value: integer);
begin
  SetIntegerField('InvoiceId', Value);
end;

procedure Tmanifestlines.SetSOID(const Value: integer);
begin
  SetIntegerField('SoId', Value);
end;

procedure Tmanifestlines.SetInvoiceLineID      (const Value: Integer   ); begin SetIntegerField('InvoiceLineID'       , Value);end;
//procedure Tmanifestlines.SetSaleID          (const Value: Integer   ); begin SetIntegerField('SaleID'       , Value);end;
procedure Tmanifestlines.SetDeleted         (const Value: Boolean   ); begin SetBooleanField('Deleted'       , Value);end;
procedure Tmanifestlines.SetETA             (const Value: TDateTime ); begin SetDateTimeField('ETA'              , Value);end;
procedure Tmanifestlines.SetPageNo          (const Value: Integer   ); begin SetIntegerField('PageNo'           , Value);end;
(*function Tmanifestlines.getSalesLine: TSalesLine;begin  Result := TSalesLine(getContainercomponent(TSalesLine, 'SaleLineID = ' + inttostr(SaleLineID)));end;*)


  {TManifest}

constructor TManifest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Manifest';
  fSQL := 'SELECT * FROM tblmanifest';
end;


function TManifest.DeleteFlaggedLines: boolean;
var
  IsFiltered: boolean;
  TempAccessLevel: integer;
begin
  result:= true;
  try
    Lines.Dataset.DisableControls;
    IsFiltered := Lines.Dataset.Filtered;
    Lines.Dataset.Filtered := false;
    TempAccessLevel:= AccessManager.AccessLevel;
    if self.CleanID < 1 then
      AccessManager.AccessLevel:= 1;
    try
      if Lines.Count > 0 then begin
        Lines.First;
        while not Lines.Dataset.Eof do begin
          if Lines.Deleted then begin
            if not Lines.Delete then begin
              result:= false;
              exit;
            end;
          end else begin
            Lines.Dataset.Next;
          end;
        end;
      end;
    finally
      Lines.Dataset.Filtered := IsFiltered;
      Lines.Dataset.EnableControls;
      if self.CleanID < 1 then
        AccessManager.AccessLevel:= TempAccessLevel;
    end;
  Except
  end;
end;

destructor TManifest.Destroy;
begin
  inherited;
end;


procedure TManifest.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'DespatchDate');
  SetPropertyFromNode(node,'OwnerName');
  SetPropertyFromNode(node,'Driver');
  SetPropertyFromNode(node,'Phone');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'VehicleID');
  SetPropertyFromNode(node,'Trailer');
  SetPropertyFromNode(node,'FromCity');
  SetPropertyFromNode(node,'FromState');
  SetPropertyFromNode(node,'FromPostcode');
  SetPropertyFromNode(node,'ToCity');
  SetPropertyFromNode(node,'ToState');
  SetPropertyFromNode(node,'ToPostcode');
  SetBooleanPropertyFromNode(node,'Completed');
  SetPropertyFromNode(node,'EmployeeId');
  SetDateTimePropertyFromNode(node,'FinalETA');
  SetPropertyFromNode(node,'ManifestRouteID');
  SetPropertyFromNode(node,'Distance');
  SetPropertyFromNode(node,'VehicleName');
  SetPropertyFromNode(node,'BillID');
end;


procedure TManifest.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DespatchDate' ,DespatchDate);
  AddXMLNode(node,'OwnerName' ,OwnerName);
  AddXMLNode(node,'Driver' ,Driver);
  AddXMLNode(node,'Phone' ,Phone);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'VehicleID' ,VehicleID);
  AddXMLNode(node,'Trailer' ,Trailer);
  AddXMLNode(node,'FromCity' ,FromCity);
  AddXMLNode(node,'FromState' ,FromState);
  AddXMLNode(node,'FromPostcode' ,FromPostcode);
  AddXMLNode(node,'ToCity' ,ToCity);
  AddXMLNode(node,'ToState' ,ToState);
  AddXMLNode(node,'ToPostcode' ,ToPostcode);
  AddXMLNode(node,'Completed' ,Completed);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'FinalETA' ,FinalETA);
  AddXMLNode(node,'ManifestRouteID' ,ManifestRouteID);
  AddXMLNode(node,'Distance' ,Distance);
  AddXMLNode(node,'VehicleName' ,VehicleName);
  AddXMLNode(node,'BillID' ,BillID);
end;


function TManifest.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TManifest.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  DeleteFlaggedLines;
  Result := inherited Save;
end;
procedure TManifest.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;
procedure TManifest.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.FieldName , 'VehicleName') then begin
      VehicleID    := tcdatautils.GetVehicleID(VehicleName);
      Trailer      := ManifestVehicle.Trailer;
      Phone        := ManifestVehicle.Phone;
      Driver       := ManifestVehicle.Driver;
      OwnerName    := ManifestVehicle.OwnerName;
      DespatchDate := Date;
      PostDB;
  end else if sametext(Sender.FieldName , 'ManifestRouteID') then begin
    Distance := ManifestRoute.Distance;
  end else if sametext(Sender.FieldName , 'Completed') then begin
    if not completed then employeeId := 0
    else if employeeId =0 then EmployeeId :=AppEnv.Employee.EmployeeID;
  end;

end;
function TManifest.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TManifest.GetIDField: string;
begin
  Result := 'ManifestID'
end;
class function TManifest.GetBusObjectTablename: string;
begin
  Result:= 'tblmanifest';
end;
function TManifest.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TManifest.GetDespatchDate    : TDateTime ; begin Result := GetDateTimeField('DespatchDate');end;
function  TManifest.GetOwnerName       : string    ; begin Result := GetStringField('OwnerName');end;
function  TManifest.GetDriver          : string    ; begin Result := GetStringField('Driver');end;
function  TManifest.GetPhone           : string    ; begin Result := GetStringField('Phone');end;
function  TManifest.GetNotes           : string    ; begin Result := GetStringField('Notes');end;
function  TManifest.GetVehicleID       : Integer   ; begin Result := GetIntegerField('VehicleID');end;
function  TManifest.GetTrailer         : string    ; begin Result := GetStringField('Trailer');end;
function  TManifest.GetFromCity        : string    ; begin Result := GetStringField('FromCity');end;
function  TManifest.GetFromState       : string    ; begin Result := GetStringField('FromState');end;
function  TManifest.GetFromPostcode    : string    ; begin Result := GetStringField('FromPostcode');end;
function  TManifest.GetToCity          : string    ; begin Result := GetStringField('ToCity');end;
function  TManifest.GetToState         : string    ; begin Result := GetStringField('ToState');end;
function  TManifest.GetToPostcode      : string    ; begin Result := GetStringField('ToPostcode');end;
function  TManifest.GetCompleted       : Boolean   ; begin Result := GetBooleanField('Completed');end;
function  TManifest.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TManifest.GetFinalETA        : TDateTime ; begin Result := GetDateTimeField('FinalETA');end;
function  TManifest.GetManifestRouteID : Integer   ; begin Result := GetIntegerField('ManifestRouteID');end;

function  TManifest.GetDistance        : Integer   ; begin Result := GetIntegerField('Distance');end;
function  TManifest.GetVehicleName     : string    ; begin Result := GetStringField('VehicleName');end;
function  TManifest.GetBillID          : Integer   ; begin Result := GetIntegerField('BillID');end;
procedure TManifest.SetDespatchDate    (const Value: TDateTime ); begin SetDateTimeField('DespatchDate'     , Value);end;
procedure TManifest.SetOwnerName       (const Value: string    ); begin SetStringField('OwnerName'        , Value);end;
procedure TManifest.SetDriver          (const Value: string    ); begin SetStringField('Driver'           , Value);end;
procedure TManifest.SetPhone           (const Value: string    ); begin SetStringField('Phone'            , Value);end;
procedure TManifest.SetNotes           (const Value: string    ); begin SetStringField('Notes'            , Value);end;
procedure TManifest.SetVehicleID       (const Value: Integer   ); begin SetIntegerField('VehicleID'        , Value);end;
procedure TManifest.SetTrailer         (const Value: string    ); begin SetStringField('Trailer'          , Value);end;
procedure TManifest.SetFromCity        (const Value: string    ); begin SetStringField('FromCity'         , Value);end;
procedure TManifest.SetFromState       (const Value: string    ); begin SetStringField('FromState'        , Value);end;
procedure TManifest.SetFromPostcode    (const Value: string    ); begin SetStringField('FromPostcode'     , Value);end;
procedure TManifest.SetToCity          (const Value: string    ); begin SetStringField('ToCity'           , Value);end;
procedure TManifest.SetToState         (const Value: string    ); begin SetStringField('ToState'          , Value);end;
procedure TManifest.SetToPostcode      (const Value: string    ); begin SetStringField('ToPostcode'       , Value);end;
procedure TManifest.SetCompleted       (const Value: Boolean   ); begin SetBooleanField('Completed'        , Value);end;
procedure TManifest.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TManifest.SetFinalETA        (const Value: TDateTime ); begin SetDateTimeField('FinalETA'         , Value);end;
procedure TManifest.SetManifestRouteID (const Value: Integer   ); begin SetIntegerField('ManifestRouteID' , Value);end;
procedure TManifest.SetDistance        (const Value: Integer   ); begin SetIntegerField('Distance'         , Value);end;
procedure TManifest.SetVehicleName     (const Value: string    ); begin SetStringField('VehicleName'      , Value);end;
procedure TManifest.SetBillID          (const Value: Integer   ); begin SetIntegerField('BillID'           , Value);end;
function TManifest.getmanifestvehicle : Tmanifestvehicles ;begin  Result := Tmanifestvehicles (getContainercomponent(Tmanifestvehicles, 'VehicleID = '      + inttostr(VehicleID)))       ;end;
function TManifest.getManifestroute   : Tmanifestroutes   ;begin  Result := Tmanifestroutes   (getContainercomponent(Tmanifestroutes  , 'ManifestRouteID = '+ inttostr(ManifestRouteID))) ;end;
function TManifest.getLines           : Tmanifestlines    ;begin  Result := Tmanifestlines    (getContainercomponent(Tmanifestlines   , 'ManifestID = '     + inttostr(ID)))              ;end;
initialization
  RegisterClass(TManifest);
  RegisterClass(Tmanifestlines);
  RegisterClass(Tmanifestroutes);
  RegisterClass(Tmanifestvehicles);

end.

