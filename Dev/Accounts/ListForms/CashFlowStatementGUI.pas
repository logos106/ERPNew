unit CashFlowStatementGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,CashFlowStatementObj,
  wwcheckbox, wwdblook,  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmCashFlowStatement = class(TBaseListingGUI)
    qryMainActivity: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAmount: TFloatField;
    Bevel1: TBevel;
    lblClassTitle: TLabel;
    cboClass: TwwDBLookupCombo;
    Label5: TLabel;
    chkAllClass: TwwCheckBox;
    cboClassQry: TERPQuery;
    qryMainEndDate: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cboClassChange(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    CashFlow  : TCashFlowStatementObj;
  protected
     procedure RefreshQuery;override;
     Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;

implementation
uses
   DnMLib, Forms, CommonLib, TransAccountDetailsForm,
   AppEnvironment, FastFuncs, tcDataUtils;

{$R *.dfm}

procedure TfrmCashFlowStatement.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmCashFlowStatement.RefreshQuery;
begin
  ProcessingCursor(True);
  try
    if qryMain.Active then qryMain.Close;
  //  CashFlow.dtFrom := dtFrom.Date;
    CashFlow.dtTo   := Filterdateto;
    CashFlow.CreateAndLoadTempTable;
    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT * FROM ' + CashFlow.TempTableName);
    RefreshOrignalSQL;
    qryMain.Open;
    inherited;
  finally
     ProcessingCursor(False);
  end;
end;

procedure TfrmCashFlowStatement.FormShow(Sender: TObject);
begin
  dtTo.Date := Date;
  cboClassQry.Connection := qryMain.Connection;
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, []);
  cboClass.Text := AppEnv.DefaultClass.DefaultClassName;
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  inherited;
end;

procedure TfrmCashFlowStatement.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Detail <> 2)';
      end;
    1:
      begin {Details}
        GroupFilterString := '';//         '(Detail <> 2)';
      end;
  end;
  inherited;
end;

procedure TfrmCashFlowStatement.FormCreate(Sender: TObject);
begin
  inherited;
  SearchMode:= smFullList;
  CashFlow := TCashFlowStatementObj.Create;
  ShowChartViewOnPopup := True;
  NonSearchReport := True;
end;

procedure TfrmCashFlowStatement.FormDestroy(Sender: TObject);
begin
  CashFlow.DeleteTempCashFlowTable;
  FreeAndNil(CashFlow);
  inherited;
end;

procedure TfrmCashFlowStatement.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (Field.Text = (AppEnv.RegionalOptions.CurrencySymbol+'0.00')) then begin
    AFont.Color := ABrush.Color;
  end;

  if (qryMainDescription.asString = 'Description')
    or (qryMainDescription.asString = '    Employee Expenses')
    or (qryMainDescription.asString = '    Accounts Payable')
    or (qryMainDescription.asString = '    Sales and Services')
    or (qryMainDescription.asString = '    Accounts Receivable')
    or (qryMainDescription.asString = '    Sale proceeds Fixed assets')
    or (qryMainDescription.asString = '    Fixed assets payments')
    or (qryMainDescription.asString = '    Depreciation Fixed Assets')
    or (qryMainDescription.asString = '    Payroll Liabilities')
    or (qryMainDescription.asString = '    Depreciation Fixed Assets')
    or (qryMainDescription.asString = 'Inflow')
    or (qryMainDescription.asString = 'Outflow')
    then begin
      AFont.Style := AFont.Style + [fsBold] ;
  end;

  if (Field.FieldName = 'Activity')  then begin
    if (Field.Text = 'Operating Activities')
      or (Field.Text = 'Investing Activities')
    then begin
      AFont.Style := AFont.Style + [fsBold] + [fsUnderline];
    end;
  end;

  if (qryMainActivity.asString = '    Net operating activities')
    or (qryMainActivity.asString = '    Net investing activities')
     then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TfrmCashFlowStatement.cboClassChange(Sender: TObject);
begin
  inherited;
  CashFlow.ClassID := GetDeptID(cboClass.Text);
  RefreshQuery;
end;

procedure TfrmCashFlowStatement.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked then begin
    CashFlow.ClassID := 0;
  end else begin
    CashFlow.ClassID := GetDeptID(cboClass.Text);
  end;
  RefreshQuery;
end;

procedure TfrmCashFlowStatement.cboClassCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  chkAllClass.Checked := False;
end;

procedure TfrmCashFlowStatement.grdMainDblClick(Sender: TObject);
var
  frmComponent: TComponent;
  s:String;
begin
  s:= '';
  Self.Enabled := False;
  Try
    if (grdMain.GetActiveField = qryMainDescription) then begin
      if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Close;
      Application.ProcessMessages;
      if not FormStillOpen('TTransAccountDetailsGUI') then begin
        frmComponent := GetComponentByClassName('TTransAccountDetailsGUI');
        if Assigned(frmComponent) then begin
          with TTransAccountDetailsGUI(frmComponent) do begin
            FromDate := 0;
            ToDate :=  Self.dtTo.Date;
            If Sysutils.SameText(Trim(qryMainDescription.AsString),'Sales and Services') then Begin
              s:= s+ 'AND AccountType = ' + QuotedStr('INC') + ' OR AccountType = ' + QuotedStr('EXINC') + ' Group by TransID';
            end else If Sysutils.SameText(Trim(qryMainDescription.AsString),'Accounts Receivable') then Begin
              s:= s +'AND AccountType = ' + QuotedStr('AR');
            end else If Sysutils.SameText(Trim(qryMainDescription.AsString),'Accounts Payable') then Begin
              s:= s +'AND AccountType = ' + QuotedStr('AP');
            end else If Sysutils.SameText(Trim(qryMainDescription.AsString),'Employee Expenses') then Begin
              s:= s +' AND COALevel1 = ' + QuotedStr('Payroll Expenses');
            end else If Sysutils.SameText(Trim(qryMainDescription.AsString),'Depreciation Fixed Assets') then Begin
              s:= s +'AND AccountType = "FIXASSET" AND Type = "Fixed Asset Depreciation"';
            end else If Sysutils.SameText(Trim(qryMainDescription.AsString),'Fixed assets payments') then Begin
              s:= s +'AND AccountType = "FIXASSET" AND Type = "Fixed Asset"';
            end else begin
              exit;
            end;
            if s<> '' then  WhereString:= s;
            FormStyle := fsmdiChild;
          end;
        end;
      end;
      Exit;
    end;
  Finally
    Self.Enabled := True;
  end;
end;

procedure TfrmCashFlowStatement.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
//  inherited;   NO SORTING
end;

procedure TfrmCashFlowStatement.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowStatement.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowStatement.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowStatement.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowStatement.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Detail');
end;

initialization
  RegisterClassOnce(TfrmCashFlowStatement);
end.
