unit CashFlowForecastGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, wwcheckbox, wwdblook,CashFlowForecastObj,
   kbmMemTable, Shader, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TfrmCashFlowForecast = class(TBaseListingGUI)
    qryMainTimePeriod: TWideStringField;
    qryMainAccntsRec: TFloatField;
    qryMainAccntsPay: TFloatField;
    qryMainBankAccnts: TFloatField;
    qryMainProjBalance: TFloatField;
    qryMainNetInFlow: TFloatField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    CashFlow  : TCashFlowObj;
  protected

    procedure RefreshQuery;override;
  public
    { Public declarations }

  end;

//var
//  CashFlow  : TCashFlowObj;

implementation
  uses FastFuncs,DNMLib,DateUtils, Forms, CommonLib,
       TransAccountDetailsForm, AccountsReceiveListForm, AccountsPayListForm,
       AppEnvironment, tcConst, tcDataUtils;
       
{$R *.dfm}


procedure TfrmCashFlowForecast.RefreshQuery ;
begin
  ProcessingCursor(True);
  try
    if qryMain.Active then qryMain.Close;
    CashFlow.classid := SelectedClassId;
    CashFlow.dtFrom := dtFrom.Date;
    CashFlow.dtTo   := dtTo.Date;
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

procedure TfrmCashFlowForecast.FormShow(Sender: TObject);
begin
  CashFlow.sTimePeriod := 'Week';
  CashFlow.dtFrom      := dtFrom.Date;
  CashFlow.dtTo        := dtTo.Date;
  CashFlow.ClassID     := 0;
  SelectedClassid := GetDeptID(AppEnv.DefaultClass.DefaultClassName);
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(    'StartDate,EndDate,BankAccnts');
end;

procedure TfrmCashFlowForecast.FormCreate(Sender: TObject);
begin
  inherited;
  SelectionOption :=soClass;
  CashFlow := TCashFlowObj.Create;
  ShowChartViewOnPopup := True;
end;

procedure TfrmCashFlowForecast.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  if (qryMain.FieldByName('TimePeriod').AsString = 'Beginning Balance')  then begin
    AFont.Style := AFont.Style + [fsBold];
  end;

  if (qryMain.FieldByName('TimePeriod').AsString = 'Ending Balance')   then begin
    AFont.Style := AFont.Style + [fsBold] + [fsUnderline];

  end;

end;

procedure TfrmCashFlowForecast.grpFiltersClick(Sender: TObject);
begin
  inherited;
  try
     case grpFilters.ItemIndex of
      0:
        begin {Week}
          CashFlow.sTimePeriod := 'Week';
        end;
      1:
      begin {Month}
        CashFlow.sTimePeriod := 'Month';
      end;

      2:
      begin {Quarter}
        CashFlow.sTimePeriod := 'Quarter';
      end;

      3:
      begin {Year}
        CashFlow.sTimePeriod := 'Year';
      end;
    end;
    RefreshQuery;
  finally

  end;
end;

procedure TfrmCashFlowForecast.FormDestroy(Sender: TObject);
begin
  CashFlow.DeleteTempTable;
  FreeAndNil(CashFlow);
  inherited;
end;

procedure TfrmCashFlowForecast.grdMainDblClick(Sender: TObject);
var
  frmComponent: TComponent;
begin
  Self.Enabled := False;
  Try
    if (grdMain.GetActiveField = qryMainBankAccnts) then begin // BANK
      if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Close;
      if not FormStillOpen('TTransAccountDetailsGUI') then begin
        frmComponent := GetComponentByClassName('TTransAccountDetailsGUI');
        if Assigned(frmComponent) then begin
          with TTransAccountDetailsGUI(frmComponent) do begin
            If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Beginning Balance') then Begin
              ToDate := Self.dtFrom.DateTime;
              FromDate := 0;
            end else If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Ending Balance') then Begin
              ToDate := Self.dtTo.DateTime;
              FromDate := 0;
            end else begin
              ToDate :=  qryMainEndDate.AsDateTime;
              FromDate := qryMainStartDate.AsDateTime;
            end;
            fbDateRangeSupplied := true;
            qryMain.SQL.Add('AND AccountName = ' + QuotedStr(UNDEPOSITED_FUNDS) + ' Group by TransID;');
            WhereString := 'AND (AccountName = ' + QuotedStr(UNDEPOSITED_FUNDS) + ' )';
            FormStyle := fsmdiChild;
          end;
        end;
      end else begin
        TForm(FindExistingComponent('TTransAccountDetailsGUI')).Show;
      end;
      Exit;
    end else if (grdMain.GetActiveField = qryMainNetInFlow) then begin // NetInFlow
      if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Close;
      if not FormStillOpen('TTransAccountDetailsGUI') then begin
        frmComponent := GetComponentByClassName('TTransAccountDetailsGUI');
        if Assigned(frmComponent) then begin
          with TTransAccountDetailsGUI(frmComponent) do begin
            If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Beginning Balance') then Begin
              ToDate := Self.dtFrom.DateTime;
              FromDate := 0;
            end else If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Ending Balance') then Begin
              ToDate := Self.dtTo.DateTime;
              FromDate := 0;
            end else begin
              ToDate :=  qryMainEndDate.AsDateTime;
              FromDate := qryMainStartDate.AsDateTime;
            end;
            fbDateRangeSupplied := true;

            qryMain.SQL.Add('AND (AccountName = ' + QuotedStr(UNDEPOSITED_FUNDS) +
                            ' OR AccountType = "AR" OR AccountType = "AP") ' +
                            ' Group by TransID;');
            WhereString := 'AND (AccountName = ' + QuotedStr(UNDEPOSITED_FUNDS) + ' OR AccountType = "AR" OR AccountType = "AP")';
            FormStyle := fsmdiChild;
          end;
        end;
      end else begin
        TForm(FindExistingComponent('TTransAccountDetailsGUI')).Show;
      end;
      Exit;

    end else if (grdMain.GetActiveField = qryMainAccntsRec) then begin // AR
      if FormStillOpen('TAccountsReceiveListGUI') then TForm(FindExistingComponent('TAccountsReceiveListGUI')).Close;
      if not FormStillOpen('TAccountsReceiveListGUI') then begin
        frmComponent := GetComponentByClassName('TAccountsReceiveListGUI');
        if Assigned(frmComponent) then begin
          with TAccountsReceiveListGUI(frmComponent) do begin
            If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Beginning Balance') then Begin
              dtTo.DateTime := Self.dtFrom.DateTime-1;
              dtFrom.DateTime := 0;
              chkIgnoreDates.Checked := False;
            end else If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Ending Balance') then Begin
              dtTo.DateTime :=  Self.dtTo.DateTime;
              dtFrom.DateTime := 0;
              chkIgnoreDates.Checked := False;
            end else begin
              dtFrom.DateTime := qryMainStartDate.AsDateTime;
              dtTo.DateTime   := qryMainEndDate.AsDateTime;
              chkIgnoreDates.Checked := False;
            end;
            fbDateRangeSupplied := true;
            FormStyle := fsmdiChild;
          end;
        end;
      end else begin
        TForm(FindExistingComponent('TAccountsReceiveListGUI')).Show;
      end;
      Exit;
    end else if (grdMain.GetActiveField = qryMainAccntsPay) then begin // AP
      if FormStillOpen('TAccountsPayListGUI') then TForm(FindExistingComponent('TAccountsPayListGUI')).Close;
      if not FormStillOpen('TAccountsPayListGUI') then begin
        frmComponent := GetComponentByClassName('TAccountsPayListGUI');
        if Assigned(frmComponent) then begin
          with TAccountsPayListGUI(frmComponent) do begin
            If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Beginning Balance') then Begin
              dtTo.DateTime := Self.dtFrom.DateTime-1;
              dtFrom.DateTime := 0;
              chkignoredates.Checked := False;
            end else If Sysutils.SameText(Trim(qryMainTimePeriod.AsString),'Ending Balance') then Begin
              dtTo.DateTime :=  Self.dtTo.DateTime;
              dtFrom.DateTime := 0;
              chkignoredates.Checked := False;
            end else begin
              dtFrom.DateTime := qryMainStartDate.AsDateTime;
              dtTo.DateTime   := qryMainEndDate.AsDateTime;
              chkignoredates.Checked := False;
            end;
            fbDateRangeSupplied := true;
            FormStyle := fsmdiChild;
          end;
        end;
      end else begin
        TForm(FindExistingComponent('TAccountsPayListGUI')).Show;
      end;
      Exit;
    end;
  Finally
    Self.Enabled := True;
  end;
end;

procedure TfrmCashFlowForecast.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
// inherited;    NO SORTING
end;

procedure TfrmCashFlowForecast.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowForecast.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowForecast.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmCashFlowForecast.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmCashFlowForecast);
end.
