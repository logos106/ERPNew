unit frmProcCapacityPlanningWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, ActnList, StdCtrls,
  Shader, DNMSpeedButton, DNMPanel, wwdbdatetimepicker,
  IntegerListObj, CheckLst, AdvGroupBox, wwcheckbox, ImgList, MemDS,
  ProgressDialog;

type
  TfmProcCapacityPlanningWork = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    ActionList: TActionList;
    actPrintWorkSheets: TAction;
    actCancel: TAction;
    DNMPanel2: TDNMPanel;
    grpDates: TAdvGroupBox;
    lblFrom: TLabel;
    lblTo: TLabel;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    lstProcesses: TCheckListBox;
    chkIncludeAllocation: TCheckBox;
    chkIncludeallsubnode: TCheckBox;
    chkPreview: TwwCheckBox;
    lblformname: TLabel;
    lblReportName: TLabel;
    Label1: TLabel;
    cmdSelectAllUsed: TDNMSpeedButton;
    lblIncludeUnScheduled: TLabel;
    procedure actCancelExecute(Sender: TObject);
    procedure actPrintWorkSheetsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdSelectAllUsedClick(Sender: TObject);
  private
    TempTable: string;
    fbhideDates :Boolean;
    fsCallingFormname: String;
    fbIncludeUnScheduled: Boolean;
    function GetDateFrom: TDateTime;
    function GetDateTo: TDateTime;
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
    procedure PopulateList;
    procedure sethideDates(const Value: Boolean);
    Procedure ReadExtraguiprefs;
    Procedure WriteExtraguiprefs;
    procedure LockIncludeUnScheduledSelection;
    procedure SetIncludeUnScheduled(const Value: Boolean);
  public
    ProcesstepIdList: TIntegerList;
    SaleLineIDList: TIntegerList;
    property DateFrom: TDateTime read GetDateFrom write SetDateFrom;
    property DateTo: TDateTime read GetDateTo write SetDateTo;
    Property hideDates :Boolean read fbhideDates write sethideDates;
    Property CallingFormname:String read fsCallingFormname write fsCallingFormname ;
    Property IncludeUnScheduled :Boolean read fbIncludeUnScheduled write SetIncludeUnScheduled;
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib, ProcessDataUtils,
  FastFuncs, ReportTemplates, DNMLib , JSONObject, AppEnvironment;


procedure TfmProcCapacityPlanningWork.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  lblIncludeUnScheduled.visible := False;
  inherited;
  ProcesstepIdList:= TIntegerList.Create;
  SaleLineIDList:= TIntegerList.Create;
//  TempTable:= GetUserTemporaryTableName('ProductionWorkSheet');
  TempTable:= '';
  fsCallingFormname := '';
  IncludeUnScheduled := False;
end;

procedure TfmProcCapacityPlanningWork.FormDestroy(Sender: TObject);
begin
  ProcesstepIdList.Free;
  SaleLineIDList.Free;
  DestroyUserTemporaryTable(TempTable);
  DestroyUserTemporaryTable(TempTable+'_Total');
  inherited;
end;

procedure TfmProcCapacityPlanningWork.FormShow(Sender: TObject);
begin
  inherited;
//  self.BeginTransaction;
  PopulateList;
  ReadExtraguiprefs;
  lblformname.Caption := GetFormDescription(fsCallingFormname);
end;

procedure TfmProcCapacityPlanningWork.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteExtraguiprefs;
  inherited;
//  self.RollbackTransaction;
  Action:= caFree;
end;

procedure TfmProcCapacityPlanningWork.actCancelExecute(Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

procedure TfmProcCapacityPlanningWork.actPrintWorkSheetsExecute(
  Sender: TObject);
var
  IdList: TIntegerList;
  x: integer;
  ReportName, SQLStr: string;
  Json: TJsonObject;

  function ReportType:String;
  begin
    if chkIncludeAllocation.checked then result := 'Production Work Sheet with allocation' else result := 'Production Work Sheet';
  end;

begin
  DisableForm;
  try
    inherited;
    IdList:= TIntegerList.Create;
    try
      for x:= 0 to lstProcesses.Count -1 do begin
        if lstProcesses.Checked[x] then
          IdList.Add(Integer(lstProcesses.Items.Objects[x]));
      end;
      if IdList.Count > 0 then begin
        if GuiPrefs.Node['Options.'+ fsCallingFormname +'.TemplateName'].asString <> '' then ReportName := GuiPrefs.Node['Options.'+ fsCallingFormname +'.TemplateName'].asString;

        if chkChooseRpt.checked then begin
          LoadReportTypes(ReportType);
          if dlgReportSelect.Execute then begin
            ReportName := dlgReportSelect.SelectedItems.Text;
            SQLStr := TReportTemplates.GetReportSQL(ReportName);
          end else exit;
        end else if ReportName = '' then begin
          TReportTemplates.GetDefaultReportSQL(ReportType,ReportName,SQLStr) ;
        end else begin
          SQLStr := TReportTemplates.GetReportSQL(ReportName);
        end;

        //if not TReportTemplates.GetDefaultReportSQL(ReportType,ReportName,SQLStr) then begin
        if ReportName = '' then begin
          CommonLib.MessageDlgXP_Vista('There is no default Production Work Sheet template defined.',mtInformation,[mbOk],0);
          exit;
        end;


        PopulateProductionWorkSheetTable(TempTable,IdList,DateFrom, DateTo , SaleLineIDList , chkIncludeallsubnode.checked =False,  chkIncludeAllocation.checked , IncludeUnScheduled );

        SQLStr:= StringReplace(SQLStr,'tmp_productionworksheet',TempTable,[rfReplaceAll, rfIgnoreCase]);
        sqlSTR:= stringreplace(SQLStr , ':SaleLineIDs' , SaleLineIDList.commatext,[rfReplaceAll, rfIgnoreCase]);
        sqlSTR:= stringreplace(SQLStr , ':Field1Name' , Appenv.CompanyPrefs.Fe1Name,[rfReplaceAll, rfIgnoreCase]);
        sqlSTR:= stringreplace(SQLStr , ':Field2Name' , Appenv.CompanyPrefs.Fe2Name,[rfReplaceAll, rfIgnoreCase]);
        sqlSTR:= stringreplace(SQLStr , ':Field3Name' , Appenv.CompanyPrefs.Fe3Name,[rfReplaceAll, rfIgnoreCase]);
        sqlSTR:= stringreplace(SQLStr , ':Field4Name' , Appenv.CompanyPrefs.Fe4Name,[rfReplaceAll, rfIgnoreCase]);
        sqlSTR:= stringreplace(SQLStr , ':Field5Name' , Appenv.CompanyPrefs.Fe5Name,[rfReplaceAll, rfIgnoreCase]);


        fbReportSQLSupplied:= true;

        if sametext(reportname , 'Production worksheet (Alloc)') or sametext(reportname , 'Production worksheet BOA') then begin
            Json:= JO;
            try
              Json.O['1'].S['master']:= 'SaleRec';
              Json.O['1'].S['detail']:= 'BOA';
              Json.O['1'].S['masterfields']:= 'SaleLineId';
              Json.O['1'].S['detailfields']:= 'SaleLineId';

              Json.O['2'].S['master']:= 'SaleRec';
              Json.O['2'].S['detail']:= 'BOM';
              Json.O['2'].S['masterfields']:= 'SaleLineId';
              Json.O['2'].S['detailfields']:= 'SL.SaleLineId';

              PrintTemplateReport(ReportName, SQLStr, not chkPreview.Checked, 1 , Json);
            finally
              Json.Free;
            end;
        end else begin
          PrintTemplateReport(ReportName, SQLStr, not chkPreview.Checked, 1 );
        end;
        GuiPrefs.Node['Options.'+ fsCallingFormname +'.TemplateName'].asString   := ReportName;
        ModalResult:= mrOk;
      end
      else begin
        CommonLib.MessageDlgXP_Vista('There are no Process Steps selected.',mtInformation,[mbOk],0);
      end;
    finally
      IdList.Free;
    end;
  finally
    EnableForm;
  end;   
end;

Procedure TfmProcCapacityPlanningWork.LockIncludeUnScheduledSelection;
begin
end;

procedure TfmProcCapacityPlanningWork.cmdSelectAllUsedClick(Sender: TObject);
begin
  inherited;
  PopulateList;
end;

function TfmProcCapacityPlanningWork.GetDateFrom: TDateTime;
begin
  result:= dtFrom.DateTime;
  if hideDates then result := 0;
end;

function TfmProcCapacityPlanningWork.GetDateTo: TDateTime;
begin
  result:= dtTo.DateTime;
  if hideDates then result := 0;
end;

procedure TfmProcCapacityPlanningWork.SetDateFrom(const Value: TDateTime);
begin
  dtFrom.DateTime:= Value;
end;

procedure TfmProcCapacityPlanningWork.SetDateTo(const Value: TDateTime);
begin
  dtTo.DateTime:= Value;
end;

procedure TfmProcCapacityPlanningWork.sethideDates(const Value: Boolean);
begin
  fbhideDates := Value;
  grpDates.Visible := not(Value);
end;

procedure TfmProcCapacityPlanningWork.SetIncludeUnScheduled(const Value: Boolean);
begin
  fbIncludeUnScheduled := Value;
  lblIncludeUnScheduled.visible := Value;
end;

procedure TfmProcCapacityPlanningWork.WriteExtraguiprefs;
begin
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.ChooseTemplate'].asBoolean   := chkChooseRpt.checked           ;
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludeAllocation'].asBoolean:= chkIncludeAllocation.checked   ;
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludewholeTree'].asBoolean := chkIncludeallsubnode.checked   ;
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.Previewreport'].asBoolean    := chkPreview.checked   ;
end;

procedure TfmProcCapacityPlanningWork.PopulateList;
var
  qry: TERPQuery;
  x: integer;
  posn: integer;
begin
  lstProcesses.Clear;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:=
      'SELECT Id, Description FROM tblProcessStep ORDER BY Description';
    qry.Open;
    { add the selected Id's first at the top of the list }
    for x:= 0 to ProcesstepIdList.Count-1 do begin
      if qry.Locate('Id',ProcesstepIdList[x], []) then begin
        posn:= lstProcesses.Items.AddObject(qry.FieldByName('Description').AsString, TObject(ProcesstepIdList[x]));
        lstProcesses.Checked[posn]:= true;
      end
      else
        raise Exception.Create('TfmProcCapacityPlanningPick.PopulateList - Unable to locate record with Id: ' +
          IntToStr(ProcesstepIdList[x]));
    end;
    qry.First;
    while not qry.Eof do begin
      if lstProcesses.Items.IndexOfObject(TObject(qry.FieldByName('Id').AsInteger)) < 0 then begin
        posn:= lstProcesses.Items.AddObject(qry.FieldByName('Description').AsString, TObject(qry.FieldByName('Id').AsInteger));
        lstProcesses.Checked[posn]:= false;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfmProcCapacityPlanningWork.ReadExtraguiprefs;
var
  s:String;
begin
    if GuiPrefs.active =False then GuiPrefs.Active := True;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.ChooseTemplate')     then chkChooseRpt.checked         :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.ChooseTemplate'].asBoolean;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.IncludeAllocation')  then chkIncludeAllocation.checked :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludeAllocation'].asBoolean;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.IncludewholeTree')   then chkIncludeallsubnode.checked :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludewholeTree'].asBoolean;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.Previewreport')      then chkPreview.checked           :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.Previewreport'].asBoolean;
    s:=GuiPrefs.Node['Options.'+ fsCallingFormname +'.TemplateName'].asString;
    if s<> '' then s:='Template :'  + s;    lblReportName.caption :=s ;
end;

end.
