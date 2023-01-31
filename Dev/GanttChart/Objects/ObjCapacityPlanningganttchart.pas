unit ObjCapacityPlanningganttchart;

interface

uses ObjGanttChart , erpdbcomponents, classes, ProcCapacityPlanningObj, wgsGanttBar , BusObjProcessTimeNDS , IntegerListObj, wgsTreeHeaderCell;

type
  TRowListnGraphLink = class(TObject)
    ListRowIndex: integer;
    ChartRowindex: integer;
  end;
  TRowListnGraphLinkList = Class(TListObject)
    Private
    function getchartRowItem(const chartIndex: integer): TRowListnGraphLink;
    function getListRowItem(const ListIndex: integer): TRowListnGraphLink;
    function getchartRowIndex(const chartIndex: integer): integer;
    function getListRowIndex(const ListIndex: integer): integer;
    protected
    Public
      procedure Add(const aItem: TRowListnGraphLink); Reintroduce;
      property chartRowItem[const chartIndex: integer]: TRowListnGraphLink read getchartRowItem;
      property ListRowItem[const ListIndex: integer]: TRowListnGraphLink read getListRowItem;
      property chartRowIndex[const chartIndex: integer]: integer read getchartRowIndex;
      property ListRowIndex[const ListIndex: integer]  : integer read getListRowIndex;
      Procedure NewEntry(ChartRowindex , ListRowIndex:Integer);
  End;

  TCapacityPlanningGanttChart = class(TGanttChart)
  private
    //SchedList: TSchedList;
    fConnection: TERPConnection;
    fbShowfinalised: boolean;
    fiListfilterSaleId: Integer;
    fListfilterStepIDList: TIntegerList;
    fsListfiltercustomerName: String;
    RowListnGraphLinkList : TRowListnGraphLinkList;
    ProcItemstoReschedule :String;
    fbLoading: boolean;
    fbSaving: boolean;
    fbRescheduling :Boolean;
    //PrevBar , ThisBar : TWGSGanttBar;
    procedure Setconnection(const Value: TERPConnection);
    procedure Makeconnections;
    procedure Makeconnection(Bar1, Bar2: TWGSGanttBar; Contype: TBarConType);
    Procedure MakeProcBar(timeFrom , TimeTo :TDatetime; Row:Integer ; ProcTreeId, ProcessPartId , ProcessTimeId:Integer ; barhint:String );
    function getchartdate: TDate;
    procedure setchartdate(const Value: TDate);
    function getSaleID              :Integer ;
    function getSaleCustomerName    :String ;
    function getSaledate            :Tdatetime  ;
    function getSaleLineProductname : String ;
    function getSaleLineQuantity    :double ;
    function getProctreecaption     :String ;
    function getProctreetotalQty    :double ;
    function getProcessDesc         :String ;
    function getProcessPartDuration:Integer;
    function getProcessStatus       :String ;
    function getSelectedrowdetails: String;
    function getProctreeId: Integer;
    procedure Reschedule(ProctreeID:Integer; OldDate, NewDate: TDateTime;Duration: double);
    procedure SelectRelatedRows(ProcTreeId, parentID: Integer;Movingforward: Boolean; OldDate, NewDate: TDateTime);


    (*procedure MakeConnection(Contype:TBarConType);*)
  Protected
      Procedure DoOnAfterBarResize   (Bar : TWGSGanttBar) ;Override;
      Procedure DoOnAfterBarAdd      (Bar : TWGSGanttBar) ;Override;
      Procedure DoOnAfterBarMove     (Bar : TWGSGanttBar) ;Override;
      Procedure DoOnAfterBarMoveDetailed  (Bar : TWGSGanttBar; AFromSummaryBar:Boolean) ;Override;
      Procedure DoOnTreeColumnMove(column:TWGSTreeHeaderCell;width : integer);override;
      Procedure DoOnAfterBarDelete   (Bar : TWGSGanttBar) ;Override;
  public
    RowList: TProcItemList;
    Constructor Create(AOwner :TComponent); Overload;Override;
    Destructor Destroy; override;
    Procedure RefreshTree(Dtfrom , dtTo :TDateTime);Override;
    Property Connection :TERPConnection read fConnection write Setconnection;
    Property Showfinalised :boolean read fbShowfinalised write fbShowfinalised;
    Property ChartDate:TDate read getchartdate write setchartdate;
    procedure ClearGraph;Override;
    function ListindexforRow(Const RowIndex:Integer):Integer;
    function FocusedProcItem :TProcItem;
    function FindBar(const ProcessPartID:Integer):TGanttBar;



    {Properties for filterring the list to populate for the chart}
    Property ListfilterStepIDList     :TIntegerList read fListfilterStepIDList    write fListfilterStepIDList;
    Property Listfiltercustomername   :String       read fsListfiltercustomerName write fsListfiltercustomerName;
    property ListfilterSaleId         :Integer      read fiListfilterSaleId       write fiListfilterSaleId;

    {properties of the sleected Row}
    Property SaleID               :Integer    read getSaleID;
    Property SaleCustomerName     :String     read getSaleCustomerName;
    Property Saledate             :Tdatetime  read getSaledate;
    Property SaleLineProductname  :String     read getSaleLineProductname;
    Property SaleLineQuantity     :double     read getSaleLineQuantity;
    Property Proctreecaption      :String     read getProctreecaption;
    Property ProctreetotalQty     :double     read getProctreetotalQty;
    Property ProcessDesc          :String     read getProcessDesc;
    Property ProcessPartDuration  :Integer    read getProcessPartDuration;
    Property ProcessStatus        :String     read getProcessStatus;
    Property ProctreeId           :Integer    read getProctreeId;
    Property Selectedrowdetails :String read getSelectedrowdetails;
    Function  SearchBar(const ProcTreeID:Integer;CurBar:TGanttBar=nil):TGanttBar;
    function logchart:String;
    Property Loading :boolean read fbLoading write fbLoading;
    Property Saving :boolean read fbSaving write fbSaving;

end;
implementation

uses sysutils , ProcessUtils, DAteutils, CommonLib , wgsBarConnection,
  tcConst, BusObjProcPrefs, ManufactureLib,wgsSummaryBar , wgsTaskBar, ProgressDialog , dialogs;

{ TCapacityPlanningGanttChart }

procedure TCapacityPlanningGanttChart.ClearGraph;
begin
  inherited;
  RowListnGraphLinkList.Clear;
end;

constructor TCapacityPlanningGanttChart.Create(AOwner: TComponent);
begin
  inherited;
  fbRescheduling:= False;
  fbLoading:=False;
  fbSaving:=False;
  RowListnGraphLinkList := TRowListnGraphLinkList.Create;
  (*SchedList:= TSchedList.Create;
  SchedList.Connection:= Connection;*)
  RowList:= TProcItemList.Create;
  RowList.Connection:= Connection;
  fconnection:=nil;
  fbShowfinalised:= False;
  fiListfilterSaleId:=0;
  fListfilterStepIDList:=nil;
  fsListfiltercustomerName:='';
  (*PrevBar := nil;
  ThisBar := nil;*)
end;

destructor TCapacityPlanningGanttChart.Destroy;
begin
  //SchedList.Free;
  Freeandnil(RowList);
  Freeandnil(RowListnGraphLinkList);
  inherited;
end;

procedure TCapacityPlanningGanttChart.DoOnAfterBarAdd(Bar: TWGSGanttBar);
begin
  inherited;
end;

procedure TCapacityPlanningGanttChart.DoOnAfterBarDelete(Bar: TWGSGanttBar);
var
  ProcItem:TProcItem;
  ProcessTime:TProcessTimeNDS;
begin
  inherited;
  if Loading or saving then exit;
  With GanttBars.ItembyBar[bar] do begin
    ProcItem := Rowlist.ItemByTreeId[ProctreeID];
    if Assigned(ProcItem) then begin
      ProcessTime:= ProcItem.ProcTimeList.ItembyProcTimeID[ProcessTimeId];
      if Assigned(ProcessTime) then begin
        ProcessTime.Deleted:= true;
      end;
    end;
  end;

end;
procedure TCapacityPlanningGanttChart.DoOnTreeColumnMove(column:TWGSTreeHeaderCell;width : integer); begin end;


procedure TCapacityPlanningGanttChart.DoOnAfterBarMove(Bar: TWGSGanttBar);
begin

end;


procedure TCapacityPlanningGanttChart.DoOnAfterBarMoveDetailed(Bar: TWGSGanttBar; AFromSummaryBar: Boolean);
var
  ProcItem:TProcItem;
  ProcessTime:TProcessTimeNDS;
  ctr:Integer;
  dt:TDateTime;
begin
  inherited;
  if  (AFromSummaryBar) then begin
    // group moved
  end else if (bar is TWGSTaskBar) then begin
    if Loading or saving then exit;
    if fbRescheduling then exit;
    fbRescheduling := True;
    try
      if not(IsWorkingday(bar.startdate)) then begin
        dt:=bar.startdate;
        ctr:= 0;

        if DateFromBeforechange < dt then
          while not(IsWorkingday(incday(dt,ctr))) do ctr:= ctr+1
        else while not(IsWorkingday(incday(dt,ctr))) do ctr:= ctr-1;

        Bar.StartDate := incday(Bar.StartDate ,ctr);
      end;
      With GanttBars.ItembyBar[bar] do begin
        ProcItem := Rowlist.ItemByTreeId[ProctreeID];
        if Assigned(ProcItem) then begin
          ProcessTime:= ProcItem.ProcTimeList.ItembyProcTimeID[ProcessTimeId];
          if Assigned(ProcessTime) then begin
            ProcessTime.TimeStart := bar.StartDate;
            ProcessTime.timeend := bar.EndDate;
          end;
        end;
      end;
      if ProcTreeIDofBarChanging <> 0 then begin
        Reschedule(ProcTreeIDofBarChanging , DateFromBeforechange, bar.StartDate , bar.duration);
      end;
      SendEvent(BarRescheduled , '');
    finally
      fbRescheduling:= False;
    end;
  end;
end;

procedure TCapacityPlanningGanttChart.DoOnAfterBarResize(Bar: TWGSGanttBar);
var
  ProcItem:TProcItem;
  ProcessTime:TProcessTimeNDS;
begin
  inherited;
  if Loading or saving then exit;
  if fbRescheduling then exit;
  fbRescheduling:= TRue;
  try
    With GanttBars.ItembyBar[bar] do begin
      ProcItem := Rowlist.ItemByTreeId[ProctreeID];
      if Assigned(ProcItem) then begin
        ProcessTime:= ProcItem.ProcTimeList.ItembyProcTimeID[ProcessTimeId];
        if Assigned(ProcessTime) then begin
          ProcessTime.TimeStart := bar.StartDate;
          ProcessTime.timeend := bar.EndDate;
        end;
      end;
    end;
    if ProcTreeIDofBarChanging <> 0 then begin
      Reschedule(ProcTreeIDofBarChanging , DateFromBeforechange, DateFromAfterchange , bar.duration);
    end;
    SendEvent(BarRescheduled , '');
  finally
    fbRescheduling:= False;
  end;
end;

function TCapacityPlanningGanttChart.getchartdate: TDate;
begin
  result:= GanttGraph.document.StartDate ;
end;

procedure TCapacityPlanningGanttChart.RefreshTree(Dtfrom , dtTo :TDateTime);
var
  x,y: integer;
  SaleID:String;
  PrevgroupRow:Integer;
  shint:String;
  s:string;
  Procedure ResetRowListnGraphLinkList(fromRow,Torow:Integer);
  var
    ctr:Integer;
  begin
    for ctr:= torow downto fromRow do begin
      if RowListnGraphLinkList.chartRowItem[ctr] <> nil then
        RowListnGraphLinkList.chartRowItem[ctr].ChartRowindex := RowListnGraphLinkList.chartRowItem[ctr].ChartRowindex  +1;
    end;

  end;
  Procedure MakeGroup;
  begin
    if Groupingfield = '' then exit;
    if MasterDs.FindField(Groupingfield) = nil then exit;
    if (x>=RowList.count) or (SaleID <>RowList[x].SaleDocNumber) then begin
      ResetRowListnGraphLinkList(PrevgroupRow,Rowcount-1);
      DataSource.RowsGroup(PrevgroupRow,Rowcount-1);
      PrevgroupRow:= Rowcount;
      if x < RowList.count then SaleID := RowList[x].SaleDocNumber;
    end;
  end;
  Procedure PopulateForDateRange;
    var
      SchedList: TSchedList;
  begin
    exit; // not sure y this is done. the list is populated in  a local variable and never used
    if fConnection = nil then exit;
    SchedList:= TSchedList.Create;
    try
      SchedList.Connection:= fConnection;
      SchedList.Connection:= Connection;
      SchedList.PopulateForDateRange(DtFrom, DtTo);
    finally
      SchedList.Free;
    end;
  end;
begin
try
  DoShowProgressbar(200, WAITMSG  , '' , True , True, nil , False);
  try
    clearGraph;
    DoStepProgressbar('Checking for Date Range');PopulateForDateRange;
    DoStepProgressbar('Loading the List');RowList.LoadList(Dtfrom, dtTo, ListfilterStepIDList , ListfiltercustomerName , ListfilterSaleId);
    if (not(ShowFinalised)) then begin
      x:= 0;
      while x < RowList.Count do begin
        if (RowList[x].ProcTreeComplete) or (RowList[x].ProcessStatus = psComplete)   then begin
          DoStepProgressbar('RowList.delete');RowList.delete(x);
        end else
          Inc(x);
      end;
    end;
    DoStepProgressbar('RowList.countcheck');if Rowlist.Count =0 then exit;
    PrevgroupRow:= 0;
    SaleID := RowList[0].SaleDocNumber;
    DoShowProgressbar(200, WAITMSG  , '' , True , True, nil , False);
    for x:= 0 to RowList.Count -1 do begin
      DoStepProgressbar('X:' +inttostr(x)+' of ' + inttostr(RowList.Count -1));
      MakeGroup;
      Addrow(Rowcount);
      CellData['Ref'              , Rowcount-1] := RowList[x].SaleDocNumber;
      CellData['Customer'         , Rowcount-1] := RowList[x].SaleCustomerName;
      CellData['Sale Date'        , Rowcount-1] := FormatDateTime('dd/mm/yy',RowList[x].SaleLineShipDate);
      CellData['Product'          , Rowcount-1] := RowList[x].SaleLineProductName;
      CellData['Qty'              , Rowcount-1] := FloatToStr(RowList[x].SaleLineQuantity);
      CellData['Tree Item'        , Rowcount-1] := RowList[x].ProcTreeCaption;
      CellData['Tree Qty'         , Rowcount-1] := FloatTostr(RowList[x].ProcTreeTotalQty);
      CellData['Process'          , Rowcount-1] := RowList[x].ProcessDesc;
      CellData['Duration'         , Rowcount-1] := SecondsToTime(trunc(RowList[x].ProcessDuration));
      CellData['Status'           , Rowcount-1] := ProcessPartStatusToUserStr(RowList[x].ProcessStatus);
      CellData['Goods on Order'   , Rowcount-1] := RowList[x].GoodsOnOrderstatus;
      RowListnGraphLinkList.NewEntry(Rowcount-1 , x);
      if RowList[x].ProcTimeList.Count>0 then
        for y := 0 to RowList[x].ProcTimeList.Count-1 do begin
          if DateRangeWithin(RowList[x].ProcTimeList[y].timestart ,
                             incsecond(RowList[x].ProcTimeList[y].timestart , trunc(RowList[x].ProcTimeList[y].duration)),
                             DtFrom ,
                             DtTo) then begin
              s:= 'Sale #' + inttostr(RowList[x].saleID) +' ' +
                      RowList[x].saleLineProductname +' ' +
                      RowList[x].ProcessDesc +' ' +
                      'From ' + FormatdateTime(shortDateformat +' HH:NN:SS am/pm' , RowList[x].ProcTimeList[y].TimeStart) +
                      SecondsToTime(trunc(RowList[x].ProcTimeList[y].Duration));
              //logtext(s);
              DoStepProgressbar(s);
              if RowList[x].ProcessStatus <> psNotScheduled then begin
                shint := inttostr(RowList[x].ProcTimeList[y].ID)+'-->' +RowList[x].ProcessDesc + ' - ' +
                        Quotedstr(Secondstotime(trunc(RowList[x].ProcTimeList[y].Duration) , true , true))  + ' from ' + FormatDatetime(FormatSettings.ShortdateFormat +' hh:nn:ss am/pm',  RowList[x].ProcTimeList[y].TimeStart ) ;
                try
                MakeProcBar(RowList[x].ProcTimeList[y].TimeStart,
                            incSecond(RowList[x].ProcTimeList[y].TimeStart, trunc(RowList[x].ProcTimeList[y].Duration)),
                            Rowcount-1 ,
                            RowList[x].ProctreeID,
                            RowList[x].ProcessPartId ,
                            RowList[x].ProcTimeList[y].ProcessTimeId,
                            shint );
                except
                  on E:EXception do begin
                  end;
                end;
              end;
          end;
        end;
    end;
    MakeGroup;
    Makeconnections;
    finally
      DoHideProgressbar;
    end;
finally
  rePaint;
end;
end;
function TCapacityPlanningGanttChart.FindBar(const ProcessPartID:Integer):TGanttBar;
var
  ctr:Integer;
begin
  result:= nil;
  for ctr:= 0 to GanttBars.Count-1 do
    if GanttBars.Item[ctr] is TGanttBar then begin
         if TGanttBar(GanttBars.Item[ctr]).ProcessPartId = ProcessPartID then begin
           Result:= TGanttBar(GanttBars.Item[ctr]);
           Exit;
         end;
    end;

end;
function TCapacityPlanningGanttChart.logchart:String;
var
  ctr:Integer;
  s:String;
begin
  s:= '';
  if GanttBars.count > 0 then
  for ctr:= 0 to GanttBars.Count-1 do
    if GanttBars.Item[ctr] is TGanttBar then begin
      s:=s + NL+ 'ProcesstimeID:' + inttostr(TGanttBar(GanttBars.Item[ctr]).ProcessTimeId) +
          ',ProcessPartId:' + inttostr(TGanttBar(GanttBars.Item[ctr]).ProcessPartId)+
          ',Rowno:' + inttostr(TGanttBar(GanttBars.Item[ctr]).Rowno)+
          ',timestart:' + formatdatetime('dd-mm-yyyy hh:nn:ss' , TGanttBar(GanttBars.Item[ctr]).TimeStart) +
          ',timeend:' + formatdatetime('dd-mm-yyyy hh:nn:ss' , TGanttBar(GanttBars.Item[ctr]).timeend) ;
    end;



  try
    if RowListnGraphLinkList.count =0 then exit;
    for ctr:= 0 to RowListnGraphLinkList.count-1 do begin
      s:= s+ inttostr(TRowListnGraphLink(RowListnGraphLinkList[ctr]).chartrowindex)+':' +inttostr(TRowListnGraphLink(RowListnGraphLinkList[ctr]).Listrowindex)+NL;
    end;
  finally
    result:= s;
  end;
end;
procedure TCapacityPlanningGanttChart.setchartdate(const Value: TDate);
begin
  GanttGraph.document.StartDate := Value;
  Repaint;
end;

Function  TCapacityPlanningGanttChart.SearchBar(const ProcTreeID:Integer;CurBar:TGanttBar=nil):TGanttBar;
var
  ctr:Integer;
begin
  Result:= nil;
  if GanttBars.Count=0 then exit;
  for ctr := 0 to GanttBars.Count -1 do begin
    if TGanttBar(GanttBars.Item[ctr]).ProctreeId = proctreeId then begin
      if CurBar = nil then begin
        Result := TGanttBar(GanttBars.Item[ctr]);
        exit;
      end else if TGanttBar(GanttBars.Item[ctr]) = curbar then begin
        if   GanttBars.Count-1 > ctr then result :=TGanttBar(GanttBars.Item[ctr+1]);
        exit;
      end;
    end;
  end;
end;

Procedure TCapacityPlanningGanttChart.MakeProcBar(timeFrom , TimeTo :TDatetime; Row:Integer ; proctreeId, ProcessPartId , ProcessTimeId:Integer ; barhint:String );
begin
  InsertedbarIndex    :=-1;
  try
    MakeBar(timeFrom, Timeto , row);
  Finally
    if InsertedbarIndex >=0 then begin
      TGanttBar(GanttBars.Item[InsertedbarIndex]).ProcessTimeId  := ProcessTimeId;
      TGanttBar(GanttBars.Item[InsertedbarIndex]).ProcessPartId  := ProcessPartId;
      TGanttBar(GanttBars.Item[InsertedbarIndex]).ProcTreeId     := ProcTreeId;
      TGanttBar(GanttBars.Item[InsertedbarIndex]).Timestart      := timeFrom;
      TGanttBar(GanttBars.Item[InsertedbarIndex]).timeEnd        := Timeto;
      TGanttBar(GanttBars.Item[InsertedbarIndex]).RowNo          := Row;
      TGanttBar(GanttBars.Item[InsertedbarIndex]).Bar.textHalo.Hint := barhint;
    end;
  end;
end;

function TCapacityPlanningGanttChart.FocusedProcItem:TProcItem;
begin
  result:= nil;
  try
    result:= RowList[ListindexforRow(Focusedrow.RowIndex)];
  except  end;
end;

function TCapacityPlanningGanttChart.ListindexforRow(Const RowIndex:Integer):Integer;
  var
    ctr:Integer;
  begin
    result := -1;
    if RowListnGraphLinkList.Count=0 then exit;
    for ctr:= 0 to RowListnGraphLinkList.Count-1 do
        if TRowListnGraphLink(RowListnGraphLinkList[ctr]).ChartRowindex = rowindex then begin
          Result := TRowListnGraphLink(RowListnGraphLinkList[ctr]).ListRowindex;
          Exit;
        end;
end;
procedure TCapacityPlanningGanttChart.Makeconnections;
var
  x,y:Integer;
  Bar1 , Bar2 :  TWGSGanttBar;
  BarsObj:TGanttBar;
  s:String;
  Function ParentItemBar(ParentProcTreeId:Integer):TWGSGanttBar;
  var
    ParentItem :TProcItem;
    ctr:Integer;
  begin
    result := nil;
    if ParentProcTreeId =0 then exit;
    ParentItem := RowList.ItemByTreeId[ParentProcTreeId];
    if not assigned(ParentItem) then exit;

    if (ParentItem.ProcTimeList.Count>0) then
      for ctr:=   0 to ParentItem.ProcTimeList.Count-1 do begin
        BarsObj := GanttBars.ItemByProcessTimeId[ParentItem.ProcTimeList.item[ctr].ProcessTimeId];
        if Assigned(BarsObj) then result :=BarsObj.Bar;
        if Assigned(result) then break;
      end;
    if not(Assigned(result)) then
        result := ParentItemBar(ParentItem.ParentProcTreeId);
  end;
begin
    DoShowProgressbar(200, WAITMSG  , '' , True , True, nil , False);
    try
    Bar2:= nil;
    for x:= 0 to RowList.Count -1 do begin
      DoStepProgressbar('X:' +inttostr(x)+' of ' + inttostr(RowList.Count -1));
      if RowList[x].ProcTimeList.Count>0 then
        if RowList[x].ProcTimeList.Count > 1 then begin
          for y := 0 to RowList[x].ProcTimeList.Count-2 do begin
            Bar1 := nil;
            Bar2:= nil;
            BarsObj:= GanttBars.ItemByProcessTimeId[RowList[x].ProcTimeList[y].ProcessTimeId];
            if Assigned(BarsObj) then begin Bar1 :=BarsObj.Bar;end;
            BarsObj:= GanttBars.ItemByProcessTimeId[RowList[x].ProcTimeList[y+1].ProcessTimeId];
            if Assigned(BarsObj) then begin Bar2 :=BarsObj.Bar; end;
            if Assigned(Bar1) and Assigned(Bar2) then  begin
              s:='[' + inttostr(X)+'] Sale #' + inttostr(RowList[x].saleID) +' ' +
                  RowList[x].saleLineProductname +' ' +
                  RowList[x].ProcessDesc +' ' +
                  'From ' + FormatdateTime(shortDateformat +' HH:NN:SS am/pm' , RowList[x].ProcTimeList[y].TimeStart) +
                  SecondsToTime(trunc(RowList[x].ProcTimeList[y].Duration)) + ' To ' +
                  'From ' + FormatdateTime(shortDateformat +' HH:NN:SS am/pm' , RowList[x].ProcTimeList[y+1].TimeStart) +
                  SecondsToTime(trunc(RowList[x].ProcTimeList[y+1].Duration));
              //logtext(s);
              DoStepProgressbar(s);
              try
                Makeconnection(Bar1,Bar2 , tbctFS);
              except
                on E:Exception do begin
                end;
              end;
            end;
          end;
        end else begin
          BarsObj:= GanttBars.ItemByProcessTimeId[RowList[x].ProcTimeList[0].ProcessTimeId];
          if Assigned(BarsObj) then Bar2 :=BarsObj.Bar;
        end;
        if Assigned(Bar2) then begin
          Bar1:= Bar2;
          Bar2 := ParentItemBar(RowList[x].ParentProcTreeId);

          if Assigned(Bar2) then begin
              s:= '[' + inttostr(X)+'] Sale #' + inttostr(RowList[x].saleID) +' ' +
                  RowList[x].saleLineProductname ;
              //logtext(s);
              DoStepProgressbar(s);
              try
                Makeconnection(Bar1,Bar2 , tbctFS);
                DoStepProgressbar(s+':' +' done');
              except
                on E:Exception do begin
                  DoStepProgressbar('Exception : ' + E.message);
                end;
              end;
          end;
        end;
   end;
   finally
    DoHideProgressbar;
    GanttGraph.Repaint;
   end;
end;

procedure TCapacityPlanningGanttChart.Makeconnection(Bar1,Bar2 :TWGSGanttBar; Contype:TBarConType);
begin
  Exit ;// Since the Adjacent slots are merged, {ProcCapacityPlanningObj.TProcTimeList.Save} , its not possible to make connections.

(*    ***********  PLEASE DO NOT REMOVE THIS CODE ***********************
==================================================================
// Binny
// Since the Adjacent slots are merged, {ProcCapacityPlanningObj.TProcTimeList.Save} ,
// its not possible to make connections.
var
  Barconnection : TWGSBarConnection;
begin
try
  Barconnection  := TWGSBarConnection.Create;
  Barconnection.origin := Bar1;
  Barconnection.target := Bar2;
  Barconnection.setConnType(BarConTypeToInteger(Contype));
  DataSource.ConnectionAdd(Barconnection);
  DataSource.ResolveDistanceViolations(Bar1);
Except
  on E:Exception do begin
    MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
  end;
end;
  //GanttGraph.Repaint;*)
end;
procedure TCapacityPlanningGanttChart.Setconnection(const Value: TERPConnection);
begin
  fConnection := Value;
  //SchedList.Connection:= Value;
  RowList.Connection  := Value;
end;
function TCapacityPlanningGanttChart.getSaleID              :Integer  ;begin Result:= 0 ;Try Result := Self.focusedRow.ColumnByname['SaleID'].AsInteger             ; Except end; end;
function TCapacityPlanningGanttChart.getSaledate            :Tdatetime;begin Result:= 0 ;Try Result := Self.focusedRow.ColumnByname['Saledate'].AsDatetime          ; Except end; end;
function TCapacityPlanningGanttChart.getSaleLineQuantity    :double   ;begin Result:= 0 ;Try Result := Self.focusedRow.ColumnByname['SaleLineQuantity'].Asfloat     ; Except end; end;
function TCapacityPlanningGanttChart.getSaleLineProductname : String  ;begin Result:= '';Try Result := Self.focusedRow.ColumnByname['SaleLineProductname'].asString ; Except end; end;
function TCapacityPlanningGanttChart.getSaleCustomerName    :String   ;begin Result:= '';Try Result := Self.focusedRow.ColumnByname['SaleCustomerName'].asString    ; Except end; end;
function TCapacityPlanningGanttChart.getSelectedrowdetails: String;
begin
    result :=
          'SaleID  :'             +inttostr(SaleID)                           + NL +
          'SaleCustomerName  :'   +SaleCustomerName                           + NL +
          'Saledate  :'           +Formatdatetime(formatSettings.shortdateformat , Saledate) + NL +
          'SaleLineProductname  :'+SaleLineProductname                        + NL +
          'SaleLineQuantity  :'   +FloatTostr(SaleLineQuantity)               + NL +
          'Proctreecaption  :'    +Proctreecaption                            + NL +
          'ProctreetotalQty  :'   +FloatTostr(ProctreetotalQty)               + NL +
          'ProcessDesc  :'        +ProcessDesc                                + NL +
          'ProcessPartDuration  :'+inttostr(ProcessPartDuration)              + NL +
          'ProctreeID  :'         +inttostr(ProctreeID)                       + NL +
          'ProcessStatus  :'      +ProcessStatus;
end;
function TCapacityPlanningGanttChart.getProctreecaption     :String   ;begin result := '';Try Result := Self.focusedRow.ColumnByname['Proctreecaption'].asString     ; Except end; end;
function TCapacityPlanningGanttChart.getProcessDesc         :String   ;begin result := '';Try Result := Self.focusedRow.ColumnByname['ProcessDesc'].asString         ; Except end; end;
function TCapacityPlanningGanttChart.getProcessStatus       :String   ;begin result := '';Try Result := Self.focusedRow.ColumnByname['ProcessStatus'].asString       ; Except end; end;
function TCapacityPlanningGanttChart.getProctreetotalQty    :double   ;begin result := 0 ;Try Result := Self.focusedRow.ColumnByname['ProctreetotalQty'].asfloat     ; Except end; end;
function TCapacityPlanningGanttChart.getProcessPartDuration :Integer  ;begin result := 0 ;Try Result := TimeToSeconds(Self.focusedRow.ColumnByname['cProcessPartDuration'].asString); Except end; end;
function TCapacityPlanningGanttChart.getProctreeId          :Integer  ;
begin
  result := 0;
  Try
    result := TProcitem(RowList[Self.focusedRow.rowindex]).ProcTreeId      ;
  Except end;
end;
{ TRowListnGraphLinkList }

procedure TRowListnGraphLinkList.Add(const aItem: TRowListnGraphLink);begin  fList.Add(aItem);end;
function TRowListnGraphLinkList.getListRowIndex(const ListIndex: integer): integer; begin   Result:= -1;  try    result:= chartRowItem[ListIndex].ListRowIndex;    Except   end; end;
function TRowListnGraphLinkList.getchartRowIndex(const chartIndex: integer): integer;begin  Result:= -1;  try    result:= chartRowItem[chartIndex].ChartRowindex;  Except  end;end;

function TRowListnGraphLinkList.getchartRowItem(const chartIndex: integer): TRowListnGraphLink;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do begin
    if self.Item[x] is TRowListnGraphLink then
      if TRowListnGraphLink(self.Item[x]).ChartRowindex = ChartIndex then begin
        result:= TRowListnGraphLink(self.Item[x]);
        break;
      end;
  end;
end;



function TRowListnGraphLinkList.getListRowItem(const ListIndex: integer): TRowListnGraphLink;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to self.Count -1 do begin
    if self.Item[x] is TRowListnGraphLink then
      if TRowListnGraphLink(self.Item[x]).ListRowIndex = ListIndex then begin
        result:= TRowListnGraphLink(self.Item[x]);
        break;
      end;
  end;

end;

procedure TRowListnGraphLinkList.NewEntry(ChartRowindex, ListRowIndex: Integer);
var
  obj :TRowListnGraphLink;
begin
  obj := TRowListnGraphLink.Create;
  obj.ListRowIndex :=ListRowIndex;
  obj.ChartRowindex := ChartRowindex;
  Add(obj);
end;

procedure TCapacityPlanningGanttChart.SelectRelatedRows(ProcTreeId,parentID :Integer; Movingforward:Boolean; OldDate, NewDate:TDateTime);
var
  x,y:Integer;
  aRowRec:TProcItem;
begin
  if (ProcTreeId=0) and (  parentID=0) then exit;
  for x:=  0  to rowlist.count-1 do begin
    aRowRec:=rowlist.item[x];
    if Assigned(aRowRec) then begin
      if ((ProcTreeId<>0) and (aRowRec.ProcTreeId = ProctreeId) )
            OR
          ((ProcTreeId=0) and (aRowRec.ParentProcTreeId = parentId)) then begin
          if ProcItemstoReschedule <> '' then ProcItemstoReschedule := ProcItemstoReschedule +',';
          ProcItemstoReschedule := ProcItemstoReschedule+ inttostr(aRowRec.ProctreeID);
          for y := aRowRec.ProcTimeList.Count-1 downto 0  do begin
            if ((oldDate <= dateof(aRowRec.ProcTimeList.Item[y].timestart)) and (Movingforward)) or
               ((oldDate >= dateof(aRowRec.ProcTimeList.Item[y].timestart)) and (not(Movingforward))) then begin
              aRowRec.ProcTimeList.Item[y].Duration:= 0;
              aRowRec.ProcTimeList.Item[y].Deleted:= true;
            end;
          end;
          if movingforward then RowList.selectedlist.Add(x)
          else RowList.selectedlist.Insert(0 , x);
          if movingforward then SelectRelatedRows(aRowRec.ParentProcTreeId,0 ,movingforward, oldDate,newDate)
          else SelectRelatedRows(0 , aRowRec.ProcTreeId , movingforward, oldDate, newDate);
      end;
    end;
  end;
end;

procedure TCapacityPlanningGanttChart.Reschedule(ProctreeID:Integer; OldDate, NewDate: TDateTime;Duration: double);
var
  Msg:String;
  Stepcount: Integer;
  fAutoProdPlanSchedType :TAutoProdPlanSchedType;
  RowListCopy: TProcItemList;
begin
 //   Grid.SelectRows(Grid.FixedRows,0);
 if NewDate < Date+1 then begin
  //MessageDlgXP_Vista('Selected Date to Reschedule - ' + FormatdateTime(ShortdateFormat , NewDate) +' - is prior today and cannot be rescheduled.', mtWarning, [mbOK], 0);
  Exit;
 end;

 RowListCopy:=TProcItemList.create;
 try
    RowList.CopyTo(RowListCopy);
    ProcItemstoReschedule:= '';
    RowList.SelectedList.Clear;

    SelectRelatedRows(ProcTreeId ,0, oldDate < NewDate , oldDate, newDate);

    if ProcItemstoReschedule <> '' then begin
      try
        fAutoProdPlanSchedType:= ProcPrefs.AutoProdPlanSchedType;
        try
          if Newdate>Olddate then ProcPrefs.AutoProdPlanSchedType := psForward else ProcPrefs.AutoProdPlanSchedType := psReverse;
          RowList.AutoScheduleProduction(Msg,Stepcount,NewDate,true, RowListCopy);
        finally
          ProcPrefs.AutoProdPlanSchedType := fAutoProdPlanSchedType;
        end;
      finally
      end;
    end;

  //LoadGridCapacityHeaders;
 finally
  FreeandNil(RowListCopy);
 end;
end;


end.


