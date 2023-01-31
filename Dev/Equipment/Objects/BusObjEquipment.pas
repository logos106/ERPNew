unit BusObjEquipment;


interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess, ERPdbComponents,
  BusObjClient, BusobjRepairsExportConfig, Busobjcustomfields, BusObjPicture , BusobjProduct,
  BusObjGLAccount ;


const
  HPTHour = 1;
  HPTHalfday = 2;
  HPTDay = 3;
  HPTWeek = 4;
  HPTFortnight = 5;
  HPTMonth = 6;
  HPTYear = 7;

type
  TEquipmentParts = class(TMSBusObj)
  private
    function GetEquipmentId: Integer;
    function GetEquipmentname: string;
    function GetProductID: Integer;
    function GetProductName: string;
    function GetActive: Boolean;
    function GetQuantity :double;
    procedure SetEquipmentId(const Value: Integer);
    procedure SetEquipmentname(const Value: string);
    procedure SetProductID(const Value: Integer);
    procedure SetProductName(const Value: string);
    procedure SetActive(const Value: Boolean);
    Procedure SetQuantity(Const Value :Double);
    function getCleanProductID: Integer;
    function getPARTSDESCRIPTION: string;
    procedure setPARTSDESCRIPTION(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property CleanProductID: Integer read getCleanProductID;
  published
    property EquipmentID: Integer read GetEquipmentId write SetEquipmentId;
    property EquipmentName: string read GetEquipmentname write SetEquipmentname;
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property Active: Boolean read GetActive write SetActive;
    property PartsDescription: string read getPARTSDESCRIPTION write setPARTSDESCRIPTION;
    Property Quantity :double read getQuantity write setQuantity;
  end;

  TEquipmentImages = class(TbusobjPicture)
  private
    function GetEquipmentId: Integer;
    procedure SetEquipmentId(const Value: Integer);
    function GetEquipImageStream: TStream;
  protected
    fEquipImageStream: TStream;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetMIMEEncodedEquipImage: string; Virtual;
    procedure SetMIMEEncodedEquipImage(const Value: string); Virtual;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property EquipImageStream: TStream read GetEquipImageStream;
    procedure Load(const fIsReadonly: Boolean); Override;
    class function _Schema: string; override;
    function Picturefieldname:String;Override;
    function Picturetypefieldname:String;Override;
  published
    property EquipmentID: Integer read GetEquipmentId write SetEquipmentId;
    property MIMEEncodedEquipImage: string read GetMIMEEncodedEquipImage write SetMIMEEncodedEquipImage;
  end;

  TEquipmentJPGImages = class(TEquipmentImages)
  protected
    function GetMIMEEncodedEquipImage: string; override;
    procedure SetMIMEEncodedEquipImage(const Value: string); override;
  public
  end;

  TEquipmentPicture = class(TbusobjPicture)
  private
    function GetEquipmentId: Integer;
    procedure SetEquipmentId(const Value: Integer);
    function GetEquipImageStream: TStream;
    function GetEquipMapStream: TStream;
  protected
    fEquipImageStream: TStream;
    fEquipMapStream: TStream;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetMIMEEncodedEquipImage: string; Virtual;
    procedure SetMIMEEncodedEquipImage(const Value: string); Virtual;
    function GetMIMEEncodedEquipMap: string; Virtual;
    procedure SetMIMEEncodedEquipMap(const Value: string); Virtual;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load(const fIsReadonly: Boolean); Override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property EquipImageStream: TStream read GetEquipImageStream;
    property EquipMapStream: TStream read GetEquipMapStream;
    class function _Schema: string; override;
    function Picturefieldname:String;Override;
    function Picturetypefieldname:String;Override;
  published
    property EquipmentID: Integer read GetEquipmentId write SetEquipmentId;
    property MIMEEncodedEquipImage: string read GetMIMEEncodedEquipImage write SetMIMEEncodedEquipImage;
    property MIMEEncodedEquipMap: string read GetMIMEEncodedEquipMap write SetMIMEEncodedEquipMap;
  end;

  TEquipmentJPGPicture = class(TEquipmentPicture)
  protected
    function GetMIMEEncodedEquipImage: string; override;
    procedure SetMIMEEncodedEquipImage(const Value: string); override;
    function GetMIMEEncodedEquipMap: string; override;
    procedure SetMIMEEncodedEquipMap(const Value: string); override;
  public
  end;

  TEquipment = class(TMSBusObj)
  private
    AllLinesValid:Boolean;
    function GetEquipmentname: string;
    function GetEquipmentdescription: string;
    function GetSerialNumber: string;
    function GetEquipmentDetails: string;
    function GetComments: string;
    function GetActive: Boolean;
    procedure SetEquipmentname(const Value: string);
    procedure SetEquipmentdescription(const Value: string);
    procedure SetSerialNumber(const Value: string);
    procedure SetEquipmentDetails(const Value: string);
    procedure SetComments(const Value: string);
    procedure SetActive(const Value: Boolean);
    function GetProductID: Integer;
    procedure SetProductID(const Value: Integer);
    function geTManufacture: string;
    function getmodel: string;
    procedure seTManufacture(const Value: string);
    procedure setmodel(const Value: string);
    function getTEquipmentParts: TEquipmentParts;
    function geTManufactureID: Integer;
    procedure seTManufactureID(const Value: Integer);
    function getCleanProductID: Integer;
    Function GetCleanSerialNumber:String;
    function GetModelID: Integer;
    function GetDefaultWarrantyDuration: Integer;
    function GetProductName: string;
    procedure SetModelID(const Value: Integer);
    procedure SetProductName(const Value: string);
    function getEquipmentImages: TEquipmentImages;
    function getEquipmentPicture: TEquipmentPicture;
    function GetEquipmentrCustomFieldValues: TEquipmentCustomFieldValues;
    function getOnHire: Boolean;
    function getisQLDRegisteredVehicle: Boolean;
    Function GetOnHireQty:Double;
    procedure SetOnHire(const Value: Boolean);
    procedure SetisQLDRegisteredVehicle(const Value: Boolean);
    Procedure SetOnHireQty(Const Value:Double);
    Procedure ValidateDatacallback(Const Sender: TBusObj; var Abort: boolean);
    function GetHireIncomeAccountId: integer;
    procedure SetHireIncomeAccountId(const Value: integer);
    function GetHireIncomeAccountName: string;
    procedure SetHireIncomeAccountName(const Value: string);
    function GetCurrent: string;
    function GetService: string;
    procedure SetCurrent(const Value: string);
    procedure SetService(const Value: string);
    function getProduct: TProductSimple;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function ImportsubClasses(const node: IXMLNode): Boolean; override;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function CreateEquipment(const fiProductID: Integer;
      const fsProductName: string; const fsSerialnumber:String; fconnection: TCustomMyconnection;
      fBusObjEvent: TBusObjEvent): Integer;
    property CleanProductID: Integer read getCleanProductID;
    Property CleanSerialNumber :String read getCleanSerialNumber;
    Property EquipmentPicture :TEquipmentPicture read getEquipmentPicture;
    Property EquipmentImages :TEquipmentImages Read getEquipmentImages;
    class function _Schema: string; override;
    class function IdForEquipManModel(const aEquipName, aManufacture, aModel: string; Conn: TCustomMyConnection = nil): integer;
    Property Product :TProductSimple Read getProduct;
    property DefaultWarrantyDuration: Integer read GetDefaultWarrantyDuration ;
  published
    property EquipmentName: string read GetEquipmentname write SetEquipmentname;
    property EquipmentDescription: string read GetEquipmentdescription write SetEquipmentdescription;
    property SerialNumber: string read GetSerialNumber write SetSerialNumber;
    property EquipmentDetails: string read GetEquipmentDetails write SetEquipmentDetails;
    property Comments: string read GetComments write SetComments;
    property Active: Boolean read GetActive write SetActive;
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property Manufacture: string read geTManufacture write seTManufacture;
    property ManufactureID: Integer read geTManufactureID write seTManufactureID;
    property Model: string read getmodel write setmodel;
    property ModelID: Integer read GetModelID write SetModelID;
    property EquipmentParts: TEquipmentParts read getTEquipmentParts;
    Property EquipmentCustomFieldValues :TEquipmentCustomFieldValues Read GetEquipmentrCustomFieldValues;
    Property OnHire :Boolean read getOnHire write SetOnHire;
    Property isQLDRegisteredVehicle :Boolean read getisQLDRegisteredVehicle write SetisQLDRegisteredVehicle;
    Property OnHireQty :Double read getOnHireQty write SetOnHireQty;
    property HireIncomeAccountId: integer read GetHireIncomeAccountId write SetHireIncomeAccountId;
    property HireIncomeAccountName: string read GetHireIncomeAccountName write SetHireIncomeAccountName;
    property Service: string read GetService write SetService;
    property Current: string read GetCurrent write SetCurrent;
  end;

  TEquipmentXRef = class(TMSBusObj)
  private
    function GetEquipmentId: Integer;
    function GetRepairid: Integer;
    function GetNotes: string;
    function GetOnsite: Boolean;
    function GetDescription: string;
    function GetCreationdate: TDatetime;
    function GetUpdatedate: TDatetime;
    function GetVehicleRego_Expiry: TDatetime;
    function GetCode: string;
    function GetCustomfield1: string;
    function GetCustomfield2: string;
    function GetCustomfield3: string;
    function GetCustomfield4: string;
    function GetCustomfield5: string;
    function GetCustomfield6: string;
    function GetCustomfield7: string;
    function GetCustomfield8: string;
    function GetCustomfield9: string;
    function GetCustomfield10: string;
    function EmptyRecord: Boolean;
    function getWarantyLeft: Integer;
    function getWarantyTaken: Integer;
    function GetQuantity: Double;
    procedure SetEquipmentId(const Value: Integer);
    procedure SetRepairid(const Value: Integer);
    procedure SetNotes(const Value: string);
    procedure SetOnsite(const Value: Boolean);
    procedure SetDescription(const Value: string);
    procedure SetCreationdate(const Value: TDatetime);
    procedure SetUpdatedate(const Value: TDatetime);
    procedure SetVehicleRego_Expiry(const Value: TDatetime);
    procedure SetCode(const Value: string);
    procedure SetCustomfield1(const Value: string);
    procedure SetCustomfield2(const Value: string);
    procedure SetCustomfield3(const Value: string);
    procedure SetCustomfield4(const Value: string);
    procedure SetCustomfield5(const Value: string);
    procedure SetCustomfield6(const Value: string);
    procedure SetCustomfield7(const Value: string);
    procedure SetCustomfield8(const Value: string);
    procedure SetCustomfield9(const Value: string);
    procedure SetCustomfield10(const Value: string);
    procedure setWarantyLeft(const Value: Integer);
    procedure setWarantyTaken(const Value: Integer);
    procedure setQuantity(const Value: Double);
    function getCustomerEquipment: TCustomerEquipment;
    function GetSaleId: Integer;
    procedure SetSaleId(const Value: Integer);
    function getisRepairConverted: Boolean;
    function GetWarantyFinishDate: string;
    function GetWarantyPeriod: string;
    procedure setWarantyFinishDate(const Value: string);
    procedure setWarantyPeriod(const Value: string);
    function getUOM: string;
    function getUOMID: Integer;
    function GetUOMMultiplier: Double;
    function GetUOMQty: Double;
    procedure setUOM(const Value: string);
    procedure setUOMID(const Value: Integer);
    procedure setUOMMultiplier(const Value: Double);
    procedure setUOMQty(const Value: Double);
    function getInvoiceID: Integer;
    procedure SetInvoiceId(const Value: Integer);
    function getAppointmentID: Integer;
    procedure setAppointmentID(const Value: Integer);
    function getWarantyStartDate: TDatetime;
    function GetUOMNameProductKey: string;
    procedure SetUOMNameProductKey(const Value: string);
    function getRepairfault: String;
    procedure setRepairfault(const Value: String);
    function getVehicleRego_IDNo: String;
    procedure setVehicleRego_IDNo(const Value: String);
    function getVehicleRego_Description: String;
    procedure setVehicleRego_Description(const Value: String);
    function getVehicleRego_PurposeOfUse: String;
    procedure setVehicleRego_PurposeOfUse(const Value: String);
    function getVehicleRego_Status: String;
    procedure setVehicleRego_Status(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure CreateInstance; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    property CustomerEquipment: TCustomerEquipment read getCustomerEquipment;
    property isRepairconverted: Boolean read getisRepairConverted;
    class function _Schema: string; override;
    Function isQLDRegisteredVehicle:Boolean;
    Function Rego :String;
  published
    property CustomerEquipmentID: Integer read GetEquipmentId write SetEquipmentId;
    property Code: string read GetCode write SetCode;
    property RepairID: Integer read GetRepairid write SetRepairid;
    property SaleID: Integer read GetSaleId write SetSaleId;
    property InvoiceID: Integer read getInvoiceID write SetInvoiceId;
    property AppointmentID: Integer read getAppointmentID write setAppointmentID;
    property Notes: string read GetNotes write SetNotes;
    property OnSite: Boolean read GetOnsite write SetOnsite;
    property Description: string read GetDescription write SetDescription;
    property CreationDate: TDatetime read GetCreationdate write SetCreationdate;
    property UpdateDate: TDatetime read GetUpdatedate write SetUpdatedate;
    property Customfield1: string read GetCustomfield1 write SetCustomfield1;
    property Customfield2: string read GetCustomfield2 write SetCustomfield2;
    property Customfield3: string read GetCustomfield3 write SetCustomfield3;
    property Customfield4: string read GetCustomfield4 write SetCustomfield4;
    property Customfield5: string read GetCustomfield5 write SetCustomfield5;
    property Customfield6: string read GetCustomfield6 write SetCustomfield6;
    property Customfield7: string read GetCustomfield7 write SetCustomfield7;
    property Customfield8: string read GetCustomfield8 write SetCustomfield8;
    property Customfield9: string read GetCustomfield9 write SetCustomfield9;
    property Customfield10: string read GetCustomfield10 write SetCustomfield10;
    property WarantyPeriodTaken: Integer read getWarantyTaken write setWarantyTaken;
    property WarantyPeriodLeft: Integer read getWarantyLeft   write setWarantyLeft;
    property Quantity: Double read GetQuantity write setQuantity;
    property WarantyFinishDate: string read GetWarantyFinishDate write setWarantyFinishDate;
    property WarantyPeriod: string read GetWarantyPeriod write setWarantyPeriod;
    property WarantyStartDate: TDatetime read getWarantyStartDate;
    property UOMNameProductKey: string read GetUOMNameProductKey  write SetUOMNameProductKey;
    property UOM: string read getUOM write setUOM;
    property UOMID: Integer read getUOMID write setUOMID;
    property UOMMultiplier: Double read GetUOMMultiplier write setUOMMultiplier;
    property UOMQty: Double read GetUOMQty write setUOMQty;
    Property Repairfault :String read getRepairfault write setRepairfault;
    Property VehicleRego_IDNo :String read getVehicleRego_IDNo write setVehicleRego_IDNo;
    Property VehicleRego_Description :String read getVehicleRego_Description write setVehicleRego_Description;
    Property VehicleRego_PurposeOfUse :String read getVehicleRego_PurposeOfUse write setVehicleRego_PurposeOfUse;
    Property VehicleRego_Status :String read getVehicleRego_Status write setVehicleRego_Status;
    property VehicleRego_Expiry: TDatetime read GetVehicleRego_Expiry write SetVehicleRego_Expiry;
  end;

implementation

uses BusObjConst, CommonLib, sysutils, tcDataUtils, busobjrepairs, BusObjSales,
  BusObjAppointments, CommonDbLib, BusObjSimpleTypes, BusObjModel,
  BusObjectListObj, BusObjManufacture,
  idCoderMIME, BusObjSchemaLib, BusObjUOM, Graphics, jpeg, dateutils,
  BusObjDuration, LogLib, AppEnvironment, DateTimeUtils, DbSharedObjectsObj,
  tcConst;

{ ======================================================== Tequipment ======================================================== }

constructor TEquipment.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblequipment';
  ExportExcludeList.Add('manufactureid');
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('modelid');
end;

destructor TEquipment.Destroy;
begin
  inherited;
end;

procedure TEquipment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EquipmentName');
  SetPropertyFromNode(node, 'Manufacture');
  SetPropertyFromNode(node, 'ManufactureID');
  SetPropertyFromNode(node, 'Model');
  SetPropertyFromNode(node, 'ModelID');
  SetPropertyFromNode(node, 'ProductId');
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'EquipmentDescription');
  SetPropertyFromNode(node, 'SerialNumber');
  SetPropertyFromNode(node, 'EquipmentDetails');
  SetPropertyFromNode(node, 'Comments');
  SetBooleanPropertyFromNode(node, 'Active');
  SetBooleanPropertyFromNode(node, 'OnHire');
  SetBooleanPropertyFromNode(node, 'isQLDRegisteredVehicle');
  SetPropertyFromNode(node, 'OnHireQty');
  SetPropertyFromNode(node, 'HireIncomeAccountId');
  SetPropertyFromNode(node, 'HireIncomeAccountName');
  SetPropertyFromNode(node, 'Service');
  SetPropertyFromNode(node, 'Current');


  ImportsubClasses(node)
end;

procedure TEquipment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EquipmentName', EquipmentName);
  AddXMLNode(node, 'Manufacture', Manufacture);
  AddXMLNode(node, 'ManufactureID', ManufactureID);
  AddXMLNode(node, 'Model', Model);
  AddXMLNode(node, 'ModelID', ModelID);
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'Equipmentdescription', EquipmentDescription);
  AddXMLNode(node, 'SerialNumber', SerialNumber);
  AddXMLNode(node, 'EquipmentDetails', EquipmentDetails);
  AddXMLNode(node, 'Comments', Comments);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'OnHire', OnHire);
  AddXMLNode(node, 'isQLDRegisteredVehicle', isQLDRegisteredVehicle);
  AddXMLNode(node, 'OnHireQty', OnHireQty);

  AddXMLNode(node, 'HireIncomeAccountId', HireIncomeAccountId);
  AddXMLNode(node, 'HireIncomeAccountName', HireIncomeAccountName);
  AddXMLNode(node, 'Service', Service);
  AddXMLNode(node, 'Current', Current);

  ExportsubClasses(node);
end;

function TEquipment.ValidateData: Boolean;
begin
  result := inherited ValidateData;
  if not result then Exit;

  result := False;
  ResultStatus.Clear;
  if EquipmentName = '' then begin
    AddResult(False, rssWarning, BOR_General_Err,'Equipment Name cannot be blank.');
    Exit;
  end;
  if (ProductID < 0) then begin
    AddResult(False, rssWarning, BOR_General_Err, 'Product not found');
    Exit;
  end;
  if (ProductID > 0) and (ProductName = '') then begin
    AddResult(False, rssWarning, BOR_General_Err, 'Product not found for ID: ' +
      IntToStr(ProductID));
    Exit;
  end;
  if (Manufacture <> '') and (ManufactureID < 1) then begin
    AddResult(False, rssWarning, BOR_General_Err, 'Manufacture "' + Manufacture
      + '" not found.');
    Exit;
  end;
  if (Model <> '') and (ModelID < 1) then begin
    AddResult(False, rssWarning, BOR_General_Err,
      'Model "' + Model + '" not found.');
    Exit;
  end;
  if not IsUnique(ID , 'EquipmentName = ' + quotedstr(EquipmentName) +' and Manufacture = ' + QuotedStr(Manufacture) +' and Model = ' + QuotedStr(Model), self.connection.connection ) then begin
     AddResult(False, rssWarning, BOR_General_Err,        'A Piece of Equipment Already Exists with the Same Equipment Name, Manufacture and Model.');
     Exit;
  end;
  if not IsUnique(ID , 'ProductId = ' + inttostr(ProductId) + ' and SerialNumber ='+Quotedstr(Serialnumber)) then begin
    if Serialnumber <> '' then
         AddResult(False, rssWarning, BOR_General_Err,        'A Piece of Equipment Already Exists for the Product and Serial Number.')
    else AddResult(False, rssWarning, BOR_General_Err,        'A Piece of Equipment Already Exists for the Product (with no Serial Number).');
     Exit;
  end;
  AllLinesValid :=true;
  EquipmentParts.Iteraterecords(ValidateDatacallback);
  if not AllLinesValid then begin
    REsult := False;
    Exit;
  end;
  EquipmentImages.Iteraterecords(ValidateDatacallback);
  if not AllLinesValid then begin
    REsult := False;
    Exit;
  end;
  EquipmentPicture.Iteraterecords(ValidateDatacallback);
  if not AllLinesValid then begin
    REsult := False;
    Exit;
  end;
  result := true;

end;

procedure TEquipment.ValidateDatacallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if Sender is TMSBusObj then begin
    TMSBusObj(Sender).PostDB;
    if not TMSBusObj(Sender).ValidateData then begin
       AllLinesValid := false;
       Abort := true;
       Exit;
    end;
  end;
end;

class function TEquipment._Schema: string;
begin
  result := inherited;
  TBOSchema.AddRefType(result, 'TManufacture', 'ManufactureObj', 'Manufacture',
    'ManufactureName');
  TBOSchema.AddRefType(result, 'TManufacture', 'ManufactureObj',
    'ManufactureID', 'ID');
  TBOSchema.AddRefType(result, 'TModel', 'ModelObj', 'Model', 'ModelName');
  TBOSchema.AddRefType(result, 'TModel', 'ModelObj', 'ModelID', 'ID');
  TBOSchema.AddRefType(result, 'TProductWeb', 'ProductObj', 'ProductName',
    'ProductName');
  TBOSchema.AddRefType(result, 'TProductWeb', 'ProductObj', 'ProductID', 'ID');
end;

function TEquipment.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TEquipment.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusobjEvent_ToDo, BusobjEvent_IDChange, self);
end;

procedure TEquipment.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.

  inherited;
  if sysutils.SameText(Sender.FieldName, 'ManufactureID') then  begin
    Manufacture := TManufacture.IDToggle(Sender.AsInteger,
      Connection.Connection);
  end  else if sysutils.SameText(Sender.FieldName, 'Manufacture') then  begin
    ManufactureID := TManufacture.IDToggle(Sender.AsString,
      Connection.Connection);
  end else  if sysutils.SameText(Sender.FieldName, 'ModelID') then  begin
    Model := TModel.IDToggle(Sender.AsInteger, Connection.Connection);
  end  else if sysutils.SameText(Sender.FieldName, 'Model') then  begin
    ModelID := TModel.IDToggle(Sender.AsString, Connection.Connection);
  end  else if Sysutils.SameText(Sender.FieldName, 'HireIncomeAccountName') then  begin
    HireIncomeAccountId := TAccount.IDToggle(HireIncomeAccountName, Connection.Connection);
  end  else if Sysutils.SameText(Sender.FieldName, 'OnHire') then  begin
    if OnHireQty =0 then OnHireQty := 1;
  end  else if Sysutils.SameText(Sender.FieldName, 'isQLDRegisteredVehicle') then  begin
  end  else if Sysutils.SameText(Sender.FieldName, 'SerialNumber') then  begin
    if OnHireQty <> 1 then OnHireQty := 1;
  end  else if Sysutils.SameText(Sender.FieldName, 'OnHireQty') then  begin
    if SerialNumber <> '' then if OnHireQty <> 1 then OnHireQty := 1;
    if onHire then if OnHireQty =0 then OnHireQty := 1;
  end  else if Sysutils.SameText(Sender.FieldName, 'ProductID') then  begin
    AddEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged, Self.ID);
  end;
end;

class function TEquipment.GetKeyStringField: string;
begin
  Result := 'EquipmentName';
end;
function TEquipment.GetEquipmentrCustomFieldValues: TEquipmentCustomFieldValues;
begin
  result := TEquipmentCustomFieldValues(GetContainerComponent(TEquipmentCustomFieldValues ,'MasterId = ' + IntToStr(Self.ID) ));
end;

function TEquipment.GetHireIncomeAccountId: integer;
begin
  result := GetIntegerField('HireIncomeAccountId');
end;

function TEquipment.GetHireIncomeAccountName: string;
begin
  Result := GetStringField('HireIncomeAccountName');
end;

function TEquipment.GetSQL: string;begin   result := inherited GetSQL; end;
class function TEquipment.GetIDField: string; begin   result := 'Equipmentid' end;
class function TEquipment.GetBusObjectTablename: string; begin   result := 'tblequipment'; end;
function TEquipment.DoAfterPost(Sender: TDatasetBusObj): Boolean; begin   result := inherited DoAfterPost(Sender);end;

{ Property functions }

function TEquipment.GetEquipmentname: string; begin   result := GetStringField('Equipmentname'); end;
function TEquipment.getEquipmentPicture: TEquipmentPicture; begin   result := TEquipmentPicture(getContainerComponent(TEquipmentPicture,    'EquipmentID =' + IntToStr(ID))); end;
function TEquipment.GetEquipmentdescription: string;begin  result := GetStringField('Equipmentdescription');end;
function TEquipment.GetSerialNumber: string;begin  result := GetStringField('SerialNumber');end;
function TEquipment.GetService: string;
begin
  result := GetStringField('Service');
end;

function TEquipment.GetEquipmentDetails: string;begin  result := GetStringField('EquipmentDetails');end;
function TEquipment.GetComments: string;begin  result := GetStringField('Comments');end;
function TEquipment.GetCurrent: string;
begin
  result := GetStringField('Current');
end;

function TEquipment.getEquipmentImages: TEquipmentImages; begin   result := TEquipmentImages(getContainerComponent(TEquipmentImages,    'EquipmentID =' + IntToStr(ID))); end;
function TEquipment.GetActive: Boolean; begin   result := GetBooleanField('Active'); end;
function TEquipment.GetModelID: Integer; begin   result := TModel.IDToggle(Model, Connection.Connection); end;
function TEquipment.GetDefaultWarrantyDuration: Integer; begin   result := Product.DefaultWarrantyDuration; end;
function TEquipment.getOnHire: Boolean;begin result := GEtBooleanfield('OnHire'); end;
function TEquipment.getisQLDRegisteredVehicle: Boolean;begin result := GEtBooleanfield('isQLDRegisteredVehicle'); end;
function TEquipment.getOnHireQty: Double;begin result := GEtFloatfield('OnHireQty'); end;
function TEquipment.getProduct: TProductSimple;
begin
  Result := TProductSimple(getContainerComponent(TProductSimple, 'PartsId = ' + inttostr(ProductID), Self.SilentMode, False, True));
end;

function TEquipment.GetProductID: Integer; begin   result := getIntegerfield('ProductID'); end;
function TEquipment.GetProductName: string; begin   result := TProductSimple.IDToggle(ProductID, Connection.Connection); end;

procedure TEquipment.SetEquipmentname(const Value: string); begin   SetStringField('Equipmentname', Value);end;
procedure TEquipment.SetHireIncomeAccountId(const Value: integer);begin  SetIntegerField('HireIncomeAccountId', Value);end;
procedure TEquipment.SetHireIncomeAccountName(const Value: string);begin  SetStringField('HireIncomeAccountName', Value);end;
procedure TEquipment.SetEquipmentdescription(const Value: string);begin  SetStringField('Equipmentdescription', Value);end;
procedure TEquipment.SetSerialNumber(const Value: string);begin  SetStringField('SerialNumber', Value);end;
procedure TEquipment.SetService(const Value: string);
begin
  SetStringField('Service',Value);
end;

procedure TEquipment.SetEquipmentDetails(const Value: string);begin  SetStringField('EquipmentDetails', Value);end;
procedure TEquipment.SetComments(const Value: string);begin  SetStringField('Comments', Value);end;
procedure TEquipment.SetCurrent(const Value: string);
begin
  SetStringField('Current',Value);
end;

procedure TEquipment.SetActive(const Value: Boolean); begin   SetBooleanField('Active', Value); end;
procedure TEquipment.SetModelID(const Value: Integer); begin   Model := TModel.IDToggle(Value, Connection.Connection); end;
procedure TEquipment.SetOnHire(const Value: Boolean);begin SetBooleanField('OnHire', Value);  end;
procedure TEquipment.SetisQLDRegisteredVehicle(const Value: Boolean);begin SetBooleanField('isQLDRegisteredVehicle', Value);  end;
procedure TEquipment.SetOnHireQty(const Value: Double);begin SetFloatField('OnHireQty', Value);  end;

procedure TEquipment.SetProductID(const Value: Integer); begin   SetIntegerField('ProductID', Value); end;

procedure TEquipment.SetProductName(const Value: string);
begin
  if Value <> '' then
  begin
    ProductID := TProductSimple.IDToggle(Value, Connection.Connection);
    if ProductID = 0 then
      ProductID := -1;
  end
  else
    ProductID := 0;
end;

class function TEquipment.CreateEquipment(const fiProductID: Integer;
  const fsProductName: string; const fsSerialnumber:String; fconnection: TCustomMyconnection;
  fBusObjEvent: TBusObjEvent): Integer;
var
  equip: TEquipment;
  s:String;
begin
  equip := TEquipment.Create(nil);
  with equip do
    try
      equip.busobjevent := fBusObjEvent;
      Connection := TMyDacDataConnection.Create(equip);
      if fconnection = nil then
        fconnection := CommonDbLib.GetNewMyDacConnection(equip);
      equip.Connection.Connection := fconnection;
      s:='ProductID=' + IntToStr(fiProductID);
      if  fsSerialnumber <> '' then s:= s + ' and Serialnumber =' +quotedstr(fsSerialnumber);
      equip.LoadSelect(s);
      if equip.count = 0 then begin
        equip.LoadSelect(' ( EquipmentName= ' + QuotedStr(fsProductName) +' and ifnull(ProductID,0) = 0)');
        if equip.count = 0 then begin
          equip.New;
          if  fsSerialnumber <> '' then
            equip.EquipmentName := fsProductName +'-'+fsSerialnumber
          else equip.EquipmentName := fsProductName;
          equip.ProductID := fiProductID;
          equip.Serialnumber := fsSerialnumber;
          equip.PostDB;
        end else if equip.count > 0 then begin
          SendEvent(BusobjEvent_ToDo, BusobjEvent_ChooseEquip, equip);
        end;
      end;
      result := equip.ID
    finally
      freeandnil(equip);
    end;
end;

{ ========================================================
  TEquipmentxRef
  ======================================================== }
constructor TEquipmentXRef.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblEquipmentxRef';
  fIsList := true;
  ExportExcludeList.Add('repairid');
  ExportExcludeList.Add('saleid');
  ExportExcludeList.Add('invoiceid');
  ExportExcludeList.Add('appointmentid');
  ExportExcludeList.Add('uomid');
end;

destructor TEquipmentXRef.Destroy;
begin
  inherited;
end;

procedure TEquipmentXRef.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  if not ImportingFromXMLFile then
  begin
    SetPropertyFromNode(node, 'CustomerEquipmentid');
  end
  else
  begin
    { todo repair - shoudl search in custoemrtable }
    CustomerEquipmentID := tcDataUtils.GetEquipmentId
      (GetXMLNodeStringValue(node, 'EquipmentName'));
  end;
  SetPropertyFromNode(node, 'Notes');
  SetBooleanPropertyFromNode(node, 'Onsite');
  SetPropertyFromNode(node, 'Description');
  SetDateTimePropertyFromNode(node, 'Creationdate');
  SetDateTimePropertyFromNode(node, 'Updatedate');
  SetPropertyFromNode(node, 'Code');
  SetPropertyFromNode(node, 'Customfield1');
  SetPropertyFromNode(node, 'Customfield2');
  SetPropertyFromNode(node, 'Customfield3');
  SetPropertyFromNode(node, 'Customfield4');
  SetPropertyFromNode(node, 'Customfield5');
  SetPropertyFromNode(node, 'Customfield6');
  SetPropertyFromNode(node, 'Customfield7');
  SetPropertyFromNode(node, 'Customfield8');
  SetPropertyFromNode(node, 'Customfield9');
  SetPropertyFromNode(node, 'Customfield10');
  SetPropertyFromNode(node, 'UOM');
  SetPropertyFromNode(node, 'UOMID');
  SetPropertyFromNode(node, 'UOMMultiplier');
  SetPropertyFromNode(node, 'UOMQty');
  SetPropertyFromNode(node, 'SaleId');
  SetPropertyFromNode(node, 'InvoiceId');
  SetPropertyFromNode(node, 'AppointmentID');
  SetPropertyFromNode(node, 'VehicleRego_IDNo');
  SetPropertyFromNode(node, 'VehicleRego_Description');
  SetPropertyFromNode(node, 'VehicleRego_PurposeOfUse');
  SetPropertyFromNode(node, 'VehicleRego_Status');
  SetDateTimePropertyFromNode(node, 'VehicleRego_Expiry');
end;

function TEquipmentXRef.ValidateXMLData(const node: IXMLNode): Boolean;
var
  fiEquipmentID: Integer;
begin
  result := inherited ValidateXMLData(node);
  if not result then
    Exit;
  if not ImportingFromXMLFile then
    Exit;

  if GetXMLNodeIntegerValue(node, 'ImportingID') <> 0 then
    XMLSearchRecorddesc := IDFieldName + ' =' +
      IntToStr(GetXMLNodeIntegerValue(node, 'ImportingID'))
  else
    XMLSearchRecorddesc := IDFieldName + ' =' +
      IntToStr(GetXMLNodeIntegerValue(node, IDFieldName));
  XMLSearchRecorddesc := ' and EquipmentName = ' + GetXMLNodeStringValue(node,
    'EquipmentName');

  result := False;

  if GetXMLNodeStringValue(node, 'EquipmentName') <> '' then
  begin
    { Todo repairs - search in customer table }
    fiEquipmentID := tcDataUtils.GetEquipmentId(GetXMLNodeStringValue(node,
      'EquipmentName'));
    if fiEquipmentID = 0 then
    begin
      ErrRecordNotfound('EquipmentName', GetXMLNodeStringValue(node,
        'EquipmentName'));
      Exit;
    end;
  end;

  result := true;
  { for the transaction records , the id should exists if its a modification transaction }
  { search on the globalref if exists, otherwise on Id }
  LocateXMLRecord;
end;

class function TEquipmentXRef._Schema: string;
begin
  result := inherited;
  TBOSchema.AddRefType(result, 'TCustomerEquipment', 'CustomerEquipmentObj',
    'CustomerEquipmentID', 'ID');
end;

procedure TEquipmentXRef.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then
  begin
    AddXMLNode(node, 'CustomerEquipmentid', CustomerEquipmentID);
  end
  else
  begin
    { todo repairs- search in custoemr table }
    AddXMLNode(node, 'EquipmentName',
      tcDataUtils.GetEquipmentname(CustomerEquipmentID));
  end;
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Onsite', OnSite);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Creationdate', CreationDate);
  AddXMLNode(node, 'Updatedate', UpdateDate);
  AddXMLNode(node, 'Code', Code);
  AddXMLNode(node, 'Customfield1', Customfield1);
  AddXMLNode(node, 'Customfield2', Customfield2);
  AddXMLNode(node, 'Customfield3', Customfield3);
  AddXMLNode(node, 'Customfield4', Customfield4);
  AddXMLNode(node, 'Customfield5', Customfield5);
  AddXMLNode(node, 'Customfield6', Customfield6);
  AddXMLNode(node, 'Customfield7', Customfield7);
  AddXMLNode(node, 'Customfield8', Customfield8);
  AddXMLNode(node, 'Customfield9', Customfield9);
  AddXMLNode(node, 'Customfield10', Customfield10);
  AddXMLNode(node, 'UOM', UOM);
  AddXMLNode(node, 'UOMID', UOMID);
  AddXMLNode(node, 'InvoiceID', InvoiceID);
  AddXMLNode(node, 'SaleId', SaleID);
  AddXMLNode(node, 'AppointmentID', AppointmentID);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
  AddXMLNode(node, 'UOMQty', UOMQty);
  AddXMLNode(node, 'Rego', Rego);
  AddXMLNode(node, 'VehicleRego_IDNo', VehicleRego_IDNo);
  AddXMLNode(node, 'VehicleRego_Description', VehicleRego_Description);
  AddXMLNode(node, 'VehicleRego_PurposeOfUse', VehicleRego_PurposeOfUse);
  AddXMLNode(node, 'VehicleRego_Status', VehicleRego_Status);
  AddXMLNode(node, 'VehicleRego_Expiry', VehicleRego_Expiry);


  end;

function TEquipmentXRef.ValidateData: Boolean;
begin
  result := False;
  ResultStatus.Clear;
  if CustomerEquipmentID = 0 then
  begin
    AddResult(False, rssWarning, 0, 'Equipment should not be blank');
    Exit;
  end;
  if (UOMID > 0) and (UOM = '') then
  begin
    AddResult(False, rssWarning, 0, 'Unit Of Measure not found for UOM ID: ' +
      IntToStr(UOMID));
    Exit;
  end;
  result := true;
end;

function TEquipmentXRef.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TEquipmentXRef.OnDataIdChange(const ChangeType
  : TBusObjDataChangeType);
begin
  inherited;
end;

function TEquipmentXRef.Rego: String;
var
  qry: TERPQuery;
begin
  result := '';
  qry := SharedQuery;
  try
    qry.sql.text := 'SELECT CE.Registration '+
                    ' FROM tblEquipmentxRef ExRef  '+
                    ' inner join tblcustomerequip CE on ExRef.customerEquipmentId = CE.id  '+
                    ' where ExRef.ID = ' + inttostr(ID);
    qry.open;
    Result := qry.fieldbyname('Registration').asString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TEquipmentXRef.DoFieldOnChange(Sender: TField);
var
  UomObj: TUnitOfMeasure;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then
      Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'CustomerEquipmentid') then
  begin

  end
  else if sysutils.SameText(Sender.FieldName, 'UOMID') then
  begin
    if UOMID > 0 then
    begin
      UomObj := TUnitOfMeasure.Create(nil);
      try
        UomObj.Connection := self.Connection;
        UomObj.Load(UOMID);
        if UomObj.count > 0 then
        begin
          UOM := UomObj.UOMName;
          UOMMultiplier := UomObj.Multiplier;
        end
        else
        begin
          UOM := '';
          UOMMultiplier := 1;
        end;
      finally
        UomObj.Free;
      end;
    end
    else
    begin
      UOM := '';
      UOMMultiplier := 1;
    end;
  end
  else if sysutils.SameText(Sender.FieldName, 'UOMQty') then
  begin
    if not RawMode then
    begin
      if UOMQty > CustomerEquipment.UOMQty then
        UOMQty := CustomerEquipment.UOMQty;
      Quantity := DivZer(UOMQty, UOMMultiplier);
    end;
  end
  else if sysutils.SameText(Sender.FieldName, 'Quantity') then
  begin
    if not RawMode then
    begin
      if Quantity > CustomerEquipment.Quantity then
        Quantity := CustomerEquipment.Quantity;
    end;
  end;
end;

function TEquipmentXRef.GetSQL: string; begin   result := inherited GetSQL; end;
class function TEquipmentXRef.GetIDField: string; begin   result := 'Id' end;
 class function TEquipmentXRef.GetBusObjectTablename: string; begin   result := 'tblEquipmentxRef'; end;

function TEquipmentXRef.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then
    Exit;
  UpdateDate := Date;
  if CreationDate = 0 then
    CreationDate := Now;
end;

function TEquipmentXRef.DoAfterPost(Sender: TDatasetBusObj): Boolean;
var
  IgnoreAccesslevelSave: Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then
    Exit;
  if count > 0 then
    if EmptyRecord then
    begin
      IgnoreAccesslevelSave := IgnoreAccesslevel;
      try
        IgnoreAccesslevel := true;
        Dataset.Delete;
      finally
        IgnoreAccesslevel := IgnoreAccesslevelSave;
      end;
    end;
  if count > 0 then
    if assigned(self.Owner) then
      if self.Owner is TRepairs then
        TRepairs(self.Owner).UpdateStatus(SimpleTypeAction_EquipmentAdded);

end;

procedure TEquipmentXRef.CreateInstance;
begin
  if Owner is TRepairs then
    if assigned(TRepairs(Owner).ObjInstanceToClone) then
      ObjInstanceToClone := TRepairs(TRepairs(Owner).ObjInstanceToClone)
        .RepairEquipment;
end;

function TEquipmentXRef.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then
    Exit;
  if assigned(self.Owner) then
    if self.Owner is TRepairs then
    begin
      TRepairs(self.Owner).PostDB;
      RepairID := TRepairs(self.Owner).ID;
    end
    else if self.Owner is TInvoice then
    begin
      TInvoice(self.Owner).PostDB;
      InvoiceID := TInvoice(self.Owner).ID;
    end
    else if self.Owner is TSales then
    begin
      TSales(self.Owner).PostDB;
      SaleID := TSales(self.Owner).ID;
    end
    else if self.Owner is TAppointment then
    begin
      TAppointment(self.Owner).PostDB;
      AppointmentID := TAppointment(self.Owner).ID;
    end;
end;

function TEquipmentXRef.EmptyRecord: Boolean;
begin
  result := (CustomerEquipmentID = 0) and
    (Code = '');

end;

{ Property functions }
function TEquipmentXRef.GetEquipmentId: Integer; begin   result := getIntegerfield('CustomerEquipmentid'); end;
function TEquipmentXRef.GetRepairid: Integer; begin   result := getIntegerfield('Repairid'); end;
function TEquipmentXRef.GetNotes: string; begin   result := GetStringField('Notes'); end;
function TEquipmentXRef.GetOnsite: Boolean; begin   result := GetBooleanField('Onsite');end;
function TEquipmentXRef.GetDescription: string;begin  result := GetStringField('Description');end;
function TEquipmentXRef.GetCreationdate: TDatetime;begin  result := GetDatetimeField('Creationdate');end;
function TEquipmentXRef.GetUpdatedate: TDatetime;begin  result := GetDatetimeField('Updatedate');end;
function TEquipmentXRef.GetCode: string;begin  result := GetStringField('Code');end;
function TEquipmentXRef.GetCustomfield1: string;begin  result := GetStringField('Customfield1');end;
function TEquipmentXRef.GetCustomfield2: string;begin  result := GetStringField('Customfield2');end;
function TEquipmentXRef.GetCustomfield3: string;begin  result := GetStringField('Customfield3');end;
function TEquipmentXRef.GetCustomfield4: string;begin  result := GetStringField('Customfield4');end;
function TEquipmentXRef.GetCustomfield5: string;begin  result := GetStringField('Customfield5');end;
function TEquipmentXRef.GetCustomfield6: string;begin  result := GetStringField('Customfield6');end;
function TEquipmentXRef.GetCustomfield7: string;begin  result := GetStringField('Customfield7');end;
function TEquipmentXRef.GetCustomfield8: string;begin  result := GetStringField('Customfield8');end;
function TEquipmentXRef.GetCustomfield9: string;begin  result := GetStringField('Customfield9');end;
function TEquipmentXRef.GetCustomfield10: string;begin  result := GetStringField('Customfield10');end;
function TEquipmentXRef.getWarantyLeft: Integer;begin  result := getIntegerfield('WarantyPeriodTaken');end;
function TEquipmentXRef.getWarantyTaken: Integer;begin  result := getIntegerfield('WarantyPeriodLeft');end;
function TEquipmentXRef.GetQuantity: Double;begin  result := GetFloatField('Quantity');end;
function TEquipmentXRef.getRepairfault: String;begin  Result := getStringfield('Repairfault');end;
function TEquipmentXRef.getVehicleRego_IDNo: String;begin  Result := getStringfield('VehicleRego_IDNo');end;
function TEquipmentXRef.getVehicleRego_Description: String;begin  Result := getStringfield('VehicleRego_Description');end;
function TEquipmentXRef.getVehicleRego_PurposeOfUse: String;begin  Result := getStringfield('VehicleRego_PurposeOfUse');end;
function TEquipmentXRef.getVehicleRego_Status: String;begin  Result := getStringfield('VehicleRego_Status');end;
function TEquipmentXRef.GetWarantyFinishDate: string;begin  result := GetStringField('WarantyFinishDate');end;
function TEquipmentXRef.GetWarantyPeriod: string;begin  result := GetStringField('WarantyPeriod');end;
function TEquipmentXRef.GetVehicleRego_Expiry: TDatetime;begin  result := GetDatetimeField('VehicleRego_Expiry');end;
procedure TEquipmentXRef.setWarantyFinishDate(const Value: string);begin  SetStringField('WarantyFinishDate', Value);end;
procedure TEquipmentXRef.setWarantyPeriod(const Value: string);begin  SetStringField('WarantyPeriod', Value);end;
procedure TEquipmentXRef.setQuantity(const Value: Double);begin  SetFloatField('Quantity', Value);end;
procedure TEquipmentXRef.setRepairfault(const Value: String);begin  SetStringField('Repairfault' , Value);end;
procedure TEquipmentXRef.setVehicleRego_IDNo(const Value: String);begin  SetStringField('VehicleRego_IDNo' , Value);end;
procedure TEquipmentXRef.setVehicleRego_Description(const Value: String);begin  SetStringField('VehicleRego_Description' , Value);end;
procedure TEquipmentXRef.setVehicleRego_PurposeOfUse(const Value: String);begin  SetStringField('VehicleRego_PurposeOfUse' , Value);end;
procedure TEquipmentXRef.setVehicleRego_Status(const Value: String);begin  SetStringField('VehicleRego_Status' , Value);end;
procedure TEquipmentXRef.SetRepairid(const Value: Integer);begin  SetIntegerField('Repairid', Value);end;
procedure TEquipmentXRef.SetNotes(const Value: string);begin  SetStringField('Notes', Value);end;
procedure TEquipmentXRef.SetOnsite(const Value: Boolean);begin  SetBooleanField('Onsite', Value);end;
procedure TEquipmentXRef.SetDescription(const Value: string);begin  SetStringField('Description', Value);end;
procedure TEquipmentXRef.SetCreationdate(const Value: TDatetime);begin  SetDatetimeField('Creationdate', Value);end;
procedure TEquipmentXRef.SetUpdatedate(const Value: TDatetime);begin  SetDatetimeField('Updatedate', Value);end;
procedure TEquipmentXRef.SetCode(const Value: string);begin  SetStringField('Code', Value);end;
procedure TEquipmentXRef.SetCustomfield1(const Value: string);begin  SetStringField('Customfield1', Value);end;
procedure TEquipmentXRef.SetCustomfield2(const Value: string);begin  SetStringField('Customfield2', Value);end;
procedure TEquipmentXRef.SetCustomfield3(const Value: string);begin  SetStringField('Customfield3', Value);end;
procedure TEquipmentXRef.SetCustomfield4(const Value: string);begin  SetStringField('Customfield4', Value);end;
procedure TEquipmentXRef.SetCustomfield5(const Value: string);begin  SetStringField('Customfield5', Value);end;
procedure TEquipmentXRef.SetCustomfield6(const Value: string);begin  SetStringField('Customfield6', Value);end;
procedure TEquipmentXRef.SetCustomfield7(const Value: string);begin  SetStringField('Customfield7', Value);end;
procedure TEquipmentXRef.SetCustomfield8(const Value: string);begin  SetStringField('Customfield8', Value);end;
procedure TEquipmentXRef.SetCustomfield9(const Value: string);begin  SetStringField('Customfield9', Value);end;
procedure TEquipmentXRef.SetCustomfield10(const Value: string);begin  SetStringField('Customfield10', Value);end;
procedure TEquipmentXRef.setWarantyLeft(const Value: Integer);begin  SetIntegerField('WarantyPeriodTaken', Value);end;
procedure TEquipmentXRef.setWarantyTaken(const Value: Integer);begin  SetIntegerField('WarantyPeriodLeft', Value);end;
procedure TEquipmentXRef.SetEquipmentId(const Value: Integer);begin  SetIntegerField('CustomerEquipmentid', Value);end;
function TEquipmentXRef.GetSaleId: Integer;begin  result := getIntegerfield('SaleId');end;
procedure TEquipmentXRef.SetSaleId(const Value: Integer);begin  SetIntegerField('SaleID', Value);end;
function TEquipmentXRef.getUOM: string;begin  result := GetStringField('UOM');end;
function TEquipmentXRef.getUOMID: Integer;begin  result := getIntegerfield('UOMID');end;
function TEquipmentXRef.GetUOMMultiplier: Double;begin  result := GetFloatField('UOMMultiplier');end;
function TEquipmentXRef.GetUOMQty: Double;begin  result := GetFloatField('UOMQty');end;
procedure TEquipmentXRef.setUOM(const Value: string);begin  SetStringField('UOM', Value);end;
procedure TEquipmentXRef.setUOMID(const Value: Integer);begin  SetIntegerField('UOMID', Value);end;
procedure TEquipmentXRef.setUOMQty(const Value: Double); begin  SetFloatField('UOMQty', Value);end;
function TEquipmentXRef.getInvoiceID: Integer;begin  result := getIntegerfield('InvoiceID');end;
procedure TEquipmentXRef.SetInvoiceId(const Value: Integer);begin  SetIntegerField('InvoiceID', Value);end;
function TEquipmentXRef.getAppointmentID: Integer;begin  result := getIntegerfield('AppointmentID');end;
procedure TEquipmentXRef.setAppointmentID(const Value: Integer);begin  SetIntegerField('AppointmentID', Value);end;
function TEquipment.geTManufacture: string;begin  result := GetStringField('Manufacture');end;
function TEquipment.getmodel: string;begin  result := GetStringField('model');end;
procedure TEquipment.seTManufacture(const Value: string);begin  SetStringField('Manufacture', Value);end;
procedure TEquipment.setmodel(const Value: string);begin  SetStringField('model', Value);end;
function TEquipmentXRef.getWarantyStartDate: TDatetime;begin  result := GetDatetimeField('WarantyStartDate');end;
procedure TEquipmentXRef.SetVehicleRego_Expiry(const Value: TDatetime);begin  SetDatetimeField('VehicleRego_Expiry', Value);end;
function TEquipmentXRef.isQLDRegisteredVehicle: Boolean;
var
  qry: TERPQuery;
begin
  result := False;
  if Rego = '' then exit;

  qry := SharedQuery;
  try
    qry.sql.text := 'SELECT E.isQLDRegisteredVehicle '+
                    ' FROM tblEquipmentxRef ExRef  '+
                    ' inner join tblcustomerequip CE on ExRef.customerEquipmentId = CE.id  '+
                    ' inner join tblEquipment E on E.EquipmentId = CE.EquipmentID  '+
                    ' where ExRef.ID = ' + inttostr(ID);
    qry.open;
    Result := qry.fieldbyname('isQLDRegisteredVehicle').AsBoolean;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TEquipmentXRef.GetUOMNameProductKey: string;
begin
  if UOMID > 0 then
    result := TUnitOfMeasure.IDToggle(UOMID, Connection.Connection)
  else
    result := '';
end;
procedure TEquipmentXRef.setUOMMultiplier(const Value: Double);
begin
  SetFloatField('UOMMultiplier', Value);
end;function TEquipmentXRef.getCustomerEquipment: TCustomerEquipment;
begin
  result := TCustomerEquipment(getContainerComponent(TCustomerEquipment,
    'ID = ' + IntToStr(CustomerEquipmentID)));
end;
function TEquipmentXRef.getisRepairConverted: Boolean;
var
  strSQL: string;
begin
  result := False;
  if RepairID = 0 then
    Exit;

  strSQL := 'select converted from tblrepairs where repairId =' +
    IntToStr(RepairID);
  with GetNewDataSet(strSQL, true) do
    try
      result := FieldByName('converted').asBoolean;
    finally
      if Active then
        close;
      Free;
    end;
end;



procedure TEquipmentXRef.SetUOMNameProductKey(const Value: string);
var
  UomObj: TUnitOfMeasure;
begin
  if Value <> '' then
  begin
    UomObj := TUnitOfMeasure.Create(nil);
    try
      UomObj.Connection := self.Connection;
      UomObj.LoadSelect('UnitProductKeyName = ' + QuotedStr(Value));
      if UomObj.count > 0 then
      begin
        UOMID := UomObj.ID;
        UOM := UomObj.UOMName;
        UOMMultiplier := UomObj.Multiplier;
      end
      else
      begin
        UOMID := 0;
        UOM := '';
        UOMMultiplier := 1;
      end;
    finally
      UomObj.Free;
    end;
  end
  else
  begin
    UOMID := 0;
    UOM := '';
    UOMMultiplier := 1;
  end;
end;


{ TEquipmentParts }

constructor TEquipmentParts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'EquipmentParts';
  fSQL := 'SELECT * FROM tblequipmentparts';
  fIsList := true;
  ExportExcludeList.Add('equipmentid');
  ExportExcludeList.Add('equipmentname');
  ExportExcludeList.Add('productid');
end;

destructor TEquipmentParts.Destroy;
begin
  inherited;
end;

procedure TEquipmentParts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EquipmentId');
  SetPropertyFromNode(node, 'Equipmentname');
  SetPropertyFromNode(node, 'ProductId');
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'Quantity');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'PARTSDESCRIPTION');
end;

procedure TEquipmentParts.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EquipmentId', EquipmentID);
  AddXMLNode(node, 'Equipmentname', EquipmentName);
  AddXMLNode(node, 'ProductId', ProductID);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'PARTSDESCRIPTION', PartsDescription);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Quantity', Quantity);
end;

function TEquipmentParts.ValidateData: Boolean;
begin
  result := False;
  ResultStatus.Clear;
  if EquipmentID = 0 then
  begin
    AddResult(False, rssError, 0, 'EquipmentId should not be 0');
    Exit;
  end;
  if (ProductID = 0) and (ProductName = '') then
  begin
    AddResult(False, rssError, 0, 'Product should not be blank');
    Exit;
  end;
  if (ProductID = 0) and (ProductName <> '') then
  begin
    AddResult(False, rssError, 0, 'Product not found for ProductName "' +
      ProductName + '"');
    Exit;
  end;
  if (ProductID > 0) and (ProductName = '') then
  begin
    AddResult(False, rssError, 0, 'Product not found for Product ID: ' +
      IntToStr(ProductID));
    Exit;
  end;
  result := true;
end;

function TEquipmentParts.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TEquipmentParts.OnDataIdChange(const ChangeType
  : TBusObjDataChangeType);
begin
  inherited;
end;

procedure TEquipmentParts.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then
      Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.FieldName, 'ProductName') then
  begin
    ProductID := TProductSimple.IDToggle(ProductName, Connection.Connection);
  end
  else if sysutils.SameText(Sender.FieldName, 'ProductID') then
  begin
    ProductName := TProductSimple.IDToggle(ProductID, Connection.Connection);
  end;
end;

function TEquipmentParts.GetSQL: string;begin  result := inherited GetSQL;end;
class function TEquipmentParts.GetIDField: string;begin  result := 'ID'end;
class function TEquipmentParts.GetBusObjectTablename: string;begin  result := 'tblequipmentparts';end;

function TEquipmentParts.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then    Exit;
  if (ProductName <> '') and (ProductID <> 0) and (Quantity = 0) then Quantity := 1;
end;
function TEquipmentParts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then
    Exit;
  if (ProductName = '') and (ProductID = 0) and (CleanProductID = 0) then
    Delete;
end;

{ Property Functions }
function TEquipmentParts.GetEquipmentId: Integer;begin  result := getIntegerfield('EquipmentId');end;
function TEquipmentParts.GetEquipmentname: string;begin  result := GetStringField('Equipmentname');end;
function TEquipmentParts.GetProductID: Integer;begin  result := getIntegerfield('ProductId');end;
function TEquipmentParts.GetProductName: string;begin  result := GetStringField('ProductName');end;
function TEquipmentParts.GetActive: Boolean;begin  result := GetBooleanField('Active');end;
function TEquipmentParts.GetQuantity:Double; begin result := GetfloatField('Quantity');end;
procedure TEquipmentParts.SetEquipmentId(const Value: Integer);begin  SetIntegerField('EquipmentId', Value);end;
procedure TEquipmentParts.SetEquipmentname(const Value: string);begin  SetStringField('Equipmentname', Value);end;
procedure TEquipmentParts.SetProductID(const Value: Integer);begin  SetIntegerField('ProductId', Value);end;
procedure TEquipmentParts.SetProductName(const Value: string);begin  SetStringField('ProductName', Value);end;
procedure TEquipmentParts.SetActive(const Value: Boolean);begin  SetBooleanField('Active', Value);end;
procedure TEquipmentParts.SetQuantity(const Value: double);begin  Setfloatfield('Quantity', Value);end;

function TEquipment.getTEquipmentParts: TEquipmentParts;
begin
  result := TEquipmentParts(getContainerComponent(TEquipmentParts,    'EquipmentID =' + IntToStr(ID)));
end;

function TEquipmentParts.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then
    Exit;
  Active := true;
  if assigned(self.Owner) then
    if self.Owner is TEquipment then
    begin
      EquipmentID := TEquipment(self.Owner).ID;
      EquipmentName := TEquipment(self.Owner).EquipmentName;
    end;
end;

function TEquipment.geTManufactureID: Integer; begin  result := getIntegerfield('ManufactureID')end;
procedure TEquipment.seTManufactureID(const Value: Integer);begin  SetIntegerField('ManufactureID', Value)end;
function TEquipmentParts.getCleanProductID: Integer;begin  result := GetXMLNodeIntegerValue(CleanXMLNode, 'ProductID');end;
function TEquipment.getCleanProductID: Integer;begin   result := GetXMLNodeIntegerValue(CleanXMLNode, 'ProductID'); end;
function TEquipment.getCleanSerialNumber: String;begin   result := GetXMLNodeStringValue(CleanXMLNode, 'SerialNumber'); end;


class function TEquipment.IdForEquipManModel(const aEquipName, aManufacture,
  aModel: string; Conn: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := Conn;
    qry.SQL.Add('select EquipmentID from tblEquipment');
    qry.SQL.Add('where EquipmentName = ' + QuotedStr(aEquipName));
    if aManufacture <> '' then
      qry.SQL.Add('and Manufacture = ' + QuotedStr(aManufacture));
    if aModel <> '' then
      qry.SQL.Add('and Model = ' + QuotedStr(aModel));
    qry.Open;
    result := qry.FieldByName('EquipmentID').AsInteger;
  finally
    qry.Free;
  end;
end;

function TEquipment.ImportsubClasses(const node: IXMLNode): Boolean;
var
  Singlerec: IXMLNode;
  x: Integer;
begin
  result := False;

  ImportFailed := False;
  XMLPropertyName := 'EquipmentParts';
  XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
  if assigned(XMLPropertyNode) then
  begin
    EquipmentParts.DeleteAll;
    for x := 0 to XMLPropertyNode.ChildNodes.count - 1 do
    begin
      EquipmentParts.ImportingFromXMLFile := False;
      Singlerec := XMLPropertyNode.ChildNodes[x];
      EquipmentParts.New;
      EquipmentParts.ImportFromXML(Singlerec);
      EquipmentParts.PostDB;
      ImportFailed := EquipmentParts.ImportFailed;
      if Error then
        Exit;
    end;
  end;
end;

function TEquipment.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  self.EquipmentParts.XMLPropertyNode := node.AddChild('EquipmentParts');
  self.EquipmentParts.XMLPropertyName := 'EquipmentParts';
  self.EquipmentParts.IterateRecords(GetPropertyXMLCallback);
  result := true;
end;

function TEquipmentParts.getPARTSDESCRIPTION: string;begin  result := GetStringField('PARTSDESCRIPTION');end;
procedure TEquipmentParts.setPARTSDESCRIPTION(const Value: string);begin  SetStringField('PARTSDESCRIPTION', Value);end;
procedure TEquipmentPicture.LoadFromXMLNode(const node: IXMLNode);begin  inherited;  SetPropertyFromNode(node, 'EquipmentID');end;

{ TEquipmentPicture }

constructor TEquipmentPicture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'EquipmentPicture';
  fSQL := 'SELECT * FROM tblEquipmentPicture';
end;

destructor TEquipmentPicture.Destroy;
begin
  freeandnil(fEquipImageStream);
  freeandnil(fEquipMapStream);
  inherited;
end;

procedure TEquipmentPicture.Load(const fIsReadonly: Boolean);
begin
  inherited;
  freeandnil(fEquipImageStream);
  freeandnil(fEquipMapStream);
end;



procedure TEquipmentPicture.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EquipmentID', EquipmentID);
end;

function TEquipmentPicture.ValidateData: Boolean;
begin
  ResultStatus.Clear;
  result := false;
  if EquipmentID < 1 then begin
    AddResult(false, rssWarning, 0, 'Equipment ID is blank');
    exit;
  end;
  result:= true;
end;

class function TEquipmentPicture._Schema: string;
begin
  result := inherited;
  TBOSchema.AddRefType(result, 'TEquipment', 'EquipmentObj', 'EquipmentID', 'ID');
end;

function TEquipmentPicture.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TEquipmentPicture.OnDataIdChange(Const ChangeType
  : TBusObjDataChangeType);
begin
  inherited;
end;

function TEquipmentPicture.Picturefieldname: String;
begin
  REsult := 'EquipImage';
end;

function TEquipmentPicture.Picturetypefieldname: String;
begin
  REsult := 'EquipImagetype';
end;

procedure TEquipmentPicture.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TEquipmentPicture.GetSQL: string;begin  result := inherited GetSQL;end;
class function TEquipmentPicture.GetIDField: string;begin  result := 'ID'end;
class function TEquipmentPicture.GetBusObjectTablename: string;begin  result := 'tblEquipmentPicture';end;

function TEquipmentPicture.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if assigned(self.Owner) and (self.Owner is TEquipment) then begin
      EquipmentID := TEquipment(self.Owner).ID;
  end;
end;

function TEquipmentPicture.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TEquipmentPicture.GetEquipImageStream: TStream;
var
  fld: TField;
begin
  result := nil;
  if assigned(Dataset) and Dataset.Active then
  begin
    if not assigned(fEquipImageStream) then
    begin
      fld := Dataset.FieldByName('EquipImage');
      if (Dataset.State in [dsEdit, dsInsert]) then
        fEquipImageStream := Dataset.CreateBlobStream(TBlobField(fld),
          bmReadWrite)
      else
        fEquipImageStream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
    end;
    fEquipImageStream.Position := 0;
    result := fEquipImageStream;
  end;
end;

function TEquipmentPicture.GetEquipMapStream: TStream;
var
  fld: TField;
begin
  result := nil;
  if assigned(Dataset) and Dataset.Active then
  begin
    if not assigned(fEquipMapStream) then
    begin
      fld := Dataset.FieldByName('EquipMap');
      if (Dataset.State in [dsEdit, dsInsert]) then
        fEquipMapStream := Dataset.CreateBlobStream(TBlobField(fld),
          bmReadWrite)
      else
        fEquipMapStream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
    end;
    fEquipMapStream.Position := 0;
    result := fEquipMapStream;
  end;
end;

function TEquipmentPicture.GetMIMEEncodedEquipImage: string;
var
  MIMEEncoder: TIdEncoderMIME;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  try
    result := MIMEEncoder.Encode(EquipImageStream);

  finally
    MIMEEncoder.Free;
  end;
end;

function TEquipmentPicture.GetMIMEEncodedEquipMap: string;
var
  MIMEEncoder: TIdEncoderMIME;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  try
    result := MIMEEncoder.Encode(EquipMapStream);

  finally
    MIMEEncoder.Free;
  end;
end;

procedure TEquipmentPicture.SetMIMEEncodedEquipImage(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    freeandnil(fEquipImageStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then
      Dataset.Edit;
    DecoderMIME.DecodeBegin(EquipImageStream);
    try
      DecoderMIME.Decode(Value);
    finally
      DecoderMIME.DecodeEnd;
    end;
  finally
    DecoderMIME.Free;
  end;
end;

procedure TEquipmentPicture.SetMIMEEncodedEquipMap(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    freeandnil(fEquipMapStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then
      Dataset.Edit;
    DecoderMIME.DecodeBegin(EquipMapStream);
    try
      DecoderMIME.Decode(Value);
    finally
      DecoderMIME.DecodeEnd;
    end;
  finally
    DecoderMIME.Free;
  end;
end;

function TEquipmentPicture.GetEquipmentId: Integer;
begin
  result := getIntegerfield('EquipmentID');
end;


procedure TEquipmentPicture.SetEquipmentId(const Value: Integer);
begin
  SetIntegerField('EquipmentID', Value);
end;


{ TEquipmentJPGPicture }

function TEquipmentJPGPicture.GetMIMEEncodedEquipImage: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    Bitmap.LoadFromStream(EquipImageStream);
    JpegImg.Assign(Bitmap);
    JpegImg.SaveToStream(stream);
    stream.Position := 0;
    result := MIMEEncoder.Encode(stream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEEncoder.Free;
    stream.Free;
  end;
end;

function TEquipmentJPGPicture.GetMIMEEncodedEquipMap: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    Bitmap.LoadFromStream(EquipMapStream);
    JpegImg.Assign(Bitmap);
    JpegImg.SaveToStream(stream);
    stream.Position := 0;
    result := MIMEEncoder.Encode(stream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEEncoder.Free;
    stream.Free;
  end;
end;

procedure TEquipmentJPGPicture.SetMIMEEncodedEquipImage(const Value: string);
var
  MIMEDecoder: TIdDecoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEDecoder := TIdDecoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    freeandnil(fEquipImageStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then
      Dataset.Edit;
    MIMEDecoder.DecodeBegin(stream);
    try
      MIMEDecoder.Decode(Value);
    finally
      MIMEDecoder.DecodeEnd;
    end;
    stream.Position := 0;
    JpegImg.LoadFromStream(stream);
    Bitmap.Assign(JpegImg);
    Bitmap.SaveToStream(EquipImageStream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEDecoder.Free;
    stream.Free;
  end;

end;

procedure TEquipmentJPGPicture.SetMIMEEncodedEquipMap(const Value: string);
var
  MIMEDecoder: TIdDecoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEDecoder := TIdDecoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    freeandnil(fEquipMapStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then
      Dataset.Edit;
    MIMEDecoder.DecodeBegin(stream);
    try
      MIMEDecoder.Decode(Value);
    finally
      MIMEDecoder.DecodeEnd;
    end;
    stream.Position := 0;
    JpegImg.LoadFromStream(stream);
    Bitmap.Assign(JpegImg);
    Bitmap.SaveToStream(EquipMapStream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEDecoder.Free;
    stream.Free;
  end;

end;

{ TEquipmentImages }

constructor TEquipmentImages.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'EquipmentImages';
  fSQL := 'SELECT * FROM tblequipmentimages';
end;

destructor TEquipmentImages.Destroy;
begin
  freeandnil(fEquipImageStream);
  inherited;
end;

procedure TEquipmentImages.Load(const fIsReadonly: Boolean);
begin
  inherited;
  freeandnil(fEquipImageStream);
end;

procedure TEquipmentImages.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EquipmentID');
end;

procedure TEquipmentImages.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EquipmentID', EquipmentID);
end;

function TEquipmentImages.ValidateData: Boolean;
begin
  ResultStatus.Clear;
  result := false;
  if EquipmentID < 1 then begin
    AddResult(false, rssWarning, 0, 'Equipment ID is blank');
    exit;
  end;
  result:= true;
end;

class function TEquipmentImages._Schema: string;
begin
  result := inherited;
  TBOSchema.AddRefType(result, 'TEquipment', 'EquipmentObj', 'EquipmentID', 'ID');
end;

function TEquipmentImages.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TEquipmentImages.OnDataIdChange(Const ChangeType
  : TBusObjDataChangeType);
begin
  inherited;
end;

function TEquipmentImages.Picturefieldname: String;
begin
  REsult := 'EquipImage';
end;

function TEquipmentImages.Picturetypefieldname: String;
begin
  REsult := 'EquipImagetype';
end;

procedure TEquipmentImages.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TEquipmentImages.GetSQL: string;
begin
  result := inherited GetSQL;
end;

class function TEquipmentImages.GetIDField: string;
begin
  result := 'ID'
end;

class function TEquipmentImages.GetBusObjectTablename: string;
begin
  result := 'tblequipmentimages';
end;

function TEquipmentImages.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if assigned(self.Owner) and (self.Owner is TEquipment) then begin
      EquipmentID := TEquipment(self.Owner).ID;
  end;
end;

function TEquipmentImages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

{ Property Functions }

function TEquipmentImages.GetEquipmentId: Integer;
begin
  result := getIntegerfield('EquipmentID');
end;


procedure TEquipmentImages.SetEquipmentId(const Value: Integer);
begin
  SetIntegerField('EquipmentID', Value);
end;


function TEquipmentImages.GetEquipImageStream: TStream;
var
  fld: TField;
begin
  result := nil;
  if assigned(Dataset) and Dataset.Active then
  begin
    if not assigned(fEquipImageStream) then
    begin
      fld := Dataset.FieldByName('EquipImage');
      if (Dataset.State in [dsEdit, dsInsert]) then
        fEquipImageStream := Dataset.CreateBlobStream(TBlobField(fld),
          bmReadWrite)
      else
        fEquipImageStream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
    end;
    fEquipImageStream.Position := 0;
    result := fEquipImageStream;
  end;
end;

function TEquipmentImages.GetMIMEEncodedEquipImage: string;
var
  MIMEEncoder: TIdEncoderMIME;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  try
    result := MIMEEncoder.Encode(EquipImageStream);

  finally
    MIMEEncoder.Free;
  end;
end;

procedure TEquipmentImages.SetMIMEEncodedEquipImage(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    freeandnil(fEquipImageStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then
      Dataset.Edit;
    DecoderMIME.DecodeBegin(EquipImageStream);
    try
      DecoderMIME.Decode(Value);
    finally
      DecoderMIME.DecodeEnd;
    end;
  finally
    DecoderMIME.Free;
  end;
end;

{ TEquipmentJPGImages }

function TEquipmentJPGImages.GetMIMEEncodedEquipImage: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    Bitmap.LoadFromStream(EquipImageStream);
    JpegImg.Assign(Bitmap);
    JpegImg.SaveToStream(stream);
    stream.Position := 0;
    result := MIMEEncoder.Encode(stream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEEncoder.Free;
    stream.Free;
  end;
end;

procedure TEquipmentJPGImages.SetMIMEEncodedEquipImage(const Value: string);
var
  MIMEDecoder: TIdDecoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEDecoder := TIdDecoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    freeandnil(fEquipImageStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then
      Dataset.Edit;
    MIMEDecoder.DecodeBegin(stream);
    try
      MIMEDecoder.Decode(Value);
    finally
      MIMEDecoder.DecodeEnd;
    end;
    stream.Position := 0;
    JpegImg.LoadFromStream(stream);
    Bitmap.Assign(JpegImg);
    Bitmap.SaveToStream(EquipImageStream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEDecoder.Free;
    stream.Free;
  end;

end;

initialization
  RegisterClass(TEquipmentParts);
  RegisterClassOnce(TEquipment);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Equipment', 'TEquipment','TEquipmentListGUI');
  RegisterClassOnce(TEquipmentXRef);
  RegisterClass(TEquipmentPicture);
  RegisterClassOnce(TEquipmentJPGPicture);
  RegisterClass(TEquipmentImages);
  RegisterClassOnce(TEquipmentJPGImages);
end.
