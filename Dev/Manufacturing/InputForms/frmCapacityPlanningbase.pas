unit frmCapacityPlanningbase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, wwclearbuttongroup, wwradiogroup, DNMSpeedButton, Shader,
  wwdbdatetimepicker, wwcheckbox, DNMPanel , ProcCapacityPlanningObj, FlagListObj,IntegerListObj,
  ActnList, ProgressDialog;

const
  {Flags}
  Flg_Initialising = 0;
  Flg_GetDisplayText = 2;
  Flg_FromDate = 3;
  Flg_GridLoading = 1;


type
  TfmCapacityPlanningbase = class(TBaseInputGUI)
    lblMsg: TLabel;
    ActionList: TActionList;
    actCancel: TAction;
    actSave: TAction;
    actStart: TAction;
    actComplete: TAction;
    actScheduled: TAction;
    actNotScheduled: TAction;
    actOpenSale: TAction;
    actProductTree: TAction;
    actAutoSchedule: TAction;
    actApply: TAction;
    actCreatePickingSlip: TAction;
    actPrintWorkSheets: TAction;
    actRefresh: TAction;
    actInvoice: TAction;
    actQualityAssurance: TAction;
    pnlTop: TDNMPanel;
    Label1: TLabel;
    Label5: TLabel;
    pnlOptions: TDNMPanel;
    Label4: TLabel;
    lblResource: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    lblSelectionoption: TLabel;
    cboCustomers: TComboBox;
    cboResource: TComboBox;
    cboResourceProcess: TComboBox;
    cboSOIds: TComboBox;
    chkSelectionoption: TwwCheckBox;
    edtDateFrom: TwwDBDateTimePicker;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnRequery: TDNMSpeedButton;
    chkShowFinalised: TwwCheckBox;
    btnPrevPage: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    btnfirstpage: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    grpGridDetail: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkShowFinalisedClick(Sender: TObject);
    procedure edtDateFromChange(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure grpGridDetailChange(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure chkSelectionoptionClick(Sender: TObject);
    procedure btnfirstpageClick(Sender: TObject);
    procedure btnPrevPageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cboCustomersCloseUp(Sender: TObject);
    procedure cboResourceCloseUp(Sender: TObject);
    procedure cboResourceProcessCloseUp(Sender: TObject);
    procedure cboSOIdsCloseUp(Sender: TObject);
  Private
      fbUserFilterOptions:Boolean;
      fiSalesOrderID: Integer;
    //fSalesOrderDateFrom: TDatetime;
      procedure SetDateFrom(const Value: TDateTime);
    procedure setCapacityPlannerDateFrom(const Value: TDateTime);
    procedure InitEmpResProc(Sender:TObject);
    procedure SetSalesOrderID(const Value: Integer);
    //procedure setSalesOrderDateFrom(const Value: TDatetime);
      //function formsize: String;

  Protected
    RowList: TProcItemList;
    fbformshown:boolean;
    FlagList: TFlagList;
    fDateTo: TDateTime;
    FDateFrom: TDateTime;
    PeriodsToDisplay: integer;
    ShowWeekends: boolean;
    CustomerName: string;
    ResourceItemIndex:integer;
    ProcessItemIndex: integer;
    SelectedProcessStepIDList: TIntegerList;
    SelectedResourceIDList: TIntegerList;
    fiUserFilterOption :Integer;
    procedure UpdateSelectedIDLists;
    function RefreshGrid: boolean;virtual;
    procedure LoadGrid;Virtual;
    function CheckSaveContinue(const DoCommit: boolean = false): boolean;
    function SaveChanges: boolean;
    function Firstdate:TDatetime; Virtual;
    procedure SetGridDetail;Virtual;
    procedure GetResourceProcessList(ProcResourceId: integer);
    procedure ClearProcessList;
    procedure GetResourceList;
    procedure GetCustomerList;
    procedure GetSOList;
    procedure InitialiseForm;Virtual;
    Function SaleIdTofilter:Integer;
    procedure RefreshOptions;
    Procedure UserFilterOptions; virtual;
    procedure WriteGuiPrefs;virtual;
    procedure Readguiprefs;virtual;
    function JobStart(const SaleLineID, ProcesspartID: Integer): TDatetime;
    procedure LockCapacityplanner;virtual;
    procedure ScriptBeforeExecute(Sender: TObject; var SQL: string;var Omit: Boolean);virtual;
    Procedure AfterFormShow; Override;
    function CheckforUnAlloctedPS:Boolean;
  public
    property DateTo: TDateTime read fDateTo;
    property DateFrom: TDateTime read FDateFrom write SetDateFrom;
    Property CapacityPlannerDateFrom :TDateTime write setCapacityPlannerDateFrom;
    constructor Create(AOwner: TComponent);Override;
    Property SalesOrderID :Integer read fiSalesOrderID write SetSalesOrderID;
    //Property SalesOrderDateFrom :TDatetime read fSalesOrderDateFrom Write setSalesOrderDateFrom;

  end;

implementation

uses BusObjProcPrefs, CommonLib, tcConst, CommonDbLib, MySQLConst , Dateutils,
  frmMessagePanel, AppEnvironment, frmMessageBase,  ManufactureLib,
  DbSharedObjectsObj, CommonFormLib, frmEmpResProcRoster;

{$R *.dfm}

type
  TResIdObj = class(TObject)
  public
    ProcessStepId,
    ResourceId: integer;
  end;

{ TfmCapacityPlanningbase }
Procedure TfmCapacityPlanningbase.LockCapacityplanner;
  (*function FormatLockMsg(Const Msg:String):String;
  begin
    result:=Msg;
    result:= replacestr(Result , 'Unable to update data.'  + #13#10, '');
    result:= replacestr(Result , ' with: ' +TitleLabel.Caption , '');
    result:= replacestr(Result , 'this record' , Quotedstr(TitleLabel.Caption));
    result:= replacestr(Result , 'Record' ,Quotedstr(TitleLabel.Caption));
    result:= replacestr(Result ,  '(Whole Table Locked)' , '');
  end;
begin
  Userlock.Enabled:= True;
  if not Userlock.Lock('Capacity Planning'  , 0 , TitleLabel.Caption) then begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista(FormatLockMsg(Userlock.lockMessage)  +NL+NL+
               'Access will be changed to read-only.', mtWarning, [mbOK], 0);
      end else begin
      //GuiPrefs.Active := True;
        self.BeginTransaction;
      end;*)
begin
  if not ManufactureLib.LockCapacityplanner(Userlock, titleLabel.Caption , ' Do Capacity Planning') then begin
        AccessLevel := 5;
      end else begin
        self.BeginTransaction;
  end;
end;

function TfmCapacityPlanningbase.JobStart(const SaleLineID , ProcesspartID:Integer):TDatetime;
begin
  REsult  :=0;
  With TempMyQuery do try
    Connection := Self.MyConnection;
    SQL.add('SELECT min(PPT.TimeStart) as timestart  ' +
            ' FROM tblSales s ' +
            ' JOIN tblSalesLines sl ON s.SaleId = sl.SaleId ' +
            ' JOIN tblProcTree pt on pt.MasterId = sl.SaleLineId and pt.mastertype <> "mtProduct" ' +
            ' JOIN tblProcessPart pp ON pp.ProcTreeId = pt.ProcTreeId ' +
            ' JOIN tblProcessTime   PPT  on PPT.ProcessPartID = PP.ID ' +
            ' where sl.saleLineId = ' + inttostr(SaleLineID) +' and processpartId = ' + inttostr(ProcesspartID) +' and S.converted = "F" and ifnull(PPT.timeStart,0)<> "1899-12-30 00:00:00" ' +
            ' and s.IsSalesOrder = "T" ' +
            ' and if(pt.ParentId=0 and pt.masterId = Sl.saleLineId,pt.TotalQty , pt.TreePartUOMTotalQty)  <> 0');
    open;
    if recordcount> 0 then begin
      REsult  := fieldByname('timestart').asDateTime;
      if result> 0 then Exit;
    end;
    close;
    SQL.clear;
    SQL.add('SELECT min(PPT.TimeStart) as timestart  ' +
            ' FROM tblSales s ' +
            ' JOIN tblSalesLines sl ON s.SaleId = sl.SaleId ' +
            ' JOIN tblProcTree pt on pt.MasterId = sl.SaleLineId and pt.mastertype <> "mtProduct" ' +
            ' JOIN tblProcessPart pp ON pp.ProcTreeId = pt.ProcTreeId ' +
            ' JOIN tblProcessTime   PPT  on PPT.ProcessPartID = PP.ID ' +
            ' where sl.saleLineId = ' + inttostr(SaleLineID) + ' and S.converted = "F" and ifnull(PPT.timeStart,0)<> "1899-12-30 00:00:00" ' +
            ' and s.IsSalesOrder = "T" ' +
            ' and if(pt.ParentId=0 and pt.masterId = Sl.saleLineId,pt.TotalQty , pt.TreePartUOMTotalQty)  <> 0');
    open;
    if recordcount> 0 then begin
      REsult  := fieldByname('timestart').asDateTime;
    end;
  finally
    if result =0 then result := date;
    closenFree;
  end;
end;
procedure TfmCapacityPlanningbase.GetResourceList;
var
  qry: TERPQuery;
begin
  cboResource.Clear;
  cboResource.Items.AddObject('[All]', nil);
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:= 'SELECT ProcResourceId, ResourceName FROM tblProcResource';
    qry.Open;
    while not qry.Eof do begin
      cboResource.Items.AddObject(qry.FieldByName('ResourceName').AsString,
                                  TObject(qry.FieldByName('ProcResourceId').AsInteger));
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfmCapacityPlanningbase.GetSOList;
var
  qry: TERPQuery;
begin
  cboSOIds.Clear;
  cboSOIds.Items.AddObject('[All]', nil);
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:=
      'SELECT DISTINCT' +
      ' S.SaleID '+
      ' FROM tblSales s inner join tblSalesLines sl on s.SaleId = sl.SaleId ' +
      ' inner join tblProcTree pt on  sl.SaleLineId = pt.MasterId AND pt.mastertype <> "mtProduct" ' +
      ' inner join tblProcessPart pp on  pt.ProcTreeId = pp.ProcTreeId  AND (pp.Status = "psNotScheduled" OR (' +
      iif(chkShowFinalised.checked =False , ' pp.Status <> "psComplete" AND ' , '') +
      ' (pp.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, DateFrom)) +
      ' AND pp.TimeStart <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, DateTo)) + '))) ' +
      ' where s.IsSalesOrder = "T" and S.Converted ="F"' +
      ' ORDER BY s.SAleID';
    qry.Open;
    while not qry.Eof do begin
      if qry.FieldByName('SaleID').asInteger <>0 then
      cboSOIds.Items.Add(qry.FieldByName('SaleID').asString);
      qry.Next;
    end;
    cboSOIds.ItemIndex:= 0;
  finally
    FreeAndNil(qry);
  end;
end;
procedure TfmCapacityPlanningbase.GetCustomerList;
var
  qry: TERPQuery;
  function ExcludeStatusforList :String;
  begin
       result:= '';
       if chkShowFinalised.checked then exit;
       result:= 'psComplete';
  end;
begin
  cboCustomers.Clear;
  cboCustomers.Items.AddObject('[All]', nil);
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:=
      'SELECT DISTINCT' +
      ' s.CustomerName as SaleCustomerName'+
      ' FROM tblSales s '+
      ' inner join  tblSalesLines sl on s.SaleId = sl.SaleId '+
      ' inner join tblProcTree pt on sl.SaleLineId = pt.MasterId ' +
      ' inner join tblProcessPart pp on pt.ProcTreeId = pp.ProcTreeId ' +
      ' WHERE pt.MasterType <> "mtProduct"' +
      ' AND (pp.Status = "psNotScheduled" OR (pp.Status <> /*"psComplete"*/ ' +Quotedstr(ExcludeStatusforList)+
      ' AND (pp.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat, DateFrom)) +
      ' AND pp.TimeStart <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, DateTo)) + ')' +
      ')) ' +
      ' AND s.IsSalesOrder = "T"' +
      ' ORDER BY s.CustomerName';
    qry.Open;
    while not qry.Eof do begin
      cboCustomers.Items.Add(qry.FieldByName('SaleCustomerName').AsString);
      qry.Next;
    end;
    cboCustomers.ItemIndex:= 0;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfmCapacityPlanningbase.UpdateSelectedIDLists;
var
  x: integer;
begin
  SelectedProcessStepIDList.Clear;
  SelectedResourceIDList.Clear;
  if cboResourceProcess.ItemIndex > 0 then begin
    { user has selected a single process step ... }
    SelectedResourceIDList.Add(TResIdObj(cboResourceProcess.Items.Objects[cboResourceProcess.ItemIndex]).ResourceId);
    SelectedProcessStepIDList.Add(TResIdObj(cboResourceProcess.Items.Objects[cboResourceProcess.ItemIndex]).ProcessStepId);
  end
  else begin
    { no process step selected .. }
    if cboResource.ItemIndex > 0 then begin
      { user has selected a single resource }

      SelectedResourceIDList.Add(Integer(cboResource.Items.Objects[cboResource.ItemIndex]));
      { steps for this resource .. }
      for x:= 1 to cboResourceProcess.Items.Count -1 do
        SelectedProcessStepIDList.AddIfNotInList(TResIdObj(cboResourceProcess.Items.Objects[x]).ProcessStepId);
    end
    else begin
      { all rsources selected }
      for x:= 1 to cboResourceProcess.Items.Count -1 do begin
        SelectedProcessStepIDList.AddIfNotInList(TResIdObj(cboResourceProcess.Items.Objects[x]).ProcessStepId);
        SelectedResourceIDList.AddIfNotInList(TResIdObj(cboResourceProcess.Items.Objects[x]).ResourceId);
      end;
    end;
  end;
end;
procedure TfmCapacityPlanningbase.UserFilterOptions;
begin
  //if chkSelectionoption.checked then begin
  if (Appenv.CompanyPRefs.CapacityplannerSelectionOptionBeforeLoad) and (Appenv.Employee.CapacityplannerSelectionOptionBeforeLoad) then begin
    fbUserFilterOptions:= True;
    try
      lblSelectionoption.caption := 'Hide Selection Options';
      chkSelectionoption.checked := False;
      InitMsgParams;
      PopupMsgParams.panel:= pnlOptions;
      PopupMsgParams.Msgcaption := Self.caption;
      PopupMsgParams.Custombuttons   := 'OK,Cancel';
      PopupMsgParams.Msg1 :='Please change options for Capacity planner if required';
      PopupMsgParams.Msg2:=  'Capacity planner will be slow when large range selected' ;
      fiUserFilterOption := TfmMessagePanel.MsgDlg;
      lblSelectionoption.caption := 'Show Selection Options before load';
    finally
      fbUserFilterOptions:= False;
    end;
  end;

end;

procedure TfmCapacityPlanningbase.WriteGuiPrefs;
begin
  GuiPrefs.Node['DetailLevel'].AsInteger:= grpGridDetail.ItemIndex;
  GuiPrefs.Node['Customer'].AsString  :=   cboCustomers.text;
  GuiPrefs.Node['Resource'].AsString  :=   cboResource.text;
  GuiPrefs.Node['Process'].AsString   :=   cboResourceProcess.text;
  GuiPrefs.Node['SalesOrder'].AsString:=   cboSOIds.text;
  //GuiPrefs.Node['SelectionOptionBeforeLoad'].asBoolean := chkSelectionoption.checked;
  GuiPrefs.Node['ShowFinalised'].AsBoolean:= chkShowFinalised.Checked;
  GuiPrefs.SavePrefs;
end;

procedure TfmCapacityPlanningbase.ClearProcessList;
begin
  while cboResourceProcess.Items.Count > 0 do begin
    cboResourceProcess.Items.Objects[0].Free;
    cboResourceProcess.Items.Delete(0);
  end;
end;

procedure TfmCapacityPlanningbase.GetResourceProcessList(ProcResourceId: integer);
var
  qry: TERPQuery;
  s: string;
  IdObj: TResIdObj;
begin
  ClearProcessList;
  cboResourceProcess.Items.AddObject('[All]', nil);
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:=
      'SELECT ProcessStepId, PS.Description, R.ResourceName, R.ProcResourceId'+
      ' FROM tblProcResourceProcess RP, tblProcessStep PS, tblProcResource R' +
      ' WHERE RP.ProcessStepId = PS.Id AND RP.ProcResourceId = R.ProcResourceId';
    if ProcResourceId <> 0 then
      qry.SQL.Add('AND RP.ProcResourceId = ' + IntToStr(ProcResourceId));
    qry.Open;
    while not qry.Eof do begin
      IdObj:= TResIdObj.Create;
      IdObj.ProcessStepId:= qry.FieldByName('ProcessStepId').AsInteger;
      IdObj.ResourceId:= qry.FieldByName('ProcResourceId').AsInteger;

      s:= qry.FieldByName('Description').AsString;
      cboResourceProcess.Items.AddObject(s, IdObj);
      qry.Next;
    end;
    if cboResourceProcess.Items.Count = 2 then
      cboResourceProcess.ItemIndex:= 1
    else
      cboResourceProcess.ItemIndex:= 0;
  finally
    FreeAndNil(qry);
  end;
end;
procedure TfmCapacityPlanningbase.SetDateFrom(const Value: TDateTime);
var
  x: integer;
begin
  FDateFrom := Value;

  fDateTo:= fDateFrom;
  for x:= 0 to PeriodsToDisplay -1 do begin
    fDateTo:= fDateTo + 1;
    if not ShowWeekends then begin
      while DayOfWeek(fDateTo) in [1,7] do
        fDateTo:= fDateTo + 1;
    end;
  end;
  lblMsg.caption := 'As per the Preference Capacity planner displays  '+inttostr(ProcPrefs.CapacityPlanningWeeksToShow) + ' Week(s) Schedule - from ' +
                Quotedstr(formatdatetime(FormatSettings.Shortdateformat,fDateFrom)) +' to ' +Quotedstr(formatdatetime(FormatSettings.Shortdateformat,fDateTo))+'.'
end;

procedure TfmCapacityPlanningbase.SetGridDetail;
begin

end;

procedure TfmCapacityPlanningbase.SetSalesOrderID(const Value: Integer);
begin
  fiSalesOrderID := Value;
  if (Value <> 0) and (cboSOIds.items.indexof(inttostr(Value)) <0) then begin
     GetSOList;
     cboSOIds.ItemIndex := cboSOIds.items.indexof(inttostr(fiSalesOrderID));
  end;
end;

(*procedure TfmCapacityPlanningbase.setSalesOrderDateFrom(const Value: TDatetime);
begin
  fSalesOrderDateFrom := Value;
  if value <> 0 then edtDatefrom.Date := Value;
  DateFrom :=edtDatefrom.Date;
end;*)

function TfmCapacityPlanningbase.SaveChanges: boolean;
var
  msg: string;
  //s:String;
(*function FormatLockMsg(Const Msg:String):String;
begin
  result:=Msg;
  result:= replacestr(Result , 'Unable to update data.'  + #13#10, 'Unable to apply Changes as it includes Rostered Items.');
  result:= replacestr(Result , 'this record' , Quotedstr('Roster'));
  result:= replacestr(Result , 'Record' ,Quotedstr('Roster'));
  result:= replacestr(Result ,  '(Whole Table Locked)' , '');
end;*)

begin
  result:= true;
  if RowList.Dirty then begin
    if not RowList.Save(msg) then begin
      result:= false;
      MessageDlgXP_Vista('Changes could not be saved: ' + NL + msg,mtWarning,[mbOk],0);
    end;
  end;
end;

procedure TfmCapacityPlanningbase.ScriptBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  DoStepProgressbar;
end;

procedure TfmCapacityPlanningbase.setCapacityPlannerDateFrom(const Value: TDateTime);
begin
  if value <> 0 then begin
    edtDateFrom.Date := Value;
    if value <>DateFrom then begin
      DateFrom := Value;
      GetSOList;
    end;
  end;
end;

procedure TfmCapacityPlanningbase.btnfirstpageClick(Sender: TObject);
begin
  inherited;
  edtDateFrom.Date:= Firstdate;
end;

procedure TfmCapacityPlanningbase.btnNextClick(Sender: TObject);
begin
  inherited;
  edtDateFrom.Date:= DateTo;
end;

procedure TfmCapacityPlanningbase.btnPrevPageClick(Sender: TObject);
begin
  inherited;
  edtDateFrom.Date:= incday(Datefrom,-PeriodsToDisplay);
end;

procedure TfmCapacityPlanningbase.cboCustomersCloseUp(Sender: TObject);
begin
  inherited;
    if cboCustomers.text<> cboCustomers.items[cboCustomers.itemindex] then
      cboCustomers.text := cboCustomers.items[cboCustomers.itemindex];
    if not(fbformshown) then begin
      CustomerName:= cboCustomers.Text;
      exit;
    end;
    if not CheckSaveContinue then begin
    cboCustomers.ItemIndex:= cboCustomers.Items.IndexOf(CustomerName);
    if cboCustomers.ItemIndex < 0 then
      cboCustomers.ItemIndex:= 0;
    exit;
  end;
  CustomerName:= cboCustomers.Text;
  LoadGrid;
end;

procedure TfmCapacityPlanningbase.cboResourceCloseUp(Sender: TObject);
begin
  inherited;
    if cboResource.text<> cboResource.items[cboResource.itemindex] then
      cboResource.text := cboResource.items[cboResource.itemindex];

    if not(fbformshown) then begin
      ResourceItemIndex:= cboResource.ItemIndex;
      if ResourceItemIndex >=0 then
           GetResourceProcessList(Integer(cboResource.Items.Objects[cboResource.ItemIndex]))
      else GetResourceProcessList(-1);
      UpdateSelectedIDLists;
      exit;
    end;
    if not CheckSaveContinue then begin
    cboResource.ItemIndex:= ResourceItemIndex;
    exit;
  end;
  ResourceItemIndex:= cboResource.ItemIndex;
  GetResourceProcessList(Integer(cboResource.Items.Objects[cboResource.ItemIndex]));
  UpdateSelectedIDLists;
//  GetCustomerList;
  LoadGrid;

end;

procedure TfmCapacityPlanningbase.cboResourceProcessCloseUp(Sender: TObject);
begin
  inherited;
    if cboResourceProcess.text<> cboResourceProcess.items[cboResourceProcess.itemindex] then
      cboResourceProcess.text := cboResourceProcess.items[cboResourceProcess.itemindex];
  if not(fbformshown) then begin
    ProcessItemIndex:= cboResourceProcess.ItemIndex;
    UpdateSelectedIDLists;
    exit;
  end;
  if not CheckSaveContinue then begin
    cboResourceProcess.ItemIndex:= ProcessItemIndex;
    exit;
  end;
  ProcessItemIndex:= cboResourceProcess.ItemIndex;
  UpdateSelectedIDLists;
  LoadGrid;
end;

procedure TfmCapacityPlanningbase.cboSOIdsCloseUp(Sender: TObject);
begin
  inherited;
    if cboSOIds.text<> cboSOIds.items[cboSOIds.itemindex] then
      cboSOIds.text := cboSOIds.items[cboSOIds.itemindex];

  if not(fbformshown) then exit;
  cboSOIds.text := cboSOIds.Items[cboSOIds.ItemIndex ];
  LoadGrid;
end;

function TfmCapacityPlanningbase.CheckSaveContinue(const DoCommit: boolean = false): boolean;
begin
  result:= true;
  if RowList.Dirty then begin
    if ProcPrefs.ProdPlanConfirmSave then begin
      case CommonLib.MessageDlgXP_Vista('Do you want to Save your changes first?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes: begin
                 if not SaveChanges then
                   result:= false
                 else
                   if DoCommit then
                     self.CommitTransaction;
               end;
        mrNo: ;
        mrCancel: result:= false;
      end;
    end
    else begin
      if not SaveChanges then
        result:= false
      else
        if DoCommit then
          self.CommitTransaction;
    end;
  end;
end;

procedure TfmCapacityPlanningbase.chkSelectionoptionClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkSelectionoption then
    if fbUserFilterOptions then
      Appenv.employee.CapacityplannerSelectionOptionBeforeLoad :=not(chkSelectionoption.Checked)
    else
      Appenv.employee.CapacityplannerSelectionOptionBeforeLoad :=chkSelectionoption.Checked ;
end;

procedure TfmCapacityPlanningbase.chkShowFinalisedClick(Sender: TObject);
begin
  inherited;
  if not(fbformshown) then exit;
  if not RefreshGrid then
    chkShowFinalised.Checked:= not chkShowFinalised.Checked;
  GetCustomerList;
end;

procedure TfmCapacityPlanningbase.edtDateFromChange(Sender: TObject);
begin
  inherited;
  if not(fbformshown) then exit;
  if FlagList .CheckFlag(Flg_GridLoading) or FlagList.CheckFlag(Flg_Initialising) or
    FlagList.CheckFlag(Flg_FromDate) then
    exit;
  FlagList.SetFlag(Flg_FromDate);
  try
    if not CheckSaveContinue then begin
      edtDateFrom.DateTime:= DateFrom;
      exit;
    end;
    DateFrom:= edtDateFrom.DateTime;
    GetCustomerList;
    GetSOList;
    self.LoadGrid;
  finally
    FlagList.ClearFlag(Flg_FromDate);
  end;
end;

function TfmCapacityPlanningbase.Firstdate: TDAtetime;
var
  qry: TERPQuery;
  dt: TDateTime;
begin
  inherited;
  Result := 0;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('select Min(PP.TimeStart) ');
    qry.SQL.Add('from tblProcessPart PP ');
    qry.SQL.Add('inner join tblProctree PT on PP.proctreeId = PT.proctreeId ');
    qry.SQL.Add('inner join tblsaleslines SL on SL.saleLineId = PT.masterID and PT.mastertype <> "mtProduct" ');
    qry.SQL.Add('inner join tblsales s on s.saleId = sl.saleId  and s.Converted ="F" and S.IsSalesorder ="T"');
    qry.SQL.Add('where Status in ("psScheduled", "psStarted") and duration > 0  ');
    qry.Open;
    if not qry.IsEmpty then begin
      if qry.Fields[0].AsDateTime <= 1 then dt:= now else dt:= qry.Fields[0].AsDateTime;
      while DayOfWeek(dt) <> 2 do
        dt:= dt -1;
      Result := dt;
    end;
  finally
    qry.Free;
  end;
end;


procedure TfmCapacityPlanningbase.FormActivate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TfmCapacityPlanningbase.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if RowList.Dirty then begin
    if not self.CheckSaveContinue(true) then
      CanClose:= false;
  end;
end;

procedure TfmCapacityPlanningbase.FormCreate(Sender: TObject);
begin
  fiSalesOrderID := 0;
  fiUserFilterOption :=0;
  inherited;
  fbUserFilterOptions:=False;
  SelectedProcessStepIDList:= TIntegerList.Create;
  SelectedResourceIDList:= TIntegerList.Create;
  ProcessItemIndex:= 0;
  ResourceItemIndex:= 0;
  FlagList:= TFlagList.Create;
  fbformshown:= False;
  if rowlist = nil then
    RowList:= TProcItemList.Create;
  RowList.Connection:= MyConnection;
  ShowWeekends:= true;
end;

procedure TfmCapacityPlanningbase.FormDestroy(Sender: TObject);
begin
  SelectedProcessStepIDList.Free;
  SelectedResourceIDList.Free;
  RowList.Free;
  FreeAndNil(FlagList);
  inherited;
end;




procedure TfmCapacityPlanningbase.grpGridDetailChange(Sender: TObject);
begin
  inherited;
  SetGridDetail;
end;

procedure TfmCapacityPlanningbase.InitialiseForm;
var
  dt: TDateTime;
begin
    PeriodsToDisplay:= ProcPrefs.CapacityPlanningWeeksToShow * 7;
    dt:= now;
    while DayOfWeek(dt) <> 2 do
      dt:= dt -1;
    edtDateFrom.Date:= dt;
    DateFrom:= dt;

    RefreshOptions;
    SetGridDetail;
end;
Procedure TfmCapacityPlanningbase.RefreshOptions;
begin
    GetResourceList;
    cboResource.ItemIndex:= 0;
    GetResourceProcessList(Integer(cboResource.Items.Objects[cboResource.ItemIndex]));
    UpdateSelectedIDLists;
    GetCustomerList;
    GetSOList;
end;

procedure TfmCapacityPlanningbase.LoadGrid;
begin

end;

procedure TfmCapacityPlanningbase.Readguiprefs;
begin
  if not(GuiPrefs.Active) then GuiPrefs.Active:= True;
  grpGridDetail.ItemIndex:= GuiPrefs.Node['DetailLevel'].AsInteger;
  if GuiPrefs.Node['Customer'].AsString   <> '' then begin cboCustomers.itemindex       := cboCustomers.items.indexof(GuiPrefs.Node['Customer'].AsString)     ;cboCustomersCloseup(cboCustomers)            ;end;
  if GuiPrefs.Node['Resource'].AsString   <> '' then begin cboResource.itemindex        := cboResource.items.indexof(GuiPrefs.Node['Resource'].AsString)      ;cboResourceCloseup(cboResource)              ;end;
  if GuiPrefs.Node['Process'].AsString    <> '' then begin cboResourceProcess.itemindex := cboResourceProcess.items.indexof(GuiPrefs.Node['Process'].AsString);cboResourceProcessCloseup(cboResourceProcess);end;
  if fiSalesOrderID <> 0                        then begin cboSOIds.itemindex           := cboSOIds.items.indexof(inttostr(fiSalesOrderID))                   ;cboSOIdsCloseup(cboSOIds);
  end else if GuiPrefs.Node['SalesOrder'].AsString <> '' then begin cboSOIds.itemindex  := cboSOIds.items.indexof(GuiPrefs.Node['SalesOrder'].AsString)       ;cboSOIdsCloseup(cboSOIds)                    ;end;
  //chkSelectionoption.checked :=GuiPrefs.Node['SelectionOptionBeforeLoad'].asBoolean;
  chkShowFinalised.Checked:= GuiPrefs.Node['ShowFinalised'].AsBoolean;
end;

function TfmCapacityPlanningbase.RefreshGrid: boolean;
begin
  result:= true;
  if RowList.Dirty then begin
    case MessageDlgXP_Vista('Do you wish to Save your changes?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      mrYes:
        begin
          if SaveChanges then begin
            self.CommitTransaction;
            self.BeginTransaction;
            LoadGrid;
          end
          else begin
            result:= false;
            exit;
          end;
        end;
      mrNo: LoadGrid;
      mrCancel:
        begin
          result:= false;
          exit;
        end;
    end;
  end
  else begin
    LoadGrid;
  end;
end;
procedure TfmCapacityPlanningbase.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;
procedure TfmCapacityPlanningbase.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveChanges then
    exit;
  self.CommitTransaction;
  Close;

end;
procedure TfmCapacityPlanningbase.AfterFormShow;
begin
  inherited;
  CheckforUnAlloctedPS;
end;
function TfmCapacityPlanningbase.CheckforUnAlloctedPS:Boolean;
var
  qry: TERPQuery;
begin
  result := true;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Closedb(qry);
    qry.sql.text := 'SELECT count(PP.ProcessStepID  ) AS ctr '+
                    ' FROM tblsales S '+
                    ' INNER JOIN tblsaleslines SL ON S.SaleID = SL.saleId '+
                    ' INNER JOIN tblproctree PT ON PT.masterID = SL.SaleLineID AND PT.mastertype = "mtSalesOrder" '+
                    ' INNER JOIN tblprocesspart PP ON PT.ProctreeId = PP.ProcTreeID '+
                    ' left JOIN tblempresprocschedule EPS ON EPS.ProcessStepId = PP.ProcessStepID '+
                    ' WHERE S.converted ="F" and S.isSalesOrder ="T" and IFNULL(EPS.ID,0)=0';
    opendb(qry);
    if qry.FieldByName('ctr').AsInteger =0 then exit;

    repeat
      if MessageDlgXP_Vista('There Are ProcessSteps that are not Allocated to Any Employee.'+NL+
                            'Do You Wish to Allocate Employees to Process Steps?', mtconfirmation, [mbyes,mbno], 0) = mrno then begin
        result := False;
        exit;
      end;
      OpenERPFormModal('TfmEmpResProcRoster', 0 , initEmpResProc);
      Closedb(qry);
      opendb(qry);
      result := qry.FieldByName('ctr').AsInteger = 0;
    until result ;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Procedure TfmCapacityPlanningbase.InitEmpResProc(Sender:TObject);
begin
  if sender is TfmEmpResProcRoster then begin
    TfmEmpResProcRoster(Sender).highlightcontrol(TfmEmpResProcRoster(Sender).btnCreateDEfaultAllocation);
  end;
end;
procedure TfmCapacityPlanningbase.actRefreshExecute(Sender: TObject);
begin
  inherited;
  RefreshGrid;
end;
function TfmCapacityPlanningbase.SaleIdTofilter: Integer;
begin
  Result := 0;
  if (fiSalesOrderID <> 0) and (cboSOIds.itemindex <> cboSOIds.items.indexof(inttostr(fiSalesOrderID))) then begin
    cboSOIds.itemindex := cboSOIds.items.indexof(inttostr(fiSalesOrderID))                   ;
    cboSOIdsCloseup(cboSOIds);
    Result :=fiSalesOrderID;
    Exit;
  end;
  if (cboSOIds.ItemIndex > 0) and (cboSOIds.text<> '') and isinteger(cboSOIds.text) then result := strToint(cboSOIds.text);
end;
(*Function  TfmCapacityPlanningbase.formsize:String;
begin
  result:= ' WindowState : ';
  if WindowState = wsNormal then result := result + 'Normal' else if WindowState =  wsMinimized then result:= result + 'Minimised' else result := result + 'Maximised';
   result:= REsult + NL + 'Height :' + inttostr(height);
   result:= REsult + NL + 'Width :' + inttostr(Width);
   result:= REsult + NL + 'ClientHeight :' + inttostr(Clientheight);
   result:= REsult + NL + 'Client Width :' + inttostr(clientWidth);
end;*)
constructor TfmCapacityPlanningbase.Create(AOwner: TComponent);
begin
  inherited;
  WindowState := wsMaximized;
end;
end.

