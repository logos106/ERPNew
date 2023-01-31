unit BusobjProctree;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/10/16  1.00.00  A.  Initial Version.
  }


interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusObjProcTreePart  , BusobjStock , BusObjProcessPart , procProgressLib , types;


type

  TProcTree = class(TMSBusObj)
  private
    fbAllLinesValid:Boolean;
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
    function GetManufacturedUOMQty       : Double    ;
    function GetManufacturingUOMQty      : Double    ;
    function GetOnOrderUOMQty            : Double    ;
    function GetFromStockQty             : Double    ;
    function GetManufactureQty           : Double    ;
    function GetManufacturedQty          : Double    ;
    function GetManufacturingQty         : Double    ;
    function GetOnOrderQty               : Double    ;
    function GetQtyPlanned               : Double    ;
    function GetTotalQtyPlanned          : Double    ;
    function GetFormulaID                : Integer   ;
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
    function GetZeroWhenLessthan1        : Boolean   ;
    function GetRoundtoNextNumber        : Boolean   ;
    function GetRoundtoPrevNumber        : Boolean   ;
    function GetSubBOMProcessOrder       : string    ;
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
    procedure SetManufacturedUOMQty       (const Value: Double    );
    procedure SetManufacturingUOMQty      (const Value: Double    );
    procedure SetOnOrderUOMQty            (const Value: Double    );
    procedure SetFromStockQty             (const Value: Double    );
    procedure SetManufactureQty           (const Value: Double    );
    procedure SetManufacturedQty          (const Value: Double    );
    procedure SetManufacturingQty         (const Value: Double    );
    procedure SetOnOrderQty               (const Value: Double    );
    procedure SetQtyPlanned               (const Value: Double    );
    procedure SetTotalQtyPlanned          (const Value: Double    );
    procedure SetFormulaID                (const Value: Integer   );
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
    procedure SetZeroWhenLessthan1        (const Value: Boolean   );
    procedure SetRoundtoNextNumber        (const Value: Boolean   );
    procedure SetRoundtoPrevNumber        (const Value: Boolean   );
    procedure SetSubBOMProcessOrder       (const Value: string    );
    function getProcTreePart: TProcTreePart;
    function geParentItem: Tproctree;
    function getProduct: TProduct;
    function getBatch: Boolean;
    function getMultipleBins: Boolean;
    function getSNTracking: Boolean;
    function getSaleID: Integer;
    function getWastageQty: Double;
    procedure BatchTrackingCheckCallback(const Sender: TBusObj;
      var Abort: Boolean);
    procedure SNTrackingCheckCallback(const Sender: TBusObj;
      var Abort: Boolean);
    procedure InitUOM(const fiProductID: Integer);
    function getProcessPart: TProcessPart;
    function GetTreeChildren: TProctree;
    function getConvertCurrent: Boolean;
    function TreehasProgressbuild: Boolean;
    function getSaleSID: Integer;
    function getSalesLineID: Integer;
    function getSubBOM_BuildFirst: Boolean;
    function getSubBOM_UseAvailableQtyFirst: Boolean;
    function getSubBOM_UseFromStockQtyFirst: Boolean;
    function getLevelIntendSpaces: String;

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
    Property     Product : TProduct read getProduct;
    Property    Batch       :Boolean read getBatch;
    Property    MultipleBins:Boolean read getMultipleBins;
    Property    SNTracking  :Boolean read getSNTracking;
    Property    SaleID :Integer read getSaleID;
    Property    WastageQty :Double read getWastageQty;
    Function    IsAnychildrenSNTracking :Boolean;
    Function    IsAnychildrenBatchTracking :Boolean;
    Function DoBuildaQty(DoneQtytype : tDoneQtytype; dt:TDateTime;
      var returnProcProgID:Integer; var PPGMsg:String; fdBuildQty :Double = 1): Boolean; Overload;
    Function DoBuildaQty(DoneQtytype : tDoneQtytype; dt:TDateTime; fdBuildQty :Double ;
      BatchnoFormat :TStringDynArray ; SNFormat:TStringDynArray; var returnProcProgID: Integer; var PPGMsg:String) :Boolean;Overload;
    Function FindTreeItem(aParentId :Integer ; aCaption :String; aPartsId :Integer; aQty :double) :TProctree;
    Property Children :TProctree read GetTreeChildren;
    Function newChild(var aParentId: Integer):Tproctree;
    Property ConvertCurrent :Boolean read getConvertCurrent;
    Procedure CompleteallProcprogress;
    procedure DoFieldOnChange(Sender: TField);                          override;
    Property SalesID:Integer read getSaleSID;
    Property SalesLineID :Integer read getSalesLineID;
    property SubBOM_BuildFirst :Boolean read getSubBOM_BuildFirst;
    property SubBOM_UseAvailableQtyFirst :Boolean read getSubBOM_UseAvailableQtyFirst;
    property SubBOM_UseFromStockQtyFirst :Boolean read getSubBOM_UseFromStockQtyFirst;
    Property LevelIntendSpaces :String read getLevelIntendSpaces;

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
    property ManufacturedUOMQty        :Double      read GetManufacturedUOMQty      write SetManufacturedUOMQty   ;
    property ManufacturingUOMQty       :Double      read GetManufacturingUOMQty     write SetManufacturingUOMQty  ;
    property OnOrderUOMQty             :Double      read GetOnOrderUOMQty           write SetOnOrderUOMQty        ;
    property FromStockQty              :Double      read GetFromStockQty            write SetFromStockQty         ;
    property ManufactureQty            :Double      read GetManufactureQty          write SetManufactureQty       ;
    property ManufacturedQty           :Double      read GetManufacturedQty         write SetManufacturedQty      ;
    property ManufacturingQty          :Double      read GetManufacturingQty        write SetManufacturingQty     ;
    property OnOrderQty                :Double      read GetOnOrderQty              write SetOnOrderQty           ;
    property QtyPlanned                :Double      read GetQtyPlanned              write SetQtyPlanned           ;
    property TotalQtyPlanned           :Double      read GetTotalQtyPlanned         write SetTotalQtyPlanned      ;
    property FormulaID                 :Integer     read GetFormulaID               write SetFormulaID            ;
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
    property ZeroWhenLessthan1         :Boolean     read GetZeroWhenLessthan1       write SetZeroWhenLessthan1    ;
    property RoundtoNextNumber         :Boolean     read GetRoundtoNextNumber       write SetRoundtoNextNumber    ;
    property RoundtoPrevNumber         :Boolean     read GetRoundtoPrevNumber       write SetRoundtoPrevNumber    ;
    property SubBOMProcessOrder        :string      read GetSubBOMProcessOrder      write SetSubBOMProcessOrder   ;

    Property ProcTreePart : TProcTreePart read getProcTreePart;
    Property ParentItem     : Tproctree read geParentItem;
    Property ProcessPart   : TProcessPart read getProcessPart;
  end;

  TproctreeRoot = Class(Tproctree)

  End;

implementation

uses ERPdbComponents, tcDataUtils, CommonLib , sysutils, busobjProcProgress,
  DbSharedObjectsObj, AppEnvironment, BusObjConst,  CommonDbLib ,
  BusObjSales,busobjPQA, LogLib, dateutils, tcConst;

  {Tproctree}
Function TProcTree.DoBuildaQty(DoneQtytype : tDoneQtytype; dt:TDateTime;
  var returnProcProgID:Integer; var PPGMsg:String; fdBuildQty: Double = 1 ): Boolean;
var
  BatchnoFormat :TStringDynArray ;
  SNFormat:TStringDynArray;
begin
  SetLength(BatchnoFormat,0);
  SetLength(SNFormat,0);
  result := DoBuildaQty(DoneQtytype ,dt,fdBuildQty ,BatchnoFormat ,SNFormat, returnProcProgID ,PPGMsg);
end;

Function TProcTree.DoBuildaQty(DoneQtytype: tDoneQtytype; dt:TDateTime;
  fdBuildQty :Double ; BatchnoFormat :TStringDynArray; SNFormat:TStringDynArray;
  var returnProcProgID:Integer; var PPGMsg:String) :Boolean;
var
  ctr:Integer;
  fsPTPAllocParentRef:String;
  fsParentPTPAllocParentRef:String;
  fsStr, errMsg:STring;
  fiindex :Integer;
  fSO:TSalesOrder;
  fdQty:Double;
  s:String;
  fdCostCalc:Double;
  aPPGMsg :String;

  Function SalesOrder :TSalesOrder;
  begin
    if Assigned(Owner) and (Owner is TSalesOrderLine) then
      if Assigned(Owner.Owner) and (Owner.Owner is TSalesOrder) then begin
        REsult :=TSalesOrder(Owner.Owner);
        Exit;
      end;
      if fSO = nil then begin
        fSO := TSalesOrder.Create(nil);
        fSO.Connection := Self.connection;
        fSO.Load(SalesId);
      end;
      REsult := fSO;
  end;
  Function SalesOrderLine:TSalesOrderline;
  begin
    if Assigned(Owner) and (Owner is TSalesOrderLine) then begin
        REsult :=TSalesOrderLine(Owner);
        Exit;
    end;
    SalesOrder.Lines.Locate('SaleLineId' , SaleslineId , []);
    result := SalesOrder.Lines;
  end;

  function DoFormat(aType, arrVar, Val: string): string;
  var Places: integer;
  begin
    result := Val;
    if Length(arrVar) > Length(aType) then begin
      Places := StrToInt(Copy(arrVar,Length(aType)+1,255));
      while Length(result) < Places do
        result := '0' + result;
    end;
  end;

  Function ArrayToValue(PQADetails: TPQADetails; ParentRef: String; Arr: TStringDynArray): string;
  var
    fi: Integer;
  begin
    Result := '';
    for fi := low(Arr) to high(Arr) do begin
      if (Pos('[SID]', Uppercase(Arr[fi]) ) = 1) then
        result := result + DoFormat('[SID]',Arr[fi],IntToStr(SaleId))
      else if (Pos('[SLID]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[SLID]',Arr[fi],IntToStr(MasterId))
      else if (Pos('[PTID]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[PTID]',Arr[fi],IntToStr(Id))
      else if (Pos('[COUNT]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[COUNT]',Arr[fi],IntToStr(PQADetails.Count+1))
      else if (Pos('[TRANSCOUNT]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[TRANSCOUNT]',Arr[fi],IntToStr(tcdatautils.TransSeqno(ID, connection.connection)))
      else if (Pos('[PARENTREF]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[PARENTREF]',Arr[fi],ParentRef)
      else if (Pos('[PRODUCTID]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[PRODUCTID]',Arr[fi],IntToStr(PartsId))
      else if (Pos('[SEQNO]', Uppercase(Arr[fi])) = 1) then
        result := result + DoFormat('[SEQNO]',Arr[fi],IntToStr(tcDataUtils.SalelineSeqno(MasterId)))

      else Result := Result +Arr[fi];
    end;
  end;

  function PQABatch(PQA:TPQA) :TPQABatch;
  begin
    result := nil;
    if PQA.Product.Batch = false then Exit;
    result := PQA.PQABatch;
  end;
  function PQABin(PQA:TPQA) :TPQABins;
  begin
    result := nil;
    if PQA.Product.MultipleBins = false then Exit;

    if PQA.Product.Batch then result := PQABatch(PQA).PQABins
    else result := PQA.PQABins;
  end;
  function PQASN(PQA:TPQA) :TPQASN;
  begin
    result := nil;
    if PQA.Product.SNTracking = False then exit;
    if PQA.Product.MultipleBins then result := PQABin(PQA).PQASN
    else if PQA.Product.Batch then result := PQABatch(PQA).PQASN
    else result := PQA.PQASN;
  end;
  function UpdateBatchQty(apqabatch:TPQABatch;aBatchQty:Double):String;
  var
    abatcho :String;
  begin
    result := '';
    if assigned(apqabatch) then begin
      abatcho := ArrayToValue(apqabatch, '', BatchnoFormat);
      if abatcho <> '' then begin
        With apqabatch do begin
          if locate('value' ,abatcho, []) then else begin
            New;
            BatchNo := abatcho;
            UOMQty :=0;
          end;
          UOMQty :=UOMQty + aBatchQty;
          Active := True;
          PostDB;
          result := Globalref;
        end;
      end;
    end;
  end;
  Procedure UpdateBatch(aPQA:TPQa;aBatchQty:Double);
  begin
        if not aPQA.Product.Batch then exit;
        fsPTPAllocParentRef := UpdateBatchQty(PQABatch(aPQA),aBatchQty);
        if Self.id = SalesOrderLine.RootprocTree.id then begin
          fsParentPTPAllocParentRef := UpdateBatchQty(PQABatch(SalesOrder.Lines.PQA),aBatchQty);
        end else if Self.ProcTreePart.IsSubNodeParent then begin // ParentProctree has to be a subnode parent when this is not root
          fsParentPTPAllocParentRef := UpdateBatchQty(PQABatch(Self.ProcTreePart.SubNodeManufcaturePQA ),aBatchQty);
        end else begin
          fsParentPTPAllocParentRef := UpdateBatchQty(PQABatch(Self.ProcTreePart.PQA),aBatchQty);
        end;
  end;
  function UpdatebinQty(aPQABins:TPQABins;aBinQty:Double; aDepartmentID :Integer; aPArenref:String):String;
  var
    aBinloc, aBinnum :String;
  begin
    result := '';
    if assigned(aPQABins)then
        With aPQABins do begin
          aBinloc:= ProcTreePart.ManufacturedProgress.Product.DefaultBinLocation(ProcTreePart.ManufacturedProgress.PQA.DepartmentID);
          aBinnum:= ProcTreePart.ManufacturedProgress.Product.DefaultBinNumber  (ProcTreePart.ManufacturedProgress.PQA.DepartmentID);
          if not Locate('binid', tcdatautils.GetBinID(abinloc, abinnum , aDepartmentID) , []) then begin
            New;
            ParentRef := aPArenref;
            Binlocation := abinloc;
            BinNumber   := abinnum;
            UOMQty      := 0;
          end;
          UOMQty      :=UOMQty +ProcTreePart.ManufacturedProgress.PQA.UOMQty;
          PostDB;
          result := Globalref;
    end;
  end;

  Procedure Updatebin(aPQA:TPQa;aBinQty:Double);
  begin
        if not aPQA.Product.MultipleBins then exit;
        fsPTPAllocParentRef := UpdatebinQty(PQABin(aPQA), aBinQty , aPqa.DepartmentID,fsPTPAllocParentRef);
        if Self.id = SalesOrderLine.RootprocTree.id then begin
          fsParentPTPAllocParentRef := UpdatebinQty(PQABin(SalesOrder.Lines.PQA),aBinQty , aPqa.DepartmentID,fsParentPTPAllocParentRef);
        end else if Self.ProcTreePart.IsSubNodeParent then begin // ParentProctree has to be a subnode parent when this is not root
          fsParentPTPAllocParentRef := UpdatebinQty(PQABin(Self.ProcTreePart.SubNodeManufcaturePQA ),aBinQty , aPqa.DepartmentID,fsParentPTPAllocParentRef);
        end else begin
          fsParentPTPAllocParentRef := UpdatebinQty(PQABin(Self.ProcTreePart.PQA),aBinQty , aPqa.DepartmentID,fsParentPTPAllocParentRef);
        end;
  end;
  Procedure updateSNQty(fsSN:String;aPQASN:TPQASN; aQty :Double; aParentRef:String);
  begin
    if assigned(aPQASN) then
      With aPQASN do begin
          New;
          ParentRef :=  aParentRef;
          fiindex := 0;
          Serialnumber := fsSN;
          UOMQty :=1;
          PostDB;
      end;

  end;
  Procedure updateSN(aPQA:TPQA; aQty :Double);
  var
    fsStr:String;
    ctr:Integer;
    aPQASN :TPQASN;
    errMsg :String;
  begin
    if not aPQA.Product.SNTracking then exit;

    aPQASN :=PQASN(aPQA);
    for ctr := 1 to trunc(aQty) do begin
        Repeat
          fsStr := ArrayToValue(aPQASN, fsPTPAllocParentRef, SNFormat);
          if fiindex <> 0 then fsSTr := fsStr +'-' + inttostr(fiindex);
          fiindex := fiindex +1;
        until (TPQASN.ValidateSN(fsStr, 0, aPQASN.ProductID,aPQASN.DEpartmentId,  TERPconnection(Connection.Connection), aPQASN.InTrans, errMsg));

        updateSNQty(fsStr,aPQASN , aQty,fsPTPAllocParentRef);
        if Self.id = SalesOrderLine.RootprocTree.id then begin
          updateSNQty(fsStr, PQASN(SalesOrder.Lines.PQA),aQty,fsParentPTPAllocParentRef);
        end else if Self.ProcTreePart.IsSubNodeParent then begin // ParentProctree has to be a subnode parent when this is not root
          updateSNQty(fsStr, PQASN(Self.ProcTreePart.SubNodeManufcaturePQA ),aQty,fsParentPTPAllocParentRef);
        end else begin
          updateSNQty(fsStr, PQASN(Self.ProcTreePart.PQA),aQty,fsParentPTPAllocParentRef);
        end;
    end;
  end;
  Function qtyleftfromstock(aProctree :TProctree):Double ;
  begin
    result := aProctree.FromStockUOMQty+
              aProctree.OnOrderUOMQty ;
    result := result - aProctree.ManufacturingUOMQty;
  end;
  Procedure AddtoPPGMsg(Const Value:String; NewLine :boolean = True);
  begin
    if NewLine then s:= s + NL+'    ';
    s:= s +Value;
  end;
begin
  fSO:=nil;
  stepProgress(Floattostrf(fdBuildQty , ffGeneral, 15,2) +' of ' +Caption);
  try
      result := False;
      if fdBuildQty >  ManufactureUOMQty -ManufacturedUOMQty then begin
        ResultStatus.Additem(True, RssInfo, 0, 'Requested Quantity to Build is ' +Floattostr(fdBuildQty) +'.'+NL+ Floattostr(ManufactureUOMQty -ManufacturedUOMQty) +' is the Quantity Left to be built. It is not Possible to Build More than the Ordered Quantity.', true);
        fdBuildQty := ManufactureUOMQty -ManufacturedUOMQty;
      end;
      if fdBuildQty =0 then begin
        ResultStatus.Additem(True, RssInfo, 0, 'This Order is Completely Built', true);
        exit;
      end;
      s:= caption +','+Floattostr(fdBuildQty);
      try
          if children.count >0 then begin
            children.first;
            AddtoPPGMsg('Sub Builds');
            AddtoPPGMsg('Caption,BuildQty,Fromstock,onorder,tobuild,BuildQty,BuildQty');
            while children.eof = false do begin
              fdQty := 0;

              AddtoPPGMsg(children.caption +',' +
                  floattostr(fdBuildQty)+',' +
                  floattostr(children.FromStockUOMQty)+',' +
                  floattostr( children.OnOrderUOMQty)+',' +
                  floattostr( children.ManufacturingUOMQty));
              if children.SubBOM_BuildFirst or (children.PartsId<=0) then
              else if children.SubBOM_UseAvailableQtyFirst then  fdQty  := ProductinstockQty(children.PartsId, connection.connection, 0 , children.TreePartUOM , SalesOrder.Saleclassid)  //children.product.InstockQty
              else fdQty := qtyleftfromstock(Children);
              AddtoPPGMsg(',' +floattostr(fdQty) , false);

              if fdQty  >= children.TreePartUOMQuantity*fdBuildQty then fdQty := 0
              else fdQty := children.TreePartUOMQuantity*fdBuildQty- fdQty;

              AddtoPPGMsg(',' +floattostr(fdQty), False);

              if (fdQty >0) and (children.ManufactureUOMQty -children.ManufacturedUOMQty >0) then begin
                stepProgress(Floattostrf(fdQty , ffGeneral, 15,2) +' of ' +children.Caption+' for '+ Caption);
                if fdQty >children.ManufactureUOMQty -children.ManufacturedUOMQty then
                  fdQty := children.ManufactureUOMQty -children.ManufacturedUOMQty;
                (*if children.ManufactureUOMQty =0 then else
                if children.ManufacturedUOMQty - children.ManufacturingUOMQty >= fdQty then else
                if children.ManufactureUOMQty -children.ManufacturedUOMQty  =0 then else*)
                if children.children.Count >0 then begin
                  children.DoBuildaQty(DoneQtytype, incSecond(dt,-1), fdQty (*(fdQty)-(children.ManufacturedUOMQty - children.ManufacturingUOMQty)*), BatchnoFormat, SNFormat, returnProcProgID,aPPGMsg); // sub boms to be built only if not available
                  AddtoPPGMsg(',' +children.LevelIntendSpaces + aPPGMsg , true);
                end;
              end;
              children.next;
            end;
            {IN}
            ProcTreePart.ManufacturedProgress.new;
            ProcTreePart.ManufacturedProgress.EmployeeId := Appenv.Employee.EmployeeID;
            ProcTreePart.ManufacturedProgress.InProcProgressId := 0;
            ProcTreePart.ManufacturedProgress.Progressdate := dt;
            ProcTreePart.ManufacturedProgress.Alloctype := 'IN';

            ProcTreePart.ManufacturedProgress.UOMQty := divzer((fdBuildQty(**Quantity*)), TreePartUOMMultiplier); // do not use TreePartUOMQuantity as for the root note TreePartUOMQuantity is totaluomqty from Sales lines
            ProcTreePart.ManufacturedProgress.BuildStatus := DoneQtytypeToStr(DoneQtytype);
            ProcTreePart.ManufacturedProgress.PostDB;
            AddtoPPGMsg('IN:' +ProcTreePart.ManufacturedProgress.Productname + ',' + Floattostr(ProcTreePart.ManufacturedProgress.UOMQty)+','+Floattostr(ProcTreePart.ManufacturedProgress.ProductUnitCost),true);
            returnProcProgID :=ProcTreePart.ManufacturedProgress.ID;
            fsPTPAllocParentRef := '';
            fsParentPTPAllocParentRef := '';

            if ProcTreePart.ManufacturedProgress.Product.Batch then begin
              if length(BatchnoFormat)<> 0 then begin
                  UpdateBatch(ProcTreePart.ManufacturedProgress.PQA, ProcTreePart.ManufacturedProgress.PQA.UOMQty);
              end;
            end;

            if ProcTreePart.ManufacturedProgress.Product.MultipleBins then begin
              Updatebin(ProcTreePart.ManufacturedProgress.PQA , ProcTreePart.ManufacturedProgress.PQA.UOMQty);
            end;

            if ProcTreePart.ManufacturedProgress.Product.SNTracking then begin
              updateSN(ProcTreePart.ManufacturedProgress.PQA, ProcTreePart.ManufacturedProgress.PQA.UOMQty);
            end;

            ProcTreePart.ManufacturedUOMQty := ProcTreePart.ManufacturedUOMQty + ProcTreePart.ManufacturedProgress.UOMQty;
            ProcTreePart.PostDB;
            ManufacturedUOMQty := ManufacturedUOMQty + ProcTreePart.ManufacturedProgress.UOMQty;
            PostDB;
            AddtoPPGMsg(Floattostr(ProcTreePart.ManufacturedUOMQty)+','+Floattostr(ManufacturedUOMQty), false);



            children.first;
            fdCostCalc:=0;
            AddtoPPGMsg('Using children');
            while children.eof = false do begin
              {OUT}
              children.ProcTreePart.ManufacturingProgress.new;
              children.ProcTreePart.ManufacturingProgress.EmployeeId := Appenv.Employee.EmployeeID;
              children.ProcTreePart.ManufacturingProgress.InProcProgressId := ProcTreePart.ManufacturedProgress.ID;
              children.ProcTreePart.ManufacturingProgress.Progressdate := dt;
              children.ProcTreePart.ManufacturingProgress.Alloctype := 'OUT';

              children.ProcTreePart.ManufacturingProgress.UOMQty := children.TreePartUOMQuantity*fdBuildQty ;
              children.ProcTreePart.ManufacturingProgress.BuildStatus := DoneQtytypeToStr(DoneQtytype);
              children.ProcTreePart.ManufacturingProgress.PostDB;

              children.ProcTreePart.ManufacturingUOMQty := children.ProcTreePart.ManufacturingUOMQty +
                                                           children.ProcTreePart.ManufacturingProgress.UOMQty;
              children.ProcTreePart.PostDB;

              children.ManufacturingUOMQty := children.ManufacturingUOMQty +
                                              children.ProcTreePart.ManufacturingProgress.UOMQty;
              children.PostDB;

              fdCostCalc := fdCostCalc +children.ProcTreePart.ManufacturingProgress.ProductunitCost* children.ProcTreePart.ManufacturingProgress.Qty;
              if children.ProcTreePart.ispqaitem then children.ProcTreePart.MoveAllocation(children.TreePartUOMQuantity*fdBuildQty ,
                                                                                           children.ProcTreePart.ManufacturingProgress.PQA);
              AddtoPPGMsg(children.LevelIntendSpaces + children.caption +',' +
                          floattostr(children.ProcTreePart.ManufacturingProgress.uomQty)+',' +
                          floattostr(children.ProcTreePart.ManufacturingUOMQty)+',' +
                          floattostr(children.ManufacturingUOMQty));
              children.Next;
            end;
            ProcTreePart.ManufacturedProgress.ProductUnitCost := DivZer(fdCostCalc ,ProcTreePart.ManufacturedProgress.Qty);
            ProcTreePart.ManufacturedProgress.PostDB;
          end;
      finally
        PPGMsg := PPGMsg + s;
      end;
      Result := True;
  finally
    FreeandNil(fSO);
  end;
end;

procedure Tproctree.CompleteallProcprogress;
begin
  if not TreeHasProgressbuild then exit;
  if ProcTreePart.count >0 then ProcTreePart.CompleteallProcprogress;
  if children.count >0 then
    children.first;
    while children.eof = false do begin
      Children.CompleteallProcprogress;
      children.Next;
    end;
end;

function Tproctree.TreehasProgressbuild: Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    commondblib.closedb(qry);
    qry.sql.text := 'SELECT count(PPG.ProcProgressID) as ctr  FROM tblprocprogress PPG inner join tblproctree PT on PPG.ProcTreeId = PT.ProcTreeId and PT.TreeRootId =  '+ IntToStr(Self.treerootId);
    commondblib.opendb(qry);
    result := Qry.fieldbyname('ctr').asInteger >0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
constructor Tproctree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'proctree';
  fSQL := 'SELECT * FROM tblproctree';
end;


destructor Tproctree.Destroy;
begin
  inherited;
end;


procedure Tproctree.LoadFromXMLNode(const node: IXMLNode);
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
  SetPropertyFromNode(node,'ManufacturedUOMQty');
  SetPropertyFromNode(node,'ManufacturingUOMQty');
  SetPropertyFromNode(node,'OnOrderUOMQty');
  SetPropertyFromNode(node,'FromStockQty');
  SetPropertyFromNode(node,'ManufactureQty');
  SetPropertyFromNode(node,'ManufacturedQty');
  SetPropertyFromNode(node,'ManufacturingQty');
  SetPropertyFromNode(node,'OnOrderQty');
  SetPropertyFromNode(node,'QtyPlanned');
  SetPropertyFromNode(node,'TotalQtyPlanned');
  SetPropertyFromNode(node,'FormulaID');
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
  SetBooleanPropertyFromNode(node,'ZeroWhenLessthan1');
  SetBooleanPropertyFromNode(node,'RoundtoNextNumber');
  SetBooleanPropertyFromNode(node,'RoundtoPrevNumber');
  SetPropertyFromNode(node,'SubBOMProcessOrder');
end;

procedure Tproctree.SaveToXMLNode(Const node: IXMLNode);
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
  AddXMLNode(node,'ManufacturedUOMQty' ,ManufacturedUOMQty);
  AddXMLNode(node,'ManufacturingUOMQty' ,ManufacturingUOMQty);
  AddXMLNode(node,'OnOrderUOMQty' ,OnOrderUOMQty);
  AddXMLNode(node,'FromStockQty' ,FromStockQty);
  AddXMLNode(node,'ManufactureQty' ,ManufactureQty);
  AddXMLNode(node,'ManufacturedQty' ,ManufacturedQty);
  AddXMLNode(node,'ManufacturingQty' ,ManufacturingQty);
  AddXMLNode(node,'OnOrderQty' ,OnOrderQty);
  AddXMLNode(node,'QtyPlanned' ,QtyPlanned);
  AddXMLNode(node,'TotalQtyPlanned' ,TotalQtyPlanned);
  AddXMLNode(node,'FormulaID' ,FormulaID);
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
  AddXMLNode(node,'ZeroWhenLessthan1' ,ZeroWhenLessthan1);
  AddXMLNode(node,'RoundtoNextNumber' ,RoundtoNextNumber);
  AddXMLNode(node,'RoundtoPrevNumber' ,RoundtoPrevNumber);
  AddXMLNode(node,'SubBOMProcessOrder' ,SubBOMProcessOrder);
end;


function Tproctree.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Tproctree.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tproctree.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tproctree.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'PartsID')  then begin
    InitUOM(PartsID);
  end else  if Sysutils.SameText(Sender.FieldName, 'ManufacturedUOMQty')  then begin    ManufacturedQty     := ManufacturedUOMQty   * TreePartUOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturedQty')     then begin    ManufacturedUOMQty  := ManufacturedQty      / TreePartUOMMultiplier;

  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturingUOMQty') then begin    ManufacturingQty    := ManufacturingUOMQty  * TreePartUOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturingQty')    then begin    ManufacturingUOMQty := ManufacturingQty     / TreePartUOMMultiplier;

  end  else if Sysutils.SameText(Sender.FieldName, 'ManufactureUOMQty')   then begin    ManufactureQty      := ManufactureUOMQty    * TreePartUOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufactureQty')      then begin    ManufactureUOMQty   := ManufactureQty       / TreePartUOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'TreEPartUOM')         then begin
    if (PartsId <> 0) and (self.TreePartUOMID <> -1) then begin
        Product.UOMList.Closedb;
        Product.UOMList.OpenDb;
        if Product.ProductUOMLocate(TreEPartUOM)  then begin
          Self.TreEPartUOMMultiplier := Product.UOMList.Multiplier;
          Self.TreePartUOMID := Product.UOMList.ID;
          Self.TreePartUOM := Product.UOMList.UOMName;
        end;
        PostDB;
      end;
  end;
end;


function Tproctree.FindTreeItem(aParentId: Integer; aCaption: String;aPartsId: Integer; aQty: Double): TProctree;
begin
  REsult := nil;
  First;
  While Eof = False do begin
    if (PartsId = aPartsId) and Sametext(caption , aCaption) and (ParentId = aParentId) then begin
      REsult := Self;
      Exit;
    end;
    if Children.count > 0 then begin
      Children.first;
      result := Children.FindTreeItem(aParentId,aCaption,aPartsId,aQty);
      if assigned(result) then exit;
    end;
    Next;
  end;
end;

function Tproctree.geParentItem: Tproctree;
begin
  Result := Tproctree(Getcontainercomponent(Tproctree, 'ProctreeID = ' + IntToStr(ParentID), True, True));
end;

function Tproctree.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tproctree.GetIDField: string;
begin
  Result := 'ProcTreeId'
end;


class function Tproctree.GetBusObjectTablename: string;
begin
  Result:= 'tblproctree';
end;


function Tproctree.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tproctree.GetTreeRootId           : Integer   ; begin Result := GetIntegerField('TreeRootId');end;
function  Tproctree.GetParentId             : Integer   ; begin Result := GetIntegerField('ParentId');end;
function  Tproctree.GetMasterId             : Integer   ; begin Result := GetIntegerField('MasterId');end;
function  Tproctree.GetMasterType           : string    ; begin Result := GetStringField('MasterType');end;
function  Tproctree.GetSequenceDown         : Integer   ; begin Result := GetIntegerField('SequenceDown');end;
function  Tproctree.GetSequenceUp           : Integer   ; begin Result := GetIntegerField('SequenceUp');end;
function  Tproctree.GetEditVersion          : Integer   ; begin Result := GetIntegerField('EditVersion');end;
function  Tproctree.GetCaption              : string    ; begin Result := GetStringField('Caption');end;
function  Tproctree.GetDescription          : string    ; begin Result := GetStringField('Description');end;
function  Tproctree.GetDetails              : string    ; begin Result := GetStringField('Details');end;
function  Tproctree.GetPartsId              : Integer   ; begin Result := GetIntegerField('PartsId');end;
function  Tproctree.GetSaleLineId           : Integer   ; begin Result := GetIntegerField('SaleLineId');end;
function  Tproctree.GetPurchaseLineId       : Integer   ; begin Result := GetIntegerField('PurchaseLineId');end;
function  Tproctree.GetIsTemplate           : Boolean   ; begin Result := GetBooleanField('IsTemplate');end;
function  Tproctree.GetQuantity             : Double    ; begin Result := GetFloatField('Quantity');end;
function  Tproctree.GetTotalQty             : Double    ; begin Result := GetFloatField('TotalQty');end;
function  Tproctree.GetTotalQtyOriginal     : Double    ; begin Result := GetFloatField('TotalQtyOriginal');end;
function  Tproctree.GetQtyOriginal          : Double    ; begin Result := GetFloatField('QtyOriginal');end;
function  Tproctree.GetQtyVariation         : Double    ; begin Result := GetFloatField('QtyVariation');end;
function  Tproctree.GetHideOnPrint          : Boolean   ; begin Result := GetBooleanField('HideOnPrint');end;
function  Tproctree.GetAddToSale            : Boolean   ; begin Result := GetBooleanField('AddToSale');end;
function  Tproctree.GetLinkedLineId         : Integer   ; begin Result := GetIntegerField('LinkedLineId');end;
function  Tproctree.GetPartSource           : string    ; begin Result := GetStringField('PartSource');end;
function  Tproctree.GetInputType            : string    ; begin Result := GetStringField('InputType');end;
function  Tproctree.GetCustomInputClass     : string    ; begin Result := GetStringField('CustomInputClass');end;
function  Tproctree.GetPrice                : Double    ; begin Result := GetFloatField('Price');end;
function  Tproctree.GetTreePricechanged     : Boolean   ; begin Result := GetBooleanField('TreePricechanged');end;
function  Tproctree.GetCost                 : Double    ; begin Result := GetFloatField('Cost');end;
function  Tproctree.GetProcStepItemRef      : string    ; begin Result := GetStringField('ProcStepItemRef');end;
function  Tproctree.GetSelected             : Boolean   ; begin Result := GetBooleanField('Selected');end;
function  Tproctree.GetValue                : string    ; begin Result := GetStringField('Value');end;
function  Tproctree.GetComplete             : Boolean   ; begin Result := GetBooleanField('Complete');end;
function  Tproctree.GetLevel                : Integer   ; begin Result := GetIntegerField('Level');end;
function  Tproctree.GetInfo                 : string    ; begin Result := GetStringField('Info');end;
function  Tproctree.GetQtyPer               : Double    ; begin Result := GetFloatField('QtyPer');end;
function  Tproctree.GetTreePartUOM          : string    ; begin Result := GetStringField('TreePartUOM');end;
function  Tproctree.GetTreePartUOMID        : Integer   ; begin Result := GetIntegerField('TreePartUOMID');end;
function  Tproctree.GetTreePartUOMMultiplier: Double    ; begin Result := GetFloatField('TreePartUOMMultiplier');end;
function  Tproctree.GetTreePartUOMQuantity  : Double    ; begin Result := GetFloatField('TreePartUOMQuantity');end;
function  Tproctree.GetTreePartUOMTotalQty  : Double    ; begin Result := GetFloatField('TreePartUOMTotalQty');end;
function  Tproctree.GetMatrixDesc           : string    ; begin Result := GetStringField('MatrixDesc');end;
function  Tproctree.GetMatrixRef            : string    ; begin Result := GetStringField('MatrixRef');end;
function  Tproctree.GetMatrixPrice          : Double    ; begin Result := GetFloatField('MatrixPrice');end;
function  Tproctree.GetFromStockUOMQty      : Double    ; begin Result := GetFloatField('FromStockUOMQty');end;
function  Tproctree.GetManufactureUOMQty    : Double    ; begin Result := GetFloatField('ManufactureUOMQty');end;
function  Tproctree.GetManufacturedUOMQty   : Double    ; begin Result := GetFloatField('ManufacturedUOMQty');end;
function  Tproctree.GetManufacturingUOMQty  : Double    ; begin Result := GetFloatField('ManufacturingUOMQty');end;
function  Tproctree.GetOnOrderUOMQty        : Double    ; begin Result := GetFloatField('OnOrderUOMQty');end;
function  Tproctree.GetFromStockQty         : Double    ; begin Result := GetFloatField('FromStockQty');end;
function  Tproctree.GetManufactureQty       : Double    ; begin Result := GetFloatField('ManufactureQty');end;
function  Tproctree.GetManufacturedQty      : Double    ; begin Result := GetFloatField('ManufacturedQty');end;
function  Tproctree.GetManufacturingQty     : Double    ; begin Result := GetFloatField('ManufacturingQty');end;
function  Tproctree.GetOnOrderQty           : Double    ; begin Result := GetFloatField('OnOrderQty');end;
function  Tproctree.GetQtyPlanned           : Double    ; begin Result := GetFloatField('QtyPlanned');end;
function  Tproctree.GetTotalQtyPlanned      : Double    ; begin Result := GetFloatField('TotalQtyPlanned');end;
function  Tproctree.GetFormulaID            : Integer   ; begin Result := GetIntegerField('FormulaID');end;
function  Tproctree.GetFormulaQtyValue1     : Double    ; begin Result := GetFloatField('FormulaQtyValue1');end;
function  Tproctree.GetFormulaQtyValue2     : Double    ; begin Result := GetFloatField('FormulaQtyValue2');end;
function  Tproctree.GetFormulaQtyValue3     : Double    ; begin Result := GetFloatField('FormulaQtyValue3');end;
function  Tproctree.GetFormulaQtyValue4     : Double    ; begin Result := GetFloatField('FormulaQtyValue4');end;
function  Tproctree.GetFormulaQtyValue5     : Double    ; begin Result := GetFloatField('FormulaQtyValue5');end;
function  Tproctree.GetFormulaQtyValue      : Double    ; begin Result := GetFloatField('FormulaQtyValue');end;
function  Tproctree.GetBuildFormulaQtyValue1: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue1');end;
function  Tproctree.GetBuildFormulaQtyValue2: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue2');end;
function  Tproctree.GetBuildFormulaQtyValue3: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue3');end;
function  Tproctree.GetBuildFormulaQtyValue4: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue4');end;
function  Tproctree.GetBuildFormulaQtyValue5: Double    ; begin Result := GetFloatField('BuildFormulaQtyValue5');end;
function  Tproctree.GetBuildFormulaQtyValue : Double    ; begin Result := GetFloatField('BuildFormulaQtyValue');end;
function  Tproctree.GetOrderFormulaQtyValue1: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue1');end;
function  Tproctree.GetOrderFormulaQtyValue2: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue2');end;
function  Tproctree.GetOrderFormulaQtyValue3: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue3');end;
function  Tproctree.GetOrderFormulaQtyValue4: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue4');end;
function  Tproctree.GetOrderFormulaQtyValue5: Double    ; begin Result := GetFloatField('OrderFormulaQtyValue5');end;
function  Tproctree.GetOrderFormulaQtyValue : Double    ; begin Result := GetFloatField('OrderFormulaQtyValue');end;
function  Tproctree.GetProductUnitPrice     : Double    ; begin Result := GetFloatField('ProductUnitPrice');end;
function  Tproctree.GetProductUnitCost      : Double    ; begin Result := GetFloatField('ProductUnitCost');end;
function  Tproctree.GetBOMGroupedLine       : Boolean   ; begin Result := GetBooleanField('BOMGroupedLine');end;
function  Tproctree.GetBOMProductionLine    : Boolean   ; begin Result := GetBooleanField('BOMProductionLine');end;
function  Tproctree.GetMakeCoupons          : Boolean   ; begin Result := GetBooleanField('MakeCoupons');end;
function  Tproctree.GetCouponLabelPrinted   : Boolean   ; begin Result := GetBooleanField('CouponLabelPrinted');end;
function  Tproctree.GetQtyPerCoupon         : Double    ; begin Result := GetFloatField('QtyPerCoupon');end;
function  Tproctree.GetRAtePercoupon        : Double    ; begin Result := GetFloatField('RAtePercoupon');end;
function  Tproctree.GetCouponsPerBundle     : Double    ; begin Result := GetFloatField('CouponsPerBundle');end;
function  Tproctree.GetBundleQty            : Double    ; begin Result := GetFloatField('BundleQty');end;
function Tproctree.getSNTracking            : Boolean   ; begin Result := Product.SNTracking   ;end;
function Tproctree.getBatch                 : Boolean   ; begin Result := Product.batch        ;end;
function Tproctree.getMultipleBins          : Boolean   ; begin Result := Product.MultipleBins ;end;
function  Tproctree.GetZeroWhenLessthan1    : Boolean   ; begin Result := GetBooleanField('ZeroWhenLessthan1');end;
function  Tproctree.GetRoundtoNextNumber    : Boolean   ; begin Result := GetBooleanField('RoundtoNextNumber');end;
function  Tproctree.GetRoundtoPrevNumber    : Boolean   ; begin Result := GetBooleanField('RoundtoPrevNumber');end;
function  TProcTree.getSaleSID              : Integer   ; begin Result := SaleIDofTree(ID);end;
function  TProcTree.getSalesLineID          : Integer   ; begin Result := MasterID;end;
function  Tproctree.GetSubBOMProcessOrder   : string    ; begin Result := GetStringField('SubBOMProcessOrder');end;
function TProcTree.getSubBOM_BuildFirst          : Boolean;begin Result := sametext(SubBOMProcessOrder , 'BS'); end;
function TProcTree.getSubBOM_UseAvailableQtyFirst: Boolean;begin Result := sametext(SubBOMProcessOrder , 'ASB');end;
function TProcTree.getSubBOM_UseFromStockQtyFirst: Boolean;begin Result := sametext(SubBOMProcessOrder , 'SB');end;
function TProcTree.getLevelIntendSpaces: String;begin result := replicateStr('      ' , LEvel); end;
procedure Tproctree.SetTreeRootId           (const Value: Integer   ); begin SetIntegerField('TreeRootId'            , Value);end;
procedure Tproctree.SetParentId             (const Value: Integer   ); begin SetIntegerField('ParentId'              , Value);end;
procedure Tproctree.SetMasterId             (const Value: Integer   ); begin SetIntegerField('MasterId'              , Value);end;
procedure Tproctree.SetMasterType           (const Value: string    ); begin SetStringField('MasterType'            , Value);end;
procedure Tproctree.SetSequenceDown         (const Value: Integer   ); begin SetIntegerField('SequenceDown'          , Value);end;
procedure Tproctree.SetSequenceUp           (const Value: Integer   ); begin SetIntegerField('SequenceUp'            , Value);end;
procedure Tproctree.SetEditVersion          (const Value: Integer   ); begin SetIntegerField('EditVersion'           , Value);end;
procedure Tproctree.SetCaption              (const Value: string    ); begin SetStringField('Caption'               , Value);end;
procedure Tproctree.SetDescription          (const Value: string    ); begin SetStringField('Description'           , Value);end;
procedure Tproctree.SetDetails              (const Value: string    ); begin SetStringField('Details'               , Value);end;
procedure Tproctree.SetPartsId              (const Value: Integer   ); begin SetIntegerField('PartsId'               , Value);end;
procedure Tproctree.SetSaleLineId           (const Value: Integer   ); begin SetIntegerField('SaleLineId'            , Value);end;
procedure Tproctree.SetPurchaseLineId       (const Value: Integer   ); begin SetIntegerField('PurchaseLineId'        , Value);end;
procedure Tproctree.SetIsTemplate           (const Value: Boolean   ); begin SetBooleanField('IsTemplate'            , Value);end;
procedure Tproctree.SetQuantity             (const Value: Double    ); begin SetFloatField('Quantity'              , Value);end;
procedure Tproctree.SetTotalQty             (const Value: Double    ); begin SetFloatField('TotalQty'              , Value);end;
procedure Tproctree.SetTotalQtyOriginal     (const Value: Double    ); begin SetFloatField('TotalQtyOriginal'      , Value);end;
procedure Tproctree.SetQtyOriginal          (const Value: Double    ); begin SetFloatField('QtyOriginal'           , Value);end;
procedure Tproctree.SetQtyVariation         (const Value: Double    ); begin SetFloatField('QtyVariation'          , Value);end;
procedure Tproctree.SetHideOnPrint          (const Value: Boolean   ); begin SetBooleanField('HideOnPrint'           , Value);end;
procedure Tproctree.SetAddToSale            (const Value: Boolean   ); begin SetBooleanField('AddToSale'             , Value);end;
procedure Tproctree.SetLinkedLineId         (const Value: Integer   ); begin SetIntegerField('LinkedLineId'          , Value);end;
procedure Tproctree.SetPartSource           (const Value: string    ); begin SetStringField('PartSource'            , Value);end;
procedure Tproctree.SetInputType            (const Value: string    ); begin SetStringField('InputType'             , Value);end;
procedure Tproctree.SetCustomInputClass     (const Value: string    ); begin SetStringField('CustomInputClass'      , Value);end;
procedure Tproctree.SetPrice                (const Value: Double    ); begin SetFloatField('Price'                 , Value);end;
procedure Tproctree.SetTreePricechanged     (const Value: Boolean   ); begin SetBooleanField('TreePricechanged'      , Value);end;
procedure Tproctree.SetCost                 (const Value: Double    ); begin SetFloatField('Cost'                  , Value);end;
procedure Tproctree.SetProcStepItemRef      (const Value: string    ); begin SetStringField('ProcStepItemRef'       , Value);end;
procedure Tproctree.SetSelected             (const Value: Boolean   ); begin SetBooleanField('Selected'              , Value);end;
procedure Tproctree.SetValue                (const Value: string    ); begin SetStringField('Value'                 , Value);end;
procedure Tproctree.SetComplete             (const Value: Boolean   ); begin SetBooleanField('Complete'              , Value);end;
procedure Tproctree.SetLevel                (const Value: Integer   ); begin SetIntegerField('Level'                 , Value);end;
procedure Tproctree.SetInfo                 (const Value: string    ); begin SetStringField('Info'                  , Value);end;
procedure Tproctree.SetQtyPer               (const Value: Double    ); begin SetFloatField('QtyPer'                , Value);end;
procedure Tproctree.SetTreePartUOM          (const Value: string    ); begin SetStringField('TreePartUOM'           , Value);end;
procedure Tproctree.SetTreePartUOMID        (const Value: Integer   ); begin SetIntegerField('TreePartUOMID'         , Value);end;
procedure Tproctree.SetTreePartUOMMultiplier(const Value: Double    ); begin SetFloatField('TreePartUOMMultiplier' , Value);end;
procedure Tproctree.SetTreePartUOMQuantity  (const Value: Double    ); begin SetFloatField('TreePartUOMQuantity'   , Value);end;
procedure Tproctree.SetTreePartUOMTotalQty  (const Value: Double    ); begin SetFloatField('TreePartUOMTotalQty'   , Value);end;
procedure Tproctree.SetMatrixDesc           (const Value: string    ); begin SetStringField('MatrixDesc'            , Value);end;
procedure Tproctree.SetMatrixRef            (const Value: string    ); begin SetStringField('MatrixRef'             , Value);end;
procedure Tproctree.SetMatrixPrice          (const Value: Double    ); begin SetFloatField('MatrixPrice'           , Value);end;
procedure Tproctree.SetFromStockUOMQty      (const Value: Double    ); begin SetFloatField('FromStockUOMQty'       , Value);end;
procedure Tproctree.SetManufactureUOMQty    (const Value: Double    ); begin SetFloatField('ManufactureUOMQty'     , Value);end;
procedure Tproctree.SetManufacturedUOMQty   (const Value: Double    ); begin SetFloatField('ManufacturedUOMQty'    , Value);end;
procedure Tproctree.SetManufacturingUOMQty  (const Value: Double    ); begin SetFloatField('ManufacturingUOMQty'    , Value);end;
procedure Tproctree.SetOnOrderUOMQty        (const Value: Double    ); begin SetFloatField('OnOrderUOMQty'         , Value);end;
procedure Tproctree.SetFromStockQty         (const Value: Double    ); begin SetFloatField('FromStockQty'          , Value);end;
procedure Tproctree.SetManufactureQty       (const Value: Double    ); begin SetFloatField('ManufactureQty'        , Value);end;
procedure Tproctree.SetManufacturedQty      (const Value: Double    ); begin SetFloatField('ManufacturedQty'       , Value);end;
procedure Tproctree.SetManufacturingQty     (const Value: Double    ); begin SetFloatField('ManufacturingQty'      , Value);end;
procedure Tproctree.SetOnOrderQty           (const Value: Double    ); begin SetFloatField('OnOrderQty'            , Value);end;
procedure Tproctree.SetQtyPlanned           (const Value: Double    ); begin SetFloatField('QtyPlanned'            , Value);end;
procedure Tproctree.SetTotalQtyPlanned      (const Value: Double    ); begin SetFloatField('TotalQtyPlanned'       , Value);end;
procedure Tproctree.SetFormulaID            (const Value: Integer   ); begin SetIntegerField('FormulaID'             , Value);end;
procedure Tproctree.SetFormulaQtyValue1     (const Value: Double    ); begin SetFloatField('FormulaQtyValue1'      , Value);end;
procedure Tproctree.SetFormulaQtyValue2     (const Value: Double    ); begin SetFloatField('FormulaQtyValue2'      , Value);end;
procedure Tproctree.SetFormulaQtyValue3     (const Value: Double    ); begin SetFloatField('FormulaQtyValue3'      , Value);end;
procedure Tproctree.SetFormulaQtyValue4     (const Value: Double    ); begin SetFloatField('FormulaQtyValue4'      , Value);end;
procedure Tproctree.SetFormulaQtyValue5     (const Value: Double    ); begin SetFloatField('FormulaQtyValue5'      , Value);end;
procedure Tproctree.SetFormulaQtyValue      (const Value: Double    ); begin SetFloatField('FormulaQtyValue'       , Value);end;
procedure Tproctree.SetBuildFormulaQtyValue1(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue1' , Value);end;
procedure Tproctree.SetBuildFormulaQtyValue2(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue2' , Value);end;
procedure Tproctree.SetBuildFormulaQtyValue3(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue3' , Value);end;
procedure Tproctree.SetBuildFormulaQtyValue4(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue4' , Value);end;
procedure Tproctree.SetBuildFormulaQtyValue5(const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue5' , Value);end;
procedure Tproctree.SetBuildFormulaQtyValue (const Value: Double    ); begin SetFloatField('BuildFormulaQtyValue' , Value);end;
procedure Tproctree.SetOrderFormulaQtyValue1(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue1' , Value);end;
procedure Tproctree.SetOrderFormulaQtyValue2(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue2' , Value);end;
procedure Tproctree.SetOrderFormulaQtyValue3(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue3' , Value);end;
procedure Tproctree.SetOrderFormulaQtyValue4(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue4' , Value);end;
procedure Tproctree.SetOrderFormulaQtyValue5(const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue5' , Value);end;
procedure Tproctree.SetOrderFormulaQtyValue (const Value: Double    ); begin SetFloatField('OrderFormulaQtyValue' , Value);end;
procedure Tproctree.SetProductUnitPrice     (const Value: Double    ); begin SetFloatField('ProductUnitPrice'      , Value);end;
procedure Tproctree.SetProductUnitCost      (const Value: Double    ); begin SetFloatField('ProductUnitCost'       , Value);end;
procedure Tproctree.SetBOMGroupedLine       (const Value: Boolean   ); begin SetBooleanField('BOMGroupedLine'        , Value);end;
procedure Tproctree.SetBOMProductionLine    (const Value: Boolean   ); begin SetBooleanField('BOMProductionLine'     , Value);end;
procedure Tproctree.SetMakeCoupons          (const Value: Boolean   ); begin SetBooleanField('MakeCoupons'           , Value);end;
procedure Tproctree.SetCouponLabelPrinted   (const Value: Boolean   ); begin SetBooleanField('CouponLabelPrinted'    , Value);end;
procedure Tproctree.SetQtyPerCoupon         (const Value: Double    ); begin SetFloatField('QtyPerCoupon'          , Value);end;
procedure Tproctree.SetRAtePercoupon        (const Value: Double    ); begin SetFloatField('RAtePercoupon'         , Value);end;
procedure Tproctree.SetCouponsPerBundle     (const Value: Double    ); begin SetFloatField('CouponsPerBundle'      , Value);end;
procedure Tproctree.SetBundleQty            (const Value: Double    ); begin SetFloatField('BundleQty'             , Value);end;
procedure Tproctree.SetZeroWhenLessthan1    (const Value: Boolean   ); begin SetBooleanField('ZeroWhenLessthan1'   , Value);end;
procedure Tproctree.SetRoundtoNextNumber    (const Value: Boolean   ); begin SetBooleanField('RoundtoNextNumber'   , Value);end;
procedure Tproctree.SetRoundtoPrevNumber    (const Value: Boolean   ); begin SetBooleanField('RoundtoPrevNumber'   , Value);end;
procedure Tproctree.SetSubBOMProcessOrder   (const Value: string    ); begin SetStringField('SubBOMProcessOrder'             , Value);end;
function Tproctree.getConvertCurrent: Boolean;
begin
  result := False;
  if Assigned(Owner) and (Owner is TSalesOrderLine) then
      REsult := TSalesOrderLine(owner).ConvertCurrent;
end;
function Tproctree.getProcessPart: TProcessPart;
begin
  Result := TProcessPart(Getcontainercomponent(TProcessPart, 'ProctreeID = ' + IntToStr(ID), True, True));
end;
function Tproctree.getSaleID: Integer;
begin
  result := 0;
  if mastertype <> 'mtProduct' then
    Result :=GetSaleIdForSaleLineId(MasterID);
end;

function Tproctree.getProcTreePart: TProcTreePart;
begin
  Result := TProcTreePart(Getcontainercomponent(TProcTreePart, 'ProctreeId = ' + IntToStr(ID), True, True));
end;

function Tproctree.getProduct: TProduct;
begin
  Result := TProduct(Getcontainercomponent(TProduct, 'PartsID = ' + IntToStr(PartsId), True, True));
end;

function Tproctree.getWastageQty: Double;
var
  Qry :TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.Connection.Connection);
  try
    Qry.SQL.text := 'SELECT Sum(uomqty) uomqty FROM  tblprocprogress WHERE ProcTreePartID = ' +inttostr(ProcTreePart.Id) +'   and  buildstatus =''W''';
    Qry.open;
    result := Qry.fieldbyname('uomqty').AsFloat;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function Tproctree.IsAnychildrenBatchTracking: Boolean;
begin
  REsult := False;
  if children.Count =0 then exit;

  fbAllLinesValid := False;
  Children.iterateRecords(BatchTrackingCheckCallback);
  result := fbAllLinesValid;
end;
Procedure Tproctree.BatchTrackingCheckCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TProctree) then exit;
  if TProctree(Sender).ProcTreePart.count = 0 then exit;
  if TProctree(Sender).ProcTreePart.Product.batch then begin
     fbAllLinesValid := True;
     abort:= true;
     Exit;
  end;
end;

function Tproctree.IsAnychildrenSNTracking: Boolean;
begin
  fbAllLinesValid := False;
  REsult := False;
  if children.Count =0 then exit;
  Children.iterateRecords(SNTrackingCheckCallback);
  result := fbAllLinesValid;

end;
Procedure Tproctree.SNTrackingCheckCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TProctree) then exit;
  if TProctree(Sender).ProcTreePart.count = 0 then exit;
  if TProctree(Sender).ProcTreePart.Product.SNTracking then begin
     fbAllLinesValid := True;
     abort:= true;
     Exit;
  end;

end;

Procedure Tproctree.InitUOM(const fiProductID:Integer);
var
  Product :TProduct;
begin
  if fiProductID<>0 then begin
    Product := TProduct.CreateWithNewConn(nil);
    try
      Product.Load(fiProductID);
      Product.UOMList.Closedb;
      Product.UOMList.OpenDb;

      if Product.ProductUOMLocate(Product.UOMSales)  then begin
        TreePartUOMMultiplier := Product.UOMList.Multiplier;
        TreePartUOMID := Product.UOMList.ID;
        TreePartUOM := Product.UOMList.UOMName;
      end else begin
        TreePartUOMMultiplier := 1;
        TreePartUOMID  := 0;
      end;
    finally
      Freeandnil(Product);
    end;
  end;
end;
function Tproctree.GetTreeChildren: TProctree;
begin
  Result := TProctree(Getcontainercomponent(TProctree, 'ParentId = ' + IntToStr(ID), True, True));
end;

Function Tproctree.newChild(var aParentId: Integer):Tproctree;
begin
  REsult := nil;
  First;
  While Eof = False do begin
    if Id = aParentId then begin
      Children.New;
      Children.masterId := PartsId;
      Children.PArentId := ID;
      Children.TreeRootId := TreeRootId;
      REsult := Children;
      Exit;
    end;
    if Children.count > 0 then begin
      Children.first;
      result := Children.newChild(aParentId);
      if assigned(result) then exit;
    end;
    Next;
  end;

end;

initialization
  RegisterClass(Tproctree);
  RegisterClass(TproctreeRoot);

end.
