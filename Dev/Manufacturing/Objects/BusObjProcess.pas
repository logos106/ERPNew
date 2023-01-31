unit BusObjProcess;
{$I ERP.inc}
interface

uses
  BusObjNDSBase, classes, BusObjProcessPartNDS,
  BusObjBase,BusObjSaleBase, BusObjProcTreePart, DB, XMLDoc, XMLIntf,
  ProcessUtils, ProductQtyLib, IntegerListObj,PQALib, ClientDiscountObj,
  BusObjStock;

type

  TPartSource = (psNone,psStock, psManufacture);
  TChangingQty = (cqTotal,cqStock, cqbuild, cqOrder);

  { The following determin how/if a user can input data to a tree node:
      itNone - user cannot change node, don't show it
      itUser - user can edit node qty
      itOption - drop down list of sub nodes that user can select (can also edit top node qty)
      itCustom - display a custom input form
   }
  TNodeInputType = (itNone, itUser, itOption, itCustom);
  TSubBOMProcessOrderCode = (snpoASB, snpoSB, snpoBS);

  TProcessStepList = class;
  TProcTreeNode = class(TBusObjNDSTree)
  private
    FQuantity: double;
    FPurchaseLineId: integer;
    FPartsId: integer;
    fsTreePartUOM:String;
    fiTreePartUOMID:Integer;
    fdTreePartUOMMultiplier:double;
    fdTreePartUOMQuantity:Double;
    fdTreePartUOMTotalQty:Double;
    FSaleLineId: integer;
    FDescription: string;
    FCaption: string;
    FHideOnPrint: boolean;
    FPartSource: TPartSource;
    FProcTreeId: integer;
    fIsTemplate: boolean;
    fProcessStepList: TProcessStepList;
    FInputType: TNodeInputType;
    FPrice: double;
    FPriceExLabour:Double;
    FCostIncLabour:Double;
    FCost: double;
    FProductUnitPrice:double;
    FProductUnitCost:double;
    FCustomInputClass: string;
    fTreePricechanged:Boolean;
    fMakeCoupons:Boolean;
    fCouponLabelPrinted:Boolean;
    FAddToSale: boolean;
    FLinkedLineId: integer;
    FDetails: string;
    FSelected: boolean;
    FValue: string;
    FTotalQty: double;
    FComplete: boolean;
    fCleanComplete: boolean;
    FInfo: string;
    Fcomments: string;
    fQtyPer: Double;
    fsPartCalcformula:String;
    FZeroWhenLessthan1: boolean;
    FRoundtoNextNumber: boolean;
    FRoundtoPrevNumber: boolean;

    fiFormulaid :Integer;
    fdFormulaQtyValue: Double;
    fdFormulaQtyValue1: Double;
    fdFormulaQtyValue2: Double;
    fdFormulaQtyValue3: Double;
    fdFormulaQtyValue4: Double;
    fdFormulaQtyValue5: Double;

    fiBuildLineNo :Integer;
    fdBuildFormulaQtyValue: Double;
    fdBuildFormulaQtyValue1: Double;
    fdBuildFormulaQtyValue2: Double;
    fdBuildFormulaQtyValue3: Double;
    fdBuildFormulaQtyValue4: Double;
    fdBuildFormulaQtyValue5: Double;

    fdOrderFormulaQtyValue: Double;
    fdOrderFormulaQtyValue1: Double;
    fdOrderFormulaQtyValue2: Double;
    fdOrderFormulaQtyValue3: Double;
    fdOrderFormulaQtyValue4: Double;
    fdOrderFormulaQtyValue5: Double;


    fMatrixDesc: String;
    fMatrixREf: String;
    fdMatrixPrice: double;
    fdOnOrderUOMQty: Double;
    fdFromStockUOMQty: Double;
    fdManufactureUOMQty: Double;
    fdManufacturedUOMQty: Double;
    fdManufacturingUOMQty: Double;
    CalculatingQty:boolean;
    fdTotalQtyOriginal: Double;
    fdQtyOriginal: double;
    fbCalcQtyFromformula:Boolean;
    fdchildrenQty: double;
    fQtyVariation: double;
    fQtyPerCoupon: double;
    FIgnoreItemCommentsforDescription: boolean;
    fObjClientDiscount: TClientDiscountObj;
    //uildingBlockQty: double;
    fRAtePercoupon: double;
    fsAllInfos: String;
    fsSelectedInfos: string;
    fInheritFromID: integer;
    fInheritFromEditVersion: integer;
    fbAddingtoTotalQty:Boolean;
    FSubBOMProcessOrder: String;
    function getFromStockQty: Double;
    function getManufactureQty: Double;
    function getonOrderQty: Double;
    function getManufacturedQty: Double;
    function getManufacturingQty: Double;


    procedure SetCaption(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetPartsId(const Value: integer);
    procedure SetTreePartUOM(const Value: String);
    procedure SetTreePartUOMID(const Value :Integer);
    procedure SetTreePartUOMMultiplier(const Value: double);
    procedure SetTreePartUOMQuantity(const Value: Double);
    procedure SetTreePartUOMTotalQty(const Value: Double);
    procedure setFromStockUOMQty(const Value: Double);
    procedure setManufactureUOMQty(const Value: Double);
    procedure setManufacturedUOMQty(const Value: Double);
    procedure setManufacturingUOMQty(const Value: Double);
    procedure setOnOrderUOMQty(const Value: Double);

    procedure SetPurchaseLineId(const Value: integer);
    procedure SetQuantity(const Value: double);
    procedure SetSaleLineId(const Value: integer);
    procedure SetHideOnPrint(const Value: boolean);
    procedure SetPartSource(const Value: TPartSource);
    procedure SetProcTreeId(const Value: integer);
    function GetIsTemplate: boolean;
    procedure SetIsTemplate(const Value: boolean);
    function GetSelectedChild: TProcTreeNode;
    function GetProcessStepList: TProcessStepList;
    procedure SetInputType(const Value: TNodeInputType);
    Procedure SetSubBOMProcessOrderCode(const Value :TSubBOMProcessOrderCode);
    procedure SetCost(const Value: double);
    procedure SetCustomInputClass(const Value: string);
    Procedure SetTreePricechanged(const Value :Boolean);
    Procedure SetMakeCoupons(const Value :Boolean);
    Procedure SetCouponLabelPrinted(const Value :Boolean);
    procedure SetPrice(const Value: double);
    Procedure SetProductUnitPrice(const Value:Double);
    Procedure SetProductUnitCost(const Value:Double);
    procedure SetPriceExLabour(const Value: double);
    Procedure SetCostIncLabour(const Value:double);

    procedure SetAddToSale(const Value: boolean);
    procedure SetLinkedLineId(const Value: integer);
    procedure SetDetails(const Value: string);
    procedure SetSelected(const Value: boolean);
    procedure SetValue(const Value: string);
    function GetParentNode: TProcTreeNode;
    function IsOptionNode: boolean;
    procedure SetTotalQty(const Value: double);
    function GetCaption: string;
    procedure SetProcessStepList(const Value: TProcessStepList);
    procedure SetInfo(const Value: string);
    procedure Setcomments(const Value: string);
    function getTreecount: Integer;
    procedure setQtyPer(const Value: Double);
    Procedure SetPartCalcformula(const Value:String);
    procedure SetZeroWhenLessthan1(const Value: boolean);
    procedure SetRoundtoNextNumber(const Value: boolean);
    procedure SetRoundtoPrevNumber(const Value: boolean);
    Procedure SetFormulaid(Const Value:Integer);
    procedure SetFormulaQtyValue(const Value: Double);
    procedure SetFormulaQtyValue1(const Value: Double);
    procedure SetFormulaQtyValue2(const Value: Double);
    procedure SetFormulaQtyValue3(const Value: Double);
    procedure SetFormulaQtyValue4(const Value: Double);
    procedure SetFormulaQtyValue5(const Value: Double);

    Procedure SetBuildLineNo(const Value:Integer);
    procedure setBuildFormulaQtyValue(const Value: Double);
    procedure setBuildFormulaQtyValue1(const Value: Double);
    procedure setBuildFormulaQtyValue2(const Value: Double);
    procedure setBuildFormulaQtyValue3(const Value: Double);
    procedure setBuildFormulaQtyValue4(const Value: Double);
    procedure setBuildFormulaQtyValue5(const Value: Double);

    procedure setOrderFormulaQtyValue(const Value: Double);
    procedure setOrderFormulaQtyValue1(const Value: Double);
    procedure setOrderFormulaQtyValue2(const Value: Double);
    procedure setOrderFormulaQtyValue3(const Value: Double);
    procedure setOrderFormulaQtyValue4(const Value: Double);
    procedure setOrderFormulaQtyValue5(const Value: Double);

    function getTreePartUOM: String;
    function getTreePartUOMMultiplier: Double;
    function getQtyFor1UOMParent: Double;
    function getQtyForUOMParent: Double;
    function getNodeDefinition: String;
    Function updateProcessParttimesheet(ProcessPartID:Integer):Boolean ;
    Procedure UpdateProcessPart;
    procedure ValidateQty(Const Value :TChangingQty);
    procedure AllocateQty(const AvailQty: double; var Qty1, Qty2: Double);


    procedure AllocateAvailableQty;
    procedure setFromStockQty(const Value: Double);
    procedure setManufactureQty(const Value: Double);
    procedure setManufacturedQty(const Value: Double);
    procedure setManufacturingQty(const Value: Double);
    procedure setOnOrderQty(const Value: Double);
    procedure SetTotalQtyOriginal(const Value: Double);
    procedure setQtyOriginal(const Value: double);
    function getFromStockUOMQty: Double;
    function getManufactureUOMQty: Double;
    function getManufacturedUOMQty: Double;
    function getManufacturingUOMQty: Double;
    function getOnOrderUOMQty: Double;
    procedure CalcQtyFromFormulaQty(qtytype:String);
    procedure getCalcQtYformulaValue(Sender: TObject; const VarName: string;
      var Value: extended; var FieldFound: Boolean);
    procedure getCalcQtYformulaValueBuild(Sender: TObject;
      const VarName: string; var Value: extended; var FieldFound: Boolean);
    procedure getCalcQtYformulaValueOrder(Sender: TObject;
      const VarName: string; var Value: extended; var FieldFound: Boolean);
    function getNodeDetails: String;
    function getparentnodeDetails: String;
    function FindnodeforDetails(sNodeDetails: String): TProcTreeNode;

    function ERPFixSLCost(const xProctreeID:Integer): double;
    function getCaptionIntended: String;
    procedure InitUOM(const aUOMName: String; Product: TProduct); //overload;
    function getProgressMsg: String;
    procedure SetQtyVariation(const Value: double);
    procedure SetQtyPerCoupon(const Value: double);
    procedure SetRAtePercoupon(const Value: double);
    function getProducthasformulaEntry: Boolean;
    function GetClientDiscountObj: TClientDiscountObj;
    function getParentCaption: String;
    procedure SetIgnoreItemCommentsforDescription(const Value: boolean);
    procedure DoGetParserVariable(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
    procedure SetInheritFromEditVern(const Value: integer);
    procedure SetInheritFromID(const Value: integer);
    procedure SetSubBOMProcessOrder(const Value: String);
    function getSubBOMProcessOrderCode: TSubBOMProcessOrderCode;

  protected
    fProcTreePart: TProcTreePart;
    fProduct: TProduct;
    fbUpdatingQty:boolean;
    fsProgressMsg:String;
    procedure SetComplete(const Value: boolean); virtual;
    function GetId: integer; override;
    procedure SetId(const Value: integer); override;
    function GetAccessLevel: integer; override;
    procedure SetAccessLevel(const Value: integer); override;
    procedure AfterSave; override;
    function GetProcTreePart: TProcTreePart; virtual;
    function GetProduct: TProduct; virtual;
    function GetDirty: boolean; override;
    procedure SetDirty(const Value: boolean); override;
    procedure MakeDirty; override;
    function getclasssID:Integer; virtual;
    procedure MergeProcess(targetnode:TProctreenode);virtual;
    function ProductQty(const fiPartsID: Integer; Qtytype :TQtytype): Double;Virtual;
    procedure undoCalcCost(const SkipCustom: boolean = true);Virtual;
    function MakeProcesStepList: TProcessStepList;Virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Delete:Boolean; override;
    function SaveNoCheck: boolean; override;
    property SelectedChild: TProcTreeNode read GetSelectedChild;
    property ProcessStepList: TProcessStepList read GetProcessStepList write SetProcessStepList;
    function HasProcessSteps: boolean;
    function ProcessStepDescList: string;
    Function ProcessStepExtraInfoList:String;
    procedure ClearIds; override;
    procedure ProcessStatus(var ProcessPartStatusList: TProcessPartStatusList);
    function StatusList: TProcessPartStatusList; Virtual;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    Procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure CalcPrice(const SkipCustom: boolean = true; Recalccost :Boolean = True;forceRecalc:Boolean =False); virtual;
    procedure CalcchildQty(const SkipCustom: boolean = true);virtual;
    procedure CalcCost(const SkipCustom: boolean = true); virtual;
    Function ProcesstepPrice:Double;
    procedure CalcTotalQty;
    procedure BuildDetails; virtual;
    function ValidateData: boolean; override;
    function GetChildNode(const Name: string): TProcTreeNode;
    property ParentNode: TProcTreeNode read GetParentNode;
    procedure Assign(Source: TPersistent); override;
    procedure DeleteNoCheck; override;
    property ProcTreePart: TProcTreePart read GetProcTreePart;
    property Product: TProduct read GetProduct;
    procedure New; override;
    function IsOptionItem: boolean;
    function IsOption: boolean;
    function AllProcessesComplete: boolean;
    procedure CompleteAllProcesses;
    procedure Load(const fIsReadonly:boolean =False); overload; override;
    property CleanComplete: boolean read fCleanComplete ;
    Property TreeCount :Integer read getTreecount;
    Function TreeText:String;
    Property NodeDefinition:String read getNodeDefinition;
    property PriceExLabour: double read FPriceExLabour write SetPriceExLabour;
    Property CostIncLabour :Double read fCostIncLabour write setCostIncLabour;
    function IsManufacuring:boolean;
    function istoremoveTree:Boolean;
    Procedure logit(Printheader:boolean =False;Lognodename:String =''; Dochildren:Boolean =true);override;
    function ProcTreePartCount: Integer;
    function DoOrder(SaleLineIDs:TIntegerList= nil; ProctreeIDs:TIntegerList= nil):Boolean;Virtual;
    procedure CalcQty;
    Procedure CompareTrees;Virtual;
    Function MasterRef:String;
    Function isInternalOrder:boolean ;Virtual;
    Procedure OnBeforechangeStatus(Oldstatus ,NewStatus :TProcessPartStatus); virtual;
    Property PartCalcformula :String read fsPartCalcformula write setPartCalcformula;
    Function ProductHasformula:Boolean;
    Property NodeDetails :String read getNodeDetails;
    Property parentNodedetails :String read getparentnodeDetails;
    Procedure MergeTree(Target:TProcTreenode);
    function findProcessstep(processstepID:Integer):TProcessPartNDS;
    Procedure InitWithZeroQty;
    function nodeselectedinTree:Boolean;
    Property childrenQty  : double read fdchildrenQty write fdchildrenQty;
    function TotalQtyDetails: String;
    function CostDetails: String;
    function CostIncLabourDetails: String;
    function PriceDetails: String;
    Property CaptionIntended :String read getCaptionIntended;
    function Locate(TreeID:Integer; var node: TProcTreeNode) :boolean;Overload;
    function Locate(aParentCaption, aTreeCaption: String;  var node: TProcTreeNode): boolean;Overload;
    function Locate(aParentCaption, aTreeCaption: String;qty1,qty2,qty3,qty4,qty5:Double;  var node: TProcTreeNode): boolean;Overload;
    Property ProgressMsg:String read getProgressMsg;
    Procedure InittoRecalculatePricefromProduct;
    Property ProducthasformulaEntry :Boolean read getProducthasformulaEntry;
    property ObjClientDiscount: TClientDiscountObj read GetClientDiscountObj;
    Procedure SetCleanComplete(const Value:Boolean);
    //Property TreePricechanged       : Boolean Read fTreePricechanged        Write SetTreePricechanged;
    procedure updateprice;Virtual;
    Property ParentCaption :String read getParentCaption;
    Procedure Deletetree; override;
    Procedure CalcQtyfromformula;
    Procedure CalcQtyFromformulaTree;
    procedure ClearAllCosts;
    function IsEqual(node: TProcTreeNode): boolean;
    property SubBOMProcessOrderCode : TSubBOMProcessOrderCode  Read getSubBOMProcessOrderCode   write SetSubBOMProcessOrderCode;
    procedure LoadTree(Const SubTreeOnly: boolean = false; PartsourceStock :Boolean = False); Override;
    //procedure UpdateDefaultQty;Virtual;
  published
    property InputType              : TNodeInputType  Read FInputType       write SetInputType;
    property PartSource             : TPartSource     Read FPartSource      write SetPartSource;
    property ProcTreeId             : integer Read FProcTreeId              Write SetProcTreeId;
    property Caption                : string  Read GetCaption               Write SetCaption;
    property Description            : string  Read FDescription             Write SetDescription;
    property Details                : string  Read FDetails                 Write SetDetails;
    property Info                   : string  Read FInfo                    Write SetInfo;
    property comments               : string  Read Fcomments                Write Setcomments;
    property PartsId                : integer Read FPartsId                 Write SetPartsId;
    property TreePartUOM            : String  Read getTreePartUOM           Write setTreePartUOM;
    property TreePartUOMID          : Integer Read fiTreePartUOMID          Write setTreePartUOMID;
    property TreePartUOMMultiplier  : Double  Read getTreePartUOMMultiplier Write setTreePartUOMMultiplier;
    property TreePartUOMQuantity    : Double  Read fdTreePartUOMQuantity    Write setTreePartUOMQuantity;
    property TreePartUOMTotalQty    : Double  Read fdTreePartUOMTotalQty    Write setTreePartUOMTotalQty;
    Property TotalQtyOriginal       : Double  Read fdTotalQtyOriginal       Write SetTotalQtyOriginal;
    Property QtyOriginal            : double  Read fdQtyOriginal            Write setQtyOriginal;
    property FromStockUOMQty        : Double  Read getFromStockUOMQty       Write setFromStockUOMQty;
    property ManufactureUOMQty      : Double  Read getManufactureUOMQty     Write setManufactureUOMQty;
    property ManufacturedUOMQty     : Double  Read getManufacturedUOMQty    Write setManufacturedUOMQty;
    property ManufacturingUOMQty    : Double  Read getManufacturingUOMQty   Write setManufacturingUOMQty;
    property OnOrderUOMQty          : Double  Read getOnOrderUOMQty         Write setOnOrderUOMQty;
    property FromStockQty           : Double  Read getFromStockQty          Write setFromStockQty;
    property ManufactureQty         : Double  Read getManufactureQty        Write setManufactureQty;
    property ManufacturedQty        : Double  Read getManufacturedQty       Write setManufacturedQty;
    property ManufacturingQty       : Double  Read getManufacturingQty      Write setManufacturingQty;
    property OnOrderQty             : Double  Read getonOrderQty            Write setOnOrderQty;
    property SaleLineId             : integer Read FSaleLineId              Write SetSaleLineId;
    Property ClassId                : Integer Read getclasssID;
    property PurchaseLineId         : integer Read FPurchaseLineId          Write SetPurchaseLineId;
    property IsTemplate             : boolean Read GetIsTemplate            Write SetIsTemplate;
    property Quantity               : double  Read FQuantity                Write SetQuantity;
    Property QtyFor1UOMParent       : Double  Read getQtyFor1UOMParent;
    Property QtyForUOMParent        : Double  Read getQtyForUOMParent;
    Property QtyPer                 : Double  Read fQtyPer                  Write setQtyPer;
    property TotalQty               : double  Read FTotalQty                Write SetTotalQty;
    property HideOnPrint            : boolean Read FHideOnPrint             Write SetHideOnPrint;
    property AddToSale              : boolean Read FAddToSale               Write SetAddToSale;
    property LinkedLineId           : integer Read FLinkedLineId            Write SetLinkedLineId;{ the id of eg invoice line that has been created from this tree item }
    property CustomInputClass       : string  Read FCustomInputClass        Write SetCustomInputClass;
    Property TreePricechanged       : Boolean Read fTreePricechanged        Write SetTreePricechanged;
    Property MakeCoupons            : Boolean Read fMakeCoupons             Write SetMakeCoupons;
    Property CouponLabelPrinted     : Boolean Read fCouponLabelPrinted      Write SetCouponLabelPrinted;
    property Price                  : double  Read FPrice                   Write SetPrice;
    Property ProductUnitPrice       : Double  Read fProductUnitPrice        Write setProductUnitPrice;
    Property ProductUnitCost        : Double  Read fProductUnitCost         Write setProductUnitCost;
    Property MatrixPrice            : double  Read fdMatrixPrice            Write fdMatrixPrice;
    Property MatrixDesc             : String  Read fMatrixDesc              Write fMatrixDesc;
    Property MatrixREf              : String  Read fMatrixREf               Write fMatrixREf;
    property Cost                   : double  Read FCost                    Write SetCost;
    property Selected               : boolean Read FSelected                Write SetSelected;
    property Value                  : string  Read FValue                   Write SetValue;
    property Complete               : boolean Read FComplete                Write SetComplete;
    property QtyVariation           : double  Read fQtyVariation            Write SetQtyVariation;
    property QtyPerCoupon           : double  Read fQtyPerCoupon            Write SetQtyPerCoupon;
    property RAtePercoupon          : double  Read fRAtePercoupon           Write SetRAtePercoupon;
    property ZeroWhenLessthan1      : boolean Read FZeroWhenLessthan1       Write SetZeroWhenLessthan1;
    property RoundtoNextNumber      : boolean Read FRoundtoNextNumber       Write SetRoundtoNextNumber;
    property RoundtoPrevNumber      : boolean Read FRoundtoPrevNumber       Write SetRoundtoPrevNumber;

    Property Formulaid       :Integer read fiFormulaid        write SetFormulaid;
    Property FormulaQtyValue : Double Read fdFormulaQtyValue  write SetFormulaQtyValue;
    Property FormulaQtyValue1: Double Read fdFormulaQtyValue1 write SetFormulaQtyValue1;
    Property FormulaQtyValue2: Double Read fdFormulaQtyValue2 write SetFormulaQtyValue2;
    Property FormulaQtyValue3: Double Read fdFormulaQtyValue3 write SetFormulaQtyValue3;
    Property FormulaQtyValue4: Double Read fdFormulaQtyValue4 write SetFormulaQtyValue4;
    Property FormulaQtyValue5: Double Read fdFormulaQtyValue5 write SetFormulaQtyValue5;

    Property BuildLineNo  :Integer Read fiBuildLineNo   write SetBuildLineNo;
    Property BuildFormulaQtyValue : Double Read fdBuildFormulaQtyValue  write setBuildFormulaQtyValue;
    Property BuildFormulaQtyValue1: Double Read fdBuildFormulaQtyValue1 write setBuildFormulaQtyValue1;
    Property BuildFormulaQtyValue2: Double Read fdBuildFormulaQtyValue2 write setBuildFormulaQtyValue2;
    Property BuildFormulaQtyValue3: Double Read fdBuildFormulaQtyValue3 write setBuildFormulaQtyValue3;
    Property BuildFormulaQtyValue4: Double Read fdBuildFormulaQtyValue4 write setBuildFormulaQtyValue4;
    Property BuildFormulaQtyValue5: Double Read fdBuildFormulaQtyValue5 write setBuildFormulaQtyValue5;

    Property OrderFormulaQtyValue : Double Read fdOrderFormulaQtyValue  write setOrderFormulaQtyValue;
    Property OrderFormulaQtyValue1: Double Read fdOrderFormulaQtyValue1 write setOrderFormulaQtyValue1;
    Property OrderFormulaQtyValue2: Double Read fdOrderFormulaQtyValue2 write setOrderFormulaQtyValue2;
    Property OrderFormulaQtyValue3: Double Read fdOrderFormulaQtyValue3 write setOrderFormulaQtyValue3;
    Property OrderFormulaQtyValue4: Double Read fdOrderFormulaQtyValue4 write setOrderFormulaQtyValue4;
    Property OrderFormulaQtyValue5: Double Read fdOrderFormulaQtyValue5 write setOrderFormulaQtyValue5;
    property IgnoreItemCommentsforDescription      : boolean Read FIgnoreItemCommentsforDescription       Write SetIgnoreItemCommentsforDescription;
    property SubBOMProcessOrder     : String  Read FSubBOMProcessOrder   write SetSubBOMProcessOrder;
    Property AllInfos :String read fsAllInfos;
    Property SelectedInfos :string read fsSelectedInfos;
    property InheritFromID: integer read fInheritFromID write SetInheritFromID;
    property InheritFromEditVersion: integer read fInheritFromEditVersion write SetInheritFromEditVern;
  end;


  TProcessStepList = class(TBusObjNDSList)
  private
  protected
    function GetItem(const index: integer): TProcessPartNDS; reintroduce;
  public
    property Item[const index: integer]: TProcessPartNDS Read GetItem; default;
    procedure ProcessStatus(var ProcessPartStatusList: TProcessPartStatusList);
    function AddProcessPart: TProcessPartNDS;Virtual;
    function ItemById(const Id: integer): TProcessPartNDS;
    procedure CompletePrecessSteps;
    function IsEqual(aStepList: TProcessStepList): boolean;
  end;

  TSalesLineProcTree = class(TProcTreeNode)
  private
    fDeleted: boolean;
    fProcTreePartInitialised: boolean;
    fSalesLine:TSalesLineBase;
    fSales:TSalesBase;
    fdQtyPlanned: Double;
    fdTotalQtyPlanned: Double;
    fdWasteUOMQty: Double;
    fbCalcTreePrice:Boolean;
    fbCalcTreeCost:Boolean;
    fbChangeTreeqty:Boolean;
    fbBOMGroupedLine :Boolean;
    //fbCOGSFixDone :Boolean;
    fbBOMProductionLine:Boolean;
    ficleanId: Integer;
    fbForcePQACreationonSave: Boolean;
    fbDoNotCreateSmartOrder: Boolean;
    fbConvertCurrent: Boolean;


    function getSalesLine: TSalesLineBase;
    procedure SetDeleted(const Value: boolean);
    function FirstShipDate: TDateTime;
    function GetDeleted: boolean;
    function getSales: TSalesBase;
    Procedure MultiEventHandler(Sender: TObject; const Event, Value : string);
    Procedure doSalesLineProcTreeIDchange;
    Function AnyScheduled:Boolean;
    Procedure LockQty;
    procedure setQtyPlanned(const Value: Double);
    procedure setTotalQtyPlanned(const Value: Double);
    procedure setWasteUOMQty(const Value: Double);
    Procedure SetBOMGroupedLine(const Value :Boolean);
    //Procedure SetCOGSFixDone(const Value :Boolean);
    Procedure SetBOMProductionLine(const Value :Boolean);
    procedure Initformulafields;
    procedure ResetProcessStep;
    procedure MakeJEforManCOGSDiff;
    function getForcePQACreationonSave: Boolean;
    procedure CheckProcessTransDate;
    function getConvertCurrent: boolean;
    Procedure Logtree(const logTitle:String);
    procedure Logtreeitem;
    function getCalcTreePrice: Boolean;

  protected
    function GetProcTreePart: TProcTreePart; override;
    procedure SetComplete(const Value: boolean); override;
    function OptionItem:Boolean; override;
    function GetStorer: TBusObjStorer; Override;
    function getclasssID:Integer; Override;
    procedure MergeProcess(targetnode:TProcTreeNode);Override;
    function ProductQty(const fiPartsID: Integer; Qtytype :TQtytype): Double;Override;
    procedure undoCalcCost(const SkipCustom: boolean = true);Override;
    Function RelatedRecordsDeleteSQL:String;Override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure DoAfterLoad;Override;
    Procedure Deletetree; override;
    procedure DoEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil ;  Proc : TProcBusObjBase= nil); override;
    procedure CalcPrice(const SkipCustom: boolean = true; Recalccost :Boolean = True;forceRecalc:Boolean =False); override;
    procedure CalcCost(const SkipCustom: boolean = true); override;
    procedure BuildDetails; override;
    function SaveNoCheck: boolean; override;
    Function SourceFromStock:Boolean ; override;
    function DoOrder(SaleLineIDs:TIntegerList= nil; ProctreeIDs:TIntegerList= nil):Boolean;Override;
    function HasOnOrderQty: boolean;
    Procedure CompareTrees;Override;
    procedure Load(const fIsReadonly:boolean =False); overload; override;
    function ValidateData: boolean; override;
    property SalesLine: TSalesLineBase Read getSalesLine;
    Property Sales :TSalesBase Read getSales;
    procedure DeleteNoCheck; override;
    property Deleted: boolean Read GetDeleted write SetDeleted;
    Function TransRef:String;
    Function isInternalOrder:boolean ;Override;
    Procedure OnBeforechangeStatus(Oldstatus ,NewStatus :TProcessPartStatus); Override;
    function SmartOrderID:Integer;
    procedure updateprice;Override;
    function StatusList: TProcessPartStatusList; Override;
    procedure Assign(Source: TPersistent); override;
    function DoAccountPosting(var PostDesc: string): Boolean;
    Property cleanId :Integer Read ficleanId write ficleanId;
    Property ForcePQACreationonSave :Boolean read getForcePQACreationonSave write fbForcePQACreationonSave;
    Property DoNotCreateSmartOrder : Boolean read fbDoNotCreateSmartOrder write fbDoNotCreateSmartOrder;
    procedure VarifyMastertype(Value: TMSBusObjMasterType);
    Property ConvertCurrent : boolean read getConvertCurrent ;
    Function ChangeTotalQty(aproctreeID:Integer ; fUOMQty, fWasteuomQty:Double):Boolean;
    Property CalcTreePrice:Boolean read getCalcTreePrice write fbCalcTreePrice;
    //procedure UpdateDefaultQty;Override;

  Published
    Property QtyPlanned :Double Read fdQtyPlanned write setQtyPlanned;
    Property TotalQtyPlanned :Double Read fdTotalQtyPlanned write setTotalQtyPlanned;
    Property WasteUOMQty :Double Read fdWasteUOMQty write setWasteUOMQty;
    Property BOMGroupedLine :Boolean Read fbBOMGroupedLine write setBOMGroupedLine;
    Property BOMProductionLine :Boolean Read fbBOMProductionLine write setBOMProductionLine;
    //Property COGSFixDone :Boolean Read fbCOGSFixDone write setCOGSFixDone;

  end;

  TProductProcTree = class(TProcTreeNode)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil;  Proc : TProcBusObjBase= nil); override;
    procedure CalcPrice(const SkipCustom: boolean = true; Recalccost :Boolean = True;forceRecalc:Boolean =False); override;
    Function IsOwnedbySalesLineProcTree:Boolean;
  end;

  function StrToPartSource(const Value: string): TPartSource;
  function PartSourceToStr(const Value: TPartSource): string;


implementation

uses
  SysUtils, ProcessDataUtils, MyAccess,ERPdbComponents,
  ClassExtenderListObj, SalesConst, CommonLib,
  tcConst, Forms, Dialogs, BusObjAccountPosting,
  busobjPQA, Math, AppEnvironment, BusObjConst, Progressdialog, tcDataUtils,
  TypInfo,BusObjProcessPart, BusObjTrans, Variants, PartsPriceMatrixLib,
  CommonDbLib,  BusObjSmartOrder,
  AuditTrialTreeLib, ParserLib, ParserObj, ManufactureLib, BusObjSales,
  SystemLib, DbSharedObjectsObj, LogLib , DateUtils;

function StrToPartSource(const Value: string): TPartSource;
begin
  if Value = 'Stock' then result:= psStock
  else if Value = 'Manufacture' then result:= psManufacture
  else if Value = '' then result:= psNone
  else
    raise Exception.Create('StrToPartSource - Invalid input value "' + Value + '"');
end;

function PartSourceToStr(const Value: TPartSource): string;
begin
  if Value = psStock then result:= 'Stock'
  else if Value = psNone then result:= ''
  else if Value = psManufacture then result:= 'Manufacture'
  else
    raise Exception.Create('PartSourceToStr - Invalid input value.');
end;


{ TProcTreeNode }

constructor TProcTreeNode.Create(AOwner: TComponent);
begin
  inherited;
  fbAddingtoTotalQty := False;
  fsProgressMsg:='';
  fbCalcQtyFromformula:= False;
  CalculatingQty:= False;
  fIdFieldName:= 'ProcTreeId';
  fBusObjectTableName:= 'tblProcTree';
  fIsTemplate:= false;
  fInputType:= itNone;
  fSubBOMProcessOrder:= 'ASB';
  fAddToSale:= false;
  fLinkedLineId:= 0;
  FSelected:= false;
  FZeroWhenLessthan1:= false;
  FRoundtoNextNumber:= false;
  FRoundtoPrevNumber:= false;
  fProcTreePart:= nil;
  fProduct:= nil;
  FPartSource:= psManufacture;
  fQtyPer:= 0;
  fsPartCalcformula:= '';

  fdFormulaQtyValue := 0;
  fdFormulaQtyValue1 := 0;
  fdFormulaQtyValue2 := 0;
  fdFormulaQtyValue3 := 0;
  fdFormulaQtyValue4 := 0;
  fdFormulaQtyValue5 := 0;

  fiBuildLineNo := 0;
  fdBuildFormulaQtyValue := 0;
  fdBuildFormulaQtyValue1 := 0;
  fdBuildFormulaQtyValue2 := 0;
  fdBuildFormulaQtyValue3 := 0;
  fdBuildFormulaQtyValue4 := 0;
  fdBuildFormulaQtyValue5 := 0;

  fdOrderFormulaQtyValue := 0;
  fdOrderFormulaQtyValue1 := 0;
  fdOrderFormulaQtyValue2 := 0;
  fdOrderFormulaQtyValue3 := 0;
  fdOrderFormulaQtyValue4 := 0;
  fdOrderFormulaQtyValue5 := 0;
  FIgnoreItemCommentsforDescription:= false;

  fbUpdatingQty := False;
  fMatrixDesc:='';
  fMatrixREf:='';
  fdMatrixPrice:=0;
end;

destructor TProcTreeNode.Destroy;
begin
  if Assigned(fProcessStepList) then
    FreeandNil(fProcessStepList);
  if Assigned(fObjClientDiscount) then
    FreeandNil(fObjClientDiscount);


  try  inherited;  Except end;
end;

function TProcTreeNode.DoOrder(SaleLineIDs:TIntegerList= nil; ProctreeIDs:TIntegerList= nil):Boolean;
begin
  // overriden in TSalesLineProcTree
  Result:= True;
end;

function TProcTreeNode.Delete:Boolean;
begin
  if (not CanDelete) then begin
    self.ResultStatus.AddItem(false, rssError, 0, 'No rights to delete ' +
      Self.BusObjectTypeDescription);
      Result := False;
  end
  else begin
    Result := inherited Delete;
  end;
end;

function TProcTreeNode.GetAccessLevel: integer;
begin
  if Assigned(Owner) and (Owner is TProcTreeNode) then
    result:= TProcTreeNode(Owner).AccessLevel
  else
    result:= inherited GetAccessLevel;
end;

function TProcTreeNode.GetId: integer;
begin
  result:= self.ProcTreeId;
end;


function TProcTreeNode.GetIsTemplate: boolean;
begin
  if Assigned(Owner) and (Owner is TProcTreeNode) then
    result:= TProcTreeNode(Owner).IsTemplate
  else
    result:= fIsTemplate;
end;

procedure TProcTreeNode.SetAccessLevel(const Value: integer);
begin
  if Assigned(Owner) and (Owner is TProcTreeNode) then
    TProcTreeNode(Owner).AccessLevel:= Value
  else
    fAccessLevel:= Value;
end;

procedure TProcTreeNode.SetIsTemplate(const Value: boolean);
begin
  fIsTemplate:= Value;
  if Assigned(Owner) and (Owner is TProcTreeNode) then
    TProcTreeNode(Owner).IsTemplate:= Value;
end;
procedure TProcTreeNode.InittoRecalculatePricefromProduct;
var
  x:Integer;
  child: TProcTreeNode;
begin
    TreePricechanged := False;
    if Children.Count >0  then
      for x:= 0 to Children.Count -1 do begin
        child:= TProcTreeNode(Children[x]);
        child.InittoRecalculatePricefromProduct;
      end;
end;

procedure TProcTreeNode.InitUOM(const aUOMName: String; Product: TProduct);
var
  UOMName: string;
begin
  UOMName := aUOMName;
  Product.UOMList.Closedb;
  Product.UOMList.OpenDb;
  if UOMName = '' then UOMName := Product.UOMSales;

  if Product.ProductUOMLocate(UOMName)  then begin
    fdTreePartUOMMultiplier := Product.UOMList.Multiplier;
    fiTreePartUOMID := Product.UOMList.ID;
    fsTreePartUOM := Product.UOMList.UOMName;
  end else begin
    fdTreePartUOMMultiplier := 1;
    fiTreePartUOMID  := 0;
  end;
end;

procedure TProcTreeNode.SetPartsId(const Value: integer);
begin
  if FPartsId <> Value then begin
    if FPartsId <> 0 then  ProcTreePart; // force to init fProcTreePart before the product is changed so that it can be deleted and new list can be created for the new product selected
    FPartsId := Value;
    if loading then exit;
    with TProduct.FieldData(Value,'PartName,PartsDescription',self.Storer.Connection) do begin
      self.Caption := O['Fields'].S['PartName'];
      self.Description := O['Fields'].S['PartsDescription'];
      free;
    end;
    DoEvent(Self, evProductSelected);
    if self = rootnode then begin
      InitUOM('', Product);
    end else begin
      InitUOM('', Product);
      if mastertype <> mtProduct then begin
        AllocateAvailableQty;
      end;
    end;

    if Quantity = 0 then TreePartUOMQuantity := 0 else TreePartUOMQuantity := Quantity /TreePartUOMMultiplier;
    if TotalQty = 0 then TreePartUOMTotalQty := 0 else TreePartUOMTotalQty := TotalQty /TreePartUOMMultiplier;
    With TProduct.CreateWithNewConn(nil) do try
      load(Value);
      if count> 0 then begin
        fsPartCalcformula  :=PartCalcformula;
        //fdFormulaQtyValue  :=1;
        fdFormulaQtyValue1 :=FormulaQtyValue1;
        fdFormulaQtyValue2 :=FormulaQtyValue2;
        fdFormulaQtyValue3 :=FormulaQtyValue3;
        fdFormulaQtyValue4 :=FormulaQtyValue4;
        fdFormulaQtyValue5 :=FormulaQtyValue5;

        fiBuildLineNo   := BuildLineNo;
        fdBuildFormulaQtyValue1 :=BuildFormulaQtyValue1;
        fdBuildFormulaQtyValue2 :=BuildFormulaQtyValue2;
        fdBuildFormulaQtyValue3 :=BuildFormulaQtyValue3;
        fdBuildFormulaQtyValue4 :=BuildFormulaQtyValue4;
        fdBuildFormulaQtyValue5 :=BuildFormulaQtyValue5;

        fdOrderFormulaQtyValue1 :=OrderFormulaQtyValue1;
        fdOrderFormulaQtyValue2 :=OrderFormulaQtyValue2;
        fdOrderFormulaQtyValue3 :=OrderFormulaQtyValue3;
        fdOrderFormulaQtyValue4 :=OrderFormulaQtyValue4;
        fdOrderFormulaQtyValue5 :=OrderFormulaQtyValue5;
      end;
    finally
      connection.connection.Free;
      Free;
    end;
    MakeDirty;
  end;
end;
procedure TProcTreeNode.CalcTotalQty;
var
  obj: TProcTreeNode;
  qty: double;
  x: integer;
begin

  qty:= fQuantity;
  obj:= nil;
  if Assigned(owner) and (owner is TProcTreeNode) then
    obj:= TProcTreeNode(Owner);
  while Assigned(obj) do begin
    if (obj.InputType <> itOption) or (selected) then
      qty:= qty * obj.Quantity;
      {Binny - 'unallocated Bach Sales' when partially built, the total qty of the raw material is calculated wrong
      as its totalQty = Quantity * oner.Quantity
      insted of   totalQty = Quantity * oner.totalQty}
      //qty:= qty * obj.totalQty;
    if Assigned(obj.owner) and (obj.owner is TProcTreeNode) then
      obj:= TProcTreeNode(obj.Owner)
    else
      break;
  end;
  TotalQty:= qty;
  if Quantity = 0 then TreePartUOMQuantity := 0 else TreePartUOMQuantity := Quantity /TreePartUOMMultiplier;
  if TotalQty = 0 then TreePartUOMTotalQty := 0 else TreePartUOMTotalQty := TotalQty /TreePartUOMMultiplier;

  for x:= 0 to Children.Count -1 do begin
    TProcTreeNode(Children[x]).CalcTotalQty;
  end;
end;

function TProcTreeNode.SaveNoCheck: boolean;
var
  x: integer;
  ProcessPartIDs:String;
  SqlList: TStringList;
begin
  if isroot and not(Anydirty) then begin
    result := False;
    Exit;
  end;
  result:= inherited SaveNoCheck;
  if  istoremoveTree then
    DeleteTree ;
  if self.ProcessStepList.Count>0 then begin
    ProcessPartIDs := '';
    for x:= 0 to self.ProcessStepList.Count -1 do begin
      ProcessStepList[x].ProcTreeId:= ProcTreeId;
      ProcessStepList[x].PartId:= 0;
      ProcessStepList[x].IsTemplate:= IsTemplate;
      Storer.Save(ProcessStepList[x]);
      if ProcessStepList[x].Status =psComplete then
        result := updateProcessParttimesheet(ProcessStepList[x].Id);
      if ProcessPartIDs <> '' then ProcessPartIDs := ProcessPartIDs +','; ProcessPartIDs := ProcessPartIDs +inttostr(ProcessStepList[x].ID);
    end;

    if ProcessPartIDs <> '' then begin
      With TempMyquery(Storer.Connection) do try
         SQL.Add('Select DISTINCT ProcTreeID , Id from tblprocesspart  where ID in (' +  ProcessPartIDs+')');
         open;
         if recordcount > 0 then begin
           first;
           SqlList := TStringList.Create;
           try
             while Eof = False do begin
               SqlList.add('update tblprocesspartClean set ProcTreeID = ' +inttostr(Fieldbyname('ProcTreeID').asInteger) + '   where Id = ' + inttostr(Fieldbyname('ID').asInteger) +';');
               Next;
             end;
             if SqlList.count>0 then begin
              try
                ExecuteSQL(SqlList.Text, Storer.Connection);
              except
                on E:Exception do begin
                end;
              end;
             end;
           finally
             Freeandnil(SqlList);
           end;
         end;
      finally
        if active then close;
        free;
      end;
    end;

  end;
  if result then
    fCleanComplete:= Complete;
end;

function TProcTreeNode.GetSelectedChild: TProcTreeNode;
var
  x: integer;
begin
  result:= nil;
  if fInputType = itOption  then begin
    for x:= 0 to Children.Count -1 do begin
      if TProcTreeNode(Children[x]).Selected then begin
        result:= TProcTreeNode(Children[x]);
        break;
      end;
    end;
  end;
end;

function TProcTreeNode.GetProcessStepList: TProcessStepList;
var
  x: integer;
  SaveDirty: boolean;
begin
  if not Assigned(fProcessStepList) then begin
    fProcessStepList:= MakeProcesStepList;
    fProcessStepList.ItemClassName:= 'TProcessPartNDS';
    if self.Id > 0 then begin
      { Get steps linked to this node }
      fProcessStepList.LoadSql:=
        'SELECT * FROM `tblProcessPart` WHERE `ProcTreeID` = ' +
        IntToStr(self.ProcTreeId) + ' ORDER BY ProcessStepSeq';
      SaveDirty:= self.Dirty;
      try
        Storer.LoadList(fProcessStepList);
      finally
        self.Dirty:= SaveDirty;
      end;
    end else begin
      { Get any steps defined for product }
      if (self.PartsId > 0) then begin
        fProcessStepList.LoadSql:=
          'SELECT * FROM `tblProcessPart` WHERE `PartId` = ' +
          IntToStr(self.PartsId) +
          ' AND ProcTreeId IS NOT NULL AND IsTemplate = "T"' +
          ' ORDER BY ProcessStepSeq';
        Storer.LoadList(fProcessStepList);
        for x:= 0 to fProcessStepList.Count -1 do begin
          { Set Id's to zero so items will be saved as new records linked to this ProdTreeNode }
          fProcessStepList[x].Id:= 0;
          fProcessStepList[x].PartId:= 0;
        end;
      end;
    end;
  end;
  result:= fProcessStepList;
end;

procedure TProcTreeNode.SetProcessStepList(const Value: TProcessStepList);
begin
  if Assigned(fProcessStepList) then
    fProcessStepList.Free;
  fProcessStepList:= value;
end;

function TProcTreeNode.HasProcessSteps: boolean;
begin
  result:= ProcessStepList.Count > 0;
end;

procedure TProcTreeNode.InitWithZeroQty;
var
  x:Integer;
begin
  quantity:=0;
  TotalQtyOriginal := 0;
  TotalQty         := 0;
  FromStockQty     := 0;
  OnOrderQty       := 0;
  ManufactureQty   := 0;
  ManufacturedQty  := 0;
  ManufacturingQty := 0;
  for x:= 0 to fProcessStepList.Count -1 do begin
      fProcessStepList[x].Duration := 0;
      fProcessStepList[x].SetupDuration:=0;
      fProcessStepList[x].BreakdownDuration:=0;
  end;
  for x:= 0 to Children.Count -1 do
    TProcTreeNode(Children[x]).InitWithZeroQty;
end;

function TProcTreeNode.IsEqual(node: TProcTreeNode): boolean;
begin
  result := self.ProcessStepList.IsEqual(node.ProcessStepList);
  if not result then exit;

  if (self.InputType <> node.InputType) or
     (self.SubBOMProcessOrderCode <> node.SubBOMProcessOrderCode) or
     (self.PartSource <> node.PartSource) or
//     (self.ProcTreeID <> node.ProcTreeId) or
     (self.Caption <> node.Caption) or
     (self.Description <> node.Description) or
     (self.Details <> node.Details) or
     (self.Info <> node.Info) or
     (self.Comments <> node.comments) or
     (self.PartsId <> node.PartsID) or
     (self.TreePartUOM <> node.TreePartUOM) or
//     (self.TreePartUOMID <> node.TreePartUOMID) or
     (self.TreePartUOMMultiplier <> node.TreePartUOMMultiplier) or
     (self.TreePartUOMQuantity <> node.TreePartUOMQuantity) or
     (self.TreePartUOMTotalQty <> node.TreePartUOMTotalQty) or
     (self.TotalQtyOriginal <> node.TotalQtyOriginal) or
     (self.QtyOriginal <> node.QtyOriginal) or
     (self.FromStockUOMQty <> node.FromStockUOMQty) or
     (self.ManufactureUOMQty <> node.ManufactureUOMQty) or
     (self.ManufacturedUOMQty <> node.ManufacturedUOMQty) or
     (self.ManufacturingUOMQty <> node.ManufacturingUOMQty) or
     (self.OnOrderUOMQty <> node.OnOrderUOMQty) or
     (self.FromStockQty <> node.FromStockQty) or
     (self.ManufactureQty <> node.ManufactureQty) or
     (self.ManufacturedQty <> node.ManufacturedQty) or
     (self.ManufacturingQty <> node.ManufacturingQty) or
     (self.OnOrderQty <> node.OnOrderQty) or
//     (self.SaleLineId <> node.SaleLineId) or
     (self.ClassId <> node.ClassId) or
//     (self.PurchaseLineId <> node.PurchaseLineId) or
     (self.IsTemplate <> node.IsTemplate) or
     (self.Quantity <> node.Quantity) or
     (self.QtyFor1UOMParent <> node.QtyFor1UOMParent) or
     (self.QtyForUOMParent <> node.QtyForUOMParent) or
     (self.QtyPer <> node.QtyPer) or
     (self.TotalQty <> node.TotalQty) or
     (self.HideOnPrint <> node.HideOnPrint) or
     (self.AddToSale <> node.AddToSale) or
//     (self.LinkedLineId <> node.LinkedLineId) or
     (self.CustomInputClass <> node.CustomInputClass) or
//     (self.TreePricechanged <> node.TreePricechanged) or
     (self.MakeCoupons <> node.MakeCoupons) or
     (self.CouponLabelPrinted <> node.CouponLabelPrinted) or
     (self.Price <> node.Price) or
     (self.ProductUnitPrice <> node.ProductUnitPrice) or
     (self.ProductUnitCost <> node.ProductUnitCost) or
     (self.MatrixPrice <> node.MatrixPrice) or
     (self.MatrixDesc <> node.MatrixDesc) or
     (self.MatrixREf <> node.MatrixREf) or
//     (self.Cost <> node.Cost) or
//     (self.Selected <> node.Selected) or
     (self.Value <> node.Value) or
     (self.Complete <> node.Complete) or
     (self.QtyVariation <> node.QtyVariation) or
     (self.QtyPerCoupon <> node.QtyPerCoupon) or
     (self.RatePercoupon <> node.RatePercoupon) or
     (self.ZeroWhenLessthan1 <> node.ZeroWhenLessthan1) or
     (self.RoundtoNextNumber <> node.RoundtoNextNumber) or
     (self.RoundtoPrevNumber <> node.RoundtoPrevNumber) or
     (self.Formulaid <> node.Formulaid) or
     (self.FormulaQtyValue <> node.FormulaQtyValue) or
     (self.FormulaQtyValue1 <> node.FormulaQtyValue1) or
     (self.FormulaQtyValue2 <> node.FormulaQtyValue2) or
     (self.FormulaQtyValue3 <> node.FormulaQtyValue3) or
     (self.FormulaQtyValue4 <> node.FormulaQtyValue4) or
     (self.FormulaQtyValue5 <> node.FormulaQtyValue5) or
     (self.BuildLineNo <> node.BuildLineNo) or
     (self.BuildFormulaQtyValue <> node.BuildFormulaQtyValue) or
     (self.BuildFormulaQtyValue1 <> node.BuildFormulaQtyValue1) or
     (self.BuildFormulaQtyValue2 <> node.BuildFormulaQtyValue2) or
     (self.BuildFormulaQtyValue3 <> node.BuildFormulaQtyValue3) or
     (self.BuildFormulaQtyValue4 <> node.BuildFormulaQtyValue4) or
     (self.BuildFormulaQtyValue5 <> node.BuildFormulaQtyValue5) or
     (self.OrderFormulaQtyValue <> node.OrderFormulaQtyValue) or
     (self.OrderFormulaQtyValue1 <> node.OrderFormulaQtyValue1) or
     (self.OrderFormulaQtyValue2 <> node.OrderFormulaQtyValue2) or
     (self.OrderFormulaQtyValue3 <> node.OrderFormulaQtyValue3) or
     (self.OrderFormulaQtyValue4 <> node.OrderFormulaQtyValue4) or
     (self.OrderFormulaQtyValue5 <> node.OrderFormulaQtyValue5) or
     (self.IgnoreItemCommentsforDescription <> node.IgnoreItemCommentsforDescription)
//     (self.InheritFromID <> node.InheritFromID) or
//     (self.InheritFromEditVersion <> node.InheritFromEditVersion) or
  then
    result := false;
end;

function TProcTreeNode.isInternalOrder: boolean;
begin
  REsult := false;
end;
Function TProcTreeNode.ProcessStepExtraInfoList:String;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to ProcessStepList.Count -1 do begin
    if x > 0 then
      result:= result + ', ';
    result:= result + ProcessStepList[x].ProcessStepExtraInfo;
  end;
end;

function TProcTreeNode.ProcessStepDescList: string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to ProcessStepList.Count -1 do begin
    if x > 0 then
      result:= result + ', ';
    result:= result + ProcessStepList[x].ProcessStepDescription;
  end;
end;


procedure TProcTreeNode.AfterSave;
begin
 inherited;
 {Ian/Binny: Was causing Lockwait time out:
 Proctreepart is created only from salestransaction and the tree is not
 editable in the sales transaction. So there will not be any record in tblProcessPart
 to be deleted as records in this table in sales is static.}
end;

procedure TProcTreeNode.ClearAllCosts;
var
  x: integer;
begin
  for x := 0 to Children.Count -1 do
    TProcTreeNode(Children[x]).ClearAllCosts;
  Cost := 0;
end;

procedure TProcTreeNode.ClearIds;
var
  x: integer;
begin
  { clear id's so a new copy is saved }
  for x:= 0 to ProcessStepList.Count -1 do begin
    ProcessStepList[x].Id:= 0;
    ProcessStepList[x].ProcTreeId:= 0;
  end;
  MakeDirty;
  inherited;
end;

procedure TProcTreeNode.ProcessStatus(var ProcessPartStatusList: TProcessPartStatusList);
var
  x: integer;
begin

  if Assigned(ProcessStepList) then
    if ManufactureQty <> 0 then
      ProcessStepList.ProcessStatus(ProcessPartStatusList);
  for x:= 0 to Children.Count -1 do begin
    TProcTreeNode(Children[x]).ProcessStatus(ProcessPartStatusList);
  end;
end;

function TProcTreeNode.StatusList: TProcessPartStatusList;
begin
  result:= [];
  self.ProcessStatus(result);
end;

procedure TProcTreeNode.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;


procedure TProcTreeNode.LoadTree(const SubTreeOnly: boolean; PartsourceStock: Boolean);
begin
  inherited;
  CalcPrice(true,true,true);
end;

function TProcTreeNode.Locate(aParentCaption, aTreeCaption: String;  var node: TProcTreeNode): boolean;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  result:= False;
  if sametext(ParentCaption  , aParentCaption ) and sametext(caption , aTreeCaption) then begin
    REsult:= true;
    node := self;
    exit;
  end;
  if Children.count >0 then begin
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := Child.Locate(aParentCaption,aTreeCaption ,  node);
      if result then exit;
    end;
  end;
end;
function TProcTreeNode.Locate(aParentCaption, aTreeCaption: String;qty1,qty2,qty3,qty4,qty5:Double;  var node: TProcTreeNode): boolean;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  result:= False;
  if sametext(ParentCaption  , aParentCaption ) and sametext(caption , aTreeCaption) and
          (Samevalue(FormulaQtyValue1 ,Qty1,0))  and
          (Samevalue(FormulaQtyValue2 ,Qty2,0))  and
          (Samevalue(FormulaQtyValue3 ,Qty3,0))  and
          (Samevalue(FormulaQtyValue4 ,Qty4,0))  and
          (Samevalue(FormulaQtyValue5 ,Qty5,0))  then begin
    REsult:= true;
    node := self;
    exit;
  end;
  if Children.count >0 then begin
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := Child.Locate(aParentCaption,aTreeCaption , Qty1,Qty2,Qty3,Qty4,Qty5, node);
      if result then exit;
    end;
  end;

end;

function TProcTreeNode.Locate(TreeID: Integer;  var node: TProcTreeNode): boolean;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  result:= False;
  if ProctreeId = treeid then begin
    REsult:= true;
    node := self;
    exit;
  end;
  if Children.count >0 then begin
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := Child.Locate(TreeID, node);
      if result then exit;
    end;
  end;
end;

procedure TProcTreeNode.SaveToXMLNode(const node: IXMLNode);
var
  ProcStepsNode: IXMLNode;
  x: integer;
begin
  inherited;
  ProcStepsNode:= node.AddChild('ProcessSteps');
  for x:= 0 to self.ProcessStepList.Count -1 do
    self.ProcessStepList[x].SaveToXMLNode(ProcStepsNode.AddChild(ProcessStepList[x].XMLNodeName));
end;

procedure TProcTreeNode.CalcchildQty(const SkipCustom: boolean = true);
var
  x: integer;
  sumchildrenQty: double;
  child: TProcTreeNode;
begin
  childrenQty:= 0;

  if (SkipCustom and (self.InputType = itCustom)) or self.AddToSale or
  (Assigned(Owner) and (Owner is TProcTreeNode) and (TProcTreeNode(Owner).AddToSale)) then
    exit;
  sumchildrenQty:= 0;
  for x:= 0 to Children.Count -1 do begin
    child:= TProcTreeNode(Children[x]);
    if InputType = itOption then begin
      if child.Selected then begin
        child.CalcchildQty;
        SumChildrenQty:= SumChildrenQty + child.ChildrenQty;
        break;
      end;
    end
    else begin
      child.CalcchildQty;
      SumChildrenQty:= SumChildrenQty + child.ChildrenQty;
    end;
  end;

  if ((Children.Count > 0) and ((SumChildrenQty <> 0) )) or (self.IsRoot )  then begin
    ChildrenQty:= Round(SumChildrenQty, GeneralRoundPlaces);
  end
  else begin
      if Children.Count =0 then
        if PArtsID>0 then ChildrenQty := TotalQty
        else ChildrenQty := 0;
  end;
end;
function TProcTreeNode.CostDetails:String;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  if Children.count >0 then begin
    Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr('') +',' +Quotedstr('')+',' +Quotedstr('');
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := result + NL +  Child.CostDetails;
    end;
  end else begin
    if PartsID>0 then
      Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr(TreePartUOM +' (' + floatTostr(TreePartUOMMultiplier) +')') +',' +floatTostr(TreePartUOMTotalQty)+',' +floatTostr(Cost)
    else
      Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr('') +',' +floatTostr(TreePartUOMTotalQty)+',' +floatTostr(Cost);
  end;
end;
function TProcTreeNode.CostIncLabourDetails:String;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  if Children.count >0 then begin
    Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr('') +',' +floatTostr(TreePartUOMTotalQty)+',' +Quotedstr('')+',' + floatTostr(ProcesstepPrice) +',' +floatTostr(ProcesstepPrice);
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := result + NL +  Child.CostIncLabourDetails;
    end;
  end else begin
    if PartsID>0 then
      Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr(TreePartUOM +' (' + floatTostr(TreePartUOMMultiplier) +')') +',' +floatTostr(TreePartUOMTotalQty)+',' +floatTostr(Cost)+',' + floatTostr(ProcesstepPrice) +',' +floatTostr(CostIncLabour)
    else
      Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr('') +',' +floatTostr(TreePartUOMTotalQty)+',' +floatTostr(Cost)+',' + floatTostr(ProcesstepPrice) +',' +floatTostr(CostIncLabour);
  end;
end;

function TProcTreeNode.PriceDetails:String;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  if Children.count >0 then begin
    Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr('') +',' +floatTostr(TreePartUOMTotalQty)+',' +Quotedstr('')+',' + floatTostr(ProcesstepPrice)+',' + floatTostr(ProcesstepPrice);
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := result + NL +  Child.PriceDetails;
    end;
  end else begin
    if PartsID>0 then
      Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr(TreePartUOM +' (' + floatTostr(TreePartUOMMultiplier) +')') +',' +floatTostr(TreePartUOMTotalQty)+',' +floatTostr(PriceExLabour)+',' + floatTostr(ProcesstepPrice)+',' + floatTostr(Price)
    else
      Result:= Quotedstr(CaptionIntended) + ',' +Quotedstr('') +',' +floatTostr(TreePartUOMTotalQty)+',' +QuotedStr('')+',' + floatTostr(ProcesstepPrice)+ ',' + floatTostr(ProcesstepPrice);
  end;
end;


function TProcTreeNode.TotalQtyDetails:String;
var
  ctr:Integer;
  child: TProcTreeNode;
begin
  Result:= '';
  if Children.count >0 then begin
    Result:= Quotedstr(CaptionIntended) + ',  ';
    for ctr:= 0 to children.count -1 do begin
      child:= TProcTreeNode(Children[ctr]);
      result := result + NL +  Child.TotalQtyDetails;
    end;
  end else begin
      if Children.Count =0 then
        if PartsID>0 then
          Result:= Quotedstr(CaptionIntended) + ',' + FloatTostr(TotalQty)
        else
          Result:= Quotedstr(CaptionIntended)+ ','+'';
  end;
end;
procedure TProcTreeNode.CalcPrice(const SkipCustom: boolean = true; Recalccost :Boolean = True;forceRecalc:Boolean =False);
var
  x: integer;
  SumCost, SumCostIncLabour, SumPrice, sumchildrenQty: double;
  child: TProcTreeNode;
  fdProcesstepPrice:double;
  RetPriceEx, RetDiscountPercent:Double;
  RetDesc, RetMsg:String;
begin
  if isroot and not(Anydirty) and not(forceRecalc) then exit;
  PriceExLabour := 0;
  CostIncLabour:= 0;
  Price:=0;
  childrenQty:= 0;
  if IgnoreItemCommentsforDescription = false then fsSelectedInfos := info else fsSelectedInfos := '';
  if self = rootnode then fsAllInfos := '' else fsAllInfos := info;

  if (SkipCustom and (self.InputType = itCustom)) or self.AddToSale or
  (Assigned(Owner) and (Owner is TProcTreeNode) and (TProcTreeNode(Owner).AddToSale)) then
    exit;
  {get children to ReCalc then
    total up price and cost from child nodes}
  SumCost:= 0;
  SumCostIncLabour := 0;
  SumPrice:= 0;
  sumchildrenQty:= 0;
  if (self = rootnode) and (Mastertype = mtProduct)  then begin
    updateprice;
  end;

  for x:= 0 to Children.Count -1 do begin
    child:= TProcTreeNode(Children[x]);
    if InputType = itOption then begin
      if child.Selected then begin
        child.CalcPrice(true , Recalccost);
        SumCost:= SumCost + Round((child.Cost * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
        SumCostIncLabour:= SumCostIncLabour + Round((child.CostIncLabour * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
        SumPrice:= SumPrice + Round((child.Price * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
        SumChildrenQty:= SumChildrenQty + Round((child.ChildrenQty * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
        if child.IgnoreItemCommentsforDescription = false then fsSelectedInfos := fsSelectedInfos +' '+ NL + Child.info;
        fsAllInfos := fsAllInfos +' '+ NL + Child.info;

        break;
      end;
    end
    else begin
      child.CalcPrice(true , Recalccost);
      SumCost:= SumCost + Round((child.Cost * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
      SumCostIncLabour:= SumCostIncLabour + Round((child.CostIncLabour * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
      SumPrice:= SumPrice + Round((child.Price * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
      SumChildrenQty:= SumChildrenQty + Round((child.ChildrenQty * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
      if child.IgnoreItemCommentsforDescription = false then fsSelectedInfos := fsSelectedInfos +' '+ NL + Child.info;
      fsAllInfos := fsAllInfos +' '+ NL + Child.info;

    end;
  end;

  if ((Children.Count > 0) and ((SumPrice <> 0) or (SumCost <> 0) or (PartsId = 0))) or (self.IsRoot )  then begin
    Cost:= Round(SumCost, GeneralRoundPlaces);
    CostIncLabour :=Round(SumCostIncLabour, GeneralRoundPlaces);
    Price:= Round(SumPrice, GeneralRoundPlaces);
    ChildrenQty:= Round(SumChildrenQty, GeneralRoundPlaces);
    ProductUnitCost  := divZer(Cost ,  Quantity);
    ProductUnitPrice := divZer(Price ,  Quantity);

  end else begin
    if Children.Count =0 then ChildrenQty := TotalQty;
    if (Children.Count >0) or Recalccost or ((cost =0) and (totalQty >0) ) then  begin
        if self.PartsId > 0 then begin
          {product template each time edited shoudl recalculate the price and cost}
          if (ProductUnitPrice = 0) or((mastertype = mtProduct) and (TreePricechanged=False)) then begin ProductUnitPrice := Round(TProduct.PriceForQty(PartsId, Quantity, self.Storer.Connection),GeneralRoundPlaces); TreePricechanged := False; end;
          if (productunitcost  = 0) or((mastertype = mtProduct) and (TreePricechanged=False)) then productunitcost  := Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces);

          if (self is TSalesLineProcTree) and ((ProductUnitPrice = 0) or((mastertype <> mtProduct) and (TreePricechanged=False))) then begin
            if ObjClientDiscount.ClientPrice_Discounts(TSalesLineProcTree(Self).Sales.ClientID,TSalesLineProcTree(Self).Sales.TermsName, TSalesLineProcTree(Self).PartsID, TSalesLineProcTree(Self).TreepartUOMID,
                                                      TSalesLineProcTree(Self).Sales.SaleClassId,TSalesLineProcTree(Self).TotalQty, TSalesLineProcTree(Self).Sales.SaleDate,
                                                      TSalesLineProcTree(Self).Sales.UseWholesalePrice, RetPriceEx, RetDiscountPercent, RetDesc, RetMsg, True, ''    ) then begin
               ProductUnitPrice :=RetPriceEx - (RetPriceEx*RetDiscountPercent);
               if RetDesc <> '' then Info := trim(info + NL + RetDesc +'.  ' + RetMsg);
            end;
          end;

          if ProductUnitCost <> 0 then
            cost := ProductUnitCost*Quantity;
        {Binny
        Balancesheet.inventoryAsset was not matching with the Productlist.total of Stock Value as the posting was done on the wrong cost.
        cost of the building product should be calculated from the avg cost of the individual product - not the cost for Quantity}
          if math.IsZero(Cost,0.000001) then
            Cost := Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces)*Quantity;
        { if average cost is 0 then use cost1 i.e. if it is a new product that
          has not been purchased yet to calc average }
          if math.IsZero(Cost,0.000001) then
            Cost:= Round(TProduct.Cost(PartsId, self.Storer.Connection),GeneralRoundPlaces)*Quantity;

          if   fdMatrixPrice<> 0 then begin
            Price :=   fdMatrixPrice;
            //TreePricechanged := false;
          end else if   ProductUnitPrice <> 0 then begin
            Price := ProductUnitPrice*Quantity;
            //TreePricechanged := false;
          end else begin
            Price:= Round(TProduct.PriceForQty(PartsId, Quantity, self.Storer.Connection),GeneralRoundPlaces)*Quantity;{Price for 1 UNITS fo parent}
            //TreePricechanged := false;
          end;
        CostIncLabour := Cost;
      end;
      if ProductUnitCost  =0  then ProductUnitCost  := divZer(Cost ,  Quantity);
      if ProductUnitPrice =0  then ProductUnitPrice := divZer(Price ,  Quantity);
    end else begin
    end;
  end;

  PriceExLabour     := PriceExLabour +Price;
  fdProcesstepPrice := ProcesstepPrice;
  Price             := Price + fdProcesstepPrice;
  CostIncLabour     := CostIncLabour +fdProcesstepPrice;
  if self = rootnode then begin
    Cost := round(cost , tcConst.GeneralRoundPlaces);
    Price := round(Price , tcConst.GeneralRoundPlaces);
  end;

end;
procedure TProcTreeNode.CalcCost(const SkipCustom: boolean = true);
var
  x: integer;
  SumCost: double;
  child: TProcTreeNode;
begin
if isroot and not(Anydirty) then exit;
{NOTE: THIS IS USED FOR VERIFY N FIX ONLY
THIS FUNCTION IS USED TO RECALCULATE THE COST BASED ON THE USED 'PRODUCT'S COST1 INSTEAD OF AVG COST'
THIS SHOULD NOT BE CALLED FROM THE NORMAL TRANSACTIONS AS THE NORMAL TRANSACTIONS SHOULD USE AVG COST
binny}
  if (SkipCustom and (self.InputType = itCustom)) or self.AddToSale or
  (Assigned(Owner) and (Owner is TProcTreeNode) and (TProcTreeNode(Owner).AddToSale)) then
    exit;
  {get children to ReCalc then
    total up price and cost from child nodes}
  SumCost:= 0;
  for x:= 0 to Children.Count -1 do begin
    child:= TProcTreeNode(Children[x]);
    if InputType = itOption then begin
      if child.Selected then begin
        child.CalcCost;
        SumCost:= SumCost + Round((child.Cost * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
        break;
      end;
    end
    else begin
      child.CalcCost;
      SumCost:= SumCost + Round((child.Cost * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
    end;
  end;

  if ((Children.Count > 0) and ((SumCost <> 0) or (PartsId = 0))) or (self.IsRoot )  then begin
    Cost:= Round(SumCost, GeneralRoundPlaces);
  end
  else if self.PartsId > 0 then begin
    if productunitcost  = 0 then productunitcost  := Round(TProduct.Cost(PartsId, self.Storer.Connection),GeneralRoundPlaces);//Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces);

    if ProductUnitCost <> 0 then
      cost := ProductUnitCost*Quantity;
    {Binny
    Balancesheet.inventoryAsset was not matching with the Productlist.total of Stock Value as the posting was done on the wrong cost.
    cost of the building product should be calculated from the avg cost of the individual product - not the cost for Quantity}
    if math.IsZero(Cost,0.000001) then
      Cost := Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces)*Quantity;
    { if average cost is 0 then use cost1 i.e. if it is a new product that
      has not been purchased yet to calc average }
    if math.IsZero(Cost,0.000001) then
      Cost:= Round(TProduct.Cost(PartsId, self.Storer.Connection),GeneralRoundPlaces)*Quantity;
  end;
end;


procedure TProcTreeNode.undoCalcCost(const SkipCustom: boolean = true);
var
  x: integer;
  SumCost: double;
  child: TProcTreeNode;
  fdCost:Double;
begin

{NOTE: THIS IS USED FOR VERIFY N FIX ONLY
THIS FUNCTION IS USED TO GET THE COST FROM ERPPFIX TABLE OF PROCTREE
binny}
  if (SkipCustom and (self.InputType = itCustom)) or self.AddToSale or
  (Assigned(Owner) and (Owner is TProcTreeNode) and (TProcTreeNode(Owner).AddToSale)) then
    exit;
  {get children to ReCalc then
    total up price and cost from child nodes}
  SumCost:= 0;
  for x:= 0 to Children.Count -1 do begin
    child:= TProcTreeNode(Children[x]);
    if InputType = itOption then begin
      if child.Selected then begin
        child.UndoCalcCost;
        SumCost:= SumCost + Round((child.Cost * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
        break;
      end;
    end
    else begin
      child.UndoCalcCost;
      SumCost:= SumCost + Round((child.Cost * TreePartUOMQuantity*TreePartUOMMultiplier),GeneralRoundPlaces);
    end;
  end;

  if ((Children.Count > 0) and ((SumCost <> 0) or (PartsId = 0))) or (self.IsRoot )  then begin
    Cost:= Round(SumCost, GeneralRoundPlaces);
  end else if self.PartsId > 0 then begin
    fdCost:=ERPFixSLCost(ProctreeID);
    if fdCost <> 0 then cost := fdCost
    else begin
      if productunitcost  = 0 then productunitcost  := Round(TProduct.Cost(PartsId, self.Storer.Connection),GeneralRoundPlaces);//Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces);
      if ProductUnitCost <> 0 then
        cost := ProductUnitCost*Quantity;
      {Binny
      Balancesheet.inventoryAsset was not matching with the Productlist.total of Stock Value as the posting was done on the wrong cost.
      cost of the building product should be calculated from the avg cost of the individual product - not the cost for Quantity}
      if math.IsZero(Cost,0.000001) then
        Cost := Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces)*Quantity;
      { if average cost is 0 then use cost1 i.e. if it is a new product that
        has not been purchased yet to calc average }
      if math.IsZero(Cost,0.000001) then
        Cost:= Round(TProduct.Cost(PartsId, self.Storer.Connection),GeneralRoundPlaces)*Quantity;
    end;
  end;
end;
(*procedure TProcTreeNode.UpdateDefaultQty;
begin
  // only applicable for sales
end;*)

Function  TProcTreeNode.ERPFixSLCost(const xProctreeID:Integer):double;
begin
  With TempMyquery do try
    SQl.add('Select Cost from  erpfix_proctree where proctreeId = ' +inttoStr(xProctreeID));
    open;
    result:= Fieldbyname('cost').AsFloat;
  finally
    closenfree;
  end;
end;
Function  TProcTreeNode.ProcesstepPrice:Double;
var
  x:Integer;
  amt:Double;
  function SecToHour(Seconds:double):Double;
  begin
    if  Seconds = 0 then Result := 0
    else result := Seconds/60/60;
  end;
  Function IfZeroQty(const Value:Double;ValueifZero:Double):Double;
  begin
    if  value = 0 then result :=  ValueifZero else result := value;
  end;
begin
  result := 0;

  for x:= 0 to self.ProcessStepList.Count -1 do begin
    if (self = rootnode) and (Mastertype = mtSalesOrder) then Amt := IfZeroQty(totalQty,1) else Amt := IfZeroQty(TreePartUOMQuantity,1);
    Amt := amt *(ProcessStepList[x].HourlyLabourRate*
            (SecToHour(ProcessStepList[x].Duration)  +SecToHour(ProcessStepList[x].SetupDuration) + SecToHour(ProcessStepList[x].BreakdownDuration) ));
    Result := Result + Amt;
  end;
end;
procedure TProcTreeNode.BuildDetails;
var
  x: integer;
begin
  { construct details field from child nodes }
  if Description = '' then
    Details:= '[' + LevelStr + ']  ' + FloatToStr(Quantity) + ' x ' + Caption
  else
    Details:= '[' + LevelStr + ']  ' + FloatToStr(Quantity) + ' x ' + Caption + ' (' + Description + ')';
  if InputType <> itCustom then begin
    for x:= 0 to Children.Count -1 do begin
      if (InputType <> itOption) or ((InputType = itOption) and (TProcTreeNode(Children[x]).Quantity = 1)) then begin
        TProcTreeNode(Children[x]).BuildDetails;
        Details:= Details + #13#10 + TProcTreeNode(Children[x]).Details;
      end;
    end;
  end;
end;


function TProcTreeNode.ValidateData: boolean;
var
  list: string;
begin
  result:= inherited ValidateData;
  if result and self.IsTemplate and self.IsRoot then begin
    if ProcessDataUtils.HasProcessSteps(self) = False then begin
      result:= false;
      ResultStatus.Clear;
      ResultStatus.AddItem(false,rssInfo,0,'The top line must have at least one process step defined for it.', true);
      exit;
    end else if ProcessDataUtils.ProcTreeHasProcesses(self) then begin
      if ProcessDataUtils.ProcTreePartsWithoutProcess(self, list) then begin
        result:= false;
        ResultStatus.Clear;
        ResultStatus.AddItem(false,rssInfo,0,'The following part(s) must have at least one process step defined for them: ' + CRLF +
          list, true);
        exit;
      end  else  if ProcTreeProcessesWithotQuantity(nil, self, list) then begin
        result:= false;
        ResultStatus.Clear;
        ResultStatus.AddItem(false,rssInfo,0,'The following part(s) have process steps and can not have a quantity of zero: ' + CRLF +
          list, true);
        exit;
      end;
    end;
    if ProductNodeHasProducts(self) then begin
      result:= false;
      ResultStatus.AddItem(false,rssInfo,0,'One or more items in the tree are inventory parts and have a sub part that is also an inventory part, this is not allowed');
    end;
  end
end;

function TProcTreeNode.GetParentNode: TProcTreeNode;
begin
  result := nil;
  if Self = Rootnode then exit;
  result:= TProcTreeNode(Owner);
end;


procedure TProcTreeNode.Assign(Source: TPersistent);
var
  x: integer;
  PP: TProcessPartNDS;
begin
  inherited;
  if ISCleanTree then fProctreeID:=TProcTreeNode(Source).ProcTreeId;
  fCaption:= TProcTreeNode(Source).Caption;
  fDescription:= TProcTreeNode(Source).Description;
  fDetails:= TProcTreeNode(Source).Details;
  //fPrice:= TProcTreeNode(Source).Price;
  fPriceExLabour:= TProcTreeNode(Source).PriceExLabour;
  fCostIncLabour:= TProcTreeNode(Source).CostIncLabour;
  //fCost:= TProcTreeNode(Source).Cost;
  fSelected:= TProcTreeNode(Source).Selected;
  fQuantity:= TProcTreeNode(Source).Quantity;
  FTotalQty:= TProcTreeNode(Source).TotalQty;
  FQtyPer:= TProcTreeNode(Source).QtyPer;
  fsPartCalcformula := TProcTreenode(Source).fsPartCalcformula;
  fZeroWhenLessthan1:= TProcTreeNode(Source).ZeroWhenLessthan1;
  fRoundtoNextNumber:= TProcTreeNode(Source).RoundtoNextNumber;
  fRoundtoPrevNumber:= TProcTreeNode(Source).RoundtoPrevNumber;

  fiFormulaId :=TProcTreeNode(Source).FormulaId;

  fdFormulaQtyValue:= TProcTreeNode(Source).fdFormulaQtyValue;
  fdFormulaQtyValue1:= TProcTreeNode(Source).fdFormulaQtyValue1;
  fdFormulaQtyValue2:= TProcTreeNode(Source).fdFormulaQtyValue2;
  fdFormulaQtyValue3:= TProcTreeNode(Source).fdFormulaQtyValue3;
  fdFormulaQtyValue4:= TProcTreeNode(Source).fdFormulaQtyValue4;
  fdFormulaQtyValue5:= TProcTreeNode(Source).fdFormulaQtyValue5;

  fiBuildLineNo := TProcTreeNode(Source).fiBuildLineNo;
  fdBuildFormulaQtyValue:= TProcTreeNode(Source).fdBuildFormulaQtyValue;
  fdBuildFormulaQtyValue1:= TProcTreeNode(Source).fdBuildFormulaQtyValue1;
  fdBuildFormulaQtyValue2:= TProcTreeNode(Source).fdBuildFormulaQtyValue2;
  fdBuildFormulaQtyValue3:= TProcTreeNode(Source).fdBuildFormulaQtyValue3;
  fdBuildFormulaQtyValue4:= TProcTreeNode(Source).fdBuildFormulaQtyValue4;
  fdBuildFormulaQtyValue5:= TProcTreeNode(Source).fdBuildFormulaQtyValue5;


  fdOrderFormulaQtyValue:= TProcTreeNode(Source).fdOrderFormulaQtyValue;
  fdOrderFormulaQtyValue1:= TProcTreeNode(Source).fdOrderFormulaQtyValue1;
  fdOrderFormulaQtyValue2:= TProcTreeNode(Source).fdOrderFormulaQtyValue2;
  fdOrderFormulaQtyValue3:= TProcTreeNode(Source).fdOrderFormulaQtyValue3;
  fdOrderFormulaQtyValue4:= TProcTreeNode(Source).fdOrderFormulaQtyValue4;
  fdOrderFormulaQtyValue5:= TProcTreeNode(Source).fdOrderFormulaQtyValue5;

  fsTreePartUOM:= TProcTreeNode(Source).TreePartUOM;
  fiTreePartUOMID:= TProcTreeNode(Source).TreePartUOMID;
  fdTreePartUOMMultiplier:= TProcTreeNode(Source).TreePartUOMMultiplier;
  fdTreePartUOMQuantity:= TProcTreeNode(Source).TreePartUOMQuantity;
  fdTreePartUOMTotalQty:= TProcTreeNode(Source).TreePartUOMTotalQty;
  fdTotalQtyOriginal :=TProcTreeNode(Source).TotalQtyOriginal;
  fdQtyOriginal :=TProcTreeNode(Source).QtyOriginal;
  fdFromStockUOMQty:= TProcTreeNode(Source).FromStockUOMQty;
  fdManufactureUOMQty:= TProcTreeNode(Source).ManufactureUOMQty;
  fdOnOrderUOMQty:= TProcTreeNode(Source).OnOrderUOMQty;

  if IsTemplate then begin
    fInheritFromID:= TProcTreeNode(Source).InheritFromID;
    fInheritFromEditVersion:= TProcTreeNode(Source).InheritFromEditVersion;
  end;

  fPurchaseLineId:= TProcTreeNode(Source).PurchaseLineId;
  fSaleLineId:= TProcTreeNode(Source).SaleLineId;
  fPartsId:= TProcTreeNode(Source).PartsId;
  fHideOnPrint:= TProcTreeNode(Source).HideOnPrint;
  fPartSource:= TProcTreeNode(Source).PartSource;
  fIsTemplate:= TProcTreeNode(Source).IsTemplate;
  fInputType:= TProcTreeNode(Source).InputType;
  fSubBOMProcessOrder:= TProcTreeNode(Source).SubBOMProcessOrder;
  fCustomInputClass:= TProcTreeNode(Source).CustomInputClass;
  fTreePricechanged := TProcTreeNode(Source).TreePricechanged;
  fMakeCoupons := TProcTreeNode(Source).MakeCoupons;
  fCouponLabelPrinted := TProcTreeNode(Source).CouponLabelPrinted;
  fValue:= TProcTreeNode(Source).Value;
  fAddToSale:= TProcTreeNode(Source).AddToSale;
  fComplete:= TProcTreeNode(Source).Complete;
  //Logtext(CaptionIntended +':' +BooleanToStr(fComplete));
  fQtyPerCoupon := TProcTreeNode(Source).QtyPerCoupon;
  fRAtePercoupon:= TProcTreeNode(Source).RAtePercoupon;
  ProductUnitPrice := TProcTreeNode(Source).ProductUnitPrice;
  ProductUnitCost  := TProcTreeNode(Source).ProductUnitCost;
  Price:=  ProductUnitPrice*Quantity;
  Cost :=  ProductUnitCost *Quantity;
  Info :=  TProcTreeNode(Source).Info;
  comments:=  TProcTreeNode(Source).comments;
  BuildLineNo := TProcTreeNode(Source).BuildLineNo;
  for x:= 0 to TProcTreeNode(Source).ProcessStepList.Count -1 do begin
    pp:= ProcessStepList.AddProcessPart;
    pp.Assign(TProcTreeNode(Source).ProcessStepList.Item[x]);
  end;
  fIgnoreItemCommentsforDescription:= TProcTreeNode(Source).IgnoreItemCommentsforDescription;
end;

function TProcTreeNode.GetChildNode(const Name: string): TProcTreeNode;
var
  Index: Integer;
begin
  Index := 0;

  while (Index < Children.Count) and (not Sysutils.SameText(Name, TProcTreeNode(Children[Index]).Caption)) do
    Inc(Index);

  if Index < Children.Count then
    Result := TProcTreeNode(Children[Index])
  else
    Result := nil;
end;

function TProcTreeNode.getclasssID: Integer;
begin
  Result := 0;
end;

function TProcTreeNode.IsOptionNode: boolean;
begin
  result:= Assigned(ParentNode) and (ParentNode.InputType = itOption);
end;

function TProcTreeNode.istoremoveTree: Boolean;
begin
  REsult := (mastertype <> mtProduct) and (not(IsManufacuring));
end;

procedure TProcTreeNode.DeleteNoCheck;
var x: integer;
begin
  if Assigned(ProcessStepList) then begin
    for x:= 0 to fProcessStepList.Count -1 do begin
      fProcessStepList[x].Delete;
    end
  end;
  inherited;
end;
procedure TProcTreeNode.Deletetree;
var
  s:String;
  ProcTreeIds, processpartIDs:String;
begin
  inherited;
  if not (self is TSaleslineproctree) then begin

  ProcTreeIds:='';
  processpartIDs:='';

  with Storer.getNewDataset do try
    s:= 'SELECT `ProcTreeId` FROM `tblProcTree` WHERE mastertype = "mtProduct" and `MasterId` = ' + IntToStr(TProcTreeNode(Self).MasterId);
    ProcTreeIds:= OpennGroupconcat(s , 'ProcTreeId');
    if ProcTreeIds <> '' then begin
      s:= 'Select  ID from `tblprocesspart`  WHERE `ProcTreeId` IN   (' + ProcTreeIds +')';
      processpartIDs:= OpennGroupconcat(s, 'ID');
    end;


    s:= '';
    if processpartIDs <> '' then  s:= s+ 'Delete from tblprocesspart  where ID  in (' + processpartIDs +');';
    if ProcTreeIds     <> '' then  s:= s+ 'Delete from tblprocTree      where ProcTreeId      in (' + ProcTreeIds     +');';
    if s<>'' then  Storer.RunSQLCommand(s);

  finally
    if Active then close;
    Free;
  end;


  end;
end;

function TProcTreeNode.ProcTreePartCount: Integer;
begin
  REsult := 0;
  if (MasterType in [mtSalesOrder]) and
   (not Assigned(fProcTreePart))  and    ( (ManufactureUOMQty<> 0) or (fromstockUOMQty <> 0) or (onorderQty <> 0) ) and
   Assigned(RootNode) then begin
    fProcTreePart:= TProcTreePart.Create(self);
    fProcTreePart.Connection:= TMyDacDataConnection.Create(fProcTreePart);
    fProcTreePart.Connection.Connection:= Storer.Connection;
    fProcTreePart.IgnoreAccesslevel:= true;
    fProcTreePart.LoadSelect('ProcTreeId = ' + IntToStr(self.Id));
  end;
  if assigned(fProcTreePart) then result:= fProcTreePart.count;
end;
function TProcTreeNode.GetProduct: TProduct;
begin

  // fProcTreePart is a TPROdQty object, Product object is defined in the base class. Using it from the sub instead of creating a new obj - for speed issue
  if fProduct = nil then
    if Assigned(fProcTreePart) then
      fProduct := fProcTreePart.Product;

  if fProduct = nil then begin
    fProduct:= TProduct.Create(self);
    fProduct.Connection:= TMyDacDataConnection.Create(fProduct);
    fProduct.Connection.Connection:= Storer.Connection;
    fProduct.IgnoreAccesslevel:= true;
    fProduct.Load(PartsId);
  end;
  if (fProduct.ID <> PartsId) then fProduct.Load(PartsId);
  result := fProduct;

end;

function TProcTreeNode.GetProcTreePart: TProcTreePart;
begin
  { We only want ProcTreePart records if this is NOT a quote AND
    the tree has process steps AND the node has a product }
  ProcTreePartCount;
  if assigned(fProcTreePart) then begin
    if fProcTreePart.Count = 0 then begin
      fProcTreePart.New;
      fProcTreePart.ProctreeID := Self.ID;
      fProcTreePart.ProductID:= self.PartsId;
      fProcTreePart.MatrixREf := Self.MAtrixREf;
      fProcTreePart.MatrixDesc := Self.MAtrixDesc;
      fProcTreePart.MatrixPrice := Self.MAtrixPrice;
      fProcTreePart.classId := self.classID;
    end;
    if IsRoot then begin
      if fProcTreePart.UOMQty           <> Self.ManufactureUOMQty then fProcTreePart.UOMQty           := ManufactureUOMQty ;
    end else begin
      if fProcTreePart.UOMQty           <> self.TreePartUOMTotalQty then fProcTreePart.UOMQty           := self.TreePartUOMTotalQty;
    end;
    //if fProcTreePart.UOMQty           <> self.FromstockUOMQty +Self.OnOrderUOMQty then fProcTreePart.UOMQty           := self.FromstockUOMQty +Self.OnOrderUOMQty;
    if fProcTreePart.ManufactureUOMQty   <> self.ManufactureUOMQty   then fProcTreePart.ManufactureUOMQty  := self.ManufactureUOMQty;
    if fProcTreePart.ManufacturedUOMQty  <> self.ManufacturedUOMQty  then fProcTreePart.ManufacturedUOMQty := self.ManufacturedUOMQty;
    if fProcTreePart.ManufacturingUOMQty <> self.ManufacturingUOMQty then fProcTreePart.ManufacturingUOMQty:= self.ManufacturingUOMQty;
    if fProcTreePart.ManufactureQty      <> self.ManufactureQty      then fProcTreePart.ManufactureQty     := self.ManufactureQty	;
    if fProcTreePart.ManufacturedQty     <> self.ManufacturedQty     then fProcTreePart.ManufacturedQty    := self.ManufacturedQty ;
    if fProcTreePart.ManufacturingQty    <> self.ManufacturingQty    then fProcTreePart.ManufacturingQty   := self.ManufacturingQty ;
    if fProcTreePart.OnOrderUOMQty       <> self.OnOrderUOMQty	      then fProcTreePart.OnOrderUOMQty      := self.OnOrderUOMQty	;
    if fProcTreePart.OnOrderQty          <>  self.OnOrderQty	        then fProcTreePart.OnOrderQty         := self.OnOrderQty	;
    if fProcTreePart.FromStockUOMQty     <> self.FromStockUOMQty     then fProcTreePart.FromStockUOMQty    := self.FromStockUOMQty	;
    if fProcTreePart.FromStockQty        <> self.FromStockQty        then fProcTreePart.FromStockQty       := self.FromStockQty	;
  end;
  result:= fProcTreePart;
end;
procedure TProcTreeNode.New;
begin
  inherited;

  if Assigned(fProcTreePart) then begin
    if assigned(fProduct) and (fProduct.Owner =fProcTreePart ) then fProduct := nil;
    FreeAndNil(fProcTreePart);
  end;
  if Assigned(fProcessStepList) then
    FreeAndNil(fProcessStepList);
end;

function TProcTreeNode.nodeselectedinTree: Boolean;
begin
  if PArentId =0 then begin
    Result:= True;
    Exit;
  end;
  if not(Assigned(ParentNode)) then begin
    Result := TRue;
    exit;
  end;
  if ParentNode.InputType = itOption then  begin
    result:= selected;
    Exit;
  end;
  Result := ParentNode.nodeselectedinTree;
end;

procedure TProcTreeNode.OnBeforechangeStatus(Oldstatus,
  NewStatus: TProcessPartStatus);
begin

end;

procedure TProcTreeNode.SetComplete(const Value: boolean);
var
  x: integer;
begin
  if fComplete <> Value then begin
    //logtext(CaptionIntended +':' +BooleanToStr(Value));
    FComplete := Value;
    MakeDirty;
    for x:= 0 to Children.Count -1 do
      TProcTreeNode(Children[x]).Complete:= Value;
  end;
end;

function TProcTreeNode.GetCaption: string;
begin
  result:= fCaption;
end;

function TProcTreeNode.getCaptionIntended: String;
begin
  REsult:= ReplicateStr('    ' , Level) +   Caption;
end;

function TProcTreeNode.IsOptionItem: boolean;
begin
  result:= Assigned(ParentNode) and (ParentNode.InputType = itOption);
end;

function TProcTreeNode.AllProcessesComplete: boolean;
begin
  result:= (StatusList = [psComplete]) or (StatusList = []);
end;

function TProcTreeNode.IsManufacuring: boolean;
begin
  Result := (ManufactureUOMQty <>0) ;
end;

function TProcTreeNode.IsOption: boolean;
begin
  result:= self.InputType = itOption;
end;

procedure TProcTreeNode.Load(const fIsReadonly:boolean =False);
begin
  FreeAndNil(fProcessStepList);
  inherited;
  fCleanComplete:= Complete;
end;

function TProcTreeNode.GetDirty: boolean;
begin
  result:= inherited GetDirty;
  if not result then begin
    if Assigned(self.fProcessStepList) then
      result:= fProcessStepList.Dirty
  end;
end;

procedure TProcTreeNode.SetDirty(const Value: boolean);
begin
  inherited;
  if Assigned(self.fProcessStepList) then
    fProcessStepList.Dirty:= Value;
end;

procedure TProcTreeNode.MakeDirty;
begin
  inherited;
  Dirty:= true;
end;

function TProcTreeNode.MakeProcesStepList: TProcessStepList;
begin
  REsult := TProcessStepList.Create(self);
end;

function TProcTreeNode.MasterRef: String;
begin
  Result := '';
  if masterId = 0 then exit;
  //if mastertype = '' then exit;
  With TempMyQuery do try
    connection := self.Storer.Connection;
    if mastertype = mtProduct then SQL.add('Select globalref from tblParts where PartsId = ' +inttostr(MasterID))
    else SQL.add('Select globalref from tblsaleslines where SaleLineID = ' +inttostr(MasterID));
    open;
    Result := fieldbyname('globalref').asString;
  finally
    ClosenFree;
  end;
end;

procedure TProcTreeNode.CompareTrees;
begin
  DoAuditTrial(TProcTreeNode(CleanTree), Self , MasterRef, 'Product');
end;

procedure TProcTreeNode.CompleteAllProcesses;
var
  x: integer;
begin
  ProcessStepList.CompletePrecessSteps;
  for x:= 0 to Children.Count -1 do
    TProcTreeNode(Children[x]).CompleteAllProcesses;
end;


function TProcTreeNode.getTreecount: Integer;
var
  x:Integer;
begin
  REsult := 1;
  for x:= 0 to self.Children.Count-1 do
        result := Result + TProcTreeNode(self.Children[x]).TreeCount;
end;


procedure TProcTreeNode.SetPartCalcformula(const Value: String);begin   if fsPartCalcformula  <> Value then begin    fsPartCalcformula  := Value;    CalcQtyFromFormulaQty('');  end;end;
procedure TProcTreeNode.SetFormulaid       (const Value:Integer);begin  if fiFormulaid        <> value then begin    fiFormulaid        := Value;    CalcQtyFromFormulaQty('');  CalcQtyFromformula;end; end;
procedure TProcTreeNode.SetFormulaQtyValue (const Value: Double);begin  if fdFormulaQtyValue  <> Value then begin    fdFormulaQtyValue  := Value;    CalcQtyFromFormulaQty('');  end;end;
procedure TProcTreeNode.SetFormulaQtyValue1(const Value: Double);begin  if fdFormulaQtyValue1 <> Value then begin    fdFormulaQtyValue1 := Value;    CalcQtyFromFormulaQty(''); CalcQtyFromformula;end;end;
procedure TProcTreeNode.SetFormulaQtyValue2(const Value: Double);begin  if fdFormulaQtyValue2 <> Value then begin    fdFormulaQtyValue2 := Value;    CalcQtyFromFormulaQty(''); CalcQtyFromformula;end;end;
procedure TProcTreeNode.SetFormulaQtyValue3(const Value: Double);begin  if fdFormulaQtyValue3 <> Value then begin    fdFormulaQtyValue3 := Value;    CalcQtyFromFormulaQty(''); CalcQtyFromformula;end;end;
procedure TProcTreeNode.SetFormulaQtyValue4(const Value: Double);begin  if fdFormulaQtyValue4 <> Value then begin    fdFormulaQtyValue4 := Value;    CalcQtyFromFormulaQty(''); CalcQtyFromformula;end;end;
procedure TProcTreeNode.SetFormulaQtyValue5(const Value: Double);begin  if fdFormulaQtyValue5 <> Value then begin    fdFormulaQtyValue5 := Value;    CalcQtyFromFormulaQty(''); CalcQtyFromformula;end;end;
procedure TProcTreeNode.CalcQtyFromformula;
var
  errMsg:String;
begin
  if formulaId <> 0 then begin
      FormulaQtyValue:= ParserValue(Self , DoGetParserVariable , getFormula(FormulaID), errMsg);
     ValidateQty(cqStock);
  end;
end;
procedure TProcTreeNode.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
   Value := 0;
       if sametext(VArname , 'Field1') then Value := FormulaQtyValue1
  else if sametext(VArname , 'Field2') then Value := FormulaQtyValue2
  else if sametext(VArname , 'Field3') then Value := FormulaQtyValue3
  else if sametext(VArname , 'Field4') then Value := FormulaQtyValue4
  else if sametext(VArname , 'Field5') then Value := FormulaQtyValue5
  else Exit;
  FieldFound := True;
end;
procedure TProcTreeNode.SetSubBOMProcessOrderCode(const  Value : TSubBOMProcessOrderCode);//begin if FSubBOMProcessOrderCode <> Value then begin FSubBOMProcessOrderCode:= Value;  MakeDirty;  end;end;
begin
       if Value = snpoASB then SubBOMProcessOrder := 'ASB'
  else if value =  snpoSB then SubBOMProcessOrder :='SB'
  else SubBOMProcessOrder  := 'BS';
end;
function TProcTreeNode.getSubBOMProcessOrderCode: TSubBOMProcessOrderCode;
begin
       if SubBOMProcessOrder = 'ASB' then result:= snpoASB
  else if SubBOMProcessOrder = 'SB' then result := snpoSB
  else result := snpoBS;
end;

procedure TProcTreeNode.setBuildLineNo  (const Value:Integer);begin  if fiBuildLineNo   <> Value then begin    fiBuildLineNo   := Value;    end;end;
procedure TProcTreeNode.setBuildFormulaQtyValue (const Value: Double);begin  if fdBuildFormulaQtyValue  <> Value then begin    fdBuildFormulaQtyValue  := Value;    CalcQtyFromFormulaQty('B');  end;end;
procedure TProcTreeNode.setBuildFormulaQtyValue1(const Value: Double);begin  if fdBuildFormulaQtyValue1 <> Value then begin    fdBuildFormulaQtyValue1 := Value;    CalcQtyFromFormulaQty('B');  end;end;
procedure TProcTreeNode.setBuildFormulaQtyValue2(const Value: Double);begin  if fdBuildFormulaQtyValue2 <> Value then begin    fdBuildFormulaQtyValue2 := Value;    CalcQtyFromFormulaQty('B');  end;end;
procedure TProcTreeNode.setBuildFormulaQtyValue3(const Value: Double);begin  if fdBuildFormulaQtyValue3 <> Value then begin    fdBuildFormulaQtyValue3 := Value;    CalcQtyFromFormulaQty('B');  end;end;
procedure TProcTreeNode.setBuildFormulaQtyValue4(const Value: Double);begin  if fdBuildFormulaQtyValue4 <> Value then begin    fdBuildFormulaQtyValue4 := Value;    CalcQtyFromFormulaQty('B');  end;end;
procedure TProcTreeNode.setBuildFormulaQtyValue5(const Value: Double);begin  if fdBuildFormulaQtyValue5 <> Value then begin    fdBuildFormulaQtyValue5 := Value;    CalcQtyFromFormulaQty('B');  end;end;
procedure TProcTreeNode.setOrderFormulaQtyValue (const Value: Double);begin  if fdOrderFormulaQtyValue  <> Value then begin    fdOrderFormulaQtyValue  := Value;    CalcQtyFromFormulaQty('O');  end;end;
procedure TProcTreeNode.setOrderFormulaQtyValue1(const Value: Double);begin  if fdOrderFormulaQtyValue1 <> Value then begin    fdOrderFormulaQtyValue1 := Value;    CalcQtyFromFormulaQty('O');  end;end;
procedure TProcTreeNode.setOrderFormulaQtyValue2(const Value: Double);begin  if fdOrderFormulaQtyValue2 <> Value then begin    fdOrderFormulaQtyValue2 := Value;    CalcQtyFromFormulaQty('O');  end;end;
procedure TProcTreeNode.setOrderFormulaQtyValue3(const Value: Double);begin  if fdOrderFormulaQtyValue3 <> Value then begin    fdOrderFormulaQtyValue3 := Value;    CalcQtyFromFormulaQty('O');  end;end;
procedure TProcTreeNode.setOrderFormulaQtyValue4(const Value: Double);begin  if fdOrderFormulaQtyValue4 <> Value then begin    fdOrderFormulaQtyValue4 := Value;    CalcQtyFromFormulaQty('O');  end;end;
procedure TProcTreeNode.setOrderFormulaQtyValue5(const Value: Double);begin  if fdOrderFormulaQtyValue5 <> Value then begin    fdOrderFormulaQtyValue5 := Value;    CalcQtyFromFormulaQty('O');  end;end;
procedure TProcTreeNode.SetPartSource           (const  Value : TPartSource     );begin  if FPartSource     <> Value then begin FPartSource             := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetInputType            (const  Value : TNodeInputType  );begin  if FInputType      <> Value then begin FInputType              := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetSubBOMProcessOrder   (const  Value: String   );begin  if FSubBOMProcessOrder     <> Value then begin FSubBOMProcessOrder     := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetCaption              (const  Value : string  );begin  if FCaption                <> Value then begin FCaption                := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetDescription          (const  Value : string  );begin  if FDescription            <> Value then begin FDescription            := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetCustomInputClass     (const  Value : string  );begin  if FCustomInputClass       <> Value then begin FCustomInputClass       := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetValue                (const  Value : string  );begin  if FValue                  <> Value then begin FValue                  := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetDetails              (const  Value : string  );begin  if FDetails                <> Value then begin FDetails                := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetInfo                 (const  Value : string  );begin  if FInfo                   <> Value then begin FInfo                   := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetInheritFromEditVern  (const  Value: integer  );begin  if fInheritFromEditVersion <> Value then begin fInheritFromEditVersion := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetInheritFromID        (const  Value: integer  );begin  if fInheritFromID          <> Value then begin fInheritFromID          := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.Setcomments             (const  Value : string  );begin  if Fcomments               <> Value then begin Fcomments               := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.setTreePartUOM          (const  Value : String  );begin  if fsTreePartUOM           <> Value then begin fsTreePartUOM           := Value;  if fsTreePartUOM ='' then fsTreePartUOM := AppEnv.DefaultClass.DefaultUOM;    MakeDirty;  end;end;
procedure TProcTreeNode.SetHideOnPrint          (const  Value : boolean );begin  if FHideOnPrint            <> Value then begin FHideOnPrint            := Value;  MakeDirty;  end;end;
Procedure TProcTreeNode.SetTreePricechanged     (const  Value : boolean );begin  if fTreePricechanged       <> Value then begin fTreePricechanged       := Value;  MakeDirty;  end;end;
Procedure TProcTreeNode.SetMakeCoupons          (const  Value : boolean );begin  if fMakeCoupons            <> Value then begin fMakeCoupons            := Value;  MakeDirty;  end;end;
Procedure TProcTreeNode.SetCouponLabelPrinted   (const  Value : boolean );begin  if fCouponLabelPrinted     <> Value then begin fCouponLabelPrinted     := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetAddToSale            (const  Value : boolean );begin  if FAddToSale              <> Value then begin FAddToSale              := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetSelected             (const  Value : boolean );begin  if fSelected               <> Value then begin FSelected               := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetZeroWhenLessthan1    (const  Value : boolean );begin  if fZeroWhenLessthan1      <> Value then begin FZeroWhenLessthan1      := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetRoundtoNextNumber    (const  Value : boolean );begin  if fRoundtoNextNumber      <> Value then begin FRoundtoNextNumber      := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetRoundtoPrevNumber    (const  Value : boolean );begin  if fRoundtoPrevNumber      <> Value then begin FRoundtoPrevNumber      := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetId                   (const  Value : integer );begin  if fProcTreeId             <> Value then begin fProcTreeId             := value;              end;end;
procedure TProcTreeNode.SetProcTreeId           (const  Value : integer );begin  if FProcTreeId             <> Value then begin FProcTreeId             := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetPurchaseLineId       (const  Value : integer );begin  if FPurchaseLineId         <> Value then begin FPurchaseLineId         := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetSaleLineId           (const  Value : integer );begin  if FSaleLineId             <> Value then begin FSaleLineId             := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetLinkedLineId         (const  Value : integer );begin  if FLinkedLineId           <> Value then begin FLinkedLineId           := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.setTreePartUOMID        (const  Value : Integer );begin    if fiTreePartUOMID       <> Value then begin fiTreePartUOMID         := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetCost                 (const  Value : double  );begin  if FCost                   <> Value then begin FCost                   := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetPrice                (const  Value : double  );begin  if FPrice                  <> Value then begin FPrice                  := Value;  MakeDirty;  end;end;
Procedure TProcTreeNode.SetProductUnitPrice     (const  Value : Double  );begin  if ProductUnitPrice        <> Value then begin fProductUnitPrice       := Value;  MakeDirty;  end;end;
Procedure TProcTreeNode.SetProductUnitCost      (const  Value : Double  );begin  if ProductUnitCost         <> Value then begin fProductUnitCost        := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetCostIncLabour        (const  Value : double  );begin  if FCostIncLabour          <> Value then begin FCostIncLabour          := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetPriceExLabour        (const  Value : double  );begin  if FPriceExLabour          <> Value then begin FPriceExLabour          := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.setTreePartUOMMultiplier(const  Value : Double  );begin  if fdTreePartUOMMultiplier <> Value then begin fdTreePartUOMMultiplier := Value;  if fdTreePartUOMMultiplier = 0 then fdTreePartUOMMultiplier := 1;    MakeDirty;  end;end;
procedure TProcTreeNode.SetQtyVariation         (const  Value : double  );begin  if fQtyVariation           <> Value then begin fQtyVariation           := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.SetQtyPerCoupon         (const  Value : double  );begin  if fQtyPerCoupon           <> Value then begin fQtyPerCoupon           := Value;  MakeDirty;  end;end;
//procedure TProcTreeNode.SetBuildingBlockQty     (const  Value : double  );begin  if fBuildingBlockQty       <> Value then begin fBuildingBlockQty       := Value;  MakeDirty;   end;end;
procedure TProcTreeNode.SetRAtePercoupon        (const  Value : double  );begin  if fRAtePercoupon          <> Value then begin fRAtePercoupon          := Value;  MakeDirty;  end;end;
procedure TProcTreeNode.setQtyOriginal          (const  Value : double  );begin  if fdQtyOriginal           <> Value then begin fdQtyOriginal           := Value;              end;end;
procedure TProcTreeNode.setQtyPer               (const  Value : Double  );begin  if fQtyPer                 <> Value then begin fQtyPer                 := Value;  if Value=0 then TreePartUOMQuantity := 0 else TreePartUOMQuantity := 1/Value;  end;end;
procedure TProcTreeNode.SetTotalQtyOriginal     (const  Value : Double  );begin  if fdTotalQtyOriginal      <> Value then begin fdTotalQtyOriginal      := Value;              end;end;
procedure TProcTreeNode.SetCleanComplete        (const  Value : Boolean );begin  fCleanComplete := Value;end;
procedure TProcTreeNode.SetIgnoreItemCommentsforDescription    (const  Value : boolean );begin  if fIgnoreItemCommentsforDescription      <> Value then begin FIgnoreItemCommentsforDescription      := Value;  MakeDirty;  end;end;

procedure TProcTreeNode.getCalcQtYformulaValue(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := FormulaQtyValue1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := FormulaQtyValue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := FormulaQtyValue3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := FormulaQtyValue4 ;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := FormulaQtyValue5 ;FieldFound:= True; end;

end;

procedure TProcTreeNode.getCalcQtYformulaValueBuild(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := BuildFormulaQtyValue1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := BuildFormulaQtyValue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := BuildFormulaQtyValue3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := BuildFormulaQtyValue4 ;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := BuildFormulaQtyValue5 ;FieldFound:= True; end;

end;

procedure TProcTreeNode.getCalcQtYformulaValueOrder(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
              if SameText(varname, 'Field1') then begin Value := OrderFormulaQtyValue1 ;FieldFound:= True;
     end else if SameText(varname, 'Field2') then begin Value := OrderFormulaQtyValue2 ;FieldFound:= True;
     end else if SameText(varname, 'Field3') then begin Value := OrderFormulaQtyValue3 ;FieldFound:= True;
     end else if SameText(varname, 'Field4') then begin Value := OrderFormulaQtyValue4 ;FieldFound:= True;
     end else if SameText(varname, 'Field5') then begin Value := OrderFormulaQtyValue5 ;FieldFound:= True; end;

end;
procedure TProcTreeNode.CalcQtyFromFormulaQty(qtytype:String);
var
  Qty :Double;
  VarEvent:TGetVarEvent;
  errMsg:String;
begin
  if fsPartCalcformula = '' then exit;

       if (qtytype = '') and (fdformulaQtyvalue=0) then exit
  else if (qtytype = 'B') and (fdBuildformulaQtyvalue=0) then exit
  else if (qtytype = 'O') and (fdOrderformulaQtyvalue=0) then exit;

  With Product do begin
    fbCalcQtyFromformula:= True;
    try

           if qtytype = ''  then VarEvent := getCalcQtYformulaValue
      else if qtytype = 'B' then VarEvent := getCalcQtYformulaValueBuild
      else if qtytype = 'O' then VarEvent := getCalcQtYformulaValueOrder
      else exit;

           if qtytype = ''  then Qty := fdformulaQtyvalue
      else if qtytype = 'B' then Qty := fdBuildformulaQtyvalue
      else if qtytype = 'O' then Qty := fdOrderformulaQtyvalue
      else exit;

      Qty := ProductQtyParseValue(Self , VarEvent ,  errMsg , Qty , Self.PartCalcformula, PartCalcFormulaMult , Self.TreePartUOMID , Self.TreePartUOMMultiplier , PartCalcformulaUOMID, PartCalcformulaUOMMult);

      Qty := round(Qty , GeneralRoundPlaces);
      TreePartUOMQuantity := Qty;

    finally
      fbCalcQtyFromformula:= False;
    end;
  end;
end;

procedure TProcTreeNode.CalcQtyFromformulaTree;
var
  x:Integer;
begin
  CalcQtyfromformula;
  if children.count =0 then exit;
    for x:= 0 to Children.Count -1 do begin
      TProcTreeNode(Children[x]).CalcQtyFromformulaTree;
    end;

end;

function TProcTreeNode.TreeText: String;
var
  ctr:Integer;
begin
  Result := '';
  REsult := ReplicateStr('  ' , Level)+ Caption;
  if Children.Count > 0 then
    for ctr:= 0 to Children.count-1 do
      if children[ctr] is  TProcTreeNode then
        result := result + chr(13) + TProcTreeNode(children[ctr]).TreeText;
end;

procedure TProcTreeNode.SetQuantity(const Value: double);
begin

  if FQuantity <> Value then begin
    FQuantity := Value;
    MakeDirty;
    if not (Loading) then
      CalcTotalQty;
  end;
  if istemplate then
    if qtyOriginal <> Value then
      qtyOriginal := Value;
  if not (Loading) then UpdateProcessPart;
end;

procedure TProcTreeNode.SetTotalQty(const Value: double);
var
  xcost:Double;
  fdValue :Double;
  fdDiff :Double;
begin
  fdDiff :=0;
  fdValue := Value;
  if RoundtoNextNumber then if not(Samevalue(fdValue, trunc(fdValue), 0)) then fdValue := trunc(fdValue)+1;
  if RoundtoPrevNumber then if not(Samevalue(fdValue, trunc(fdValue), 0)) then fdValue := trunc(fdValue);
  if ZeroWhenLessthan1 then if fdValue <1 then fdValue := 0;

  if FTotalQty <> fdValue then begin
      fdDiff := fdValue - fTotalQty ;
      xCost := DivZer(Cost ,FTotalQty);
      FTotalQty := fdValue;
      Cost :=xCost*FTotalQty;
      MakeDirty;
  end;
  if Loading then exit;
  if istemplate then if totalQtyOriginal <> fdValue then totalQtyOriginal := fdValue;
  try
    if (fdDiff <> 0) and fbAddingtoTotalQty then begin
          if Children.count >0 then begin
          end else begin
            fdFromStockUOMQty := fdFromStockUOMQty + fdDiff/TreePartUOMMultiplier;
            Exit;
          end;
    end;
    AllocateAvailableQty;
  finally
    UpdateProcessPart;
  end;
end;



procedure TProcTreeNode.setTreePartUOMQuantity(const Value: Double);
begin
  if fdTreePartUOMQuantity = Value then exit;
  fdTreePartUOMQuantity := Value;
  if fbUpdatingQty then exit;
  if Loading then exit;
  //if not (Loading) then CalcTotalQty;
  fbUpdatingQty:= true;
  try

      if Value = 0 then     fQtyPer := 0     else     fQtyPer := 1/Value;
      if TreePartUOMQuantity = 0 then quantity := 0 else quantity := TreePartUOMQuantity * TreePartUOMMultiplier;
      if not (Loading) then CalcTotalQty;
      if assigned(ParentNode) then
        if (ParentNode.isroot) and (ParentNode is TSalesLineProcTree) then
          TotalQty :=Quantity * TSalesLineProcTree(parentnode).SalesLine.qtyshipped
        else
          TotalQty :=Quantity * ParentNode.totalQty
      else totalQty :=Quantity;
      TreePartUOMTotalQty := TotalQty /TreePartUOMMultiplier;
      AllocateAvailableQty;
      CalcQty;
      MakeDirty;
  finally
      fbUpdatingQty := False;
  end;
end;

procedure TProcTreeNode.setTreePartUOMTotalQty(const Value: Double);
begin
    if fdTreePartUOMTotalQty = Value then exit;
    fdTreePartUOMTotalQty := Value;

  if fbUpdatingQty then exit;
  if Loading then exit;
  fbUpdatingQty:= true;
  try
      if fdTreePartUOMTotalQty = 0 then  totalQty := 0
      else totalQty:= fdTreePartUOMTotalQty * TreePartUOMMultiplier;
      if fbAddingtoTotalQty = false then begin
        if assigned(owner) and (owner is TSalesLineProcTree) then
          if (totalQty <>0) and ( TSalesLineProcTree(owner).manufactureqty <>0) then
            Quantity := DivZer(totalQty , TSalesLineProcTree(owner).manufactureqty + TSalesLineProcTree(owner).QtyVariation);
      end;

      MakeDirty;
  finally
      fbUpdatingQty := False;
  end;
end;


procedure TProcTreeNode.AllocateQty(const AvailQty:double; var Qty1:Double; var Qty2:Double);
var
  fdqty:double;
begin
  fdqty:= Round(AvailQty , GeneralRoundPlaces);
  try
    if Qty1<0 then Qty1:= 0;
    if Qty2<0 then Qty2:= 0;
    if fdQty =0 then begin
      Qty1:= 0;
      Qty2:= 0;
      Exit;
    end;

    if Qty1> fdqty then begin
      Qty1:= fdqty;
      Qty2:= 0;
      Exit;
    end;

    if Qty2> fdqty-Qty1 then begin
      Qty2:= fdqty-Qty1;
      Exit;
    end;

    if (Qty1 = 0) AND (Qty2=0) then begin
      Qty1:= fdqty;
      Qty2:= 0;
      exit
    end;

    if Qty1=0 then begin
      Qty1 :=fdqty-Qty2;
      Exit;
    end;

    if Qty2 =0 then begin
      Qty2 := fdqty-Qty1;
      Exit;
    end;
  finally
    if Qty1+Qty2 <> fdqty then
      Qty2 := fdqty -Qty1;
  end;
end;
function TProcTreeNode.getFromStockQty: Double;
begin
  REsult := 0;
  if FromStockUOMQty =0 then exit;
  if Mastertype = mtProduct then exit;
  result :=FromStockUOMQty*TreePartUOMMultiplier;
end;
function TProcTreeNode.getFromStockUOMQty: Double;
begin
  Result := 0;
  if Mastertype = mtProduct then exit;
  result :=fdFromStockUOMQty;
end;

function TProcTreeNode.getManufactureQty: Double;
begin
  REsult := 0;
  if ManufactureUOMQty =0 then exit;
  if Mastertype = mtProduct then exit;
  result := ManufactureUOMQty*TreePartUOMMultiplier;
end;
function TProcTreeNode.getManufacturedQty: Double;
begin
  REsult := 0;
  if ManufacturedUOMQty =0 then exit;
  if Mastertype = mtProduct then exit;
  result := ManufacturedUOMQty*TreePartUOMMultiplier;
end;
function TProcTreeNode.getManufacturingQty: Double;
begin
  REsult := 0;
  if ManufacturingUOMQty =0 then exit;
  if Mastertype = mtProduct then exit;
  result := ManufacturingUOMQty*TreePartUOMMultiplier;
end;
function TProcTreeNode.getManufactureUOMQty: Double;
begin
  Result := 0;
  if Mastertype = mtProduct then exit;
  result :=fdManufactureUOMQty;
end;
function TProcTreeNode.getManufacturedUOMQty: Double;
begin
  Result := 0;
  if Mastertype = mtProduct then exit;
  result :=fdManufacturedUOMQty;
end;
function TProcTreeNode.getManufacturingUOMQty: Double;
begin
  Result := 0;
  if Mastertype = mtProduct then exit;
  result :=fdManufacturingUOMQty;
end;

function TProcTreeNode.getonOrderQty: Double;
begin
  REsult := 0;
  if OnOrderUOMQty =0 then exit;
  if Mastertype = mtProduct then exit;
  result := OnOrderUOMQty*TreePartUOMMultiplier;
end;
function TProcTreeNode.getOnOrderUOMQty: Double;
begin
  Result := 0;
  if Mastertype = mtProduct then exit;
  result :=fdOnOrderUOMQty;

end;

function TProcTreeNode.getParentCaption: String;
begin
  result := '';
  if not Assigned(self.ParentNode) then exit;
  REsult := ParentNode.Caption;
end;

Procedure TProcTreeNode.AllocateAvailableQty;
var
  fdProductQty:double;
  fdUOMProductQty:double;
  //fitype:Integer;
begin
  //fitype:=0;
  if mastertype <> mtsalesorder then begin
     if children.count =0 then
      OnOrderUOMQty:=fdTreePartUOMtotalQty
     else
      fdManufactureUOMQty := fdTreePartUOMtotalQty;
     //fitype:=1;
  end else begin
    if (isRoot) and (PartsID>0) then begin
      fdManufactureUOMQty := fdTreePartUOMtotalQty;
      fdFromStockUOMQty:=0;
      fdOnOrderUOMQty:=0;
      //fitype:=2;
    end else begin
      if PartsId > 0 then begin
        fdProductQty:= 0;
                if Appenv.CompanyPrefs.SmartOrderbasedOn =0 then fdProductQty := 0
        else if Appenv.CompanyPrefs.SmartOrderbasedOn = 1 then fdProductQty := ProductQty(PartsId , tAvailable)
        else if Appenv.CompanyPrefs.SmartOrderbasedOn = 2 then fdProductQty := ProductQty(PartsId , tInStock)
        else if Appenv.CompanyPrefs.SmartOrderbasedOn = 3 then fdProductQty := ProductQty(PartsId , tAvailablenOnOrder)
        else if Appenv.CompanyPrefs.SmartOrderbasedOn = 4 then fdProductQty := ProductQty(PartsId , tInStocknOnOrder);
        if fdProductQty <0 then fdProductQty :=0;
        if fdProductQty       <> 0 then fdUOMProductQty :=fdProductQty / TreePartUOMMultiplier else fdUOMProductQty :=0;

        if fdFromStockUOMQty   > fdTreePartUOMtotalQty  then fdFromStockUOMQty   := fdTreePartUOMTotalQty;
        if fdFromStockUOMQty   > fdUOMProductQty        then fdFromStockUOMQty   := fdUOMProductQty;
        if fdOnOrderUOMQty     > fdTreePartUOMtotalQty  then fdOnOrderUOMQty     := fdTreePartUOMtotalQty;
        if fdManufactureUOMQty > fdTreePartUOMtotalQty  then fdManufactureUOMQty := fdTreePartUOMtotalQty;

        if fdUOMProductQty >0 then begin
          if fdTreePartUOMtotalQty  < fdUOMProductQty then
            fdFromStockUOMQty:= fdTreePartUOMtotalQty
          else fdFromStockUOMQty:= fdUOMProductQty;
        end else begin
           fdOnOrderUOMQty:= fdTreePartUOMtotalQty;
        end;
        //fitype:=3;
      end else begin
        fdFromStockUOMQty   := 0;
        fdOnOrderUOMQty     := 0;
        fdManufactureUOMQty := FTotalQty;
        //fitype:=4;
      end;
    end;
    if (optionitem or (PartsID=0)) and (children.count>0) then begin
      fdManufactureUOMQty := fdTreePartUOMtotalQty;
      fdFromStockUOMQty:=0;
      fdOnOrderUOMQty:=0;
      //fitype:=5;
    end else if (children.count >0) and (PartsID>0) then begin
      if Appenv.CompanyPrefs.SubBOMUseAvailableQtyFromStock then begin
        if  (fdProductQty <= TotalQty) then FromStockQty :=fdProductQty
        else FromStockQty :=TotalQty;
        fdManufactureUOMQty := fdTreePartUOMtotalQty - fdFromStockUOMQty;
        fdOnOrderUOMQty:=0;
        //fitype:=6;
      end else begin
        fdManufactureUOMQty := fdTreePartUOMtotalQty;
        fdFromStockUOMQty:=0;
        fdOnOrderUOMQty:=0;
        //fitype:=7;
      end;
      //UpdateDefaultQty;
    end else if (ProcessSteplist.count>0) then begin
      fdManufactureUOMQty := fdTreePartUOMtotalQty;
      //fitype:=8;
    end else if (children.count =0) and (PartsID>0) then begin
      fdOnOrderUOMQty:=fdTreePartUOMtotalQty -fdFromStockUOMQty;
      fdManufactureUOMQty := 0;
      //fitype:=9;
    end else if (children.count =0) and (PartsID=0) then begin
      fdManufactureUOMQty := fdTreePartUOMtotalQty;
      fdOnOrderUOMQty:=0;
      fdFromStockUOMQty:= 0;
      //fitype:=10;
    end else begin
      AllocateQty(fdTreePartUOMtotalQty -fdFromStockUOMQty , fdManufactureUOMQty , fdOnOrderUOMQty);
      //fitype:=11;
    end;
  end;
  (*logtext(inttostr(fiType)+',' +
          caption +',' +
          floattostr(fdTreePartUOMtotalQty)+',' +
          floattostr(Quantity)+',' +
          floattostr(fdManufactureUOMQty)+',' +
          floattostr(fdFromStockUOMQty)+',' +
          floattostr(fdOnOrderUOMQty));*)
end;

procedure TProcTreeNode.CalcQty;
var
  x:Integer;
  child: TProcTreeNode;
begin
  if CalculatingQty then exit;
  CalculatingQty:= True;
  try
  if children.count =0 then exit;
    for x:= 0 to Children.Count -1 do begin
      child:= TProcTreeNode(Children[x]);
      if ((InputType = itOption) and  (child.Selected)) or ((InputType <> itOption) or (child.Selected)) then begin
        if mastertype = mtProduct then begin
          Child.TotalQty := child.Quantity * (TotalQty + QtyVariation);
          Child.TreePartUOMTotalQty :=Child.TotalQty /child.TreePartUOMMultiplier;
          if isroot then
            Child.TotalQtyOriginal := (ManufactureQty +FromstockQty +OnOrderUOMQty + QtyVariation)
          else
          Child.TotalQtyOriginal := Child.QtyOriginal * (TotalQty + QtyVariation);
        end else begin
          if not SameValue(Child.TotalQty , child.Quantity * (ManufactureQty + QtyVariation) , 0.00001) then Child.TotalQty := child.Quantity * (ManufactureQty + QtyVariation);
          if not SameValue(Child.TreePartUOMTotalQty ,Child.TotalQty /child.TreePartUOMMultiplier, 0.00001) then Child.TreePartUOMTotalQty :=Child.TotalQty /child.TreePartUOMMultiplier;
          child.AllocateAvailableQty;
          if isroot then begin
            if not SameValue(Child.TotalQtyOriginal ,ManufactureQty +FromstockQty +OnOrderUOMQty + QtyVariation, 0.00001) then Child.TotalQtyOriginal := ManufactureQty +FromstockQty +OnOrderUOMQty + QtyVariation;
          end else begin
            if not SameValue(Child.TotalQtyOriginal , Child.QtyOriginal * (TotalQty + QtyVariation), 0.00001) then Child.TotalQtyOriginal := Child.QtyOriginal * (TotalQty + QtyVariation);
          end;
        end;
      end else begin
        Child.TotalQty            := 0;
        Child.TreePartUOMTotalQty := 0;
        Child.ManufactureUOMQty   := 0;
        Child.ManufacturedUOMQty  := 0;
        //Child.ManufacturingUOMQty := 0;
        Child.FromStockUOMQty     := 0;
        Child.OnOrderUOMQty       := 0;
        Child.TotalQtyOriginal    := 0;
      end;
      child.CalcQty;
    end;
  finally
    CalculatingQty:= False;
  end;
end;

function TProcTreeNode.ProductQty(const fiPartsID:Integer; Qtytype :TQtytype):Double;
begin
  result:= 0;
end;

function TProcTreeNode.ProductHasformula: Boolean;
begin
  Result := False;
  if PartsId = 0 then exit;
  result := Formulaid >0;
end;


procedure TProcTreeNode.ValidateQty(Const Value :TChangingQty);
var
  fdmanQty, fdOrderQty:Double;
begin
  try
    fdmanQty :=   fdManufactureUOMQty;
    fdOrderQty :=  fdOnOrderUOMQty;
    try
      if fdTreePartUOMTotalQty = fdFromStockUOMQty + fdManufactureUOMQty + fdOnOrderUOMQty then exit;

      if fdManufactureUOMQty  < 0 then fdManufactureUOMQty:=0;
      if fdManufacturedUOMQty  > fdManufactureUOMQty then fdManufacturedUOMQty := fdManufactureUOMQty;
      //if fdManufacturingUOMQty > fdManufactureUOMQty then fdManufacturingUOMQty:= fdManufactureUOMQty;
      if fdFromStockUOMQty    < 0 then fdFromStockUOMQty  := 0;
      if fdOnOrderUOMQty      < 0 then fdOnOrderUOMQty    :=0;
      if optionitem then begin
        fdManufactureUOMQty := fdTreePartUOMtotalQty;
        fdFromStockUOMQty:=0;
        fdOnOrderUOMQty:=0;
      end else if Value = cqTotal then begin
          if fdTreePartUOMTotalQty =0 then begin
            fdManufactureUOMQty:=0;
            fdFromStockUOMQty := 0;
            fdOnOrderUOMQty :=0;
          end else begin
            AllocateAvailableQty;
          end;
      end else  if Value = cqStock then begin

        if fdTreePartUOMtotalQty< fdFromStockUOMQty then fdFromStockUOMQty :=fdTreePartUOMtotalQty;
        if fdTreePartUOMtotalQty< fdFromStockUOMQty+fdManufactureUOMQty then fdManufactureUOMQty := fdTreePartUOMtotalQty-fdFromStockUOMQty;
        if fdTreePartUOMtotalQty< fdFromStockUOMQty+fdManufactureUOMQty+fdOnOrderUOMQty then fdOnOrderUOMQty := fdTreePartUOMtotalQty-fdFromStockUOMQty-fdManufactureUOMQty;

        if children.count =0 then begin
          fdOnOrderUOMQty:=fdTreePartUOMtotalQty -fdFromStockUOMQty ; fdManufactureUOMQty := 0;
        end else AllocateQty(fdTreePartUOMTotalQty -fdFromStockUOMQty , fdManufactureUOMQty , fdOnOrderUOMQty)
      end else  if Value = cqbuild then begin
        if fdTreePartUOMtotalQty< fdManufactureUOMQty then fdManufactureUOMQty :=fdTreePartUOMtotalQty;
        if fdTreePartUOMtotalQty< fdManufactureUOMQty+fdFromStockUOMQty then fdFromStockUOMQty := fdTreePartUOMtotalQty-fdManufactureUOMQty;
        if fdTreePartUOMtotalQty< fdManufactureUOMQty+fdFromStockUOMQty+fdOnOrderUOMQty then fdOnOrderUOMQty := fdTreePartUOMtotalQty-fdManufactureUOMQty-fdFromStockUOMQty;

        AllocateQty(fdTreePartUOMTotalQty -fdManufactureUOMQty , fdFromStockUOMQty, fdOnOrderUOMQty )
      end else  if Value = cqORder then begin
        if fdTreePartUOMtotalQty< fdOnOrderUOMQty then fdOnOrderUOMQty :=fdTreePartUOMtotalQty;
        if fdTreePartUOMtotalQty< fdOnOrderUOMQty+fdFromStockUOMQty then fdFromStockUOMQty := fdTreePartUOMtotalQty-fdOnOrderUOMQty;
        if fdTreePartUOMtotalQty< fdOnOrderUOMQty+fdFromStockUOMQty+fdManufactureUOMQty then fdManufactureUOMQty := fdTreePartUOMtotalQty-fdOnOrderUOMQty-fdFromStockUOMQty;

        if children.count =0 then fdFromStockUOMQty:=fdTreePartUOMtotalQty -fdOnOrderUOMQty
        else AllocateQty(fdTreePartUOMTotalQty -fdOnOrderUOMQty , fdFromStockUOMQty , fdManufactureUOMQty);
      end;
    finally
       if fdmanQty   <>  fdManufactureUOMQty then BuildFormulaQtyValue:= 0;
       if fdOrderQty <>  fdOnOrderUOMQty     then OrderFormulaQtyValue:= 0;
    end;
  finally
  end;
end;
procedure TProcTreeNode.setFromStockQty(const Value: Double);
begin
  if Value =0 then begin
    FromStockUOMQty := 0;
    exit;
  end;
  FromStockUOMQty := Value * TreePartUOMMultiplier;
end;

procedure TProcTreeNode.setFromStockUOMQty(const Value: Double);
begin
  if fdFromStockUOMQty= Value then exit;
  fdFromStockUOMQty:= Value;
  if Loading then exit;
  if  fdTreePartUOMTotalQty < fdFromStockUOMQty    then fdFromStockUOMQty    := fdTreePartUOMTotalQty;
  if fdFromStockUOMQty < 0 then fdFromStockUOMQty := 0;
  ValidateQty(cqStock);
  MakeDirty;
  CalcQty;
end;
procedure TProcTreeNode.setManufactureQty(const Value: Double);
begin
  if Value =0 then begin
    ManufactureUOMQty := 0;
    exit;
  end;
  ManufactureUOMQty := Value * TreePartUOMMultiplier;
end;
procedure TProcTreeNode.setManufacturedQty(const Value: Double);
begin
  if Value =0 then begin
    ManufacturedUOMQty := 0;
    exit;
  end;
  ManufacturedUOMQty := Value * TreePartUOMMultiplier;
end;
procedure TProcTreeNode.setManufacturingQty(const Value: Double);
begin
  if Value =0 then begin
    ManufacturingUOMQty := 0;
    exit;
  end;
  ManufacturingUOMQty := Value * TreePartUOMMultiplier;
end;
procedure TProcTreeNode.setManufacturedUOMQty(const Value: Double);
begin
  fdManufacturedUOMQty := Value;
end;
procedure TProcTreeNode.setManufacturingUOMQty(const Value: Double);
begin
  fdManufacturingUOMQty := Value;
end;
procedure TProcTreeNode.setManufactureUOMQty(const Value: Double);
begin
  if fdManufactureUOMQty= Value then exit;

  fdManufactureUOMQty:= Value;
  BuildFormulaQtyValue :=0;
  if Loading then exit;
  if  fdTreePartUOMTotalQty < fdManufactureUOMQty  then fdManufactureUOMQty  := fdTreePartUOMTotalQty;
  if fdManufactureUOMQty < 0 then fdManufactureUOMQty := 0;
  //fdManufacturingUOMQty := fdManufactureUOMQty -fdManufactureUOMQty;
  ValidateQty(cqbuild);
  MakeDirty;
  CalcQty;
end;
procedure TProcTreeNode.setOnOrderQty(const Value: Double);
begin
  if Value =0 then begin
    OnOrderUOMQty := 0;
    Exit;
  end;

  OnOrderUOMQty := Value * TreePartUOMMultiplier;
end;

procedure TProcTreeNode.setOnOrderUOMQty(const Value: Double);
begin
  if fdOnOrderUOMQty = value then exit;
  fdOnOrderUOMQty := value;
  OrderFormulaQtyValue:= 0;
  if Loading then exit;
  if  fdTreePartUOMTotalQty < fdOnOrderUOMQty      then fdOnOrderUOMQty      := fdTreePartUOMTotalQty;
  if fdOnOrderUOMQty <0 then fdOnOrderUOMQty:= 0;
  ValidateQty(cqOrder);
  MakeDirty;
  CalcQty;
end;
function TProcTreeNode.getTreePartUOM: String;
begin
  result :=fsTreePartUOM;
  if result = '' then result := AppEnv.DefaultClass.DefaultUOM;
end;

function TProcTreeNode.getTreePartUOMMultiplier: Double;
begin
  result := fdTreePartUOMMultiplier;
  if result =0 then result := 1;
end;


function TProcTreeNode.getProgressMsg: String;
begin
  result := fsProgressMsg;
  if assigned(Owner) then
    if owner is TProcTreeNode then
      result :=TProcTreeNode(Owner).ProgressMsg;
end;

function TProcTreeNode.getQtyFor1UOMParent: Double;
begin
  REsult := TreePartUOMQuantity;
  if Assigned(owner) and (owner is TProcTreeNode) then
    REsult := Result *TProcTreeNode(Owner).TreePartUOMMultiplier;
end;
function TProcTreeNode.getQtyForUOMParent: Double;
begin
  REsult := TreePartUOMQuantity;
  if Assigned(owner) and (owner is TProcTreeNode) then begin
    REsult := Result *TProcTreeNode(Owner).TreePartUOMMultiplier;
    REsult := result *TProcTreeNode(Owner).TreePartUOMQuantity;
  end;
end;

function TProcTreeNode.getNodeDefinition: String;
begin
  result := '';
  if Assigned(Owner) and (Owner is TProcTreeNode) then begin
    Result := 'Tot Qty = '+ FloatToStr(TreePartUOMQuantity )+' (Qty column) x '+
              FloatToStr(TProcTreeNode(OwneR).TreepartUOMMultiplier )+' (' +TProcTreeNode(OwneR).TreepartUOM +' = ' +FloatToStr(TProcTreeNode(OwneR).TreepartUOMMultiplier )+') x ' +
              FloatToStr(TProcTreeNode(OwneR).TreePartUOMQuantity )+' (Parent Tot Qty) = ' +
              FloattoStr(TotalQty) +' ' + AppEnv.DefaultClass.DefaultUOM;
  end else begin
    Result := 'This number should always be "1"';
  end;

end;

procedure TProcTreeNode.UpdateProcessPart;
begin
  if ID =0 then exit;
  try
    if Assigned(ProcTreePart) then begin
      if Assigned(self.ParentNode) and (ParentNode.IsOptionNode) and (self.Selected)  then begin
          if fProcTreePart.UnitOfMeasure       <> self.TreePartUOM                    then fProcTreePart.UnitOfMeasure      := self.TreePartUOM;
          if fProcTreePart.UnitOfMeasureID     <> self.TreePartUOMId                  then fProcTreePart.UnitOfMeasureID    := self.TreePartUOMId;
          if fProcTreePart.UOMMultiplier       <> self.TreePartUOMMultiplier          then fProcTreePart.UOMMultiplier      := self.TreePartUOMMultiplier;
          if fProcTreePart.UOMQty              <> self.ParentNode.TotalQty            then fProcTreePart.UOMQty             := self.ParentNode.TotalQty;
          if fProcTreePart.ManufactureUOMQty   <> self.ParentNode.ManufactureUOMQty   then fProcTreePart.ManufactureUOMQty  := self.ParentNode.ManufactureUOMQty;
          if fProcTreePart.ManufacturedUOMQty  <> self.ParentNode.ManufacturedUOMQty  then fProcTreePart.ManufacturedUOMQty := self.ParentNode.ManufacturedUOMQty;
          //if fProcTreePart.ManufacturingUOMQty <> self.ParentNode.ManufacturingUOMQty then fProcTreePart.ManufacturingUOMQty := self.ParentNode.ManufacturingUOMQty;
          if fProcTreePart.OnOrderUOMQty       <> self.ParentNode.OnOrderUOMQty	      then fProcTreePart.OnOrderUOMQty      := self.ParentNode.OnOrderUOMQty;
          if fProcTreePart.FromStockQty        <> self.ParentNode.FromStockQty	      then fProcTreePart.FromStockQty       := self.ParentNode.FromStockQty;
          if fProcTreePart.ManufactureQty      <> self.ParentNode.ManufactureQty	    then fProcTreePart.ManufactureQty     := self.ParentNode.ManufactureQty;
          if fProcTreePart.ManufacturedQty     <> self.ParentNode.ManufacturedQty     then fProcTreePart.ManufacturedQty    := self.ParentNode.ManufacturedQty;
          //if fProcTreePart.ManufacturingQty    <> self.ParentNode.ManufacturingQty    then fProcTreePart.ManufacturingQty    := self.ParentNode.ManufacturingQty;
          if fProcTreePart.OnOrderQty          <> self.ParentNode.OnOrderQty	        then fProcTreePart.OnOrderQty         := self.ParentNode.OnOrderQty;
      end else begin
          if fProcTreePart.UnitOfMeasure       <> self.TreePartUOM             then fProcTreePart.UnitOfMeasure      := self.TreePartUOM;
          if fProcTreePart.UnitOfMeasureID     <> self.TreePartUOMId           then fProcTreePart.UnitOfMeasureID    := self.TreePartUOMId;
          if fProcTreePart.UOMMultiplier       <> self.TreePartUOMMultiplier   then fProcTreePart.UOMMultiplier      := self.TreePartUOMMultiplier;
          if fProcTreePart.Qty                 <>  self.TotalQty               then fProcTreePart.Qty                := self.TotalQty;
          if fProcTreePart.ManufactureUOMQty   <> self.ManufactureUOMQty       then fProcTreePart.ManufactureUOMQty  := self.ManufactureUOMQty;
          if fProcTreePart.ManufacturedUOMQty  <> self.ManufacturedUOMQty      then fProcTreePart.ManufacturedUOMQty := self.ManufacturedUOMQty;
          //if fProcTreePart.ManufacturingUOMQty <> self.ManufacturingUOMQty     then fProcTreePart.ManufacturingUOMQty:= self.ManufacturingUOMQty;
          if fProcTreePart.OnOrderUOMQty       <> self.OnOrderUOMQty	         then fProcTreePart.OnOrderUOMQty      := self.OnOrderUOMQty	;
          if fProcTreePart.FromStockQty        <> self.FromStockQty	           then fProcTreePart.FromStockQty       := self.FromStockQty	;
          if fProcTreePart.ManufactureQty      <> self.ManufactureQty	         then fProcTreePart.ManufactureQty     := self.ManufactureQty	;
          if fProcTreePart.ManufacturedQty     <> self.ManufacturedQty         then fProcTreePart.ManufacturedQty    := self.ManufacturedQty	;
          //if fProcTreePart.ManufacturingQty    <> self.ManufacturingQty        then fProcTreePart.ManufacturingQty   := self.ManufacturingQty	;
          if fProcTreePart.OnOrderQty          <> self.OnOrderQty	             then fProcTreePart.OnOrderQty         := self.OnOrderQty	;
      end;
        fProcTreePart.Postdb;
    end;
  Except
  end;
end;
{ TProcessStepList }

function TProcessStepList.AddProcessPart: TProcessPartNDS;
begin
  result:= TProcessPartNDS.Create(nil);
  self.Add(result);
end;

procedure TProcessStepList.CompletePrecessSteps;
var
  x: integer;
begin
  for x:= 0 to self.Count -1 do begin
    if Item[x].TimeStart = 0 then
      Item[x].TimeStart:= now;
    if Item[x].TimeEnd = 0 then
      Item[x].TimeEnd:= now;
    Item[x].Status:= psComplete;
  end;
end;

function TProcessStepList.GetItem(const index: integer): TProcessPartNDS;
begin
  result:= TProcessPartNDS(inherited GetItem(index));
end;

function TProcessStepList.IsEqual(aStepList: TProcessStepList): boolean;
var
  x: integer;
begin
  result := self.Count = aStepList.Count;
  if not result then exit;
  for x := 0 to Count -1 do begin
    if (Item[x].PartId <> aStepList.Item[x].PartId) or
       (Item[x].ProcessStepSeq <> aStepList.Item[x].ProcessStepSeq) or
       (Item[x].IsTemplate <> aStepList.Item[x].IsTemplate) or
       (Item[x].MakeCoupons <> aStepList.Item[x].MakeCoupons) or
       (Item[x].Duration <> aStepList.Item[x].Duration) or
       (Item[x].SetupDuration <> aStepList.Item[x].SetupDuration) or
       (Item[x].BreakdownDuration <> aStepList.Item[x].BreakdownDuration) or
       (Item[x].QtyPerCoupon <> aStepList.Item[x].QtyPerCoupon) or
       (Item[x].RatePercoupon <> aStepList.Item[x].RatePercoupon) or
       (Item[x].FixedAmount <> aStepList.Item[x].FixedAmount) or
       (Item[x].TimeStart <> aStepList.Item[x].TimeStart) or
       (Item[x].TimeEnd <> aStepList.Item[x].TimeEnd) or
       (Item[x].Status <> aStepList.Item[x].Status) or
       (Item[x].HourlyLabourRate <> aStepList.Item[x].HourlyLabourRate) or
       (Item[x].ProcessStepExtraInfo <> aStepList.Item[x].ProcessStepExtraInfo) or
       (Item[x].BuildingBlockQty <> aStepList.Item[x].BuildingBlockQty) then begin
      result := false;
      exit;
    end;
  end;

end;

function TProcessStepList.ItemById(const Id: integer): TProcessPartNDS;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do begin
    if Item[x].Id = Id then begin
      result:= Item[x];
      break;
    end;
  end;
end;

procedure TProcessStepList.ProcessStatus(
  var ProcessPartStatusList: TProcessPartStatusList);
var x: integer;
begin
  for x:= 0 to Count -1 do begin
    Include(ProcessPartStatusList, self.Item[x].Status);
  end;
end;

{ TSalesLineProcTree }
Function TSalesLineProcTree.ChangeTotalQty(aproctreeID: Integer; fUOMQty, fWasteuomQty: Double):boolean;
var
  x:Integer;
begin
  result := False;
  if ProctreeId = aproctreeID then begin

    fbAddingtoTotalQty := TRue;
    try
      TreePartUOMTotalQty := fUOMQty;//TreePartUOMTotalQty + fdUOMQty;
      WasteUOMQty := fWasteuomQty;
    finally
      fbAddingtoTotalQty := False;
    end;
    Result := True;
    Exit;
  end;
  if Children.Count =0 then exit;
  for x:= 0 to Children.Count -1 do begin
    if TSalesLineProcTree(Children[x]).ChangeTotalQty(aproctreeID,fUOMQty, fWasteuomQty) then begin
      result := True;
      Exit;
    end;
  end;
end;
function TSalesLineProcTree.AnyScheduled: Boolean;
var
  x:Integer;
begin
  Result := False;
  if Assigned(ProcessStepList) then begin
    for x:= 0 to self.ProcessStepList.Count -1 do begin
      if ProcessStepList[x].status <>psNotScheduled then begin
        Result := true;
        exit;
      end;
    end;
  end;
  if Children.Count >0 then begin
    for x:= 0 to Children.Count -1 do begin
      if TSalesLineProcTree(Children[x]).AnyScheduled then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TSalesLineProcTree.Assign(Source: TPersistent);
begin
  inherited;
  fbBOMGroupedLine     := TSalesLineProcTree(Source).BOMGroupedLine;
  fbBOMProductionLine  := TSalesLineProcTree(Source).BOMProductionLine;
  //fbCOGSFixDone        := TSalesLineProcTree(Source).COGSFixDone;
end;

procedure TSalesLineProcTree.BuildDetails;
begin
  inherited;
  if Owner is TSalesLineBase then
    if appenv.companyprefs.BOMDetailsReplacesProductDescriptionMemo then TSalesLineBase(Owner).Product_Description_Memo:= Details
    else if appenv.companyprefs.BOMDetailsAppendsProductDescriptionMemo then TSalesLineBase(Owner).Product_Description_Memo:= trim(TSalesLineBase(Owner).Product.SalesDescriptionMemo+ NL+Details);
end;
procedure TSalesLineProcTree.CheckProcessTransDate;
var
  x:Integer;
begin
     if Assigned(ProcTreePart) then begin
        fProcTreePart.EditDB;
        fProcTreePart.DateRequired:= FirstShipDate;
        fProcTreePart.PostDB;
     end;
    if Children.Count >0  then
      for x:= 0 to Children.Count -1 do
        TSalesLineProcTree(Children[x]).CheckProcessTransDate;
end;
procedure TSalesLineProcTree.CalcPrice(const SkipCustom: boolean = true; Recalccost :Boolean = True;forceRecalc:Boolean =False);
var
  fbflag:boolean;
  fdPrice, RetDiscountPercent :Double;
  RetDesc, RetMsg:String;
  fbCSPDone:Boolean;
begin
  if isroot and not(Anydirty) and not(forceRecalc)  then exit;


      inherited;
      fbCSPDone:=False;
      if Owner is TSalesLineBase then begin
          if TSalesLineBase(Owner).HAsTree then begin
            ProductUnitCost  := divZer(Cost ,  totalqty);
            ProductUnitPrice := divZer(Price ,  totalqty);

            if  (ProductPrice1(TSalesLineBase(Owner).ProductID)=0) or (fbCalcTreePrice) then begin
              fbFlag:= TSalesLineBase(Owner).ignoreCheckSaveSpecialPrice;
              TSalesLineBase(Owner).ignoreCheckSaveSpecialPrice := True;
              try
                if ((TSalesLineBase(Owner).OriginalLinePrice<>  Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces)) and (Appenv.companyprefs.BOMPriceOverridesAllOtherPrice)) Or
                    (TSalesLineBase(Owner).OriginalLinePrice =0) then
                  TSalesLineBase(Owner).OriginalLinePrice:= Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces);

                if  Appenv.companyprefs.CSPOverridesRawMaterialPrices then begin
                    if ObjClientDiscount.ClientPrice_Discounts(TSalesLineProcTree(Self).Sales.ClientID,TSalesLineProcTree(Self).Sales.TermsName, TSalesLineProcTree(Self).PartsID, TSalesLineProcTree(Self).TreepartUOMID,
                                                      TSalesLineProcTree(Self).Sales.SaleClassId,TSalesLineProcTree(Self).TotalQty, TSalesLineProcTree(Self).Sales.SaleDate,
                                                      TSalesLineProcTree(Self).Sales.UseWholesalePrice, fdPrice, RetDiscountPercent, RetDesc, RetMsg, True, '' , true ) then begin
                      if (ObjClientDiscount.DiscountType = SPEC_PRICE_DISC) or (ObjClientDiscount.DiscountType = CSP_DISC) then begin
                         SalesLine.LinePrice:= fdPrice;
                         TSalesLineBase(Owner).OriginalLinePrice:=fdPrice;
                         fbCSPDone:=true;
                      end;
                    end;
                end;

                if  not(fbCSPDone) and  (fbCalcTreePrice) and not(Appenv.companyprefs.IgnoreBOMCalcPriceOnSale)  then begin
                  if SalesLine.LinePrice<>  Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces) then
                    SalesLine.LinePrice:= Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces);
                  if TSalesLineBase(Owner).OriginalLinePrice > Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces) then
                    TSalesLineBase(Owner).OriginalLinePrice:= Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces);
                end;
              finally
                TSalesLineBase(Owner).ignoreCheckSaveSpecialPrice := fbFlag;
              end;
            end;
            TSalesLineBase(Owner).LineCost:= Round(DivZer(Cost,ManufactureQty),GeneralRoundPlaces);
            TSalesLineBase(Owner).PostDB;
          end;
      end;
end;
procedure TSalesLineProcTree.undoCalcCost(const SkipCustom: boolean = true);
begin
{NOTE: THIS IS USED FOR VERIFY N FIX ONLY
THIS FUNCTION IS USED TO RECALCULATE THE COST BASED ON THE USED 'PRODUCT'S COST1 INSTEAD OF AVG COST'
THIS SHOULD NOT BE CALLED FROM THE NORMAL TRANSACTIONS AS THE NORMAL TRANSACTIONS SHOULD USE AVG COST
binny}
  inherited;
  if Owner is TSalesLineBase then begin
    TSalesLineBase(Owner).LineCost:= Round(DivZer(Cost,ManufactureQty),GeneralRoundPlaces);
    TSalesLineBase(Owner).PostDB;
  end;
end;
(*procedure TSalesLineProcTree.UpdateDefaultQty;
var
  fdQty:Double;
  x:Integer;
begin
  if mastertype = mtProduct then Exit;
  if not Appenv.CompanyPrefs.SubBOMUseAvailableQtyFromStock then exit;
  if ProductionSchedOrStarted(self) then Exit;
  if TotalQty =0 then exit;

  if self <> rootnode then begin
    if (children.Count >0) and (PartsID>0) then begin
      fdQty:= tcdatautils.ProductinstockQty(PartsID,Storer.connection, 0 , TreePartUOM, classId);
      if (fdQty<>0) then begin
        fdManufactureUOMQty :=0;
        if  (fdQty <= TotalQty) then FromStockQty :=fdQty
        else FromStockQty :=TotalQty;
        {fdManufactureUOMQty := TreePartUOMTotalQty - FromStockUOMQty;
        fdOnOrderUOMQty:=0;}
        ManufactureQty := TotalQty - FromStockQty;
        OnOrderUOMQty:=0;
      end;
    end;
  end;
 { if Children.Count >0 then
    for x:= 0 to Children.Count -1 do
      if Children[x] is TSalesLineProcTree then
        TSalesLineProcTree(Children[x]).UpdateDefaultQty;}
end;*)

procedure TSalesLineProcTree.Calccost(const SkipCustom: boolean = true);
begin
if isroot and not(Anydirty) then exit;
{NOTE: THIS IS USED FOR VERIFY N FIX ONLY
THIS FUNCTION IS USED TO RECALCULATE THE COST BASED ON THE USED 'PRODUCT'S COST1 INSTEAD OF AVG COST'
THIS SHOULD NOT BE CALLED FROM THE NORMAL TRANSACTIONS AS THE NORMAL TRANSACTIONS SHOULD USE AVG COST
binny}
    inherited;
    if Owner is TSalesLineBase then begin
      TSalesLineBase(Owner).LineCost:= Round(DivZer(Cost,ManufactureQty),GeneralRoundPlaces);
      TSalesLineBase(Owner).PostDB;
    end;
end;

procedure TSalesLineProcTree.CompareTrees;
function Transtype:String;
begin
       if mastertype = mtsaleSOrder then result := 'SalesOrder'
  else if mastertype = mtInvoice then result := 'Invoice'
  else result := 'Quote';
end;
begin
  DoAuditTrial(TProcTreeNode(CleanTree), Self , MasterRef, Transtype, TRansRef);

end;

constructor TSalesLineProcTree.Create(AOwner: TComponent);
var
  id: integer;
begin
  inherited;
  fbConvertCurrent:= False;
  DoNotCreateSmartOrder := False;
  try
  Except end;
  ficleanId :=0;
  fbCalcTreePrice := False;
  fbCalcTreeCost:= False;
  fbChangeTreeqty:= False;
  fSalesLine := nil;
  fSales := nil;
  fProcTreePartInitialised:= false;
  fDeleted:= false;
  Options := Options + [opSave, opValidateData, opLoad, opNew, opEdit, opDelete, opDirty, opCancel, opXML];
  if (Owner is TSalesLineBase) and (TSalesLineBase(owner).Id > 0) then begin
    id:= TreeRootIdForSaleLineId(TSalesLineBase(owner).Id,self.Storer.Connection);
    if id > 0 then begin
      doSalesLineProcTreeIDchange;
      self.Load(id);
    end;
  end;
end;


function TSalesLineProcTree.RelatedRecordsDeleteSQL: String;
begin
  Result := ' Delete from tblbarcodexref  ' +
            ' where barcodetype = ' + Quotedstr(BarCodeType_WorkOrder)+
            ' and intvalue1 = ' +  inttostr(proctreeId)  +';'+
            ' Delete from tblprocProgress  where ifnull(ProctreeId,0) = '+  inttostr(proctreeId) +';';
end;

procedure TSalesLineProcTree.DeleteNoCheck;
begin
try
  if ProcTreePartCount> 0 then begin
  //if Assigned(ProcTreePart) then begin
    fProcTreePart.Delete;
  end;
  if self = rootnode then
    DeleteCleanTree(self);
Except
  // kill the exception in case if the record is already deleted
end;
  inherited;
end;

procedure TSalesLineProcTree.Deletetree;
var
  s:String;
  //Qry :TERPQuery;
  ProcTreeIds, ProctreePartIDs,PQAIds:String;
begin
  inherited;

  if TSalesLineProcTree(Self).saleLineID =0 then begin
    exit;
  end;
  ProcTreeIds:='';
  ProctreePartIDs:='';
  PQAIds:='';

  with Storer.getNewDataset do try
    s:= 'SELECT `ProcTreeId` FROM `tblProcTree` WHERE mastertype <> "mtProduct" and `MasterId` = ' + IntToStr(TSalesLineProcTree(Self).saleLineID);
    ProcTreeIds:= OpennGroupconcat(s , 'ProcTreeId');
    if ProcTreeIds <> '' then begin
      s:= 'Select  ProctreePartID from `tblProctreePart`  WHERE `ProcTreeId` IN   (' + ProcTreeIds +')';
      ProctreePartIDs:= OpennGroupconcat(s, 'ProctreePartID');
    end;

    if ProctreePartIDs<> '' then begin
      s:= 'Select PQAID from tblPQA where TRanstype in(' + ManufactureTypes +') and TransLineId in (' + ProctreePartIDs +')';
      PQAIds:= OpennGroupconcat(s,'PQAID');
    end;

    s:= '';
    if PQAIds          <> '' then  s:=    'Delete from tblPQA           where PQAID           in (' + PQAIds          +');';
    if ProctreePartIDs <> '' then  s:= s+ 'Delete from tblProctreePart  where ProctreePartID  in (' + ProctreePartIDs +');';
    //if ProcTreeIds     <> '' then  s:= s+ 'Delete from tblprocTree      where ProcTreeId      in (' + ProcTreeIds     +');';
    if s<>'' then  Storer.RunSQLCommand(s);

  finally
    if Active then close;
    Free;
  end;
end;

destructor TSalesLineProcTree.Destroy;
begin
  if assigned(fSales) then fSales.DoSalesLineProcTreeDestroy;
  fSales := nil;
  fSalesLine := nil;
  inherited;
end;
procedure TSalesLineProcTree.ResetProcessStep;
var
  x:Integer;
begin
  for x:= 0 to ProcessStepList.Count -1 do begin
    ProcessStepList.Item[x].TimeEnd:=0;
    ProcessStepList.Item[x].TimeStart:=0;
    ProcessStepList.Item[x].Status := psNotScheduled;
  end;
  if Children.Count >0 then
    for x:= 0 to Children.Count -1 do
      if Children[x] is TSalesLineProcTree then
        TSalesLineProcTree(Children[x]).ResetProcessStep;
end;
procedure TSalesLineProcTree.Initformulafields;
var
  x:Integer;
begin
  if ProductHAsFormula then begin
    BuildFormulaQtyValue1:= FormulaQtyValue1;
    BuildFormulaQtyValue2:= FormulaQtyValue2;
    BuildFormulaQtyValue3:= FormulaQtyValue3;
    BuildFormulaQtyValue4:= FormulaQtyValue4;
    BuildFormulaQtyValue5:= FormulaQtyValue5;

    OrderFormulaQtyValue1:= FormulaQtyValue1;
    OrderFormulaQtyValue2:= FormulaQtyValue2;
    OrderFormulaQtyValue3:= FormulaQtyValue3;
    OrderFormulaQtyValue4:= FormulaQtyValue4;
    OrderFormulaQtyValue5:= FormulaQtyValue5;

    FormulaQtyValue1:= FormulaQtyValue1;
    FormulaQtyValue2:= FormulaQtyValue2;
    FormulaQtyValue3:= FormulaQtyValue3;
    FormulaQtyValue4:= FormulaQtyValue4;
    FormulaQtyValue5:= FormulaQtyValue5;

  end;
  if Children.Count > 0 then
    for x:= 0 to Children.Count -1 do begin
      TSalesLineProcTree(Children[x]).Initformulafields;
    end;
end;
procedure TSalesLineProcTree.updateprice;
begin
  inherited;
end;

procedure TSalesLineProcTree.DoEvent(const Sender: TObject;const EventType: integer; const Data: TObject= nil;  Proc : TProcBusObjBase= nil);
var
  TreeRootId: integer;
  NewLineTree: TSalesLineProcTree;

  procedure CheckQty(DoCalculatePrice: boolean = true);
  begin
    if (SalesLine.ClassName = 'TQuoteLine') then begin
      if (SalesLine.UOMQtySold <> Quantity) then begin
        Quantity:= SalesLine.UOMQtySold;
        if DoCalculatePrice then
          CalcPrice;
        BuildDetails;
      end;
    end
    else if (SalesLine.UOMQtyShipped <> Quantity) then begin
      if ProductionSchedOrStarted(self) then
        if not (DEvmode) then self.ResultStatus.AddItem(false,rssWarning,0,
        'This is a manufactured product with production that has been scheduled or started.' + CRLF +
        'Please cancel your changes and make sure there is no production scheduled before editing this order.');
      TreePartUOMQuantity:= SalesLine.UOMQtyShipped;
      if DoCalculatePrice then
        CalcPrice;
      BuildDetails;
    end;
  end;

  function  PartsourceStock:boolean;
  begin
    {binny : default partsource based on the Preference and user confirmation based on the available Qty}
    result := Sales.PartsourceStock;
  end;

  Procedure Maketree;
  begin
    if (self.Id > 0) then begin
      if ProductionSchedOrStarted(self) then
        if not (DEvmode) then self.ResultStatus.AddItem(false,rssWarning,0,
        'This is a manufactured product with production that has been scheduled or started.' + CRLF +
        'To avoid deletion of this information please cancel your changes.');
      self.Deleted:= true;
      try
        self.SaveNoCheck;
        self.PostList.Execute;
        self.Delete;
        self.Children.Clear;
        self.ProcessStepList.Clear;
        self.ClearIds;
      Finally
        if PArtsId=0 then
          self.Deleted:= False;
      end;
    end;
    { does this product have a tree }
    //TreeRootId:= TProductProcTree(TSalesLineBase(Owner).Product.Container.ItemByClass(TProductProcTree)).Id;
    TreeRootId:= TreeRootIdForProductTemplate(TSalesLineBase(Owner).ProductID);
    if (TreeRootId > 0)  then begin
      if PartsourceStock then exit;
      ProcessStepList.Clear(true);
      ProcessStepList:= nil; { .. so it will be reloaded when it is created }
      ProcTreeId:= TreeRootId;
      LoadTree(False , False);
      CalcQtyFromformulaTree;
      CalcTotalQty;
      updateprice;
      Initformulafields;
      self.Deleted:= False;
      { clear Ids so a copy of the tree structure will be saved linked to this sale line }
      ClearIds;
      SaleLineId:= TSalesLineBase(Sender).Id;
      if Sender.ClassNameIs('TQuoteLine') then
        MasterType:= mtQuote
      else if Sender.ClassNameIs('TSalesOrderLine') then
        MasterType:= mtSalesOrder
      else if Sender.ClassNameIs('TInvoiceLine') then
        MasterType:= mtInvoice
      else
        raise Exception.Create('TSalesLineProcTree.DoEvent (evSalesLineProductChange) - Invalid line class type: "' + Sender.ClassName + '"');
      MasterId:= SaleLineId;
      IsTemplate:= false;
      fsProgressMsg := 'Making Tree';
      //UpdateDefaultQty;
      Logtree('Maketree');
      self.SaveNoCheck;
    end;
  end;
  Procedure ClearTreeQtys;
  begin
    TreePartUOMTotalQty := 0;
    TreePartUOMQuantity := 0;
    ManufactureUOMQty:=0;
    ManufacturedUOMQty:=0;
    //ManufacturingUOMQty:=0;
    FromStockUOMQty := 0;
    OnOrderUOMQty :=0;
    CalcQty;
  end;

  Procedure DoOnlyManufacture;
  begin
    if (ManufactureUOMQty = SalesLine.UOMQtyShipped) then exit;
    ManufactureUOMQty :=SalesLine.UOMQtyShipped;
  end;

  Procedure ReadSaleslines;
  var
    QtyVariationSave: double;
  begin
    if (TreePartUOMQuantity = SalesLine.UOMQtyShipped) and (TreePartUOM =  SalesLine.UnitOfMeasure) and (TreePartUOMID = SalesLine.UnitOfMeasureID)  then exit;
    fbUpdatingQty := true;
    try
      TreePartUOM:= SalesLine.UnitOfMeasure;
      TreePartUOMID := SalesLine.UnitOfMeasureID;
      //dene - clear qtys in the tree so that the fromstock/onorder/tobuild qtys will be reassigned based on the product availability
      // this will clear all existing allocations

      QtyVariationSave := QtyVariation;
      try
        QtyVariation := 0;
        ClearTreeQtys;
      finally
        QtyVariation := QtyVariationSave;
      end;

      TreePartUOMMultiplier := SalesLine.UOMMultiplier;
      TreePartUOMTotalQty := SalesLine.UOMQtyShipped;
      TotalQty :=SalesLine.QtyShipped;
      TreePartUOMQuantity := SalesLine.UOMQtyShipped;
      ManufactureUOMQty :=  TreePartUOMQuantity-  (FromStockUOMQty+OnOrderuomQty);
      CalcQty;

      CalcQtyFromformulaTree;
    finally
      fbUpdatingQty:= False;
    end;
      if TreePartUOMQuantity =0 then begin
        ManufactureUOMQty:=0;
        ManufacturedUOMQty:=0;
        //ManufacturingUOMQty:=0;
        FromStockUOMQty := 0;
        OnOrderUOMQty :=0;
      end else begin
        AllocateAvailableQty;
        ValidateQty(cqstock);
      end;
      CalcQty;
  end;
begin
      inherited;
      case EventType of
    { 1:}evDSBeforeDelete:
          begin

          end;
    { 2:}evSalesLinePartsourceChange:
          begin
          {binny:Changing the partsource from stock to manufacture -
          initialed from OrdersFromStock list }
            Maketree;
            CheckQty(false);
          end;
    { 3:}evSalesLineProductChange:
          begin
            if (self.PartsId <> TSalesLineBase(Owner).ProductId) then begin
              { existing tree for different product for this line ... so delete it }
              maketree;
            end;
          end;
    { 4:}evSalesBuildWhole:
          if IsRoot and (Caption <> '') then begin
              DoOnlyManufacture;
              CheckQty;
              if TSalesLineBase(Owner).Product.SellQty1Price = 0 then
                TSalesLineBase(Owner).OriginalLinePrice:= Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces);
            end;
    { 5:}evSalesAfterGetBaseLinePrice:
          begin
            {  sales line

             is re-calculating line price so we need to set it back to
               tree  price }
            if not ConvertCurrent then begin
              if IsRoot and (Caption <> '') then begin
                ReadSaleslines;
                CheckQty;
                if TSalesLineBase(Owner).Product.SellQty1Price = 0 then
                  TSalesLineBase(Owner).OriginalLinePrice:= Round(DivZer(Price,ManufactureQty),GeneralRoundPlaces);
              end;
            end;
          end;
    { 6:}evSalesLineMakeCleanTree:
          begin
            //if ProcPrefs.WastageCalculationEnabled  then begin
              fsProgressMsg := 'Making Clean Tree';
              ///Savenocheck;
              DeleteCleanTree(self);
              MakeCleanTree(self);
            //end;
          end;
    { 7:}evSalesLineCalcTreePrice:
          begin
            fbCalcTreePrice:= True;
            try
              CalcPrice;
            finally
              fbCalcTreePrice := False;
            end;
          end;
    {7.1:}evSalesLineCalcTreecost:
          begin
            fbCalcTreeCost:= True;
            try
              CalcCost;
              Savenocheck;
            finally
              fbCalcTreeCost := False;
            end;
          end;
    {7.2:}evSalesLineFixTreecost:
          begin
            fbCalcTreeCost:= True;
            try
              undoCalcCost;
              Savenocheck;
            finally
              fbCalcTreeCost := False;
            end;
          end;


    { 8:}evSalesLineAfterGetBaseLineCost:
          begin
            if IsRoot and (Caption <> '') then begin
              ReadSaleslines;
              CheckQty;
              //TSalesLineBase(Owner).LineCost:= Round(Cost,GeneralRoundPlaces);
              TSalesLineBase(Owner).LineCost:= Round(DivZer(Cost,ManufactureQty),GeneralRoundPlaces);
            end;
          end;
    { 9:}evSalesLineUOMChange:
          begin
            if IsRoot and (Caption <> '') then begin
             ReadSaleslines;
              CheckQty;
            end;
          end;
    {10:}evSalesLineQtyChange:
          begin
            fbChangeTreeqty:= True;
            try
              if not ConvertCurrent then begin
                if IsRoot and (Caption <> '') then begin
                  fdTreePartUOMQuantity :=0; // make it 0 to make the eent happen
                  ReadSaleslines;
                  //UpdateDefaultQty;
                  ProcTreePart;
                  CheckQty;
                  fsProgressMsg := 'Sales Qty Changed';
                  fbCalcTreePrice:= True;
                  try
                    CalcPrice;
                  finally
                    fbCalcTreePrice := False;
                  end;
                  Savenocheck;
                  TSalesLineBase(Owner).TreeQtyChanged;
                  Logtree('SalesLineQtyChange');
                end;
              end;
            finally
              fbChangeTreeqty:= False;
            end;
          end;
    {11:}evSalesLineClonePropertyObjects:
          begin
            if IsRoot and (Caption <> '') then begin

              NewLineTree:= TSalesLineProcTree(TSalesLineBase(Data).Container.ItemByClass(TSalesLineProcTree, false));
              if Assigned(NewLineTree) then begin
                NewLineTree.Assign(self);
                NewLineTree.MasterId:= TSalesLineBase(Data).Id;
                NewLineTree.SaleLineId:= TSalesLineBase(Data).Id;
                NewLineTree.ResetProcessStep;
                if Data.ClassNameIs('TQuoteLine') then
                  NewLineTree.MasterType:= mtQuote
                else if Data.ClassNameIs('TSalesOrderLine') then
                  NewLineTree.MasterType:= mtSalesOrder
                else if Data.ClassNameIs('TInvoiceLine') then begin
                  NewLineTree.MasterType:= mtInvoice;
                  {Link TProcTreePart records to new tree}

                end
                else
                  raise Exception.Create('TSalesLineProcTree.DoEvent (evSalesLineProductChange) - Invalid line class type: "' + Data.ClassName + '"');
                NewLineTree.Complete := False;
                NewLineTree.AllocateAvailableQty;
                NewLineTree.CalcQty;
                NewLineTree.SaveNoCheck;
              end;
            end;
          end;
    {12:}evSalesLineDeletedChange:
          begin
            if IsRoot and (Caption <> '') then begin
              Deleted:= SalesLine.Deleted;
            end;
          end;
    {13:}evSalesLineShipDateChange:
          begin
            if IsRoot and (Caption <> '') then begin
              SetTreeDateRequired(self,Sales.Saledatetime);
              if ProductionSchedOrStarted(self) then
                if not (DEvmode) then self.ResultStatus.AddItem(false,rssWarning,0,
                'This is a manufactured product with production that has been scheduled or started.' + CRLF +
                'Please cancel your changes and make sure there is no production scheduled before editing this order.');
            end;
          end;
    {14:}evSalesLinecheckForTree:
          begin
              if IsRoot and (Caption <> '') and (children.count<>0) then begin
                Sales.Lines.HAsTree:= True;
              end;
          end;
    {15:}evProductSelected:
          begin
            if Assigned(fProcTreePart) and (fProcTreePart.Count>0) then
              fProcTreePart.DeleteAll;
            fProcTreePartInitialised := False;
          end;
    {16:}evBOMMergingLine:
          begin
            if Sales is TSalesOrder then
              BOMGroupedLine := TSalesOrder(Sales).Lines.BOMGroupedLine;
          end;
    {17:}evBOMProductionLine:
          begin
            if Sales is TSalesOrder then
              BOMProductionLine := TSalesOrder(Sales).Lines.BOMProductionLine;
          end;
    {18:}evupdateCustomerEquipQty:
         begin
          if IsRoot and (Caption <> '') and (ProcTreePart.count>0) and (ProcTreePart.isPQAItem) and (ProcTreePart.Product.SnTracking) then
            ProcTreePart.PQA.PQASN.IterateREcords(Sales.updateCustomerEquipQty);
         end;
    {21}evSalesDateChange:
        begin
          if Sales is TSalesOrder then
            CheckProcessTransDate;
        end;
    {22}evSalesReadBOMPrice:
          if IsRoot then
            TSalesOrder(Sales).Lines.BOMPrice := Price;
      end;
end;

procedure TSalesLineProcTree.doSalesLineProcTreeIDchange;
begin
  Sales;
  if assigned(fSales) then
    fSales.doSalesLineProcTreeIDchange;
end;

function TSalesLineProcTree.FirstShipDate: TDateTime;
begin
  result:= SalesLine.TransDate;
  if (Sales.Saledatetime > 0) and (Sales.Saledatetime < result) then
    result:= Sales.Saledatetime;
  if result = 0 then
    result:= Now;
end;

function TSalesLineProcTree.getCalcTreePrice: Boolean;
begin
  if Assigned(owner) and (Owner is TSalesLineProcTree) then
    Result := TSalesLineProcTree(owner).CalcTreePrice
  else Result := fbCalcTreePrice;
end;

function TSalesLineProcTree.getclasssID: Integer;
begin
  REsult := SalesLine.ClassId;
end;

function TSalesLineProcTree.getConvertCurrent: boolean;
begin
  if Assigned(owner) and (Owner is TSalesLineProcTree) then result := TSalesLineProcTree(Owner).ConvertCurrent
  else if Assigned(owner) and (Owner is TSalesOrderLine) then result := TSalesOrderLine(Owner).ConvertCurrent
  else result := fbConvertCurrent;
end;

function TSalesLineProcTree.GetDeleted: boolean;
begin
  result:= fDeleted;
end;



function TSalesLineProcTree.getForcePQACreationonSave: Boolean;
begin
  Result := fbForcePQACreationonSave;
  if Assigned(Owner) then
    if owner is TSalesLineProcTree then
      result := TSalesLineProcTree(Owner).ForcePQACreationonSave;

end;

function TSalesLineProcTree.GetProcTreePart: TProcTreePart;
begin
  result:= inherited GetProcTreePart;
  if Assigned(result) and (not fProcTreePartInitialised) then begin
    fProcTreePart.PostList:= SalesLine.PostList;
    if fProcTreePart.SaleLineId <> SalesLine.Id then
      fProcTreePart.SaleLineId:= SalesLine.Id;
    if fProcTreePart.SaleId <> SalesLine.SaleId then
      fProcTreePart.SaleId:= SalesLine.SaleId;
    if (fProcTreePart.DateRequired = 0) then
      fProcTreePart.DateRequired:= FirstShipDate;
    if fProcTreePart.ClassId <> self.SalesLine.ClassId then
      fProcTreePart.ClassId:= self.SalesLine.ClassId;
    fProcTreePartInitialised:= true;
    fProcTreePart.PostDB;
    if assigned(fProcTreePart) then
      if (fProcTreePart.ProductID<> self.PartsId) and (fProcTreePart.ProductID<>0) then
        Sales.SendEmailtoErp(BusObjProcTreePartWrongProduct);
  end;
end;


function TSalesLineProcTree.getSales: TSalesBase;
begin
  if assigned(fSales) then else begin
    SalesLine;
    if assigned(SalesLine) then
      fSales:= TSalesBase(SalesLine.owner);
  end;
  result := fSales;
end;

function TSalesLineProcTree.getSalesLine: TSalesLineBase;
begin
  if assigned(fSalesLine) then
  else fSalesLine:= TSalesLineBase(self.RootNode.Owner);
  result := fSalesLine;
end;

function TSalesLineProcTree.GetStorer: TBusObjStorer;
begin
  Result := inherited GetStorer;
end;

procedure TProcTreeNode.logit(Printheader:boolean =False;Lognodename:String =''; Dochildren:Boolean =true);
var
  s:String;
  ctr:Integer;
begin
  if Printheader then begin
    s:= 'Caption' +#9 +
        'Object'+#9 +
        'ProcTreeId'+#9 +
        'Description '+#9 +
        'Info '+#9 +
        'comments '+#9 +
        'PartsId '+#9 +
        'TreePartUOM '+#9 +
        'TreePartUOMQuantity'+#9 +
        'TreePartUOMTotalQty'+#9 +
        'FromStockUOMQty'+#9 +
        'ManufactureUOMQty' + #9 +
        'OnOrderUOMQty'+#9 +
        'FromStockQty'+ #9 +
        'ManufactureQty'+#9 +
        'OnOrderQty'+#9 +
        'ProcesspartID'+#9 +
        'partname'+#9 +
        'Qty'+#9 +
        'PQAID'+#9 +
        'Productname'+#9 +
        'Qty'+#9 +
        'Active';
  end;
  if (lognodename = '') or (Sametext(lognodename , caption)) then begin
    s:= Caption +#9 +inttostr(integer(Self))+#9 +
        inttostr(ProcTreeId)+#9 +
       Description+#9 +
      Info+#9 +
      comments+#9 +
      inttostr(PartsId)+#9 +
      TreePartUOM +#9 +
      floattostr(TreePartUOMQuantity)+#9 +
      FloatTostr(TreePartUOMTotalQty)+#9 +
      Floattostr(FromStockUOMQty)+#9 +
      floattostr(ManufactureUOMQty)+#9 +
      floattostr(OnOrderUOMQty)+#9 +
      Floattostr(OnOrderUOMQty)+#9 +
      floattostr(OnOrderUOMQty)+#9 +
      Floattostr(OnOrderUOMQty);
    if ID =0 then exit;
      if Assigned(ProcTreePart) then begin
        s:= s+ #9 +inttostr(ProcTreePart.ID) +#9 +
                ProcTreePart.ProductName +#9 +
                floatTostr(ProcTreePart.Qty) ;
        if ProcTreePart.IsPQAItem then begin
          s:= s +#9 +inttostr(ProcTreePart.PQA.ID) +#9 +
                ProcTreePart.PQA.ProductName +#9 +
                floatTostr(ProcTreePart.PQA.Qty) ;
        end;
      end;
  end;
  if Dochildren then
    if children.count >0 then
      for ctr := 0 to children.count-1 do
        if children[ctr] is TProcTreeNode then
          TProcTreeNode(children[ctr]).logit(false, lognodename , true);
end;

function TProcTreeNode.FindnodeforDetails(sNodeDetails:String):TProcTreeNode;
var
  x:Integer;
begin
  result:= nil;
  if Sametext(nodedetails, snodedetails) then begin
    result :=self;
  end else begin
   for x:= 0 to Children.Count -1 do begin
      result:= TProcTreeNode(Children[x]).FindnodeforDetails(snodedetails);
      if assigned(result) then break;
   end;
  end;
end;

function TProcTreeNode.findProcessstep(processstepID: Integer): TProcessPartNDS;
var
  x:Integer;
begin
  result:=nil;
  for x:= 0 to ProcessStepList.Count -1 do begin
    if ProcessStepList[x].ProcessStepID = processstepID then begin
      result := ProcessStepList[x];
      exit;
    end;
  end;

end;

function TProcTreeNode.getNodeDetails: String;
begin
  result := inttostr(Level)+'#'+Caption + '#' + inttostr(PartsId)+ '#' + BooleanToStr(Selected);
end;

function TProcTreeNode.getparentnodeDetails: String;
begin
  result:='';
  if not(Assigned(ParentNode)) then exit;
  REsult := ParentNode.nodedetails;
end;

Procedure TProcTreeNode.MergeTree(Target:TProcTreenode);
var
  targetnode, child:TProcTreenode;
  x:Integer;
begin
  if self = rootnode then
    targetnode := TProctreenode(Target.rootnode)
  else targetnode:= Target.FindnodeforDetails(self.NodeDetails);
  if Assigned(targetnode) then begin
    targetnode.Loading:= True;
    try
      targetnode.quantity         := targetnode.quantity + Quantity;
      targetnode.TotalQtyOriginal := targetnode.TotalQtyOriginal  + TotalQtyOriginal;
      targetnode.TotalQty         := targetnode.TotalQty + totalQty;
      targetnode.FromStockQty     := targetnode.FromStockQty + FromStockQty;
      targetnode.OnOrderQty       := targetnode.OnOrderQty + OnOrderQty;
      targetnode.ManufactureQty   := targetnode.ManufactureQty  + ManufactureQty ;
      targetnode.ManufacturedQty  := targetnode.ManufacturedQty  + ManufacturedQty ;
      targetnode.TreePartUOMQuantity := targetnode.TreePartUOMQuantity + TreePartUOMQuantity;
      targetnode.TreePartUOMTotalQty := targetnode.TreePartUOMTotalQty + TreePartUOMTotalQty;
    finally
      targetnode.Loading := False;
    end;
    targetnode.UpdateProcessPart;
    MergeProcess(targetnode);
    for x:= 0 to Children.Count -1 do
      TProcTreeNode(Children[x]).MergeTree(Target);
  end else begin
    targetnode:= Target.FindnodeforDetails(parentNodeDetails);
    if not(Assigned(targetnode)) then targetnode := TProctreenode(Target.rootnode);
    if Assigned(targetnode) then begin
      child:= TProcTreenode(Targetnode.MakeInstance);
      Child.assign(self);
      targetnode.Children.Add(child);
    end;
  end;
end;

Procedure TProcTreeNode.MergeProcess(targetnode:TProctreenode);
begin

end;
Function TProcTreeNode.updateProcessParttimesheet(ProcessPartID: Integer):Boolean;
begin
  REsult := TProcessPartTimesheet.StopAllOpenJobs(ProcessPartID, Storer.Connection);
end;
function TProcTreeNode.getProducthasformulaEntry: Boolean;
begin
  Result :=Product.formulaID <> 0;
end;
function TProcTreeNode.GetClientDiscountObj: TClientDiscountObj;
begin
  if not Assigned(fObjClientDiscount) then begin
    fObjClientDiscount := TClientDiscountObj.Create;
  end;
  Result := fObjClientDiscount;
end;
procedure TProcTreeNode.updateprice;
var
  x:Integer;
begin
  for x:= 0 to ProcessStepList.Count -1 do begin
    ProcessStepList[x].HourlyOverheadRate := ProcessStepList[x].ProcResourceProcessDetails.ProcResource.HourlyOverheadRate;
    ProcessStepList[x].HourlyLabourRate := ProcessStepList[x].ProcResourceProcessDetails.ProcResource.HourlyLabourRate;
  end;
  if children.Count>0 then begin
    for x:= 0 to children.Count-1 do begin
      TProcTreeNode(Children[x]).updateprice;
    end;
  end else begin

    if partsID>0 then begin
        ProductUnitCost:=Round(TProduct.AvgCost(PartsId, self.Storer.Connection),GeneralRoundPlaces);
        if math.IsZero(ProductUnitCost,0.000001) then
          ProductUnitCost:= Round(TProduct.Cost(PartsId, self.Storer.Connection),GeneralRoundPlaces);

         if (TreePricechanged=False) or (ProductUnitPrice =0) then ProductUnitPrice := Round(TProduct.PriceForQty(PartsId, Quantity, self.Storer.Connection),GeneralRoundPlaces);
    end;
  end;
end;
procedure TSalesLineProcTree.MergeProcess(targetnode:TProcTreeNode);
var
  x:Integer;
  PP: TProcessPartNDS;
begin
  if not(Targetnode is TSalesLineProcTree) then exit;
  for x:= 0 to ProcessStepList.Count -1 do begin
    //pp:= ProcessStepList[x];
    pp:= TSalesLineProcTree(targetnode).findProcessstep(ProcessStepList[x].ProcessStepID);
    if assigned(pp) then begin
      pp.Duration := pp.Duration + ProcessStepList[x].Duration;
      pp.SetupDuration:=pp.SetupDuration + ProcessStepList[x].SetupDuration;
      pp.BreakdownDuration:=pp.BreakdownDuration + ProcessStepList[x].BreakdownDuration;
    end else begin
      pp:= TSalesLineProcTree(targetnode).ProcessStepList.AddProcessPart;
      pp.Assign(ProcessStepList.Item[x]);
    end;
    //pp.Assign(TProcTreeNode(Source).ProcessStepList.Item[x]);
  end;
end;
function TSalesLineProcTree.ProductQty(const fiPartsID: Integer; Qtytype :TQtytype): Double;
begin
    With TempMyquery do try
      SQL.add('Select ' +SQL4Qty(Qtytype) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where P.PartsId = ' + intToStr(fiPartsID)+
              //' and not (PQa.transtype in (' + SalesTransTypes +',' + ManufactureTypes+' ) and PQa.transId = ' + inttostr(Sales.ID) +' and PQa.TranslineId in ('+ SalesLine.SalesTreePartIDs+'))' +
              ' and PC.Classid = ' + inttostr(Classid));
      Open;
      result := fieldbyname('Qty').Asfloat;
    finally
      if active then Close;
      Free;
    end;
end;

procedure TSalesLineProcTree.MultiEventHandler(Sender: TObject;  const Event, Value: string);
begin
  if Sysutils.SameText(Event, Storer_save) then begin
    if not silentmode then
      DoStepProgressbar(Value);

  end;
end;

procedure TSalesLineProcTree.OnBeforechangeStatus(Oldstatus,  NewStatus: TProcessPartStatus);
begin
  inherited;
  if (Oldstatus = psNotScheduled) and (newStatus <> psNotScheduled) then
    if Assigned(Rootnode) and (Rootnode is TSalesLineProcTree)  and (not(TSalesLineProcTree(rootnode).AnyScheduled)) then
      TSalesLineProcTree(rootnode).LockQty;

end;

function TSalesLineProcTree.OptionItem: Boolean;
begin
  result :=inputType =itOption;
end;
Procedure TSalesLineProcTree.MakeJEforManCOGSDiff;
begin
  Sales;
  if Assigned(fSales) then begin
    if Assigned(fSales.MakeJEforManCOGSDiff) then
      fSales.MakeJEforManCOGSDiff(Self);
  end;
end;
procedure TSalesLineProcTree.VarifyMastertype(Value: TMSBusObjMasterType);
var
  x: integer;
begin
  if self.Loading then exit;
  MasterType:= Value;
  for x:= 0 to Children.Count -1 do Children[x].MasterType:= Value;
end;


function TSalesLineProcTree.DoAccountPosting(var PostDesc: string):Boolean;
var
  msg: string;
begin
  if Assigned(SalesLine) then
    if (SalesLine is TSalesOrderline) and TSalesOrderline(SalesLine).ConvertCurrent then exit; // dont need these posting
                //if Complete then begin
                  PostDesc:= '';
                  if Assigned(SalesLine) then begin
                    if Assigned(SalesLine.Owner) and (SalesLine.Owner is TSalesBase) then
                      PostDesc:= TSalesBase(SalesLine.Owner).CustomerName;
                  end;
                  CleanId := ID;
                  try
                    result:= DoTreeAccountPosting(self,self.Storer.Connection,msg,PostDesc  );
                    MakeJEforManCOGSDiff;
                    //COGSFixDone := True;
                  finally
                    cleanId :=0;
                  end;
                  if result then begin
                    if ManufactureUOMQty<> 0 then begin
                      TProduct.UpdateAvgCosts(ProcTreePart, ProcTreePart.Connection , ProcTreePart.Product.ID);
                      TProduct.UpdateManAvgCosts(ProcTreePart , ProcTreePart.Connection , ProcTreePart.Product.ID);
                      TProduct.UpdateManLatestCosts(ProcTreePart , round(Cost /ManufactureUOMQty/TreePartUOMMultiplier,5)  , ProcTreePart.PQA.TransDate, ProcTreePart.connection, ProcTreePart.Product.ID);

                    end;
                      //ProcTreePart.Product.UpdateAvgCosts;
                  end else begin
                    self.ResultStatus.AddItem(false,rssError,0,msg);
                    fCleanComplete:= false;
                  end;
                //end else begin
                  //TAccountPosting.DeletePosting(AccountPostingSource_Manufacturing, Self.Id, self.Storer.Connection);
                //end;
end;
procedure TSalesLineProcTree.DoAfterLoad;
begin
  inherited;
end;

function TSalesLineProcTree.SaveNoCheck: boolean;
var
  CompleteChanged: boolean;
  PostDesc: string;
begin
  if isroot and not(Anydirty) then begin
    result := true;
    Exit;
  end;
      result:= true;
      if isroot then
        Storer.MultiEventObj.AddMultiEvent(MultiEventHandler);
      try
        if not(silentmode) and Isroot and (TreeCount>1) then
            DoShowProgressbar(TreeCount , 'Please wait ' {$IFDEF DevMode}  + ':' +  ProgressMsg {$ENDIF},'Saving :' +caption, true)
        else DoStepProgressbar('Saving :' +caption);
        try
          try
            if self.Caption = '' then
              result:= true
            else begin
              CompleteChanged:= self.CleanComplete <> self.Complete;
              if isroot then begin
                Storer.MultiEventObj.FireEvent(Self , Storer_Save , 'Calculating Tree Price');
                CalcPrice;
              end;
              result:= inherited SaveNoCheck;
              if result then begin
                if ((ManufactureUOMQty<> 0) or (fromStockUOMQty <> 0) or (onorderqty <> 0)) then begin
                  if Assigned(ProcTreePart) then begin

                    if ProcTreePart.ProcTreeId <> self.Id then ProcTreePart.ProcTreeId:= self.Id;
                    if fDeleted then
                      ProcTreePart.Active:= false;
                    if ((not ProcTreePart.Active) and (ProcTreePart.Id < 1)) then
                      exit;
                    Try
                      if ForcePQACreationonSave then ProcTreePart.msTimeStamp := now;
                      result:= ProcTreePart.Save;
                    Except
                      // if the building qty changed and so the tree is deleted then ignore the exception
                    End;
                  end;
                end else begin
                  deletetree;
                end;
                if self.IsRoot then begin
                  if CompleteChanged then begin
                    result := DoAccountPosting(Postdesc);
                  end;
                end;
              end;
            end;
          finally
            if result then
              if isroot then
                if not DoNotCreateSmartOrder then
                  if Appenv.CompanyPrefs.AutoCreateSmartOrderFromSalesOrderTree then
                    DoOrder;
          end;
        finally
            if not(SilentMode) and isRoot then
              DoHideProgressbar;
        end;
      finally
        if isroot then
          Storer.MultiEventObj.RemoveMultiEvent(MultiEventHandler);
      end;
end;

procedure TSalesLineProcTree.SetComplete(const Value: boolean);
begin
  inherited;
end;


procedure TSalesLineProcTree.SetDeleted(const Value: boolean);
var
  x: integer;
begin
  if fDeleted <> value then begin
    fDeleted:= value;
    MakeDirty;
    if Assigned(ProcTreePart) then begin
      if value = true then BEGIN
        if ProcTreePart.count > 0 then ProcTreePart.Active:= false;
      END else begin
        { not deleted }
        if IsOptionNode and (not self.Selected) then
          ProcTreePart.Active:= false
        else begin
          ProcTreePart.Active:= true;
          if ProcTreePart.ProductID<>  self.PartsId then ProcTreePart.ProductID:= self.PartsId;
          if ProctreePart.SaleLineId <> SaleLineId then begin
            ProctreePart.SaleLineId := SaleLineId;
            ProcTreePart.SaleId     := SalesLine.SaleId;
          end;
          if Complete then
            ProcTreePart.PQA.Active:= true;
        end;
      end;
      ProcTreePart.PostDB;
    end;
  end;

  for x:= 0 to Children.Count -1 do begin
    TSalesLineProcTree(Children[x]).Deleted:= Value;
  end;
end;

procedure TSalesLineProcTree.SetBOMGroupedLine(const Value:boolean);
var
  x:Integer;
begin
  if fbBOMGroupedLine = value then exit;
  fbBOMGroupedLine := value;

  if Loading then exit;

  if Children.Count>0 then
    {the whole tree will have the same value for this flag}
    for x:= 0 to Children.Count -1 do begin
      if Children[x] is TSalesLineProcTree then
        TSalesLineProcTree(Children[x]).BOMGroupedLine:= Value;
    end;

  {to make the PQA inactive}
  if Assigned(ProcTreePart) then
      if ProcTreePart.count > 0 then begin
        ProcTreePart.BOMGroupedLine := Value;
        ProcTreePart.PostDB;
      end;
  MakeDirty;
end;

procedure TSalesLineProcTree.SetBOMProductionLine(const Value:boolean);
var
  x:Integer;
begin
  if fbBOMProductionLine = value then exit;
  fbBOMProductionLine := value;
  if Loading then exit;
  if Children.Count>0 then
    {the whole tree will have the same value for this flag}
    for x:= 0 to Children.Count -1 do begin
      if Children[x] is TSalesLineProcTree then
        TSalesLineProcTree(Children[x]).BOMProductionLine:= Value;
    end;

  {to make the PQA inactive}
  if Assigned(ProcTreePart) then
      if value = true then
        if ProcTreePart.count > 0 then begin
          ProcTreePart.BOMProductionLine := Value;
          ProcTreePart.PostDB;
        end;
  MakeDirty;
end;
procedure TSalesLineProcTree.setTotalQtyPlanned(const Value: Double);begin  if fdTotalQtyPlanned = value then exit;  fdTotalQtyPlanned := value;  if Loading then exit;  MakeDirty;end;
procedure TSalesLineProcTree.setWasteUOMQty(const Value: Double);begin  if fdWasteUOMQty = value then exit;  fdWasteUOMQty := value;  if Loading then exit;  MakeDirty;end;
procedure TSalesLineProcTree.setQtyPlanned(const Value: Double);begin if fdQtyPlanned = value then exit;  fdQtyPlanned := value;  if Loading then exit;  MakeDirty;end;

function TSalesLineProcTree.SmartOrderID: Integer;
begin
  result := 0;
  if sales = nil then exit;
  if sales.Id =0 then exit;
  With TempMyquery(Self.storer.connection) do try
    SQL.add('Select SmartOrderID from tblSmartOrder where SaleOrderID = ' + inttoStr(Sales.ID) +' and SalesGlobalref = ' +quotedstr(Sales.Globalref));
    open;
    Result := fieldbyname('smartOrderID').asInteger;
  finally
    closenFree;
  end;
end;

function TSalesLineProcTree.SourceFromStock: Boolean;
begin
  Result := False; //(manufactureUOMQty=0) and (mastertype = mtSalesorder) ; //Partsource = psStock;
end;
function TSalesLineProcTree.StatusList: TProcessPartStatusList;
begin
  result:= [];
  if BomGroupedLine then exit;
  self.ProcessStatus(result);
end;

function TSalesLineProcTree.TransRef: String;
begin
  Result := '';
  if Sales.ID = 0 then exit;
  With TempMyQuery do try
    connection := self.Storer.Connection;
    SQL.add('Select globalref from tblsales where SaleID = ' +inttostr(Sales.ID));
    open;
    Result := fieldbyname('globalref').asString;
  finally
    ClosenFree;
  end;

end;

function TSalesLineProcTree.HasOnOrderQty:boolean;
  var
    x: integer;
    child: TProcTreeNode;
begin
  REsult := False;
  if onOrderQty >0 then begin
    Result := True;
    Exit;
  end;
    for x:= 0 to Children.Count -1 do begin
        child:= TProcTreeNode(Children[x]);
        if ((InputType = itOption) and  (child.Selected)) or ((InputType <> itOption) or (child.Selected)) then begin
          Result :=   TSalesLineProcTree(child).HasOnOrderQty;
          if result then exit;
        end;
    end;

end;
function TSalesLineProcTree.isInternalOrder: boolean;
var
  Val: Variant;
begin
  REsult := inherited isInternalOrder;
  if Assigned(Sales) and  (Sales.classnameis('TSalesOrder')) then begin
    val:= GetPropValue(Sales, 'IsInternalOrder');
    if (not VarIsNull(val)) and (Val = 'True') then Result := True;
  end;
end;


procedure TSalesLineProcTree.Load(const fIsReadonly: boolean);
begin
  inherited;
end;

procedure TSalesLineProcTree.LockQty;
var
  x:Integer;
  child:TSalesLineProcTree;
begin
  QtyPlanned := Quantity;
  TotalQtyPlanned:= totalQty;
  if children.count =0 then exit;
  for x:= 0 to Children.Count -1 do begin
    child:= TSalesLineProcTree(Children[x]);
    Child.LockQty;
  end;
end;
function TSalesLineProcTree.DoOrder(SaleLineIDs:TIntegerList= nil; ProctreeIDs:TIntegerList= nil):Boolean;
var
  child: TProcTreeNode;
  SmartOrder:TSmartOrder;
  Procedure AddSmartOrderLine(node: TProcTreeNode);
  var
      x: integer;
  begin
    if SaleLineId =0 then exit;
    if node.Id=0 then exit;
    if mastertype <> mtsalesorder then exit;
    if node.nodeselectedinTree then
      if (node.OnOrderQty > 0) and (Salesline.deleted=False) and ((SaleLineIds =nil) or (SaleLineIds.Inlist(Salesline.ID))) then begin
        if (ProctreeIDs=nil) or (ProctreeIDs.InList(node.ProctreeId)) then begin
          if not(SmartOrder.Lines.Locate('SaleLineId;ProctreeId' , varArrayof([SaleLineId,node.Id]) , [])) then begin
            SmartOrder.Lines.New;
            SmartOrder.Lines.SaleLineID   := SaleLineID;
            SmartOrder.Lines.ProcTreeId   := node.Id;
          end;
          SmartOrder.Lines.PartsId         := node.PArtsID;
          SmartOrder.Lines.FormulaQtyValue1:= node.OrderFormulaQtyValue1;
          SmartOrder.Lines.FormulaQtyValue2:= node.OrderFormulaQtyValue2;
          SmartOrder.Lines.FormulaQtyValue3:= node.OrderFormulaQtyValue3;
          SmartOrder.Lines.FormulaQtyValue4:= node.OrderFormulaQtyValue4;
          SmartOrder.Lines.FormulaQtyValue5:= node.OrderFormulaQtyValue5;
          if node is TSalesLineProcTree then begin
            SmartOrder.Lines.CusJobName :=  TSalesBase(TSalesLineProcTree(node).SalesLine.Owner).CustomerName;
            SmartOrder.Lines.CusJobID   :=  TSalesBase(TSalesLineProcTree(node).SalesLine.Owner).CustomerID;
          end;
          if node.OrderFormulaQtyValue <> 0 then SmartOrder.Lines.FormulaQtyValue:= node.OrderFormulaQtyValue;
          SmartOrder.Lines.ClassID      := Sales.SaleClassId;
          SmartOrder.Lines.UnitOfMeasure := node.TreePartUOM;
          SmartOrder.Lines.ToPurchaseQtyexWastagePercentage := node.OnOrderQty;
          SmartOrder.Lines.PostDb;
        end else if ProctreeIDs=nil then begin
          if (SmartOrder.Lines.Locate('SaleLineId;ProctreeId' , varArrayof([SaleLineId,node.Id]) , [])) then begin
            SmartOrder.Lines.Deleted := True;
            SmartOrder.Lines.Postdb;
          end;
        end;
      end;
      for x:= 0 to node.Children.Count -1 do begin
          child:= TProcTreeNode(node.Children[x]);
          if ((node.InputType = itOption) and  (child.Selected)) or ((node.InputType <> itOption) or (child.Selected)) then begin
            AddSmartOrderLine(Child);
          end;
      end;
  end;
  Procedure DeleteLinkToSOPOofDeletedNodes;
  var
    deletedPTIds:TIntegerList;
  begin
    if smartorder.Lines.Count =0 then exit;
     With TERPQuery(SmartOrder.GetNewDataSet('select distinct proctreeId  from tblproctree where mastertype <> ''mtProduct'' and masterID = ' + inttostr(SalesLine.ID))) do try
      open;
      if recordcount = 0 then exit;
      deletedPTIds:=TIntegerList.Create;
      try
        DeletedPTIds.CommaText := Groupconcat('proctreeId');
        smartorder.Lines.first;
        while smartorder.Lines.EOf = False do begin
          if (smartorder.Lines.proctreeID<>0) and not(deletedPTIds.InList(smartorder.Lines.proctreeID))  and (smartorder.Lines.SalelineID = Salesline.ID) then begin
            smartorder.Lines.PODesc := smartorder.Lines.PODesc +'  :Product deleted From Tree';
            smartorder.Lines.ProctreeId := 0;
            smartorder.Lines.Postdb;
          end;
          smartorder.Lines.Next;
        end;
      finally
        Freeandnil(deletedPTIds);
      end;
     finally
       closenFree;
     end;
  end;
begin
  Result := True;

  if not (HasOnOrderQty) then exit;
  if not(mastertype = mtSalesOrder) then exit;
  if fbAddingtoTotalQty then exit;
  //if Assigned(Salesline) and (Salesline.deleted) then exit;

  SmartOrder:= TSmartOrder.Create(nil);
  try
    SmartOrder.Connection:= TMyDacDataConnection.Create(fProcTreePart);
    SmartOrder.Connection.Connection:= Storer.Connection;
    SmartOrder.IgnoreAccesslevel:= true;
    SmartOrder.LoadSelect('SaleOrderID = ' + inttoStr(Sales.ID) +' and SalesGlobalref = ' +quotedstr(Sales.Globalref) );
    if (SmartOrder.count=0) or (UserLock.Lock(SmartOrder.BusObjectTableName,SmartOrder.Id,'SalesOrder')) then begin
      try
        SmartOrder.Connection.BeginNestedTransaction;
        try
          if SmartOrder.count =0 then begin
            SmartOrder.New;
            SmartOrder.SaleOrderID    := Sales.ID;
            SmartOrder.SalesGlobalref := Sales.Globalref;
            //SmartOrder.SaleLineRef    := SalesLine.globalref;
            SmartOrder.SmartOrderDesc :='Production Requirements for Production Sale # ' +inttostr(Sales.ID);
            SmartOrder.PostDB;
          end;

          AddSmartOrderLine(Self);
          DeleteLinkToSOPOofDeletedNodes;
          if not(SmartOrder.Save) then begin
            SmartOrder.connection.RollbackNestedTransaction;
            Result := False;
            Exit;
          end;
          SmartOrder.Connection.CommitNestedTransaction;
          REsult := True;
        Except
          on E:EXception do begin
            Result := False;
            SmartOrder.connection.RollbackNestedTransaction;
          end;
        end;
      finally
         //UserLock.unLock(SmartOrder.BusObjectTableName,SmartOrder.Id,'SalesOrder')
      end;
    end else begin
      if (SmartOrder.count<>0) then
        ResultStatus.AddItem(false,rssError,0,replacestr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to update the smartOrder #' + inttostr(SmartOrder.ID)+'.'));
      Result := False;
    end;
  finally
    Freeandnil(SmartOrder);
  end;
end;
function TSalesLineProcTree.ValidateData: boolean;
begin
  if SalesLine.Deleted then begin
    result := true;
    exit;
  end;
  result:= inherited ValidateData;
  if result and Assigned(ProcTreePart) then begin
   result:= ProcTreePart.ValidateData;
  end;
end;
procedure TSalesLineProcTree.Logtree(const logTitle:String);
begin
  logtext(logTitle);
  logtext('========================================');
  Logtreeitem;
  logtext('========================================');
end;
procedure TSalesLineProcTree.Logtreeitem;
var
  ctr:Integer;
begin
  logtext(CaptionIntended +',' +
          floattostr(fdTreePartUOMtotalQty)+',' +
          floattostr(Quantity)+',' +
          floattostr(fdManufactureUOMQty)+',' +
          floattostr(fdFromStockUOMQty)+',' +
          floattostr(fdOnOrderUOMQty));
  if children.Count =0 then exit;
  for ctr := 0 to children.Count-1 do
    TSalesLineProcTree(Children[ctr]).Logtreeitem;
end;

{ TProductProcTree }

constructor TProductProcTree.Create(AOwner: TComponent);
begin
  inherited;
  Options := Options + [opSave, opValidateData, opLoad, opNew, opEdit, opDelete, opDirty, opCancel, opXML];

end;

procedure TProductProcTree.DoEvent(const Sender: TObject;  const EventType: integer; const Data: TObject= nil;  Proc : TProcBusObjBase= nil);
var
  TreeRootId: integer;
begin
  inherited;
  case EventType of
    evDSAfterOpen, evDSAfterAssignDataset,evDSAfterCreate:
      begin
        if IsOwnedbySalesLineProcTree  then else begin
          TreeRootId:= ProcessDataUtils.TreeRootIdForProductTemplate(TBusObj(Owner).Id);
          if (TreeRootId > 0)  then begin
            Id:= TreeRootId;
            LoadTree;
            CleanTree;
          end;
        end;
      end;
  end;
end;

procedure TProductProcTree.CalcPrice(const SkipCustom: boolean = true; Recalccost :Boolean = True;forceRecalc:Boolean =False);
begin
  inherited;
end;
function TProductProcTree.IsOwnedbySalesLineProcTree: Boolean;
var
  obj:TComponent;
begin
  result := false;
  try
    obj := self.owner;
    while (obj<> nil ) and (not (obj is TForm)) and (obj <> application) do begin
        if obj is TSalesLineProcTree then begin
           Result := true;
           Exit;
        end else obj := obj.owner;
    end;
  Except
      //kill the exception
  end;
end;

initialization
  RegisterClassOnce(TSalesLineProcTree);
  RegisterClassOnce(TProductProcTree);
end.
