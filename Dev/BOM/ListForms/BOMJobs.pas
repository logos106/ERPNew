unit BOMJobs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , IntegerListObj,
  DNMAction, wwclearbuttongroup, wwradiogroup;

type
  TBOMJobsGUI = class(TBaseListingGUI)
    N1: TMenuItem;
    actScheduleAllSelected: TDNMAction;
    actScheduleallofProcess: TDNMAction;
    actSelectAll: TDNMAction;
    actAllJobofProduct: TDNMAction;

    ScheduleAllSelected1: TMenuItem;
    SheduleAll1: TMenuItem;
    SelectAll1: TMenuItem;
    N2: TMenuItem;
    mnuAllJobofProduct: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnCustomizeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    Procedure ScheduleAllSelected(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;      var Accept: Boolean);

    procedure mnuFilterPopup(Sender: TObject);
    procedure actScheduleAllSelectedUpdate(Sender: TObject);
    procedure actScheduleallofProcessUpdate(Sender: TObject);
    procedure actScheduleallofProcessExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actAllJobofProductUpdate(Sender: TObject);
    procedure actAllJobofProductExecute(Sender: TObject);
  private
    Tablename :String;
    fsCaptionCaption: String;
    fsDurationCaption: String;
    fsQuantityCaption: String;
    fsBreakDownDurationCaption: String;
    fsToBeScheduledCaption: String;
    fsProcessCaption: String;
    fsSaleIDCaption: String;
    fsDueDateCaption: String;
    fsProductNameCaption: String;
    fsSetupDurationCaption: String;
    fsHeirarchyLvlCaption: String;
    fsHeirarchyDurCaption: String;

    fbCaptionVisible: Boolean;
    fbDurationVisible: Boolean;
    fbToBeScheduledVisible: Boolean;
    fbQuantityVisible: Boolean;
    fbBreakDownDurationVisible: Boolean;
    fbProcessVisible: Boolean;
    fbSaleIDVisible: Boolean;
    fbDueDateVisible: Boolean;
    fbProductNameVisible: Boolean;
    fbSetupDurationVisible: Boolean;
    fiPPID:Integer;
    fiPsID:Integer;
    fiSaleLineId:Integer;

    Function TreeLevelsinData:Integer;
    procedure Initform;
    Function isProcessfield(Const Fieldname :String):Boolean;
    function IsProcessToBeScheduled: Boolean;
    Function ProcessStep :String;
    //function PPID:Integer;
    function PsID:Integer;
    Function SaleLineId :Integer;
    Function IsSalesLinefield(const Fieldname:String):Boolean;

  Protected
    fiBomLevels:Integer;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure DoAfterallSelected;Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    constructor Create(AOwner: TComponent); override;
    Procedure RefreshQuery;Override;
    Property SaleIDvisible            :Boolean read fbSaleIDVisible             Write fbSaleIDvisible;
    Property DueDatevisible           :Boolean read fbDueDateVisible            Write fbDueDatevisible;
    Property ProductNamevisible       :Boolean read fbProductNameVisible        Write fbProductNamevisible;
    Property Quantityvisible          :Boolean read fbQuantityVisible           Write fbQuantityvisible;
    Property Captionvisible           :Boolean read fbCaptionVisible            Write fbCaptionvisible;
    Property Processvisible           :Boolean read fbProcessVisible            Write fbProcessvisible;
    Property Durationvisible          :Boolean read fbDurationVisible           Write fbDurationvisible;
    Property ToBeScheduledVisible     :Boolean read fbToBeScheduledVisible      Write fbToBeScheduledVisible;
    Property SetupDurationvisible     :Boolean read fbSetupDurationVisible      Write fbSetupDurationvisible;
    Property BreakDownDurationvisible :Boolean read fbBreakDownDurationVisible  Write fbBreakDownDurationvisible;
    Property SaleIDCaption            :String  read fsSaleIDCaption             Write fsSaleIDCaption;
    Property DueDateCaption           :String  read fsDueDateCaption            Write fsDueDateCaption;
    Property ProductNameCaption       :String  read fsProductNameCaption        Write fsProductNameCaption;
    Property QuantityCaption          :String  read fsQuantityCaption           Write fsQuantityCaption;
    Property CaptionCaption           :String  read fsCaptionCaption            Write fsCaptionCaption;
    Property ProcessCaption           :String  read fsProcessCaption            Write fsProcessCaption;
    Property DurationCaption          :String  read fsDurationCaption           Write fsDurationCaption;
    Property SetupDurationCaption     :String  read fsSetupDurationCaption      Write fsSetupDurationCaption;
    Property BreakDownDurationCaption :String  read fsBreakDownDurationCaption  Write fsBreakDownDurationCaption;
    Property ToBeScheduledCaption     :String  read fsToBeScheduledCaption      Write fsToBeScheduledCaption;
    Property HeirarchyLvlCaption      :String  read fsHeirarchyLvlCaption       Write fsHeirarchyLvlCaption;
    Property HeirarchyDurCaption      :String  read fsHeirarchyDurCaption       Write fsHeirarchyDurCaption;
    procedure SetGridColumns; Override;
  end;


implementation

uses CommonLib, CommonDbLib, DbSharedObjectsObj, tcDataUtils, LogLib, tcConst,
  frmBOMJobsCustomize, MySQLConst, ProcCapacityPlanningObj, BusObjBase , sndkey32;

{$R *.dfm}
Procedure TBOMJobsGUI.Initform;
begin
    CaptionVisible          := True;
    DurationVisible         := True;
    ToBeScheduledVisible    := True;
    BreakDownDurationVisible:= True;
    SaleIDVisible           := True;
    DueDateVisible         := True;
    QuantityVisible         := True;
    ProcessVisible          := True;
    ProductNameVisible      := True;
    SetupDurationVisible    := True;

    SaleIDCaption           := 'Sale #';
    DueDateCaption         := 'Due Date';
    ProductNameCaption      := 'Product ';
    QuantityCaption         := 'Quantity';
    HeirarchyLvlCaption     := 'Level #';
    CaptionCaption          := '    Caption';
    ProcessCaption          := '    Process';
    HeirarchyDurCaption     := '    Level Duration #';
    DurationCaption         := '        Job';
    BreakDownDurationCaption:= '        Breakdown';
    BreakDownDurationCaption:= '        To Schedule';
    SetupDurationCaption    := '        Setup';
end;
function TBOMJobsGUI.isProcessfield(const Fieldname: String): Boolean;
var
  ctr:Integer;
begin
  REsult := False;
  for ctr := 1 to fiBomLevels-1 do begin
    if Sametext(fieldname ,'Caption'          + trim(inttostr(ctr)) ) or
      Sametext(fieldname ,'Process'          + trim(inttostr(ctr))  ) or
      Sametext(fieldname ,'Duration'         + trim(inttostr(ctr))  ) or
      Sametext(fieldname ,'SetupDuration'    + trim(inttostr(ctr))  ) or
      Sametext(fieldname ,'ToBeScheduled'    + trim(inttostr(ctr))  ) or
      Sametext(fieldname ,'BreakdownDuration'+ trim(inttostr(ctr))  ) then begin
        REsult := (Qrymain.FieldByName('PPID'+ trim(inttostr(ctr))).AsInteger <>0) and
                  (Qrymain.FieldByName('ToBeScheduledSecs'+ trim(inttostr(ctr))).asfloat >0);
        Exit;
      end;
  end;
end;


procedure TBOMJobsGUI.actAllJobofProductExecute(Sender: TObject);
begin
  inherited;
  if qrymain.FieldByName('saleLineID').AsInteger =0 then exit;
  try
    fiSaleLineId := qrymain.FieldByName('saleLineID').AsInteger;
    grdmain.UnselectAll;
    iterateProcNo:= 2;
    IterateRecords;
  finally
    fiSaleLineId := 0;
  end;

end;

procedure TBOMJobsGUI.actAllJobofProductUpdate(Sender: TObject);
begin
  inherited;
  actAllJobofProduct.Visible := IsSalesLinefield(grdmain.GetActiveField.FieldName) and (Qrymain.FieldByName('saleLineID').AsInteger<>0);
  if actAllJobofProduct.Visible  then begin
    actAllJobofProduct.Hint := 'Choose to select all jobs of Product : '+ quotedstr(Qrymain.fieldbyname('productName').asString) +' of Sale # ' +  inttostr(Qrymain.fieldbyname('saleID').asInteger) +'.';
    mnuAllJobofProduct.Hint := actAllJobofProduct.Hint;
  end;

end;

procedure TBOMJobsGUI.actScheduleallofProcessExecute(Sender: TObject);
begin
  inherited;
  if fiPsID =0 then exit;
  grdmain.UnselectAll;
  iterateProcNo:= 1;
  IterateRecords;
end;

procedure TBOMJobsGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
begin
  inherited;
    if IterateProcNo=1 then begin
      if PsID = fiPsID then grdmain.SelectRecord;
    end else if IterateProcNo=2 then begin
      if SaleLineId = fiSaleLineId then grdmain.SelectRecord;
    end;
end;


procedure TBOMJobsGUI.mnuFilterPopup(Sender: TObject);
begin
  inherited;
  actScheduleallofProcess.caption := 'Select All '+quotedstr(ProcessStep)+' Jobs';
end;

procedure TBOMJobsGUI.actScheduleallofProcessUpdate(Sender: TObject);
begin
  inherited;
  actScheduleallofProcess.Visible := PSID<>0;
end;

procedure TBOMJobsGUI.actScheduleAllSelectedUpdate(Sender: TObject);
begin
  inherited;
  actScheduleAllSelected.enabled := grdmain.selectedlist.count >0;
end;

procedure TBOMJobsGUI.actSelectAllExecute(Sender: TObject);
var
  Key: word;
begin
  inherited;
  SetControlfocus(grdmain);
  Key := Ord('A');
  FormKeyUp(grdmain,  Key , [ssCtrl]);
  (*keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0);
  keybd_event(Ord('A'), MapVirtualKey(Ord('A'), 0), 0, 0);
  keybd_event(Ord('A'), MapVirtualKey(Ord('A'), 0), KEYEVENTF_KEYUP, 0);
  keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), KEYEVENTF_KEYUP, 0);*)
end;

procedure TBOMJobsGUI.btnCustomizeClick(Sender: TObject);
begin
//  inherited;
  TfmBOMJobsCustomize.CallBOMJobsCustomize(Self);
end;

constructor TBOMJobsGUI.Create(AOwner: TComponent);
begin
  inherited;
  fiBomLevels := BOMTreeLevels;
  if fiBomLevels <=1 then fiBomLevels := 2;
end;

procedure TBOMJobsGUI.DoAfterallSelected;
begin
  inherited;
end;

procedure TBOMJobsGUI.FormCreate(Sender: TObject);
begin
  DateRangeSelectionHint := 'Report is filterd on Sales DueDate';
  initForm;
  Tablename := commondblib.GetUserTemporaryTableName('BOMJobs');
  Qrymain.SQL.text := 'Select * from ' +Tablename ;
  fbHasfutureDateRangeOptions := True;
  fiSaleLineId :=  0;
  inherited;
end;

procedure TBOMJobsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TBOMJobsGUI.FormShow(Sender: TObject);
begin
  inherited;
(*var
  NewItem : TMenuItem;
begin
  inherited;
                NewItem := TMenuItem.Create(TAdvPopupMenu(grdMain.Popupmenu));
                NewItem.Caption := 'Schedule All Selected';
                NewItem.OnClick := ScheduleAllSelected;
                grdMain.PopupMenu.Items.Add(NewItem);*)
end;

procedure TBOMJobsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  ctr:Integer;
begin
  inherited;
  AFont.Color := ClBlack;
  ABrush.color := ClWhite;

  if (qryMain.IndexFieldNames ='') then begin
    if Qrymain.fieldbyname('Level').asInteger>1 then begin
      for ctr:= 1 to Qrymain.fieldbyname('Level').asInteger-1 do
        if sametext(Field.fieldname  , 'Caption'          + trim(inttostr(ctr))) then Afont.color := ABrush.color;
      if IsSalesLinefield(field.FieldName) then Afont.color := ABrush.color;
    end;
  end;
  if grdmain.IsSelectedRecord then
    if isProcessfield(Field.FieldName) then begin
      AFont.Color := Clwhite;
      ABrush.color := clNavy;
    end;

end;
procedure TBOMJobsGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  hidetimerMsg;
  Accept := IsProcessToBeScheduled;
  if not(accept) then
    ListTimerMsg('The job is already Scheduled')
  (*else actScheduleallofProcess.caption := 'Select All '+quotedstr(ProcessStep)*);
end;
(*function TBOMJobsGUI.PPID:Integer;
var
  ctr:Integer;
begin
  Result := 0;
  for ctr := 1 to fiBomLevels-1 do begin
    if  (Qrymain.fieldbyname('PPID'+Trim(inttostr(ctr))).asInteger >0) {and
        (Qrymain.fieldbyname('tobescheduledsecs'+Trim(inttostr(ctr))).asInteger >0) } then begin
      result:= Qrymain.fieldbyname('PPID'+Trim(inttostr(ctr))).asInteger;
      break;
    end;
  end;

end;*)
function TBOMJobsGUI.PsID:Integer;
var
  ctr:Integer;
begin
  Result := 0;
  for ctr := 1 to fiBomLevels-1 do begin
    if  (Qrymain.fieldbyname('PsID'+Trim(inttostr(ctr))).asInteger >0) (*and
        (Qrymain.fieldbyname('tobescheduledsecs'+Trim(inttostr(ctr))).asInteger >0)*) then begin
      result:= Qrymain.fieldbyname('PsID'+Trim(inttostr(ctr))).asInteger;
      break;
    end;
  end;

end;

Function TBOMJobsGUI.ProcessStep:String;
var
  ctr:Integer;
begin
  Result := '';
  fiPPID:=0;
  fiPsID:=0;
  for ctr := 1 to fiBomLevels-1 do begin
    if  (Qrymain.fieldbyname('PPID'+Trim(inttostr(ctr))).asInteger >0) (*and
        (Qrymain.fieldbyname('tobescheduledsecs'+Trim(inttostr(ctr))).asInteger >0)*) then begin
      result := Qrymain.fieldbyname('Process'+Trim(inttostr(ctr))).asString;
      fiPPID:= Qrymain.fieldbyname('PPID'+Trim(inttostr(ctr))).asInteger;
      fiPsID:= Qrymain.fieldbyname('PsID'+Trim(inttostr(ctr))).asInteger;
      if devmode then ListTimerMsg('PPID:' + inttostr(fiPPID)+',    PsID:' + inttostr(fiPsID));
      break;
    end;
  end;

end;
Function TBOMJobsGUI.IsProcessToBeScheduled :Boolean;
var
  ctr:Integer;
begin
  Result := False;
  for ctr := 1 to fiBomLevels-1 do begin
    if  (Qrymain.fieldbyname('PPID'+Trim(inttostr(ctr))).asInteger >0) and
        (Qrymain.fieldbyname('tobescheduledsecs'+Trim(inttostr(ctr))).asInteger >0) then begin
      result := True;
      break;
    end;
  end;

end;
function TBOMJobsGUI.IsSalesLinefield(const Fieldname: String): Boolean;
begin
  Result := sametext(FieldName  , 'ProductName') or
          sametext(FieldName  , 'SaleID') or
          sametext(FieldName  , 'DueDate') or
          sametext(FieldName  , 'Shipped');
end;

function TBOMJobsGUI.SaleLineId: Integer;
begin
  result:= Qrymain.fieldbyname('saleLineID').AsInteger;
end;

procedure TBOMJobsGUI.ScheduleAllSelected(Sender: TObject);
var
  s:STring;
  ctr:Integer;
  fsSelectedIds:String;
  ProcessList: TProcItemList;
  lockedsaleIDs : TIntegerlist;
  msg:String;
  connection : TMyDAcDataconnection;
begin
  if grdMain.SelectedList.Count =0 then exit;
  fsSelectedIds:='';

  for ctr := 1 to fiBomLevels-1 do begin
    s:= SelectedIds('ppid'+trim(inttostr(ctr)));
    if s <> '' then begin
      if fsSelectedIds <> '' then fsSelectedIds := fsSelectedIds + ',';
      fsSelectedIds := fsSelectedIds + s;
    end;
  end;

  if fsSelectedIds = '' then Exit;

  connection := TMyDAcDataconnection.Create(Self);
  connection.Connection := GetNewMyDacConnection(connection);
  try
    connection.BeginTransaction;
    try
        ProcessList:= TProcItemList.Create;
        try
          ProcessList.Connection:= TERPConnection(connection.Connection);

          ProcessList.SelectStr:= 'pp.Id in (' +  fsSelectedIds +')';
          ProcessList.OrderByStr:=' sl.saleID, sl.SaleLineId, sl.ShipDate, pt.LEvel DESC, pt.SequenceDown DESC, pp.ProcessStepSeq';

          ProcessList.LoadList;
          if ProcessList.Count > 0 then begin
              try
                ProcessList.SelectAll;
                lockedsaleIDs := TIntegerlist.create;
                try
                  for ctr:= ProcessList.SelectedList.Count -1 downto 0 do begin
                    if not (Userlock.Lock('tblsales' ,ProcessList.SelectedItem[ctr].saleID)) then begin
                      lockedsaleIDs.AddIfNotInList(ProcessList.SelectedItem[ctr].saleID);
                      ProcessList.SelectedList.Delete(ctr);
                    end;
                  end;
                  if lockedsaleIDs.count>0 then
                    MessageDlgXP_Vista('The following Sales cannot be locked for scheduling '+chr(13)+ SaleDetails(lockedsaleIDs.commatext ) , mtWarning, [mbOK], 0);
                finally
                  Freeandnil(lockedsaleIDs);
                end;

                if (ProcessList.SelectedList.Count > 0) then begin
                  DoShowProgressbar(ProcessList.SelectedList.Count, WAITMSG);
                  try
                    msg := '';
                    ProcessList.AutoScheduleProduction(msg,ctr);
                  finally
                    DoHideProgressbar;
                  end;
                  if ProcessList.Save(msg) then begin
                    connection.CommitTransaction;
                    MessageDlgXP_Vista('Selected Job are all scheduled', mtInformation, [mbOK], 0);
                    Exit;
                  end else begin
                    connection.RollbackTransaction;
                    MessageDlgXP_Vista('Scheduling Failed : ' +NL+Msg, mtError, [mbOK], 0);
                    Exit;
                  end;
                end;
              finally
                  for ctr:= ProcessList.SelectedList.Count -1 downto 0 do
                    Userlock.unLock( 'tblsales' ,ProcessList.SelectedItem[ctr].saleID);
              end;
          end;
        finally
          ProcessList.Free;
        end;
    Except
      on E:Exception do begin
        connection.RollbackTransaction;
        MessageDlgXP_Vista('Scheduling Failed : ' +NL+E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Freeandnil(connection);
    RefreshQuery;
  end;
end;

procedure TBOMJobsGUI.SetGridColumns;
var
  ctr:Integer;
begin
  inherited;
  fieldList := TStringList.create;
  try
    if SaleIDVisible        then AddGridSelectedfield('SaleID' , 10 , SaleIDCaption );
    if DueDateVisible      then AddGridSelectedfield('DueDate' , 10 , DueDateCaption );
    if ProductNameVisible   then AddGridSelectedfield('ProductName' , 15 , ProductNameCaption );
    if QuantityVisible      then AddGridSelectedfield('Shipped' , 15 , QuantityCaption );
    for ctr:= 1 to TreeLevelsinData do begin
      if CaptionVisible           then AddGridSelectedfield('Caption'          + trim(inttostr(ctr)) , 15    , CaptionCaption           , HeirarchyLvlCaption + trim(inttostr(ctr)));
      if ProcessVisible           then AddGridSelectedfield('Process'          + trim(inttostr(ctr)) , 15    , ProcessCaption           , HeirarchyLvlCaption + trim(inttostr(ctr)));
      if DurationVisible          then AddGridSelectedfield('Duration'         + trim(inttostr(ctr)) , 15    , DurationCaption          , HeirarchyDurCaption + trim(inttostr(ctr)));
      if SetupDurationVisible     then AddGridSelectedfield('SetupDuration'    + trim(inttostr(ctr)) , 15    , SetupDurationCaption     , HeirarchyDurCaption + trim(inttostr(ctr)));
      if BreakDownDurationVisible then AddGridSelectedfield('BreakdownDuration'+ trim(inttostr(ctr)) , 15    , BreakDownDurationCaption , HeirarchyDurCaption + trim(inttostr(ctr)));
      if ToBeScheduledVisible     then AddGridSelectedfield('ToBeScheduled'    + trim(inttostr(ctr)) , 15    , ToBeScheduledCaption     , HeirarchyDurCaption + trim(inttostr(ctr)));
    end;
    grdMain.Selected := FieldList;
    grdMain.ApplySelected;
  finally
        freeandnil(fieldList);
  end;
end;

procedure TBOMJobsGUI.RefreshQuery;
var
  ctr, level:Integer;
  s:String;
begin
  With scriptmain do try
    SQL.Clear;
    SQL.Add('Drop table if exists '+ Tablename+'_1;');
    s:= 'Create table '+ Tablename+'_1'+
  ' (Level int(1) NOT NULL DEFAULT 0 , '+
  '   saleID int(11) NOT NULL DEFAULT 0 , '+
  '   DueDate DateTime , '+
  '   saleLineID int(11) NOT NULL DEFAULT 0 , '+
  '   productID int(11) DEFAULT 0 , '+
  '   productName varchar(60) DEFAULT NULL, '+
  '   Shipped double NOT NULL DEFAULT 0  ';
  for level := 1 to fiBomLevels do
    s:= s + ',PTID'       + Trim(intToStr(level)) +' int(11) NOT NULL DEFAULT 0 ,' +
            ' Caption'    + Trim(intToStr(level)) +' varchar(255) DEFAULT NULL,' +
            ' TotalQty'    + Trim(intToStr(level)) +' Double DEFAULT NULL,' +
            ' Sequenceup' + Trim(intToStr(level)) +' int(11) DEFAULT 0 ,' +
            ' parentId'   + Trim(intToStr(level)) +' int(11) DEFAULT NULL ';

  s:= s +' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;';
  SQL.add(s);
   s:= 'insert into '+Tablename+'_1 (Level, SaleId, DueDate,saleLineID , productID , productName , Shipped , Caption1 , TotalQty1, Sequenceup1 , parentId1, PTID1) select ' +
	          ' Distinct 1 as Level, S.saleID     as saleID, ' +
            ' S.DueDate            as DueDate ,' +
	          ' SL.saleLineID         as saleLineID, ' +
	          ' SL.productID          as productID, ' +
            ' SL.productName        as productName, ' +
	          ' SL.Shipped            as Shipped,' +
	          ' PT.caption            as Caption1, ' +
            ' PT.TotalQty           as TotalQty1, '+
	          ' PT.Sequenceup         as Sequenceup1, ' +
	          ' PT.parentId           as parentId1, ' +
	          ' PT.proctreeId         as PTID1' +
	          ' from tblsales S ' +
	          ' inner join tblsaleslines SL on S.sALeId = SL.saleId ' +
	          ' inner join tblProctree PT on PT.masterID = SL.saleLineId and PT.mastertype <> "mtProduct"  and ifnull(Pt.parentId,0)=0 ' +
	          ' inner join tblProcessPart PP on PT.proctreeId = PP.ProctreeId ' +
            ' Left join tblprocessstep PS on PP.ProcessStepId = PS.ID '+
	          ' Where S.IsSalesOrder ="T" and S.Converted ="F" and S.Deleted ="F" '+
            ' and  ifnull(S.DueDate,' + quotedstr(formatDateTime(MysqlDateTimeFormat , 0 ))+ ' ) between ' + quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateFrom ))+ ' and ' + quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateTo))+' ;' ;
  SQL.add(s);
  for Level := 2 to fiBomLevels do begin
      s:='insert into   '+ Tablename+'_1  (Level, SaleId, DueDate,saleLineID , productID , productName , Shipped  ';
      for ctr:= 1 to Level do s:= s+',Caption'+trim(inttostr(ctr))+' , '+
                                    ' TotalQty'+trim(inttostr(ctr))+' , '+
                                    ' Sequenceup'+trim(inttostr(ctr))+' , '+
                                    ' parentId'+trim(inttostr(ctr))+', '+
                                    ' PTID'+trim(inttostr(ctr))+'';
      s:= s+ ' )  select ' +
            ' distinct ' + inttostr(Level)+' as Level, T.SaleId, T.DueDate, T.saleLineID , T.productID , T.productName , T.Shipped , ';
      for ctr:= 1 to Level-1 do s:= s+' T.Caption'+trim(inttostr(ctr))+' , '+
                                      ' T.TotalQty'+trim(inttostr(ctr))+' , '+
                                      ' T.Sequenceup'+trim(inttostr(ctr))+' , '+
                                      ' T.parentId'+trim(inttostr(ctr))+', '+
                                      ' T.PTID'+trim(inttostr(ctr))+', ';

      s:= s +
            ' PT.caption Caption'       + trim(inttostr(Level)) +',  ' +
            ' PT.TotalQty TotalQty'       + trim(inttostr(Level)) +',  ' +
            ' PT.Sequenceup Sequenceup' + trim(inttostr(Level)) +',  ' +
            ' PT.parentId ParentID'     + trim(inttostr(Level)) +' , ' +
            ' PT.proctreeId PTID'       + trim(inttostr(Level)) +'   ' +
            ' from '+ Tablename+'_1 T Inner join  (tblProctree PT   ' +
            ' Left join tblProcessPart PP on PT.proctreeId = PP.ProctreeId ' +
            ' Left join tblprocessstep PS on PP.ProcessStepId = PS.ID ) on PT.parentId = T.PTID' + inttostr(Level-1)+' ' +
            ' Where ifnull(T.PTID' + inttostr(Level-1)+',0)<>0 '+
            ' order by Sequenceup;';
      SQL.Add(s);

    end;

    for Level := fiBomLevels downto 2 do
      SQL.Add('update  '+ Tablename+'_1 Set Level = ' + inttostr(Level)+' where ifnull(level,0)=0 and ifnull(PTid'+trim(inttostr(level))+' ,0)<>0;');

    s:= '';
    for ctr := 1 to fiBomLevels-1 do begin
      if ctr <> 1 then s:= s + ' union all';
      s:= s + ' Select @rownum'+trim(inttostr(ctr))+':=@rownum'+trim(inttostr(ctr))+'+1 RecNo,   T.*';
      for level := 1 to fiBomLevels do
        s:= s + ' ,   '+iif(level=ctr , 'PP.id'                 , 'NULL' )+' as PPID'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'PS.id'                 , 'NULL' )+' as PSID'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'PS.Description '       , 'NULL' )+' as Process'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'PP.duration '          , 'NULL' )+' as DurationSecs'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'PP.setupduration '     , 'NULL' )+' as setupdurationSecs'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'PP.breakdownduration ' , 'NULL' )+' as breakdowndurationSecs'+trim(inttostr(level))+','+
                    ' 0 as TotalScheduledSecs'+trim(inttostr(level))+','+
                    ' 0 as ToBeScheduledSecs'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'FormatSecondsTotime(PP.duration) '          , 'NULL' )+' as Duration'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'FormatSecondsTotime(PP.setupduration) '     , 'NULL' )+' as setupduration'+trim(inttostr(level))+','+
                    ' '+iif(level=ctr , 'FormatSecondsTotime(PP.breakdownduration) ' , 'NULL' )+' as breakdownduration'+trim(inttostr(level))+',' +
                    Quotedstr(ReplicateStr(' ' , 20) )+' as ToBeScheduled'+trim(inttostr(level));

      s:= s + ' from ' + Tablename + '_1 as T ';
      s:= s + ' inner join  (tblProcessPart PP Left join tblprocessstep PS on PP.ProcessStepId = PS.ID ) on T.PTID'+trim(inttostr(ctr))+' = PP.ProctreeId';
      s:= s + '  , (SELECT @rownum'+trim(inttostr(ctr))+':=0) r';
      s:= s + ' Where ifnull(T.PTID'+trim(inttostr(ctr))+',0)<>0 and ifnull(T.PTID'+trim(inttostr(ctr+1))+',0)=0';
  end;
  s:= s+' order by saleId Desc,  SaleLineID ,DueDate desc;';
  SQL.Add('Drop table if exists '+ Tablename+';');
  SQL.Add('Create table '+ Tablename+' ' + s);
  SQL.Add('Alter table '+ Tablename+' ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (`ID`); ' );

  for level := 1 to fiBomLevels do begin
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN PPID'                  +trim(inttostr(level))+' PPID'                  +trim(inttostr(level))+' INT(11)  NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN PSID'                  +trim(inttostr(level))+' PSID'                  +trim(inttostr(level))+' INT(11)  NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN TotalScheduledSecs'    +trim(inttostr(level))+' TotalScheduledSecs'    +trim(inttostr(level))+' INT(11)  NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN ToBeScheduledSecs'     +trim(inttostr(level))+' ToBeScheduledSecs'     +trim(inttostr(level))+' INT(11)  NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN DurationSecs'          +trim(inttostr(level))+' DurationSecs'          +trim(inttostr(level))+' DOUBLE   NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN setupdurationSecs'     +trim(inttostr(level))+' setupdurationSecs'     +trim(inttostr(level))+' DOUBLE   NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN breakdowndurationSecs' +trim(inttostr(level))+' breakdowndurationSecs' +trim(inttostr(level))+' DOUBLE   NULL DEFAULT 0 ;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN Process'               +trim(inttostr(level))+' Process'               +trim(inttostr(level))+' VARCHAR(255) NULL DEFAULT "";');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN Duration'              +trim(inttostr(level))+' Duration'              +trim(inttostr(level))+' TEXT     NULL;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN setupduration'         +trim(inttostr(level))+' setupduration'         +trim(inttostr(level))+' TEXT     NULL;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN breakdownduration'     +trim(inttostr(level))+' breakdownduration'     +trim(inttostr(level))+' TEXT     NULL;');
          SQL.Add('ALTER TABLE  '+ Tablename+' CHANGE COLUMN ToBeScheduled'         +trim(inttostr(level))+' ToBeScheduled'         +trim(inttostr(level))+' VARCHAR(50) NULL DEFAULT "";');
  end;
  for ctr := 1 to fiBomLevels-1 do begin

    SQL.Add('update '+ Tablename+' T Set TotalScheduledSecs'+ trim(inttostr(ctr))+'  = (Select Sum(PT.Duration)  from tblProcesstime PT  where  T.PPID'+trim(inttostr(ctr))+' = PT.ProcessPartId   ); ' );

    SQL.Add('update '+ Tablename+' T Set ToBeScheduledSecs'+ trim(inttostr(ctr))+'  = (DurationSecs'          + trim(inttostr(ctr))+' + '+
                                                                                   '   setupdurationSecs'     + trim(inttostr(ctr))+' +  '+
                                                                                   '   breakdowndurationSecs' + trim(inttostr(ctr))+' ) * TotalQty'+trim(inttostr(ctr)) + ' -  '+
                                                                                   'TotalScheduledSecs'+ trim(inttostr(ctr))+' ; ' );
     SQL.Add('update '+ Tablename+' T Set ToBeScheduled'+ trim(inttostr(ctr))+'  = FormatSecondsTotime(ToBeScheduledSecs'+ trim(inttostr(ctr))+');' );
  end;
  finally
    clog(SQL.Text);
    logtext(Qrymain.sQL.text);
    doshowProgressbar(SQL.count , WaitMSg);
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
    SQL.Clear;
  end;
  inherited;
  SetGridColumns;
end;

function TBOMJobsGUI.TreeLevelsinData: Integer;
var
  Level :Integer;
  Qry :TERPQuery;
begin
  REsult := 1;
  Qry := DbSharedObj.GetQuery(Qrymain.Connection);
  try
    Qry.SQL.clear;

    for level := 1 to fiBomLevels do begin
        if level <> 1 then Qry.SQL.Add('union all');
        Qry.SQL.Add('Select ' + inttostr(Level)+' as level, Max(T.PTID' + Trim(IntToStr(level)) +') as PTID /*from '+tablename +'*/' +
            ' from '+ tablename +' T Inner join  tblProcessPart PP   on PP.proctreeId = T.PTID' + inttostr(Level)+' ' +
            ' Inner  join tblprocessstep PS on PP.ProcessStepId = PS.ID ' +
            ' Where ifnull(T.PTID' + inttostr(Level)+',0)<>0 ');

    end;
    Qry.SQL.Add('order by level');
    Qry.Open;
    if Qry.recordcount >0 then
      while Qry.Eof = False do begin
        if Qry.fieldbyname('PTID').AsInteger <> 0 then
          if result < Qry.fieldbyname('level').AsInteger then
            result := Qry.fieldbyname('level').AsInteger;
        Qry.Next;
      end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;
procedure TBOMJobsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.SaleIDVisible')            then  SaleIDvisible            := GuiPrefs.Node['Options.SaleIDVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.DueDateVisible')           then  DueDatevisible           := GuiPrefs.Node['Options.DueDateVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.ProductNameVisible')       then  ProductNamevisible       := GuiPrefs.Node['Options.ProductNameVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.QuantityVisible')          then  Quantityvisible          := GuiPrefs.Node['Options.QuantityVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.CaptionVisible')           then  Captionvisible           := GuiPrefs.Node['Options.CaptionVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.ProcessVisible')           then  Processvisible           := GuiPrefs.Node['Options.ProcessVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.DurationVisible')          then  Durationvisible          := GuiPrefs.Node['Options.DurationVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.ToBeScheduledVisible')     then  ToBeScheduledVisible     := GuiPrefs.Node['Options.ToBeScheduledVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.SetupDurationVisible')     then  SetupDurationvisible     := GuiPrefs.Node['Options.SetupDurationVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.BreakDownDurationVisible') then  BreakDownDurationvisible := GuiPrefs.Node['Options.BreakDownDurationVisible'].AsBoolean;
    if GuiPrefs.Node.Exists('Options.SaleIDCaption')            then  SaleIDCaption            := GuiPrefs.Node['Options.SaleIDCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.DueDateCaption')           then  DueDateCaption           := GuiPrefs.Node['Options.DueDateCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.ProductNameCaption')       then  ProductNameCaption       := GuiPrefs.Node['Options.ProductNameCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.QuantityCaption')          then  QuantityCaption          := GuiPrefs.Node['Options.QuantityCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.CaptionCaption')           then  CaptionCaption           := GuiPrefs.Node['Options.CaptionCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.ProcessCaption')           then  ProcessCaption           := GuiPrefs.Node['Options.ProcessCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.DurationCaption')          then  DurationCaption          := GuiPrefs.Node['Options.DurationCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.SetupDurationCaption')     then  SetupDurationCaption     := GuiPrefs.Node['Options.SetupDurationCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.BreakDownDurationCaption') then  BreakDownDurationCaption := GuiPrefs.Node['Options.BreakDownDurationCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.ToBeScheduledCaption')     then  ToBeScheduledCaption     := GuiPrefs.Node['Options.ToBeScheduledCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.HeirarchyLvlCaption')      then  HeirarchyLvlCaption      := GuiPrefs.Node['Options.HeirarchyLvlCaption'].AsString;
    if GuiPrefs.Node.Exists('Options.HeirarchyDurCaption')      then  HeirarchyDurCaption      := GuiPrefs.Node['Options.HeirarchyDurCaption'].AsString;

  if not fbDateRangeSupplied then begin

      if GuiPrefs.Node.Exists('Options.Ignoredate') then
        chkIgnoreDates.checked :=  GuiPrefs.Node['Options.Ignoredate'].asBoolean;

      if GuiPrefs.Node.Exists('Options.DateRangeOption') then begin
        cboDateRange.ItemIndex := GuiPrefs.Node['Options.DateRangeOption'].asInteger;
        cboDateRangeCloseUp(cboDateRange);
      end;
  end;

end;

procedure TBOMJobsGUI.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['Options.SaleIDvisible'].asBoolean            := SaleIDVisible;
    GuiPrefs.Node['Options.DueDatevisible'].asBoolean           := DueDateVisible;
    GuiPrefs.Node['Options.ProductNamevisible'].asBoolean       := ProductNameVisible;
    GuiPrefs.Node['Options.Quantityvisible'].asBoolean          := QuantityVisible;
    GuiPrefs.Node['Options.Captionvisible'].asBoolean           := CaptionVisible;
    GuiPrefs.Node['Options.Processvisible'].asBoolean           := ProcessVisible;
    GuiPrefs.Node['Options.Durationvisible'].asBoolean          := DurationVisible;
    GuiPrefs.Node['Options.ToBeScheduledVisible'].asBoolean     := ToBeScheduledVisible;
    GuiPrefs.Node['Options.SetupDurationvisible'].asBoolean     := SetupDurationVisible;
    GuiPrefs.Node['Options.BreakDownDurationvisible'].asBoolean := BreakDownDurationVisible;
    GuiPrefs.Node['Options.SaleIDCaption'].asString             := SaleIDCaption;
    GuiPrefs.Node['Options.DueDateCaption'].asString            := DueDateCaption;
    GuiPrefs.Node['Options.ProductNameCaption'].asString        := ProductNameCaption;
    GuiPrefs.Node['Options.QuantityCaption'].asString           := QuantityCaption;
    GuiPrefs.Node['Options.CaptionCaption'].asString            := CaptionCaption;
    GuiPrefs.Node['Options.ProcessCaption'].asString            := ProcessCaption;
    GuiPrefs.Node['Options.DurationCaption'].asString           := DurationCaption;
    GuiPrefs.Node['Options.SetupDurationCaption'].asString      := SetupDurationCaption;
    GuiPrefs.Node['Options.BreakDownDurationCaption'].asString  := BreakDownDurationCaption;
    GuiPrefs.Node['Options.ToBeScheduledCaption'].asString      := ToBeScheduledCaption;
    GuiPrefs.Node['Options.HeirarchyLvlCaption'].asString       := HeirarchyLvlCaption;
    GuiPrefs.Node['Options.HeirarchyDurCaption'].asString       := HeirarchyDurCaption;

    GuiPrefs.Node['Options.Ignoredate'].asBoolean       := chkIgnoreDates.checked;
    GuiPrefs.Node['Options.DateRangeOption'].asInteger  := cboDateRange.ItemIndex;
end;

initialization
 RegisterClassOnce(TBOMJobsGUI);

end.
