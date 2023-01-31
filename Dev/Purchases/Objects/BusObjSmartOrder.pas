unit BusObjSmartOrder;

interface

Uses TypesLib, Classes,BusObjBase, DB, BusObjStock, busobjOrders, UserLockObj,
  IntegerListObj, ProgressDialog, BusobjBaseProdTrans , BusobjSmartOrderRFQ, BusObjProductClass,
  BusObjClient, XMLIntf , busobjtodo;

Type
    TQtyChange = (qcPurchase=1, qcPurchaseUOM =2, qcTotal=3, qcTotalUOM=4, qcToBuild=5, qcToBuildUOM = 6);

    TSmartOrderLine = Class(TProdTrans)
    Private
      fbCalcQtyFromformula: Boolean;
      fbCalcQtys :Boolean;
      Function GetSmartOrderID			: Integer;
      Function GetPARTSID	        		: Integer;
      Function GetSupplierID	    		: Integer;
      Function GetClassID	        		: Integer;
      Function GetGroupID	        		: Integer;
      Function GetGroupLineID	    		: Integer;
      Function GetToPurchaseUOMQty    : Double;
      Function GetToPurchaseQty    		: Double;
      Function GetTotalQty    		    : Double;
      Function GetTotalUOMqty    		  : Double;
      Function GetTobuildQty    		  : Double;
      Function GetToBuildUOMQty    		: Double;
      Function GetLinePrice	    		  : Double;
      Function GetLineTaxRate	        : Double;
      Function GetCostEx	        		: Double;
      Function GetCostInc	        		: Double;
      Function GetSupplierName			  : String;
      Function GetSupplierPrintName   : String;
      Function GetClassName	    		  : String;
      Function GetCusJobName	    		: String ;
      Function GetCusJobPrintName 		: String ;
      Function GetCusJobID	    		  : Integer;
      Function GetPODesc	        		: String;
      Function GetSupplierContact			: String;
      Function GetCustPONumber			  : String;
      Function GetPARTSNAME	    		  : String;
      Function GetSearchFilter			  : String;
      Function GetFilterCopy		      : String;
      Function GetDocketNumber			  : String;
      Function GetCustomField1			  : String;
      Function GetCustomField2			  : String;
      Function GetCustomField3			  : String;
      Function GetCustomField4			  : String;
      Function GetCustomField5			  : String;
      Function GetCustomField6			  : String;
      Function GetCustomField7			  : String;
      Function GetCustomField8			  : String;
      Function GetCustomField9			  : String;
      Function GetCustomField10			  : String;
      Function GetEditedFlag	    		: Boolean;
      Function GetGroupheader	    		: Boolean;
      Function GetMultiBuy  	    		: Boolean;
      Function GetConverted  	    		: Boolean;
      Function GetDeleted	    		    : Boolean;
      function GetLineNotes           : string;
      Function CalcBaseLineAmount     : Double;
      Function GetSaleLineID          : Integer;
      Function GetHirePartsSaleID     : Integer;
      function getCustomerEquipmentID : Integer;
      function getEquipmentName       : String;
      function getRepairId            : Integer;
      function getRepairPartsID       : Integer;
      function GetSupplierProductCode : string;
      function GetSupplierProductName : string;
      function GetSupplierBarCode : string;
      function getPrintedValue        : Double;
      function getWastagePercentage   : Double;
      function getpartbarcode         : String;
      procedure setCustomerEquipmentID  (const Value: Integer);
      procedure SetEquipmentName        (const Value: String);
      procedure setRepairId             (const Value: Integer);
      procedure setRepairPartsID        (const Value: Integer);
      Procedure SetSmartOrderID			    (Const Value :Integer);
      Procedure SetPARTSID				      (Const Value :Integer);
      Procedure SetSupplierID				    (Const Value :Integer);
      Procedure setClassID				      (Const Value :Integer);
      Procedure SetGroupID				      (Const Value :Integer);
      Procedure SetGroupLineID			    (Const Value :Integer);
      Procedure SetToPurchaseUOMQty     (Const Value :Double);
      Procedure SetLinePrice				    (Const Value :Double);
      Procedure SetToPurchaseQty        (Const Value :Double);
      Procedure SetTotalQty             (Const Value :Double);
      Procedure SetTotalUOMqty          (Const Value :Double);
      Procedure SetTobuildQty           (Const Value :Double);
      Procedure SetToBuildUOMQty        (Const Value :Double);
      Procedure SetLineTaxRate			    (Const Value :Double);
      Procedure SetCostEx				        (Const Value :Double);
      Procedure SetCostInc				      (Const Value :Double);
      Procedure SetSupplierName			    (Const Value :String);
      Procedure SetSupplierPrintName    (Const Value :String);
      Procedure SetClassName				    (Const Value :String);
      Procedure SetCusJobName				    (Const Value :String );
      Procedure SetCusJobPrintName	    (Const Value :String );
      Procedure SetSupplierContact		  (Const Value :String);
      Procedure SetCusJobID				      (Const Value :Integer);
      Procedure SetPODesc				        (Const Value :String);
      Procedure SetCustPONumber			    (Const Value :String);
      Procedure SetPARTSNAME				    (Const Value :String);
      Procedure SetSearchFilter			    (Const Value :String);
      Procedure SetFilterCopy		        (Const Value :String);
      Procedure SetDocketNumber			    (Const Value :String);
      Procedure SetCustomField1			    (Const Value :String);
      Procedure SetCustomField2			    (Const Value :String);
      Procedure SetCustomField3			    (Const Value :String);
      Procedure SetCustomField4			    (Const Value :String);
      Procedure SetCustomField5			    (Const Value :String);
      Procedure SetCustomField6			    (Const Value :String);
      Procedure SetCustomField7			    (Const Value :String);
      Procedure SetCustomField8			    (Const Value :String);
      Procedure SetCustomField9			    (Const Value :String);
      Procedure SetCustomField10			  (Const Value :String);
      Procedure SetEditedFlag				    (Const Value :Boolean);
      Procedure SetDeleted			        (Const Value :Boolean);
      Procedure SetGroupheader			    (Const Value :Boolean);
      Procedure SetMultiBuy   			    (Const Value :Boolean);
      Procedure SetConverted  			    (Const Value :Boolean);
      procedure SetLineNotes            (const Value: string);
      procedure SetSaleLineID           (const Value: Integer);
      procedure SetHirePartsSaleID      (const Value: Integer);
      procedure setProcTreeId           (const Value: Integer);
      procedure SetSupplierProductCode  (const Value: string);
      procedure SetSupplierProductName  (const Value: string);
      procedure SetSupplierBarCode  (const Value: string);
      procedure setPrintedValue         (const Value: Double);
      procedure setWastagePercentage    (const Value: Double);
      procedure setpartbarcode          (const Value: String);
      Procedure SearchBarcode;
      procedure SetProductDetails;
      procedure CalcPrice;
      function getHeight: Double;
      function getLength: Double;
      function getvolume: Double;
      function getWeight: Double;
      function getWidth: Double;
      function getProcTreeId: Integer;
      procedure CalcQtyFromformula;
      procedure getCalcQtYformulaValue(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
      procedure CalcQtys(const QtyType : TQtyChange);
      function IsBOMProduct: Boolean;
      function getTotalvolume: double;
      function getTotalWeight: double;
      function getTotalcostEx: double;
      function getTotalcostInc: double;
      function getunitVolume: double;
      function getProductClass: TProductclass;
      procedure setToPurchaseQtyexWastagePercentage(const Value: Double);
      procedure setToPurchaseUOMQtyexWastagePercentage(const Value: Double);
      function GetGeneralNotes: string;
      procedure SetGeneralNotes(const Value: string);
      function getSupplier: TSupplier;
      function GetUserEnteredCost: boolean;
      procedure SetUserEnteredCost(const Value: boolean);
        //procedure AddDesc(const Value: string);
    Protected
        Function  GetSQL                                : String;   override;
        Function  GetId                                 : Integer;  override;
        Function  DoAfterInsert(Sender :TDatasetBusObj) : Boolean;  override;
        Function  DoAfterPost(Sender :TDatasetBusObj )  : Boolean;  override;
        Function  DoBeforePost(Sender :TDatasetBusObj ) : Boolean;  override;
        procedure DoFieldOnChange(Sender: TField);                  override;
        procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
        procedure InitializeNewObject;                              override;
        Procedure CreateInstance;                                   Override;
        procedure SetActive(const Value: Boolean); Override;
        function GetActive: Boolean; Override;
        function GetUnitOfMeasureID: Integer; Override;
        procedure SetUnitOfMeasureID(const Value: Integer); Override;
        function GetUOMMultiplier: Double; Override;
        procedure SetUOMMultiplier(const Value: Double); Override;
        function GetUnitOfMeasure: string; Override;
        procedure SetUnitOfMeasure(const Value: string); Override;
        Function  DoBeforeEdit(Sender :TDatasetBusObj ):Boolean; Override;
    Public
      Constructor Create(AOwner:TComponent);                          override;
      class function  GetIDField              : string;           override;
      class function  GetBusObjectTablename   : string;           override;
      function GetProductID: Integer; Override;
      function GetProductName: string; Override;
      procedure SetProductID(const Value: Integer); Override;
      procedure SetProductName(const Value: string); Override;
      Property Totalvolume : double read getTotalvolume;
      Property TotalWeight : double read getTotalWeight;
      Property TotalCostEx : double read getTotalcostEx;
      Property TotalCostInc : double read getTotalcostInc;
      Property unitVolume :double read getunitVolume;
      Property ProductClass :TProductclass read getProductClass;
      Property ToPurchaseQtyexWastagePercentage :Double write setToPurchaseQtyexWastagePercentage;
      Property ToPurchaseUOMQtyexWastagePercentage :Double write setToPurchaseUOMQtyexWastagePercentage;
      Property Supplier :TSupplier read getSupplier;
      property UserEnteredCost: boolean read GetUserEnteredCost write SetUserEnteredCost;
      function Delete: boolean; overload; override;
    Published
      Property 	ToPurchaseQty           : Double	Read GetToPurchaseQty       Write SetToPurchaseQty	;
      Property 	TotalQty                : Double	Read GetTotalQty            Write SetTotalQty	;
      Property 	TotalUOMqty             : Double	Read GetTotalUOMqty         Write SetTotalUOMqty	;
      Property 	TobuildQty              : Double	Read GetTobuildQty          Write SetTobuildQty	;
      Property 	ToBuildUOMQty           : Double	Read GetToBuildUOMQty       Write SetToBuildUOMQty	;
      Property 	LinePrice				        : Double	Read GetLinePrice				    Write SetLinePrice	;
      Property 	LineTaxRate				      : Double	Read GetLineTaxRate				  Write SetLineTaxRate	;
      Property 	ToPurchaseUOMQty        : Double	Read GetToPurchaseUOMQty    Write SetToPurchaseUOMQty	;
      Property 	UnitofMeasureMultiplier	: Double	Read GetUOMMultiplier	      Write SetUOMMultiplier	;
      Property 	CostEx					        : Double	Read GetCostEx				      Write SetCostEx	;
      Property 	CostInc					        : Double	Read GetCostInc				      Write SetCostInc	;
      Property 	EditedFlag				      : Boolean	Read GetEditedFlag				  Write SetEditedFlag	;
      Property 	Groupheader				      : Boolean	Read GetGroupheader				  Write SetGroupheader	;
      Property 	MultiBuy  				      : Boolean	Read GetMultiBuy  				  Write SetMultiBuy	;
      Property 	Deleted				          : Boolean	Read GetDeleted				      Write SetDeleted	;
      Property 	SmartOrderID			      : Integer	Read GetSmartOrderID			  Write SetSmartOrderID	;
      Property 	PARTSID					        : Integer	Read GetPARTSID				      Write SetPARTSID	;
      Property 	SupplierID				      : Integer	Read GetSupplierID				  Write SetSupplierID	;
      Property 	ClassID					        : Integer	Read GetClassID				      Write setClassID	;
      Property 	GroupID					        : Integer	Read GetGroupID				      Write SetGroupID	;
      Property 	GroupLineID				      : Integer	Read GetGroupLineID				  Write SetGroupLineID	;
      Property 	CusJobID				        : Integer	Read GetCusJobID				    Write SetCusJobID	;
      Property 	PODesc					        : String	Read GetPODesc				      Write SetPODesc	;
      Property 	SupplierContact		      : String	Read GetSupplierContact			Write SetSupplierContact	;
      Property 	CustPONumber			      : String	Read GetCustPONumber			  Write SetCustPONumber	;
      Property 	PARTSNAME				        : String	Read GetPARTSNAME				    Write SetPARTSNAME	;
      Property 	SearchFilter			      : String	Read GetSearchFilter			  Write SetSearchFilter	;
      Property 	SearchFilterCopy	      : String	Read GetFilterCopy		      Write SetFilterCopy	;
      Property 	SupplierName			      : String	Read GetSupplierName			  Write SetSupplierName	;
      Property 	SupplierPrintName	      : String	Read GetSupplierPrintName	  Write SetSupplierPrintName	;
      Property 	DeptName				        : String	Read GetClassName				    Write SetClassName	;
      Property 	CusJobName				      : String	Read GetCusJobName				  Write SetCusJobName	;
      Property 	CusJobPrintName 	      : String	Read GetCusJobPrintName		  Write SetCusJobPrintName	;
      Property 	DocketNumber			      : String	Read GetDocketNumber			  Write SetDocketNumber	;
      property  LineNotes               : string  Read GetLineNotes           Write SetLineNotes;
      property  GeneralNotes            : string  Read GetGeneralNotes        Write SetGeneralNotes;
      Property 	CustomField1			      : String	Read GetCustomField1			  Write SetCustomField1	;
      Property 	CustomField2			      : String	Read GetCustomField2			  Write SetCustomField2	;
      Property 	CustomField3			      : String	Read GetCustomField3			  Write SetCustomField3	;
      Property 	CustomField4			      : String	Read GetCustomField4			  Write SetCustomField4	;
      Property 	CustomField5			      : String	Read GetCustomField5			  Write SetCustomField5	;
      Property 	CustomField6			      : String	Read GetCustomField6			  Write SetCustomField6	;
      Property 	CustomField7			      : String	Read GetCustomField7			  Write SetCustomField7	;
      Property 	CustomField8			      : String	Read GetCustomField8			  Write SetCustomField8	;
      Property 	CustomField9			      : String	Read GetCustomField9			  Write SetCustomField9	;
      Property 	CustomField10			      : String	Read GetCustomField10			  Write SetCustomField10	;
      Property RepairId                 : Integer Read getRepairId            Write setRepairId;
      Property RepairPartsID            : Integer Read getRepairPartsID       Write setRepairPartsID;
      Property CustomerEquipmentID      : Integer Read getCustomerEquipmentID Write setCustomerEquipmentID;
      Property EquipmentName            : String  Read getEquipmentName       Write SetEquipmentName;
      Property Converted                : Boolean Read getConverted           Write setConverted;
      Property Weight                   : Double  Read getWeight;
      Property Height                   : Double  Read getHeight;
      Property Length                   : Double  Read getLength;
      Property Width                    : Double  Read getWidth;
      Property volume                   : Double  Read getvolume;
      property  SaleLineID              : Integer Read GetSaleLineID          Write SetSaleLineID   ;
      property  HirePartsSaleID         : Integer Read GetHirePartsSaleID     Write SetHirePartsSaleID   ;
      Property  ProcTreeId              : Integer Read getProcTreeId          Write setProcTreeId;
      property SupplierProductCode      : string  Read GetSupplierProductCode Write SetSupplierProductCode;
      Property PrintedValue             : Double  Read getPrintedValue        Write setPrintedValue;
      Property WastagePercentage        : Double  Read getWastagePercentage   Write setWastagePercentage;
      property SupplierProductName      : string  Read GetSupplierProductName Write SetSupplierProductName;
      property SupplierBarCode      : string  Read GetSupplierBarCode Write SetSupplierBarCode;
      Property partbarcode              : String  Read getpartbarcode         Write setpartbarcode;
    End;

    TSmartOrder = Class(TMSBusObj)
    Private
        slOrder         : TStringList;
        NoSupplierStr   : String;
        POObj           : TPurchaseOrder;
        MergingOrders   : TSmartOrder;
        fdTotalcostEx   : Double;
        fdTotalweight   : Double;
        fdtotalvolume   : double;
        fdTotalcostInc  : Double;
        fiTotalProducts : Integer;
        slItemCount     : TStringList;
        fRefreshFooter  : TGeneralProc;
        Iscalculating   : boolean;
        fProgressDialog: TProgressdialog;
        fbHideconvertedLines: Boolean;
        fLoading: boolean;
        function GetEmployeeID	        : Integer;
        function GetCreationDate	    : TDateTime;
        function GetSmartOrderDesc	    : String;
        function GetDone	            : Boolean;
        function GetApproved          : Boolean;
        function GetEditedFlag	        : Boolean;
        function GetSaleOrderID	        : Integer;
        function GetProjectLineID	    : Integer;
        Function GetLines               : TSmartOrderLine;
        Procedure SetEmployeeID	        (Const Value : Integer);
        Procedure SetCreationDate	      (Const Value : TDateTime);
        Procedure SetSmartOrderDesc	    (Const Value : String);
        Procedure SetDone	              (Const Value : Boolean);
        Procedure SetApproved           (Const Value : Boolean);
        Procedure SetEditedFlag	        (Const Value : Boolean);
        Procedure SetSaleOrderID	      (Const Value : Integer);
        Procedure SetProjectLineID	    (Const Value : Integer);
        procedure getsuppliers          (Const Sender: TBusObj; var Abort: boolean);
        procedure SOApprovedCallback    (Const Sender: TBusObj; var Abort: boolean);

        Function  CreatePO              (const fsSupplierID:String):Integer;
        procedure EMailPO;//s(const IDs : string);
        Procedure CreatePOLines         (Const Sender: TBusObj; var Abort: boolean);
        Procedure MergeSOs(Const Sender: TSmartOrder);//           (Const Sender: TBusObj; var Abort: boolean);
        Procedure MergeLines            (Const Sender: TBusObj; var Abort: boolean);
        Procedure CalcOrderTotalCallBack(Const Sender: TBusObj; var Abort: boolean);
        function DeleteFlaggedLines: boolean;
        function  getSalesGlobalref: String;
        function  getShipTo: String;
        function  getArea: String;
        procedure SetSalesGlobalref(const Value: String);
        procedure SetShipTo(const Value: String);
        procedure SetArea(const Value: String);
        function  getSaleLineRef: String;
        function  getHireGlobalref: String;
        procedure SetSaleLineRef(const Value: String);
        procedure SetHireGlobalref(const Value: String);
        procedure setHideconvertedLines(const Value: Boolean);
        function SONotcreatedforLine(const LineID: Integer): Boolean;
        function getRFQs: TSmartOrderRFQ;
        function getApprovedBy: integer;
        procedure SetApprovedBy(const Value: integer);
        function GetApproverID: integer;
        procedure SetApproverID(const Value: integer);
        function GetDefaultSupplierID: integer;
        function GetDefaultSupplierName: string;
        procedure SetDefaultSupplierID(const Value: integer);
        procedure SetDefaultSupplierName(const Value: string);
        function GetUseDefaultSupplierForAllLines: boolean;
        procedure SetUseDefaultSupplierForAllLines(const Value: boolean);
        function getcleanApproved: Boolean;
        function getToDos: TToDo;
    Protected
        Function        GetSQL                  : String;               override;
        Function        GetId                   : Integer;              override;
        procedure       InitializeNewObject;                            override;
        Function        DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
        procedure       OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
        procedure       DoFieldOnChange(Sender: TField);                  override;

    Public
        class function  GetIDField              : string;               override;
        class function  GetBusObjectTablename   : string;               override;
        function    CopySmartOrderToPO      : String;
        function    ValidateData                : Boolean ;             Override;
        function    Save                        : Boolean ;             override;
        destructor  Destroy;                                            override;
        Constructor Create(AOwner:TComponent);                          override;
        Procedure   Load(const fIsReadonly:boolean =False);Override;
        Procedure   New;                                                Override;
        Procedure   CalcOrderTotal(const Loading: boolean = false);
        Class function LockLinkedSOs(const SaleLineID: Integer;const UserLock :TUserLock;const LockGroupName,ProductName :STring; var Msg:STring): Boolean;
        Class function DeleteLinkToSO(const SaleLineID:Integer):String;
        function    MergedOrders(OrderList: TStringList): integer;
        Property    Totalweight   : Double read fdTotalweight write fdTotalweight;
        Property    Totalvolume   : double read fdTotalvolume write fdTotalvolume;
        Property    TotalProducts       : Integer       Read fiTotalProducts    Write fiTotalProducts;
        Property    RefreshFooter       : TGeneralProc  Read fRefreshFooter     Write fRefreshFooter;
        property ProgressDialog: TProgressDialog read fProgressDialog write fProgressDialog;
        Property HideconvertedLines:Boolean read fbHideconvertedLines Write setHideconvertedLines;
        Function isAllconverted:Boolean;
        Function IsAnyconverted:Boolean;
        function HasanyTobuild(const SelectedLineIDs:String):Boolean;
        function IsAllBomCreated(const SelectedLineIDs:String):Boolean;
        function IsanyBomCreated(const SelectedLineIDs:String):Boolean;
        Function CreateInternalsalesOrder(CreateSOforAll:Boolean):Integer;
        Procedure    LoadFromXMLNode      (const node: IXMLNode);     Override;
        Procedure    SaveToXMLNode        (const node: IXMLNode);     Override;
        Property cleanApproved :Boolean read getcleanApproved;
        Property Todos :TToDo read getToDos;
    Published
        Property  EmployeeID	        : Integer   read getEmployeeID          write setEmployeeID;
        Property  CreationDate	      : TDateTime REad getCreationDate        write setCreationDate;
        Property  SmartOrderDesc	    : String    read getSmartOrderDesc      write setSmartOrderDesc;
        Property  Done	              : Boolean   read getDone                write setDone;
        Property  Approved            : Boolean   read getApproved            write setApproved;
        Property  EditedFlag	        : Boolean   read getEditedFlag          write setEditedFlag;
        Property  SaleOrderID	        : Integer   read getSaleOrderID         write setSaleOrderID;
        Property  ProjectLineID	      : Integer   read getProjectLineID       write setProjectLineID;
        Property  SalesGlobalref      : String    Read getSalesGlobalref      Write SetSalesGlobalref;
        Property  ShipTo              : String    Read getShipTo              Write SetShipTo;
        Property  Area                : String    Read getArea              Write SetArea;
        Property  SaleLineRef         : String    Read getSaleLineRef         Write SetSaleLineRef;
        Property  HireGlobalref       : String    Read getHireGlobalref       Write SetHireGlobalref;
        Property  Lines               : TSmartOrderLine  read GetLines;
        Property  RFQs                : TSmartOrderRFQ read getRFQs;
        Property  TotalCostEx         : double        read fdTotalcostEx          write fdTotalcostEx;
        Property  TotalCostInc        : Double        Read fdTotalcostInc         Write fdTotalcostInc;
        property DefaultSupplierID    : integer       read GetDefaultSupplierID   write SetDefaultSupplierID;
        property DefaultSupplierName  : string        read GetDefaultSupplierName write SetDefaultSupplierName;
        property UseDefaultSupplierForAllLines: boolean read GetUseDefaultSupplierForAllLines write SetUseDefaultSupplierForAllLines;
        property  ApprovedBy          : integer   read getApprovedBy          write SetApprovedBy;
        property  ApproverID          : integer   read GetApproverID          write SetApproverID;

    End;

implementation

uses
  Sysutils, DateUtils, tcDataUtils, CommonLib,
  AppEnvironment, tcConst, TypInfo, BusObjTaxCodes,
  CommonDbLib, BusObjConst, ParserLib,BusObjSales, ERPDBComponents,
  DbSharedObjectsObj, SalesConst, BusObjApprovals,
  EmailUtils, CorrespondenceObj, ApprovalObj, BusObjAttachment;

{ TSmartOrder }

function TSmartOrder.GetEmployeeID      : Integer;  begin Result := getIntegerField('EmployeeID');              end;
function TSmartOrder.GetCreationDate    : TDateTime;begin Result := getDatetimeField('CreationDate');           end;
function TSmartOrder.GetSmartOrderDesc  : String;   begin Result := getStringfield('SmartOrderDesc');           end;
function TSmartOrder.GetDefaultSupplierID: integer;
begin
  result := GetIntegerField('DefaultSupplierID');
end;

function TSmartOrder.GetDefaultSupplierName: string;
begin
  result := GetStringField('DefaultSupplierName');
end;

function TSmartOrder.GetDone            : Boolean;  begin Result := Getbooleanfield('Done');                    end;
function TSmartOrder.GetApproved        : Boolean;  begin Result := Getbooleanfield('Approved');                end;
function TSmartOrder.GetEditedFlag      : Boolean;  begin Result := GetBooleanField('EditedFlag');              end;
function TSmartOrder.GetSaleOrderID     : Integer;  begin Result := getIntegerField('SaleOrderID');             end;
function TSmartOrder.GetProjectLineID   : Integer;  begin Result := getIntegerField('ProjectLineID');           end;
function TSmartOrder.GetCleanApproved   : Boolean;  begin Result := GetXMLNodeBooleanValue(CleanXMLNOde, 'Approved')end;

Procedure TSmartOrder.SetEmployeeID     (Const Value: Integer);  begin SetIntegerField('EmployeeId'     , Value);end;
Procedure TSmartOrder.SetCreationDate   (Const Value: TDateTime);begin SetDatetimefield('CreationDate'  , Value);end;
Procedure TSmartOrder.SetSmartOrderDesc (Const Value: String);   begin SetStringField('SmartOrderDesc'  , Value);end;
procedure TSmartOrder.SetUseDefaultSupplierForAllLines(const Value: boolean);
begin
  SetBooleanField('UseDefaultSupplierForAllLines', Value);
end;

procedure TSmartOrder.SetDefaultSupplierID(const Value: integer);
begin
  SetIntegerField('DefaultSupplierID',Value);
end;

procedure TSmartOrder.SetDefaultSupplierName(const Value: string);
begin
  SetStringField('DefaultSupplierName',Value);
end;

Procedure TSmartOrder.SetDone           (Const Value: Boolean);  begin SetBooleanField('done'           , Value);end;
Procedure TSmartOrder.SetApproved       (Const Value: Boolean);  begin
  SetBooleanField('Approved', Value);
  if Value then begin
    ApprovedBy := EmployeeId;
  end else begin
    ApprovedBy := 0;
  end;
end;

procedure TSmartOrder.SetApprovedBy(const Value: integer);
begin
  SetIntegerField('ApprovedBy', Value);
end;

procedure TSmartOrder.SetApproverID(const Value: integer);
begin
  SetIntegerField('ApproverID', Value);
end;

Procedure TSmartOrder.SetEditedFlag     (Const Value: Boolean);  begin SetBooleanField('EditedFlag'     , Value);end;
Procedure TSmartOrder.SetSaleOrderID    (Const Value: Integer);  begin SetIntegerField('SaleOrderID'    , Value);end;
Procedure TSmartOrder.SetProjectLineID  (Const Value: Integer);  begin SetIntegerField('ProjectLineID'  , Value);end;


Function  TSmartOrder.GetLines :TSmartOrderLine;
begin
  REsult := TSmartOrderLine(getcontainercomponent(TSmartOrderLine ,'SmartOrderId = ' + IntToStr(Self.ID)));
end;

Function  TSmartOrder.GetSQL                 : String;
begin
  result := inherited;
end;

Function  TSmartOrder.GetId                  : Integer;
begin
    Result := GetIntegerField(IDFieldName);
end;

class Function  TSmartOrder.GetIDField             : String;
begin
    Result := 'SmartOrderID';
end;

class function TSmartOrder.GetBusObjectTablename: string;
begin
  Result := 'tblSmartOrder';
end;


destructor TSmartOrder.Destroy;
begin
    FreeandNil(slItemCount);
    inherited;
end;

Procedure TSmartOrder.New;
begin
  fLoading := true;
  try
    Inherited;
  finally
    fLoading := false;
  end;
end;

Procedure TSmartOrder.Load(const fIsReadonly:boolean =False);
begin
  fLoading := true;
  try
    Inherited;
  finally
    fLoading := false;
  end;
end;

procedure TSmartOrder.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetDateTimePropertyFromNode(node,'CreationDate');
  SetPropertyFromNode(node,'SmartOrderDesc');
  SetBooleanPropertyFromNode(node,'Done');
  SetBooleanPropertyFromNode(node,'Approved');
  SetPropertyFromNode(node,'ApprovedBy');
  SetBooleanPropertyFromNode(node,'EditedFlag');
  SetPropertyFromNode(node,'SaleOrderID');
  SetPropertyFromNode(node,'ProjectLineID');
  SetPropertyFromNode(node,'SalesGlobalref');
  SetPropertyFromNode(node,'ShipTo');
  SetPropertyFromNode(node,'Area');
  SetPropertyFromNode(node,'SaleLineRef');
  SetPropertyFromNode(node,'HireGlobalref');
  SetPropertyFromNode(node,'TotalCostEx');
  SetPropertyFromNode(node,'TotalCostInc');
end;

Constructor TSmartOrder.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
    fLoading := false;
    fSQL := 'SELECT * FROM tblSmartOrder';
    fBusObjectTypeDescription := 'Smart Order';
    slItemCount             := TStringList.create;
    slItemCount.Duplicates  := dupIgnore;
    slItemCount.Sorted      := true;
end;

function TSmartOrder.SONotcreatedforLine(const LineID:Integer):Boolean;
begin
  with Getnewdataset('Select *  from tblsaleslines SL where ifnull(SL.SmartOrderLineID,0)  =  '+ inttostr(LineID), true) do try
    result := recordcount = 0;
  finally
    if active then close;
    free;
  end;

end;
function TSmartOrder.CreateInternalsalesOrder(CreateSOforAll: Boolean): Integer;
var
  SO:TSalesOrder;
begin
  Result:= 0;
  SO:= TSalesorder.Create(Self);
  try
    SO.Connection := Self.Connection;
    SO.Load(0);
    so.Connection.BeginTransaction;
    try
      So.New;
      SO.CustomerName := CLIENT_WORKSHOP;
      SO.IsInternalOrder := True;
      SO.Comments := 'Internal Sales order created for Smart Order #' + inttostr(ID);
      SO.PostDb;
      Lines.First;
      While Lines.EOF = False do begin
        if  (Lines.TobuildQty>0 ) and (CreateSOforAll or (SONotcreatedforLine(Lines.ID))) then begin
          SO.Lines.New;
          SO.Lines.ProductName      := Lines.ProductName;
          SO.Lines.UnitOfMeasureID  := Lines.UnitOfMeasureID;
          SO.Lines.UnitOfMeasure    := Lines.UnitOfMeasure;
          SO.Lines.QtySold          := Lines.TobuildQty;
          SO.Lines.SmartOrderLineID := Lines.ID;
          SO.Lines.PostDB;
        end;
        Lines.Next;
      end;
      if SO.Lines.Count =0 then begin
        resultStatus.AddItem(False ,rssWarning, 0 , 'No product found to create the internal salesorder.' );
        So.Connection.RollbackTransaction;
        Exit;
      end;
      if not SO.Save then begin
        So.Connection.RollbackTransaction;
        Exit;
      end;
      So.Connection.CommitTransaction;
      REsult := SO.ID;
    Except
      on E:Exception do begin
        resultStatus.AddItem(False ,rssWarning, 0 , 'Creation of Internal Sales order for Smart Order #' + inttostr(ID) +' Failed.' + NL +E.Message );
        So.Connection.RollbackTransaction;
        Exit;
      end;
    end;
  finally
    Freeandnil(SO);
  end;
end;

Procedure TSmartOrder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    if ChangeType = dcClose then Exit;

    Lines;
    TotalcostEx :=0;
    TotalcostInc:=0;
    TotalProducts :=0;
    Totalvolume:=0;
    Totalweight:=0;
end;

Function TSmartOrder.CreatePO(const fsSupplierID:String):Integer;
var
    fsFilter :String;
begin
    REsult := 0;
    fsFilter :=Lines.dataset.filter;
    try
        if fsFilter <> '' then
            Lines.dataset.filter := fsFilter + ' And SupplierID = ' +fsSupplierID
        else
            Lines.dataset.filter    := ' SupplierID = ' +fsSupplierID;

        Lines.dataset.filtered  := True;
        if Lines.count = 0 then Exit;
        if Assigned(ProgressDialog) then begin
          ProgressDialog.MaxValue:= Lines.Count;
          ProgressDialog.Execute;
        end;

        POObj.New;
        POObj.SilentMode := True;
        POObj.EnteredAt         := TimeToStr(Time());
        POObj.clientId          := StrToInt(fsSupplierID);
        POObj.SupplierName      := Lines.SupplierName;
        POObj.Area              := Self.Area;
        POObj.CustPONumber      := Lines.CustPONumber;
        POObj.OrderDate         := Date;
        POObj.salesGlobalref    := Self.SalesGlobalref;
        if Self.ShipTo <> '' then if poobj.ShipToCustomer then POObj.ShipTo            := Self.ShipTo;
        POObj.SaleLineRef       := Self.SaleLineRef;

        POObj.duedate           := Date;
        POObj.shipping          := POObj.Supplier.ShippingMethodName;
        POObj.ETADate           := POObj.OrderDate + POObj.Supplier.shiptime;
//        POObj.EmployeeName      := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        // PO is created by the same person who created SO - Dene wants it
        POObj.EmployeeId := EmployeeId;
        POObj.EnteredBy := POObj.EmployeeName;
        POObj.EmployeeId := EmployeeId;
        POObj.CreatedFromSmartOrder := Self.Id;
        //POObj.SmartOrderApprovedBy := Self.ApprovedBy;
        POObj.SmartOrderApprovedBy := Self.ApproverId;
        POObj.PostDB;
        POObj.ConvertingRepairFromSmartOrder := true;
        Lines.IterateRecords(CreatePOLines);
        // Really we create here back order...
        (*
        if POObj.TotalAmountInc > 0 then
          POObj.Approved          := TApprovalLevels.Approve(ApprovalTypePurchaseOrder, POObj.TotalAmountInc, Approved)
        else
          POObj.Approved          := TApprovalLevels.Approve(ApprovalTypePurchaseOrder, POObj.TotalEstimatedAmountInc, Approved);
        *)
        // Pre-approval - from SmartOrder, not Purchase Order
        POObj.SilentMode := True;
        if POObj.TotalAmountInc > 0 then
          POObj.Approved          := TApprovalLevels.Approve(ApprovalTypeSmartOrder, POObj.TotalAmountInc, Approved)
        else
          POObj.Approved          := TApprovalLevels.Approve(ApprovalTypeSmartOrder, POObj.TotalEstimatedAmountInc, Approved);

        POObj.Save;
        result := POObj.ID;

    Finally
        Lines.dataset.filtered :=False;
        Lines.dataset.filter :=fsFilter;
    end;
End;

Procedure TSmartOrder.CreatePOLines(Const Sender: TBusObj; var Abort: boolean);
var
    Index :Integer;
    CustField :String;
begin
    if not (Sender is TSmartOrderLine) then Exit;
    if not appenv.CompanyPrefs.ConvertConvertedSmartOrder then
      if TSmartOrderLine(Sender).Converted then exit;
    POObj.Lines.New;
    POObj.Lines.ProductId           := TSmartOrderLine(Sender).PartsID;
    POObj.Lines.Deleted := false;
    POObj.Lines.LineTaxRate         := TSmartOrderLine(Sender).LineTaxRate;
    POObj.Lines.UnitOfMeasureID     := TSmartOrderLine(Sender).UnitOfMeasureID;
    POObj.Lines.UnitOfMeasure       := TSmartOrderLine(Sender).UnitofMeasure;
    POObj.Lines.UOMMultiplier       := TSmartOrderLine(Sender).UnitofMeasureMultiplier;
    POObj.Lines.UOMQtySold          := TSmartOrderLine(Sender).ToPurchaseUOMQty;
    { moved this here in case user has changed cost on Smart Order .. changing UOMQtySold reverts cost }
    POObj.Lines.LineCost            := TSmartOrderLine(Sender).CostEx;

    POObj.Lines.UOMQtyBackOrder     := TSmartOrderLine(Sender).ToPurchaseUOMQty;
    POObj.Lines.FormulaQtySoldValue1:= TSmartOrderLine(Sender).FormulaQtyValue1;
    POObj.Lines.FormulaQtySoldValue2:= TSmartOrderLine(Sender).FormulaQtyValue2;
    POObj.Lines.FormulaQtySoldValue3:= TSmartOrderLine(Sender).FormulaQtyValue3;
    POObj.Lines.FormulaQtySoldValue4:= TSmartOrderLine(Sender).FormulaQtyValue4;
    POObj.Lines.FormulaQtySoldValue5:= TSmartOrderLine(Sender).FormulaQtyValue5;
    POObj.Lines.FormulaQtySoldValue := TSmartOrderLine(Sender).FormulaQtyValue;
    POObj.Lines.DocketNumber        := TSmartOrderLine(Sender).DocketNumber;
    POObj.Lines.Invoiced            := False;
    POObj.Lines.TotalLineAmount     := 0;
    POObj.Lines.LineClassId         := TSmartOrderLine(Sender).classID;
    POObj.Lines.CustomerJob         := TSmartOrderLine(Sender).CusJobName;
    POObj.Lines.CustomerJobID       := TSmartOrderLine(Sender).CusJobID;
    POObj.Lines.RepairId            := TSmartOrderLine(Sender).RepairId;
    POObj.Lines.CustomerEquipmentID := TSmartOrderLine(Sender).CustomerEquipmentID;
    POObj.Lines.EquipmentName       := TSmartOrderLine(Sender).EquipmentName;
    POObj.Lines.SaleLineID          := TSmartOrderLine(Sender).SaleLineID;
    POObj.Lines.ProcTreeId          := TSmartOrderLine(Sender).ProcTreeId;
    POObj.Lines.SupplierProductCode := TSmartOrderLine(Sender).SupplierProductCode;
    POObj.Lines.SupplierProductName := TSmartOrderLine(Sender).SupplierProductName;
    POObj.Lines.SupplierBarCode := TSmartOrderLine(Sender).SupplierBarCode;
    POObj.Lines.ProductDescription  := TSmartOrderLine(Sender).PODesc;
    POObj.Lines.PrintedValue        := TSmartOrderLine(Sender).PrintedValue;
    POObj.Lines.SmartOrderID        := TSmartOrderLine(Sender).SmartOrderId;
    POObj.Lines.smartOrderLineId    := TSmartOrderLine(Sender).Id;
    POObj.Lines.LineNotes           := TSmartOrderLine(Sender).LineNotes;
    POObj.Lines.GeneralNotes        := TSmartOrderLine(Sender).GeneralNotes;

    for Index := 1 to cCustomFieldsMax do begin
        CustField :='CustomField' + IntToStr(Index);
        SetPropValue(POObj.Lines,CustField,getPropValue(TSmartOrderLine(Sender),CustField));
    end;
    POObj.Lines.PostDB;
    TSmartOrderLine(Sender).Converted := true;
    TSmartOrderLine(Sender).PostDB;
    { copy attachments from Smart Order lines to PO }
    TAttachment.Clone('tblsmartorderlines',TSmartOrderLine(Sender).ID,'tblpurchaseorders', POObj.ID,POObj.Connection.Connection);
    if Assigned(ProgressDialog) then begin
      ProgressDialog.StepIt;
    end;
end;

function  TSmartOrder.Save :Boolean ;
begin
    Result := False;
    PostDB;
    Lines.PostDB;
    if not ValidateData then Exit;
    REsult := inherited Save;
    if not DeleteFlaggedlines then begin
      result:= false;
      exit;
    end;
    Dirty  := False;
end;

procedure TSmartOrder.SaveToXMLNode(const node: IXMLNode);
begin
  if fLoading then
    self.CalcOrderTotal(true);
  inherited;
  AddXMLNode(node,'EmployeeID', EmployeeID);
  AddXMLNode(node,'CreationDate', CreationDate);
  AddXMLNode(node,'SmartOrderDesc', SmartOrderDesc);
  AddXMLNode(node,'Done', Done);
  AddXMLNode(node,'Approved', Approved);
  AddXMLNode(node,'ApprovedBy', ApprovedBy);
  AddXMLNode(node,'EditedFlag', EditedFlag);
  AddXMLNode(node,'SaleOrderID', SaleOrderID);
  AddXMLNode(node,'ProjectLineID', ProjectLineID);
  AddXMLNode(node,'SalesGlobalref', SalesGlobalref);
  AddXMLNode(node,'ShipTo', ShipTo);
  AddXMLNode(node,'Area', Area);
  AddXMLNode(node,'SaleLineRef', SaleLineRef);
  AddXMLNode(node,'HireGlobalref', HireGlobalref);
  AddXMLNode(node,'TotalCostEx', TotalCostEx);
  AddXMLNode(node,'TotalCostInc', TotalCostInc);
end;

function TSmartOrder.DeleteFlaggedLines: boolean;
var
  IsFiltered: boolean;
  SavedAccessLevel: integer;
begin
    result:= true;
    Lines.Dataset.DisableControls;
    IsFiltered := Lines.Dataset.Filtered;
    Lines.Dataset.Filtered := false;
    if Lines.Count > 0 then begin
        Lines.First;
        SavedAccessLevel:= Lines.AccessManager.AccessLevel;
        try
          while not Lines.Dataset.Eof do begin
              if Lines.Deleted then begin
                if Lines.PARTSID = 0 then begin
                  Lines.AccessManager.AccessLevel:= 1;
                end
                else begin
                  if Lines.AccessManager.AccessLevel <> SavedAccessLevel then
                    Lines.AccessManager.AccessLevel := SavedAccessLevel;
                end;
                if not Lines.Delete then begin
                  result:= false;
                  break
                end;
              end
              else Lines.Dataset.Next;
          end;
        finally
          if Lines.AccessManager.AccessLevel <> SavedAccessLevel then
            Lines.AccessManager.AccessLevel := SavedAccessLevel;
        end;
        Lines.Dataset.Filtered := IsFiltered;
    end;
    Lines.Dataset.EnableControls;
end;

Procedure TSmartOrder.CalcOrderTotalCallBack(Const Sender: TBusObj; var Abort: boolean);
begin
    if not (Sender is TSmartOrderline) then exit;
    (*TotalcostEx :=TotalcostEx + TSmartOrderline(Sender).CostEx*TSmartOrderLine(Sender).ToPurchaseQty;
    TotalcostInc:=TotalcostInc + TSmartOrderline(Sender).CostInc*TSmartOrderLine(Sender).ToPurchaseQty;
    Totalvolume:=Totalvolume + TSmartOrderline(Sender).ToPurchaseUOMQty*TSmartOrderLine(Sender).volume;
    Totalweight:=Totalweight+ TSmartOrderline(Sender).ToPurchaseUOMQty*TSmartOrderLine(Sender).Weight;*)
    TotalcostEx   := TotalcostEx  + TSmartOrderline(Sender).TotalcostEx;
    Totalcostinc  := Totalcostinc + TSmartOrderline(Sender).Totalcostinc;
    Totalvolume   := Totalvolume  + TSmartOrderline(Sender).Totalvolume;
    Totalweight   := Totalweight  + TSmartOrderline(Sender).Totalweight;
    StepProgressbar('Calculating Order Total from Lines '+ inttostr(TSmartOrderline(Sender).recno)+' of ' +inttostr(TSmartOrderline(Sender).count));
end;

Procedure TSmartOrder.CalcOrderTotal(const Loading: boolean);
var
    strSQL :STring;
begin
    {these totals are calculated for the gui, not stored in the db}
    //WE need it for approvals also...
    if Iscalculating then Exit;
    if appenv.CompanyPrefs.ConvertConvertedSmartOrder  then exit;

    // if not Assigned(fRefreshFooter) then exit;

    Iscalculating := True;
    Try
        TotalcostEx   :=0;
        TotalcostInc  :=0;
         totalvolume:= 0;
         TotalWeight:= 0;
        slItemCount.Clear;
        StepProgressbar('Calculating Order Total from Lines');
        Lines.IterateRecords(CalcOrderTotalCallBack, false, true);
        TotalProducts := slItemCount.count;
        strSQL :='select count(distinct PartsId) as Partscount  ' +
                ' from tblsmartorderlines ' +
                ' where smartOrderId = ' + IntToStr(ID);
        with getNewDataset(strSQL , true) do try
            TotalProducts := fieldByname('Partscount').asInteger;
        finally
            if active then Close;
            free;
        end;
        if Assigned(fRefreshFooter) then fRefreshFooter;
        SendEvent(BusObjEvent_Change,BusObjEvent_TotalsChanged, self);
        if (not Loading) and self.Approved then
          TApprovalCheck.Approved(self);
    finally
        Iscalculating := False;
    end;
end;

Procedure TSmartOrder.MergeLines(Const Sender: TBusObj; var Abort: boolean);
var
  SaveConvertConvertedSmartOrder: boolean;
begin
    IF NOT(Sender is TSmartOrderLine) then exit;

    SaveConvertConvertedSmartOrder := appenv.CompanyPrefs.ConvertConvertedSmartOrder;
    try
      appenv.CompanyPrefs.ConvertConvertedSmartOrder := true;
      StepProgressbar('Merging Order # '+ inttostr(TSmartOrderLine(Sender).smartorderID)+' lines ' + inttostr(TSmartOrderline(Sender).recno) +' of ' +inttostr(TSmartOrderline(Sender).count));
      if TSmartOrderLine(Sender).CloneBusObj('SmartOrderID' , ID , False ) = nil then
        Abort := true
      else begin
        TSmartOrderLine(TSmartOrderLine(Sender).ObjInstanceToClone).Converted := TSmartOrderLine(Sender).converted;
        TSmartOrderLine(TSmartOrderLine(Sender).ObjInstanceToClone).PostDB;
        TSmartOrderLine(Sender).Converted := True;
        TSmartOrderLine(Sender).PostDB;
      end;
    finally
      appenv.CompanyPrefs.ConvertConvertedSmartOrder := SaveConvertConvertedSmartOrder;
    end;
end;

Procedure TSmartOrder.MergeSOs(Const Sender: TSmartOrder);
begin
    TSmartOrder(Sender).done := True;
    TSmartOrder(Sender).PostDB;
    TSmartOrder(Sender).Lines.ObjInstanceToClone := Self.Lines;
    TSmartOrder(Sender).Lines.IterateRecords(MergeLines);
    TSmartOrder(Sender).PostDB;


end;

function TSmartOrder.MergedOrders(OrderList: TStringList): integer;
var
  x: integer;
  (*qry: TERPQuery;
  sale: TSales;
  invoice: TInvoice;
  SO: TSalesOrder;
  Quote : TQuote;*)
  saleID:Integer;

begin
  result:= 0;
  if OrderList.Count = 0 then exit;
  try
    stepProgress('Check For Sales Linked to the Selected Orders');
    for x:= 0 to OrderList.Count -1 do begin
      if not UserLock.Lock(Self.BusObjectTableName ,strToInt(OrderList[x]) , 'Merging Smart Orders' ) then begin
        resultStatus.AddItem(False ,rssWarning, 0 ,  StringReplace(StringReplace(UserLock.LockMessage , 'Unable To Update Data.' , 'Merging Failed.' , [rfIgnoreCase]) , 'is accessing this record' , 'is accessing Smart Order#'+OrderList[x],[rfIgnoreCase]));
        Exit;
      end;
      SaleID := SaleIdForSmartOrder(strToInt(OrderList[x]));
      if SaleID > 0 then begin
        if not UserLock.Lock('tblsales' ,SaleId , 'Merging Smart Orders' ) then begin
          resultStatus.AddItem(False ,rssWarning, 0 ,  StringReplace(StringReplace(UserLock.LockMessage , 'Unable To Update Data.' , 'Merging Failed.' , [rfIgnoreCase]) , 'is accessing this record' , 'is accessing Smart Order#'+OrderList[x],[rfIgnoreCase]));
          Exit;
        end;
      end;
    end;

    Self.New;
    PostDB;
    Self.SmartOrderDesc:= 'Merged from '+ Orderlist.CommaText;
    for x:= 0 to OrderList.Count -1 do begin
        stepProgress('Merging Orders ' +inttostr(x+1) +' of ' + inttostr(OrderList.Count));
        MergingOrders:=  TSmartOrder.Create(nil); // owner nil
        try
          MergingOrders.Connection := self.Connection;
          MergingOrders.Load(strToInt(OrderList[x]));
          stepProgress('Merging Orders ' +inttostr(x+1) +' of ' + inttostr(OrderList.Count)+' # ' + inttostr(MergingOrders.ID)+', having '+ inttostr(MergingOrders.Lines.count) +' Products');
          MergeSOs(MergingOrders);
          SaleID := SaleIdForSmartOrder(MergingOrders.ID);
          if SaleID<> 0 then
            ExecuteSQL('update tblsales Set AutoSmartOrderRef =' + Quotedstr(Globalref) + ' where saleId =' + inttostr(saleID)+';' , true);
        finally
          MergingOrders.Free;
        end;
    end;
      done := False;
      PostDB;

      (*invoice := nil;
      SO := nil;
      sale := nil;
      qry := DbSharedObj.GetQuery(Connection.Connection);
      try
        qry.SQL.Add('select distinct tblsaleslines.SaleId from tblsmartorderlines, tblsaleslines');
        qry.SQL.Add('where tblsaleslines.SaleLineId = tblsmartorderlines.SaleLineId');
        qry.SQL.Add('and tblsmartorderlines.SmartOrderId in (' + OrderList.CommaText + ')');
        qry.Open;
        while not qry.eof do begin
          if TSales.GetSaleType(qry.FieldByName('SaleId').AsInteger) = stInvoice then begin
            if not Assigned(invoice) then begin
              invoice := TInvoice.Create(nil);
              invoice.Connection := self.Connection;
            end;
            sale := invoice;
          end else if TSales.GetSaleType(qry.FieldByName('SaleId').AsInteger) = stSalesOrder then begin
            if not Assigned(SO) then begin
              SO := TSalesOrder.Create(nil);
              SO.Connection := self.Connection;
            end;
            sale := SO;
          end else if TSales.GetSaleType(qry.FieldByName('SaleId').AsInteger) = stQuote then begin
            if not Assigned(Quote) then begin
              Quote := TQuote.Create(nil);
              Quote.Connection := self.Connection;
            end;
            sale := Quote;
          end else
            Continue;
          if not Assigned(sale) then Continue;
          sale.Load(qry.FieldByName('SaleId').AsInteger);
          if sale.Lock then begin
            sale.AutoSmartOrderRef := self.GlobalRef;
            sale.PostDb;
          end else begin
            result := 0;
            AddResult(False ,rssWarning, 0, 'Could not lock Sale ' + qry.FieldByName('SaleId').AsString + ' to update it''s Smart Order link as it is in use.');
            exit;
          end;
          qry.Next;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
        invoice.Free;
        SO.Free;
      end;*)

    result:= self.ID;
  finally
      Userlock.UnLock('Merging Smart Orders' );
  end;
end;

function  TSmartOrder.ValidateData :Boolean ;
begin

    Result := inherited ValidateData;
    if Result = False then Exit;
    PostDB;
    Lines.PostDB;

    if Self.Approved then
      result := TApprovalCheck.Approved(self);

    if Result = False then Exit;

    if SmartOrderDesc = '' then begin
        ResultStatus.AddItem(False , rssWarning , 0 , 'Smart Order description should not be blank');
        Result := False;
        Exit;
    end;
    result := True;
end;

function  TSmartOrder.CopySmartOrderToPO:String;
var
    ixOrder :Integer;
    msg :String;
    CleanConInTransaction:Boolean;
begin
    CleanConInTransaction := Connection.Connection.inTransaction;
    Try
      Result := '';
      if not Save then Exit;
      if lines.count = 0 then Exit;

      Connection.BeginTransOrNestedTrans(CleanConInTransaction);
      try
          if Assigned(fProgressDialog) then begin
              ProgressDialog.Caption := 'Creating Purchase Orders';
              ProgressDialog.MinValue := 0;
              ProgressDialog.Message:= '';
              ProgressDialog.MaxValue := 1;
              ProgressDialog.Step := 1;
              ProgressDialog.Value := 0;
          end;
          POObj               := TPurchaseOrder.Create(nil);
          POObj.connection    := Self.connection;
          POObj.Load(0);
          //POObj.SmartOrderApprovedBy := ApprovedBy;
          POObj.SmartOrderApprovedBy := ApproverId;
          slOrder             := TStringList.create;
          POObj.SilentMode    := true;
          NoSupplierStr       := '';
          slOrder.Duplicates  := dupIgnore;
          slOrder.Sorted      := true;

          if Assigned(fProgressDialog) then begin
              ProgressDialog.MinValue := 1;
              ProgressDialog.Message:= 'Getting suppliers ...';
              ProgressDialog.MaxValue := Lines.Count;
              ProgressDialog.Value := 1;
              ProgressDialog.Execute;
          end;
          Lines.IterateRecords(getsuppliers);

          for ixOrder := 0 to slOrder.Count - 1 do begin
              if Assigned(ProgressDialog) then begin
                  ProgressDialog.CloseDialog;
                  ProgressDialog.Message:= 'Creating Order ' +
                    IntToStr(ixOrder + 1) + ' of ' + IntToStr(slOrder.Count);
                  ProgressDialog.MaxValue:= 2;
                  ProgressDialog.Value:= 1;
              end;
              if result <> '' then result := result +',' ;
              result := result + IntToStr(CreatePO(slOrder[ixOrder]));
          end;
          if slOrder.Count > 0 then
            Done := True;
          PostDB;
          if NoSupplierStr <> '' then begin
              msg := 'No supplier specified for the following products:' + chr(13) + NoSupplierStr;
            ResultStatus.Additem(True, rssInfo ,0 ,msg );
          end;
          Connection.CommitTransOrNestedTrans(CleanConInTransaction);
          EmailPo; //@@@
          Dirty := False;
          if Assigned(ProgressDialog) then
            ProgressDialog.CloseDialog;
      except
          on E:Exception do begin
              ResultStatus.Additem(True, rssInfo ,0 ,'Conversion of Smart Order to Purchase Order has failed.' + chr(13) + E.Message );
              Connection.RollbackTransOrNestedTrans(CleanConInTransaction);
          End;
      end;
    Finally
      if not CleanConInTransaction then
        Connection.CommitTransaction;
    End;
end;

procedure TSmartOrder.getsuppliers(Const Sender: TBusObj; var Abort: boolean);
begin
    if not (Sender is TSmartOrderLine) then exit;
    if not appenv.CompanyPrefs.ConvertConvertedSmartOrder then
      if TSmartOrderLine(sender).Converted then Exit;

    if TSmartOrderLine(sender).SupplierID = 0 then begin
        if NoSupplierStr <> '' then NoSupplierStr := NoSupplierStr + chr(13);
        NoSupplierStr := NoSupplierStr +TSmartOrderLine(sender).PartsName;
    end else
    slOrder.Add(IntToStr(TSmartOrderLine(sender).SupplierID));
    if Assigned(ProgressDialog) then
      ProgressDialog.StepIt;
end;
function TSmartOrder.getToDos: TToDo;
begin
  REsult := TToDo(getcontainercomponent(TToDo ,'LinkTo =' + quotedstr('Smart Order') +' and LinkToID = ' + IntToStr(Self.ID)));
end;

function TSmartOrder.GetUseDefaultSupplierForAllLines: boolean;
begin
  result := GetBooleanField('UseDefaultSupplierForAllLines');
end;

function TSmartOrder.HasanyTobuild(const SelectedLineIDs:String): Boolean;
var
  s:String;
begin
  PostDB;
  Lines.PostDb;
  s:='Select * from tblsmartOrderlines where ifnull(TobuildQty,0)<> 0 and SmartOrderID ='  + inttostr(ID) ;
  if SelectedLineIDs <> '' then s:= s +' and  (' +SelectedLineIDs+')';
  with Getnewdataset(s, true) do try
    result := recordcount >0;
  finally
    if active then close;
    free;
  end;
end;

procedure TSmartOrder.InitializeNewObject;
begin
    inherited;
end;
function TSmartOrder.IsAllBomCreated(const SelectedLineIDs:String): Boolean;
var
  s:String;
begin
  PostDB;
  Lines.PostDb;
  s:='Select SOL.* '+
      ' from tblsmartOrderlines SOL  '+
      ' Left join tblsaleslines SL on SOL.SmartOrderLinesID = ifnull(SL.SmartOrderLineID,0)   '+
      ' where ifnull(TobuildQty,0)<> 0 and SmartOrderID ='  + inttostr(ID) +' and ifnull(SL.saleLineid,0) =0';
  if SelectedLineIDs <> '' then s:= s +' and  (' +SelectedLineIDs+')';
  with Getnewdataset(s, true) do try
    result := recordcount = 0;
  finally
    if active then close;
    free;
  end;

end;

Function  TSmartOrder.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited  DoAfterInsert(Sender);
    if not result then exit;
    CreationDate    := now;
    EmployeeId      := AppEnv.Employee.EmployeeID;
    UseDefaultSupplierForAllLines := AppEnv.CompanyPrefs.DefaultSupplierallLinesSmartOrder;
end;

procedure TSmartOrder.DoFieldOnChange(Sender: TField);
begin
  inherited;
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
{---} if Sysutils.SameText(Sender.FieldName, 'Approved') then begin
        TApprovalCheck.Approved(self, Sender);
        if Approved then Todos.iteraterecords(SOApprovedCallback);
        SendEvent(BusObjEvent_Change,BusObjEvent_Approved, self);
{---} end else if Sysutils.SameText(Sender.fieldName, 'ApproverID') then begin
        SendEvent(BusObjEvent_Change, BusobjEventVal_ApproverID, self);
{---} end;
end;
procedure TSmartOrder.SOApprovedCallback    (Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is TToDo then begin
    if self.Approved and TToDo(Sender).IsSmartOrderApprovalRequest then begin
      TToDo(Sender).Completed := True;
      TToDo(Sender).PostDB;
    end;
  end;
end;
procedure TSmartOrder.EMailPO;//(const IDs: string);
var
  msgTo : string;
  s1, s2 : string;
begin
  // Emails
  if not AppEnv.CompanyPrefs.EnablePOCreateEmail then
    exit;

  msgTo := POObj.ContactEmail;
  if msgTo = '' then
    msgTo := POObj.Supplier.Email;
  s1 := TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POCreateEmailSubject, POObj.PopulateMessageSubstituteList);
  s2 := TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POCreateEmailText, POObj.PopulateMessageSubstituteList);
  TCorrespondenceGui.EmailSupplier(msgTo, s1, s2, POObj.Supplier.ID);
end;

class function TSmartOrder.LockLinkedSOs(const SaleLineID: Integer;const UserLock :TUserLock;const LockGroupName,ProductName :STring; var Msg:STring): Boolean;
var
  strSQL:String;
begin
  Msg := '';
  Result := TRue;
  strSQL:= 'SELECT  ' +  GetIDField + '     FROM ' + TSmartOrderLine.GetBusObjectTablename+
            '  WHERE SaleLineID = ' + IntToStr(SaleLineID);
  With TempMyQuery do try
    SQL.add(strSQL);
    Open;
    if recordcount = 0 then exit;
    First;
    While Eof = False do begin
      if UserLock.Lock(GetBusObjectTablename , Fieldbyname(GetIDField).asInteger, LockGroupName)= False then begin
          MSg := ReplaceStr(userlock.LockMessage, 'Unable to update data' ,
                        'Deleted Product ' + ProductName +' is Linked to SmartOrder#' +IntToStr(Fieldbyname(GetIDField).asInteger) ) +chr(13)+chr(13)+
                        'Unable to delete the link.';
          Result := False;
          Exit;
      end;
      Next;
    end;
  finally
      if Active then close;
      Free;
  end;
end;

class Function TSmartOrder.DeleteLinkToSO(const SaleLineID: Integer):String;
var
  strSQL:String;
begin
  RESULT := '';
  strSQL:= 'SELECT  ' + TSmartOrderLine.GetIDField + '     FROM ' + TSmartOrderLine.GetBusObjectTablename+
            '  WHERE SaleLineID = ' + IntToStr(SaleLineID);
  With TempMyQuery do try
    SQL.add(strSQL);
    Open;
    if recordcount = 0 then exit;
    First;
    strSQL:='';
    While Eof = False do begin
      if strSQL<> '' then strSQL:= strSQL+',';
      strSQL := strSQL + IntToStr(Fieldbyname(TSmartOrderLine.GetIDField).asInteger);
      next;
    end;
    if strSQL <> '' then
        result := 'update ' + TSmartOrderLine.GetBusObjectTablename +
                ' set  SaleLineID = 0 , ProctreeId =0, PODesc = concat(PODESC , " :Sales line deleted")  ' +
                ' where '  + TSmartOrderLine.GetIDField +' in (' + strSQL+')';
  finally
      if Active then close;
      Free;
  end;
end;
function TSmartOrder.getSalesGlobalref: String;
begin
  Result := GetStringField('SalesGlobalref');
end;
function TSmartOrder.getShipTo: String;
begin
  Result := GetStringField('ShipTo');
end;
function TSmartOrder.getApprovedBy: integer;
begin
  Result := GetIntegerField('ApprovedBy');
end;

function TSmartOrder.GetApproverID: integer;
begin
  result := GetIntegerField('ApproverID');
end;

function TSmartOrder.getArea: String;
begin
  Result := GetStringField('Area');
end;

procedure TSmartOrder.SetSalesGlobalref(const Value: String);
begin
  SetStringfield('SalesGlobalref' , Value);
end;
procedure TSmartOrder.SetShipTo(const Value: String);
begin
  SetStringfield('ShipTo' , Value);
end;
procedure TSmartOrder.SetArea(const Value: String);
begin
  SetStringfield('Area' , Value);
end;
function TSmartOrder.getRFQs: TSmartOrderRFQ;
begin
  REsult := TSmartOrderRFQ(getcontainercomponent(TSmartOrderRFQ ,'SmartOrderId = ' + IntToStr(Self.ID)));
end;

function TSmartOrder.getSaleLineRef: String;
begin
  Result := GetStringField('SaleLineRef');
end;
function TSmartOrder.getHireGlobalref: String;
begin
  Result := GetStringField('HireGlobalref');
end;

procedure TSmartOrder.SetSaleLineRef(const Value: String);
begin
  SetStringfield('SaleLineRef' , Value);
end;
procedure TSmartOrder.SetHireGlobalref(const Value: String);
begin
  SetStringfield('HireGlobalref' , Value);
end;

procedure TSmartOrder.setHideconvertedLines(const Value: Boolean);
var
  fsfilter:String;
begin
  fbHideconvertedLines := Value;
  if not datasetAssigned then exit;
  if not lines.DatasetAssigned then exit;
  fsfilter := lines.dataset.Filter;
  if Value then begin
      if fsfilter <> '' then fsfilter := fsfilter + ' and ';
      fsfilter := fsfilter + ' converted =' +quotedStr('F');
  end else begin
    fsfilter := Trim(StringReplace(fsfilter , ' converted =' +quotedStr('F') , '' , [rfIgnoreCase]));
    if copy(fsFilter , char_length(fsFilter)-2 , 3) = 'and' then fsFilter := copy(fsFilter, 1, char_length(fsFilter)-3);
  end;
  Lines.Dataset.filter := fsFilter ;
  Lines.Dataset.filtered := fsFilter <> '';
end;

function TSmartOrder.isAllconverted: Boolean;
begin
  With GetNewDataset('Select * from ' +Lines.BusObjectTableName +' where SmartOrderID = ' +IntToStr(ID)+' and Converted = "F"' , true) do try
    Result := recordcount = 0;
  finally
      if active then close;
      Free;
  end;
end;

function TSmartOrder.IsanyBomCreated(const SelectedLineIDs:String): Boolean;
var
  s:String;
begin
  PostDB;
  Lines.PostDb;
  s:='Select SOL.* '+
                      ' from tblsmartOrderlines SOL  '+
                      ' inner join tblsaleslines SL on SOL.SmartOrderLinesID = ifnull(SL.SmartOrderLineID,0)   '+
                      ' where ifnull(TobuildQty,0)<> 0 and SmartOrderID ='  + inttostr(ID);
  if SelectedLineIDs <> '' then s:= s +' and  (' +SelectedLineIDs+')';
  with Getnewdataset(s, true) do try
    result := recordcount > 0;
  finally
    if active then close;
    free;
  end;
end;

function TSmartOrder.IsAnyconverted: Boolean;
begin
  With GetNewDataset('Select * from ' +Lines.BusObjectTableName +' where SmartOrderID = ' +IntToStr(ID)+' and Converted = "T"' , true) do try
    Result := recordcount <> 0;
  finally
      if active then close;
      Free;
  end;
end;

{ TSmartOrderLine }

Function TSmartOrderLine.GetSmartOrderID          : Integer; begin    Result := getIntegerfield('SmartOrderID');          end;
Function TSmartOrderLine.GetPARTSID	              : Integer; begin    Result := getIntegerfield('PARTSID');               end;
Function TSmartOrderLine.GetSupplierID	          : Integer; begin    Result := getIntegerfield('SupplierID');            end;
Function TSmartOrderLine.GetClassID	              : Integer; begin    Result := getIntegerfield('ClassID');               end;
Function TSmartOrderLine.GetGroupID	              : Integer; begin    Result := getIntegerfield('GroupID');               end;
Function TSmartOrderLine.GetGroupLineID	          : Integer; begin    Result := getIntegerfield('GroupLineID');           end;
Function TSmartOrderLine.GetUnitOfMeasureID       : Integer; begin    Result := getIntegerfield('UnitOfMeasureID');       end;
function TSmartOrderLine.getProductClass: TProductclass;
begin
  Result := TProductclass(getContainerComponent(TProductclass, 'ProductID = ' + inttostr(Self.ProductId) + ' and ClassID = ' + inttostr(ClassId)));
end;

function TSmartOrderLine.getunitVolume: double;
begin
  result  :=volume;
  if result <> 0 then
         if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =0 then
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =1 then result := result / 10
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =2 then result := result / 100
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =3 then result := result / 1000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =4 then result := result / 10000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =5 then result := result / 100000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =6 then result := result / 1000000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =7 then result := result / 10000000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =8 then result := result / 100000000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =9 then result := result / 1000000000;
end;

Function TSmartOrderLine.GetToPurchaseUOMQty      : Double ; begin    Result := Getfloatfield('UnitofMeasureQty');        end;
function TSmartOrderLine.GetProductID             : Integer; begin    result := PartsID;                                  end;
function TSmartOrderLine.GetProductName           : string ; begin    result := PartsName;                                end;
Function TSmartOrderLine.GetToPurchaseQty         : Double ; begin    Result := Getfloatfield('Qty');                     end;
Function TSmartOrderLine.GetTotalQty              : Double ; begin    Result := Getfloatfield('TotalQty');                end;
Function TSmartOrderLine.GetTotalUOMqty           : Double ; begin    Result := Getfloatfield('TotalUOMqty');             end;
function TSmartOrderLine.getTotalvolume: double;
begin
  result  :=ToPurchaseUOMQty*volume;
  if result <> 0 then
         if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =0 then
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =1 then result := result / 10
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =2 then result := result / 100
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =3 then result := result / 1000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =4 then result := result / 10000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =5 then result := result / 100000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =6 then result := result / 1000000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =7 then result := result / 10000000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =8 then result := result / 100000000
    else if Appenv.CompanyPrefs.TotalvolumeUOMInsmartOrder =9 then result := result / 1000000000;
end;
function TSmartOrderLine.getTotalWeight : double; begin result  :=  ToPurchaseUOMQty  * Weight  ; end;
function TSmartOrderLine.getTotalcostEx : double; begin result  :=  ToPurchaseQty     * CostEx  ; end;
function TSmartOrderLine.getTotalcostInc: double; begin result  :=  ToPurchaseQty     * Costinc ; end;
Function TSmartOrderLine.GetTobuildQty            : Double ; begin    Result := Getfloatfield('TobuildQty');              end;
Function TSmartOrderLine.GetToBuildUOMQty         : Double ; begin    Result := Getfloatfield('ToBuildUOMQty');           end;
Function TSmartOrderLine.GetLinePrice	            : Double ; begin    Result := Getfloatfield('LinePrice');               end;
Function TSmartOrderLine.GetLineTaxRate           : Double ; begin    Result := Getfloatfield('LineTaxRate');             end;
Function TSmartOrderLine.GetUOMMultiplier         : Double ; begin    Result := Getfloatfield('UnitofMeasureMultiplier'); end;
function TSmartOrderLine.GetUserEnteredCost: boolean;
begin
  result := Vars.Values.ByName['UserEnteredCost'].AsBoolean;
end;

Function TSmartOrderLine.GetCostEx	              : Double ; begin    Result := Getfloatfield('CostEx');                  end;
Function TSmartOrderLine.GetCostInc	              : Double ; begin    Result := Getfloatfield('CostInc');                 end;
Function TSmartOrderLine.GetSupplierName          : String ; begin    Result := getStringField('SupplierName');           end;
Function TSmartOrderLine.GetSupplierPrintName     : String ; begin    Result := getStringField('SupplierPrintName');      end;
Function TSmartOrderLine.GetClassName	            : String ; begin    Result := getStringField('ClassName');              end;
Function TSmartOrderLine.GetCusJobName	          : String ; begin    Result := getStringField('CusJobName');             end;
Function TSmartOrderLine.GetCusJobPrintName       : String ; begin    Result := getStringField('CusJobPrintName');        end;
Function TSmartOrderLine.GetCusJobID	            : Integer; begin    Result := getIntegerfield('CusJobID');              end;
Function TSmartOrderLine.GetPODesc	              : String ; begin    Result := getStringField('PODesc');                 end;
Function TSmartOrderLine.GetSupplierContact       : String ; begin    Result := getStringField('SupplierContact');        end;
Function TSmartOrderLine.GetUnitOfMeasure         : String ; begin    Result := getStringField('UnitofMeasure');          end;
Function TSmartOrderLine.GetCustPONumber          : String ; begin    Result := getStringField('CustPONumber');           end;
Function TSmartOrderLine.GetPARTSNAME	            : String ; begin    Result := getStringField('PARTSNAME');              end;
Function TSmartOrderLine.GetSearchFilter          : String ; begin    Result := getStringField('SearchFilter');           end;
Function TSmartOrderLine.GetFilterCopy            : String ; begin    Result := getStringField('FilterCopy');             end;
Function TSmartOrderLine.GetDocketNumber          : String ; begin    Result := getStringField('DocketNumber');           end;
Function TSmartOrderLine.GetCustomField1          : String ; begin    Result := getStringField('CustomField1');           end;
Function TSmartOrderLine.GetCustomField2          : String ; begin    Result := getStringField('CustomField2');           end;
Function TSmartOrderLine.GetCustomField3          : String ; begin    Result := getStringField('CustomField3');           end;
Function TSmartOrderLine.GetCustomField4          : String ; begin    Result := getStringField('CustomField4');           end;
Function TSmartOrderLine.GetCustomField5          : String ; begin    Result := getStringField('CustomField5');           end;
Function TSmartOrderLine.GetCustomField6          : String ; begin    Result := getStringField('CustomField6');           end;
Function TSmartOrderLine.GetCustomField7          : String ; begin    Result := getStringField('CustomField7');           end;
Function TSmartOrderLine.GetCustomField8          : String ; begin    Result := getStringField('CustomField8');           end;
Function TSmartOrderLine.GetCustomField9          : String ; begin    Result := getStringField('CustomField9');           end;
Function TSmartOrderLine.GetCustomField10         : String ; begin    Result := getStringField('CustomField10');          end;
function TSmartOrderLine.GetLineNotes             : String ; begin    result:=  GetStringField('LineNotes');              end;
Function TSmartOrderLine.GetEditedFlag	          : Boolean; begin	  REsult := getBooleanField('EditedFlag');            end;
function TSmartOrderLine.GetGeneralNotes          : string ; begin    Result := GetStringField('GeneralNotes');           end;
Function TSmartOrderLine.GetGroupheader	          : Boolean; begin	  REsult := getBooleanField('Groupheader');           end;
Function TSmartOrderLine.GetMultiBuy  	          : Boolean; begin	  REsult := getBooleanField('MultiBuy');              end;
Function TSmartOrderLine.GetConverted	            : Boolean; begin	  REsult := getBooleanField('Converted');             end;
Function TSmartOrderLine.GetDeleted	              : Boolean; begin	  REsult := getBooleanField('Deleted');               end;
Function TSmartOrderLine.GetSaleLineID            : Integer; begin    Result := getIntegerfield('SaleLineID');            end;
Function TSmartOrderLine.GetHirePartsSaleID       : Integer; begin    Result := getIntegerfield('HirePartsSaleID');       end;
function TSmartOrderLine.getCustomerEquipmentID   : Integer; begin    REsult := GetIntegerField('CustomerEquipmentID');   end;
function TSmartOrderLine.getEquipmentName         : String;  begin    Result := GetStringField('EquipmentName');          end;
function TSmartOrderLine.getRepairId              : Integer; begin    REsult := GetIntegerField('RepairId');              end;
function TSmartOrderLine.getRepairPartsID         : Integer; begin    REsult := GetIntegerField('RepairPartsID');         end;
function TSmartOrderLine.getHeight                : Double;  begin    REsult := Getfloatfield('Height');                  end;
function TSmartOrderLine.getLength                : Double;  begin    REsult := Getfloatfield('Length');                  end;
function TSmartOrderLine.getvolume                : Double;  begin    REsult := Getfloatfield('volume');                  end;
function TSmartOrderLine.getWeight                : Double;  begin    REsult := Getfloatfield('Weight');                  end;
function TSmartOrderLine.getWidth                 : Double;  begin    REsult := Getfloatfield('Width');                   end;
function TSmartOrderLine.getProcTreeId            : Integer; begin    REsult := GetIntegerField('ProcTreeId');            end;
function TSmartOrderLine.GetSupplierProductName   : string;  begin    result:= GetStringField('SupplierProductName');     end;
function TSmartOrderLine.GetSupplierBarCode   : string;  begin    result:= GetStringField('SupplierBarCode');     end;
function TSmartOrderLine.GetSupplierProductCode   : string;  begin    result:= GetStringField('SupplierProductCode');     end;
function TSmartOrderLine.getWastagePercentage     : Double;  begin    REsult := getfloatfield('WastagePercentage' );      end;
function TSmartOrderLine.getPrintedValue          : Double;  begin    REsult := getfloatfield('PrintedValue' );           end;
procedure TSmartOrderLine.setCustomerEquipmentID  (const Value: Integer);begin  SetIntegerField('CustomerEquipmentID'   , Value);end;
procedure TSmartOrderLine.SetEquipmentName        (const Value: String );begin  SetStringfield('EquipmentName'          , Value);end;
procedure TSmartOrderLine.setRepairId             (const Value: Integer);begin  SetIntegerField('RepairId'              , Value);end;
procedure TSmartOrderLine.setRepairPartsID        (const Value: Integer);begin  SetIntegerField('RepairPartsID'         , Value);end;
Procedure TSmartOrderLine.SetSmartOrderID         (const Value :Integer);begin  SetIntegerField('SmartOrderID'          , Value);end;
Procedure TSmartOrderLine.SetPARTSID              (const Value :Integer);begin  SetIntegerField('PARTSID'               , Value);end;
Procedure TSmartOrderLine.SetSupplierID           (const Value :Integer);begin  SetIntegerField('SupplierID'            , Value);end;
Procedure TSmartOrderLine.setClassID              (const Value :Integer);begin  SetIntegerField('ClassID'               , Value);end;
Procedure TSmartOrderLine.SetGroupID              (const Value :Integer);begin  SetIntegerField('GroupID'               , Value);end;
Procedure TSmartOrderLine.SetGroupLineID          (const Value :Integer);begin  SetIntegerField('GroupLineID'           , Value);end;
Procedure TSmartOrderLine.SetUnitOfMeasureID      (const Value :Integer);begin  SetIntegerField('UnitOfMeasureID'       , Value);end;
Procedure TSmartOrderLine.SetToPurchaseUOMQty     (const Value :Double );begin  SetFloatField('UnitofMeasureQty'        , Value);end;
Procedure TSmartOrderLine.SetUOMMultiplier        (const Value :Double );begin  SetFloatField('UnitofMeasureMultiplier' , Value);end;
procedure TSmartOrderLine.SetUserEnteredCost      (const Value: boolean);begin  Vars.Values.ByName['UserEnteredCost'].AsBoolean := Value;end;
Procedure TSmartOrderLine.SetLinePrice            (const Value :Double );begin  SetFloatField('LinePrice'               , Value);end;
Procedure TSmartOrderLine.SetToPurchaseQty        (const Value :Double );begin  SetFloatField('Qty'                     , Value);end;
Procedure TSmartOrderLine.SetTotalQty             (const Value :Double );begin  SetFloatField('TotalQty'                , Value);end;
Procedure TSmartOrderLine.SetTotalUOMqty          (const Value :Double );begin  SetFloatField('TotalUOMqty'             , Value);end;
Procedure TSmartOrderLine.SetTobuildQty           (const Value :Double );begin  SetFloatField('TobuildQty'              , Value);end;
Procedure TSmartOrderLine.SetToBuildUOMQty        (const Value :Double );begin  SetFloatField('ToBuildUOMQty'           , Value);end;
Procedure TSmartOrderLine.SetLineTaxRate          (const Value :Double );begin  SetFloatField('LineTaxRate'             , Value);end;
Procedure TSmartOrderLine.SetCostEx               (const Value :Double );begin  SetFloatField('CostEx'                  , Value);end;
Procedure TSmartOrderLine.SetCostInc              (const Value :Double );begin  SetFloatField('CostInc'                 , Value);end;
Procedure TSmartOrderLine.SetSupplierName         (const Value :String );begin  SetStringField('SupplierName'           , Value);end;
Procedure TSmartOrderLine.SetSupplierPrintName    (const Value :String );begin  SetStringField('SupplierPrintName'      , Value);end;
Procedure TSmartOrderLine.SetClassName            (const Value :String );begin  SetStringField('ClassName'              , Value);end;
Procedure TSmartOrderLine.SetCusJobName           (const Value :String );begin  SetStringField('CusJobName'             , Value);end;
Procedure TSmartOrderLine.SetCusJobPrintName      (const Value :String );begin  SetStringField('CusJobPrintName'        , Value);end;
Procedure TSmartOrderLine.SetSupplierContact      (const Value :String );begin  SetStringField('SupplierContact'        , Value);end;
Procedure TSmartOrderLine.SetUnitOfMeasure        (const Value :String );begin  SetStringField('UnitofMeasure'          , Value);end;
Procedure TSmartOrderLine.SetCusJobID             (const Value :Integer);begin  SetIntegerField('CusJobID'              , Value);end;
Procedure TSmartOrderLine.SetPODesc               (const Value :String );begin  SetStringField('PODesc'                 , Value);end;
Procedure TSmartOrderLine.SetCustPONumber         (const Value :String );begin  SetStringField('CustPONumber'           , Value);end;
Procedure TSmartOrderLine.SetPARTSNAME            (const Value :String );begin  SetStringField('PARTSNAME'              , Value);end;
Procedure TSmartOrderLine.SetSearchFilter         (const Value :String );begin  SetStringField('SearchFilter'           , Value);end;
Procedure TSmartOrderLine.SetFilterCopy           (const Value :String );begin  SetStringField('FilterCopy'             , Value);end;
Procedure TSmartOrderLine.SetDocketNumber         (const Value :String );begin  SetStringField('DocketNumber'           , Value);end;
Procedure TSmartOrderLine.SetCustomField1         (const Value :String );begin  SetStringField('CustomField1'           , Value);end;
Procedure TSmartOrderLine.SetCustomField2         (const Value :String );begin  SetStringField('CustomField2'           , Value);end;
Procedure TSmartOrderLine.SetCustomField3         (const Value :String );begin  SetStringField('CustomField3'           , Value);end;
Procedure TSmartOrderLine.SetCustomField4         (const Value :String );begin  SetStringField('CustomField4'           , Value);end;
Procedure TSmartOrderLine.SetCustomField5         (const Value :String );begin  SetStringField('CustomField5'           , Value);end;
Procedure TSmartOrderLine.SetCustomField6         (const Value :String );begin  SetStringField('CustomField6'           , Value);end;
Procedure TSmartOrderLine.SetCustomField7         (const Value :String );begin  SetStringField('CustomField7'           , Value);end;
Procedure TSmartOrderLine.SetCustomField8         (const Value :String );begin  SetStringField('CustomField8'           , Value);end;
Procedure TSmartOrderLine.SetCustomField9         (const Value :String );begin  SetStringField('CustomField9'           , Value);end;
Procedure TSmartOrderLine.SetCustomField10        (const Value :String );begin  SetStringField('CustomField10'          , Value);end;
procedure TSmartOrderLine.SetLineNotes            (const Value: String );begin  SetStringField('LineNotes'              , Value);end;
Procedure TSmartOrderLine.SetEditedFlag           (const Value :Boolean);begin  SetBooleanField('EditedFlag'            , Value);end;
procedure TSmartOrderLine.SetGeneralNotes         (const Value :string );begin  SetStringField('GeneralNotes'           , Value);end;
Procedure TSmartOrderLine.SetGroupheader          (const Value :Boolean);begin  SetBooleanField('Groupheader'           , Value);end;
Procedure TSmartOrderLine.SetMultiBuy            (const Value :Boolean);begin  SetBooleanField('MultiBuy'               , Value);end;
Procedure TSmartOrderLine.SetConverted            (const Value :Boolean);begin  SetBooleanField('Converted'             , Value);end;
Procedure TSmartOrderLine.SetDeleted              (const Value :Boolean);begin  SetBooleanField('Deleted'               , Value);end;
Procedure TSmartOrderLine.SetSaleLineID           (const Value :Integer);begin  SetIntegerField('SaleLineID'            , Value);end;
Procedure TSmartOrderLine.SetHirePartsSaleID      (const Value :Integer);begin  SetIntegerField('HirePartsSaleID'       , Value);end;
procedure TSmartOrderLine.setProcTreeId           (const Value :Integer);begin  SetIntegerField('ProcTreeId'            , Value);end;
procedure TSmartOrderLine.SetSupplierProductCode  (const Value :string );begin  SetStringField('SupplierProductCode'    , Value);end;
procedure TSmartOrderLine.SetSupplierProductName  (const Value :string );begin  SetStringField('SupplierProductName'    , Value);end;
procedure TSmartOrderLine.SetSupplierBarCode  (const Value :string );begin  SetStringField('SupplierBarCode'    , Value);end;
procedure TSmartOrderLine.setPrintedValue         (const Value :Double );begin  SetFloatfield('PrintedValue'            , Value);end;
procedure TSmartOrderLine.setWastagePercentage    (const Value :Double );begin  SetFloatfield('WastagePercentage'       , Value);end;
procedure TSmartOrderLine.setToPurchaseQtyexWastagePercentage(const Value: Double);
begin
  if ProductClass.WastagePercentage <=0 then ToPurchaseQty := Value
  else begin
    ToPurchaseQty := Value + Value * ProductClass.WastagePercentage/100;
    //AddDesc('. Qty Includes Wastage '+ floattostrf(WastagePercentage , ffGeneral, 15,2)+'%');
  end;
end;
procedure TSmartOrderLine.setToPurchaseUOMQtyexWastagePercentage(const Value: Double);
begin
  if ProductClass.WastagePercentage <=0 then ToPurchaseUOMQty := Value
  else begin
    ToPurchaseUOMQty := Value + Value * ProductClass.WastagePercentage/100;
    //AddDesc('. Qty Includes Wastage '+ floattostrf(WastagePercentage , ffGeneral, 15,2)+'%');
  end;
end;
(*Procedure TSmartOrderLine.AddDesc(Const Value:string);
begin
  if pos(Value , PODesc) = 0 then PODesc:= PODesc +Value;
end;*)
Function  TSmartOrderLine.GetSQL                 : String;
begin
  Result := '';
  if fSQL = '' then fSQL := 'SELECT * FROM tblSmartOrderlines ';
  if fSQL <> '' then Result := fSQL;
  if fSQLSelect <> '' then Result := Result + ' WHERE ' + fSQLSelect;

end;
function TSmartOrderLine.getSupplier: TSupplier;
begin
  REsult := TSupplier(getcontainercomponent(TSupplier ,'ClientId = ' + IntToStr(Self.SupplierId)));
end;

Function  TSmartOrderLine.GetId                  : Integer;
begin
    Result := GetIntegerField(IDFieldName);
end;

class Function  TSmartOrderLine.GetIDField: String;
begin
    Result := 'SmartOrderLinesID';
end;
Function TSmartOrderLine.CalcBaseLineAmount: Double;
var
  SuppProdCode, SuppProdName,suppbarcode: string;
  fdPrintedValue :Double;
begin
  result:=  0;
  if (SupplierID = 0) or ( UnitOfMeasureID=0) then exit;

  if (assigned(Self.Owner)) and (Self.owner is TSmartOrder) then begin
    result:= Product.ExtraBuyPrice.GetCostForUOM(SupplierID, UnitOfMeasureID, SuppProdCode, SuppProdName,suppbarcode, fdPrintedValue);
    if result = 0 then begin
      Result := Product.GetCostForQty(ToPurchaseQty);
      if SuppProdCode <> '' then self.SupplierProductCode:= SuppProdCode;
      if SuppProdName <> '' then self.SupplierProductName:= SuppProdName;
      if suppbarcode <> '' then self.SupplierBarCode:= suppbarcode;
    end else begin
      self.SupplierProductCode:= SuppProdCode;
      self.SupplierProductName:= SuppProdName;
      self.SupplierBarCode:= suppbarcode;
      Self.PrintedValue := fdPrintedValue;
    end;
    if self.SupplierBarCode = '' then self.SupplierBarCode := Product.BARCODE;
  end;
end;

function TSmartOrderLine.GetActive: Boolean;begin  REsult := not(Deleted);end;

procedure TSmartOrderLine.getCalcQtYformulaValue(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := FormulaQtyValue1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := FormulaQtyValue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := FormulaQtyValue3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := FormulaQtyValue4 ;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := FormulaQtyValue5 ;FieldFound:= True; end;

end;
procedure TSmartOrderLine.CalcQtyFromformula;
var
  Qty :Double;
  ErrMsg:string;
begin
  PostDB;
  if ProductId =0 then exit;
  postDB;
  if QtyCalcFormulaDetails.PartCalcformula = '' then exit;
  fbCalcQtyFromformula:= True;
  try
    Qty :=ProductQtyParseValue(Self , getCalcQtYformulaValue ,ErrMsg , Self , formulaQtyvalue);
    ToPurchaseUOMQty := Qty;
    DoFieldOnChange(dataset.Findfield('UnitofMeasureQty'));

  finally
    fbCalcQtyFromformula:= False;
  end;
end;


class function TSmartOrderLine.GetBusObjectTablename: string;
begin
  Result := 'tblSmartOrderlines';
end;
function TSmartOrderLine.IsBOMProduct:Boolean;
var
  Qry:TERPQuery;
begin
  result :=  False;
  if ProductID =0 then exit;
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry do begin
      SQL.Text := 'select  PT.ProcTreeId '+
                  ' from tblparts P inner join tblproctree PT on P.partsId = PT.MasterId and PT.MasterType = "mtProduct" and ifnull(PT.ParentId,0)=0'+
                  ' where P.partsId = ' + inttostr(ProductID);
      open;
      result := fieldbyname('ProcTreeId').AsInteger >0;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;
procedure TSmartOrderLine.CalcQtys(const QtyType : TQtyChange);
begin
  if fbCalcQtys then exit;
  fbCalcQtys := True;
  try
         if QtyType = qcPurchase    then ToPurchaseUOMQty := Divzer(ToPurchaseQty , UnitofMeasureMultiplier)
    else if QtyType = qcTotal       then TotalUOMQty      := Divzer(TotalQty      , UnitofMeasureMultiplier)
    else if QtyType = qcToBuild     then ToBuildUOMQty    := Divzer(ToBuildQty    , UnitofMeasureMultiplier)
    else if QtyType = qcPurchaseUOM then ToPurchaseQty    := ToPurchaseUOMQty *  UnitofMeasureMultiplier
    else if QtyType = qcTotalUOM    then TotalQty         := TotalUOMQty      *  UnitofMeasureMultiplier
    else if QtyType = qcToBuildUOM  then ToBuildQty       := ToBuildUOMQty    *  UnitofMeasureMultiplier;
    //WastagePercentage := 0;
    SendEvent(BusObjEvent_Change,BusObjEvent_QtyChanged, self);
    if not(IsBOMProduct) and ((ToBuildQty<>0) or (ToBuildUOMQty<>0)) then begin
        ToBuildQty:= 0;
        ToBuildUOMQty := 0;
        SendEvent(BusObjEvent_Warning,BusobjEventVal_BOMqtyonNonBOMProduct, self);
    end;

    if (QtyType = qcPurchase) or (QtyType = qcPurchaseUOM)     then begin
      if  TotalQty =0 then begin
        TotalQty      :=  ToPurchaseQty;
        TotalUOMQty   :=  ToPurchaseUOMQty;
        ToBuildQty    := 0;
        ToBuildUOMQty := 0;
      end else begin
        TotalQty    :=  ToPurchaseQty    + ToBuildQty;
        TotalUOMQty :=  ToPurchaseUOMQty + ToBuildUOMQty;
      end;
      CalcPrice;
      if (Assigned(Self.Owner)) and (Self.Owner is TSmartOrder) then
        TSmartOrder(self.Owner).CalcOrderTotal;
    end else if (QtyType = qcToBuild) or (QtyType = qcToBuildUOM)     then begin
      if  TotalQty =0 then begin
        TotalQty          :=  ToBuildQty;
        TotalUOMQty       :=  ToBuildUOMQty;
        ToPurchaseQty     := 0;
        ToPurchaseUOMQty  := 0;
      end else begin
        TotalQty    :=  ToPurchaseQty    + ToBuildQty;
        TotalUOMQty :=  ToPurchaseUOMQty + ToBuildUOMQty;
      end;
    end else if (QtyType = qcTotal) or (QtyType = qcTotalUOM)     then begin
        ToPurchaseQty    := TotalQty   -  ToBuildQty;
        ToPurchaseUOMQty := TotalUOMQty-  ToBuildUOMQty;
    end;
  finally
    fbCalcQtys:= False;
  end;
end;

procedure TSmartOrderLine.DoFieldOnChange(Sender: TField);
  Procedure InitWastagePercent;
  begin
        if (self.ProductID > 0) and (Self.ClassID>0) then
          WastagePercentage := ProductClass.WastagePercentage
        else WastagePercentage := 0;

  end;
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName, 'FormulaQtyValue') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue1') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue2') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue3') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue4') or
      Sysutils.SameText(Sender.FieldName , 'FormulaQtyValue5')  then begin
      if not rawmode then CalcQtyFromformula;
    end else if Sysutils.SameText(Sender.FieldName , 'SupplierID') then begin
      SupplierName:= Supplier.ClientName;
      SupplierPrintName := Supplier.ClientPrintName(false,false,false);   // binny : HidewhensamecleintName=False as the selection from the dropdown is not working when this parameter is true. most of the time, it will be either the supplier name or print name will be displayed on the grid
      CostEx := self.CalcBaseLineAmount;
      DoFieldOnChange(Dataset.findfield('CostEx'));
    end else if Sysutils.SameText(Sender.FieldName , 'classname') then begin
        classId := tcDataUtils.GetDeptID(DeptName);
        DoFieldOnChange(Dataset.findfield('classId'));
    end else if Sysutils.SameText(Sender.FieldName , 'classId') then begin
        DeptName := tcDatautils.GetClassName(ClassID);
        InitWastagePercent;
    end else if Sysutils.SameText(Sender.FieldName , 'PARTSID') then begin
      if self.ProductID > 0 then begin
        SetProductDetails;
        if  UnitOfMeasureID = 0 then begin
            UnitOfMeasureID := Product.UOMPurchasesID;
            DoFieldOnChange(Dataset.findfield('UnitOfMeasureID'));
        end;
        if ToPurchaseUOMQty = 0 then begin
            ToPurchaseQty := 1;
            DoFieldOnChange(Dataset.findfield('Qty'));
        End;
        if (Assigned(Self.Owner)) and (Self.Owner is TSmartOrder) then
            TSmartOrder(self.Owner).CalcOrderTotal;
        CostEx := self.CalcBaseLineAmount;
        DoFieldOnChange(Dataset.findfield('CostEx'));
        SupplierName := product.PreferedSupplierName;
        if (SupplierName = '') or TSmartOrder(Owner).UseDefaultSupplierForAllLines then begin
          if TSmartOrder(Owner).DefaultSupplierID > 0 then
            SupplierName := TSmartOrder(Owner).DefaultSupplierName;
        end;
        DoFieldOnChange(Dataset.findfield('SupplierName'));
        SearchFilter := PARTSNAME;

        PODesc := Product.PurchaseDescription;
        LineTaxRate := Product.TaxPurchase.Rate;
        initWastagePercent;
        DoFieldOnChange(Dataset.findfield('LineTaxRate'));
      end;
    end else if Sysutils.SameText(Sender.FieldName , 'LineTaxRate') then begin
        CostInc := GetAmountInc(CostEx , LineTaxRate);
    end else if Sysutils.SameText(Sender.FieldName , 'SupplierName') then begin
        SupplierId := tcDataUtils.getSupplierID(Suppliername);
        DoFieldOnChange(Dataset.findfield('SupplierId'));
    end else if Sysutils.SameText(Sender.fieldname , 'CusJobName') then begin
        CusJobID := TCustomer.IDToggle(Sender.AsString, Connection.Connection);
        DoFieldOnChange(Dataset.findfield('CusJobID'));
    end else if Sysutils.SameText(Sender.fieldname , 'CusJobID') then begin
        CusJobName:= TCustomer.IDToggle(Sender.AsInteger, Connection.Connection);
        CusJobPrintName:= TCustomer.ClientPrintnameToggle(Sender.AsInteger, Connection.Connection);
    end else if Sysutils.SameText(Sender.FieldName , 'CostEx') then begin
        CostInc := GetAmountInc(CostEx , LineTaxRate);
        LinePrice := self.CostEx;
    end else if Sysutils.SameText(Sender.FieldName , 'CostInc') then begin
        CostEx := GetAmountEx(CostInc , LineTaxRate);
        LinePrice := self.CostEx;
    end else if Sysutils.SameText(Sender.FieldName , 'PARTSNAME') then begin
        PartsId := tcdatautils.getProduct(Sender.asString);
        DoFieldOnChange(Dataset.findfield('PartsID'));
    end else if Sysutils.SameText(Sender.FieldName , 'TotalQty'         ) then begin
      CalcQtys(qcTotal);
    end else if Sysutils.SameText(Sender.FieldName , 'TotalUOMqty'      ) then begin
      CalcQtys(qcTotalUOM);
    end else if Sysutils.SameText(Sender.FieldName , 'TobuildQty'       ) then begin CalcQtys(qcToBuild);
    end else if Sysutils.SameText(Sender.FieldName , 'ToBuildUOMQty'    ) then begin CalcQtys(qcToBuildUOM);
    end else if Sysutils.SameText(Sender.FieldName , 'Qty'              ) then begin
      CalcQtys(qcPurchase);
    end else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasureQty' ) then begin
      CalcQtys(qcPurchaseUOM);
    end else if Sysutils.SameText(Sender.FieldName, 'deleted') then begin
      if PartsID <> 0 then begin
        if deleted then PostDB;
          if Deleted then
              if (Assigned(Self.Owner)) and (Self.Owner is TSmartOrder) then
                  TSmartOrder(self.Owner).CalcOrderTotal;
      end;
    end else if Sysutils.SameText(Sender.FieldName, 'UnitofMeasure') then begin
        UnitOfMeasureID := tcDatautils.GetUnitOfMeasureID(UnitofMeasure , PartsId);
        DoFieldOnChange(Dataset.findfield('UnitOfMeasureID'));
    end else if Sysutils.SameText(Sender.fieldName , 'UnitOfMeasureID') then begin
//       if UnitofMeasure = '' then UnitofMeasure := tcDataUtils.GetUnitOfTimeName(UnitOfMeasureID);
       if UnitofMeasure = '' then
         UnitofMeasure := tcDataUtils.GetUOMName(UnitOfMeasureID);
        UnitofMeasureMultiplier := tcDataUtils.getUnitMultiplier(UnitOfMeasureID);
        DoFieldOnChange(Dataset.findfield('UnitofMeasureMultiplier'));
        ToPurchaseUOMQty:= Divzer(ToPurchaseQty, UnitofMeasureMultiplier);
        CostEx := self.CalcBaseLineAmount;
        DoFieldOnChange(Dataset.findfield('CostEx'));
    end else if Sysutils.SameText(Sender.FieldName , 'PartBarcode') then begin
      if (not sender.IsNull) and (sender.AsString <> '') then
        SearchBarcode;
    end;
end;

procedure TSmartOrderLine.SetProductDetails;
begin
    SearchFilter:= Product.ProductName;
    UnitofMeasure:= Product.UOMPurchases;
    if UnitofMeasure = ''           then UnitofMeasure:= AppEnv.DefaultClass.DefaultUOM;
    if UnitofMeasureMultiplier = 0  then UnitofMeasureMultiplier:= 1;
    UnitOfMeasureID:= Product.UOMPurchasesID;
    UnitofMeasureMultiplier:= Product.UOMList.GetUnitMultiplier(self.UnitOfMeasureID);
    Multibuy :=Product.Multibuy;
    self.PODesc:= Product.PurchaseDescription;
    self.LineTaxRate:= Product.TaxPurchase.Rate;
    self.ClassID:= AppEnv.DefaultClass.ClassID;
    self.DeptName:= AppEnv.DefaultClass.DefaultClassName;

    if Assigned(Product.PreferedSupplier) then begin
        self.SupplierID:= Product.PreferedSupplier.Id;
        self.SupplierName:= Product.PreferedSupplierName;
        self.SupplierPrintName:= Supplier.clientPrintName;
    end;
    self.PODesc:= Product.PurchaseDescription;
    SendEvent(BusObjEvent_Change,BusObjEventVal_ProductChanged, self);
    CalcPrice;

end;

procedure TSmartOrderLine.SetProductID(const Value: Integer);begin  inherited;PartsID := Value;end;
procedure TSmartOrderLine.SetProductName(const Value: string);begin  inherited; Partsname := Value;end;

procedure TSmartOrderLine.CalcPrice;
begin
  if UserEnteredCost then exit;
  if self.ToPurchaseQty <> 0 then begin
    self.CostEx:= Product.GetCostForQty(self.ToPurchaseQty);
    self.CostInc:= GetAmountInc(self.CostEx, self.LineTaxRate);
  end  else begin
    self.CostEx:= Product.GetCostForQty(1);
    self.CostInc:= GetAmountInc(self.CostEx, self.LineTaxRate);
  end;
end;

procedure TSmartOrderLine.InitializeNewObject;
begin
    inherited;
    if Owner is TSmartOrder then begin
        TSmartOrder(owner).PostDB ;
        SmartOrderID:= TSmartOrder(owner).Id;
    end;
    Deleted := False;
end;

procedure TSmartOrderLine.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fbCalcQtys:= False;
end;

function TSmartOrderLine.Delete: boolean;
begin
  try
    with TERPCommand.Create(nil) do begin
      Connection := self.Connection.Connection;
      SQL.Text :=
        'delete from ' + TAttachment.GetBusObjectTablename +
        ' where TableName = ' + QuotedStr(self.GetBusObjectTablename) +
        ' and TableId = ' + IntToStr(self.ID);
      Execute;
      Free;
    end;
  except
    on ex : exception do begin
      result := false;
      ResultStatus.AddItem(false,rssWarning,0,'Error deleting: ' + ex.Message);
      exit;
    end;
  end;
  result := inherited;
end;

function TSmartOrderLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    result:= inherited DoAfterInsert(Sender);
    if not result then Exit;
    InitializeNewObject;
    ClassID := AppEnv.DefaultClass.ClassID;
    UnitofMeasure := AppEnv.DefaultClass.DefaultUOM;
end;

Function  TSmartOrderLine.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
    result:= inherited DoAfterPost(Sender);
    if not result then Exit;
    if (Assigned(Self.Owner)) and (Self.Owner is TSmartOrder) and not(appenv.CompanyPrefs.ConvertConvertedSmartOrder)  then
        TSmartOrder(Self.Owner).CalcOrderTotal;
    if (ID>0)  and (CusJobName = '') and (ToPurchaseQty = 0) and (not deleted) and
      (PartsID = 0) and ((PartsName = '') or (TProduct.IDToggle(PartsName,Connection.Connection) = 0)) then
      Deleted := True;
end;

function TSmartOrderLine.DoBeforeEdit(Sender: TDatasetBusObj): Boolean;
begin
    result := inherited DoBeforeEdit(Sender);
    if not result then exit;

    if (not appenv.CompanyPrefs.ConvertConvertedSmartOrder) then
      if converted then begin
        SendEvent(BusObjEvent_Warning,BusobjEventVal_ConvertedSOLnotEditable, self);
        Result:= False;
        Abort;
      end;

end;

Function  TSmartOrderLine.DoBeforePost(Sender :TDatasetBusObj ) : Boolean;
begin
    result:= inherited DoBeforePost(Sender);
    if not result then Exit;
    if  {(not DatasetPosting) and} (PartsID = 0) and ((PartsName = '') or (TProduct.IDToggle(PartsName,Connection.Connection) = 0)) then begin
        Deleted := True;
        Result := True;
        Exit;
    end;
end;

constructor TSmartOrderLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbCalcQtys := False;
end;

Procedure TSmartOrderLine.CreateInstance;
begin
end;



procedure TSmartOrderLine.SearchBarcode;
var
  x:String;
begin
      x := tcdatautils.GetProductForbarCode(PartBarcode);
      if sametext(x,'InactiveProduct') then
        partbarcode := ''
      else if (sametext(x,'Inactivebarcode')) or (x='') then begin
          SendEvent(BusobjEvent_ToDo, BusObjEvent_PartBarcodeNotfound, self);
          if PARTSNAME <> '' then
            DoFieldOnChange(Dataset.findfield('PARTSNAME'));
      end else begin
        PARTSNAME := x;
        DoFieldOnChange(Dataset.findfield('PARTSNAME'));
      end;
end;

procedure TSmartOrderLine.SetActive(const Value: Boolean);begin  inherited;  Deleted := not(Active);end;

function TSmartOrderLine.getpartbarcode: String;
begin
  Result := GetStringfield('partbarcode');
end;

procedure TSmartOrderLine.setpartbarcode(const Value: String);
begin
  SetStringfield('partbarcode' , Value);
end;

initialization
  RegisterClassOnce(TSmartOrder);
  RegisterClassOnce(TSmartOrderLine);
end.


