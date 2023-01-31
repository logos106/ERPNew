unit ApprovalReminderListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, BusObjApprovals, kbmMemTable, DAScript, MyScript, wwcheckbox,
  CustomInputBox;

type
  TApprovalReminderListGUI = class(TBaseListingGUI)
    Label4: TLabel;
    cboEmployee: TwwDBLookupCombo;
    chkAllEmployees: TCheckBox;
    qryEmployees: TERPQuery;
    dsEmployees: TDataSource;
    qryMainRecID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainItemType: TWideStringField;
    qryMainApprovalType: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainExpenseClaimEmployeeID: TIntegerField;
    qryMainExpenseClaimEmployeeName: TWideStringField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainApproved: TWideStringField;
    qryMainPaid: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: String);
  private
    ApprovalReminders: TApprovalReminders;
    procedure SetSQL(aRefreshQuery: Boolean);
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, AppEnvironment, CommonDbLib;

{$R *.dfm}

procedure TApprovalReminderListGUI.RefreshQuery;
begin
  inherited;
  with grdMain do begin
    ColumnByName('TotalAmountInc').DisplayLabel := 'Total Amount (Inc)';
    ColumnByName('ExpenseClaimEmployeeName').DisplayLabel := 'Expense Claim Employee';
    ColumnByName('ItemType').DisplayLabel := 'Type';
  end;
end;

procedure TApprovalReminderListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('ItemType').AsString;
  inherited;
end;

procedure TApprovalReminderListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
  qryEmployees.Connection := GetSharedMyDacConnection;
  ApprovalReminders := TApprovalReminders.Create(Self);
  GuiPrefs.AddFieldPair('TotalAmountInc', 'TotalAmountEx', qryMain);
end;

procedure TApprovalReminderListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('OrderDate') + ' DESC CIS ; ' + QuotedStr('PurchaseOrderID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('PurchaseOrderID') + ' DESC CIS';
end;

procedure TApprovalReminderListGUI.SetSQL(aRefreshQuery: Boolean);
var
  sql: string;
begin
  if chkAllEmployees.Checked then
    sql := ApprovalReminders.GetSQL(0)
  else
    sql := ApprovalReminders.GetSQL(qryEmployees.FieldByName('EmployeeID').AsInteger);
  if qryMain.SQL.Text <> sql then begin
    qryMain.SQL.Text := sql;
    RefreshOrignalSQL;
    if aRefreshQuery then
      RefreshQuery;
  end;
end;

procedure TApprovalReminderListGUI.chkAllEmployeesClick(Sender: TObject);
begin
  cboEmployee.Enabled := not chkAllEmployees.Checked;
  SetSQL(True);
end;

procedure TApprovalReminderListGUI.cboEmployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  SetSQL(True);
end;

procedure TApprovalReminderListGUI.FormShow(Sender: TObject);
begin
  qryEmployees.Close;
  qryEmployees.Open;
  qryEmployees.Locate('EmployeeID', AppEnv.Employee.EmployeeID, []);
  cboEmployee.Text := qryEmployees.FieldByName('EmployeeName').AsString;
  SetSQL(False);
  inherited;
  GuiPrefs.DbGridElement[grdMain].HideFields('RecID,ExpenseClaimEmployeeID');
end;

procedure TApprovalReminderListGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: String);
begin
  inherited;
  with TwwDBGrid(Sender) do begin
    if AFieldName = 'TotalAmountInc' then begin
      RemoveField('TotalAmountInc');
      AddField('TotalAmountEx');
      qryMain.FieldByName('TotalAmountEx').Index := qryMain.FieldByName('TotalAmountInc').Index;
      ColumnByName('TotalAmountEx').DisplayLabel := 'Total Amount (Ex)';
      SetActiveField('TotalAmountEx');
    end else if AFieldName = 'TotalAmountEx' then begin
      RemoveField('TotalAmountEx');
      AddField('TotalAmountInc');
      qryMain.FieldByName('TotalAmountInc').Index := qryMain.FieldByName('TotalAmountEx').Index;
      ColumnByName('TotalAmountInc').DisplayLabel := 'Total Amount (Inc)';
      SetActiveField('TotalAmountInc');
    end;
  end;
end;

initialization
  RegisterClassOnce(TApprovalReminderListGUI);
end.
