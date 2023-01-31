unit BusObjProcPrefs;

interface

uses
  Classes, BusObjNDSGenDb;

type

  TAutoProdPlanSchedType = (psForward, psReverse, psOnTheDate);

  TBusObjProcPrefs = class(TBusObjNDSGenDb)
  private
    FResourceAvailableForHolidays: boolean;
    FAllocationWarningDays: integer;
    FWarnTemplateProcessesNotDefined: boolean;
    FAutoScheduleBasedonBOMEmpRoster: boolean;
    //FWastageCalculationEnabled: boolean;
    FWarnTemplateOptionDefaultNotDefined: boolean;
    FCapacityPlanningWeeksToShow: integer;
    FAutoProdPlanSchedGraceDays: integer;
    FAutoProdPlanSchedType: TAutoProdPlanSchedType;
    fProdPlanConfirmSave: boolean;
    fShowAllEmployeesinProductionScheduler: boolean;
    fCapacityplannerSelectionOptionBeforeLoad: boolean;
    fOpenTreeFromSalesOrder: boolean;
    fManufacturePartSourceStock: Boolean;
    fManufacturePartSourceStockconfirm: Boolean;
    fScheduleProductionOnWeekendDays:Boolean;
    fbAutoCreateSmartOrderFromSalesOrderTree: Boolean;
    fbCopyTreeInfotoSalesDesc: Boolean;
    fbPrintOnItemProgress: Boolean;
    fbPrintOnItemcompletion: Boolean;
    fbOpenTreeOnSmartOrdercreation: Boolean;
    fbResetSaleDateWhenBuilt: Boolean;
    fbDefaultCoupenTimeinWOTimesheet: Boolean;
    fbHideSelectedSubnodesinReport:boolean;
    fbAutoclockOnemployeeOnjob:boolean;
    fbCompleteBOMOrderOnSave:boolean;
    fbOnlyshowScheduledJobsForBarCodeMan:boolean;
    (*fiNonInvProductcostinBOM1:Integer;
    fiNonInvProductcostinBOM2:Integer;
    fiNonInvProductcostinBOM3:Integer;*)
    fiGanttChartBarHeight :Integer;
    fiCostDecimalPlacesinTree :Integer;
    fiPPGBalanceAdjAccountID :Integer;
    fiPPGBalanceAdjEmployeeID :Integer;
    fsDefaultBOMWastageAccount :String;
    fsBoMNonProductsubnodePostingAccount :String;
    fiGanttChartDrawStyle :Integer;
    (*fsInventoryAssetBOMNonInvCogsAccount:String;*)
    fiGanttChartGFStartColour :Integer;
    fiGanttChartGFEndcolour :Integer;
    fiProductStatusPartQtyColour :Integer;
    fiProductStatusTransQtyColour :Integer;
    fiProductStatusOrderQtyColour :Integer;
    fiProductStatusETAWithinPeriodColour :Integer;
    fiProductStatusETAExceededColour :Integer;
    fiGanttChartGFStartColourIntensity :Integer;
    fiGanttChartGFEndColourIntensity :Integer;
    fiProductStatusPartQtyColourIntensity:Integer;
    fiProductStatusTransQtyColourIntensity:Integer;
    fiProductStatusOrderQtyColourIntensity:Integer;
    fiProductStatusETAWithinPeriodColourIntensity:Integer;
    fiProductStatusETAExceededColourIntensity:Integer;
    fbUseFld7AsSteelWeight: boolean;
    fbUpdateProductDescriptionFromTreeInfo: boolean;
    fbUpdateSalesDescriptionFromTreeInfo: boolean;
    fbBOMPriceOverridesAllOtherPrice: boolean;
    fbIgnoreBOMCalcPriceOnSale: boolean;
    fbSubBOMUseAvailableQtyFromStock: boolean;
    fbCSPOverridesRawMaterialPrices: boolean;
    fbRoundBatchQtyinProgressBatchCreator: boolean;
    FUseCurrentCostforProgressBuild: boolean;
    FAutoAllocateProcessForTreeRoot: boolean;
    FConfirmQtysOnfinalise: boolean;
    fsDefaultProcessforTree :String;
    fdDefaultTreeProcessDuration :Double;
    FOnPPGErrorSendEmail: boolean;
    fsPPErrorEmailTo :String;
    fsBuildDetailsUpdateOption :String;


    procedure SetResourceAvailableForHolidays(const Value: boolean);
    procedure SetAllocationWarningDays(const Value: integer);
    procedure SetWarnTemplateOptionDefaultNotDefined(const Value: boolean);
    procedure SetWarnTemplateProcessesNotDefined(const Value: boolean);
    procedure SetAutoScheduleBasedonBOMEmpRoster(const Value: boolean);
    //procedure SetWastageCalculationEnabled(const Value: boolean);
    Procedure setScheduleProductionOnWeekendDays(const Value:Boolean);
    procedure SetCapacityPlanningWeeksToShow(const Value: integer);
    procedure SetAutoProdPlanSchedGraceDays(const Value: integer);
    procedure SetAutoProdPlanSchedType(const Value: TAutoProdPlanSchedType);
    procedure SetProdPlanConfirmSave(const Value: boolean);
    procedure SetShowAllEmployeesinProductionScheduler(const Value: boolean);
    procedure SetCapacityplannerSelectionOptionBeforeLoad(const Value: boolean);
    procedure SetOpenTreeFromSalesOrder(const Value: boolean);
    procedure setManufacturePartSourceStock(const Value: Boolean);
    procedure setManufacturePartSourceStockconfirm(const Value: Boolean);
    procedure setAutoCreateSmartOrderFromSalesOrderTree(const Value: Boolean);
    procedure setCopyTreeInfotoSalesDesc(const Value: Boolean);
    procedure setPrintOnItemProgress(const Value: Boolean);
    procedure setPrintOnItemcompletion(const Value: Boolean);
    procedure setOpenTreeOnSmartOrdercreation(const Value: Boolean);
    procedure setResetSaleDateWhenBuilt(const Value: Boolean);
    procedure setDefaultCoupenTimeinWOTimesheet(const Value: Boolean);
    Procedure SetHideSelectedSubnodesinReport(const Value: Boolean);
    Procedure SetAutoclockOnemployeeOnjob(const Value: Boolean);
    Procedure SetCompleteBOMOrderOnSave(const Value: Boolean);
    Procedure SetOnlyshowScheduledJobsForBarCodeMan(const Value: Boolean);
    (*Procedure SetNonInvProductcostinBOM1(const Value:Integer);
    Procedure SetNonInvProductcostinBOM2(const Value:Integer);
    Procedure SetNonInvProductcostinBOM3(const Value:Integer);*)
    procedure SetGanttChartBarHeight(Const  Value:Integer);
    procedure SetCostDecimalPlacesinTree(Const  Value:Integer);
    procedure SetPPGBalanceAdjAccountID(Const  Value:Integer);
    procedure SetPPGBalanceAdjEmployeeID(Const  Value:Integer);
    procedure SetDefaultBOMWastageAccount(Const  Value:String);
    procedure SetBoMNonProductsubnodePostingAccount(Const  Value:String);
    procedure SetGanttChartDrawStyle(Const  Value:Integer);
    (*Procedure SetInventoryAssetBOMNonInvCogsAccount(const Value:String);*)
    procedure SetGanttChartGFStartColour(Const  Value:Integer);
    procedure SetGanttChartGFEndcolour(Const  Value:Integer);
    procedure SetProductStatusPartQtyColour(Const  Value:Integer);
    procedure SetProductStatusTransQtyColour(Const  Value:Integer);
    procedure SetProductStatusOrderQtyColour(Const  Value:Integer);
    procedure SetProductStatusETAWithinPeriodColour(Const  Value:Integer);
    procedure SetProductStatusETAExceededColour(Const  Value:Integer);


    procedure SetGanttChartGFStartColourIntensity(Const  Value:Integer);
    procedure SetGanttChartGFEndColourIntensity(Const  Value:Integer);
    procedure SetProductStatusPartQtyColourIntensity(Const  Value:Integer);
    procedure SetProductStatusTransQtyColourIntensity(Const  Value:Integer);
    procedure SetProductStatusOrderQtyColourIntensity(Const  Value:Integer);
    procedure SetProductStatusETAWithinPeriodColourIntensity(Const  Value:Integer);
    procedure SetProductStatusETAExceededColourIntensity(Const  Value:Integer);
    function getCostDecimalPlacesinTree: Integer;
    function getPPGBalanceAdjAccountID: Integer;
    function getPPGBalanceAdjEmployeeID: Integer;
    procedure SetUseFld7AsSteelWeight(const Value: boolean);
    procedure SetUpdateProductDescriptionFromTreeInfo(const Value: boolean);
    procedure SetUpdateSalesDescriptionFromTreeInfo(const Value: boolean);
    procedure SetBOMPriceOverridesAllOtherPrice(const Value: boolean);
    procedure SetIgnoreBOMCalcPriceOnSale(const Value: boolean);
    procedure SetSubBOMUseAvailableQtyFromStock(const Value: boolean);
    procedure SetCSPOverridesRawMaterialPrices(const Value: boolean);
    procedure SetRoundBatchQtyinProgressBatchCreator(const Value: boolean);
    procedure SetUseCurrentCostforProgressBuild(const Value: boolean);
    procedure SetAutoAllocateProcessForTreeRoot(const Value: boolean);
    procedure SetConfirmQtysOnfinalise(const Value: boolean);
    procedure SetDefaultProcessforTree(Const  Value:String);
    procedure SetDefaultTreeProcessDuration(Const  Value:Double);
    function getAutoAllocateProcessForTreeRoot: boolean;
    function getConfirmQtysOnfinalise: boolean;
    function getDefaultProcessforTreeID: Integer;
    procedure SetOnPPGErrorSendEmail(const Value: boolean);
    procedure SetPPErrorEmailTo(Const  Value:String);
    procedure SetBuildDetailsUpdateOption(Const  Value:String);
    function getOnPPGErrorSendEmail: boolean;
    function getPPErrorEmailToEmail: String;
    function getBOMDetailsAppendsProductDescriptionMemo: Boolean;
    function getBOMDetailsReplacesProductDescriptionMemo: Boolean;
    function getIgnoreBOMDetailsUpdateonSales: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Function Save:Boolean;Override;
  published
    property ResourceNotAvailableForHolidays: boolean read FResourceAvailableForHolidays write SetResourceAvailableForHolidays;
    property AllocationWarningDays: integer read FAllocationWarningDays write SetAllocationWarningDays;
    property WarnTemplateProcessesNotDefined: boolean  read FWarnTemplateProcessesNotDefined write SetWarnTemplateProcessesNotDefined;
    property AutoScheduleBasedonBOMEmpRoster: boolean  read FAutoScheduleBasedonBOMEmpRoster write SetAutoScheduleBasedonBOMEmpRoster;
    //property WastageCalculationEnabled: boolean  read FWastageCalculationEnabled write SetWastageCalculationEnabled;
    property WarnTemplateOptionDefaultNotDefined: boolean read FWarnTemplateOptionDefaultNotDefined write SetWarnTemplateOptionDefaultNotDefined;
    Property ScheduleProductionOnWeekendDays :Boolean read fScheduleProductionOnWeekendDays write setScheduleProductionOnWeekendDays;
    property CapacityPlanningWeeksToShow: integer read FCapacityPlanningWeeksToShow write SetCapacityPlanningWeeksToShow;
    property AutoProdPlanSchedType: TAutoProdPlanSchedType read FAutoProdPlanSchedType write SetAutoProdPlanSchedType;
    property AutoProdPlanSchedGraceDays: integer read FAutoProdPlanSchedGraceDays write SetAutoProdPlanSchedGraceDays;
    property ProdPlanConfirmSave: boolean read fProdPlanConfirmSave write SetProdPlanConfirmSave;
    property ShowAllEmployeesinProductionScheduler: boolean read fShowAllEmployeesinProductionScheduler write SetShowAllEmployeesinProductionScheduler;
    property CapacityplannerSelectionOptionBeforeLoad: boolean read fCapacityplannerSelectionOptionBeforeLoad write SetCapacityplannerSelectionOptionBeforeLoad;
    property OpenTreeFromSalesOrder: boolean read fOpenTreeFromSalesOrder write SetOpenTreeFromSalesOrder;
    Property ManufacturePartSourceStock :Boolean read fManufacturePartSourceStock Write setManufacturePartSourceStock;
    Property ManufacturePartSourceStockconfirm :Boolean read fManufacturePartSourceStockconfirm Write setManufacturePartSourceStockconfirm;
    Property AutoCreateSmartOrderFromSalesOrderTree :Boolean read fbAutoCreateSmartOrderFromSalesOrderTree write setAutoCreateSmartOrderFromSalesOrderTree;
    Property CopyTreeInfotoSalesDesc :Boolean read fbCopyTreeInfotoSalesDesc write setCopyTreeInfotoSalesDesc;
    Property PrintOnItemProgress :Boolean read fbPrintOnItemProgress write setPrintOnItemProgress;
    Property PrintOnItemcompletion :Boolean read fbPrintOnItemcompletion write setPrintOnItemcompletion;
    Property OpenTreeOnSmartOrdercreation :Boolean read fbOpenTreeOnSmartOrdercreation write setOpenTreeOnSmartOrdercreation;
    Property ResetSaleDateWhenBuilt :Boolean read fbResetSaleDateWhenBuilt write setResetSaleDateWhenBuilt;
    Property DefaultCoupenTimeinWOTimesheet :Boolean read fbDefaultCoupenTimeinWOTimesheet write setDefaultCoupenTimeinWOTimesheet;
    Property HideSelectedSubnodesinReport :Boolean read fbHideSelectedSubnodesinReport write setHideSelectedSubnodesinReport;
    Property AutoclockOnemployeeOnjob :Boolean read fbAutoclockOnemployeeOnjob write setAutoclockOnemployeeOnjob;
    Property CompleteBOMOrderOnSave :Boolean read fbCompleteBOMOrderOnSave write setCompleteBOMOrderOnSave;
    Property OnlyshowScheduledJobsForBarCodeMan :Boolean read fbOnlyshowScheduledJobsForBarCodeMan write setOnlyshowScheduledJobsForBarCodeMan;
    (*Property NonInvProductcostinBOM1 :Integer read fiNonInvProductcostinBOM1 write setNonInvProductcostinBOM1;
    Property NonInvProductcostinBOM2 :Integer read fiNonInvProductcostinBOM2 write setNonInvProductcostinBOM2;
    Property NonInvProductcostinBOM3 :Integer read fiNonInvProductcostinBOM3 write setNonInvProductcostinBOM3;*)
    Property GanttChartBarHeight:Integer read fiGanttChartBarHeight write setGanttChartBarHeight;
    Property CostDecimalPlacesinTree:Integer read getCostDecimalPlacesinTree write setCostDecimalPlacesinTree;
    Property PPGBalanceAdjAccountID:Integer read getPPGBalanceAdjAccountID write setPPGBalanceAdjAccountID;
    Property PPGBalanceAdjEmployeeID:Integer read getPPGBalanceAdjEmployeeID write setPPGBalanceAdjEmployeeID;
    Property DefaultBOMWastageAccount:String read fsDefaultBOMWastageAccount write setDefaultBOMWastageAccount;
    Property BoMNonProductsubnodePostingAccount:String read fsBoMNonProductsubnodePostingAccount write setBoMNonProductsubnodePostingAccount;
    Property GanttChartDrawStyle:Integer read fiGanttChartDrawStyle write setGanttChartDrawStyle;
    (*Property InventoryAssetBOMNonInvCogsAccount :String read fsInventoryAssetBOMNonInvCogsAccount write setInventoryAssetBOMNonInvCogsAccount;*)

    Property GanttChartGFStartColour:Integer read fiGanttChartGFStartColour write setGanttChartGFStartColour;
    Property GanttChartGFEndcolour:Integer read fiGanttChartGFEndcolour write setGanttChartGFEndcolour;
    Property ProductStatusPartQtyColour :Integer read fiProductStatusPartQtyColour write setProductStatusPartQtyColour;
    Property ProductStatusTransQtyColour :Integer read fiProductStatusTransQtyColour write setProductStatusTransQtyColour;
    Property ProductStatusOrderQtyColour :Integer read fiProductStatusOrderQtyColour write setProductStatusOrderQtyColour;
    Property ProductStatusETAWithinPeriodColour :Integer read fiProductStatusETAWithinPeriodColour write setProductStatusETAWithinPeriodColour;
    Property ProductStatusETAExceededColour :Integer read fiProductStatusETAExceededColour write setProductStatusETAExceededColour;

    Property GanttChartGFStartColourIntensity:Integer read fiGanttChartGFStartColourIntensity write setGanttChartGFStartColourIntensity;
    Property GanttChartGFEndColourIntensity:Integer read fiGanttChartGFEndColourIntensity write setGanttChartGFEndColourIntensity;
    Property ProductStatusPartQtyColourIntensity:Integer read fiProductStatusPartQtyColourIntensity  write setProductStatusPartQtyColourIntensity;
    Property ProductStatusTransQtyColourIntensity:Integer read fiProductStatusTransQtyColourIntensity  write setProductStatusTransQtyColourIntensity;
    Property ProductStatusOrderQtyColourIntensity:Integer read fiProductStatusOrderQtyColourIntensity  write setProductStatusOrderQtyColourIntensity;
    Property ProductStatusETAWithinPeriodColourIntensity:Integer read fiProductStatusETAWithinPeriodColourIntensity  write setProductStatusETAWithinPeriodColourIntensity;
    Property ProductStatusETAExceededColourIntensity:Integer read fiProductStatusETAExceededColourIntensity  write setProductStatusETAExceededColourIntensity;

    property UseFld7AsSteelWeight : boolean read fbUseFld7AsSteelWeight write SetUseFld7AsSteelWeight;
    property UpdateProductDescriptionFromTreeInfo : boolean read fbUpdateProductDescriptionFromTreeInfo write SetUpdateProductDescriptionFromTreeInfo;
    property UpdateSalesDescriptionFromTreeInfo : boolean read fbUpdateSalesDescriptionFromTreeInfo write SetUpdateSalesDescriptionFromTreeInfo;
    property BOMPriceOverridesAllOtherPrice : boolean read fbBOMPriceOverridesAllOtherPrice write SetBOMPriceOverridesAllOtherPrice;
    property IgnoreBOMCalcPriceOnSale : boolean read fbIgnoreBOMCalcPriceOnSale write SetIgnoreBOMCalcPriceOnSale;
    property SubBOMUseAvailableQtyFromStock : boolean read fbSubBOMUseAvailableQtyFromStock write SetSubBOMUseAvailableQtyFromStock;
    property CSPOverridesRawMaterialPrices : boolean read fbCSPOverridesRawMaterialPrices write SetCSPOverridesRawMaterialPrices;

    property RoundBatchQtyinProgressBatchCreator : boolean read fbRoundBatchQtyinProgressBatchCreator write SetRoundBatchQtyinProgressBatchCreator;
    property UseCurrentCostforProgressBuild: boolean  read FUseCurrentCostforProgressBuild write SetUseCurrentCostforProgressBuild;
    property AutoAllocateProcessForTreeRoot: boolean  read getAutoAllocateProcessForTreeRoot write SetAutoAllocateProcessForTreeRoot;
    property ConfirmQtysOnfinalise: boolean  read getConfirmQtysOnfinalise write SetConfirmQtysOnfinalise;
    Property DefaultProcessforTree:String read fsDefaultProcessforTree write setDefaultProcessforTree;
    Property DefaultProcessforTreeID:Integer read getDefaultProcessforTreeID;
    Property DefaultTreeProcessDuration:Double read fdDefaultTreeProcessDuration write setDefaultTreeProcessDuration;
    property OnPPGErrorSendEmail: boolean  read getOnPPGErrorSendEmail write SetOnPPGErrorSendEmail;
    Property PPErrorEmailTo:String read fsPPErrorEmailTo write setPPErrorEmailTo;
    Property BuildDetailsUpdateOption:String read fsBuildDetailsUpdateOption write setBuildDetailsUpdateOption;
    Property BOMDetailsReplacesProductDescriptionMemo :Boolean read getBOMDetailsReplacesProductDescriptionMemo;
    Property BOMDetailsAppendsProductDescriptionMemo :Boolean read getBOMDetailsAppendsProductDescriptionMemo;
    Property IgnoreBOMDetailsUpdateonSales : Boolean read getIgnoreBOMDetailsUpdateonSales;
    Property PPErrorEmailToEmail:String read getPPErrorEmailToEmail ;




  end;

  function ProcPrefs: TBusObjProcPrefs;

implementation

uses
  Forms, AppEnvironment, tcDataUtils;

var
  ProcPrefsInst: TBusObjProcPrefs;


function ProcPrefs: TBusObjProcPrefs;
begin
  if not Assigned(ProcPrefsInst) then begin
    ProcPrefsInst:= TBusObjProcPrefs.Create(Application);
    ProcPrefsInst.IgnoreAccesslevel:= true;
    ProcPrefsInst.Load;
  end;
  result:= ProcPrefsInst;
end;


{ TBusObjProcPrefs }

constructor TBusObjProcPrefs.Create(AOwner: TComponent);
begin
  inherited;
  ObjTableName:= 'tbldbPreferences';
  ObjIdFieldName:= '';
  ObjTypeFieldName:= 'PrefType';
  ObjPropNameFieldName:= 'Name';
  ObjPropTypeFieldName:= 'FieldType';
  ObjPropSizeFieldName:= 'FieldSize';
  ObjPropValueFieldName:= 'FieldValue';
  ObjPropDefaultValueFieldName:= 'DefaultValue';

  {set defaults}
  FResourceAvailableForHolidays:= true;
  WarnTemplateProcessesNotDefined:= true;
  AutoScheduleBasedonBOMEmpRoster:= true;
  //WastageCalculationEnabled:= true;
  WarnTemplateOptionDefaultNotDefined:= true;
  fScheduleProductionOnWeekendDays := False;
  FCapacityPlanningWeeksToShow:= 2;
  FAutoProdPlanSchedGraceDays:= 1;
  FAutoProdPlanSchedType:= psForward;
  fProdPlanConfirmSave:= false;
  fShowAllEmployeesinProductionScheduler:= false;
  fCapacityplannerSelectionOptionBeforeLoad:= false;
  fOpenTreeFromSalesOrder:= false;
  fManufacturePartSourceStock := False;
  fManufacturePartSourceStockconfirm := false;
  fbAutoCreateSmartOrderFromSalesOrderTree :=False;
  fbCopyTreeInfotoSalesDesc :=False;
  fbPrintOnItemProgress :=False;
  fbPrintOnItemcompletion :=False;
  fbOpenTreeOnSmartOrdercreation :=False;
  fbResetSaleDateWhenBuilt :=False;
  fbDefaultCoupenTimeinWOTimesheet :=False;
  fbHideSelectedSubnodesinReport:= False;
  fbAutoclockOnemployeeOnjob:= False;
  fbCompleteBOMOrderOnSave:= False;
  fbOnlyshowScheduledJobsForBarCodeMan:= False;
  UseCurrentCostforProgressBuild:= true;
  AutoAllocateProcessForTreeRoot:= true;
  OnPPGErrorSendEmail:= true;
  ConfirmQtysOnfinalise:= true;
  (*fiNonInvProductcostinBOM1 := 1;
  fiNonInvProductcostinBOM1 := 2;*)
  fiGanttChartBarHeight := 33;
  fiCostDecimalPlacesinTree := 0;
  fiPPGBalanceAdjAccountID := 0;
  fiPPGBalanceAdjEmployeeID := 0;
  fsDefaultBOMWastageAccount := '';
  fsBoMNonProductsubnodePostingAccount := '';
  fiGanttChartDrawStyle:= 2;
  (*fsInventoryAssetBOMNonInvCogsAccount := '';*)
  fiGanttChartGFStartColour := 65535;
  fiGanttChartGFEndcolour:= 255;
  fiProductStatusPartQtyColour:= 255;
  fiProductStatusTransQtyColour:= 255;
  fiProductStatusOrderQtyColour:= 255;
  fiProductStatusETAWithinPeriodColour:= 255;
  fiProductStatusETAExceededColour:= 255;

  fiGanttChartGFStartColourIntensity:= 175;
  fiGanttChartGFEndColourIntensity:= 175;
  fiProductStatusPartQtyColourIntensity:= 175;
  fiProductStatusTransQtyColourIntensity:= 175;
  fiProductStatusOrderQtyColourIntensity:= 175;
  fiProductStatusETAWithinPeriodColourIntensity:= 175;
  fiProductStatusETAExceededColourIntensity:= 175;
  fsDefaultProcessforTree := '';
  fdDefaultTreeProcessDuration := 0;
  fsPPErrorEmailTo := '';
  fsBuildDetailsUpdateOption := '';

end;

destructor TBusObjProcPrefs.Destroy;
begin

  inherited;
end;

function TBusObjProcPrefs.getAutoAllocateProcessForTreeRoot: boolean;
begin
  REsult := fAutoAllocateProcessForTreeRoot;
  if result then
    Result := (DefaultProcessforTree<> '') and (DefaultTreeProcessDuration <> 0)
end;
function TBusObjProcPrefs.getOnPPGErrorSendEmail: boolean;
begin
  REsult := fOnPPGErrorSendEmail;
  if result then
    Result := (PPErrorEmailTo<> '') ;
end;
function TBusObjProcPrefs.getPPErrorEmailToEmail: String;
begin
  REsult := '';
  if not OnPPGErrorSendEmail then exit;
  if PPErrorEmailTo = '' then exit;
  REsult := tcdatautils.getEmployeeEmail(PPErrorEmailTo);
end;

function TBusObjProcPrefs.getConfirmQtysOnfinalise: boolean;
begin
  REsult := fConfirmQtysOnfinalise;
end;

function TBusObjProcPrefs.getCostDecimalPlacesinTree: Integer;
begin
  REsult := fiCostDecimalPlacesinTree;
  if result =0 then result := appenv.RegionalOptions.DecimalPlaces;
end;
function TBusObjProcPrefs.getPPGBalanceAdjAccountID: Integer;
begin
  REsult := fiPPGBalanceAdjAccountID;
  if result =0 then result := appenv.RegionalOptions.DecimalPlaces;
end;
function TBusObjProcPrefs.getPPGBalanceAdjEmployeeID: Integer;
begin
  REsult := fiPPGBalanceAdjEmployeeID;
  if result =0 then result := appenv.RegionalOptions.DecimalPlaces;
end;
function TBusObjProcPrefs.getDefaultProcessforTreeID: Integer;
begin
  result := getProcessStep(DefaultProcessforTree);
end;

function TBusObjProcPrefs.Save: Boolean;
begin
  Result := Inherited;
end;

procedure TBusObjProcPrefs.SetAllocationWarningDays(const Value: integer);
begin
  if FAllocationWarningDays <> Value then begin
    FAllocationWarningDays := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetAutoProdPlanSchedGraceDays(
  const Value: integer);
begin
  if FAutoProdPlanSchedGraceDays <> Value then begin
    FAutoProdPlanSchedGraceDays := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetAutoProdPlanSchedType(
  const Value: TAutoProdPlanSchedType);
begin
  if FAutoProdPlanSchedType <> Value then begin
    FAutoProdPlanSchedType := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetCapacityPlanningWeeksToShow(
  const Value: integer);
begin
  if fCapacityPlanningWeeksToShow <> Value then begin
    FCapacityPlanningWeeksToShow := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.setManufacturePartSourceStock(
  const Value: Boolean);
begin
  if fManufacturePartSourceStock <> Value then begin
    fManufacturePartSourceStock := Value;
    MakeDirty;
  end;
end;


procedure TBusObjProcPrefs.setAutoCreateSmartOrderFromSalesOrderTree(const Value: Boolean);
begin

  if fbAutoCreateSmartOrderFromSalesOrderTree <> Value then begin
    fbAutoCreateSmartOrderFromSalesOrderTree := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setCopyTreeInfotoSalesDesc(const Value: Boolean);
begin

  if fbCopyTreeInfotoSalesDesc <> Value then begin
    fbCopyTreeInfotoSalesDesc := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setPrintOnItemProgress(const Value: Boolean);
begin

  if fbPrintOnItemProgress <> Value then begin
    fbPrintOnItemProgress := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setPrintOnItemcompletion(const Value: Boolean);
begin

  if fbPrintOnItemcompletion <> Value then begin
    fbPrintOnItemcompletion := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setHideSelectedSubnodesinReport(const Value: Boolean);
begin

  if fbHideSelectedSubnodesinReport <> Value then begin
    fbHideSelectedSubnodesinReport := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setAutoclockOnemployeeOnjob(const Value: Boolean);
begin

  if fbAutoclockOnemployeeOnjob <> Value then begin
    fbAutoclockOnemployeeOnjob := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setCompleteBOMOrderOnSave(const Value: Boolean);
begin

  if fbCompleteBOMOrderOnSave <> Value then begin
    fbCompleteBOMOrderOnSave := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.setOpenTreeOnSmartOrdercreation(const Value: Boolean);
begin

  if fbOpenTreeOnSmartOrdercreation <> Value then begin
    fbOpenTreeOnSmartOrdercreation := Value;
    MakeDirty;
  end;

end;
procedure TBusObjProcPrefs.setResetSaleDateWhenBuilt(const Value: Boolean);
begin

  if fbResetSaleDateWhenBuilt <> Value then begin
    fbResetSaleDateWhenBuilt := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.setDefaultCoupenTimeinWOTimesheet(const Value: Boolean);
begin

  if fbDefaultCoupenTimeinWOTimesheet <> Value then begin
    fbDefaultCoupenTimeinWOTimesheet := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.setManufacturePartSourceStockconfirm(
  const Value: Boolean);
begin

  if fManufacturePartSourceStockconfirm <> Value then begin
    fManufacturePartSourceStockconfirm := Value;
    MakeDirty;
  end;

end;

procedure TBusObjProcPrefs.SetProdPlanConfirmSave(const Value: boolean);
begin
  if fProdPlanConfirmSave <> Value then begin
    fProdPlanConfirmSave := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetShowAllEmployeesinProductionScheduler(const Value: boolean);
begin
  if fShowAllEmployeesinProductionScheduler <> Value then begin
    fShowAllEmployeesinProductionScheduler := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetUseFld7AsSteelWeight(const Value: boolean);
begin
  if fbUseFld7AsSteelWeight <> Value then
  begin
    fbUseFld7AsSteelWeight := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetUpdateProductDescriptionFromTreeInfo(const Value: boolean);
begin
  if fbUpdateProductDescriptionFromTreeInfo <> Value then
  begin
    fbUpdateProductDescriptionFromTreeInfo := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetUpdateSalesDescriptionFromTreeInfo(const Value: boolean);
begin
  if fbUpdateSalesDescriptionFromTreeInfo <> Value then
  begin
    fbUpdateSalesDescriptionFromTreeInfo := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetBOMPriceOverridesAllOtherPrice(const Value: boolean);
begin
  if fbBOMPriceOverridesAllOtherPrice <> Value then
  begin
    fbBOMPriceOverridesAllOtherPrice := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetIgnoreBOMCalcPriceOnSale(const Value: boolean);
begin
  if fbIgnoreBOMCalcPriceOnSale <> Value then
  begin
    fbIgnoreBOMCalcPriceOnSale := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetSubBOMUseAvailableQtyFromStock(const Value: boolean);
begin
  if fbSubBOMUseAvailableQtyFromStock <> Value then
  begin
    fbSubBOMUseAvailableQtyFromStock := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetCSPOverridesRawMaterialPrices(const Value: boolean);
begin
  if fbCSPOverridesRawMaterialPrices <> Value then
  begin
    fbCSPOverridesRawMaterialPrices := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetCapacityplannerSelectionOptionBeforeLoad(const Value: boolean);
begin
  if fCapacityplannerSelectionOptionBeforeLoad <> Value then begin
    fCapacityplannerSelectionOptionBeforeLoad := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.SetOpenTreeFromSalesOrder(const Value: boolean);
begin
  if fOpenTreeFromSalesOrder <> Value then begin
    fOpenTreeFromSalesOrder := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetResourceAvailableForHolidays(
  const Value: boolean);
begin
  if FResourceAvailableForHolidays <> Value then begin
    FResourceAvailableForHolidays := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetRoundBatchQtyinProgressBatchCreator(const Value: boolean);
begin
  if fbRoundBatchQtyinProgressBatchCreator <> Value then
  begin
    fbRoundBatchQtyinProgressBatchCreator := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcPrefs.SetScheduleProductionOnWeekendDays(
  const Value: boolean);
begin
  if FScheduleProductionOnWeekendDays <> Value then begin
    FScheduleProductionOnWeekendDays := Value;
    MakeDirty;
  end;
end;


procedure TBusObjProcPrefs.SetWarnTemplateOptionDefaultNotDefined(
  const Value: boolean);
begin
  if FWarnTemplateOptionDefaultNotDefined <> Value then begin
    FWarnTemplateOptionDefaultNotDefined := Value;
    MakeDirty;
  end;
end;
procedure TBusObjProcPrefs.setOnlyshowScheduledJobsForBarCodeMan(const Value: Boolean);begin if fbOnlyshowScheduledJobsForBarCodeMan  <> Value then begin fbOnlyshowScheduledJobsForBarCodeMan:= Value;    MakeDirty;  end;end;
procedure TBusObjProcPrefs.SetWarnTemplateProcessesNotDefined   (const Value: boolean);begin if FWarnTemplateProcessesNotDefined      <> Value then begin FWarnTemplateProcessesNotDefined    := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetUseCurrentCostforProgressBuild    (const Value: boolean);begin if FUseCurrentCostforProgressBuild       <> Value then begin FUseCurrentCostforProgressBuild     := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetAutoAllocateProcessForTreeRoot    (const Value: boolean);begin if FAutoAllocateProcessForTreeRoot       <> Value then begin FAutoAllocateProcessForTreeRoot     := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetOnPPGErrorSendEmail               (const Value: boolean);begin if FOnPPGErrorSendEmail                  <> Value then begin FOnPPGErrorSendEmail                := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetConfirmQtysOnfinalise             (const Value: boolean);begin if FConfirmQtysOnfinalise                <> Value then begin FConfirmQtysOnfinalise              := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetAutoScheduleBasedonBOMEmpRoster   (const Value: boolean);begin if FAutoScheduleBasedonBOMEmpRoster      <> Value then begin FAutoScheduleBasedonBOMEmpRoster    := Value; MakeDirty; end;end;
//procedure TBusObjProcPrefs.SetWastageCalculationEnabled         (const Value: boolean);begin if FWastageCalculationEnabled          <> Value then begin FWastageCalculationEnabled          := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetGanttChartBarHeight               (Const Value:Integer); begin if fiGanttChartBarHeight                 <> Value then begin fiGanttChartBarHeight               := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetCostDecimalPlacesinTree           (Const Value:Integer); begin if fiCostDecimalPlacesinTree             <> Value then begin fiCostDecimalPlacesinTree           := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetPPGBalanceAdjAccountID            (Const Value:Integer); begin if fiPPGBalanceAdjAccountID              <> Value then begin fiPPGBalanceAdjAccountID            := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetPPGBalanceAdjEmployeeID           (Const Value:Integer); begin if fiPPGBalanceAdjEmployeeID             <> Value then begin fiPPGBalanceAdjEmployeeID           := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetDefaultTreeProcessDuration        (Const Value:Double  ); begin if fdDefaultTreeProcessDuration         <> Value then begin fdDefaultTreeProcessDuration        := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetDefaultBOMWastageAccount          (Const Value:String ); begin if fsDefaultBOMWastageAccount            <> Value then begin fsDefaultBOMWastageAccount          := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetBoMNonProductsubnodePostingAccount(Const Value:String ); begin if fsBoMNonProductsubnodePostingAccount  <> Value then begin fsBoMNonProductsubnodePostingAccount:= Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetGanttChartDrawStyle               (Const Value:Integer); begin if fiGanttChartDrawStyle                 <> Value then begin fiGanttChartDrawStyle               := Value; MakeDirty; end;end;
(*Procedure TBusObjProcPrefs.SetInventoryAssetBOMNonInvCogsAccount(const Value:String);  begin if fsInventoryAssetBOMNonInvCogsAccount<> Value then begin fsInventoryAssetBOMNonInvCogsAccount:= Value;Makedirty; end;end;*)
procedure TBusObjProcPrefs.SetGanttChartGFStartColour           (Const Value:Integer); begin if fiGanttChartGFStartColour             <> Value then begin fiGanttChartGFStartColour           := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetGanttChartGFEndcolour             (Const Value:Integer); begin if fiGanttChartGFEndcolour               <> Value then begin fiGanttChartGFEndcolour             := Value; MakeDirty; end;end;
(*Procedure TBusObjProcPrefs.setNonInvProductcostinBOM1           (const Value:Integer); begin if fiNonInvProductcostinBOM1           <> value then begin fiNonInvProductcostinBOM1           := Value; MakeDirty;  end;end;
Procedure TBusObjProcPrefs.setNonInvProductcostinBOM2           (const Value:Integer); begin if fiNonInvProductcostinBOM2             <> value then begin fiNonInvProductcostinBOM2           := Value; MakeDirty;  end;end;
Procedure TBusObjProcPrefs.setNonInvProductcostinBOM3           (const Value:Integer); begin if fiNonInvProductcostinBOM3             <> value then begin fiNonInvProductcostinBOM3           := Value; MakeDirty; end;end;*)
procedure TBusObjProcPrefs.SetProductStatusPartQtyColour        (Const Value:Integer); begin if fiProductStatusPartQtyColour          <> Value then begin fiProductStatusPartQtyColour        := Value; MakeDirty; end; end;
procedure TBusObjProcPrefs.SetProductStatusTransQtyColour       (Const Value:Integer); begin if fiProductStatusTransQtyColour         <> Value then begin fiProductStatusTransQtyColour       := Value; MakeDirty; end; end;
procedure TBusObjProcPrefs.SetProductStatusOrderQtyColour       (Const Value:Integer); begin if fiProductStatusOrderQtyColour         <> Value then begin fiProductStatusOrderQtyColour       := Value; MakeDirty; end; end;
procedure TBusObjProcPrefs.SetProductStatusETAExceededColour    (Const Value:Integer); begin if fiProductStatusETAExceededColour      <> Value then begin fiProductStatusETAExceededColour    := Value; MakeDirty; end; end;
procedure TBusObjProcPrefs.SetGanttChartGFEndColourIntensity    (Const Value:Integer); begin if fiGanttChartGFEndColourIntensity      <> Value then begin fiGanttChartGFEndColourIntensity    := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetGanttChartGFStartColourIntensity            (Const Value:Integer); begin if fiGanttChartGFStartColourIntensity            <> Value then begin fiGanttChartGFStartColourIntensity            := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetProductStatusETAWithinPeriodColour          (Const Value:Integer); begin if fiProductStatusETAWithinPeriodColour          <> Value then begin fiProductStatusETAWithinPeriodColour          := Value; MakeDirty; end; end;
procedure TBusObjProcPrefs.SetProductStatusPartQtyColourIntensity         (Const  Value:Integer);begin if fiProductStatusPartQtyColourIntensity         <> Value then begin fiProductStatusPartQtyColourIntensity         := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetProductStatusTransQtyColourIntensity        (Const  Value:Integer);begin if fiProductStatusTransQtyColourIntensity        <> Value then begin fiProductStatusTransQtyColourIntensity        := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetProductStatusOrderQtyColourIntensity        (Const  Value:Integer);begin if fiProductStatusOrderQtyColourIntensity        <> Value then begin fiProductStatusOrderQtyColourIntensity        := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetProductStatusETAWithinPeriodColourIntensity (Const  Value:Integer);begin if fiProductStatusETAWithinPeriodColourIntensity <> Value then begin fiProductStatusETAWithinPeriodColourIntensity := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetProductStatusETAExceededColourIntensity     (Const  Value:Integer);begin if fiProductStatusETAExceededColourIntensity     <> Value then begin fiProductStatusETAExceededColourIntensity     := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetDefaultProcessforTree                       (Const  Value:String );begin if fsDefaultProcessforTree                       <> Value then begin fsDefaultProcessforTree      := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetPPErrorEmailTo                              (Const  Value:String );begin if fsPPErrorEmailTo                              <> Value then begin fsPPErrorEmailTo             := Value; MakeDirty; end;end;
procedure TBusObjProcPrefs.SetBuildDetailsUpdateOption                    (Const  Value:String );begin if fsBuildDetailsUpdateOption                    <> Value then begin fsBuildDetailsUpdateOption   := Value; MakeDirty; end;end;
function TBusObjProcPrefs.getBOMDetailsAppendsProductDescriptionMemo  : Boolean;begin  result := BuildDetailsUpdateOption ='A';end;
function TBusObjProcPrefs.getBOMDetailsReplacesProductDescriptionMemo : Boolean;begin  result := BuildDetailsUpdateOption ='R';end;
function TBusObjProcPrefs.getIgnoreBOMDetailsUpdateonSales            : Boolean;begin  result := (BuildDetailsUpdateOption <>'R') and (BuildDetailsUpdateOption <>'A');end;
end.
