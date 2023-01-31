unit BusobjStowAway;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  08/05/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusObjStock , BusobjProctree;


type
  (*Tproctree = class(TMSBusObj)
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
    function GetHideOnPrint              : Boolean   ;
    function GetAddToSale                : Boolean   ;
    function GetTreePricechanged         : Boolean   ;
    function GetLinkedLineId             : Integer   ;
    function GetPartSource               : string    ;
    function GetInputType                : string    ;
    function GetCustomInputClass         : string    ;
    function GetPrice                    : Double    ;
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
    procedure SetHideOnPrint              (const Value: Boolean   );
    procedure SetAddToSale                (const Value: Boolean   );
    procedure SetTreePricechanged         (const Value: Boolean   );
    procedure SetLinkedLineId             (const Value: Integer   );
    procedure SetPartSource               (const Value: string    );
    procedure SetInputType                (const Value: string    );
    procedure SetCustomInputClass         (const Value: string    );
    procedure SetPrice                    (const Value: Double    );
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
    property HideOnPrint               :Boolean     read GetHideOnPrint             write SetHideOnPrint          ;
    property AddToSale                 :Boolean     read GetAddToSale               write SetAddToSale            ;
    property TreePricechanged          :Boolean     read GetTreePricechanged        write SetTreePricechanged     ;
    property LinkedLineId              :Integer     read GetLinkedLineId            write SetLinkedLineId         ;
    property PartSource                :string      read GetPartSource              write SetPartSource           ;
    property InputType                 :string      read GetInputType               write SetInputType            ;
    property CustomInputClass          :string      read GetCustomInputClass        write SetCustomInputClass     ;
    property Price                     :Double      read GetPrice                   write SetPrice                ;
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
  end;*)
  Tprocstowawaylines = class(TMSBusObj)
  private
    xCtr:Integer;
    function GetStowAwayID          : Integer   ;
    function GetProctreeStowId      : Integer   ;
    function GetQty                 : Double    ;
    function GetUOMID               : Integer   ;
    function GetUOM                 : string    ;
    function GetUOMMult             : Double    ;
    function GetUOMQty              : Double    ;
    function GetDeleted             : Boolean;
    function GetProductID           : Integer;
    function getProduct             : TProduct;
    procedure SetStowAwayID          (const Value: Integer   );
    procedure SetProctreeStowId      (const Value: Integer   );
    procedure SetQty                 (const Value: Double    );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetUOM                 (const Value: string    );
    procedure SetUOMMult             (const Value: Double    );
    procedure SetUOMQty              (const Value: Double    );
    procedure SetDeleted             (const Value: Boolean);
    procedure InitUOM(const UOMName, UOMNameOldValue: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoBeforeInsert(Sender:TDatasetBusObj) : Boolean;          override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    procedure CaptureDatasetEvents;override;
    procedure ReleaseDatasetEvents;override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property ProductID            :Integer     read getProductID;
    Property Product              :TProduct    read getProduct;
  published
    property StowAwayID           :Integer     read GetStowAwayID         write SetStowAwayID      ;
    property ProctreeStowId       :Integer     read GetProctreeStowId     write SetProctreeStowId  ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property UOM                  :string      read GetUOM                write SetUOM             ;
    property UOMMult              :Double      read GetUOMMult            write SetUOMMult         ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    Property Deleted: Boolean read getDeleted write setDeleted;
  end;
  Tprocstowaway = class(TMSBusObj)
  private
    AllLinesValid:Boolean;
    //fdQty:double;
    function GetProctreeStowId      : Integer   ;
    function GetEmployeeID          : Integer   ;
    function GetEmployeeName        : string    ;
    function GetStowAwayDate        : TDateTime ;
    function GetQty                 : Double    ;
    function GetUOMID               : Integer   ;
    function GetUOMMult             : Double    ;
    function GetUOM                 : string    ;
    function GetUOMQty              : Double    ;
    function GetDeleted             : Boolean;
    function getLines               : Tprocstowawaylines;
    function getProductID           : Integer;
    function getProduct             : TProduct;
    procedure SetProctreeStowId      (const Value: Integer   );
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetStowAwayDate        (const Value: TDateTime );
    procedure SetQty                 (const Value: Double    );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetUOMMult             (const Value: Double    );
    procedure SetUOM                 (const Value: string    );
    procedure SetUOMQty              (const Value: Double    );
    procedure SetDeleted             (const Value: Boolean);
    Procedure CalcTotals;
    //Procedure CalctotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
    Procedure LinesValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
    procedure InitUOM(const UOMName, UOMNameOldValue: String);


  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property Lines    : Tprocstowawaylines     read getLines;
    Property ProductID: Integer                read getProductID;
    Property Product  : TProduct               read getProduct;
    function Validateentryfields: boolean;
  published
    property ProctreeStowId       :Integer     read GetProctreeStowId     write SetProctreeStowId  ;
    property EmployeeID           :Integer     read GetEmployeeID         write SetEmployeeID      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    property StowAwayDate         :TDateTime   read GetStowAwayDate       write SetStowAwayDate    ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property UOMMult              :Double      read GetUOMMult            write SetUOMMult         ;
    property UOM                  :string      read GetUOM                write SetUOM             ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    Property Deleted: Boolean read getDeleted write setDeleted;
  end;
  TProctreeStow = class(TMSBusObj)
  private
    AllLinesValid:Boolean;
    dsSalesinfo :tdataset;
    function GetProcTreeId            : Integer   ;
    function GetDateCreated           : TDateTime ;
    function GetTotalStowedQty        : Double    ;
    function GetExtraQtyToCustomer    : Double    ;
    function GetExtraQtytoStore       : Double    ;
    procedure SetProcTreeId            (const Value: Integer   );
    procedure SetDateCreated           (const Value: TDateTime );
    procedure SetTotalStowedQty        (const Value: Double    );
    procedure SetExtraQtyToCustomer    (const Value: Double    );
    procedure SetExtraQtytoStore       (const Value: Double    );
    function getStowAway: Tprocstowaway;
    function getproctree: Tproctree;
    Procedure CalcTotals;
    Procedure StowAwayValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
    function getProduct: TProduct;
    function getLines: Tprocstowawaylines;
    function getProductID: Integer;
    Procedure DeleteFlaggedStowAways;
    function IsInternalOrder:Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property StowAways  : Tprocstowaway          read getStowAway;
    Property proctree   : Tproctree              read getproctree;
    Property Product    : TProduct               read getProduct;
    Property Lines      : Tprocstowawaylines     REad getLines;
    Property ProductID  : Integer                read getProductID;

  published
    property ProcTreeId             :Integer     read GetProcTreeId           write SetProcTreeId        ;
    property DateCreated            :TDateTime   read GetDateCreated          write SetDateCreated       ;
    property TotalStowedQty         :Double      read GetTotalStowedQty       write SetTotalStowedQty    ;
    property ExtraQtyToCustomer     :Double      read GetExtraQtyToCustomer   write SetExtraQtyToCustomer;
    property ExtraQtytoStore        :Double      read GetExtraQtytoStore      write SetExtraQtytoStore   ;
  end;




implementation


uses tcDataUtils, CommonLib, sysutils, AppEnvironment, tcConst , Variants,
   BusObjConst;



  {TProctreeStow}

procedure TProctreeStow.CalcTotals;
begin
  {don't use iterate records as the 3rd level object(Lines) doesn't reposition the record properly }
  With getNewDataset('Select sum(Qty) Qty from tblprocstowaway where ProctreeStowId = ' + inttostr(ID) +' and deleted ="F" ', true) do try
    TotalStowedQty:= Fieldbyname('Qty').AsFloat;
    SendEvent(BusObjEvent_Change, BusObjEventVal_StowedQty);
  finally
    if active then close;
    Free;
  end;

end;
constructor TProctreeStow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProctreeStow';
  fSQL := 'SELECT * FROM tblproctreestow';
  dsSalesinfo:= nil;
end;


procedure TProctreeStow.DeleteFlaggedStowAways;
var
  IsFiltered: boolean;
  TempAccessLevel: integer;
begin
  StowAways.Dataset.DisableControls;
  IsFiltered := StowAways.Dataset.Filtered;
  StowAways.Dataset.Filtered := false;
  TempAccessLevel:= AccessManager.AccessLevel;
  if self.CleanID < 1 then
    AccessManager.AccessLevel:= 1;
  try
    if StowAways.Count > 0 then begin
      StowAways.First;
      while not StowAways.Dataset.Eof do begin
        if StowAways.Deleted then begin
          StowAways.Lines.DeleteAll;
          StowAways.Delete;
        end else begin
          StowAways.Dataset.Next;
        end;
      end;
    end;
  finally
    StowAways.Dataset.Filtered := IsFiltered;
    StowAways.Dataset.EnableControls;
    if self.CleanID < 1 then
      AccessManager.AccessLevel:= TempAccessLevel;
  end;
end;

destructor TProctreeStow.Destroy;
begin
  Freeandnil(dsSalesinfo);
  inherited;
end;


procedure TProctreeStow.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProcTreeId');
  SetDateTimePropertyFromNode(node,'DateCreated');
  SetPropertyFromNode(node,'TotalStowedQty');
  SetPropertyFromNode(node,'ExtraQtyToCustomer');
  SetPropertyFromNode(node,'ExtraQtytoStore');
end;


procedure TProctreeStow.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProcTreeId' ,ProcTreeId);
  AddXMLNode(node,'DateCreated' ,DateCreated);
  AddXMLNode(node,'TotalStowedQty' ,TotalStowedQty);
  AddXMLNode(node,'ExtraQtyToCustomer' ,ExtraQtyToCustomer);
  AddXMLNode(node,'ExtraQtytoStore' ,ExtraQtytoStore);
end;


function TProctreeStow.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ProcTreeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProcTreeId should not be Blank' , True);
    Exit;
  end;
  if DateCreated = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DateCreated should not be blank' , True );
    Exit;
  end;

  if (TotalStowedQty > Proctree.ManufactureQty ) then begin
     if (Proctree.ManufactureQty <>  TotalStowedQty- (ExtraQtyToCustomer + ExtraQtytoStore)) then begin
          Resultstatus.AddItem(False , rssError , 0,  'Extra Quantity manufactured : ' +floatTostr(TotalStowedQty-Proctree.ManufactureQty)+'.' + NL +
                                                  ' is not allocated Correctly.'  , True );
          Exit;
     end;
  end;
  AllLinesValid := True;
  StowAways.IterateRecords(StowAwayValidateCallback);
  Result := AllLinesValid;
end;
Procedure TProctreeStow.StowAwayValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is Tprocstowaway) then exit;
  if not(Tprocstowaway(Sender).ValidateData) then begin
    AllLinesValid:= False;
    Abort := True;
  end;
end;
function TProctreeStow.Save: Boolean ;
var
  fbFiltered:Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  fbFiltered:=StowAways.Filtered;
  StowAways.Filtered:= False;
  try
    DeleteFlaggedStowAways;
    Calctotals;
  finally
    StowAways.Filtered:=fbFiltered;
  end;
  Result := inherited Save;
end;


procedure TProctreeStow.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  Freeandnil(dsSalesinfo);
end;


procedure TProctreeStow.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'TotalStowedQty') then begin
    if TotalStowedQty- (ExtraQtyToCustomer + ExtraQtytoStore) <> Proctree.ManufactureQty then begin
      if TotalStowedQty = Proctree.ManufactureQty then begin
        ExtraQtyToCustomer := 0;
        ExtraQtytoStore :=0;
      end else if TotalStowedQty < Proctree.ManufactureQty then begin
        if ExtraQtyToCustomer <> 0 then ExtraQtyToCustomer :=0;
        if ExtraQtytoStore    <> 0 then ExtraQtytoStore := 0;
      end else if TotalStowedQty > Proctree.ManufactureQty then begin
        if IsInternalOrder then begin
          ExtraQtytoStore :=TotalStowedQty- Proctree.ManufactureQty;
          ExtraQtyToCustomer  :=0;
        end else
          ExtraQtyToCustomer  := TotalStowedQty- Proctree.ManufactureQty -ExtraQtytoStore;
      end;
    end;
    if ExtraQtyToCustomer < 0 then ExtraQtyToCustomer :=0;
    if ExtraQtytoStore    < 0 then ExtraQtytoStore := 0;
  end else if Sysutils.SameText(Sender.FieldName, 'ExtraQtyToCustomer') then begin
    ExtraQtytoStore  := TotalStowedQty- Proctree.ManufactureQty -ExtraQtyToCustomer;
  end else if Sysutils.SameText(Sender.FieldName, 'ExtraQtytoStore') then begin
    if IsInternalOrder then begin
      ExtraQtytoStore :=TotalStowedQty- Proctree.ManufactureQty;
      ExtraQtyToCustomer  :=0;
    end else
    ExtraQtyToCustomer  := TotalStowedQty- Proctree.ManufactureQty -ExtraQtytoStore;
  end;
end;


function TProctreeStow.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TProctreeStow.getStowAway: Tprocstowaway;
begin
    Result := Tprocstowaway(getcontainercomponent(Tprocstowaway , 'ProctreeStowId = ' + IntToStr(ID) , true , true));
end;

class function TProctreeStow.GetIDField: string;
begin
  Result := 'ID'
end;


function TProctreeStow.getLines: Tprocstowawaylines;
begin
      Result := Tprocstowawaylines(getcontainercomponent(Tprocstowawaylines , 'ProctreeStowId = ' + IntToStr(Id) , true , true));
end;

function TProctreeStow.getproctree: Tproctree;
begin
    Result := Tproctree(getcontainercomponent(Tproctree , 'ProctreeID = ' + IntToStr(ProcTreeId) , true , true));
end;

class function TProctreeStow.GetBusObjectTablename: string;
begin
  Result:= 'tblproctreestow';
end;


function TProctreeStow.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  DateCreated:= Date;
end;

function TProctreeStow.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProctreeStow.GetProcTreeId        : Integer   ; begin Result := GetIntegerField('ProcTreeId');end;
function TProctreeStow.getProduct: TProduct;
begin
    Result := TProduct(getcontainercomponent(TProduct , 'PartsId = ' + IntToStr(Proctree.PartsId) , true , true));
end;

function TProctreeStow.getProductID: Integer;
begin
  result:= Proctree.PartsId;
end;

function  TProctreeStow.GetDateCreated       : TDateTime ; begin Result := GetDateTimeField('DateCreated');end;
function  TProctreeStow.GetTotalStowedQty    : Double    ; begin Result := GetFloatField('TotalStowedQty');end;
function TProctreeStow.IsInternalOrder: Boolean;
begin
  if dsSalesinfo = nil then begin
    dsSalesinfo := getNewDataset('SELECT PT.proctreeId  , PT.ManufactureQty , PT.ManufactureUOMQty, PT.TreePartUOM, PT.TreePartUOMID, PT.TreePartUOMMultiplier, S.isinternalorder,' +
                                  ' concat(PT.TreePartUOM, "(" , PT.TreePartUOMMultiplier,")") as UOM' +
                                  ' FROM tblproctree PT' +
                                  ' inner join tblSaleslines SL on PT.MasterId = SL.SaleLineId' +
                                  ' inner join tblSales S on S.SaleId = SL.SaLeId' +
                                  ' where PT.ProctreeId = ' + inttostr(ProctreeID), true);
  end;
  result:= dsSalesinfo.FieldByName('isinternalorder').AsBoolean;
end;

function  TProctreeStow.GetExtraQtyToCustomer: Double    ; begin Result := GetFloatField('ExtraQtyToCustomer');end;
function  TProctreeStow.GetExtraQtytoStore   : Double    ; begin Result := GetFloatField('ExtraQtytoStore');end;
procedure TProctreeStow.SetProcTreeId        (const Value: Integer   ); begin SetIntegerField('ProcTreeId'         , Value);end;
procedure TProctreeStow.SetDateCreated       (const Value: TDateTime ); begin SetDateTimeField('DateCreated'        , Value);end;
procedure TProctreeStow.SetTotalStowedQty    (const Value: Double    ); begin SetFloatField('TotalStowedQty'     , Value);end;
procedure TProctreeStow.SetExtraQtyToCustomer(const Value: Double    ); begin SetFloatField('ExtraQtyToCustomer' , Value);end;
procedure TProctreeStow.SetExtraQtytoStore   (const Value: Double    ); begin SetFloatField('ExtraQtytoStore'    , Value);end;

  {Tprocstowaway}

procedure Tprocstowaway.CalcTotals;
begin
(*    fdQty :=0;
    Lines.IterateRecords(CalctotalsCallback);
    Qty := fdQty;
    PostDB;*)
  {don't use iterate records as the 3rd level object(Lines) doesn't reposition the record properly }
  With getNewDataset('Select sum(Qty) Qty from tblprocStowawayLines where StowAwayID = ' + inttostr(ID) +' and deleted ="F" ', true) do try
    Qty:= Fieldbyname('Qty').AsFloat;
    SendEvent(BusObjEvent_Change, BusObjEventVal_StowedQty);
  finally
    if active then close;
    Free;
  end;

end;

(*procedure Tprocstowaway.CalctotalsCallback(const Sender: TBusObj;var Abort: Boolean);
begin
  if not(Sender is Tprocstowawaylines) then exit;
  fdQty := fdQty + Tprocstowawaylines(Sender).Qty;
end;*)

constructor Tprocstowaway.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'procstowaway';
  fSQL := 'SELECT * FROM tblprocstowaway';
end;


destructor Tprocstowaway.Destroy;
begin
  inherited;
end;


procedure Tprocstowaway.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProctreeStowId');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
  SetDateTimePropertyFromNode(node,'StowAwayDate');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOMMult');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'Deleted');
end;


procedure Tprocstowaway.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProctreeStowId' ,ProctreeStowId);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'StowAwayDate' ,StowAwayDate);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOMMult' ,UOMMult);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'Deleted' ,Deleted);
end;

Function TProcStowAway.Validateentryfields:boolean;
begin
  Result:= False;
  if ProctreeStowId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProctreeStowId should not be 0' , True );
    Exit;
  end;
  if EmployeeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should not be blank' , True );
    Exit;
  end;
  if StowAwayDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Stow Away Date should not be blank' , True );
    Exit;
  end;
  REsult:= True;
end;
function Tprocstowaway.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result:= Validateentryfields;
  if not result then exit;
  result:= False;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , True );
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOMID should not be 0' , True );
    Exit;
  end;
  AllLinesValid := True;
  Lines.IterateRecords(LinesValidateCallback);
  Result := AllLinesValid;
end;
Procedure Tprocstowaway.LinesValidateCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is Tprocstowawaylines) then exit;
  if not(Tprocstowawaylines(Sender).ValidateData) then begin
    AllLinesValid:= False;
    Abort := True;
  end;
end;

function Tprocstowaway.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprocstowaway.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  Lines.Filter := 'StowAwayID = ' + inttostr(ID)+' and Deleted =' + Quotedstr('F');
  Lines.Filtered := True;
  SendEvent(BusObjEvent_Change,BusObjEvent_OnDataIdChange, self);
end;


procedure Tprocstowaway.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'employeeId') then begin
    Employeename := tcDataUtils.getemployeeName(EmployeeID);
  end else if Sysutils.SameText(Sender.FieldName, 'UOM') then begin
    (*uomid := tcdatautils.getUOMID(uom, ProductId  );
    DoFieldOnChange(Dataset.FindField('UOMID'));*)
    if sender.OldValue = null then
      InitUOM(Sender.Value , '')
    else
      InitUOM(Sender.Value , sender.OldValue);
    UOMQty := DivZer(Qty, UOMMult);
  end else if Sysutils.SameText(Sender.FieldName, 'UOMID') then begin
    uom     := tcdatautils.GetUOMName(UOMID);
    UOMMult := tcdatautils.getUnitMultiplier(uomID);
    UOMQty := DivZer(Qty, UOMMult);
  end else if Sysutils.SameText(Sender.FieldName, 'uomQty') then begin
    Qty := uomQty*uommult;
  end else if Sysutils.SameText(Sender.FieldName, 'Qty') then begin
    UOMQty := DivZer(Qty, UOMMult);
  end else if Sysutils.SameText(Sender.FieldName, 'ProctreeStowId') then begin
    if Assigned(Owner) then
      if Owner is  TProcTreeStow then begin
        UOMID := TProcTreeStow(Owner).proctree.TreePartUOMID;
        DoFieldOnChange(Dataset.FindField('UOMID'));
      end;
  end else if Sysutils.SameText(Sender.FieldName, 'Deleted') then begin
    CalcTotals;
    if Assigned(Owner) then
      if owner is TProctreeStow then
        TProctreeStow(Owner).CalcTotals;
  end;
end;

Procedure Tprocstowaway.InitUOM(const UOMName, UOMNameOldValue:String);
begin
  if productId<>0 then begin
      Product.UOMList.Closedb;
      Product.UOMList.OpenDb;
      if Product.ProductUOMLocate(UOMName)  then begin
        Self.UOMMult  := Product.UOMList.Multiplier;
        Self.UOMID    := Product.UOMList.ID;
        Self.UOM      := Product.UOMList.UOMName;
      end else begin
        Self.UOMMult  := 1 ;
        Self.UOMID    := 0;
      end;
      PostDB;
    end;
end;

function Tprocstowaway.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tprocstowaway.GetIDField: string;
begin
  Result := 'ID'
end;


function Tprocstowaway.getLines: Tprocstowawaylines;
begin
  Result:= TProctreeStow(Owner).Lines;
end;

class function Tprocstowaway.GetBusObjectTablename: string;
begin
  Result:= 'tblprocstowaway';
end;


function Tprocstowaway.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TProcTreeStow then
      ProctreeStowId := TProcTreeStow(Self.Owner).ID;
  EmployeeID := appenv.Employee.EmployeeID;
  StowAwayDate := Date;
end;

function Tprocstowaway.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if Assigned (Owner) then
    if owner is TProctreeStow then
      TProctreeStow(Owner).calcTotals;
  Lines.Filter := 'StowAwayID = ' + inttostr(ID)+' and Deleted =' + Quotedstr('F');
  Lines.Filtered := True;
end;


{Property Functions}
function  Tprocstowaway.GetProctreeStowId  : Integer   ; begin Result := GetIntegerField('ProctreeStowId');end;
function Tprocstowaway.getProduct: TProduct;
begin
  result := nil;
  if assigned(Owner) then
    if owner is TProctreeStow then
      result:= TProctreeStow(Owner).Product;
end;

function Tprocstowaway.getProductID: Integer;
begin
  result:= 0;
  if assigned(Owner) and  (Owner is TProcTreeStow) then
    result:= TProcTreeStow(Owner).ProductID;
end;

function  Tprocstowaway.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  Tprocstowaway.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  Tprocstowaway.GetStowAwayDate    : TDateTime ; begin Result := GetDateTimeField('StowAwayDate');end;
function  Tprocstowaway.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function  Tprocstowaway.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  Tprocstowaway.GetUOMMult         : Double    ; begin Result := GetFloatField('UOMMult');end;
function  Tprocstowaway.GetUOM             : string    ; begin Result := GetStringField('UOM');end;
function  Tprocstowaway.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function  Tprocstowaway.GetDeleted: Boolean; begin Result := GetBooleanField('Deleted');end;
procedure Tprocstowaway.SetProctreeStowId  (const Value: Integer   ); begin SetIntegerField('ProctreeStowId'   , Value);end;
procedure Tprocstowaway.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure Tprocstowaway.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure Tprocstowaway.SetStowAwayDate    (const Value: TDateTime ); begin SetDateTimeField('StowAwayDate'     , Value);end;
procedure Tprocstowaway.SetQty             (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;
procedure Tprocstowaway.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure Tprocstowaway.SetUOMMult         (const Value: Double    ); begin SetFloatField('UOMMult'          , Value);end;
procedure Tprocstowaway.SetUOM             (const Value: string    ); begin SetStringField('UOM'              , Value);end;
procedure Tprocstowaway.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'           , Value);end;
procedure Tprocstowaway.SetDeleted(const Value: Boolean); begin SetBooleanField('Deleted' , Value);end;


  {Tprocstowawaylines}

procedure Tprocstowawaylines.CaptureDatasetEvents;
begin
  xCtr:= xCtr+1;
  inherited;
end;
procedure Tprocstowawaylines.ReleaseDatasetEvents;
begin
  xCtr:= xCtr-1;
  inherited;
end;

constructor Tprocstowawaylines.Create(AOwner: TComponent);
begin
  xCtr:=0;
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'procstowawaylines';
  fSQL := 'SELECT * FROM tblprocstowawaylines';
end;


destructor Tprocstowawaylines.Destroy;
begin
  inherited;
end;


procedure Tprocstowawaylines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'StowAwayID');
  SetPropertyFromNode(node,'ProctreeStowId');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMMult');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'Deleted');
end;


procedure Tprocstowawaylines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'StowAwayID' ,StowAwayID);
  AddXMLNode(node,'ProctreeStowId' ,ProctreeStowId);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMMult' ,UOMMult);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'Deleted' ,Deleted);
end;


function Tprocstowawaylines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if StowAwayID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'StowAwayID should not be 0' , True );
    Exit;
  end;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , True );
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOMID should not be 0' , True );
    Exit;
  end;
  Result := True;
end;


function Tprocstowawaylines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tprocstowawaylines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;



procedure Tprocstowawaylines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'UOMID') then begin
    uom     := tcdatautils.GetUOMName(UOMID);
    DoFieldOnChange(dataset.findfield('uom'));
  end else if Sysutils.SameText(Sender.FieldName, 'UOM') then begin
    if sender.OldValue = null then
      InitUOM(Sender.Value , '')
    else
    InitUOM(Sender.Value , sender.OldValue);
    if not Deleted then
      if not isUnique(ID, 'StowAwayID = ' + inttostr(StowAwayID) +' and uomID = ' + inttostr(UOMID)+' and Deleted ="F"', Self.Connection.connection) then begin
        resultStatus.AddItem(False, rssWarning,0 ,  'Record for UOM ' +Quotedstr(UOM) +' already exists, Please change qty in that'  );
        CAnceldb;
        Exit;
      end;
      UOMQty := DivZer(Qty, UOMMult);
  end else if Sysutils.SameText(Sender.FieldName, 'uomQty') then begin
    Qty := uomQty*uommult;
  end else if Sysutils.SameText(Sender.FieldName, 'Qty') then begin
    UOMQty := DivZer(Qty, UOMMult);
  end;
end;
function Tprocstowawaylines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

Procedure Tprocstowawaylines.InitUOM(const UOMName, UOMNameOldValue:String);
begin
  if productId<>0 then begin
      Product.UOMList.Closedb;
      Product.UOMList.OpenDb;
      if Product.ProductUOMLocate(UOMName)  then begin
        Self.UOMMult  := Product.UOMList.Multiplier;
        Self.UOMID    := Product.UOMList.ID;
        Self.UOM      := Product.UOMList.UOMName;
      end else begin
        Self.UOMMult  := 1 ;
        Self.UOMID    := 0;
      end;
    end;
end;

class function Tprocstowawaylines.GetIDField: string;
begin
  Result := 'ID'
end;


function Tprocstowawaylines.getProduct: TProduct;
begin
  result := nil;
  if assigned(Owner) then
    if owner is TProcTreeStow then
      result:= TProcTreeStow(Owner).Product;
end;

function Tprocstowawaylines.getProductID: Integer;
begin
  result:= 0;
  if assigned(Owner) and  (Owner is TProcTreeStow) then
    result:= TProcTreeStow(Owner).ProductId;
end;

class function Tprocstowawaylines.GetBusObjectTablename: string;
begin
  Result:= 'tblprocstowawaylines';
end;


function Tprocstowawaylines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TProctreeStow then begin
      StowAwayID      := TProctreeStow(Self.Owner).StowAways.ID;
      ProctreeStowId  := TProctreeStow(Self.Owner).Id;
    end;
end;

function Tprocstowawaylines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is  TProcTreeStow then
      TProcTreeStow(Owner).StowAways.Calctotals;
end;


function Tprocstowawaylines.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult:= inherited DoBeforeInsert(Sender);
  if not(Result) then exit;
  if assigned(Owner) then
    if owner is TProctreeStow then
      TProctreeStow(Self.Owner).StowAways.PostDB;
end;

function Tprocstowawaylines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  if (Qty  =0) and (uomid=0) then
    Deleted := True;

end;

{Property Functions}
function  Tprocstowawaylines.GetStowAwayID      : Integer   ; begin Result := GetIntegerField('StowAwayID');end;
function  Tprocstowawaylines.GetProctreeStowId  : Integer   ; begin Result := GetIntegerField('ProctreeStowId');end;
function  Tprocstowawaylines.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function  Tprocstowawaylines.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  Tprocstowawaylines.GetUOM             : string    ; begin Result := GetStringField('UOM');end;
function  Tprocstowawaylines.GetUOMMult         : Double    ; begin Result := GetFloatField('UOMMult');end;
function  Tprocstowawaylines.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function  Tprocstowawaylines.GetDeleted         : Boolean   ; begin Result := GetBooleanField('Deleted');end;
procedure Tprocstowawaylines.SetStowAwayID      (const Value: Integer   ); begin SetIntegerField('StowAwayID'       , Value);end;
procedure Tprocstowawaylines.SetProctreeStowId  (const Value: Integer   ); begin SetIntegerField('ProctreeStowId'   , Value);end;
procedure Tprocstowawaylines.SetQty             (const Value: Double    ); begin SetFloatField('Qty'                , Value);end;
procedure Tprocstowawaylines.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure Tprocstowawaylines.SetUOM             (const Value: string    ); begin SetStringField('UOM'               , Value);end;
procedure Tprocstowawaylines.SetUOMMult         (const Value: Double    ); begin SetFloatField('UOMMult'            , Value);end;
procedure Tprocstowawaylines.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'             , Value);end;
procedure Tprocstowawaylines.SetDeleted         (const Value: Boolean   ); begin SetBooleanField('Deleted'          , Value);end;


(* {Tproctree}

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
  SetBooleanPropertyFromNode(node,'HideOnPrint');
  SetBooleanPropertyFromNode(node,'AddToSale');
  SetBooleanPropertyFromNode(node,'TreePricechanged');
  SetPropertyFromNode(node,'LinkedLineId');
  SetPropertyFromNode(node,'PartSource');
  SetPropertyFromNode(node,'InputType');
  SetPropertyFromNode(node,'CustomInputClass');
  SetPropertyFromNode(node,'Price');
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
  AddXMLNode(node,'HideOnPrint' ,HideOnPrint);
  AddXMLNode(node,'AddToSale' ,AddToSale);
  AddXMLNode(node,'TreePricechanged' ,TreePricechanged);
  AddXMLNode(node,'LinkedLineId' ,LinkedLineId);
  AddXMLNode(node,'PartSource' ,PartSource);
  AddXMLNode(node,'InputType' ,InputType);
  AddXMLNode(node,'CustomInputClass' ,CustomInputClass);
  AddXMLNode(node,'Price' ,Price);
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
function  Tproctree.GetHideOnPrint          : Boolean   ; begin Result := GetBooleanField('HideOnPrint');end;
function  Tproctree.GetAddToSale            : Boolean   ; begin Result := GetBooleanField('AddToSale');end;
function  Tproctree.GetTreePricechanged     : Boolean   ; begin Result := GetBooleanField('TreePricechanged');end;
function  Tproctree.GetLinkedLineId         : Integer   ; begin Result := GetIntegerField('LinkedLineId');end;
function  Tproctree.GetPartSource           : string    ; begin Result := GetStringField('PartSource');end;
function  Tproctree.GetInputType            : string    ; begin Result := GetStringField('InputType');end;
function  Tproctree.GetCustomInputClass     : string    ; begin Result := GetStringField('CustomInputClass');end;
function  Tproctree.GetPrice                : Double    ; begin Result := GetFloatField('Price');end;
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
function  Tproctree.GetOnOrderUOMQty        : Double    ; begin Result := GetFloatField('OnOrderUOMQty');end;
function  Tproctree.GetFromStockQty         : Double    ; begin Result := GetFloatField('FromStockQty');end;
function  Tproctree.GetManufactureQty       : Double    ; begin Result := GetFloatField('ManufactureQty');end;
function  Tproctree.GetOnOrderQty           : Double    ; begin Result := GetFloatField('OnOrderQty');end;
function  Tproctree.GetQtyPlanned           : Double    ; begin Result := GetFloatField('QtyPlanned');end;
function  Tproctree.GetTotalQtyPlanned      : Double    ; begin Result := GetFloatField('TotalQtyPlanned');end;
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
procedure Tproctree.SetHideOnPrint          (const Value: Boolean   ); begin SetBooleanField('HideOnPrint'           , Value);end;
procedure Tproctree.SetAddToSale            (const Value: Boolean   ); begin SetBooleanField('AddToSale'             , Value);end;
procedure Tproctree.SetTreePricechanged     (const Value: Boolean   ); begin SetBooleanField('TreePricechanged'      , Value);end;
procedure Tproctree.SetLinkedLineId         (const Value: Integer   ); begin SetIntegerField('LinkedLineId'          , Value);end;
procedure Tproctree.SetPartSource           (const Value: string    ); begin SetStringField('PartSource'            , Value);end;
procedure Tproctree.SetInputType            (const Value: string    ); begin SetStringField('InputType'             , Value);end;
procedure Tproctree.SetCustomInputClass     (const Value: string    ); begin SetStringField('CustomInputClass'      , Value);end;
procedure Tproctree.SetPrice                (const Value: Double    ); begin SetFloatField('Price'                 , Value);end;
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
procedure Tproctree.SetOnOrderUOMQty        (const Value: Double    ); begin SetFloatField('OnOrderUOMQty'         , Value);end;
procedure Tproctree.SetFromStockQty         (const Value: Double    ); begin SetFloatField('FromStockQty'          , Value);end;
procedure Tproctree.SetManufactureQty       (const Value: Double    ); begin SetFloatField('ManufactureQty'        , Value);end;
procedure Tproctree.SetOnOrderQty           (const Value: Double    ); begin SetFloatField('OnOrderQty'            , Value);end;
procedure Tproctree.SetQtyPlanned           (const Value: Double    ); begin SetFloatField('QtyPlanned'            , Value);end;
procedure Tproctree.SetTotalQtyPlanned      (const Value: Double    ); begin SetFloatField('TotalQtyPlanned'       , Value);end;
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
*)
initialization
  RegisterClass(Tprocstowawaylines);
  RegisterClass(Tprocstowaway);
  RegisterClass(TProctreeStow);


end.
