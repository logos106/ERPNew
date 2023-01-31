unit busobjBOMSalesPieceRateConf;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  04/12/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusObjProcessPart, BusobjSales, BusObjBarcodeXRef , busobjproctree;


type
  (*TProcTree = class(TMSBusObj)
  private
    function GetTreeRootId               : Integer   ;
    function GetParentId                 : Integer   ;
    function GetMasterId                 : Integer   ;
    function GetMasterType               : string    ;
    function GetSequenceDown             : Integer   ;
    function GetSequenceUp               : Integer   ;
    function GetEditVersion              : Integer   ;
    function GetCaption                  : string    ;
    function GetDescription              : string    ;
    function GetDetails                  : string    ;
    function GetPartsId                  : Integer   ;
    function GetSaleLineId               : Integer   ;
    function GetPurchaseLineId           : Integer   ;
    function GetIsTemplate               : Boolean   ;
    function GetQuantity                 : Double    ;
    function GetTotalQty                 : Double    ;
    function GetTotalQtyOriginal         : Double    ;
    function GetQtyOriginal              : Double    ;
    function GetQtyVariation             : Double    ;
    function GetHideOnPrint              : Boolean   ;
    function GetAddToSale                : Boolean   ;
    function GetLinkedLineId             : Integer   ;
    function GetPartSource               : string    ;
    function GetInputType                : string    ;
    function GetCustomInputClass         : string    ;
    function GetPrice                    : Double    ;
    function GetTreePricechanged         : Boolean   ;
    function GetCost                     : Double    ;
    function GetProcStepItemRef          : string    ;
    function GetSelected                 : Boolean   ;
    function GetValue                    : string    ;
    function GetComplete                 : Boolean   ;
    function GetLevel                    : Integer   ;
    function GetInfo                     : string    ;
    function GetQtyPer                   : Double    ;
    function GetTreePartUOM              : string    ;
    function GetTreePartUOMID            : Integer   ;
    function GetTreePartUOMMultiplier    : Double    ;
    function GetTreePartUOMQuantity      : Double    ;
    function GetTreePartUOMTotalQty      : Double    ;
    function GetMatrixDesc               : string    ;
    function GetMatrixRef                : string    ;
    function GetMatrixPrice              : Double    ;
    function GetFromStockUOMQty          : Double    ;
    function GetManufactureUOMQty        : Double    ;
    function GetOnOrderUOMQty            : Double    ;
    function GetFromStockQty             : Double    ;
    function GetManufactureQty           : Double    ;
    function GetOnOrderQty               : Double    ;
    function GetQtyPlanned               : Double    ;
    function GetTotalQtyPlanned          : Double    ;
    function GetFormulaQtyValue1         : Double    ;
    function GetFormulaQtyValue2         : Double    ;
    function GetFormulaQtyValue3         : Double    ;
    function GetFormulaQtyValue4         : Double    ;
    function GetFormulaQtyValue5         : Double    ;
    function GetFormulaQtyValue          : Double    ;
    function GetBuildFormulaQtyValue1    : Double    ;
    function GetBuildFormulaQtyValue2    : Double    ;
    function GetBuildFormulaQtyValue3    : Double    ;
    function GetBuildFormulaQtyValue4    : Double    ;
    function GetBuildFormulaQtyValue5    : Double    ;
    function GetBuildFormulaQtyValue     : Double    ;
    function GetOrderFormulaQtyValue1    : Double    ;
    function GetOrderFormulaQtyValue2    : Double    ;
    function GetOrderFormulaQtyValue3    : Double    ;
    function GetOrderFormulaQtyValue4    : Double    ;
    function GetOrderFormulaQtyValue5    : Double    ;
    function GetOrderFormulaQtyValue     : Double    ;
    function GetProductUnitPrice         : Double    ;
    function GetProductUnitCost          : Double    ;
    function GetBOMGroupedLine           : Boolean   ;
    function GetBOMProductionLine        : Boolean   ;
    function GetMakeCoupons              : Boolean   ;
    function GetCouponLabelPrinted       : Boolean   ;
    function GetQtyPerCoupon             : Double    ;
    function GetRAtePercoupon            : Double    ;
    function GetCouponsPerBundle         : Double    ;
    function GetBundleQty                : Double    ;
    procedure SetTreeRootId               (const Value: Integer   );
    procedure SetParentId                 (const Value: Integer   );
    procedure SetMasterId                 (const Value: Integer   );
    procedure SetMasterType               (const Value: string    );
    procedure SetSequenceDown             (const Value: Integer   );
    procedure SetSequenceUp               (const Value: Integer   );
    procedure SetEditVersion              (const Value: Integer   );
    procedure SetCaption                  (const Value: string    );
    procedure SetDescription              (const Value: string    );
    procedure SetDetails                  (const Value: string    );
    procedure SetPartsId                  (const Value: Integer   );
    procedure SetSaleLineId               (const Value: Integer   );
    procedure SetPurchaseLineId           (const Value: Integer   );
    procedure SetIsTemplate               (const Value: Boolean   );
    procedure SetQuantity                 (const Value: Double    );
    procedure SetTotalQty                 (const Value: Double    );
    procedure SetTotalQtyOriginal         (const Value: Double    );
    procedure SetQtyOriginal              (const Value: Double    );
    procedure SetQtyVariation             (const Value: Double    );
    procedure SetHideOnPrint              (const Value: Boolean   );
    procedure SetAddToSale                (const Value: Boolean   );
    procedure SetLinkedLineId             (const Value: Integer   );
    procedure SetPartSource               (const Value: string    );
    procedure SetInputType                (const Value: string    );
    procedure SetCustomInputClass         (const Value: string    );
    procedure SetPrice                    (const Value: Double    );
    procedure SetTreePricechanged         (const Value: Boolean   );
    procedure SetCost                     (const Value: Double    );
    procedure SetProcStepItemRef          (const Value: string    );
    procedure SetSelected                 (const Value: Boolean   );
    procedure SetValue                    (const Value: string    );
    procedure SetComplete                 (const Value: Boolean   );
    procedure SetLevel                    (const Value: Integer   );
    procedure SetInfo                     (const Value: string    );
    procedure SetQtyPer                   (const Value: Double    );
    procedure SetTreePartUOM              (const Value: string    );
    procedure SetTreePartUOMID            (const Value: Integer   );
    procedure SetTreePartUOMMultiplier    (const Value: Double    );
    procedure SetTreePartUOMQuantity      (const Value: Double    );
    procedure SetTreePartUOMTotalQty      (const Value: Double    );
    procedure SetMatrixDesc               (const Value: string    );
    procedure SetMatrixRef                (const Value: string    );
    procedure SetMatrixPrice              (const Value: Double    );
    procedure SetFromStockUOMQty          (const Value: Double    );
    procedure SetManufactureUOMQty        (const Value: Double    );
    procedure SetOnOrderUOMQty            (const Value: Double    );
    procedure SetFromStockQty             (const Value: Double    );
    procedure SetManufactureQty           (const Value: Double    );
    procedure SetOnOrderQty               (const Value: Double    );
    procedure SetQtyPlanned               (const Value: Double    );
    procedure SetTotalQtyPlanned          (const Value: Double    );
    procedure SetFormulaQtyValue1         (const Value: Double    );
    procedure SetFormulaQtyValue2         (const Value: Double    );
    procedure SetFormulaQtyValue3         (const Value: Double    );
    procedure SetFormulaQtyValue4         (const Value: Double    );
    procedure SetFormulaQtyValue5         (const Value: Double    );
    procedure SetFormulaQtyValue          (const Value: Double    );
    procedure SetBuildFormulaQtyValue1    (const Value: Double    );
    procedure SetBuildFormulaQtyValue2    (const Value: Double    );
    procedure SetBuildFormulaQtyValue3    (const Value: Double    );
    procedure SetBuildFormulaQtyValue4    (const Value: Double    );
    procedure SetBuildFormulaQtyValue5    (const Value: Double    );
    procedure SetBuildFormulaQtyValue     (const Value: Double    );
    procedure SetOrderFormulaQtyValue1    (const Value: Double    );
    procedure SetOrderFormulaQtyValue2    (const Value: Double    );
    procedure SetOrderFormulaQtyValue3    (const Value: Double    );
    procedure SetOrderFormulaQtyValue4    (const Value: Double    );
    procedure SetOrderFormulaQtyValue5    (const Value: Double    );
    procedure SetOrderFormulaQtyValue     (const Value: Double    );
    procedure SetProductUnitPrice         (const Value: Double    );
    procedure SetProductUnitCost          (const Value: Double    );
    procedure SetBOMGroupedLine           (const Value: Boolean   );
    procedure SetBOMProductionLine        (const Value: Boolean   );
    procedure SetMakeCoupons              (const Value: Boolean   );
    procedure SetCouponLabelPrinted       (const Value: Boolean   );
    procedure SetQtyPerCoupon             (const Value: Double    );
    procedure SetRAtePercoupon            (const Value: Double    );
    procedure SetCouponsPerBundle         (const Value: Double    );
    procedure SetBundleQty                (const Value: Double    );
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
    property TreeRootId                :Integer     read GetTreeRootId              write SetTreeRootId           ;
    property ParentId                  :Integer     read GetParentId                write SetParentId             ;
    property MasterId                  :Integer     read GetMasterId                write SetMasterId             ;
    property MasterType                :string      read GetMasterType              write SetMasterType           ;
    property SequenceDown              :Integer     read GetSequenceDown            write SetSequenceDown         ;
    property SequenceUp                :Integer     read GetSequenceUp              write SetSequenceUp           ;
    property EditVersion               :Integer     read GetEditVersion             write SetEditVersion          ;
    property Caption                   :string      read GetCaption                 write SetCaption              ;
    property Description               :string      read GetDescription             write SetDescription          ;
    property Details                   :string      read GetDetails                 write SetDetails              ;
    property PartsId                   :Integer     read GetPartsId                 write SetPartsId              ;
    property SaleLineId                :Integer     read GetSaleLineId              write SetSaleLineId           ;
    property PurchaseLineId            :Integer     read GetPurchaseLineId          write SetPurchaseLineId       ;
    property IsTemplate                :Boolean     read GetIsTemplate              write SetIsTemplate           ;
    property Quantity                  :Double      read GetQuantity                write SetQuantity             ;
    property TotalQty                  :Double      read GetTotalQty                write SetTotalQty             ;
    property TotalQtyOriginal          :Double      read GetTotalQtyOriginal        write SetTotalQtyOriginal     ;
    property QtyOriginal               :Double      read GetQtyOriginal             write SetQtyOriginal          ;
    property QtyVariation              :Double      read GetQtyVariation            write SetQtyVariation         ;
    property HideOnPrint               :Boolean     read GetHideOnPrint             write SetHideOnPrint          ;
    property AddToSale                 :Boolean     read GetAddToSale               write SetAddToSale            ;
    property LinkedLineId              :Integer     read GetLinkedLineId            write SetLinkedLineId         ;
    property PartSource                :string      read GetPartSource              write SetPartSource           ;
    property InputType                 :string      read GetInputType               write SetInputType            ;
    property CustomInputClass          :string      read GetCustomInputClass        write SetCustomInputClass     ;
    property Price                     :Double      read GetPrice                   write SetPrice                ;
    property TreePricechanged          :Boolean     read GetTreePricechanged        write SetTreePricechanged     ;
    property Cost                      :Double      read GetCost                    write SetCost                 ;
    property ProcStepItemRef           :string      read GetProcStepItemRef         write SetProcStepItemRef      ;
    property Selected                  :Boolean     read GetSelected                write SetSelected             ;
    property Value                     :string      read GetValue                   write SetValue                ;
    property Complete                  :Boolean     read GetComplete                write SetComplete             ;
    property Level                     :Integer     read GetLevel                   write SetLevel                ;
    property Info                      :string      read GetInfo                    write SetInfo                 ;
    property QtyPer                    :Double      read GetQtyPer                  write SetQtyPer               ;
    property TreePartUOM               :string      read GetTreePartUOM             write SetTreePartUOM          ;
    property TreePartUOMID             :Integer     read GetTreePartUOMID           write SetTreePartUOMID        ;
    property TreePartUOMMultiplier     :Double      read GetTreePartUOMMultiplier   write SetTreePartUOMMultiplier;
    property TreePartUOMQuantity       :Double      read GetTreePartUOMQuantity     write SetTreePartUOMQuantity  ;
    property TreePartUOMTotalQty       :Double      read GetTreePartUOMTotalQty     write SetTreePartUOMTotalQty  ;
    property MatrixDesc                :string      read GetMatrixDesc              write SetMatrixDesc           ;
    property MatrixRef                 :string      read GetMatrixRef               write SetMatrixRef            ;
    property MatrixPrice               :Double      read GetMatrixPrice             write SetMatrixPrice          ;
    property FromStockUOMQty           :Double      read GetFromStockUOMQty         write SetFromStockUOMQty      ;
    property ManufactureUOMQty         :Double      read GetManufactureUOMQty       write SetManufactureUOMQty    ;
    property OnOrderUOMQty             :Double      read GetOnOrderUOMQty           write SetOnOrderUOMQty        ;
    property FromStockQty              :Double      read GetFromStockQty            write SetFromStockQty         ;
    property ManufactureQty            :Double      read GetManufactureQty          write SetManufactureQty       ;
    property OnOrderQty                :Double      read GetOnOrderQty              write SetOnOrderQty           ;
    property QtyPlanned                :Double      read GetQtyPlanned              write SetQtyPlanned           ;
    property TotalQtyPlanned           :Double      read GetTotalQtyPlanned         write SetTotalQtyPlanned      ;
    property FormulaQtyValue1          :Double      read GetFormulaQtyValue1        write SetFormulaQtyValue1     ;
    property FormulaQtyValue2          :Double      read GetFormulaQtyValue2        write SetFormulaQtyValue2     ;
    property FormulaQtyValue3          :Double      read GetFormulaQtyValue3        write SetFormulaQtyValue3     ;
    property FormulaQtyValue4          :Double      read GetFormulaQtyValue4        write SetFormulaQtyValue4     ;
    property FormulaQtyValue5          :Double      read GetFormulaQtyValue5        write SetFormulaQtyValue5     ;
    property FormulaQtyValue           :Double      read GetFormulaQtyValue         write SetFormulaQtyValue      ;
    property BuildFormulaQtyValue1     :Double      read GetBuildFormulaQtyValue1   write SetBuildFormulaQtyValue1;
    property BuildFormulaQtyValue2     :Double      read GetBuildFormulaQtyValue2   write SetBuildFormulaQtyValue2;
    property BuildFormulaQtyValue3     :Double      read GetBuildFormulaQtyValue3   write SetBuildFormulaQtyValue3;
    property BuildFormulaQtyValue4     :Double      read GetBuildFormulaQtyValue4   write SetBuildFormulaQtyValue4;
    property BuildFormulaQtyValue5     :Double      read GetBuildFormulaQtyValue5   write SetBuildFormulaQtyValue5;
    property BuildFormulaQtyValue      :Double      read GetBuildFormulaQtyValue    write SetBuildFormulaQtyValue ;
    property OrderFormulaQtyValue1     :Double      read GetOrderFormulaQtyValue1   write SetOrderFormulaQtyValue1;
    property OrderFormulaQtyValue2     :Double      read GetOrderFormulaQtyValue2   write SetOrderFormulaQtyValue2;
    property OrderFormulaQtyValue3     :Double      read GetOrderFormulaQtyValue3   write SetOrderFormulaQtyValue3;
    property OrderFormulaQtyValue4     :Double      read GetOrderFormulaQtyValue4   write SetOrderFormulaQtyValue4;
    property OrderFormulaQtyValue5     :Double      read GetOrderFormulaQtyValue5   write SetOrderFormulaQtyValue5;
    property OrderFormulaQtyValue      :Double      read GetOrderFormulaQtyValue    write SetOrderFormulaQtyValue ;
    property ProductUnitPrice          :Double      read GetProductUnitPrice        write SetProductUnitPrice     ;
    property ProductUnitCost           :Double      read GetProductUnitCost         write SetProductUnitCost      ;
    property BOMGroupedLine            :Boolean     read GetBOMGroupedLine          write SetBOMGroupedLine       ;
    property BOMProductionLine         :Boolean     read GetBOMProductionLine       write SetBOMProductionLine    ;
    property MakeCoupons               :Boolean     read GetMakeCoupons             write SetMakeCoupons          ;
    property CouponLabelPrinted        :Boolean     read GetCouponLabelPrinted      write SetCouponLabelPrinted   ;
    property QtyPerCoupon              :Double      read GetQtyPerCoupon            write SetQtyPerCoupon         ;
    property RAtePercoupon             :Double      read GetRAtePercoupon           write SetRAtePercoupon        ;
    property CouponsPerBundle          :Double      read GetCouponsPerBundle        write SetCouponsPerBundle     ;
    property BundleQty                 :Double      read GetBundleQty               write SetBundleQty            ;
  end;*)
  TBOMSalesPieceRateConf = class(TMSBusObj)
  private
    fiSaleslineId :Integer;
    fsTablename :String;
    fdBOMBundleQty : Double;
    stCalcCoupns :TStringlist;
    function GetMasterID             : Integer   ;
    function GetProctreeId           : Integer   ;
    function GetProcessPartID        : Integer   ;
    function GetSeqno                : Integer   ;
    function Gettree                 : string    ;
    function GetProcessStep          : string    ;
    function GetDuration             : Double ;
    function GetSetupduration        : Double ;
    function Getbreakdownduration    : Double ;
    function GetQtyPerCoupon         : Double    ;
    function GetTreePartUOMTotalQty  : Double    ;
    function GetOnOrderUOMQty        : Double    ;
    function GetFromStockUOMQty      : Double    ;
    function GetManufactureUOMQty    : Double    ;
    function GetRAtePercoupon        : Double    ;
    function GetMakeCoupons          : Boolean   ;
    function GetCouponLabelPrinted   : Boolean   ;
    function GetSequenceDown         : Integer   ;
    function GetParentID             : Integer   ;
    function GetNoOfchildNodes       : Integer   ;
    function GetCouponsPerBundle     : Double    ;
    function GetBundleQty            : Double    ;
    procedure SetMasterID             (const Value: Integer   );
    procedure SetProctreeId           (const Value: Integer   );
    procedure SetProcessPartID        (const Value: Integer   );
    procedure SetSeqno                (const Value: Integer   );
    procedure Settree                 (const Value: string    );
    procedure SetProcessStep          (const Value: string    );
    procedure SetDuration             (const Value: Double );
    procedure SetSetupduration        (const Value: Double );
    procedure Setbreakdownduration    (const Value: Double );
    procedure SetQtyPerCoupon         (const Value: Double    );
    procedure SetRAtePercoupon        (const Value: Double    );
    procedure SetMakeCoupons          (const Value: Boolean   );
    procedure SetCouponLabelPrinted   (const Value: Boolean   );
    procedure SetSequenceDown         (const Value: Integer   );
    procedure SetParentID             (const Value: Integer   );
    procedure SetNoOfchildNodes       (const Value: Integer   );
    procedure SetCouponsPerBundle     (const Value: Double    );
    procedure SetBundleQty            (const Value: Double    );
    function getProcessPart: TProcessPart;
    function getProcTree: TProcTree;
    function getSalesOrderLine: TSalesOrderLine;
    function getSaleLineID: Integer;
    function getBarcodeXRef: TBarcodeXRef;
    Procedure MakeBarcodeXRefs;
    function getCleanQtyPercoupon: Double;
    function getCleanCoupons: Integer;
    function getCoupons: Integer;
    Procedure DeleteAllRefs;
    Procedure DeleteAllRefsCallback(const Sender: TBusObj; var Abort: Boolean);
    Function DeleteFlaggedBarcodeXRefs: Boolean;
    Procedure CalcCoupnsCallback(const Sender: TBusObj; var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Procedure SelectAllCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure UnSelectAllCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure SelectAllPartsCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure SelectAllProcessCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure SaveCallback(const Sender: TBusObj; var Abort: Boolean);

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure SelectAll;
    Procedure UnSelectAll;
    Procedure SelectAllParts;
    Procedure SelectAllProcess;
    Procedure LoadForSaleLine(const aSalelineId:Integer; const aProctreeID:Integer);
    Property ProcessPart : TProcessPart read getProcessPart;
    Property ProcTree : TProcTree read getProcTree;
    Property SalesOrderLine :TSalesOrderLine read getSalesOrderLine;
    Property SaleLineID :Integer read getSaleLineID;
    function ProcTreeSQL(Extrafield:String): String;
    function ProcesSSQL(Extrafield:String): String;
    Property BarcodeXRef : TBarcodeXRef read getBarcodeXRef;
    Property CleanQtyPercoupon:Double  read getCleanQtyPercoupon;
    Property CleanCoupons : Integer read getCleanCoupons;
    Property Coupons :Integer read getCoupons;
    function BundleDuration : String;
    Function Bundles:String;
  published
    property MasterID              :Integer     read GetMasterID            write SetMasterID         ;
    property ProctreeId            :Integer     read GetProctreeId          write SetProctreeId       ;
    property ProcessPartID         :Integer     read GetProcessPartID       write SetProcessPartID    ;
    property Seqno                 :Integer     read GetSeqno               write SetSeqno            ;
    property tree                  :string      read Gettree                write Settree             ;
    property ProcessStep           :string      read GetProcessStep         write SetProcessStep      ;
    property Duration              :Double   read GetDuration            write SetDuration         ;
    property Setupduration         :Double   read GetSetupduration       write SetSetupduration    ;
    property breakdownduration     :Double   read Getbreakdownduration   write Setbreakdownduration;
    property QtyPerCoupon          :Double      read GetQtyPerCoupon        write SetQtyPerCoupon     ;
    property TreePartUOMTotalQty   :Double      read GetTreePartUOMTotalQty ;
    property OnOrderUOMQty         :Double      read GetOnOrderUOMQty ;
    property FromStockUOMQty       :Double      read GetFromStockUOMQty ;
    property ManufactureUOMQty     :Double      read GetManufactureUOMQty ;
    property RAtePercoupon         :Double      read GetRAtePercoupon       write SetRAtePercoupon    ;
    property MakeCoupons           :Boolean     read GetMakeCoupons         write SetMakeCoupons      ;
    property CouponLabelPrinted    :Boolean     read GetCouponLabelPrinted  write SetCouponLabelPrinted;
    property SequenceDown          :Integer     read GetSequenceDown        write SetSequenceDown     ;
    property ParentID              :Integer     read GetParentID            write SetParentID         ;
    property NoOfchildNodes        :Integer     read GetNoOfchildNodes      write SetNoOfchildNodes   ;
    property CouponsPerBundle      :Double      read GetCouponsPerBundle    write SetCouponsPerBundle ;
    property BundleQty             :Double      read GetBundleQty           write SetBundleQty        ;
  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib , Sysutils, DbSharedObjectsObj,
  CommonDbLib, LogLib, variants;



  {TBOMSalesPieceRateConf}

constructor TBOMSalesPieceRateConf.Create(AOwner: TComponent);
begin
  fsTablename :=GetUserTemporaryTableName('BOMSalesPieceRateConf');
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BOMSalesPieceRateConf';
  fSQL := 'SELECT * FROM ' + fsTablename;
  fdBOMBundleQty := 0;
  LogChangesOnSave := false ;
end;


procedure TBOMSalesPieceRateConf.DeleteAllRefs;
begin
  BarcodeXRef.Iteraterecords(DeleteAllRefsCallback);
end;
procedure TBOMSalesPieceRateConf.DeleteAllRefsCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if  not(Sender is TBarcodeXRef) then Exit;
  TBarcodeXRef(Sender).Deleted := True;
  TBarcodeXRef(Sender).PostDB;
end;


destructor TBOMSalesPieceRateConf.Destroy;
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;
Function TBOMSalesPieceRateConf.ProcesSSQL(Extrafield:String):String;
begin
  REsult := ' select distinct '  +
                   Extrafield +
                   'S.PONumber,'+
                   'SL.Product_Description,  '+
                   ' PT.MasterID, ' +
                   ' Pt.ProctreeId,   ' +
                   ' Pt.Quantity,   ' +
                   ' Pt.TreePartUOMMultiplier , '+
                   ' PT.TreePartUOMTotalQty ,  ' +
                   ' PT.ManufactureUOMQty   ,  ' +
                   ' PT.OnOrderUOMQty ,  ' +
                   ' PT.FromStockUOMQty , '+
                   ' PP.Id as ProcessPartID,   ' +
                   ' 2 as Seqno, ' +
                   ' Concat(PT.Caption,"." ,PS.Description)  as Caption,'+
                   ' Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) tree, ' +
                   ' PS.Description as ProcessStep, ' +
                   ' PP.Duration as Duration, ' +
                   ' PP.SetupDuration as Setupduration, ' +
                   ' PP.breakdownduration  as breakdownduration , ' +
                   ' Pp.QtyPerCoupon, ' +
                   ' Pp.CouponsPerBundle, ' +
                   ' Pp.BundleQty, ' +
                   ' Pp.RAtePercoupon, ' +
                   ' Pp.MakeCoupons, ' +
                   ' PT.SequenceDown, ' +
                   ' PT.ParentID , if(PP.CouponLabelPrinted="T" , "T" , "F") as CouponLabelPrinted, if(PP.CouponLabelPrinted="T" , "Duplicate","") as DuplicateDesc' +
                   ' from  tblsales S inner join  tblsaleslines SL   on S.SaleId = SL.saleId  ' +
                   ' inner join tblproctree PT on PT.MasterId = Sl.saleLineId and PT.Mastertype <> "mtProduct" ' +
                   ' inner join tblProcessPart PP on PP.procTreeId = PT.proctreeId ' +
                   ' inner join tblProcessStep PS on PP.ProcessStepId = PS.ID ' ;
end;
function TBOMSalesPieceRateConf.ProcTreeSQL (Extrafield:String):String;
begin
  Result := ' select distinct ' +
                    Extrafield +
                   'S.PONumber,'+
                   'SL.Product_Description, '+
                   ' PT.MasterID, ' +
                   ' Pt.ProctreeId,    ' +
                   ' Pt.Quantity,   ' +
                   ' Pt.TreePartUOMMultiplier , '+
                   ' PT.TreePartUOMTotalQty ,  ' +
                   ' PT.ManufactureUOMQty   ,  ' +
                   ' PT.OnOrderUOMQty ,  ' +
                   ' PT.FromStockUOMQty , '+
                   ' Null as ProcessPartID,   ' +
                   ' 1 as Seqno, ' +
                   ' PT.Caption as Caption,'+
                   ' Convert(TreeNodeCaption(PT.Level, PT.caption ) , char(255)) tree, ' +
                   ' Null as ProcessStep, ' +
                   ' Null as Duration, ' +
                   ' Null  as Setupduration, ' +
                   ' Null  as breakdownduration , ' +
                   ' PT.QtyPerCoupon, ' +
                   ' PT.CouponsPerBundle, ' +
                   ' PT.BundleQty, ' +
                   ' PT.RAtePercoupon, ' +
                   ' PT.MakeCoupons, ' +
                   ' PT.SequenceDown, ' +
                   ' PT.ParentID , if(PT.CouponLabelPrinted="T" , "T" , "F") as CouponLabelPrinted, if(PT.CouponLabelPrinted="T" , "Duplicate","") as DuplicateDesc ' +
                   ' from  tblsales S inner join  tblsaleslines SL   on S.SaleId = SL.saleId   ' +
                   ' inner join tblproctree PT on PT.MasterId = Sl.saleLineID and PT.Mastertype <> "mtProduct" '+
                   ' inner join tblProcessPart PP on PP.procTreeId = PT.proctreeId ' ;
end;
procedure TBOMSalesPieceRateConf.LoadForSaleLine(const aSalelineId:Integer; const aProctreeID:Integer);
var
  script :TERPScript;
begin
  fiSaleslineId := aSalelineId;

  Script := DbSharedObj.GetScript(CommondbLib.GetSharedMyDacConnection);
  try
    Script.SQL.Clear;
    Script.SQL.Add('Drop table if exists ' + fsTablename +'1' +';')  ;
    Script.SQL.Add('Create Table  ' + fsTablename +'1'  +
                   ProcTreeSQL('') +
                   ' where PT.MasterId = ' + inttostr(fiSaleslineId )+
                   ' and ('+ inttostr(aProctreeID)+' =0 or PT.proctreeId =' + inttostr(aProctreeID)+')'+
                   ' union all ' +
                   ProcessSQL('') +
                   ' where PT.MasterId = ' + inttostr(fiSaleslineId )+
                   ' and ('+ inttostr(aProctreeID)+' =0 or PT.proctreeId =' + inttostr(aProctreeID)+')'+
                   ' order by SequenceDown, ParentId;');

    Script.SQL.Add('Alter table ' + fsTablename +'1 Add column NoOfchildNodes int(11);')  ;
    //Script.SQL.Add('Alter table ' + fsTablename +'1 Add column CouponLabelPrinted Enum("T","F") Default "F";')  ;
    Script.SQL.Add('Drop table if exists  ' + fsTablename +'11;');
    Script.SQL.Add('create table  ' + fsTablename +'11 Select ParentId , seqno , count(*) ctr from  ' + fsTablename +'1 group by ParentId, seqno ;');
    Script.SQL.Add('update  ' + fsTablename +'1 T1 set NoOfchildNodes  = (Select count(*) from  ' + fsTablename +'11 T2 where T2.parentID = T1.ProctreeID);');
    Script.SQL.Add('Drop table if exists  ' + fsTablename +';');
    Script.SQL.Add('create table  ' + fsTablename +
                          ' select ' +
                          ' convert(@rownum:=if(@proctreeId = A.proctreeId,  @rownum ,  @rownum+1),signed) rownum ,  ' +
                          ' @proctreeId := A.proctreeId groupproctreeId,   ' +
                          ' a.* ' +
                          ' from   (select * from  ' + fsTablename +'1 ) A ,  ' +
                          ' (SELECT @rownum:=0) r ,  ' +
                          ' (SELECT @proctreeId:=0) s;');
    Script.SQL.Add('ALTER TABLE  ' + fsTablename +'	ADD COLUMN ID INT NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (ID);');
    Script.SQL.Add('ALTER TABLE  ' + fsTablename +'	ADD COLUMN Bundles Double;');

    Script.SQL.Add('ALTER TABLE  ' + fsTablename +'	ADD COLUMN TotalDuration          VarChar(50);');
    Script.SQL.Add('ALTER TABLE  ' + fsTablename +'	ADD COLUMN TotalSetupduration     VarChar(50);');
    Script.SQL.Add('ALTER TABLE  ' + fsTablename +'	ADD COLUMN Totalbreakdownduration VarChar(50);');
    Script.SQL.Add('ALTER TABLE  ' + fsTablename +'	ADD COLUMN BundleDuration         VarChar(50);');
    Script.SQL.add('update '+ fsTablename +' set TotalDuration          = FormatSecondsTotime(Duration*ManufactureUOMQty);');
    Script.SQL.add('update '+ fsTablename +' set TotalSetupduration     = FormatSecondsTotime(Setupduration);');
    Script.SQL.add('update '+ fsTablename +' set Totalbreakdownduration = FormatSecondsTotime(breakdownduration);');
    Script.SQL.add('update '+ fsTablename +' set BundleDuration         = FormatSecondsTotime(duration*BundleQty);');
    Script.SQL.add('update '+ fsTablename +' set QtyPerCoupon           = Round(BundleQty/CouponsPerBundle,2);');


    Script.SQL.Add('Drop table if exists  ' + fsTablename +'11;');
    Script.SQL.Add('Drop table if exists ' + fsTablename +'1' +';')  ;
    clog(Script.SQL.Text);
    Script.Execute;
  finally
    DbSharedObj.ReleaseObj(Script);
  end;
  fSQL := 'SELECT * FROM ' + fsTablename;
  Load;
end;

procedure TBOMSalesPieceRateConf.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'MasterID');
  SetPropertyFromNode(node,'ProctreeId');
  SetPropertyFromNode(node,'ProcessPartID');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'tree');
  SetPropertyFromNode(node,'ProcessStep');
  SetDateTimePropertyFromNode(node,'Duration');
  SetDateTimePropertyFromNode(node,'Setupduration');
  SetDateTimePropertyFromNode(node,'breakdownduration');
  SetPropertyFromNode(node,'QtyPerCoupon');
  SetPropertyFromNode(node,'CouponsPerBundle');
  SetPropertyFromNode(node,'BundleQty');
  SetPropertyFromNode(node,'TreePartUOMTotalQty');
  SetPropertyFromNode(node,'OnOrderUOMQty');
  SetPropertyFromNode(node,'FromStockUOMQty');
  SetPropertyFromNode(node,'ManufactureUOMQty');
  SetPropertyFromNode(node,'RAtePercoupon');
  SetBooleanPropertyFromNode(node,'MakeCoupons');
  SetBooleanPropertyFromNode(node,'CouponLabelPrinted ');
  SetPropertyFromNode(node,'SequenceDown');
  SetPropertyFromNode(node,'ParentID');
  SetPropertyFromNode(node,'NoOfchildNodes');
end;


procedure TBOMSalesPieceRateConf.MakeBarcodeXRefs;
var
  ctr:Integer;
begin
  DeleteAllRefs;
  for ctr := 1 to trunc(Coupons) do begin
    if not(BarcodeXRef.Locate('Barcodetype;intValue1;intValue2;intValue3;intValue4;intValue5' , vararrayof([BarcodeXRefTypeToStr(btWorkOrder),ProctreeId,ProcesspartID,trunc(QtyPerCoupon),ctr,trunc(Coupons)]), [])) then begin
      BarcodeXRef.New;
      BarcodeXRef.Barcodetype := BarcodeXRefTypeToStr(btWorkOrder);
      BarcodeXRef.intValue1 := ProctreeId;
      BarcodeXRef.intValue2 := ProcessPartID;
      BarcodeXRef.intValue3 := trunc(QtyPerCoupon);
      BarcodeXRef.intValue4 := ctr;
      BarcodeXRef.intValue5 := trunc(Coupons) ;
    end;
    BarcodeXRef.Barcode := 'P-'+Trim(Inttostr(ProctreeId))+'-'+Trim(Inttostr(ProcessPartID))+'-'+ Trim(FloatTostr(QtyPerCoupon))+'-'+ Trim(Inttostr(ctr));
    BarcodeXRef.Deleted := False;
    BarcodeXRef.PostDB;
  end;
  DeleteFlaggedBarcodeXRefs;
end;
function TBOMSalesPieceRateConf.DeleteFlaggedBarcodeXRefs: Boolean;
begin
  Result := true;
      If BarcodeXRef.Count > 0 Then Begin
        BarcodeXRef.First;
        While Not BarcodeXRef.Eof Do Begin
          if BarcodeXRef.deleted then
            BarcodeXRef.Delete
          else BarcodeXRef.Next;
        End;
      End;
end;

procedure TBOMSalesPieceRateConf.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'MasterID' ,MasterID);
  AddXMLNode(node,'ProctreeId' ,ProctreeId);
  AddXMLNode(node,'ProcessPartID' ,ProcessPartID);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'tree' ,tree);
  AddXMLNode(node,'ProcessStep' ,ProcessStep);
  AddXMLNode(node,'Duration' ,Duration);
  AddXMLNode(node,'Setupduration' ,Setupduration);
  AddXMLNode(node,'breakdownduration' ,breakdownduration);
  AddXMLNode(node,'QtyPerCoupon' ,QtyPerCoupon);
  AddXMLNode(node,'CouponsPerBundle' ,CouponsPerBundle);
  AddXMLNode(node,'BundleQty' ,BundleQty);
  AddXMLNode(node,'TreePartUOMTotalQty' ,TreePartUOMTotalQty);
  AddXMLNode(node,'OnOrderUOMQty' ,OnOrderUOMQty);
  AddXMLNode(node,'FromStockUOMQty' ,FromStockUOMQty);
  AddXMLNode(node,'ManufactureUOMQty' ,ManufactureUOMQty);
  AddXMLNode(node,'RAtePercoupon' ,RAtePercoupon);
  AddXMLNode(node,'MakeCoupons' ,MakeCoupons);
  AddXMLNode(node,'CouponLabelPrinted ' ,CouponLabelPrinted );
  AddXMLNode(node,'SequenceDown' ,SequenceDown);
  AddXMLNode(node,'ParentID' ,ParentID);
  AddXMLNode(node,'NoOfchildNodes' ,NoOfchildNodes);
  AddXMLNode(node,'Coupons' ,Coupons);

end;


function TBOMSalesPieceRateConf.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TBOMSalesPieceRateConf.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  try
    IterateRecords(SaveCallback);
    Result := True;
  Except
    on E:Exception do begin
      Result := False;
      ResultStatus.AddItem(False , rssWarning, 0 , 'Save Failed.  '+E.Message );
    end;
  end;
  if result then Result := inherited Save;
end;


procedure TBOMSalesPieceRateConf.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TBOMSalesPieceRateConf.BundleDuration: String;
begin
  REsult := GetStringField('BundleDuration');
end;

function TBOMSalesPieceRateConf.Bundles: String;
begin
  REsult := GetStringField('Bundles');
end;

Procedure TBOMSalesPieceRateConf.CalcCoupnsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if Not(Sender is TBOMSalesPieceRateConf) then exit;
  //if TBOMSalesPieceRateConf(sender).parentId =0 then exit;
  //if fdBOMBundleQty =0 then exit;
  if TBOMSalesPieceRateConf(sender).ParentID =0 then stCalcCoupns.add('update '+ fsTablename +' set bundleQty = ' + floattostr(fdBOMBundleQty) +' where Id = ' + inttostr(TBOMSalesPieceRateConf(sender).ID)+';')
  else stCalcCoupns.add('update '+ fsTablename +' set bundleQty = ' + floattostr(fdBOMBundleQty) +' where Id = ' + inttostr(TBOMSalesPieceRateConf(sender).ID)+';')
end;
procedure TBOMSalesPieceRateConf.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'BundleQty') then begin
    if ParentId = 0 then begin
      fdBOMBundleQty := BundleQty;
      try
        stCalcCoupns := TStringlist.create;
        try
          IterateRecords(CalcCoupnsCallback);
          if stCalcCoupns.count >0 then begin

            stCalcCoupns.add('update '+ fsTablename +' set Bundles = Round(ManufactureUOMQty /bundleQty ,5) where ifnull(ManufactureUOMQty,0)<> 0 and ifnull(bundleQty,0)<>0;');
            stCalcCoupns.add('update '+ fsTablename +' set Bundles = Round(Bundles ,0)+1 where Round(Bundles ,0) <> Round(Bundles,5);');
            stCalcCoupns.add('update '+ fsTablename +' set TotalDuration = FormatSecondsTotime(Duration*ManufactureUOMQty);');
            stCalcCoupns.add('update '+ fsTablename +' set TotalSetupduration = FormatSecondsTotime(Setupduration);');
            stCalcCoupns.add('update '+ fsTablename +' set Totalbreakdownduration = FormatSecondsTotime(breakdownduration);');
            stCalcCoupns.add('update '+ fsTablename +' set BundleDuration = FormatSecondsTotime(duration*BundleQty);');
            stCalcCoupns.add('update '+ fsTablename +' set QtyPerCoupon = round(BundleQty/CouponsPerBundle,2);');

            clog(stCalcCoupns.text );
            ExecuteSQL(stCalcCoupns.text , true);
          end;
          RefreshDB;
        finally
          Freeandnil(stCalcCoupns);
        end;
      finally
        fdBOMBundleQty := 0;
      end;
    end;
  end else if Sysutils.SameText(Sender.FieldName, 'MakeCoupons') then begin
    if MakeCoupons then
      if (QtyPercoupon =0) and ((BundleQty =0) or (CouponsPerBundle =0)) then begin
        MakeCoupons := False;
        ResultStatus.AddItem(False , rssWarning, 0 , 'Please provide Quantity / Coupons to choose to ''Make Coupon''' );
      end;
  end else if Sysutils.SameText(Sender.FieldName, 'QtyPercoupon') then begin
    if Sender.oldvalue <> 0 then
      if CouponLabelPrinted then
        ResultStatus.AddItem(False , rssWarning, 0 , 'Coupons are already printed for this job with a Different ''Qty Per Coupon''.' );
  end;
end;


function TBOMSalesPieceRateConf.getBarcodeXRef: TBarcodeXRef;
begin
  Result := TBarcodeXRef(getContainercomponent(TBarcodeXRef, 'Barcodetype = "btWorkOrder" '+
                                                        ' and intValue1 = ' + inttostr(ProctreeId)+'  '+
                                                        ' and intValue2 = ' + inttostr(ProcessPartID) ));
end;

function TBOMSalesPieceRateConf.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBOMSalesPieceRateConf.GetIDField: string;
begin
  Result := 'ID'
end;


class function TBOMSalesPieceRateConf.GetBusObjectTablename: string;
begin
  Result:= '';
end;


function TBOMSalesPieceRateConf.getCleanCoupons: Integer;
begin
    Result := GetXMLNodeIntegerValue(CleanXMLNode, 'Coupons');
end;

function TBOMSalesPieceRateConf.getCleanQtyPercoupon: Double;
begin
    Result := GetXMLNodefloatValue(CleanXMLNode, 'QtyPercoupon');
end;

function TBOMSalesPieceRateConf.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBOMSalesPieceRateConf.GetMasterID         : Integer   ; begin Result := GetIntegerField('MasterID');end;
function  TBOMSalesPieceRateConf.GetProctreeId       : Integer   ; begin Result := GetIntegerField('ProctreeId');end;
function  TBOMSalesPieceRateConf.GetProcessPartID    : Integer   ; begin Result := GetIntegerField('ProcessPartID');end;
function  TBOMSalesPieceRateConf.GetSeqno            : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TBOMSalesPieceRateConf.Gettree             : string    ; begin Result := GetStringField('tree');end;
function  TBOMSalesPieceRateConf.GetProcessStep      : string    ; begin Result := GetStringField('ProcessStep');end;
function  TBOMSalesPieceRateConf.GetDuration         : Double ; begin Result := GetFloatField('Duration');end;
function  TBOMSalesPieceRateConf.GetSetupduration    : Double ; begin Result := GetFloatField('Setupduration');end;
function  TBOMSalesPieceRateConf.Getbreakdownduration: Double ; begin Result := GetFloatField('breakdownduration');end;
function  TBOMSalesPieceRateConf.GetQtyPerCoupon     : Double    ; begin Result := GetFloatField('QtyPerCoupon');end;
function  TBOMSalesPieceRateConf.GetTreePartUOMTotalQty: Double    ; begin Result := GetFloatField('TreePartUOMTotalQty');end;
function  TBOMSalesPieceRateConf.GetOnOrderUOMQty    : Double    ; begin Result := GetFloatField('OnOrderUOMQty');end;
function  TBOMSalesPieceRateConf.GetFromStockUOMQty  : Double    ; begin Result := GetFloatField('FromStockUOMQty');end;
function  TBOMSalesPieceRateConf.GetManufactureUOMQty: Double    ; begin Result := GetFloatField('ManufactureUOMQty');end;
function  TBOMSalesPieceRateConf.GetRAtePercoupon    : Double    ; begin Result := GetFloatField('RAtePercoupon');end;
function  TBOMSalesPieceRateConf.GetMakeCoupons      : Boolean   ; begin Result := GetBooleanField('MakeCoupons');end;
function  TBOMSalesPieceRateConf.GetCouponLabelPrinted : Boolean   ; begin Result := GetBooleanField('CouponLabelPrinted');end;
function  TBOMSalesPieceRateConf.GetSequenceDown     : Integer   ; begin Result := GetIntegerField('SequenceDown');end;
function  TBOMSalesPieceRateConf.GetParentID         : Integer   ; begin Result := GetIntegerField('ParentID');end;
function  TBOMSalesPieceRateConf.GetNoOfchildNodes   : Integer   ; begin Result := GetIntegerField('NoOfchildNodes');end;
function  TBOMSalesPieceRateConf.GetCouponsPerBundle : Double    ; begin Result := GetFloatField('CouponsPerBundle');end;
function  TBOMSalesPieceRateConf.GetBundleQty        : Double    ; begin Result := GetFloatField('BundleQty');end;
procedure TBOMSalesPieceRateConf.SetMasterID         (const Value: Integer   ); begin SetIntegerField('MasterID'          , Value);end;
procedure TBOMSalesPieceRateConf.SetProctreeId       (const Value: Integer   ); begin SetIntegerField('ProctreeId'        , Value);end;
procedure TBOMSalesPieceRateConf.SetProcessPartID    (const Value: Integer   ); begin SetIntegerField('ProcessPartID'     , Value);end;
procedure TBOMSalesPieceRateConf.SetSeqno            (const Value: Integer   ); begin SetIntegerField('Seqno'             , Value);end;
procedure TBOMSalesPieceRateConf.Settree             (const Value: string    ); begin SetStringField('tree'              , Value);end;
procedure TBOMSalesPieceRateConf.SetProcessStep      (const Value: string    ); begin SetStringField('ProcessStep'       , Value);end;
procedure TBOMSalesPieceRateConf.SetDuration         (const Value: Double ); begin SetFloatField('Duration'          , Value);end;
procedure TBOMSalesPieceRateConf.SetSetupduration    (const Value: Double ); begin SetFloatField('Setupduration'     , Value);end;
procedure TBOMSalesPieceRateConf.Setbreakdownduration(const Value: Double ); begin SetFloatField('breakdownduration' , Value);end;
procedure TBOMSalesPieceRateConf.SetQtyPerCoupon     (const Value: Double    ); begin SetFloatField('QtyPerCoupon'      , Value);end;
procedure TBOMSalesPieceRateConf.SetRAtePercoupon    (const Value: Double    ); begin SetFloatField('RAtePercoupon'     , Value);end;
procedure TBOMSalesPieceRateConf.SetMakeCoupons      (const Value: Boolean   ); begin SetBooleanField('MakeCoupons'       , Value);end;
procedure TBOMSalesPieceRateConf.SetCouponLabelPrinted  (const Value: Boolean   ); begin SetBooleanField('CouponLabelPrinted'       , Value);end;
procedure TBOMSalesPieceRateConf.SetSequenceDown     (const Value: Integer   ); begin SetIntegerField('SequenceDown'      , Value);end;
procedure TBOMSalesPieceRateConf.SetParentID         (const Value: Integer   ); begin SetIntegerField('ParentID'          , Value);end;
procedure TBOMSalesPieceRateConf.SetNoOfchildNodes   (const Value: Integer   ); begin SetIntegerField('NoOfchildNodes'    , Value);end;
procedure TBOMSalesPieceRateConf.SetCouponsPerBundle (const Value: Double    ); begin SetFloatField('CouponsPerBundle'   , Value);end;
procedure TBOMSalesPieceRateConf.SetBundleQty        (const Value: Double    ); begin SetFloatField('BundleQty'   , Value);end;
procedure TBOMSalesPieceRateConf.SelectAll        ;begin  IterateRecords(SelectAllCallback)       ;end;
procedure TBOMSalesPieceRateConf.UnSelectAll      ;begin  IterateRecords(UnSelectAllCallback)       ;end;
procedure TBOMSalesPieceRateConf.SelectAllParts   ;begin  IterateRecords(SelectAllpartsCallback)  ;end;
procedure TBOMSalesPieceRateConf.SelectAllProcess ;begin  IterateRecords(SelectAllProcessCallback);end;
function TBOMSalesPieceRateConf.getCoupons: Integer;
var
  fiCoupons:Double;
begin
  if (BundleQty <>0)  then begin
    if CouponsPerBundle =0 then CouponsPerBundle := 1;
    fiCoupons:=(ManufactureUOMQty /BundleQty)*CouponsPerBundle;
  end else begin
    fiCoupons:= ManufactureUOMQty /QtyPercoupon;
  end;
  if trunc(fiCoupons)<> fiCoupons then fiCoupons := trunc(fiCoupons+1);
  Result := trunc(fiCoupons);
end;
function TBOMSalesPieceRateConf.getProcTree: TProcTree;
begin
  Result := TProcTree(getContainercomponent(TProcTree, 'ProctreeId = ' + inttostr(ProctreeId) ));
end;
function TBOMSalesPieceRateConf.getSaleLineID: Integer;
begin
  Result := MasterId;
end;

function TBOMSalesPieceRateConf.getSalesOrderLine: TSalesOrderLine;
begin
  Result := TSalesOrderLine(getContainercomponent(TSalesOrderLine, 'SaleLineID = ' + inttostr(SaleLineID) ));
end;
function TBOMSalesPieceRateConf.getProcessPart: TProcessPart;
begin
  Result := TProcessPart(getContainercomponent(TProcessPart, 'ID = ' + inttostr(ProcessPartID) ));
end;

procedure TBOMSalesPieceRateConf.SelectAllCallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if not(Sender is TBOMSalesPieceRateConf) then exit;
  if TBOMSalesPieceRateConf(Sender).QtyPerCoupon <> 0 then
    if TBOMSalesPieceRateConf(Sender).MakeCoupons = False then begin
      TBOMSalesPieceRateConf(Sender).MakeCoupons := True;
      TBOMSalesPieceRateConf(Sender).PostDB;
    end;
end;

procedure TBOMSalesPieceRateConf.UnSelectAllCallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if not(Sender is TBOMSalesPieceRateConf) then exit;
    if TBOMSalesPieceRateConf(Sender).MakeCoupons  then begin
      TBOMSalesPieceRateConf(Sender).MakeCoupons := False;
      TBOMSalesPieceRateConf(Sender).PostDB;
    end;
end;


procedure TBOMSalesPieceRateConf.SelectAllPartsCallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if not(Sender is TBOMSalesPieceRateConf) then exit;
  if TBOMSalesPieceRateConf(Sender).Seqno =1 then
    if TBOMSalesPieceRateConf(Sender).QtyPerCoupon <> 0 then
      if TBOMSalesPieceRateConf(Sender).MakeCoupons = False then begin
        TBOMSalesPieceRateConf(Sender).MakeCoupons := True;
        TBOMSalesPieceRateConf(Sender).PostDB;
      end;
end;

procedure TBOMSalesPieceRateConf.SelectAllProcessCallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if not(Sender is TBOMSalesPieceRateConf) then exit;
  if TBOMSalesPieceRateConf(Sender).Seqno <>1 then
    if TBOMSalesPieceRateConf(Sender).QtyPerCoupon <> 0 then
      if TBOMSalesPieceRateConf(Sender).MakeCoupons = False then begin
        TBOMSalesPieceRateConf(Sender).MakeCoupons := True;
        TBOMSalesPieceRateConf(Sender).PostDB;
      end;

end;
procedure TBOMSalesPieceRateConf.SaveCallback(const Sender: TBusObj;var Abort: Boolean);
begin
    if ProcessPartId <> 0 then begin
      if Processpart.Count =1 then begin
        Processpart.RatePercoupon := self.RAtePercoupon;
        Processpart.QtyPercoupon := self.QtyPercoupon;
        Processpart.CouponsPerBundle := self.CouponsPerBundle;
        Processpart.BundleQty := self.BundleQty;
        Processpart.MakeCoupons := Self.MakeCoupons;
        Processpart.CouponLabelPrinted := Self.CouponLabelPrinted;
        Processpart.PostDB;
      end;
    end else if ProctreeId <> 0 then begin
      if ProcTree.Count =1 then begin
        ProcTree.RatePercoupon := self.RAtePercoupon;
        ProcTree.QtyPercoupon := self.QtyPercoupon;
        ProcTree.CouponsPerBundle := self.CouponsPerBundle;
        ProcTree.BundleQty := self.BundleQty;
        ProcTree.MakeCoupons := Self.MakeCoupons;
        ProcTree.CouponLabelPrinted := Self.CouponLabelPrinted;
        ProcTree.PostDB;
      end;
    end;
    MakeBarcodeXRefs;
end;

(*  {TProcTree}

constructor TProcTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProcTree';
  fSQL := 'SELECT * FROM tblproctree';
  LockGroupname := 'Work Order'
end;


destructor TProcTree.Destroy;
begin
  inherited;
end;


procedure TProcTree.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TreeRootId');
  SetPropertyFromNode(node,'ParentId');
  SetPropertyFromNode(node,'MasterId');
  SetPropertyFromNode(node,'MasterType');
  SetPropertyFromNode(node,'SequenceDown');
  SetPropertyFromNode(node,'SequenceUp');
  SetPropertyFromNode(node,'EditVersion');
  SetPropertyFromNode(node,'Caption');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Details');
  SetPropertyFromNode(node,'PartsId');
  SetPropertyFromNode(node,'SaleLineId');
  SetPropertyFromNode(node,'PurchaseLineId');
  SetBooleanPropertyFromNode(node,'IsTemplate');
  SetPropertyFromNode(node,'Quantity');
  SetPropertyFromNode(node,'TotalQty');
  SetPropertyFromNode(node,'TotalQtyOriginal');
  SetPropertyFromNode(node,'QtyOriginal');
  SetPropertyFromNode(node,'QtyVariation');
  SetBooleanPropertyFromNode(node,'HideOnPrint');
  SetBooleanPropertyFromNode(node,'AddToSale');
  SetPropertyFromNode(node,'LinkedLineId');
  SetPropertyFromNode(node,'PartSource');
  SetPropertyFromNode(node,'InputType');
  SetPropertyFromNode(node,'CustomInputClass');
  SetPropertyFromNode(node,'Price');
  SetBooleanPropertyFromNode(node,'TreePricechanged');
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'ProcStepItemRef');
  SetBooleanPropertyFromNode(node,'Selected');
  SetPropertyFromNode(node,'Value');
  SetBooleanPropertyFromNode(node,'Complete');
  SetPropertyFromNode(node,'Level');
  SetPropertyFromNode(node,'Info');
  SetPropertyFromNode(node,'QtyPer');
  SetPropertyFromNode(node,'TreePartUOM');
  SetPropertyFromNode(node,'TreePartUOMID');
  SetPropertyFromNode(node,'TreePartUOMMultiplier');
  SetPropertyFromNode(node,'TreePartUOMQuantity');
  SetPropertyFromNode(node,'TreePartUOMTotalQty');
  SetPropertyFromNode(node,'MatrixDesc');
  SetPropertyFromNode(node,'MatrixRef');
  SetPropertyFromNode(node,'MatrixPrice');
  SetPropertyFromNode(node,'FromStockUOMQty');
  SetPropertyFromNode(node,'ManufactureUOMQty');
  SetPropertyFromNode(node,'OnOrderUOMQty');
  SetPropertyFromNode(node,'FromStockQty');
  SetPropertyFromNode(node,'ManufactureQty');
  SetPropertyFromNode(node,'OnOrderQty');
  SetPropertyFromNode(node,'QtyPlanned');
  SetPropertyFromNode(node,'TotalQtyPlanned');
  SetPropertyFromNode(node,'FormulaQtyValue1');
  SetPropertyFromNode(node,'FormulaQtyValue2');
  SetPropertyFromNode(node,'FormulaQtyValue3');
  SetPropertyFromNode(node,'FormulaQtyValue4');
  SetPropertyFromNode(node,'FormulaQtyValue5');
  SetPropertyFromNode(node,'FormulaQtyValue');
  SetPropertyFromNode(node,'BuildFormulaQtyValue1');
  SetPropertyFromNode(node,'BuildFormulaQtyValue2');
  SetPropertyFromNode(node,'BuildFormulaQtyValue3');
  SetPropertyFromNode(node,'BuildFormulaQtyValue4');
  SetPropertyFromNode(node,'BuildFormulaQtyValue5');
  SetPropertyFromNode(node,'BuildFormulaQtyValue');
  SetPropertyFromNode(node,'OrderFormulaQtyValue1');
  SetPropertyFromNode(node,'OrderFormulaQtyValue2');
  SetPropertyFromNode(node,'OrderFormulaQtyValue3');
  SetPropertyFromNode(node,'OrderFormulaQtyValue4');
  SetPropertyFromNode(node,'OrderFormulaQtyValue5');
  SetPropertyFromNode(node,'OrderFormulaQtyValue');
  SetPropertyFromNode(node,'ProductUnitPrice');
  SetPropertyFromNode(node,'ProductUnitCost');
  SetBooleanPropertyFromNode(node,'BOMGroupedLine');
  SetBooleanPropertyFromNode(node,'BOMProductionLine');
  SetBooleanPropertyFromNode(node,'MakeCoupons');
  SetBooleanPropertyFromNode(node,'CouponLabelPrinted');
  SetPropertyFromNode(node,'QtyPerCoupon');
  SetPropertyFromNode(node,'RAtePercoupon');
  SetPropertyFromNode(node,'CouponsPerBundle');
  SetPropertyFromNode(node,'BundleQty');
end;


procedure TProcTree.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TreeRootId' ,TreeRootId);
  AddXMLNode(node,'ParentId' ,ParentId);
  AddXMLNode(node,'MasterId' ,MasterId);
  AddXMLNode(node,'MasterType' ,MasterType);
  AddXMLNode(node,'SequenceDown' ,SequenceDown);
  AddXMLNode(node,'SequenceUp' ,SequenceUp);
  AddXMLNode(node,'EditVersion' ,EditVersion);
  AddXMLNode(node,'Caption' ,Caption);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Details' ,Details);
  AddXMLNode(node,'PartsId' ,PartsId);
  AddXMLNode(node,'SaleLineId' ,SaleLineId);
  AddXMLNode(node,'PurchaseLineId' ,PurchaseLineId);
  AddXMLNode(node,'IsTemplate' ,IsTemplate);
  AddXMLNode(node,'Quantity' ,Quantity);
  AddXMLNode(node,'TotalQty' ,TotalQty);
  AddXMLNode(node,'TotalQtyOriginal' ,TotalQtyOriginal);
  AddXMLNode(node,'QtyOriginal' ,QtyOriginal);
  AddXMLNode(node,'QtyVariation' ,QtyVariation);
  AddXMLNode(node,'HideOnPrint' ,HideOnPrint);
  AddXMLNode(node,'AddToSale' ,AddToSale);
  AddXMLNode(node,'LinkedLineId' ,LinkedLineId);
  AddXMLNode(node,'PartSource' ,PartSource);
  AddXMLNode(node,'InputType' ,InputType);
  AddXMLNode(node,'CustomInputClass' ,CustomInputClass);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'TreePricechanged' ,TreePricechanged);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'ProcStepItemRef' ,ProcStepItemRef);
  AddXMLNode(node,'Selected' ,Selected);
  AddXMLNode(node,'Value' ,Value);
  AddXMLNode(node,'Complete' ,Complete);
  AddXMLNode(node,'Level' ,Level);
  AddXMLNode(node,'Info' ,Info);
  AddXMLNode(node,'QtyPer' ,QtyPer);
  AddXMLNode(node,'TreePartUOM' ,TreePartUOM);
  AddXMLNode(node,'TreePartUOMID' ,TreePartUOMID);
  AddXMLNode(node,'TreePartUOMMultiplier' ,TreePartUOMMultiplier);
  AddXMLNode(node,'TreePartUOMQuantity' ,TreePartUOMQuantity);
  AddXMLNode(node,'TreePartUOMTotalQty' ,TreePartUOMTotalQty);
  AddXMLNode(node,'MatrixDesc' ,MatrixDesc);
  AddXMLNode(node,'MatrixRef' ,MatrixRef);
  AddXMLNode(node,'MatrixPrice' ,MatrixPrice);
  AddXMLNode(node,'FromStockUOMQty' ,FromStockUOMQty);
  AddXMLNode(node,'ManufactureUOMQty' ,ManufactureUOMQty);
  AddXMLNode(node,'OnOrderUOMQty' ,OnOrderUOMQty);
  AddXMLNode(node,'FromStockQty' ,FromStockQty);
  AddXMLNode(node,'ManufactureQty' ,ManufactureQty);
  AddXMLNode(node,'OnOrderQty' ,OnOrderQty);
  AddXMLNode(node,'QtyPlanned' ,QtyPlanned);
  AddXMLNode(node,'TotalQtyPlanned' ,TotalQtyPlanned);
  AddXMLNode(node,'FormulaQtyValue1' ,FormulaQtyValue1);
  AddXMLNode(node,'FormulaQtyValue2' ,FormulaQtyValue2);
  AddXMLNode(node,'FormulaQtyValue3' ,FormulaQtyValue3);
  AddXMLNode(node,'FormulaQtyValue4' ,FormulaQtyValue4);
  AddXMLNode(node,'FormulaQtyValue5' ,FormulaQtyValue5);
  AddXMLNode(node,'FormulaQtyValue' ,FormulaQtyValue);
  AddXMLNode(node,'BuildFormulaQtyValue1' ,BuildFormulaQtyValue1);
  AddXMLNode(node,'BuildFormulaQtyValue2' ,BuildFormulaQtyValue2);
  AddXMLNode(node,'BuildFormulaQtyValue3' ,BuildFormulaQtyValue3);
  AddXMLNode(node,'BuildFormulaQtyValue4' ,BuildFormulaQtyValue4);
  AddXMLNode(node,'BuildFormulaQtyValue5' ,BuildFormulaQtyValue5);
  AddXMLNode(node,'BuildFormulaQtyValue' ,BuildFormulaQtyValue);
  AddXMLNode(node,'OrderFormulaQtyValue1' ,OrderFormulaQtyValue1);
  AddXMLNode(node,'OrderFormulaQtyValue2' ,OrderFormulaQtyValue2);
  AddXMLNode(node,'OrderFormulaQtyValue3' ,OrderFormulaQtyValue3);
  AddXMLNode(node,'OrderFormulaQtyValue4' ,OrderFormulaQtyValue4);
  AddXMLNode(node,'OrderFormulaQtyValue5' ,OrderFormulaQtyValue5);
  AddXMLNode(node,'OrderFormulaQtyValue' ,OrderFormulaQtyValue);
  AddXMLNode(node,'ProductUnitPrice' ,ProductUnitPrice);
  AddXMLNode(node,'ProductUnitCost' ,ProductUnitCost);
  AddXMLNode(node,'BOMGroupedLine' ,BOMGroupedLine);
  AddXMLNode(node,'BOMProductionLine' ,BOMProductionLine);
  AddXMLNode(node,'MakeCoupons' ,MakeCoupons);
  AddXMLNode(node,'CouponLabelPrinted' ,CouponLabelPrinted);
  AddXMLNode(node,'QtyPerCoupon' ,QtyPerCoupon);
  AddXMLNode(node,'RAtePercoupon' ,RAtePercoupon);
  AddXMLNode(node,'CouponsPerBundle' ,CouponsPerBundle);
  AddXMLNode(node,'BundleQty' ,BundleQty);
end;


function TProcTree.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TProcTree.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProcTree.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProcTree.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProcTree.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProcTree.GetIDField: string;
begin
  Result := 'ProcTreeId'
end;


class function TProcTree.GetBusObjectTablename: string;
begin
  Result:= 'tblproctree';
end;


function TProcTree.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProcTree.GetTreeRootId           : Integer   ; begin Result := GetIntegerField('TreeRootId');end;
function  TProcTree.GetParentId             : Integer   ; begin Result := GetIntegerField('ParentId');end;
function  TProcTree.GetMasterId             : Integer   ; begin Result := GetIntegerField('MasterId');end;
function  TProcTree.GetMasterType           : string    ; begin Result := GetStringField('MasterType');end;
function  TProcTree.GetSequenceDown         : Integer   ; begin Result := GetIntegerField('SequenceDown');end;
function  TProcTree.GetSequenceUp           : Integer   ; begin Result := GetIntegerField('SequenceUp');end;
function  TProcTree.GetEditVersion          : Integer   ; begin Result := GetIntegerField('EditVersion');end;
function  TProcTree.GetCaption              : string    ; begin Result := GetStringField('Caption');end;
function  TProcTree.GetDescription          : string    ; begin Result := GetStringField('Description');end;
function  TProcTree.GetDetails              : string    ; begin Result := GetStringField('Details');end;
function  TProcTree.GetPartsId              : Integer   ; begin Result := GetIntegerField('PartsId');end;
function  TProcTree.GetSaleLineId           : Integer   ; begin Result := GetIntegerField('SaleLineId');end;
function  TProcTree.GetPurchaseLineId       : Integer   ; begin Result := GetIntegerField('PurchaseLineId');end;
function  TProcTree.GetIsTemplate           : Boolean   ; begin Result := GetBooleanField('IsTemplate');end;
function  TProcTree.GetQuantity             : Double    ; begin Result := GetFloatField('Quantity');end;
function  TProcTree.GetTotalQty             : Double    ; begin Result := GetFloatField('TotalQty');end;
function  TProcTree.GetTotalQtyOriginal     : Double    ; begin Result := GetFloatField('TotalQtyOriginal');end;
function  TProcTree.GetQtyOriginal          : Double    ; begin Result := GetFloatField('QtyOriginal');end;
function  TProcTree.GetQtyVariation         : Double    ; begin Result := GetFloatField('QtyVariation');end;
function  TProcTree.GetHideOnPrint          : Boolean   ; begin Result := GetBooleanField('HideOnPrint');end;
function  TProcTree.GetAddToSale            : Boolean   ; begin Result := GetBooleanField('AddToSale');end;
function  TProcTree.GetLinkedLineId         : Integer   ; begin Result := GetIntegerField('LinkedLineId');end;
function  TProcTree.GetPartSource           : string    ; begin Result := GetStringField('PartSource');end;
function  TProcTree.GetInputType            : string    ; begin Result := GetStringField('InputType');end;
function  TProcTree.GetCustomInputClass     : string    ; begin Result := GetStringField('CustomInputClass');end;
function  TProcTree.GetPrice                : Double    ; begin Result := GetFloatField('Price');end;
function  TProcTree.GetTreePricechanged     : Boolean   ; begin Result := GetBooleanField('TreePricechanged');end;
function  TProcTree.GetCost                 : Double    ; begin Result := GetFloatField('Cost');end;
function  TProcTree.GetProcStepItemRef      : string    ; begin Result := GetStringField('ProcStepItemRef');end;
function  TProcTree.GetSelected             : Boolean   ; begin Result := GetBooleanField('Selected');end;
function  TProcTree.GetValue                : string    ; begin Result := GetStringField('Value');end;
function  TProcTree.GetComplete             : Boolean   ; begin Result := GetBooleanField('Complete');end;
function  TProcTree.GetLevel                : Integer   ; begin Result := GetIntegerField('Level');end;
function  TProcTree.GetInfo                 : string    ; begin Result := GetStringField('Info');end;
function  TProcTree.GetQtyPer               : Double    ; begin Result := GetFloatField('QtyPer');end;
function  TProcTree.GetTreePartUOM          : string    ; begin Result := GetStringField('TreePartUOM');end;
function  TProcTree.GetTreePartUOMID        : Integer   ; begin Result := GetIntegerField('TreePartUOMID');end;
function  TProcTree.GetTreePartUOMMultiplier: Double    ; begin Result := GetFloatField('TreePartUOMMultiplier');end;
function  TProcTree.GetTreePartUOMQuantity  : Double    ; begin Result := GetFloatField('TreePartUOMQuantity');end;
function  TProcTree.GetTreePartUOMTotalQty  : Double    ; begin Result := GetFloatField('TreePartUOMTotalQty');end;
function  TProcTree.GetMatrixDesc           : string    ; begin Result := GetStringField('MatrixDesc');end;
function  TProcTree.GetMatrixRef            : string    ; begin Result := GetStringField('MatrixRef');end;
function  TProcTree.GetMatrixPrice          : Double    ; begin Result := GetFloatField('MatrixPrice');end;
function  TProcTree.GetFromStockUOMQty      : Double    ; begin Result := GetFloatField('FromStockUOMQty');end;
function  TProcTree.GetManufactureUOMQty    : Double    ; begin Result := GetFloatField('ManufactureUOMQty');end;
function  TProcTree.GetOnOrderUOMQty        : Double    ; begin Result := GetFloatField('OnOrderUOMQty');end;
function  TProcTree.GetFromStockQty         : Double    ; begin Result := GetFloatField('FromStockQty');end;
function  TProcTree.GetManufactureQty       : Double    ; begin Result := GetFloatField('ManufactureQty');end;
function  TProcTree.GetOnOrderQty           : Double    ; begin Result := GetFloatField('OnOrderQty');end;
function  TProcTree.GetQtyPlanned           : Double    ; begin Result := GetFloatField('QtyPlanned');end;
function  TProcTree.GetTotalQtyPlanned      : Double    ; begin Result := GetFloatField('TotalQtyPlanned');end;
function  TProcTree.GetFormulaQtyValue1     : Double    ; begin Result := GetFloatField('FormulaQtyValue1');end;
function  TProcTree.GetFormulaQtyValue2     : Double    ; begin Result := GetFloatField('FormulaQtyValue2');end;
function  TProcTree.GetFormulaQtyValue3     : Double    ; begin Result := GetFloatField('FormulaQtyValue3');end;
function  TProcTree.GetFormulaQtyValue4     : Double    ; begin Result := GetFloatField('FormulaQtyValue4');end;
function  TProcTree.GetFormulaQtyValue5     : Double    ; begin Result := GetFloatField('FormulaQtyValue5');end;
function  TProcTree.GetFormulaQtyValue      : Double    ; begin Result := GetFloatField('FormulaQtyValue');end;
function  TProcTree.GetBuildFormulaQtyValue1: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue1');end;
function  TProcTree.GetBuildFormulaQtyValue2: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue2');end;
function  TProcTree.GetBuildFormulaQtyValue3: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue3');end;
function  TProcTree.GetBuildFormulaQtyValue4: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue4');end;
function  TProcTree.GetBuildFormulaQtyValue5: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue5');end;
function  TProcTree.GetBuildFormulaQtyValue : Double    ; begin Result := GetFloatField('BuildFormulaQtyValue');end;
function  TProcTree.GetOrderFormulaQtyValue1: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue1');end;
function  TProcTree.GetOrderFormulaQtyValue2: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue2');end;
function  TProcTree.GetOrderFormulaQtyValue3: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue3');end;
function  TProcTree.GetOrderFormulaQtyValue4: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue4');end;
function  TProcTree.GetOrderFormulaQtyValue5: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue5');end;
function  TProcTree.GetOrderFormulaQtyValue : Double    ; begin Result := GetFloatField('OrderFormulaQtyValue');end;
function  TProcTree.GetProductUnitPrice     : Double    ; begin Result := GetFloatField('ProductUnitPrice');end;
function  TProcTree.GetProductUnitCost      : Double    ; begin Result := GetFloatField('ProductUnitCost');end;
function  TProcTree.GetBOMGroupedLine       : Boolean   ; begin Result := GetBooleanField('BOMGroupedLine');end;
function  TProcTree.GetBOMProductionLine    : Boolean   ; begin Result := GetBooleanField('BOMProductionLine');end;
function  TProcTree.GetMakeCoupons          : Boolean   ; begin Result := GetBooleanField('MakeCoupons');end;
function  TProcTree.GetCouponLabelPrinted   : Boolean   ; begin Result := GetBooleanField('CouponLabelPrinted');end;
function  TProcTree.GetQtyPerCoupon         : Double    ; begin Result := GetFloatField('QtyPerCoupon');end;
function  TProcTree.GetRAtePercoupon        : Double    ; begin Result := GetFloatField('RAtePercoupon');end;
function  TProcTree.GetCouponsPerBundle     : Double    ; begin Result := GetFloatField('CouponsPerBundle');end;
function  TProcTree.GetBundleQty            : Double    ; begin Result := GetFloatField('BundleQty');end;
procedure TProcTree.SetTreeRootId           (const Value: Integer   ); begin SetIntegerField('TreeRootId'            , Value);end;
procedure TProcTree.SetParentId             (const Value: Integer   ); begin SetIntegerField('ParentId'              , Value);end;
procedure TProcTree.SetMasterId             (const Value: Integer   ); begin SetIntegerField('MasterId'              , Value);end;
procedure TProcTree.SetMasterType           (const Value: string    ); begin SetStringField('MasterType'            , Value);end;
procedure TProcTree.SetSequenceDown         (const Value: Integer   ); begin SetIntegerField('SequenceDown'          , Value);end;
procedure TProcTree.SetSequenceUp           (const Value: Integer   ); begin SetIntegerField('SequenceUp'            , Value);end;
procedure TProcTree.SetEditVersion          (const Value: Integer   ); begin SetIntegerField('EditVersion'           , Value);end;
procedure TProcTree.SetCaption              (const Value: string    ); begin SetStringField('Caption'               , Value);end;
procedure TProcTree.SetDescription          (const Value: string    ); begin SetStringField('Description'           , Value);end;
procedure TProcTree.SetDetails              (const Value: string    ); begin SetStringField('Details'               , Value);end;
procedure TProcTree.SetPartsId              (const Value: Integer   ); begin SetIntegerField('PartsId'               , Value);end;
procedure TProcTree.SetSaleLineId           (const Value: Integer   ); begin SetIntegerField('SaleLineId'            , Value);end;
procedure TProcTree.SetPurchaseLineId       (const Value: Integer   ); begin SetIntegerField('PurchaseLineId'        , Value);end;
procedure TProcTree.SetIsTemplate           (const Value: Boolean   ); begin SetBooleanField('IsTemplate'            , Value);end;
procedure TProcTree.SetQuantity             (const Value: Double    ); begin SetFloatField('Quantity'              , Value);end;
procedure TProcTree.SetTotalQty             (const Value: Double    ); begin SetFloatField('TotalQty'              , Value);end;
procedure TProcTree.SetTotalQtyOriginal     (const Value: Double    ); begin SetFloatField('TotalQtyOriginal'      , Value);end;
procedure TProcTree.SetQtyOriginal          (const Value: Double    ); begin SetFloatField('QtyOriginal'           , Value);end;
procedure TProcTree.SetQtyVariation         (const Value: Double    ); begin SetFloatField('QtyVariation'          , Value);end;
procedure TProcTree.SetHideOnPrint          (const Value: Boolean   ); begin SetBooleanField('HideOnPrint'           , Value);end;
procedure TProcTree.SetAddToSale            (const Value: Boolean   ); begin SetBooleanField('AddToSale'             , Value);end;
procedure TProcTree.SetLinkedLineId         (const Value: Integer   ); begin SetIntegerField('LinkedLineId'          , Value);end;
procedure TProcTree.SetPartSource           (const Value: string    ); begin SetStringField('PartSource'            , Value);end;
procedure TProcTree.SetInputType            (const Value: string    ); begin SetStringField('InputType'             , Value);end;
procedure TProcTree.SetCustomInputClass     (const Value: string    ); begin SetStringField('CustomInputClass'      , Value);end;
procedure TProcTree.SetPrice                (const Value: Double    ); begin SetFloatField('Price'                 , Value);end;
procedure TProcTree.SetTreePricechanged     (const Value: Boolean   ); begin SetBooleanField('TreePricechanged'      , Value);end;
procedure TProcTree.SetCost                 (const Value: Double    ); begin SetFloatField('Cost'                  , Value);end;
procedure TProcTree.SetProcStepItemRef      (const Value: string    ); begin SetStringField('ProcStepItemRef'       , Value);end;
procedure TProcTree.SetSelected             (const Value: Boolean   ); begin SetBooleanField('Selected'              , Value);end;
procedure TProcTree.SetValue                (const Value: string    ); begin SetStringField('Value'                 , Value);end;
procedure TProcTree.SetComplete             (const Value: Boolean   ); begin SetBooleanField('Complete'              , Value);end;
procedure TProcTree.SetLevel                (const Value: Integer   ); begin SetIntegerField('Level'                 , Value);end;
procedure TProcTree.SetInfo                 (const Value: string    ); begin SetStringField('Info'                  , Value);end;
procedure TProcTree.SetQtyPer               (const Value: Double    ); begin SetFloatField('QtyPer'                , Value);end;
procedure TProcTree.SetTreePartUOM          (const Value: string    ); begin SetStringField('TreePartUOM'           , Value);end;
procedure TProcTree.SetTreePartUOMID        (const Value: Integer   ); begin SetIntegerField('TreePartUOMID'         , Value);end;
procedure TProcTree.SetTreePartUOMMultiplier(const Value: Double    ); begin SetFloatField('TreePartUOMMultiplier' , Value);end;
procedure TProcTree.SetTreePartUOMQuantity  (const Value: Double    ); begin SetFloatField('TreePartUOMQuantity'   , Value);end;
procedure TProcTree.SetTreePartUOMTotalQty  (const Value: Double    ); begin SetFloatField('TreePartUOMTotalQty'   , Value);end;
procedure TProcTree.SetMatrixDesc           (const Value: string    ); begin SetStringField('MatrixDesc'            , Value);end;
procedure TProcTree.SetMatrixRef            (const Value: string    ); begin SetStringField('MatrixRef'             , Value);end;
procedure TProcTree.SetMatrixPrice          (const Value: Double    ); begin SetFloatField('MatrixPrice'           , Value);end;
procedure TProcTree.SetFromStockUOMQty      (const Value: Double    ); begin SetFloatField('FromStockUOMQty'       , Value);end;
procedure TProcTree.SetManufactureUOMQty    (const Value: Double    ); begin SetFloatField('ManufactureUOMQty'     , Value);end;
procedure TProcTree.SetOnOrderUOMQty        (const Value: Double    ); begin SetFloatField('OnOrderUOMQty'         , Value);end;
procedure TProcTree.SetFromStockQty         (const Value: Double    ); begin SetFloatField('FromStockQty'          , Value);end;
procedure TProcTree.SetManufactureQty       (const Value: Double    ); begin SetFloatField('ManufactureQty'        , Value);end;
procedure TProcTree.SetOnOrderQty           (const Value: Double    ); begin SetFloatField('OnOrderQty'            , Value);end;
procedure TProcTree.SetQtyPlanned           (const Value: Double    ); begin SetFloatField('QtyPlanned'            , Value);end;
procedure TProcTree.SetTotalQtyPlanned      (const Value: Double    ); begin SetFloatField('TotalQtyPlanned'       , Value);end;
procedure TProcTree.SetFormulaQtyValue1     (const Value: Double    ); begin SetFloatField('FormulaQtyValue1'      , Value);end;
procedure TProcTree.SetFormulaQtyValue2     (const Value: Double    ); begin SetFloatField('FormulaQtyValue2'      , Value);end;
procedure TProcTree.SetFormulaQtyValue3     (const Value: Double    ); begin SetFloatField('FormulaQtyValue3'      , Value);end;
procedure TProcTree.SetFormulaQtyValue4     (const Value: Double    ); begin SetFloatField('FormulaQtyValue4'      , Value);end;
procedure TProcTree.SetFormulaQtyValue5     (const Value: Double    ); begin SetFloatField('FormulaQtyValue5'      , Value);end;
procedure TProcTree.SetFormulaQtyValue      (const Value: Double    ); begin SetFloatField('FormulaQtyValue'       , Value);end;
procedure TProcTree.SetBuildFormulaQtyValue1(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue1' , Value);end;
procedure TProcTree.SetBuildFormulaQtyValue2(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue2' , Value);end;
procedure TProcTree.SetBuildFormulaQtyValue3(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue3' , Value);end;
procedure TProcTree.SetBuildFormulaQtyValue4(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue4' , Value);end;
procedure TProcTree.SetBuildFormulaQtyValue5(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue5' , Value);end;
procedure TProcTree.SetBuildFormulaQtyValue (const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue'  , Value);end;
procedure TProcTree.SetOrderFormulaQtyValue1(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue1' , Value);end;
procedure TProcTree.SetOrderFormulaQtyValue2(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue2' , Value);end;
procedure TProcTree.SetOrderFormulaQtyValue3(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue3' , Value);end;
procedure TProcTree.SetOrderFormulaQtyValue4(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue4' , Value);end;
procedure TProcTree.SetOrderFormulaQtyValue5(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue5' , Value);end;
procedure TProcTree.SetOrderFormulaQtyValue (const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue'  , Value);end;
procedure TProcTree.SetProductUnitPrice     (const Value: Double    ); begin SetFloatField('ProductUnitPrice'      , Value);end;
procedure TProcTree.SetProductUnitCost      (const Value: Double    ); begin SetFloatField('ProductUnitCost'       , Value);end;
procedure TProcTree.SetBOMGroupedLine       (const Value: Boolean   ); begin SetBooleanField('BOMGroupedLine'      , Value);end;
procedure TProcTree.SetBOMProductionLine    (const Value: Boolean   ); begin SetBooleanField('BOMProductionLine'   , Value);end;
procedure TProcTree.SetMakeCoupons          (const Value: Boolean   ); begin SetBooleanField('MakeCoupons'         , Value);end;
procedure TProcTree.SetCouponLabelPrinted   (const Value: Boolean   ); begin SetBooleanField('CouponLabelPrinted'  , Value);end;
procedure TProcTree.SetQtyPerCoupon         (const Value: Double    ); begin SetFloatField('QtyPerCoupon'          , Value);end;
procedure TProcTree.SetRAtePercoupon        (const Value: Double    ); begin SetFloatField('RAtePercoupon'         , Value);end;
procedure TProcTree.SetCouponsPerBundle     (const Value: Double    ); begin SetFloatField('CouponsPerBundle'      , Value);end;
procedure TProcTree.SetBundleQty            (const Value: Double    ); begin SetFloatField('BundleQty'             , Value);end;*)
initialization
  RegisterClass(TBOMSalesPieceRateConf);
  //RegisterClass(TProcTree);


end.
