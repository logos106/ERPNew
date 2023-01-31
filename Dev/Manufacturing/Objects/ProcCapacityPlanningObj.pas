unit ProcCapacityPlanningObj;
{$I ERP.inc}
{$IFDEF DevMode}
  {$M+}
{$ENDIF}
interface

uses
  Contnrs, IntegerListObj, MyAccess,ERPdbComponents, BusObjSales,
  BusObjProcessTimeNDS, BusObjNDSBase, ProcessUtils,
  UserLockObj;

type
  TSlots = Record
    ResourceID          : Integer;
    ResourceDetailID    : Integer;
    EmpResProcScheduleID: Integer;
    EmployeeID          : Integer;
    TimeStart           : TDatetime;
    TimeTo              : TDateTime;
    Allocated           : Integer;
    Status              : String;
    SaleLineID          : Integer;
  End;
  TColRec = class(TObject)
  private
    Function InsertSlot(SlotIndex:Integer; InsertBefore:Boolean):Integer;
    function CapacitySeconds: Integer;
    function AllocatedSeconds: Integer;
  public
    Id        : integer;
    Date      : TDateTime;
    Allocated : double;
    Slots     : Array of TSlots;
    Function Capacity  : double;
    function Available: double;
    Constructor Create;
    Function AvailableSeconds :Integer;
    Function CommaText:String;
    Function PropertyNames:String;
    Procedure ClearUnAvailables;
    Procedure Allocate(SlotIndex:Integer;Starttime:TDateTime;aDuration,aSaleLineId :Integer; aStatus:String ='');
    Function FindSlot(fdStarttime:TDateTime;aDuration :Integer; var AvailableDuration :Integer):Integer;
    Procedure SplitSlot(SlotIndex:Integer; SplitTime :TDatetime);
    Procedure NewSlot(Starttime:TDateTime;
                      aResourceID:Integer;
                      aResourceDetailID:Integer;
                      aEmpResProcScheduleID:Integer;
                      aEmployeeId:Integer;
                      aTimeStart:TDatetime;
                      aTimeTo:TDateTime;
                      aAllocated :Integer);
  end;

  TSchedList = class(TObject)
  private
    fList: TObjectList;
    fConnection: TERPConnection;
    fResourceIdList: TIntegerList;
    function GetCount: integer;
    function GetItem(const index: integer): TColRec;
    function GetConnection: TERPConnection;
    procedure SetConnection(const Value: TERPConnection);
    function GetResourceIdList: TIntegerList;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TColRec read GetItem; default;
    procedure Clear;
    function LoadResAvailability(const aDate: TDateTime;const  ProcResourceId: integer;
                             const CreateIfNotFound: boolean = true; Reschedling:Boolean =False): TColRec;
    property Connection: TERPConnection read GetConnection write SetConnection;
    procedure PopulateForDateRange(const aDateFrom, aDateTo: TDateTime);
    procedure SummaryForDate(const aDate: TDateTime; const ResourceIdList: TIntegerList;
                             var Capacity, Available,Overallocated: double);
    function ResourceCapacityFordate(const aDate: TDateTime; aResID:Integer):double;
    function AvailableForDate(const aDate: TDateTime; const aResourceId: integer): double;
    procedure AdjustForDate(const aDate: TDateTime; const aResourceId: integer; const aValue: double);
    property ResourceIdList: TIntegerList read GetResourceIdList;
    Procedure CopySchedList(var cleanSchedList : TSchedList);
    Function Listdata:String;
    Procedure ClearUnAvailables;
    procedure LogList(aID:Integer=0; adate:TDateTime =0);

  end;

  TProcItem = class;

  TProcTimeList = class(TObject)
  private
    fList: TObjectList;
    fProcItem: TProcItem;
    function GetCount: integer;
    function GetDirty: boolean;
    function GetItem(const index: integer): TProcessTimeNDS;
    function GetItembyProcTimeID(const fProcTimeID: integer): TProcessTimeNDS;

    function ProcesstimeIDs: String;
  public
    Constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TProcessTimeNDS read GetItem; default;
    property ItembyProcTimeID[const index: integer]: TProcessTimeNDS read GetItembyProcTimeID;
    Procedure DeleteItem(const index: integer);
    procedure Clear;
    property Dirty: boolean read GetDirty;
    procedure Save;
    procedure Add(const aItem: TProcessTimeNDS);
    property ProcItem: TProcItem read fProcItem write fProcItem;
    function TotalScheduled: double;
    function TotalUnScheduled: double;
    function SchedTimeForDate(const aDate: TDateTime): double;
    Function Schedule(const OldDate, NewDate: TDateTime; const aDuration: double; const aDetailID:Integer; const aEmpID:Integer):TProcessTimeNDS;
    procedure Unschedule(const aId: integer);
    procedure UpdateProcItem(CreatenewifNotfound:boolean =True);
  end;




  TProcItemList = class;
  TProcItem = class(TObject)
  private
    FDirty: boolean;
    FSaleLineQuantity: double;
    FProcTreeTotalQty: double;
    FProcessDuration: double;
    FProcesSetupDuration: double;
    FProcesBreakDownDuration: double;
    FSingleDuration: double;
    FProcessPartId: integer;
    FSaleId: integer;
    FSaleLineId: integer;
    fClassID:Integer;
    FProcTreeId: integer;
    fParentProcTreeId:Integer;
    FProcTreeCaption: string;
    FSaleLineProductName: string;
    FSaleCustomerName: string;
    FProcessDesc: string;
    FSaleDocNumber: string;
    FSaleShipDate: TDateTime;
    FSaleLineShipDate: TDateTime;
    FProcessTimeStart: TDateTime;
    FProcessStatus: TProcessPartStatus;
    FProcessSequence: integer;
    FProcessStepId: integer;
    FTreeRootId: integer;
    FProcTreePartId: integer;
    FProcTreePartUom: string;
    FProcTreeDescription: string;
    FSaleLineProductDescription: string;
    FProcTreePartType: string;
    fProcTimeList: TProcTimeList;
    fItemList: TProcItemList;
    FProcessResourceId: integer;
    FProcTreeLevel: integer;
    FProcTreeSequenceDown: integer;
    FProcTreeComplete: boolean;
    fsGoodsOnOrderStatus: String;
    fdScheduleStart: TDateTime;
    fdManufacturingUnits: double;
    FBuildingBlockQty: double;
    procedure SetDirty(const Value: boolean);
    procedure SetProcessDesc(const Value: string);
    procedure SetProcessDuration(const Value: double);
    procedure SetProcesSetupDuration(const Value: double);
    procedure SetProcesBreakDownDuration(const Value: double);
    procedure SetSingleDuration(const Value: double);
    procedure SetProcessPartId(const Value: integer);
    procedure SetProcessStatus(const Value: TProcessPartStatus);
    procedure SetProcessTimeStart(const Value: TDateTime);
    procedure SetProcTreeCaption(const Value: string);
    procedure SetProcTreeId(const Value: integer);
    procedure SetProcTreeTotalQty(const Value: double);
    procedure SetSaleCustomerName(const Value: string);
    procedure SetSaleDocNumber(const Value: string);
    procedure SetSaleId(const Value: integer);
    procedure SetSaleLineId(const Value: integer);
    Procedure SetClassID(Const Value:Integer);
    procedure SetSaleLineProductName(const Value: string);
    procedure SetSaleLineQuantity(const Value: double);
    procedure SetSaleLineShipDate(const Value: TDateTime);
    procedure SetSaleShipDate(const Value: TDateTime);
    procedure SetProcessSequence(const Value: integer);
    procedure SetProcessStepId(const Value: integer);
    procedure SetTreeRootId(const Value: integer);
    procedure SetProcTreePartUom(const Value: string);
    procedure SetProcTreePartId(const Value: integer);
    procedure SetProcTreeDescription(const Value: string);
    procedure SetSaleLineProductDescription(const Value: string);
    procedure SetProcTreePartType(const Value: string);
    procedure SetProcessResourceId(const Value: integer);
    function GetDirty: boolean;
    procedure SetProcTreeLevel(const Value: integer);
    procedure SetProcTreeSequenceDown(const Value: integer);
    function GetCommaText: string;
    Function GetPropertynames:String;
    procedure SetProcTreeComplete(const Value: boolean);
    procedure setGoodsOnOrderStatus(const Value: String);
    procedure SetParentProcTreeId(const Value: Integer);
    function getSelected: boolean;
    procedure setManufacturingUnits(const Value: double);
    procedure SetBuildingBlockQty(const Value: double);
    function getBuildingBlockQty: double;
  Protected
      function GetProcTimeList: TProcTimeList;Virtual;
  public
    destructor Destroy; override;
    property CommaText: string read GetCommaText;
    property Propertynames: string read GetPropertynames;
    function IsRoot: boolean;
    function ProcessOverdue: boolean;
  {$IFDEF DevMode}
  Published
   {$ENDIF}
    property SaleId: integer read FSaleId write SetSaleId;
    property SaleLineId: integer read FSaleLineId write SetSaleLineId;
    Property ClassID :Integer read fClassID write setClassID;
    property ProcTreeId: integer read FProcTreeId write SetProcTreeId;
    Property ParentProcTreeId :Integer read fParentProcTreeId write SetParentProcTreeId;
    property TreeRootId: integer read FTreeRootId write SetTreeRootId;
    property ProcessPartId: integer read FProcessPartId write SetProcessPartId; {tblProcessPart.Id}
    property SaleDocNumber: string read FSaleDocNumber write SetSaleDocNumber;
    property SaleCustomerName: string read FSaleCustomerName write SetSaleCustomerName;
    property SaleShipDate: TDateTime read FSaleShipDate write SetSaleShipDate;
    property SaleLineProductName: string read FSaleLineProductName write SetSaleLineProductName;
    property SaleLineProductDescription: string read FSaleLineProductDescription write SetSaleLineProductDescription;
    property SaleLineQuantity: double read FSaleLineQuantity write SetSaleLineQuantity;
    property SaleLineShipDate: TDateTime read FSaleLineShipDate write SetSaleLineShipDate;
    property ProcTreePartId: integer read FProcTreePartId write SetProcTreePartId;
    property ProcTreePartUom: string read FProcTreePartUom write SetProcTreePartUom;
    property ProcTreePartType: string read FProcTreePartType write SetProcTreePartType;
    property ProcTreeTotalQty: double read FProcTreeTotalQty write SetProcTreeTotalQty;
    property ProcTreeCaption: string read FProcTreeCaption write SetProcTreeCaption;
    property ProcTreeDescription: string read FProcTreeDescription write SetProcTreeDescription;
    property ProcTreeLevel: integer read FProcTreeLevel write SetProcTreeLevel;
    property ProcTreeSequenceDown: integer read FProcTreeSequenceDown write SetProcTreeSequenceDown;
    property ProcTreeComplete: boolean read FProcTreeComplete write SetProcTreeComplete;
    property ProcessDesc: string read FProcessDesc write SetProcessDesc;
    property ProcessDuration: double read FProcessDuration write SetProcessDuration;
    property ProcesSetupDuration: double read FProcesSetupDuration write SetProcesSetupDuration;
    property ProcesBreakDownDuration: double read FProcesBreakDownDuration write SetProcesBreakDownDuration;
    property SingleDuration: double read FSingleDuration write SetSingleDuration;
    property ProcessStatus: TProcessPartStatus read FProcessStatus write SetProcessStatus;
    property ProcessTimeStart: TDateTime read FProcessTimeStart write SetProcessTimeStart;
    property ProcessSequence: integer read FProcessSequence write SetProcessSequence;
    property ProcessStepId: integer read FProcessStepId write SetProcessStepId;
    property ProcessResourceId: integer read FProcessResourceId write SetProcessResourceId;
    Property GoodsOnOrderStatus :String read fsGoodsOnOrderStatus write setGoodsOnOrderStatus;
    property Dirty: boolean read GetDirty write SetDirty;
    property ProcTimeList: TProcTimeList read GetProcTimeList;
    property ItemList: TProcItemList read fItemList write fItemList;
    Property selected:boolean read getSelected;
    Property ScheduleStart :TDateTime read fdScheduleStart write fdScheduleStart;
    Property ManufacturingUnits :double read fdManufacturingUnits write setManufacturingUnits;
    property BuildingBlockQty: double read getBuildingBlockQty write SetBuildingBlockQty;
  end;

  TProcItemList = class(TObject)
  private
    fList: TObjectList;
    fSelectStr: string;
    fOrderByStr: string;
    fDateFrom: TDateTime;
    fDateTo: TDateTime;
    fConnection: TERPConnection;
    fProcResourceId: integer;
    fProcessStepIdListStr: string;
    fStorer: TBusObjStorer;
    fSelectedList: TIntegerList;

    function GetCount: integer;
    function GetItem(const index: integer): TProcItem;
    function GetDirty: boolean;
    function UpdateLine(const SalesOrder: TSalesOrder; const RowRec: TProcItem): boolean;
    function GetStorer: TBusObjStorer;
    function GetSelectedList: TIntegerList;
    function GetSelectedItem(const Index: integer): TProcItem;
    function GetItemByTreeId(const aTreeId: integer): TProcItem;
    function getGridhint: String;
    procedure MakeSQL(const ProcessDateFrom, ProcessDateTo: TDateTime; const ProcessStepIdList: TIntegerList; const CustomerName: string = '';forSaleId:Integer=0);
    Function LoadListSQL(LoadNone:Boolean =False):String; overload;
    function getSelected(const Index: integer): Boolean;
    Function CheckForEmpScheduleforSelectedProcesses :Boolean;

  public
    Constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[const index: integer]: TProcItem read GetItem; default;
    property ItemByTreeId[const aTreeId: integer]: TProcItem read GetItemByTreeId;
    procedure Clear;
    procedure LoadList(const ProcessDateFrom, ProcessDateTo: TDateTime; const ProcessStepIdList: TIntegerList; const CustomerName: string = '';forSaleId:Integer=0;LoadNone :Boolean =False); overload;
    procedure LoadList( LoadNone :Boolean =False; updateGoodsOnOrderstatus :Boolean = True); overload;
    Function LoadListSQL(const ProcessDateFrom, ProcessDateTo: TDateTime; const ProcessStepIdList: TIntegerList; const CustomerName: string = '';forSaleId:Integer=0; LoadNone :Boolean =False):String; overload;
    procedure LoadList(const  aSQL: string); overload;
    Procedure addItem(const aItem:TProcItem);
    property Dirty: boolean read GetDirty;
    function Save(var msg: string): boolean;
    property Connection: TERPConnection read fConnection write fConnection;
    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;
    property ProcessStepIdListStr: string read fProcessStepIdListStr write fProcessStepIdListStr;
    property ProcResourceId: integer read fProcResourceId write fProcResourceId;
    property OrderByStr: string read fOrderByStr write fOrderByStr;
    property SelectStr: string read fSelectStr write fSelectStr;
    procedure Reset;
    Procedure CopyTo(dest :TProcItemList);
    property Storer: TBusObjStorer read GetStorer;
    function MaxLevelForSaleLineId(const aSaleLineId: integer): integer;
    property SelectedList: TIntegerList read GetSelectedList;
    property SelectedItem[Const Index: integer]: TProcItem read GetSelectedItem;
    Property Selected[Const Index: integer]: Boolean read getSelected;
    procedure SelectItemsForSalesLine(const aSalesLineId: integer; const UnScheduledOnly: boolean = true);
    function AutoScheduleProduction(var msg: string; var StepCount: integer; StartSchedulingon :TDateTime =0; Reschedling:Boolean = False; CleanList:TProcItemList = nil): boolean;
    procedure SaveToFile(const aFileName: string);
    procedure Delete(const index: integer);
    Property GridHint:String read getGridhint;
    function ChangedProcesstimeIDs: String;
    Procedure SelectAll;
    function commatext:STring;
  end;



  { Automatically schedule production for processes that are currently not scheduled }
  function AutoScheduleProduction(var msg: string; var StepCount: integer; Connection: TERPConnection; UserLock: TUserLock;SaleIDs:String = ''): boolean;
  Function REsourceNameforID(Const aid:Integer):string;
  Procedure LogSlot(const aslot:TSlots);


implementation


uses
  SysUtils, CommonDbLib, BusObjBase, BusObjProcess, ProgressDialog, Dialogs,
  ProcessDataUtils, Commonlib,systemlib, ClassFuncs, Classes,
  BusObjProcessPartNDS, frmProcAutoShedSelect, Controls,BusObjProcPrefs,
  FastFuncs, MySQLConst,
  ManufactureLib, DateUtils, tcConst, BOMLib, DebugLib, tcDataUtils,
  DbSharedObjectsObj, frmMessageBase, AppEnvironment , GraphUtil,
  frmMessageWithList, CommonFormLib, BusObjProcessForScheduling, LogLib,Math;

Procedure LogSlot(const aSlot:TSlots);
begin
    logtext(inttostr(aSlot.ResourceID)+','+
    inttostr(aSlot.ResourceDetailID)+','+
    inttostr(aSlot.EmpResProcScheduleID)+','+
    inttostr(aSlot.EmployeeID)+','+
    FormatdateTime('dd-mm-yy hh:nn:ss am/pm',aSlot.TimeStart)+','+
    FormatdateTime('dd-mm-yy hh:nn:ss am/pm',aSlot.TimeTo)+','+
    inttostr(aSlot.Allocated)+','+
    aSlot.Status+','+
    inttostr(aSlot.SaleLineID), 'i:\temp\to be deleted\erp.log');
end;
  { TColRec }

procedure TColRec.Allocate(SlotIndex:Integer; Starttime: TDateTime;aDuration,aSaleLineID: Integer; aStatus:String ='');
var
  dt1, dt2, dt3 , dt4:TDateTime;
  Slot: TSlots;
  i:Integer;
begin
  Slot := Slots[slotIndex];

  dt1:= StartTime;
  dt2:= incSecond(dt1, aDuration);
  if (Slots[slotIndex].TimeStart = dt1) and (Slots[slotIndex].TimeTo = dt2) then begin
    Slots[slotIndex].Allocated := aDuration;
    if aStatus <> '' then Slots[slotIndex].Status := aStatus;
    Exit;
  end;
  if (Slots[slotIndex].TimeStart = dt1) then begin
    dt1:=Slots[slotIndex].Timeto;
    Slots[slotIndex].Timeto := dt2;
    Slots[slotIndex].Allocated := aDuration;
    Slots[slotIndex].SaleLineId := aSaleLineId;
    i:= InsertSlot(SlotIndex, False);
    if i >=0 then begin
      Slots[i].ResourceID          	    := Slots[slotIndex].ResourceID;
      Slots[i].ResourceDetailID    	    := Slots[slotIndex].ResourceDetailID;
      Slots[i].EmpResProcScheduleID	    := Slots[slotIndex].EmpResProcScheduleID;
      Slots[i].EmployeeID          	    := Slots[slotIndex].EmployeeID;
      Slots[i].TimeStart           	    := dt2;
      Slots[i].TimeTo              	    := dt1;
      Slots[i].Allocated           	    := 0;
      Slots[i].Status              	    := Slots[slotIndex].Status;
    end;
    if aStatus <> '' then Slots[slotIndex].Status := aStatus;
    Exit;
  end;

  if (Slots[slotIndex].TimeTo = dt2) then begin
    dt2:=Slots[slotIndex].TimeStart;
    Slots[slotIndex].TimeStart:= dt1;
    Slots[slotIndex].Allocated := aDuration;
    Slots[slotIndex].SaleLineId := aSaleLineId;
    i:= InsertSlot(SlotIndex, true);
    if i >=0 then begin
      Slots[i].ResourceID          	    := Slots[slotIndex+1].ResourceID;
      Slots[i].ResourceDetailID    	    := Slots[slotIndex+1].ResourceDetailID;
      Slots[i].EmpResProcScheduleID	    := Slots[slotIndex+1].EmpResProcScheduleID;
      Slots[i].EmployeeID          	    := Slots[slotIndex+1].EmployeeID;
      Slots[i].TimeStart           	    := dt2;
      Slots[i].TimeTo              	    := dt1;
      Slots[i].Allocated           	    := 0;
      Slots[i].Status              	    := Slots[slotIndex+1].Status;
    end;
    if aStatus <> '' then Slots[slotIndex+1].Status := aStatus;
    Exit;
  end;
  if (Slots[slotIndex].TimeStart < dt1) and (Slots[slotIndex].TimeTo > dt2) then begin
    dt3 := Slots[slotIndex].TimeStart;
    dt4:= Slots[slotIndex].TimeTo;

    Slots[slotIndex].TimeStart:= dt1;
    Slots[slotIndex].timeto:= dt2;
    Slots[slotIndex].Allocated := aDuration;
    Slots[slotIndex].SaleLineId := aSaleLineId;

    i:= InsertSlot(SlotIndex, true);
    if i >=0 then begin
      Slots[high(Slots)].ResourceID          	    := Slots[slotIndex+1].ResourceID;
      Slots[high(Slots)].ResourceDetailID    	    := Slots[slotIndex+1].ResourceDetailID;
      Slots[high(Slots)].EmpResProcScheduleID	    := Slots[slotIndex+1].EmpResProcScheduleID;
      Slots[high(Slots)].EmployeeID          	    := Slots[slotIndex+1].EmployeeID;
      Slots[high(Slots)].TimeStart           	    := dt3;
      Slots[high(Slots)].TimeTo              	    := dt1;
      Slots[high(Slots)].Allocated           	    := 0;
      Slots[high(Slots)].Status              	    := Slots[slotIndex+1].Status;
    end;

    i:= InsertSlot(SlotIndex, False);
    if i >=0 then begin
      Slots[high(Slots)].ResourceID          	    := Slots[slotIndex].ResourceID;
      Slots[high(Slots)].ResourceDetailID    	    := Slots[slotIndex].ResourceDetailID;
      Slots[high(Slots)].EmpResProcScheduleID	    := Slots[slotIndex].EmpResProcScheduleID;
      Slots[high(Slots)].EmployeeID          	    := Slots[slotIndex].EmployeeID;
      Slots[high(Slots)].TimeStart           	    := dt2;
      Slots[high(Slots)].TimeTo              	    := dt4;
      Slots[high(Slots)].Allocated           	    := 0;
      Slots[high(Slots)].Status              	    := Slots[slotIndex].Status;
    end;
    if aStatus <> '' then Slots[slotIndex].Status := aStatus;
    Exit;
  end;
end;

function TColRec.Available: double;
begin
  Result:= self.Capacity - AllocatedSeconds;
end;

function TColRec.AvailableSeconds: Integer;
var
  ctr:Integer;
begin
  result := 0;
  if length(Slots) =0 then exit;
  for ctr := low(Slots) to high(Slots) do
    if not(Sametext(Slots[ctr].status, 'Un Available')) then
      REsult := result + (secondsbetween(Slots[ctr].TimeStart , Slots[ctr].TimeTo) - Slots[ctr].Allocated);
end;
function TColRec.CapacitySeconds: Integer;
var
  ctr:Integer;
begin
  result := 0;
  if length(Slots) =0 then exit;
  for ctr := low(Slots) to high(Slots) do
    if not(Sametext(Slots[ctr].status, 'Un Available')) then
      REsult := result + (secondsbetween(Slots[ctr].TimeStart , Slots[ctr].TimeTo) );
end;
function TColRec.AllocatedSeconds: Integer;
var
  ctr:Integer;
begin
  result := 0;
  if length(Slots) =0 then exit;
  for ctr := low(Slots) to high(Slots) do
    if not(Sametext(Slots[ctr].status, 'Un Available')) then
      REsult := result +  Slots[ctr].Allocated;
end;

function TColRec.Capacity: double;
begin
  result :=CapacitySeconds;
end;

procedure TColRec.ClearUnAvailables;
var
  ctr:Integer;
begin
  for ctr:= low(Slots) to high(Slots) do begin
    if SameText(slots[ctr].status , 'Un Available') then begin
      slots[ctr].status := '';
      slots[ctr].Allocated := 0;
    end;
  end;
end;

function TColRec.CommaText: String;
var
  x:Integer;
begin
  REsult := '';
  if length(Slots)=0 then begin
    result := inttostr(Id)+',' +formatDateTime('dd-mm-yyyy hh:nn:ss' , Date)+',' +floatToStr(Allocated)+NL;
    exit;
  end;
  for x:= low(slots) to high(Slots) do
      REsult := result +inttostr(Id)+',' +formatDateTime('dd-mm-yyyy hh:nn:ss' , Date)+',' +floatToStr(Allocated)+',' +
                        ProcResName(Slots[x].ResourceID)+',' +
                        ProcResDetName(Slots[x].ResourceDetailID)+',' +
                        inttostr(Slots[x].EmpResProcScheduleID)+',' +
                        getemployeeName(Slots[x].EmployeeID)+',' +
                        formatDateTime('dd-mm-yyyy hh:nn:ss' , Slots[x].TimeStart)+',' +
                        formatDateTime('dd-mm-yyyy hh:nn:ss' , Slots[x].TimeTo)+',' +
                        floatToStr(Slots[x].Allocated)+',' +
                        Slots[x].Status+','+
                        inttostr(Slots[x].SaleLineID)+NL;
end;

constructor TColRec.Create;
begin
  inherited;
  SetLength(Slots,0);
end;

function TColRec.FindSlot(fdStarttime:TDateTime;aDuration: Integer; var AvailableDuration :Integer): Integer;
var
  ctr:Integer;
  aStartTime :TDateTime;
begin
try
  aStartTime :=0;
  result := -1;
  for ctr := low(slots) to high(slots) do begin
    if Slots[ctr].TimeTo <= fdStarttime then
    else if Slots[ctr].TimeStart < fdStarttime then begin
      SplitSlot(ctr ,fdStarttime );
      break;
    end;
  end;
  for ctr := low(slots) to high(slots) do begin
      if not(Sametext(Slots[ctr].status, 'Un Available')) then
        if ((aStartTime  =0 ) or (aStartTime >  slots[ctr].TimeStart)) and
            ((secondsbetween(Slots[ctr].TimeStart , Slots[ctr].TimeTo) - Slots[ctr].Allocated) >=aDuration ) then begin
            if (fdStarttime=0) or (fdStarttime <=Slots[ctr].TimeStart) then begin
              aStartTime :=Slots[ctr].TimeStart ;
              AvailableDuration :=aDuration ;
              result := ctr; break;
            end;
        end;
  end;
  if result >=0 then exit;

  for ctr := low(slots) to high(slots) do begin
    if not(Sametext(Slots[ctr].status, 'Un Available')) then
      if  ((secondsbetween(Slots[ctr].TimeStart , Slots[ctr].TimeTo) - Slots[ctr].Allocated) > 0) then begin
        if (fdStarttime=0) or (fdStarttime <=Slots[ctr].TimeStart) then begin
          AvailableDuration :=secondsbetween(Slots[ctr].TimeStart , Slots[ctr].TimeTo) - Slots[ctr].Allocated;
          result := ctr;
          Exit;
        end;
      end;
  end;
finally
  (*for ctr := low(slots) to high(slots) do
    Logtext(Formatdatetime('dd-mm-yy hh:nn:ss' , Slots[ctr].TimeStart ) +' -  ' + Formatdatetime('dd-mm-yy hh:nn:ss' , Slots[ctr].TimeTo ) +' , ' + Slots[ctr].Status +' , ' + Floattostr(Slots[ctr].Allocated));*)
end;

end;

function TColRec.InsertSlot(SlotIndex:Integer; InsertBefore:Boolean):Integer;
var
  ctr:Integer;
begin
  SetLength(Slots , Length(Slots)+1);

  if InsertBefore then SlotIndex := SlotIndex-1;

  for ctr:=high(Slots)-1 downto  SlotIndex+1 do begin
          Slots[ctr+1].ResourceID          	    := Slots[ctr].ResourceID;
          Slots[ctr+1].ResourceDetailID    	    := Slots[ctr].ResourceDetailID;
          Slots[ctr+1].EmpResProcScheduleID	    := Slots[ctr].EmpResProcScheduleID;
          Slots[ctr+1].EmployeeID          	    := Slots[ctr].EmployeeID;
          Slots[ctr+1].TimeStart           	    := Slots[ctr].TimeStart;
          Slots[ctr+1].TimeTo              	    := Slots[ctr].TimeTo;
          Slots[ctr+1].Allocated           	    := Slots[ctr].Allocated;
          Slots[ctr+1].Status              	    := Slots[ctr].Status;
  end;
          Slots[SlotIndex+1].ResourceID          	    := 0;
          Slots[SlotIndex+1].ResourceDetailID    	    := 0;
          Slots[SlotIndex+1].EmpResProcScheduleID	    := 0;
          Slots[SlotIndex+1].EmployeeID          	    := 0;
          Slots[SlotIndex+1].TimeStart           	    := 0;
          Slots[SlotIndex+1].TimeTo              	    := 0;
          Slots[SlotIndex+1].Allocated           	    := 0;
          Slots[SlotIndex+1].Status              	    := '';
  Result := SlotIndex+1;
end;


procedure TColRec.NewSlot(Starttime:TDateTime; aResourceID, aResourceDetailID,aEmpResProcScheduleID,aEmployeeId: Integer; aTimeStart, aTimeTo: TDateTime;aAllocated :Integer);
begin
  if dateof(aTimeStart) <dateof(aTimeTo) then aTimeTo := Dateof(incday(aTimeStart,1));
  if aAllocated <> 0 then begin
    SetLength(Slots , length(Slots)+1);
    with Slots[high(Slots)] do begin
      ResourceID          := aResourceID;
      ResourceDetailID    := aResourceDetailID;
      EmpResProcScheduleID:= aEmpResProcScheduleID;
      EmployeeID          := aEmployeeId;
      TimeStart           := aTimeStart;
      TimeTo              := aTimeTo;
      Allocated           := aAllocated;
      //logtext('aAllocated <> 0 :' +inttostr(high(Slots))+':' + inttostr(ResourceID)+',' + inttostr(aResourceDetailID) +',' + inttostr(EmpResProcScheduleID) +','+ FormatDateTime('dd-mm-yy hh:nn:ss am/pm' ,timeStart)+'  -  ' + FormatDateTime('dd-mm-yy hh:nn:ss am/pm' ,TimeTo)+'  , '+inttostr(Allocated));
    end;
    Exit;
  end;
  if  aTimeStart < Starttime then begin
    SetLength(Slots , length(Slots)+1);
    with Slots[high(Slots)] do begin
      ResourceID          := aResourceID;
      ResourceDetailID    := aResourceDetailID;
      EmpResProcScheduleID:= aEmpResProcScheduleID;
      EmployeeID          := aEmployeeId;
      TimeStart           := aTimeStart;
      TimeTo              := Starttime;
      Status              := 'Un Available';
      Allocated           := secondsbetween(aTimeStart , Starttime);
      //logtext(formatdatetime('dd:mm:yy hh:nn:ss am/pm', aTimeStart)+' <'+formatdatetime('dd:mm:yy hh:nn:ss am/pm', Starttime)+' :' +inttostr(high(Slots))+':' + inttostr(ResourceID)+',' + inttostr(aResourceDetailID) +',' + inttostr(EmpResProcScheduleID) +','+ FormatDateTime('dd-mm-yy hh:nn:ss am/pm' ,timeStart)+'  -  ' + FormatDateTime('dd-mm-yy hh:nn:ss am/pm' ,TimeTo)+'  , '+inttostr(Allocated));
    end;

    aTimeStart := Starttime;
  end;

  if aTimeStart >=aTimeTo then exit;
  SetLength(Slots , length(Slots)+1);
  with Slots[high(Slots)] do begin
    ResourceID          := aResourceID;
    ResourceDetailID    := aResourceDetailID;
    EmpResProcScheduleID:= aEmpResProcScheduleID;
    EmployeeID          := aEmployeeId;
    TimeStart           := aTimeStart;
    TimeTo              := aTimeTo;
    Allocated           := 0;
    //logtext(formatdatetime('dd:mm:yy hh:nn:ss am/pm', aTimeStart)+' >='+formatdatetime('dd:mm:yy hh:nn:ss am/pm', Starttime)+' :' +inttostr(high(Slots))+':' + inttostr(ResourceID)+',' + inttostr(aResourceDetailID) +',' + inttostr(EmpResProcScheduleID) +','+ FormatDateTime('dd-mm-yy hh:nn:ss am/pm' ,timeStart)+'  -  ' + FormatDateTime('dd-mm-yy hh:nn:ss am/pm' ,TimeTo)+'  , '+inttostr(Allocated));
  end;
end;

function TColRec.PropertyNames: String;
begin
    result := 'ID,Date,Allocated,ResourceID,ResourceDetailID,EmpResProcScheduleID,EmployeeID,TimeStart,TimeTo,Allocated,Status';
end;

procedure TColRec.SplitSlot(SlotIndex: Integer; SplitTime: TDatetime);
begin
  if (SlotIndex < low(slots)) or (SlotIndex > high(slots)) then exit;

  if (secondsbetween(Slots[SlotIndex].TimeStart , Slots[SlotIndex].TimeTo) - Slots[SlotIndex].Allocated) <=0 then exit;

  if (secondsbetween(Slots[SlotIndex].TimeStart ,SplitTime) < Slots[SlotIndex].Allocated)  then SplitTime := incSecond(Slots[SlotIndex].TimeStart , Slots[SlotIndex].Allocated);


  InsertSlot(SlotIndex , False);

  Slots[SlotIndex+1].ResourceID          	    := Slots[Slotindex].ResourceID;
  Slots[SlotIndex+1].ResourceDetailID    	    := Slots[Slotindex].ResourceDetailID;
  Slots[SlotIndex+1].EmpResProcScheduleID	    := Slots[Slotindex].EmpResProcScheduleID;
  Slots[SlotIndex+1].EmployeeID          	    := Slots[Slotindex].EmployeeID;
  Slots[SlotIndex+1].TimeStart           	    := Slots[Slotindex].TimeStart;
  Slots[SlotIndex+1].TimeTo              	    := Slots[Slotindex].TimeTo;
  Slots[SlotIndex+1].Allocated           	    := 0;
  Slots[SlotIndex+1].Status              	    := Slots[Slotindex].Status;
  Slots[SlotIndex+1].SaleLineID              	:= Slots[Slotindex].SaleLineID;

  Slots[Slotindex].timeto := SplitTime;
  Slots[SlotIndex+1].TimeStart := SplitTime;

end;

{ TProcItem }

destructor TProcItem.Destroy;
begin
  fProcTimeList.Free;
  inherited;
end;

function TProcItem.ProcessOverdue: boolean;
begin
  Result:= (fProcessTimeStart > 0) and (FProcessStatus <> psComplete) and
    (Trunc(now) > FProcessTimeStart);
end;

procedure TProcItem.SetDirty(const Value: boolean);
begin
  FDirty := Value;
end;

procedure TProcItem.setGoodsOnOrderStatus(const Value: String);
begin
  if fsGoodsOnOrderStatus <> Value then begin
    fsGoodsOnOrderStatus := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.setManufacturingUnits(const Value: double);
begin
  if fdManufacturingUnits <> Value then begin
    fdManufacturingUnits := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetParentProcTreeId(const Value: Integer);
begin
  if FParentProcTreeId <> Value then begin
    FParentProcTreeId := Value;
    fDirty:= true;
  end;

end;

procedure TProcItem.SetProcessDesc(const Value: string);
begin
  if FProcessDesc <> Value then begin
    FProcessDesc := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcessDuration(const Value: double);
begin
  if FProcessDuration <> Value then begin
    FProcessDuration := Value;
    fDirty:= true;
  end;
end;
procedure TProcItem.SetProcesSetupDuration(const Value: double);
begin
  if FProcesSetupDuration <> Value then begin
    FProcesSetupDuration := Value;
  end;
end;
procedure TProcItem.SetProcesBreakDownDuration(const Value: double);
begin
  if FProcesBreakDownDuration <> Value then begin
    FProcesBreakDownDuration := Value;
  end;
end;
procedure TProcItem.SetSingleDuration(const Value: double);
begin
  if FSingleDuration <> Value then begin
    FSingleDuration := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcessPartId(const Value: integer);
begin
  if FProcessPartId <> Value then begin
    FProcessPartId := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcessSequence(const Value: integer);
begin
  if FProcessSequence <> Value then begin
    FProcessSequence := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcessStatus(const Value: TProcessPartStatus);
var x: integer;
begin
  if FProcessStatus <> Value then begin
    FProcessStatus := Value;
    fDirty:= true;
    if Value = psNotScheduled then begin
      for x:= 0 to ProcTimeList.Count -1 do begin
        ProcTimeList[x].Deleted:= true;
      end;
    end;
  end;
end;

procedure TProcItem.SetProcessStepId(const Value: integer);
begin
  if FProcessStepId <> Value then begin
    FProcessStepId := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcessTimeStart(const Value: TDateTime);
begin
  if FProcessTimeStart <> Value then begin
    FProcessTimeStart := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreePartUom(const Value: string);
begin
  if FProcTreePartUom <> Value then begin
    FProcTreePartUom := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreeCaption(const Value: string);
begin
  if FProcTreeCaption <> Value then begin
    FProcTreeCaption := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreeId(const Value: integer);
begin
  if FProcTreeId <> Value then begin
    FProcTreeId := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreePartId(const Value: integer);
begin
  if FProcTreePartId <> Value then begin
    FProcTreePartId := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreeTotalQty(const Value: double);
begin
  if FProcTreeTotalQty <> Value then begin
    FProcTreeTotalQty := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleCustomerName(const Value: string);
begin
  if FSaleCustomerName <> Value then begin
    FSaleCustomerName := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleDocNumber(const Value: string);
begin
  if FSaleDocNumber <> Value then begin
    FSaleDocNumber := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleId(const Value: integer);
begin
  if FSaleId <> Value then begin
    FSaleId := Value;
    fDirty:= true;
  end;
end;
procedure TProcItem.SetClassID(const Value: integer);
begin
  if FClassID <> Value then begin
    FClassID := Value;
    fDirty:= true;
  end;
end;
procedure TProcItem.SetSaleLineId(const Value: integer);
begin
  if FSaleLineId <> Value then begin
    FSaleLineId := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleLineProductName(const Value: string);
begin
  if FSaleLineProductName <> Value then begin
    FSaleLineProductName := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleLineQuantity(const Value: double);
begin
  if FSaleLineQuantity <> Value then begin
    FSaleLineQuantity := Value;
    fDirty:= true;
  end;
end;
procedure TProcItem.SetBuildingBlockQty(const Value: double);
begin
  if FBuildingBlockQty <> Value then begin
    FBuildingBlockQty := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleLineShipDate(const Value: TDateTime);
begin
  if FSaleLineShipDate <> Value then begin
    FSaleLineShipDate := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleShipDate(const Value: TDateTime);
begin
  if FSaleShipDate <> Value then begin
    FSaleShipDate := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetTreeRootId(const Value: integer);
begin
  if FTreeRootId <> Value then begin
    FTreeRootId := Value;
    fDirty:= true;
  end;
end;

function TProcItem.IsRoot: boolean;
begin
  Result:= self.TreeRootId = self.ProcTreeId;
end;

procedure TProcItem.SetProcTreeDescription(const Value: string);
begin
  if FProcTreeDescription <> Value then begin
    FProcTreeDescription := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetSaleLineProductDescription(const Value: string);
begin
  if FSaleLineProductDescription <> Value then begin
    FSaleLineProductDescription := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreePartType(const Value: string);
begin
  if FProcTreePartType <> Value then begin
    FProcTreePartType := Value;
    fDirty:= true;
  end;
end;

function TProcItem.GetProcTimeList: TProcTimeList;
begin
  if not Assigned(fProcTimeList) then begin
    fProcTimeList:= TProcTimeList.Create;
    fProcTimeList.ProcItem:= self;
  end;
  Result:= fProcTimeList;
end;

procedure TProcItem.SetProcessResourceId(const Value: integer);
begin
  if FProcessResourceId <> Value then begin
    FProcessResourceId := Value;
    fDirty:= true;
  end;
end;

function TProcItem.GetDirty: boolean;
begin
  Result:= fDirty or self.ProcTimeList.Dirty;
end;

procedure TProcItem.SetProcTreeLevel(const Value: integer);
begin
  if FProcTreeLevel <> Value then begin
    FProcTreeLevel := Value;
    fDirty:= true;
  end;
end;

procedure TProcItem.SetProcTreeSequenceDown(const Value: integer);
begin
  if FProcTreeSequenceDown <> Value then begin
    FProcTreeSequenceDown := Value;
    fDirty:= true;
  end;
end;
function TProcItem.GetPropertynames:String;
begin
  Result:=
    'SaleID,'+
    'SaleLineId,'+
    'ClassID,'+
    'ProcTreeId,'+
    'ParentProcTreeId,'+
    'TreeRootId,'+
    'ProcessPartId,'+
    'SaleDocNumber,'+
    'SaleCustomerName,'+
    'SaleShipDate,'+
    'SaleLineProductName,'+
    'SaleLineProductDescription,'+
    'SaleLineQuantity,'+
    'SaleLineShipDate,'+
    'ProcTreePartId,'+
    'ProcTreePartUom,'+
    'ProcTreePartType,'+
    'ProcTreeTotalQty,'+
    'ProcTreeCaption,'+
    'ProcTreeDescription,'+
    'ProcTreeLevel,'+
    'ProcTreeSequenceDown,'+
    'ProcessDesc,'+
    'ProcessDuration,'+
    'ProcesSetupDuration,'+
    'ProcesBreakDownDuration,'+
    'SingleDuration,'+
    'ProcessStatus,'+
    'ProcessTimeStart,'+
    'ProcessSequence,'+
    'ProcessStepId,'+
    'ProcessResourceId,'+
    'Selected,'+
    'TotScheduled,'+
    'totUnscheduled,'+
    'ProcessTimeId,'+
    'ProcessPartId,'+
    'TimeStart,'+
    'TimeEnd,'+
    'Duration,'+
    'Active,'+
    'SaleLineQuantity';

end;
function TProcItem.getSelected: boolean;
var
  x:Integer;
begin
  result:= False;
  if not(Assigned(Itemlist)) then exit;
  for x := 0 to itemlist.count -1 do begin
    if itemlist[x] = self then
      result := itemlist.Selected[x];
  end;
end;

function TProcItem.getBuildingBlockQty: double;
begin
  REsult := FBuildingBlockQty;
  if result =0 then Result := 1;
end;

function TProcItem.GetCommaText: string;
var
  ctr:Integer;
  s:String;
begin
  result:= '';
  s:=
    IntToStr(SaleId)            +  ','+
    IntToStr(SaleLineId)        +  ','+
    IntToStr(ClassID)        +  ','+
    IntToStr(ProcTreeId)        +  ','+
    Inttostr(ParentProcTreeId)  +  ','+
    IntToStr(TreeRootId)        +  ','+
    IntToStr(ProcessPartId)     +  ','+
    QuotedStr(SaleDocNumber)    +  ','+
    QuotedStr(SaleCustomerName) +  ','+
    QuotedStr(FormatDateTime('dd/mm/yyyy hh:nn:ss',SaleShipDate)) +  ','+
    QuotedStr(SaleLineProductName) +  ','+
    QuotedStr(SaleLineProductDescription) +  ','+
    FloatToStr(SaleLineQuantity) +  ','+
    QuotedStr(FormatDateTime('dd/mm/yyyy hh:nn:ss',SaleLineShipDate)) +  ','+
    IntToStr(ProcTreePartId)      +  ','+
    QuotedStr(ProcTreePartUom)    +  ','+
    QuotedStr(ProcTreePartType)   +  ','+
    FloatToStr(ProcTreeTotalQty)  +  ','+
    QuotedStr(ProcTreeCaption)    +  ','+
    QuotedStr(ProcTreeDescription)+  ','+
    IntToStr(ProcTreeLevel)       +  ','+
    IntToStr(ProcTreeSequenceDown)+  ','+
    QuotedStr(ProcessDesc)        +  ','+
    FloatToStr(ProcessDuration)   +  ','+
    FloatToStr(ProcesSetupDuration)   +  ','+
    FloatToStr(ProcesBreakDownDuration)   +  ','+
    FloatToStr(SingleDuration)   +  ','+
    QuotedStr(ProcessPartStatusToStr(ProcessStatus)) +  ','+
    QuotedStr(FormatDateTime('dd/mm/yyyy hh:nn:ss',ProcessTimeStart)) +  ','+
    IntToStr(ProcessSequence)     +  ','+
    IntToStr(ProcessStepId)       +  ','+
    IntToStr(ProcessResourceId)   +  ','+
    BooleantoStr(Selected)        +  ','+
    FloatTostr(ProcTimeList.TotalScheduled)   +  ','+
    FloatTostr(ProcTimeList.TotalUnScheduled)+
    FloatToStr(SaleLineQuantity) ;

    if ProcTimeList.Count =0 then begin
      REsult:= s;
      exit;
    end;
    for ctr := 0 to ProcTimeList.Count-1 do begin
        result:= result+ s +',' +
            inttostr(ProcTimeList.Item[ctr].ProcessTimeId)+',' +
            inttostr(ProcTimeList.Item[ctr].ProcessPartId)+',' +
            QuotedStr(FormatDateTime('dd/mm/yyyy hh:nn:ss',ProcTimeList.Item[ctr].TimeStart)) +  ','+
            QuotedStr(FormatDateTime('dd/mm/yyyy hh:nn:ss',ProcTimeList.Item[ctr].TimeEnd)) +  ','+
            floatTostr(ProcTimeList.Item[ctr].Duration) +  ','+
            BooleanToStr(ProcTimeList.Item[ctr].Active)+NL;
    end;
end;

procedure TProcItem.SetProcTreeComplete(const Value: boolean);
begin
  if FProcTreeComplete <> Value then begin
    FProcTreeComplete := Value;
    fDirty:= true;
  end;
end;

{ TProcItemList }

procedure TProcItemList.CopyTo(dest: TProcItemList);
var
  row: TProcItem;
  x,y:Integer;
  ProcTime: TProcessTimeNDS;
begin
  for x:= 0 to count-1 do begin
        row:= TProcItem.Create;
        row.ItemList                  := dest;
        row.SaleId                    := Item[x].SaleId;
        row.SaleLineId                := Item[x].SaleLineId;
        row.ClassID                   := Item[x].ClassID;
        row.ProcTreeId                := Item[x].ProcTreeId;
        Row.ParentProcTreeId          := Item[x].ParentProcTreeId;
        row.TreeRootId                := Item[x].TreeRootId;
        row.ProcessPartId             := Item[x].ProcessPartId;
        row.SaleDocNumber             := Item[x].SaleDocNumber;
        row.SaleCustomerName          := Item[x].SaleCustomerName;
        row.SaleShipDate              := Item[x].SaleShipDate;
        row.SaleLineProductName       := Item[x].SaleLineProductName;
        row.SaleLineProductDescription:= Item[x].SaleLineProductDescription;
        row.SaleLineQuantity          := Item[x].SaleLineQuantity;
        row.SaleLineShipDate          := Item[x].SaleLineShipDate;
        row.ProcTreeCaption           := Item[x].ProcTreeCaption;
        row.ProcTreeDescription       := Item[x].ProcTreeDescription;
        row.ProcTreeTotalQty          := Item[x].ProcTreeTotalQty;
        row.ProcTreePartId            := Item[x].ProcTreePartId;
        row.ProcTreeLevel             := Item[x].ProcTreeLevel;
        row.ProcTreeSequenceDown      := Item[x].ProcTreeSequenceDown;
        row.ProcTreeComplete          := Item[x].ProcTreeComplete;
        row.ProcessDesc               := Item[x].ProcessDesc;
        row.ProcessDuration           := Item[x].ProcessDuration;
        row.ProcesSetupDuration       := Item[x].ProcesSetupDuration;
        row.ProcesBreakDownDuration   := Item[x].ProcesBreakDownDuration;
        row.SingleDuration            := Item[x].SingleDuration;
        row.ProcessStatus             := Item[x].ProcessStatus;
        row.ProcessTimeStart          := Item[x].ProcessTimeStart;
        row.ProcessSequence           := Item[x].ProcessSequence;
        row.ProcessStepId             := Item[x].ProcessStepId;
        row.ProcessResourceId         := Item[x].ProcessResourceId;
        row.GoodsOnOrderStatus        := Item[x].GoodsOnOrderStatus;
        row.BuildingBlockQty          := Item[x].BuildingBlockQty;
        for y := 0 to Item[x].ProcTimeList.count-1 do begin
          ProcTime:= TProcessTimeNDS.Create(nil);
          ProcTime.ProcessTimeId      := Item[x].ProcTimeList.item[y].ProcessTimeId;
          ProcTime.ProcessPartId      := Item[x].ProcTimeList.item[y].ProcessPartId;
          ProcTime.TimeStart          := Item[x].ProcTimeList.item[y].TimeStart;
          ProcTime.TimeEnd            := Item[x].ProcTimeList.item[y].TimeEnd;
          ProcTime.Duration           := Item[x].ProcTimeList.item[y].Duration;
          ProcTime.Active             := Item[x].ProcTimeList.item[y].Active;
          row.ProcTimeList.Add(ProcTime);
        end;
        Dest.fList.Add(row);
  end;
end;

constructor TProcItemList.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
  Reset;
end;

destructor TProcItemList.Destroy;
begin
  fList.Free;
  fStorer.Free;
  fSelectedList.Free;
  inherited;
end;

procedure TProcItemList.Reset;
begin
  fSelectStr:= '';
  fOrderByStr:= '';
  fDateFrom:= 0;
  fDateTo:= 0;
  fProcResourceId:= 0;
  fProcessStepIdListStr:= '';
end;

procedure TProcItemList.Clear;
begin
  fList.Clear;
end;

function TProcItemList.commatext: STring;
var
  x:Integer;
begin
  result:= '';
  for x:= 0 to Count -1 do begin
    result:= result + NL + TProcItem(Item[x]).commatext ;
  end;
end;

function TProcItemList.GetCount: integer;
begin
  Result:= fList.Count;
end;

function TProcItemList.GetItem(const index: integer): TProcItem;
begin
  Result:= nil;
  if index<0 then exit;
  Result:= TProcItem(fList[index]);
end;
Procedure TProcItemList.MakeSQL(const ProcessDateFrom, ProcessDateTo: TDateTime; const ProcessStepIdList: TIntegerList; const CustomerName: string = '';forSaleId:Integer=0);
var
  IdListStr: string;
begin
  Clear;
  if Assigned(ProcessStepIdList) then
    self.fProcessStepIdListStr:= ProcessStepIdList.CommaText;

  fSelectStr:=
    '(pp.Status = "psNotScheduled" OR ' +
      ' ((pp.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, ProcessDateFrom)) +
      ' AND pp.TimeStart <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, ProcessDateTo)) + ') or '+
      ' ((Select count(*) ctr from tblProcessTime PCT '+
 		' where PCT.processpartid = PP.ID and  PCT.Timestart between  ' + QuotedStr(FormatDateTime(MysqlDateFormat, ProcessDateFrom)) +' AND  ' + QuotedStr(FormatDateTime(MysqlDateFormat, ProcessDateTo)) + ' ) >= 1)))';
  if IdListStr <> '' then
    fSelectStr:= fSelectStr + ' AND pp.ProcessStepId in (' + IdListStr + ')';

  if CustomerName <> '' then
    fSelectStr:= fSelectStr + ' AND s.CustomerName = ' + QuotedStr(CustomerName);
  if forSaleId <> 0 then
    fSelectStr:= fSelectStr + ' AND s.SaleID = ' + inttostr(forSaleId);

  fOrderByStr:=
    's.SaleID, SL.saleLineId, sl.ShipDate, s.InvoiceDocNumber, pt.TreeRootId, pt.SequenceDown, pp.ProcessStepSeq';
end;

Function TProcItemList.LoadListSQL(const ProcessDateFrom, ProcessDateTo: TDateTime; const ProcessStepIdList: TIntegerList; const CustomerName: string = '';forSaleId:Integer=0; LoadNone :Boolean =False):String;
begin
  MakeSQL(ProcessDateFrom, ProcessDateTo,ProcessStepIdList,CustomerName,forSaleId);
  Result :=LoadListSQL(LoadNone);
end;

function TProcItemList.LoadListSQL(LoadNone:Boolean =False): String;
begin
    Result := '';
    Result := Result +' SELECT S.ClassId,  pt.parentId, pt.ProcTreeId, pt.TreeRootId, s.SaleId, s.InvoiceDocNumber as SaleDocNumber,';
    Result := Result +' s.CustomerName as SaleCustomerName, s.SaleDate, s.ShipDate as SaleShipDate,';
    Result := Result +' sl.SaleLineId, sl.ProductName as SaleLineProductName, sl.Product_Description as SaleLineProductDescription, ';
    Result := Result +' sl.UnitofMeasureQtySold as SaleLineQuantity, sl.ShipDate as SaleLineShipDate,';
    Result := Result +' pt.Caption as ProcTreeCaption, pt.Description as ProcTreeDescription, ';
    Result := Result +' if(pt.ParentId=0 and pt.masterId = Sl.saleLineId,pt.TotalQty , pt.ManufactureUOMQty) as ProcTreeTotalQty,';
    Result := Result +' pt.PartsId as ProcTreePartId, pt.Level as ProcTreeLevel, pt.SequenceDown as ProcTreeSequenceDown,';
    Result := Result +' pt.Complete as ProcTreeComplete,';
    Result := Result +' pt.TreePartUOM as TreePartUOM,';
    Result := Result +' P.partType as partType,';
    Result := Result +' ps.Description as ProcessDesc,';
    Result := Result +' pp.Id as ProcessPartId, ';
    Result := Result +' pp.Duration as ProcessPartDuration,';
    Result := Result +' pp.Status as ProcessStatus, pp.TimeStart as ProcessTimeStart,';
    Result := Result +' pp.SetupDuration as ProcessPartSetupDuration, pp.BreakdownDuration as ProcessPartBreakdownDuration,';
    Result := Result +' pp.ProcessStepSeq as ProcessSequence, pp.ProcessStepId,';
    Result := Result +' rp.ProcResourceId as ProcessResourceId,';
    Result := Result +' psl.ProcPickSlipId , pp.BuildingBlockQty';
    Result := Result +' FROM tblSales s';
    Result := Result +' JOIN tblSalesLines sl ON s.SaleId = sl.SaleId';
    Result := Result +' JOIN tblProcTree pt on pt.MasterId = sl.SaleLineId and pt.MasterType <> "mtProduct"';
    Result := Result +' Left JOIN tblparts P  on P.partsId = pt.PartsId';
    Result := Result +' JOIN tblProcessPart pp ON pp.ProcTreeId = pt.ProcTreeId';
    Result := Result +' JOIN tblProcessStep ps ON ps.Id = pp.ProcessStepId';
    Result := Result +' JOIN tblProcResourceProcess rp ON rp.ProcessStepId = ps.Id';
    Result := Result +' LEFT JOIN tblProcPickSlipLine psl ON psl.ProcTreeId = pt.ProcTreeId';
    Result := Result +' WHERE s.IsSalesOrder = "T" and S.Converted ="F"';
    Result := Result +' and (SL.BOMProductionLine ="T" or SL.BOMGroupedLine ="F")';
    Result := Result +' and if(pt.ParentId=0 and pt.masterId = Sl.saleLineId,pt.TotalQty , pt.ManufactureUOMQty)  <> 0';
    if fSelectStr            <> ''  then Result := Result +' AND ' + fSelectStr;
    if fDateFrom              > 0   then Result := Result +' AND pp.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, fDateFrom));
    if fDateTo                > 0   then Result := Result +' AND pp.TimeStart <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, fDateTo));
    if fProcResourceId        > 0   then Result := Result +' AND rp.ProcResourceId = ' + IntToStr(fProcResourceId);
    if fProcessStepIdListStr <> ''  then Result := Result +' AND pp.ProcessStepId IN (' + fProcessStepIdListStr + ')';
    if fOrderByStr           <> ''  then Result := Result +' ORDER BY ' + fOrderByStr;
    if LoadNone then Result := Result +' LIMIT 0 ';
end;


procedure TProcItemList.LoadList(const ProcessDateFrom, ProcessDateTo: TDateTime; const ProcessStepIdList: TIntegerList; const CustomerName: string = '';forSaleId:Integer=0;LoadNone :Boolean =False);
begin
  MakeSQL(ProcessDateFrom, ProcessDateTo,ProcessStepIdList,CustomerName,forSaleId);
  LoadList(Loadnone);
end;
procedure TProcItemList.LoadList( LoadNone :Boolean =False; updateGoodsOnOrderstatus :Boolean = True);
var
  qry, qryTime: TERPQuery;
  row: TProcItem;
  ProcTime: TProcessTimeNDS;
begin
  Clear;
  qry:= TERPQuery.Create(nil);
  qryTime:= TERPQuery.Create(nil);
  try
    qry.Connection:= fConnection;
    qryTime.Connection:= fConnection;

    Qry.SQL.add(LoadListSQL(LoadNone));
    qryTime.SQL.Text:= 'SELECT * FROM tblProcessTime WHERE ProcessPartId = :ProcessPartId ' +
      ' and not(timestart = ''1899-12-30 00:00:00'' and timeend = ''1899-12-30 00:00:00'' and duration =0)' +
      ' ORDER BY TimeStart';

    qry.Open;
    DoShowProgressbar(qry.recordcount, 'Checking for Sales Jobs and it''s Schedules');
    try
      while not qry.Eof do begin
        DoStepProgressbar('Loading ' +inttostr(qry.recno) + ' of ' +inttostr(qry.recordcount));
        row:= TProcItem.Create;
        row.ItemList:= self;
        row.SaleId:= qry.FieldByName('SaleId').AsInteger;
        row.SaleLineId:= qry.FieldByName('SaleLineId').AsInteger;
        row.ClassID:= qry.FieldByName('ClassID').AsInteger;
        row.ProcTreeId:= qry.FieldByName('ProcTreeId').AsInteger;
        Row.ParentProcTreeId := Qry.FieldByName('ParentId').AsInteger;
        row.TreeRootId:= qry.FieldByName('TreeRootId').AsInteger;
        row.ProcessPartId:= qry.FieldByName('ProcessPartId').AsInteger;
        row.SaleDocNumber:= qry.FieldByName('SaleDocNumber').AsString;
        row.SaleCustomerName:= qry.FieldByName('SaleCustomerName').AsString;
        row.SaleShipDate:= qry.FieldByName('SaleShipDate').AsDateTime;
        row.SaleLineProductName:= qry.FieldByName('SaleLineProductName').AsString;
        row.SaleLineProductDescription:= qry.FieldByName('SaleLineProductDescription').AsString;
        row.SaleLineQuantity:= qry.FieldByName('SaleLineQuantity').AsFloat;
        row.SaleLineShipDate:= qry.FieldByName('SaleLineShipDate').AsDateTime;
        row.ProcTreeCaption:= qry.FieldByName('ProcTreeCaption').AsString;
        row.ProcTreeDescription:= qry.FieldByName('ProcTreeDescription').AsString;
        row.ProcTreeTotalQty:= qry.FieldByName('ProcTreeTotalQty').AsFloat;
        row.ProcTreePartId:= qry.FieldByName('ProcTreePartId').AsInteger;
        row.ProcTreeLevel:= qry.FieldByName('ProcTreeLevel').AsInteger;
        row.ProcTreeSequenceDown:= qry.FieldByName('ProcTreeSequenceDown').AsInteger;
        row.ProcTreeComplete:= qry.FieldByName('ProcTreeComplete').AsBoolean;
        row.ProcessDesc:= qry.FieldByName('ProcessDesc').AsString;
        row.ProcessDuration:=
          (qry.FieldByName('ProcessPartDuration').AsFloat + qry.FieldByName('ProcessPartSetupDuration').AsFloat +
          qry.FieldByName('ProcessPartBreakdownDuration').AsFloat) * row.ProcTreeTotalQty;
        row.ProcesSetupDuration:=qry.FieldByName('ProcessPartSetupDuration').AsFloat  * row.ProcTreeTotalQty;
        row.ProcesBreakDownDuration:=qry.FieldByName('ProcessPartBreakdownDuration').AsFloat  * row.ProcTreeTotalQty;
        row.SingleDuration:= qry.FieldByName('ProcessPartDuration').AsFloat + qry.FieldByName('ProcessPartSetupDuration').AsFloat +
          qry.FieldByName('ProcessPartBreakdownDuration').AsFloat;//qry.FieldByName('ProcessPartDuration').AsFloat ;
        row.ProcessStatus:= StrToProcessPartStatus(qry.FieldByName('ProcessStatus').AsString);
        row.ProcessTimeStart:= qry.FieldByName('ProcessTimeStart').AsDateTime;
        row.ProcessSequence:= qry.FieldByName('ProcessSequence').AsInteger;
        row.ProcessStepId:= qry.FieldByName('ProcessStepId').AsInteger;
        row.ProcessResourceId:= qry.FieldByName('ProcessResourceId').AsInteger;
        if updateGoodsOnOrderstatus and not(Devmode) then row.GoodsOnOrderStatus :=  GoodsOnOrderstatus(qry.fieldByname('ProctreeID').asInteger , fconnection);
        row.ProcTreePartUom :=qry.FieldByName('TreePartUOM').asString;
        row.ProctreeParttype :=qry.FieldByName('Parttype').asString;
        qryTime.ParamByName('ProcessPartId').AsInteger:= row.ProcessPartId;
        row.BuildingBlockQty:= qry.FieldByName('BuildingBlockQty').AsFloat;
        qryTime.Open;
        while not qryTime.Eof do begin
          ProcTime:= TProcessTimeNDS.Create(nil);
          SetObjectPropertiesFromDataSet(ProcTime, qryTime);
          ProcTime.Storer:= self.Storer;
          ProcTime.Dirty:= false;
          row.ProcTimeList.Add(ProcTime);
          qryTime.Next;
        end;
        qryTime.Close;
        row.Dirty:= false;
        fList.Add(row);
        qry.Next;
      end;
    finally
      DoHideProgressbar;
    end;
  finally
    qry.Free;
    qryTime.Free;
  end;
end;
procedure TProcItemList.LoadList(Const aSQL: string);
begin
  self.fSelectStr:= aSQL;
  self.LoadList;
end;


function TProcItemList.GetDirty: boolean;
var
  x: integer;
begin
  Result:= false;
  for x:= 0 to Count -1 do begin
    if Item[x].Dirty then begin
      Result:= true;
      Break;
    end;
  end;
end;


function TProcItemList.getGridhint: String;
begin
  Result := replacestr(fSelectStr , 'pp.' , '')+#13#10 +#13#10 +'Double Click on the Process Column For the List of All Processes Associated with the Sales Order';
end;

function TProcItemList.ChangedProcesstimeIDs:String;
var
  x:Integer;
begin
  Result:= '';
  for x:= 0 to Count -1 do begin
        if Item[x].Dirty  then begin
          if Result<> '' then Result := Result+',';
          Result:= Result + Item[x].ProcTimeList.ProcesstimeIDs;
        end;
  end;
  Result:= replacestr(Result , ',,' , ',');
end;
function TProcItemList.CheckForEmpScheduleforSelectedProcesses: Boolean;
var
  ctr:Integer;
  Ids:TStringlist;
  Qry :TERPQuery;
begin
  result := True;

  if not(Appenv.Companyprefs.AutoScheduleBasedonBOMEmpRoster) then exit;

  if SelectedList.Count  =0 then exit;
  Ids:= TStringlist.Create;
  try
    Ids.Duplicates := dupIgnore;
    Ids.Sorted:= true;
    for ctr:= 0 to SelectedList.Count -1 do
      if SelectedItem[ctr].processduration <> 0 then
        Ids.Add(trim(inttostr(SelectedItem[ctr].ProcessStepId)));
    if Ids.count =0 then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);
  try
    Qry.SQL.Text := 'Select ' +
                    ' PS.Id ProcessStepID , '+
                    ' PS.Description ProcessStep, '+
                    ' count(EPS.ID) as ctr , '+
                    ' sum(SecondsBetween(EPS.TimeFrom , EPS.TimeTo)) as seconds '+
                    ' from tblprocessstep PS '+
                    ' left join tblempresprocschedule EPS on PS.Id = EPS.ProcessStepId '+
                    ' where PS.ID in (' + Ids.commatext +') group by PS.Id '+
                    ' Order by ctr ';
    opendb(Qry);
    Qry.filter := 'ctr < 1';
    Qry.filtered := True;
    if Qry.recordcount =0 then exit;

    Result := False;
    InitMsgParams;
    PopupMsgParams.Msgcaption := 'Warning';
    PopupMsgParams.Msgds := qry;
    PopupMsgParams.fieldnames := 'ProcessStep';
    PopupMsgParams.displayLabels:= 'Process Step';
    PopupMsgParams.Custombuttons := '"OK","Employee Allocation"';
    PopupMsgParams.Msg1:= 'It is not Possible to Schedule Process Steps When The Resource Has No Staff Allocated'+NL+ 'The Following Process Step(s) Need to be Allocated.';
    PopupMsgParams.Msg2 := 'Please Choose ''Employee Allocation'' to Allcoate';
    PopupMsgParams.MsgColor := ColorAdjustLuma(AppEnv.ColourPrefs.GetColour('Manufacturing'),  AppEnv.ColourPrefs.GetGradIntensity('Manufacturing'), False);
    if TfmMessageWithList.MsgDlg = 101 then OpenERPForm('TfmEmpResProcRoster' , 0);

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

  finally
    FreeandNil(Ids);
  end;
end;

function TProcItemList.Save(var msg: string): boolean;
var
  SO: TSalesOrder;
  x, y: integer;
  ProcessedList: TIntegerList;
  ProgDlg: TProgressDialog;
begin
  Result:= true;
  SO:= TSalesOrder.Create(nil);
  ProcessedList:= TIntegerList.Create;
  ProgDlg:= TProgressDialog.Create(nil);
  try
    SO.Connection:= TMyDacDataConnection.Create(SO);
    SO.Connection.Connection:= Connection;
    SO.SilentMode:= true;
    SO.Connection.BeginNestedTransaction;
    try
      ProgDlg.Caption:= 'Saving Lines ...';
      ProgDlg.MaxValue:= Count ;
      ProgDlg.MinValue:= 1;
      ProgDlg.Step:= 1;
      ProgDlg.Value:= 1;
      ProgDlg.Execute;
      ProgDlg.StepIt;
      for x:= 0 to Count -1 do begin
        if Item[x].Dirty and (not ProcessedList.InList(x)) then begin
          ProcessedList.Add(x);
          SO.Load(Item[x].SaleId);
          SO.InstantiateAllTrees;
          Item[x].ProcTimeList.Save;

          if not UpdateLine(SO, Item[x]) then begin
            Result:= false;
            break;
          end;
          { now update any other items in the list for this same sales order }
          for y:= x +1 to Count -1 do begin
            if Item[y].Dirty and (Item[y].SaleId = Item[x].SaleId) and (not ProcessedList.InList(y)) then begin
              ProcessedList.Add(y);
              try
                Item[y].ProcTimeList.Save;
              Except
                on E:EXception do begin
                  if devmode then MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
                end;
              end;
              if not UpdateLine(SO, Item[y]) then begin
                Result:= false;
                break; // out of y loop
              end;
            end;
          end;
          if not Result then
            break; // out of x loop

          {now Save the whole sales order (if all ok)}
          SO.ResultStatus.Clear;
          if not SO.Save then begin
            Result:= false;
            break;
          end;
        end;
        ProgDlg.StepIt;
      end;
      if Result then begin
        SO.Connection.CommitNestedTransaction;
        for x:= 0 to Count -1 do
          Item[x].Dirty:= false;
      end
      else begin
        SO.Connection.RollbackNestedTransaction;
        msg:= SO.ResultStatus.Messages;
      end;
    Except
      on E:Exception do begin
        SO.Connection.RollbackNestedTransaction;
        SO.ResultStatus.addItem(False , rssError, 0 , E.Message);
      end;
    end;
  finally
    SO.Free;
    ProcessedList.Free;
    ProgDlg.Free;
  end;
end;

function TProcItemList.UpdateLine(const SalesOrder: TSalesOrder; const RowRec: TProcItem): boolean;
var
  ProcTree, node: TProcTreeNode;

  procedure UpdateProcess;
  var pp: TProcessPartNDS;
  begin
    pp:= node.ProcessStepList.ItemById(RowRec.ProcessPartId);
    if Assigned(pp) then begin
      pp.TimeStart:= RowRec.ProcessTimeStart;
      pp.Status:= RowRec.ProcessStatus;
    end
    else begin
      Result:= false;
      SalesOrder.ResultStatus.AddItem(false,rssError,0,
        'Could not find BOM tree process: "' + RowRec.ProcessDesc + '"' +
         ' for product: "' + RowRec.SaleLineProductName +
        '" on Sales Order: "' + RowRec.SaleDocNumber + '" Customer: "' +
      RowRec.SaleCustomerName + '"');
    end;
  end;

  procedure UpdateProductAvailability(aNode: TProcTreeNode; aDateTime: TDateTime; StopIfProcesses: boolean = true);
  var x: integer;
  begin
    if not (aNode.HasProcessSteps and StopIfProcesses) then begin
      if (not aNode.IsRoot) and Assigned(aNode.ProcTreePart) then
        aNode.ProcTreePart.DateRequired:= aDateTime;
      for x:= 0 to aNode.Children.Count -1 do
        UpdateProductAvailability(TProcTreeNode(aNode.Children[x]), aDateTime);
    end;
  end;

begin
  Result:= true;

  if (SalesOrder.Lines.Id = RowRec.SaleLineId) or
    SalesOrder.Lines.DataSet.Locate('SaleLineId',RowRec.SaleLineId,[]) then begin
    ProcTree:= TProcTreeNode(SalesOrder.Lines.Container.ItemByClass(TProcTreeNode, false));
    if Assigned(ProcTree) and (ProcTree.Children.Count > 0) then begin
      node:= TProcTreeNode(ProcTree.NodeById(RowRec.ProcTreeId));
      if Assigned(node) then begin
        UpdateProcess;
        if Result then
          UpdateProductAvailability(node, RowRec.ProcessTimeStart, false);
      end else begin
        Result:= false;
        SalesOrder.ResultStatus.AddItem(false,rssError,0,
          'Could not find BOM tree process node for product: "' + RowRec.SaleLineProductName +
          '" for Sales Order: "' + RowRec.SaleDocNumber + '" Customer: "' +
          RowRec.SaleCustomerName + '"');
      end;
    end else begin
      Result:= false;
      SalesOrder.ResultStatus.AddItem(false,rssError,0,
        'Could not find BOM tree for product: "' + RowRec.SaleLineProductName +
        '" for Sales Order: "' + RowRec.SaleDocNumber + '" Customer: "' +
        RowRec.SaleCustomerName + '"');
    end;
  end
  else begin
    { can't find sales order line! }
    Result:= false;
    SalesOrder.ResultStatus.AddItem(false,rssError,0,
      'Could not find line: "' + RowRec.SaleLineProductName +
      '" for Sales Order: "' + RowRec.SaleDocNumber + '" Customer: "' +
      RowRec.SaleCustomerName + '"');
  end;
end;



procedure SkipWeekend(var aDate: TDateTime);
begin
    while not(IsWorkingday(adate)) do aDate:= aDate +1;
end;

function AutoScheduleProduction(var msg: string; var StepCount: integer; Connection: TERPConnection; UserLock: TUserLock;SaleIDs:String = ''): boolean;
var
  ProcessList: TProcItemList;
  SelectForm: TfmProcAutoShedSelect;
  DoSchedule: boolean;
  x:Integer;
  lockedsaleIDs:TIntegerList;

  Function LockedSaleIDdetails:String;
  var qry: TERPQuery;
  begin
    qry := TempMyQuery(Connection);
    try
      qry.SQL.add('Select Concat("SaleId " , SaleID , " for " , '''''''', customername, '''''''' ) details from tblsales where saleId in (' +lockedsaleIDs.commatext +')');
      qry.open;
      Result := qry.GroupConcat('details' , '', false, chr(13));
    finally
      qry.Free;
    end;
  end;

begin
  Result:= true;
  StepCount:= 0;
  ProcessList:= TProcItemList.Create;
  try
    ProcessList.Connection:= Connection;

    ProcessList.SelectStr:=
     ' pt.ManufactureUOMQty  * (ifnull(pp.Duration ,0)+ifnull(pp.SetupDuration ,0) +ifnull( pp.BreakdownDuration,0))  > '+
     ' ifnull((Select  sum(ifnull(Prt.Duration,0)) from  tblprocesstime Prt where  Prt.ProcessPartId = pp.id  and prt.timestart >"1899-12-30 00:00:00"),0)';
    if SaleIDs <> '' then ProcessList.SelectStr := ProcessList.SelectStr + ' and S.SaleId in ('+SaleIDs+')';
    if ProcPrefs.AutoProdPlanSchedType = psReverse then
         ProcessList.OrderByStr:= ' sl.ShipDate Desc , sl.saleID, sl.SaleLineId, pt.LEvel DESC, pt.SequenceDown DESC, pp.ProcessStepSeq'
    else ProcessList.OrderByStr:= ' sl.ShipDate, sl.saleID, sl.SaleLineId, pt.LEvel DESC, pt.SequenceDown DESC, pp.ProcessStepSeq';

    ProcessList.LoadList(False , False);
    if ProcessList.Count > 0 then begin

      SelectForm:= TfmProcAutoShedSelect.Create(nil);
      try
        SelectForm.ItemList:= ProcessList;
        DoSchedule:= SelectForm.ShowModal = mrOk;
      finally
        SelectForm.Free;
      end;

      if DoSchedule then begin
        try
          lockedsaleIDs := TIntegerlist.create;
          try
            for x:= ProcessList.SelectedList.Count -1 downto 0 do begin
              if not (Userlock.Lock('tblsales' ,ProcessList.SelectedItem[x].saleID)) then begin
                lockedsaleIDs.AddIfNotInList(ProcessList.SelectedItem[x].saleID);
                ProcessList.SelectedList.Delete(x);
              end;
            end;
            if lockedsaleIDs.count>0 then
              MessageDlgXP_Vista('The following Sales cannot be locked for scheduling '+chr(13)+ LockedSaleIDdetails , mtWarning, [mbOK], 0);
          finally
            Freeandnil(lockedsaleIDs);
          end;

          if (ProcessList.SelectedList.Count > 0) then begin
            DoShowProgressbar(StepCount, 'Scheduling ' + inttostr(ProcessList.SelectedList.Count) +' Jobs for the Available Slots');
            try
              ProcessList.AutoScheduleProduction(msg,StepCount);
            finally
              DoHideProgressbar;
            end;
            Result:= ProcessList.Save(msg);
          end;
        finally
            for x:= ProcessList.SelectedList.Count -1 downto 0 do
              Userlock.unLock( 'tblsales' ,ProcessList.SelectedItem[x].saleID);
        end;
      end;
    end else begin
      { nothing to process }
      CommonLib.MessageDlgXP_Vista('Nothing found to schedule.',mtInformation,[mbOk],0);
    end;

  finally
    ProcessList.Free;
  end;
end;


function TProcItemList.GetStorer: TBusObjStorer;
begin
  if not Assigned(fStorer) then begin
    fStorer:= TBusObjStorer.Create;
    fStorer.Connection:= fConnection;
  end;
  Result:= fStorer;
end;

function TProcItemList.MaxLevelForSaleLineId(
  const aSaleLineId: integer): integer;
var
  x: integer;
begin
  Result:= 0;
  for x:= 0 to Count -1 do begin
    if (Item[x].SaleLineId = aSaleLineId) and (Item[x].ProcTreeLevel > Result) then
      Result:= Item[x].ProcTreeLevel;
  end;
end;

function TProcItemList.GetSelectedList: TIntegerList;
begin
  if not Assigned(fSelectedList) then
    fSelectedList:= TIntegerList.Create;
  Result:= fSelectedList;
end;

function TProcItemList.GetSelectedItem(const Index: integer): TProcItem;
begin
  Result:= Item[SelectedList[Index]];
end;

procedure TProcItemList.SelectAll;
var
  x:Integer;
begin
  for x:= 0 to count -1 do
    SelectedList.Add(x);
end;

procedure TProcItemList.SelectItemsForSalesLine(const aSalesLineId: integer; const UnScheduledOnly: boolean);
var
  x: integer;
begin
  SelectedList.Clear;
  for x:= 0 to count -1 do begin
    if (Item[x].SaleLineId = aSalesLineId) and
      ((not UnScheduledOnly) or (Item[x].ProcessStatus = psNotScheduled)) then
      SelectedList.Add(x);
  end;
end;


procedure TProcItemList.addItem(const aItem: TProcItem);
begin
  fList.Add(aItem);
end;

function TProcItemList.AutoScheduleProduction(var msg: string; var StepCount: integer; StartSchedulingon :TDateTime =0; Reschedling:Boolean = False; CleanList:TProcItemList = nil): boolean;
var
   listPos: integer;
   SchedList: TSchedList;
           Procedure LogTimes;
           var
             x1 : integer;
           begin
             if SchedList.count >0 then begin
               Logtext(TColRec(SchedList.item[0]).Propertynames);
               for x1 := 0 to SchedList.count-1 do Logtext(TColRec(SchedList.item[x1]).CommaText);
             end;
           end;
           {==============================================================================================================================================================}
           Procedure ResetScheduleStart;
           var
             i:Integer;
           begin
             for i:= 0 to SelectedList.Count -1 do SelectedItem[i].ScheduleStart  := 0;
           end;
           {==============================================================================================================================================================}
           Procedure updateParettimeStart(aSaleLineID:Integer;IsForward :Boolean; aProctreeId, aParentProcTreeID,aProcessesSequence:Integer; fdtScheduledUpTo:TDateTime);
           var
             i:Integer;
           begin
             for i:= 0 to SelectedList.Count -1 do
               if SelectedItem[i].SaleLineId =aSaleLineID then
                   if SelectedItem[i].ProcTimeList.TotalUnScheduled >0 then begin
                     if  SelectedItem[i].ProctreeId = aParentProcTreeID then begin
                       if SelectedItem[i].ScheduleStart < fdtScheduledUpTo then begin
                         SelectedItem[i].ScheduleStart  := fdtScheduledUpTo;
                       end;
                     end;

                     if (SelectedItem[i].ParentProcTreeID = aParentProcTreeID) then begin
                       if (IsForward) and  (SelectedItem[i].ProcessSequence > aProcessesSequence)  then begin
                           if SelectedItem[i].ScheduleStart < fdtScheduledUpTo then begin
                             SelectedItem[i].ScheduleStart  := fdtScheduledUpTo;
                           end;
                       end else if (not(IsForward)) and  (SelectedItem[i].ProcessSequence < aProcessesSequence)  then begin
                           if (SelectedItem[i].ScheduleStart=0) or (SelectedItem[i].ScheduleStart > fdtScheduledUpTo) then begin
                             SelectedItem[i].ScheduleStart  := fdtScheduledUpTo;
                           end;
                       end;
                     end else if (not(IsForward)) and  (SelectedItem[i].ParentProcTreeID = aProctreeId) then begin
                           if (SelectedItem[i].ScheduleStart=0) or (SelectedItem[i].ScheduleStart > fdtScheduledUpTo) then begin
                             SelectedItem[i].ScheduleStart  := fdtScheduledUpTo;
                           end;
                     end;
                   end;
           end;
           {==============================================================================================================================================================}
         procedure ScheduleSalesLine(aSalesLineId: integer; SchedType: TAutoProdPlanSchedType; Schedulingfrom :Tdatetime=0);
         var
           dt: TDateTime;
           x{, i}: integer;
           ToSched: double;
           iToSched:Integer;
           SchedDay: TColRec;
           pd:TProgressDialog;
           fCleanItem :TProcItem;
           ctr:Integer;
           iAvailable:Integer;
           fdtScheduledUpTo:TDatetime;
           CleanSchedList: TSchedList;
           fdt:TDateTime;
           fdQty1, fdQty2:Double;
           SecsScheduled:Integer;
           NewRec: TProcessTimeNDS;
           SaleslineTree: TProcTreeNodeForScheduling;
           fdQtycanbeBuiltonDate :Double;
           s:String;
             {==}procedure RemoveScheduleForSalesLine(aSalesLineId: integer);
                 var
                   x, y: integer;
                 begin
                   for x:= 0 to SelectedList.Count -1 do begin
                     if (SelectedItem[x].SaleLineId = aSalesLineId) then begin
                       Dec(StepCount);
                       for y:= 0 to SelectedItem[x].ProcTimeList.Count-1 do begin
                         if not SelectedItem[x].ProcTimeList[y].Deleted then begin
                           SelectedItem[x].ProcTimeList.Unschedule(y);
                         end;
                       end;
                     end;
                   end;
                   ResetScheduleStart;
                   CleanSchedList.CopySchedList(SchedList);
                 end;
                 {==============================================================================================================================================================}
             {==}function CleanItem:TProcItem;
                   var
                     ctr:Integer;
                 begin
                     fcleanItem:= nil;
                     result := nil;
                     try
                        if not assigned(CleanList) then begin
                         fcleanItem:= nil;
                         exit;
                        end;

                        if assigned(fcleanitem) then begin
                           if fcleanItem.ProcTreeId = SelectedItem[x].ProctreeId then exit;
                           fcleanItem:= nil
                        end;

                        for ctr:= 0 to cleanlist.count-1 do begin
                          if cleanlist.Item[ctr].ProcTreeId = SelectedItem[x].ProctreeId then begin
                           fcleanItem :=cleanlist.Item[ctr];
                           exit;
                          end;
                        end;
                     finally
                       result :=fcleanItem;
                     end;
                   end;
                  {==============================================================================================================================================================}
             {==}Function QtycanbeBuiltonDate(aItem:TProcItem ; var adt:TDateTime ; QtyLeftToBuilt :Double ):Double;
                  var
                    SelectedNode : TProcTreeNodeForScheduling;
                    SelectedProcess : TProcessPartNDS;
                    fdQty :Double;
                  begin
                    Result := 0;
                    if QtyLeftToBuilt =0 then exit;
                    SelectedNode := SaleslineTree.FindNodeForID(aitem.ProctreeId);
                    if SelectedNode = nil then exit;
                    SelectedProcess := SelectedNode.findProcessPart(aitem.ProcessPartId);
                    if SelectedProcess = nil then exit;
                    if SelectedProcess.BuildingBlockQty =0 then fdQty := SelectedNode.TotalQty else fdQty :=SelectedProcess.BuildingBlockQty;
                    if fdQty > QtyLeftToBuilt  then fdQty :=QtyLeftToBuilt;
                    if fdQty  =0 then exit;
                    if SelectedNode.IsOkToBuild(SelectedProcess , fdQty , adt, False) then begin
                      SelectedNode.IsOkToBuild(SelectedProcess , fdQty , adt, True);
                      REsult := fdQty;
                    end;
                  end;
                  {==============================================================================================================================================================}
             {==}Procedure calcQtycanbeBuiltonDate;
                  begin
                    if fdQtycanbeBuiltonDate <= 0 then begin
                      fdQtycanbeBuiltonDate :=QtycanbeBuiltonDate(SelectedItem[x] , dt , SelectedItem[x].ProcTreeTotalQty - fdQty2);
                      ToSched:=fdQtycanbeBuiltonDate * SelectedItem[x].singleDuration;
                    end;
                    if fdQtycanbeBuiltonDate >  SelectedItem[x].ProcTreeTotalQty - fdQty2 then begin
                      fdQtycanbeBuiltonDate :=  SelectedItem[x].ProcTreeTotalQty - fdQty2;
                      ToSched:=fdQtycanbeBuiltonDate * SelectedItem[x].singleDuration;
                    end;
                    //logtext('QtycanbeBuiltonDate:' +Floattostr(fdQtycanbeBuiltonDate));
                  end;
{==============================================================================================================================================================}
         begin
             pd:= nil;
             CleanSchedList := nil;
             fdtScheduledUpTo :=0;
             Try
              SchedList.ClearUnAvailables;
             Except  End;
             try
                pd:= DoShowNewProgressbar(SelectedList.Count, WAITMSG+'.  Searching for Available Date' , '' , False);
                //pd.top := pd.top +30;
             Except
             End;
             try
               if (SchedType = psForward) then begin
                   { locate first record for this sale line id }
                   for x:= 0 to SelectedList.Count -1 do if (SelectedItem[x].SaleLineId = aSalesLineId) then Break;

                   if Schedulingfrom =0 then Schedulingfrom := date+1;

                   SaleslineTree:= TProcTreeNodeForScheduling.create(nil);
                   try
                      SaleslineTree.ProcTreeId := SalesLineRootNodeId(aSalesLineId);
                      SaleslineTree.LoadTree;
                               while (x < SelectedList.Count) and (SelectedItem[x].SaleLineId = aSalesLineId) do begin
                                  //logtext(inttostr(SelectedItem[x].Processpartid)+':' +SelectedItem[x].ProcessDesc+','+Floattostr(SelectedItem[x].ProcTimeList.TotalUnScheduled));
                                  if SelectedItem[x].ProcTimeList.TotalUnScheduled = 0 then begin
                                    Inc(x);
                                    Continue;
                                  end;
                                 DoStepProgressbar(pd , SelectedItem[x].ProcessDesc);
                                 fdtScheduledUpTo:= 0;
                                 dt:= Schedulingfrom;
                                 if SelectedItem[x].processduration <>0 then begin
                                     if ProcessResourceAvailable(SelectedItem[x].ProcessResourceId) then begin
                                         if SelectedItem[x].ProcTimeList.TotalUnScheduled > 0 then begin
                                           fdQty1 :=SelectedItem[x].BuildingBlockQty;
                                           if fdQty1 =0 then fdQty1 := 1;
                                           //logtext('Building Block Qty :' + floattostr(fdQty1));
                                           fdQty2:= 0;
                                           SecsScheduled:= 0;
                                           NewRec:= nil;
                                           //if SelectedItem[x].ProcTimeList.TotalUnScheduled >0 then begin
                                              fdQtycanbeBuiltonDate := 0;
                                              //logtext('ProcesspartID,Processdesc,TotalUnScheduled,ProcTreeTotalQty,DoneQty');
                                               while (Round(SelectedItem[x].ProcTimeList.TotalUnScheduled, GeneralRoundPlaces) > 0) and (SelectedItem[x].ProcTreeTotalQty - fdQty2 >0) do begin
                                                 //logtext(inttostr(SelectedItem[x].ProcessPartID)+','+SelectedItem[x].Processdesc+',' +Floattostr(SelectedItem[x].ProcTimeList.TotalUnScheduled)+':' +floattostr(SelectedItem[x].ProcTreeTotalQty)+','+floattostr(fdQty2));
                                                 SchedDay:= SchedList.LoadResAvailability(dt,SelectedItem[x].ProcessResourceId ,true,  Reschedling);
                                                 if SchedDay.AvailableSeconds > 0 then begin

                                                   calcQtycanbeBuiltonDate;
                                                   if fdQtycanbeBuiltonDate >0 then begin
                                                      //ToSched:=fdQtycanbeBuiltonDate * SelectedItem[x].singleDuration;
                                                     while (fdQtycanbeBuiltonDate>0) and (Round(SelectedItem[x].ProcTimeList.TotalUnScheduled, GeneralRoundPlaces) > 0) and (SelectedItem[x].ProcTreeTotalQty - fdQty2 >0) do begin
                                                          try
                                                           if fdQtycanbeBuiltonDate >SelectedItem[x].ProcTreeTotalQty - fdQty2  then fdQtycanbeBuiltonDate := SelectedItem[x].ProcTreeTotalQty - fdQty2;


                                                             ctr := SchedDay.FindSlot(dt, (*FloatToInt(fdQtycanbeBuiltonDate * SelectedItem[x].singleDuration, true)*) FloatToInt(ToSched, true), iToSched); (*secondsbetween(SchedDay.Slots[ctr].TimeStart , SchedDay.Slots[ctr].TimeTo) - SchedDay.Slots[ctr].Allocated;*)
                                                             if ctr <0 then break;
                                                             LogSlot(SchedDay.Slots[ctr]);

                                                             if iToSched >0 then begin
                                                                //ToSched:= iToSched;
                                                                if trunc((*ToSched*)iToSched) <> (*ToSched*)iToSched then (*ToSched*)iToSched := trunc((*ToSched*)iToSched)+1;
                                                                if (*ToSched*)iToSched >0 then begin
                                                                  NewRec:= SelectedItem[x].ProcTimeList.Schedule(0,incSecond(SchedDay.Slots[ctr].TimeStart ,SchedDay.Slots[ctr].Allocated ),(*ToSched*)iToSched, SchedDay.Slots[ctr].ResourceDetailID , SchedDay.Slots[ctr].EmployeeID);
                                                                  SchedDay.Allocate(ctr,incSecond(SchedDay.Slots[ctr].TimeStart ,SchedDay.Slots[ctr].Allocated ) ,Trunc((*ToSched*)iToSched) ,aSalesLineId);
                                                                  if fdtScheduledUpTo <incsecond( SchedDay.Slots[ctr].TimeStart , SchedDay.Slots[ctr].Allocated) then fdtScheduledUpTo:=incsecond( SchedDay.Slots[ctr].TimeStart , SchedDay.Slots[ctr].Allocated);
                                                                  fdQty1 :=fdQtycanbeBuiltonDate;
                                                                  fdQtycanbeBuiltonDate := round(fdQtycanbeBuiltonDate - (Trunc((*ToSched*)iToSched)/SelectedItem[x].SingleDuration),GeneralRoundPlaces);
                                                                  fdQty1 :=fdQty1-fdQtycanbeBuiltonDate;
                                                                  SecsScheduled := SecsScheduled +Trunc((*ToSched*)iToSched);

                                                                  s:=       inttostr(SelectedItem[x].ProcTreeId)+','+ SelectedItem[x].ProctreeCaption +',' +SelectedItem[x].ProcessDesc +',' +
                                                                            inttostr(SelectedItem[x].ProcessSequence) +',' +
                                                                            inttostr(SelectedItem[x].ProcessPartID) +',' +
                                                                            FormatdateTime('dd-mm-yyyy hh:nn:ss' , NewRec.TimeStart) +',' +
                                                                            FormatdateTime('dd-mm-yyyy hh:nn:ss' , incSecond(SchedDay.Slots[ctr].TimeStart ,SchedDay.Slots[ctr].Allocated )) +',' +
                                                                            SecondsToTime(trunc((*ToSched*)iToSched))+','+
                                                                            floattostr(fdQtycanbeBuiltonDate) +',' +
                                                                            floattostr(SelectedItem[x].ProcTreeTotalQty - fdQty2) ;

                                                                  if NewRec <> nil then begin
                                                                    dt := NewRec.Endtime;
                                                                    ToSched := ToSched - iToSched;
                                                                  end;
                                                                  if SecsScheduled >=       fdQty1 * SelectedItem[x].SingleDuration then begin
                                                                    NewRec.AddNewScheduledQty(incSecond(fdtScheduledUpTo , trunc(0-(SecsScheduled - (fdQty1 * SelectedItem[x].SingleDuration)))) ,fdQty1 );
                                                                    (*Logtext(inttostr(NewRec.id)+','+
                                                                            inttostr(NewRec.ProcesspartId)+','+
                                                                            formatdatetime('dd-mm-yy hh:nn:ss', NewRec.TimeStart)+','+
                                                                            formatdatetime('dd-mm-yy hh:nn:ss', NewRec.timeEnd)+ ',' + NewRec.LogString, 'd:\erp.log');*)
                                                                    SaleslineTree.AddNewScheduledQty(SelectedItem[x].ProcTreeId , SelectedItem[x].ProcessPartId,  incSecond(fdtScheduledUpTo , trunc(0-(SecsScheduled - (fdQty1 * SelectedItem[x].SingleDuration)))) ,fdQty1 );
                                                                    NewRec := nil;
                                                                    SecsScheduled := SecsScheduled -trunc(fdQty1 * SelectedItem[x].SingleDuration);
                                                                    fdQty2 := fdQty2 + fdQty1;
                                                                  end;
                                                                  if Round(SelectedItem[x].ProcTimeList.TotalUnScheduled,GeneralRoundPlaces) <=0 then break
                                                                  else if Round(SelectedItem[x].ProcTreeTotalQty - fdQty2,GeneralRoundPlaces) <=0 then break
                                                                  else if fdQtycanbeBuiltonDate <=0 then  begin
                                                                    calcQtycanbeBuiltonDate;
                                                                    //ToSched:=fdQtycanbeBuiltonDate * SelectedItem[x].singleDuration;
                                                                  end;
                                                                  s:= s+ ',' +FloatToStr(fdQtycanbeBuiltonDate);
                                                                  logtext(s, 'i:\temp\to be deleted\erp.log');
                                                                end;
                                                             end;
                                                             finally
                                                                fdQtycanbeBuiltonDate := Round(fdQtycanbeBuiltonDate,5);
                                                                if Samevalue(Round(fdQtycanbeBuiltonDate,5), 0, LowestcurrencyDecimalValue) then
                                                                  fdQtycanbeBuiltonDate := 0;
                                                             end;
                                                     end;

                                                   end else begin
                                                    //logtext('not possible to build on '+ formatdatetime('dd-mm-yy hh:nn:ss am/pm', dt));
                                                   end;
                                                   dt:= dateof(incday(dt,1)) ;
                                                   if round(SelectedItem[x].ProcTimeList.TotalUnScheduled,GeneralRoundPlaces) <=0 then break;
                                                 end else begin
                                                   dt:= dateof(incday(dt,1));
                                                 end;
                                                 DoStepProgressbar(pd , SelectedItem[x].ProcessDesc+':' +FormatdateTime(FormatSettings.shortdateFormat , dt));
                                               end;
                                               if (SecsScheduled <> 0) and (round(SelectedItem[x].ProcTimeList.TotalUnScheduled,GeneralRoundPlaces)=0) then begin
                                                            if NewRec <> nil then begin
                                                              NewRec.AddNewScheduledQty( fdtScheduledUpTo  ,SelectedItem[x].ProcTreeTotalQty - fdQty2 );
                                                              SaleslineTree.AddNewScheduledQty(SelectedItem[x].ProcTreeId , SelectedItem[x].ProcessPartId,  fdtScheduledUpTo  ,SelectedItem[x].ProcTreeTotalQty - fdQty2 );
                                                            end;
                                               end;

                                               //SaleslineTree.LogTreeWithProcessnBuiltQty;
                                           //end;
                                         end;
                                     end;
                                   Inc(StepCount);
                                 end; { psNotScheduled }
                                 Inc(x);
                               end;
                   Finally
                    FreeandNil(SaleslineTree);
                   End;
               end else if (SchedType = psReverse) then begin
                   { locate first record for this sale line id }
                   //clog(Schedlist.listdata);
                   for x:= SelectedList.Count -1 downto 0 do if (SelectedItem[x].SaleLineId = aSalesLineId) then Break;

                   if Schedulingfrom =0 then Schedulingfrom := endoftheday(SelectedItem[x].SaleLineShipDate - ProcPrefs.AutoProdPlanSchedGraceDays);
                   dt:= Schedulingfrom;
                   if (dt <= (Date + 1)) and (Reschedling =False) then begin
                     { can't do it so schedule forward }
                     ScheduleSalesLine(aSalesLineId,psForward);
                     exit;
                   end;
                   FreeandNil(CleanSchedList);
                   SchedList.CopySchedList(CleanSchedList);
                   try
                       while (x >= 0) and (SelectedItem[x].SaleLineId = aSalesLineId) do begin
                                  if SelectedItem[x].ProcTimeList.TotalUnScheduled = 0 then begin
                                    dec(x);
                                    Continue;
                                  end;
                         if (SelectedItem[x].ScheduleStart >0) and ((SelectedItem[x].ScheduleStart > Schedulingfrom) or (SelectedItem[x].ScheduleStart > fdtScheduledUpTo)) then dt :=SelectedItem[x].ScheduleStart
                         else if fdtScheduledUpTo<>0 then dt:= fdtScheduledUpTo
                         else dt:= Schedulingfrom;
                         fdtScheduledUpTo:= 0;

                         if SelectedItem[x].processduration <>0 then begin
                           if ProcessResourceAvailable(SelectedItem[x].ProcessResourceId) then begin
                           if round(SelectedItem[x].ProcTimeList.TotalUnScheduled , GeneralRoundPlaces)> 0 then begin
                               while (Round(SelectedItem[x].ProcTimeList.TotalUnScheduled, GeneralRoundPlaces) > 0) and (SelectedItem[x].ProcTreeTotalQty - fdQty2 >0) do begin
                                 if (dt < (Date + 1)) and (Reschedling=False) then begin
                                   RemoveScheduleForSalesLine(aSalesLineId);
                                   ScheduleSalesLine(aSalesLineId,psForward);
                                   break;
                                 end;
                                 SchedDay:= SchedList.LoadResAvailability(dateof(dt),SelectedItem[x].ProcessResourceId ,true,  Reschedling);

                                 {remove slots after the current time}
                                 for ctr :=  high(SchedDay.slots) downto low(SchedDay.Slots)  do
                                   if SchedDay.Slots[ctr].TimeStart > dt then begin
                                     SchedDay.Allocate(ctr,SchedDay.Slots[ctr].TimeStart  ,secondsbetween(SchedDay.Slots[ctr].TimeStart , SchedDay.Slots[ctr].TimeTo),0, 'Un Available');
                                   end else if SchedDay.Slots[ctr].TimeTo > dt then begin
                                       SchedDay.Allocate(ctr, dt ,secondsbetween(dt , SchedDay.Slots[ctr].TimeTo), 0,'Un Available');
                                   end;

                                 if SchedDay.AvailableSeconds > 0 then begin
                                       for ctr :=  high(SchedDay.slots) downto low(SchedDay.Slots)  do begin
                                         iAvailable := secondsbetween(SchedDay.Slots[ctr].TimeStart , SchedDay.Slots[ctr].TimeTo) - SchedDay.Slots[ctr].Allocated;
      //                                   fdt:= 0;
                                         if iAvailable >0 then begin
                                           if iAvailable >= SelectedItem[x].ProcTimeList.TotalUnScheduled then begin
                                             ToSched:= SelectedItem[x].ProcTimeList.TotalUnScheduled;
                                             fdt:=incSecond(SchedDay.Slots[ctr].TimeTo ,0-(SchedDay.Slots[ctr].Allocated+trunc(ToSched)) );
                                             SelectedItem[x].ProcTimeList.Schedule(0,fdt,ToSched , SchedDay.Slots[ctr].ResourceDetailID , SchedDay.Slots[ctr].EmployeeID);
                                             SchedDay.Allocate(ctr,fdt ,Trunc(ToSched) ,aSalesLineId);
                                           end else begin
                                             ToSched:= iAvailable;
                                             fdt:=incSecond(SchedDay.Slots[ctr].TimeTo ,0-(SchedDay.Slots[ctr].Allocated +trunc(ToSched)));
                                             SelectedItem[x].ProcTimeList.Schedule(0,fdt,ToSched, SchedDay.Slots[ctr].ResourceDetailID , SchedDay.Slots[ctr].EmployeeID);
                                             SchedDay.Allocate(ctr,fdt ,Trunc(ToSched) ,aSalesLineId);
                                           end;
                                           if fdt<>0 then if (fdtScheduledUpTo=0) or (fdtScheduledUpTo >fdt)then fdtScheduledUpTo := fdt;
                                           if SelectedItem[x].ProcTimeList.TotalUnScheduled <=0 then break;
                                         end;
                                       end;
                                       dt:= endoftheday(dateof(incday(dt,-1)));
                                       DoStepProgressbar(pd , SelectedItem[x].ProcessDesc+':' +FormatdateTime(FormatSettings.shortdateFormat , dt));
                                       if SelectedItem[x].ProcTimeList.TotalUnScheduled <=0 then break
                                       else if SelectedItem[x].ProcTreeTotalQty - fdQty2 <=0 then break;
                                     end else begin
                                       dt:= endoftheday(dateof(incday(dt,-1)));
                                     end;
                           end;
                         end; { psNotScheduled }
                         end;
                         Inc(StepCount);
                       end;
                       if fdtScheduledUpTo<> 0 then updateParettimeStart(aSalesLineId, False, SelectedItem[x].ProctreeId, SelectedItem[x].ParentProcTreeId ,SelectedItem[x].ProcessSequence, fdtScheduledUpTo);
                       Dec(x);
                     end;
                   finally
                     CleanSchedList.Free;
                   end;
               end;
             finally
                DoHideProgressbar(pd);
             end;
       end;
       {==============================================================================================================================================================}
 begin


   DoStepProgressbar;
   Result:= true;
   StepCount:= 0;
   if SelectedList.Count =0 then exit;

   if not CheckForEmpScheduleforSelectedProcesses then Exit;

     SchedList:= TSchedList.Create;
     try
       SchedList.Connection:= self.Connection;
       if (ProcPrefs.AutoProdPlanSchedType = psForward) then begin
         for listPos:= 0 to SelectedList.Count -1 do begin
          DoStepProgressbar(SelectedItem[listPos].ProcessDesc +'( Sale #' + inttostr(SelectedItem[listPos].SaleId)+')' );
           if SelectedItem[listPos].processduration <> 0 then
             ScheduleSalesLine(SelectedItem[listPos].SaleLineId, ProcPrefs.AutoProdPlanSchedType , StartSchedulingon );
         end;
       end else if (ProcPrefs.AutoProdPlanSchedType = psReverse) then begin
         for listPos:= SelectedList.Count -1 downto 0 do begin
          DoStepProgressbar(SelectedItem[listPos].ProcessDesc +'( Sale #' + inttostr(SelectedItem[listPos].SaleId)+')');
           if SelectedItem[listPos].processduration <> 0 then
             ScheduleSalesLine(SelectedItem[listPos].SaleLineId, ProcPrefs.AutoProdPlanSchedType, StartSchedulingon );

         end;
       end
     finally
       SchedList.Free;
     end;
end;

procedure TProcItemList.SaveToFile(const aFileName: string);
var
  sl: TStringlist;
  x: integer;
begin
  sl:= TStringList.Create;
  try
    for x:= 0 to Count -1 do begin
      sl.Add(Item[x].CommaText);
    end;
    sl.SaveToFile(aFileName);
  finally
    sl.Free;
  end;
end;

procedure TProcItemList.Delete(const index: integer);
begin
  fList.Delete(index);
end;

function TProcItemList.GetItemByTreeId(const aTreeId: integer): TProcItem;
var
  x: integer;
begin
  Result:= nil;
  for x:= 0 to self.Count -1 do begin
    if self.Item[x].ProcTreeId = aTreeId then begin
      Result:= self.Item[x];
      break;
    end;
  end;
end;

function TProcItemList.getSelected(const Index: integer): Boolean;
begin
  result := Selectedlist.inlist(index);
end;

{ TSchedList }

constructor TSchedList.Create;
begin
  inherited;
  fList:= TObjectList.Create(true);
end;

destructor TSchedList.Destroy;
begin
  fList.Free;
  fResourceIdList.Free;
  inherited;
end;

procedure TSchedList.Clear;
var
  ctr:Integer;
begin
  for ctr:= 0 to count-1 do begin
    SetLength(Item[ctr].Slots,0);
    finalize(Item[ctr].Slots);
  end;
  fList.Clear;
end;

procedure TSchedList.ClearUnAvailables;
var
  x1:Integer;
begin
  for x1 := 0 to count-1 do
    Item[x1].ClearUnAvailables;
end;

procedure TSchedList.CopySchedList(var cleanSchedList: TSchedList);
var
  x1,x2:Integer;
  colRec : TColRec;
begin
  if cleanSchedList = nil then begin
    cleanSchedList :=TSchedList.create;
    cleanSchedList.connection := Self.connection;
  end else begin
    cleanSchedList.Clear;
  end;

  if count > 0 then
    for x1:= 0 to count-1 do begin
      colRec          := TColRec.Create;
      colRec.Id       := Item[x1].id;
      colRec.Date     := Item[x1].Date;
      colRec.Allocated:= Item[x1].Allocated;
      if length(Item[x1].slots)>0 then
        for x2:= low(Item[x1].slots) to high(Item[x1].slots) do begin
          SetLength(colRec.slots, length(colRec.Slots)+1);
          colRec.Slots[high(colRec.Slots)].ResourceID          	    := Item[x1].slots[x2].ResourceID;
          colRec.Slots[high(colRec.Slots)].ResourceDetailID    	    := Item[x1].slots[x2].ResourceDetailID;
          colRec.Slots[high(colRec.Slots)].EmpResProcScheduleID	    := Item[x1].slots[x2].EmpResProcScheduleID;
          colRec.Slots[high(colRec.Slots)].EmployeeID          	    := Item[x1].slots[x2].EmployeeID;
          colRec.Slots[high(colRec.Slots)].TimeStart           	    := Item[x1].slots[x2].TimeStart;
          colRec.Slots[high(colRec.Slots)].TimeTo              	    := Item[x1].slots[x2].TimeTo;
          colRec.Slots[high(colRec.Slots)].Allocated           	    := Item[x1].slots[x2].Allocated;
          colRec.Slots[high(colRec.Slots)].Status              	    := Item[x1].slots[x2].Status;
        end;
        cleanSchedList.fList.Add(colRec);
    end;
end;

function TSchedList.GetCount: integer;
begin
  Result:= fList.Count;
end;

function TSchedList.GetItem(const index: integer): TColRec;
begin
  Result:= TColRec(fList[index]);
end;

function TSchedList.Listdata: String;
var
  x1:Integer;
begin
  REsult := '';
  for x1 := 0 to count-1 do
    REsult := result + Item[x1].commatext;
end;

function TSchedList.LoadResAvailability(const aDate: TDateTime; const ProcResourceId: integer;
                             const CreateIfNotFound: boolean = true; Reschedling:Boolean =False): TColRec;
var
  x: integer;
begin
  Result:= nil;
  for x:= 0 to Count -1 do begin
    if (Item[x].Id = ProcResourceId) and (Trunc(Item[x].Date) = Trunc(aDate)) then begin
      Result:= Item[x];
      break;
    end;
  end;
  if not Assigned(Result) and CreateIfNotFound then begin
    Result          := TColRec.Create;
    Result.Id       := ProcResourceId;
    Result.Date     := aDate;
    ResourceProcessCapacityForDate(REsult , ProcresourceID , aDate , 0, connection);
    fList.Add(Result);
  end;
end;

function TSchedList.GetConnection: TERPConnection;
begin
  if Assigned(fConnection) then
    Result:= fConnection
  else
    Result:= CommonDbLib.GetSharedMyDacConnection;
end;

procedure TSchedList.SetConnection(const Value: TERPConnection);
begin
  fConnection:= Value;
end;
procedure TSchedList.LogList(aID:Integer=0; adate:TDateTime =0);
var
  x,y: integer;
  Rec: TColRec;
begin
  if not devmode then exit;

  DoShowProgressbar(Count, 'Loging : Resource Usage / Availability');
  try
    //clog('ID,Date,Allocated,ResourceID,ResourceDetailID,EmpResProcScheduleID,EmployeeID,timestart,timeEnd,Allocated,Status,saleLineID');
    for x:= 0 to Count -1 do begin
      Rec:= Item[x];
      if ((aID=0) or (aid =REc.Id)) and
        ((adate=0) or (trunc(adate) = trunc(REc.date))) then begin
        for y := low(REc.Slots) to high(REc.Slots) do begin
            Logtext(inttostr(REc.Id)+',' +
                     FormatDatetime('DD-MM-yyyy',REc.Date)+','+
                     Floattostr(REc.Allocated)+','+
                     inttostr(REc.Slots[y].ResourceID)+','+
                     inttostr(REc.Slots[y].ResourceDetailID)+','+
                     inttostr(REc.Slots[y].EmpResProcScheduleID)+','+
                     inttostr(REc.Slots[y].EmployeeID)+','+
                     FormatDateTime('DD-MM-YYYY hh:nn:ss am/pm' , REc.Slots[y].TimeStart)+','+
                     FormatDateTime('DD-MM-YYYY hh:nn:ss am/pm' , REc.Slots[y].TimeTo)+','+
                     Floattostr(REc.Slots[y].Allocated)+','+
                     REc.Slots[y].Status+','+
                     Inttostr(REc.Slots[y].SaleLineID)+','+
                     Floattostr(REc.AvailableSeconds), 'i:\temp\to be deleted\SchedList.log');
            //DoStepProgressbar( '(' + inttostr(x+1)+' of ' + inttostr(count)+') '+FormatDatetime('DD-MM-yyyy',REc.Date) +'  --   (' + inttostr(y+1)+' of ' + inttostr(high(REc.Slots)+1)+')') ;
        end;

      end;
    end;
  finally
   DoHideProgressbar;
  end;
end;
procedure TSchedList.PopulateForDateRange(const aDateFrom,aDateTo: TDateTime);
var
  Rec: TColRec;
  dt: TDateTime;
  x: integer;
  fsResName:String;
begin
  fList.Clear;
  DoShowProgressbar(ResourceIdList.Count * DaysBetween(aDateFrom,aDateTo), 'Checking for Resource Usage / Availability');
  try
    for x:= 0 to ResourceIdList.Count -1 do begin
      dt:= aDateFrom;
      fsResName:= ProcResName(ResourceIdList[x]);
      while dt <= aDateTo do begin
        Rec:= TColRec.Create;
        Rec.Id:= ResourceIdList[x];
        Rec.Date:= dt;
        ResourceProcessCapacityForDate(Rec, Rec.Id , dt , 0, connection);
        fList.Add(Rec);
        dt:= dt + 1;
        DoStepProgressbar('('+ inttostr(x+1) +' of ' + inttostr(ResourceIdList.Count) +')  '+ fsResName+' : ' + Formatdatetime(FormatSettings.ShortdateFormat , dt)) ;
      end;
    end;
  finally
    DoHideProgressbar;
  end;
end;

procedure TSchedList.SummaryForDate(const aDate: TDateTime;const ResourceIdList: TIntegerList; var Capacity, Available,Overallocated: double);
var
  x: integer;
begin
  for x:= 0 to fList.Count -1 do begin
    if ResourceIdList.InList(Item[x].Id) and (dateof(Item[x].Date) = dateof(aDate)) then begin
      Capacity:= Capacity + Item[x].Capacity;
      Available:= Available + Item[x].Available;
      if Item[x].Available <0 then Overallocated := Overallocated + 0- Item[x].Available;
    end;
  end;
end;
function TSchedList.ResourceCapacityFordate(const aDate: TDateTime; aResID:Integer):double;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to fList.Count -1 do begin
    if (Item[x].Id = aResID) and (dateof(Item[x].Date) = dateof(aDate)) then begin
      result:= Item[x].Capacity;
      exit;
    end;
  end;
end;
function TSchedList.AvailableForDate(const aDate: TDateTime; const aResourceId: integer): double;
var
  rec: TColRec;
begin
  Result:= 0;
  rec:= self.LoadResAvailability(aDate, aResourceId);
  if Assigned(rec) then
    Result:= rec.Available;
end;

procedure TSchedList.AdjustForDate(const aDate: TDateTime; const aResourceId: integer; const aValue: double);
var
  rec: TColRec;
begin
  rec:= self.LoadResAvailability(aDate, aResourceId);
  if Assigned(rec) then
    rec.Allocated:= rec.Allocated + aValue;
end;

function TSchedList.GetResourceIdList: TIntegerList;
var
  qry: TERPQuery;
begin
  if not Assigned(fResourceIdList) then begin
    fResourceIdList:= TIntegerList.Create;
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= Connection;
      qry.SQL.Text:=
       'SELECT ProcResourceId'+
       ' FROM tblProcResource WHERE UsedWithProductsInSeq ="F" and  ResourceAvailable = "T"';
      qry.Open;
      while not qry.Eof do begin
        fResourceIdList.Add(qry.FieldByName('ProcResourceId').AsInteger);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
  end;
  Result:= fResourceIdList;
end;

{ TProcTimeList }

constructor TProcTimeList.Create;
begin
  Inherited;
  fList:= TObjectList.Create(true);
end;

destructor TProcTimeList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TProcTimeList.Add(const aItem: TProcessTimeNDS);
begin
  fList.Add(aItem);
end;

procedure TProcTimeList.Clear;
begin
  fList.Clear;
end;

function TProcTimeList.GetCount: integer;
begin
  Result:= fList.Count;
end;

function TProcTimeList.GetDirty: boolean;
var
  x: integer;
begin
  Result:= false;
  for x:= 0 to Count -1 do begin
    if Item[x].Dirty then begin
      Result:= true;
      break;
    end;
  end;
end;

function TProcTimeList.GetItem(const index: integer): TProcessTimeNDS;
begin
  Result:= TProcessTimeNDS(fList[index]);
end;
function TProcTimeList.GetItembyProcTimeID(const fProcTimeID: integer): TProcessTimeNDS;
  var
    x: integer;
begin
  Result:= nil;
  for x:= 0 to Count -1 do begin
    if Item[x].ID = fProcTimeID then begin
      Result := Item[x];
      Exit;
    end;
  end;

end;

Procedure TProcTimeList.DeleteItem(const index: integer);
begin
  flist.Delete(index);
end;
function TProcTimeList.ProcesstimeIDs:String;
  var
    x: integer;
begin
  Result:= '';
  for x:= 0 to Count -1 do begin
    if Result<> '' then Result := Result+',';
    Result := Result + inttostr(Item[x].ID);
  end;
end;

procedure TProcTimeList.Save;
var
  x,y: integer;
begin
  if count >1 then
  for x:=  Count -1 downto 0 do begin
    if Item[x].Deleted then begin
      Item[x].Delete;
    end else if Item[x].duration <=0 then begin
      Item[x].Deleted := True;
      Item[x].Delete;
    end;
  end;


  //Adjacent slots are merged.
  // ObjCapacityPlanningganttchart : TCapacityPlanningGanttChart.Makeconnections can't be done as the slots are merged - Dene approves.
  x:= 0;
  y:= 1;

  if count >1 then
    while (x<= Count -2) and (Y <= count-1) do begin
      if not Item[x].Deleted then
        if (dateof(Item[x].Timestart) = dateof(Item[y].Timestart)) and
           (Item[x].ProcessPartId     = Item[y].ProcessPartId) and
           (Item[x].ResourcedetailsID = Item[y].ResourcedetailsID) and
           (Item[x].EmployeeId        = Item[y].EmployeeId) and
           (incsecond(Item[x].Timestart , trunc(Item[x].Duration)) = Item[y].Timestart) then begin
           Item[x].Duration := Item[x].Duration + Item[y].Duration;
           Item[x].timeend := Item[y].timeend;
           Item[y].Deleted := True;
           y:= y+1;
           continue;
        end;
        x:= y;
        y:= x+1;
    end;

  for x:=  Count -1 downto 0 do begin
    if Item[x].Deleted then begin
      Item[x].Delete;
    end else if Item[x].duration <=0 then begin
      Item[x].Deleted := True;
      Item[x].Delete;
    end;
  end;


  for x:= 0 to Count -1 do begin
    if Item[x].Deleted then begin
    end else if Item[x].duration <=0 then begin
    end else if not(Item[x].Deleted) and (Item[x].duration >0) then begin
      Item[x].SaveNoCheck;
    end;
  end;
end;

function TProcTimeList.TotalScheduled: double;
var
  x: integer;
begin
  Result:= 0;
  for x:= 0 to Count -1 do begin
    if not Item[x].Deleted then
      Result:= Result + Item[x].Duration;
  end;
end;

function TProcTimeList.SchedTimeForDate(const aDate: TDateTime): double;
var
  x: integer;
begin
  Result:= 0;
  for x:= 0 to Count -1 do begin
    if (Dateof(Item[x].TimeStart) = Dateof(aDate)) and (not Item[x].Deleted) then begin
      Result:= Result + Item[x].Duration;
      //break;
    end;
  end;
end;

function TProcTimeList.TotalUnScheduled: double;
begin
  Result:= ProcItem.ProcessDuration - TotalScheduled;
end;

function TProcTimeList.Schedule(const OldDate, NewDate: TDateTime; const aDuration: double; const aDetailID:Integer; const aEmpID:Integer): TProcessTimeNDS;
var
  x: integer;
  OldRec, NewRec: TProcessTimeNDS;
begin
  result := nil;
  OldRec:= nil;
  NewRec:= nil;

  for x:= 0 to Count -1 do begin
    if (item[x].ResourcedetailsID = aDetailId) and (item[x].EmployeeId = aEmpID) and  (Dateof(Item[x].TimeStart) = OldDate) then
      OldRec:= Item[x];
    if (item[x].ResourcedetailsID = aDetailId) and (item[x].EmployeeId = aEmpID) and  (dateof(Item[x].TimeStart) = NewDate) then
      NewRec:= Item[x];
  end;

  if (OldDate > 0) and Assigned(OldRec) then begin
    OldRec.Duration:= Round(OldRec.Duration - aDuration,GeneralRoundPlaces);
    if OldRec.Duration <= 0 then
      OldRec.Deleted:= true;
  end;

  if (NewDate > 0) then begin
    if not Assigned(NewRec) then begin
      NewRec:= TProcessTimeNDS.Create(nil);
      NewRec.Storer:= self.ProcItem.ItemList.Storer;
      NewRec.ProcessPartId:= self.ProcItem.ProcessPartId;
      NewRec.TimeStart:= NewDate;
      NewRec.ResourcedetailsID := aDetailID;
      //NewRec.EmpResProcScheduleID := aEmprosterID;
      NewRec.EmployeeId := aEmpID;
      self.Add(NewRec);
    end;
    NewRec.Duration:= Round(NewRec.Duration + aDuration, GeneralRoundPlaces);
    NewRec.Deleted:= false;
    Result := NewRec;
  end;

  UpdateProcItem;
end;

procedure TProcTimeList.Unschedule(const aId: integer);
begin
  if not Item[aId].Deleted then begin
    Item[aId].Duration:= 0;
    Item[aId].Deleted:= true;
    UpdateProcItem(False);
  end;
end;
procedure TProcTimeList.UpdateProcItem(CreatenewifNotfound:boolean =True);
var
  FirstDate: TDateTime;
  x: integer;
  NewRec: TProcessTimeNDS;
  found: boolean;
begin
  FirstDate:= 0;
  found:= false;
  for x:= 0 to Count -1 do begin
    if not Item[x].Deleted then begin
      found:= true;
      if FirstDate = 0 then
        FirstDate:= Item[x].TimeStart
      else if Item[x].TimeStart < FirstDate then
        FirstDate:= Item[x].TimeStart
    end;
  end;
  if not(found) and CreatenewifNotfound then begin
    NewRec:= TProcessTimeNDS.Create(nil);
    NewRec.Storer:= self.ProcItem.ItemList.Storer;
    NewRec.ProcessPartId:= self.ProcItem.ProcessPartId;
    NewRec.TimeStart:= ProcItem.ProcessTimeStart;
    NewRec.Duration:= self.TotalUnScheduled;
    self.Add(NewRec);
    FirstDate :=ProcItem.ProcessTimeStart;
  end;
  //if FirstDate > 0 then
    ProcItem.ProcessTimeStart:= FirstDate;

  if (ProcItem.ProcessTimeStart = 0) and (ProcItem.ProcessStatus in [psScheduled, psStarted]) then
    ProcItem.ProcessStatus:= psNotScheduled
  else if (ProcItem.ProcessTimeStart > 0) and (ProcItem.ProcessStatus = psNotScheduled) then
    ProcItem.ProcessStatus:= psScheduled;

//  if (ProcItem.ProcessStatus = psScheduled) and (ProcItem.
end;

Function REsourceNameforID(Const aid:Integer):string;
begin
  With Commondblib.TempMyQuery do try
    SQL.Add('SELECT ResourceName FROM tblProcResource where ProcResourceId = ' + inttostr(aid));
    open;
    REsult:= Fieldbyname('ResourceName').AsString;
  finally
    closenFree;
  end;
end;


end.
