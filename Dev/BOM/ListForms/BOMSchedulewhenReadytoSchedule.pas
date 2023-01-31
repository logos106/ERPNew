unit BOMSchedulewhenReadytoSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCapacityPlanningbase, ActnList, ProgressDialog, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, wwclearbuttongroup, wwradiogroup,
  DNMSpeedButton, Shader, wwdbdatetimepicker, wwcheckbox, DNMPanel, BaseListingForm,
  BaseInputForm, DAScript, MyScript, kbmMemTable, CustomInputBox, wwDialog,
  Wwlocate, PrintDAT, AdvOfficeStatusBar, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdblook, DNMAction , IntegerListObj , BOMWorkOrderBase, GIFImg;

type
  TBOMSchedulewhenReadytoScheduleGUI = class(TBOMWorkOrderBaseGUI)
    btnAutoSelect: TDNMSpeedButton;
    btnSchedule: TDNMSpeedButton;

    actScheduleAllSelected: TDNMAction;
    actScheduleallofProcess: TDNMAction;
    actSelectAll: TDNMAction;
    actAllJobofProduct: TDNMAction;

    ScheduleAllSelected1: TMenuItem;
    SheduleAll1: TMenuItem;
    SelectAll1: TMenuItem;
    N2: TMenuItem;
    mnuAllJobofProduct: TMenuItem;
    actSelectProcess: TDNMAction;
    lstProcessPartIDs: TListBox;
    SelectToSchedule1: TMenuItem;
    actScheduleforDateAllSelected: TDNMAction;
    ScheduleAllSelectedJobsOnSelctedDate1: TMenuItem;
    actAutoSelect: TDNMAction;


    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure actScheduleAllSelectedUpdate(Sender: TObject);
    procedure actSelectProcessUpdate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure actSelectProcessExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure mnuFilterPopup(Sender: TObject);
    procedure actScheduleallofProcessExecute(Sender: TObject);
    procedure actAllJobofProductUpdate(Sender: TObject);
    procedure actAllJobofProductExecute(Sender: TObject);
    procedure actScheduleAllSelectedExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fPaintTimerTimer(Sender: TObject);
    procedure grdMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actScheduleforDateAllSelectedUpdate(Sender: TObject);
    procedure actScheduleforDateAllSelectedExecute(Sender: TObject);
    procedure actAutoSelectExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOptionsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);



  private



    fbEnableSingleclickSelection:boolean;
    fiPsID :Integer;
    fiSaleLineId :Integer;

    //ProcessPartIDs: TIntegerList;



    function EvenProcessfield(const FieldName: String): Boolean;
    function OddProcessfield(const FieldName: String): Boolean;
    Function IsProcessField(const FieldName: String; fieldno:Integer =0): Boolean;
    //Function ProcessPartIDName(const FieldName: String): String;
    function ProcessPartID(const FieldName: String):Integer;
    //function ProcessStepID(const FieldName: String):Integer;
    function ProcessStep(const FieldName: String):String;
    Function ProcessPartSeqno(const FieldName: String): Integer;
    function IsProcessSelected(const fieldname:string):boolean;
    function ChooseProcess: Boolean;Overload;
    Procedure ChooseProcess(const fiProcessPArtID:Integer);Overload;
    Procedure ChooseProcesses(const fiProcesstepID:Integer =0; const fiSlLineId:Integer =0);
    procedure ScheduleIt(Dt: TDateTime; FitAllOnThisDate :Boolean =False);
    function dtValidation(var Value: TDateTime; Var Msg:String): Boolean;
    procedure Selectall;
  Protected

    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    function TablenamePrefix :STring;Override;
    Procedure MakeQrymain;Override;
    Function Gridcolors(aField:Tfield; AfieldName: String; AFont:Tfont ; ABrush: TBrush; IsTitle:Boolean):Boolean;Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonDbLib, CommonLib, tcConst, LogLib, ProductQtyLib,
  ManufactureLib, MySQLConst, PQALib, tcDataUtils, ProcessUtils,
  ProcCapacityPlanningObj , frmBOMSchedulewhenReadytoScheduleOptions, dmMainGUI,
  MAIN,  dateutils, frmAdvDateInputBox;

const
  Processfields : Array [1..6] of String = ('ProcessStep',
                                            'Duration'         ,
                                            'SetupDuration'    ,
                                            'BreakdownDuration',
                                            'Scheduledtime'    ,
                                            'Status');


{$R *.dfm}

{ TFmBOMJobs }


procedure TBOMSchedulewhenReadytoScheduleGUI.FormCreate(Sender: TObject);
begin
  lstProcessPartIDs.Visible := devmode;
  IsGridcustomisable      := false;
  inherited;
  DisableSortoncolumtitleclick:= True;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.FormDestroy(Sender: TObject);
begin
  //FreeandNil(ProcessPartIDs);
  inherited;
end;


procedure TBOMSchedulewhenReadytoScheduleGUI.FormKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) then begin
    if Chr(Key) = 'A' then begin
      Selectall;
      if lstProcessPartIDs.Items.Count>0 then MessageDlgXP_Vista(inttostr(lstProcessPartIDs.Items.Count)+' Job(s) are selected', mtInformation, [mbOK], 0)
      else MessageDlgXP_Vista('No Unscheduled Job found to Select', mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
  inherited;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.FormShow(Sender: TObject);
begin
  inherited;
(*  if devmode then begin
    if MainForm.windowstate =  wsNormal then
          MainForm.windowstate:= wsMaximized
    else  dtmMainGUI.Maximiseform(Sender);
    windowstate:= wsMaximized;
  end;*)
  fPaintTimer.enabled := True;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.fPaintTimerTimer(Sender: TObject);
begin
  inherited;
  //ImgFormHint.visible := False ;
end;

function TBOMSchedulewhenReadytoScheduleGUI.IsProcessField(const FieldName: String; fieldno:Integer =0): Boolean;
var
  ctr:Integer;
begin
  result := False;
  if fieldno =0 then  begin
  result := (Pos(uppercase(Processfields[1]), uppercase(fieldname)) = 1) or
            (Pos(uppercase(Processfields[2]), uppercase(fieldname)) = 1) or
            (Pos(uppercase(Processfields[3]), uppercase(fieldname)) = 1) or
            (Pos(uppercase(Processfields[4]), uppercase(fieldname)) = 1) or
            (Pos(uppercase(Processfields[5]), uppercase(fieldname)) = 1) or
            (Pos(uppercase(Processfields[6]), uppercase(fieldname)) = 1);
  end else begin
    for ctr := low(Processfields) to high(Processfields) do
      if Sametext(fieldname, Processfields[ctr]+ Trim(IntToStr(fieldno))) then begin
        REsult := True;
        Exit;
      end;
  end;
end;
function TBOMSchedulewhenReadytoScheduleGUI.IsProcessSelected(const fieldname: string): boolean;
var
  ctr:Integer;
begin
  Result := False;
  ctr:= ProcessPartID(Fieldname);
  if ctr>0 then
    result := lstProcessPartIDs.Items.indexof(inttostr(ctr))>=0;
end;


Function TBOMSchedulewhenReadytoScheduleGUI.ProcessPartSeqno(const FieldName: String): Integer;
var
  ctr:Integer;
begin
    Result := 0;
    if FieldName ='' then exit;
    for ctr := 1 to fiProcesses do begin
      if  IsProcessField(fieldname, ctr) then begin
          result := ctr;
          exit;
      end;
    end;
end;

(*Function TBOMSchedulewhenReadytoScheduleGUI.ProcessPartIDName(const FieldName: String): String;
var
  ctr:Integer;
begin
    Result := '';
    if fieldname ='' then exit;
    ctr:= ProcessPartSeqno(Fieldname);
    result := 'ProcesspartID'+ Trim(IntToStr(ctr));
end;*)

function TBOMSchedulewhenReadytoScheduleGUI.EvenProcessfield(const FieldName:String):Boolean;
  var
      ctr:Integer;
  begin
    Result := False;
    if FieldName ='' then exit;
    for ctr := 1 to fiProcesses do begin
      if  IsProcessField(fieldname, ctr) then begin
          result := trunc(ctr/2)*2 = ctr;
          if result then result := Qrymain.fieldbyname('ProcesspartID'+ Trim(IntToStr(ctr))).asInteger <> 0;
          exit;
      end;
    end;
  end;

  function TBOMSchedulewhenReadytoScheduleGUI.OddProcessfield(const FieldName:String):Boolean;
  var
      ctr:Integer;
  begin
    Result := False;
    if FieldName ='' then exit;
    for ctr := 1 to fiProcesses do begin
      if  IsProcessField(fieldname, ctr)   then begin
          result := trunc(ctr/2)*2 <> ctr;
          if result then result := Qrymain.fieldbyname('ProcesspartID'+ Trim(IntToStr(ctr))).asInteger <> 0;
          exit;
      end;
    end;
  end;

Function TBOMSchedulewhenReadytoScheduleGUI.Gridcolors(aField:Tfield; AfieldName:String; AFont :Tfont; ABrush:TBrush; IsTitle:Boolean): Boolean;
begin
  result := False;
  try
        result := inherited Gridcolors(aField,AfieldName,AFont,ABrush,IsTitle);

        if not Result then if not(IsTitle) and IsProcessSelected(Afieldname) then begin
              AFont.Color := Clwhite;
              ABrush.color := clNavy;
        end else if EvenProcessfield(afieldName) then  begin
              ABrush.color := GridColhighLightRed;
              Afont.color := Clblack;
        end else if OddProcessfield(AFieldName) then  begin
              ABrush.color := GridColhighLightOrange;
              Afont.color := Clblack;
        end;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('1 :'+ E.Message, mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TBOMSchedulewhenReadytoScheduleGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
try
  inherited;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('2 :'+ E.Message, mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TBOMSchedulewhenReadytoScheduleGUI.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  try
    inherited;
    Gridcolors(nil, AFieldName, Afont, ABrush , true);
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('3 :'+ E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;


procedure TBOMSchedulewhenReadytoScheduleGUI.grdMainDblClick(Sender: TObject);
begin
  if ChooseProcess then exit;
  inherited;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.grdMainMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell             : TGridCoord;
begin
  inherited;
  if fbEnableSingleclickSelection then
    if button = mbLeft then begin
      Cell:=grdmain.MouseCoord(X,Y);
      if (Cell.X>0 ) and (Cell.Y>0) then
        ChooseProcess;
    end;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.IterateselectedRecordsCallback(var Abort: boolean;
  SelIndex: Integer);
begin
  inherited;
  if iterateprocno = 1 then begin
    if Qrymain.fieldbyname('OktoSchedule').asInteger = 2 then ChooseProcesses;
  end else if iterateprocno = 2 then begin
    ChooseProcesses;
  end else if iterateprocno = 3 then begin
    ChooseProcesses(fiPSID);
  end else if iterateprocno = 4 then begin
    ChooseProcesses(0, fiSaleLineId);
  end;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.MakeQrymain;
begin
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select *');
  Qrymain.SQL.add('From ' + Tablename);
  Qrymain.SQL.add('Order by SaleDate desc, SaleId Desc ,SaleLineId,  ProductName, Sequencedown');
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.mnuFilterPopup(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= ProcessStep(ActiveFieldname);
  actScheduleallofProcess.visible := s<> '';
  actScheduleallofProcess.caption := 'Select All '+quotedstr(s)+' Jobs';
end;
function TBOMSchedulewhenReadytoScheduleGUI.ProcessStep(const FieldName: String):String;
var
  ctr:Integer;
begin
  result := '';
  ctr:= ProcessPartSeqno(FieldName);
  if (ctr>0) then begin
    result := Qrymain.fieldbyname('ProcessStep'+trim(inttostr(ctr))).asString;
    fiPsID := Qrymain.fieldbyname('ProcessStepID'+trim(inttostr(ctr))).asInteger;
  end;
end;
(*function TBOMSchedulewhenReadytoScheduleGUI.ProcessStepID(const FieldName: String):Integer;
var
  ctr:Integer;
begin
  result := 0;
  ctr:= ProcessPartSeqno(FieldName);
  if (ctr>0) then result := Qrymain.fieldbyname('ProcessStepId'+trim(inttostr(ctr))).asInteger;
end;*)
function TBOMSchedulewhenReadytoScheduleGUI.ProcessPartID(const FieldName: String): Integer;
var
  ctr:Integer;
begin
  result := 0;
  ctr:= ProcessPartSeqno(FieldName);
  if (ctr>0) then result := Qrymain.fieldbyname('ProcesspartID'+trim(inttostr(ctr))).asInteger;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  fieldList := TStringList.create;
  try
      AddGridSelectedfield('SaleID'               ,10,'Sale #');
      AddGridSelectedfield('SaleDate'             ,12,'Sale Date');
      AddGridSelectedfield('customername'         ,10,'Customer');
      AddGridSelectedfield('productname'          ,10,'Product');
      AddGridSelectedfield('UnitofMeasureShipped' ,10,'Sale Qty');
      AddGridSelectedfield('UOM'                  ,10,'UOM');
      AddGridSelectedfield('Tree'                 ,20,'Tree');

      AddGridSelectedfield('TotalQty'             ,10,'Total','BOM Quantity');
      AddGridSelectedfield('ManufactureQty'       ,10,'To Build','BOM Quantity');
      AddGridSelectedfield('FromStockQty'         ,10,'From Stock','BOM Quantity');
      AddGridSelectedfield('BOMOnOrderQty'        ,10,'On Order','BOM Quantity');


      AddGridSelectedfield('Instock'    ,10,'Instock'     ,'Product Quantity');
      AddGridSelectedfield('Available'  ,10,'Available'   ,'Product Quantity');
      AddGridSelectedfield('OnOrder'    ,10,'OnOrder'     ,'Product Quantity');

      AddGridSelectedfield('SOQty'      ,10,'Ordered'     ,'Order Quantity');
      AddGridSelectedfield('Received'   ,10,'Received'    ,'Order Quantity');
      AddGridSelectedfield('Backorder'  ,10,'Backordered' ,'Order Quantity');

      AddGridSelectedfield('OktoSchedule', 10 , 'Is Ok~To Schedule?');
      AddGridSelectedfield('GoodsReceived', 10 , 'Good~Received');
      AddGridSelectedfield('StockAvailable', 10 , 'Stock~Available');
      AddGridSelectedfield('SubBOMsDone', 10 , 'Sub BOMs~Done');
      AddGridSelectedfield('ProcessesDone', 10 , 'Processes~Done');


      AddGridSelectedfield('ETADate'    ,12,'ETADate');

      for ctr := 1 to fiProcesses do begin
        AddGridSelectedfield(Processfields[1]+Trim(IntToStr(ctr)) ,10,'Process'   ,'Process # '+Trim(IntToStr(ctr)));
        AddGridSelectedfield(Processfields[2]+Trim(IntToStr(ctr)) ,10,'Duration'  ,'Process # '+Trim(IntToStr(ctr)));
        AddGridSelectedfield(Processfields[3]+Trim(IntToStr(ctr)) ,10,'Setup'     ,'Process # '+Trim(IntToStr(ctr)));
        AddGridSelectedfield(Processfields[4]+Trim(IntToStr(ctr)) ,10,'Breakdown' ,'Process # '+Trim(IntToStr(ctr)));
        AddGridSelectedfield(Processfields[5]+Trim(IntToStr(ctr)) ,10,'Scheduled' ,'Process # '+Trim(IntToStr(ctr)));
        AddGridSelectedfield(Processfields[6]+Trim(IntToStr(ctr)) ,10,'Status'    ,'Process # '+Trim(IntToStr(ctr)));
      end;


      grdMain.Selected := FieldList;
      grdMain.ApplySelected;
  finally
    Freeandnil(fieldList);
  end;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  fbEnableSingleclickSelection:=False;

  if GuiPrefs.Node.Exists('Options.EnableSingleclickSelection')         then fbEnableSingleclickSelection:=  GuiPrefs.Node['Options.EnableSingleclickSelection'].asBoolean;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.RefreshQuery;
begin
  CreateTempTable;
  inherited;
end;


procedure TBOMSchedulewhenReadytoScheduleGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.EnableSingleclickSelection'].asBoolean := fbEnableSingleclickSelection;
end;



procedure TBOMSchedulewhenReadytoScheduleGUI.actScheduleAllSelectedUpdate(Sender: TObject);
begin
  inherited;
  actScheduleAllSelected.enabled := lstProcessPartIDs.Items.count >0;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.actScheduleforDateAllSelectedUpdate(
  Sender: TObject);
begin
  inherited;
  actScheduleforDateAllSelected.enabled := lstProcessPartIDs.Items.count >0;
end;

function TBOMSchedulewhenReadytoScheduleGUI.ChooseProcess:Boolean;
var
  ctr:Integer;
begin
  inherited;
  ctr:= ProcessPartSeqno(ActiveFieldname);
  if (ctr>0) and // processfield
     (Qrymain.fieldbyname('ProcesspartID'+trim(inttostr(ctr))).asInteger >0) then  // Processid is not blank
     if ((Sametext(Qrymain.fieldbyname('Status'+trim(inttostr(ctr))).asString , 'Not Sched'))) then begin  // not already scheduled
        ChooseProcess(Qrymain.fieldbyname('ProcesspartID'+trim(inttostr(ctr))).asInteger);
     end else begin
        ListTimerMsg(Qrymain.fieldbyname('ProcessStep'+trim(inttostr(ctr))).asString+' is already Scheduled');
     end;
     Result := True;
end;
Procedure TBOMSchedulewhenReadytoScheduleGUI.ChooseProcess(const fiProcessPArtID:Integer);
begin
  if fiProcessPartId =0 then exit;
  //if (not(Sametext(Qrymain.fieldbyname('Status'+trim(inttostr(ctr))).asString , 'Not Sched'))) then Exit;

  if lstProcessPartIDs.Items.indexof(inttostr(fiProcessPartId))>=0 then begin
    lstProcessPartIDs.Items.delete(lstProcessPartIDs.Items.indexof(inttostr(fiProcessPartId)));
  end else begin
    lstProcessPartIDs.Items.add(inttostr(fiProcessPartId));
  end;
  grdmain.Invalidate;
  if lstProcessPartIDs.Items.count >0 then
        lblDateComments.Caption := inttostr(lstProcessPartIDs.Items.count)+ ' Processes Selected to Schedule'
  else  lblDateComments.Caption := 'Nothing Selected to Schedule';
end;
procedure TBOMSchedulewhenReadytoScheduleGUI.ChooseProcesses(const fiProcesstepID:Integer =0; const fiSlLineId:Integer =0);
var
  ctr:Integer;
begin
    for ctr := 1 to fiProcesses do begin
      if ((fiProcesstepID =0) or (fiProcesstepID =Qrymain.fieldbyname('ProcessStepID'+trim(inttostr(ctr))).asInteger)) and
        ((fiSlLineId=0) or (fiSlLineId = Qrymain.FieldByName('fiSlLineId').AsInteger))  then
        if ((Sametext(Qrymain.fieldbyname('Status'+trim(inttostr(ctr))).asString , 'Not Sched'))) then
          ChooseProcess(Qrymain.fieldbyname('ProcesspartID'+trim(inttostr(ctr))).asInteger);
    end;
end;
procedure TBOMSchedulewhenReadytoScheduleGUI.actSelectAllUpdate( Sender: TObject);
begin
  inherited;
  actSelectAll.Enabled := Qrymain.RecordCount >0;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.actSelectProcessExecute(Sender: TObject);
begin
  inherited;
  ChooseProcess;
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.actSelectProcessUpdate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  ctr:= ProcessPartSeqno(ActiveFieldname);
  actSelectProcess.visible := (ctr>0) and // processfield
                              (Qrymain.fieldbyname('ProcesspartID'+trim(inttostr(ctr))).asInteger >0) and // Processid is not blank
                              (not(Sametext(Qrymain.fieldbyname('Status'+trim(inttostr(ctr))).asString , 'Not Sched'))); // not already scheduled
  if actSelectProcess.visible  then
  if lstProcessPartIDs.Items.indexof(inttostr(Qrymain.fieldbyname('ProcesspartID'+trim(inttostr(ctr))).asInteger))>=0 then actSelectProcess.caption := 'Unselect' else actSelectProcess.caption := 'Select to Schedule';
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.btnOptionsClick(Sender: TObject);
begin
  if TfmBOMSchedulewhenReadytoScheduleOptions.ReadOptions(fbOktoScheduleWhenSubBOMsDone,
                                         fbOktoScheduleWhenGoodsReceived,
                                         fbOktoScheduleWhenProcessesnotScheduled,
                                         fbOktoScheduleWhenStockAvailable,
                                         fbEnableSingleclickSelection) then RefreshQuery;

end;

procedure TBOMSchedulewhenReadytoScheduleGUI.actScheduleAllSelectedExecute(Sender: TObject);
begin
  inherited;
  ScheduleIt(0 , false);
end;
Function TBOMSchedulewhenReadytoScheduleGUI.dtValidation(Var Value :TDateTime; Var Msg:String):Boolean ;
begin
  REsult := True;
  if Value < date then begin
    Msg := 'Please Choose a Future Date/Time.'+NL+'Date is Changed to Current Date/Time';
    REsult := False;
    Value := Now;
  end;
end;
procedure TBOMSchedulewhenReadytoScheduleGUI.actScheduleforDateAllSelectedExecute(Sender: TObject);
var
  dt:TDateTime;
  fbFitOnDate:boolean;
begin
  inherited;
  dt:= incDay(date,1);
  if TfmAdvDateInputBox.InputValue('Choose Schedule Date','Date To Start Scheduling from', 'Fit All Selected Process(es) on this date', dt,fbFitOnDate , Self.Color ,
                                                                                       'When Not Selected : The Schedule Will Start from the Date that You choose'+NL+
                                                                                       '      When Selected : Will Schedule Everything to the Date Selected Even When Slots Are Not Available'+NL+Nl+
                                                                                       'All jobs will be Scheduled to the First Resource for the process.'+NL,
                                                                                       dtValidation, True) then begin
    if dt <now then dt := now;
    ScheduleIt(dt , fbFitOnDate)
  end;

end;

procedure TBOMSchedulewhenReadytoScheduleGUI.ScheduleIt(Dt: TDateTime; FitAllOnThisDate :Boolean =False);
var
  ProcessList: TProcItemList;
  s:String;
  lockedsaleIDs : TIntegerlist;
  x:Integer;
  StepCount:Integer;
  msg:String;
begin
  inherited;
  //if Grdmain.selectedList.count =0 then exit;
  if lstProcessPartIDs.Items.Count =0 then exit;

  StepCount:= 0;
  //s:= SelectedIDs('ProcTreeID');
  s:= lstProcessPartIDs.Items.CommaText;
  if s = '' then exit;

  ProcessList:= TProcItemList.Create;
  try
    ProcessList.Connection:= commondblib.GetNewMyDacConnection(self);

    ProcessList.SelectStr:=
     ' PP.ID in (' + s+') '+
     ' and  pp.Status <> "psComplete"  '+
     ' and pt.ManufactureUOMQty  * (ifnull(pp.Duration ,0)+ifnull(pp.SetupDuration ,0) +ifnull( pp.BreakdownDuration,0))  > ifnull((Select  sum(ifnull(Prt.Duration,0)) from  tblprocesstime Prt where  Prt.ProcessPartId = pp.id),0)';

    ProcessList.OrderByStr:=
      ' sl.saleID, sl.SaleLineId, sl.ShipDate, pt.LEvel DESC, pt.SequenceDown DESC, pp.ProcessStepSeq';

    ProcessList.LoadList;
    if ProcessList.Count > 0 then begin
        ProcessList.SelectAll;

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
              MessageDlgXP_Vista('The following Sales cannot be locked for scheduling '+chr(13)+ SaleDetails(lockedsaleIDs.commatext ) , mtWarning, [mbOK], 0);
          finally
            Freeandnil(lockedsaleIDs);
          end;

          if (ProcessList.SelectedList.Count > 0) then begin
            DoShowProgressbar(StepCount, WAITMSG);
            try
              if not FitAllOnThisDate then begin
                ProcessList.AutoScheduleProduction(msg,StepCount , dt);
              end else begin
                //ProcessList.ScheduleProductionForADate(msg,StepCount , dt);
              end;
            finally
              DoHideProgressbar;
            end;
            if ProcessList.Save(msg) then begin
              if ProcessList.Connection.intransaction then ProcessList.Connection.commit;
              lstProcessPartIDs.Items.Clear;
              RefreshQuery;

            end else begin
              if Msg <> '' then
                MessageDlgXP_Vista('Scheduling Failed :' + msg, mtWarning, [mbOK], 0);
            end;
          end;
        finally
            for x:= ProcessList.SelectedList.Count -1 downto 0 do
              Userlock.unLock( 'tblsales' ,ProcessList.SelectedItem[x].saleID);
        end;
    end ;
  finally
     Freeandnil(ProcessList);
  end;


end;


procedure TBOMSchedulewhenReadytoScheduleGUI.actSelectAllExecute(Sender: TObject);
begin
  inherited;
  Selectall;
end ;
procedure TBOMSchedulewhenReadytoScheduleGUI.Selectall;
begin
  IterateProcno := 2;
  lstProcessPartIDs.Items.Clear;
  IterateRecords(True, 'Selecting all BOMs to be Built')
end;

function TBOMSchedulewhenReadytoScheduleGUI.TablenamePrefix: STring;
begin
  REsult :='BOMjobs';
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.actAllJobofProductUpdate(
  Sender: TObject);
begin
  inherited;
  actAllJobofProduct.Visible := IsSalesLinefield(grdmain.GetActiveField.FieldName) and (Qrymain.FieldByName('saleLineID').AsInteger<>0);
end;

procedure TBOMSchedulewhenReadytoScheduleGUI.actAutoSelectExecute(
  Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  lstProcessPartIDs.Items.Clear;
  IterateRecords(True, 'Selecting all BOMs that are Ready to be Built')
end;


procedure TBOMSchedulewhenReadytoScheduleGUI.actScheduleallofProcessExecute(Sender: TObject);
begin
  inherited;
  if fiPsID =0 then exit;
  iterateProcNo:= 3;
  lstProcessPartIDs.Items.Clear;
  IterateRecords(True, replacestr(actScheduleallofProcess.caption , 'Select' , 'Selecting'));
end;
procedure TBOMSchedulewhenReadytoScheduleGUI.actAllJobofProductExecute(Sender: TObject);
begin
  inherited;
  fiSaleLineId := Qrymain.fieldbyname('SaleLineId').asInteger;
  if fiSaleLineId =0 then exit;
  iterateProcNo:= 4;
  lstProcessPartIDs.Items.Clear;
  IterateRecords(True, replacestr(actScheduleallofProcess.caption , 'Select' , 'Selecting'));

end;

initialization
  RegisterClassOnce(TBOMSchedulewhenReadytoScheduleGUI);

end.
