unit ProfitandLossReportByPeriod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitandLossPeriodReportBase, kbmMemTable, DB, 
  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  wwdblook, Shader, DNMPanel, AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, wwcheckbox, ReportSQLProfitAndLossPeriod, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProfitandLossByPeriodGUI = class(TProfitLossPeriodBase)
    procedure FormCreate(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure chkBudgetClick(Sender: TObject);
  private
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; override;
  public
  end;

implementation

uses Commonlib,systemlib, FastFuncs, tcConst, wwmemo, BaseListingForm, AppEnvironment;

{$R *.dfm}

procedure TProfitandLossByPeriodGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Budget') then begin
    if not qryBudgets.active then begin
      if Assigned(QryMain.Connection) and QryMain.Connection.Connected then begin
        qryBudgets.Connection := QryMain.Connection;
        qryBudgets.Open;
      end;
    end;
    if qryBudgets.active then begin
      qryBudgets.locate('budgetID' ,GuiPrefs.Node['Budget.Id'].asInteger , []);
      chkBudget.checked :=StrToBoolean(GuiPrefs.Node['Budget.Selected'].asString);
      if chkBudget.Checked = false then
        TReportSQLProfitAndLossPeriod(ReportSQLObj).BudgetId := 0
      else if cboBudget.Text <> '' then
        TReportSQLProfitAndLossPeriod(ReportSQLObj).BudgetId := qryBudgets.FieldByName('budgetId').AsInteger;
    end;
  end;
end;

procedure TProfitandLossByPeriodGUI.WriteGuiPrefExtra;
begin
  inherited;
   if chkBudget.checked then GuiPrefs.Node['Budget.Id'].asInteger := qryBudgets.fieldbyname('budgetId').asInteger else GuiPrefs.Node['Budget.Id'].asInteger := 0;
   GuiPrefs.Node['Budget.Selected'].asString:= BooleantoStr(chkBudget.checked);
end;

procedure TProfitandLossByPeriodGUI.cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  if Screen.Activecontrol.Name <> cbobudget.Name then Exit;
  TReportSQLProfitAndLossPeriod(ReportSQLObj).BudgetId := qryBudgets.FieldByName('budgetId').AsInteger;
  inherited;
end;

procedure TProfitandLossByPeriodGUI.chkBudgetClick(Sender: TObject);
begin
  if chkBudget.Checked = false then TReportSQLProfitAndLossPeriod(ReportSQLObj).BudgetId := 0
  else if cboBudget.Text <> '' then TReportSQLProfitAndLossPeriod(ReportSQLObj).BudgetId := qryBudgets.FieldByName('budgetId').AsInteger;
  inherited;
end;

procedure TProfitandLossByPeriodGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossByPeriodGUI.dtToChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossByPeriodGUI.FormCreate(Sender: TObject);
begin
  fReportSQLObj := TReportSQLProfitAndLossPeriod.Create(Self);
  ReportSQLobj.employeeID := Appenv.Employee.EmployeeID;
  Tablename := ReportSQLObj.Temptablename ;//'tmp_PLPeriod_' + GetMachineIdentification(true, true, true, true);
  TReportSQLProfitAndLossBase(ReportSQLObj).QryBudgets := QryBudgets;
  inherited;
  SearchMode:= smFullList;
  reportCaption :='Profit and Loss';
end;

initialization
  RegisterClassOnce(TProfitandLossByPeriodGUI);

end.
