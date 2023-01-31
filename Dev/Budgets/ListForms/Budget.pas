{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/05  1.00.00 BJ  Initial version.
}
unit Budget;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, kbmMemTable,
   wwdblook, Shader, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TBudgetGUI = class(TBaseListingGUI)
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAmount1: TWideStringField;
    qryMainAmount2: TWideStringField;
    qryMainBudgetNo: TIntegerField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainBudgetID: TIntegerField;
    qryMainBudgetPeriodID: TIntegerField;
    chkUseStartDate: TCheckBox;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkUseStartDateClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private

  public
    BudgetName: string;
    procedure RefreshQuery; override;
  end;

implementation

uses FastFuncs,frmBudget, CommonLib, MySQLConst;

{$R *.dfm}
procedure TBudgetGUI.RefreshQuery;
begin
  //inherited;
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('FromDate').AsDateTime := 0;
    qryMain.Params.ParamByName('ToDate').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('FromDate').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
    qryMain.Params.ParamByName('ToDate').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  end;
  inherited;
end;

procedure TBudgetGUI.grpFiltersClick(Sender: TObject);
var
  qryfilter: string;
begin
  inherited;

  case grpFilters.ItemIndex of
    0: qryfilter := ' PeriodActive = ''T'' AND  BudgetActive = ''T'' ';
    1: qryfilter := ' PeriodActive = ''F'' OR  BudgetActive = ''F'' ';
    else qryfilter := '';
  end;

  with qryMain do begin
    Filtered := false;
    if qryfilter <> '' then begin
      Filter := qryfilter;
      Filtered := true;
    end;
  end;
end;

procedure TBudgetGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmBudget');
    if Assigned(Form) then begin
      With TfmBudget(Form) do begin
        AttachObserver(Self);
        KeyId     := 0;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TBudgetGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    GuiPrefs.DbGridElement[grdMain].RemoveFields('BudgetID,BudgetPeriodID');
    {When the form is called for the budgets of a budget definition , apply the filter
    when the form is shown}
    if Trim(BudgetName) <> '' then begin
      edtSearch.Text := BudgetName;
      actAddToFilterExecute(actAddToFilter);
      actExecuteFilterExecute(actExecuteFilter);
    end;
      grpFilters.ItemIndex := 0;
  finally
    EnableForm;
  end;     
end;

procedure TBudgetGUI.FormCreate(Sender: TObject);
begin
  inherited;
  BudgetName := '';
  fbEnableWebSearch      := true;
  fbStartinWebSearchMode := true;
end;

procedure TBudgetGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TBudgetGUI.chkUseStartDateClick(Sender: TObject);
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('Select');
  qryMain.SQL.Add('tblBudgetPeriods.BudgetID as BudgetID,');
  qryMain.SQL.Add('tblBudgetPeriods.BudgetPeriodID as BudgetPeriodID,');
  qryMain.SQL.Add('tblBudgets.Name as Name,');
  qryMain.SQL.Add('tblBudgets.Description as Description,');
  qryMain.SQL.Add('if (tblBudgets.showAmount1 = "T" , tblBudgets.Amount1Label , "NA") as Amount1,');
  qryMain.SQL.Add('if (tblBudgets.showAmount2 = "T" , tblBudgets.Amount2Label , "NA") as Amount2,');
  qryMain.SQL.Add('tblBudgetPeriods.BudgetNo as BudgetNo,');
  qryMain.SQL.Add('tblBudgetPeriods.StartDate as StartDate,');
  qryMain.SQL.Add('tblBudgetPeriods.EndDate as EndDate,');
  qryMain.SQL.Add('tblBudgetPeriods.Active as PeriodActive,');
  qryMain.SQL.Add('tblBudgets.Active as BudgetActive');
  qryMain.SQL.Add('from tblBudgetPeriods,');
  qryMain.SQL.Add('tblBudgets');
  qryMain.SQL.Add('Where tblBudgetPeriods.BudgetID =  tblBudgets.BudgetID');
  if chkUseStartDAte.Checked then
    qryMain.SQL.Add('and tblBudgetPeriods.StartDate >= :FromDate and tblBudgetPeriods.StartDate <=:ToDate')
  else
    qryMain.SQL.Add('and tblBudgetPeriods.endDate >= :FromDate and tblBudgetPeriods.endDate <=:ToDate');
  RefreshQuery;
end;

procedure TBudgetGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudgetGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudgetGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TBudgetGUI);
end.
