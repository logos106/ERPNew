unit frmAccountbudget;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls,
  wwcheckbox, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwdbdatetimepicker, wwdblook, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  BusObjAccountBudget, ComCtrls,AdvOfficeStatusBar,
  Shader, ImgList, ProgressDialog ;

type
  TfmAccountbudget = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    QryBudgetDef: TERPQuery;
    dsBudgetDef: TDataSource;
    DNMPanel5: TDNMPanel;
    Label4: TLabel;
    Label7: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    chkFreezeColumn: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    grdBudgets: TwwDBGrid;
    grdBudgetsIButton: TwwIButton;
    QryBudgetDefbudgetId: TIntegerField;
    QryBudgetDefName: TWideStringField;
    QryBudgetDefDescription: TWideStringField;
    QryBudgetDefStartDAte: TDateTimeField;
    QryBudgetDefEndDate: TDateTimeField;
    QryBudgetDefAmount1Label: TWideStringField;
    QryBudgetDefAmount2Label: TWideStringField;
    QryBudgetDefIntervalPeriod: TSmallintField;
    dsLines: TDataSource;
    cboJob: TwwDBLookupCombo;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    cboBudgetName: TwwDBLookupCombo;
    pnlBudgetDetails: TDNMPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    qryJobs: TERPQuery;
    qryJobsJobName: TWideStringField;
    qryJobsJobNumber: TIntegerField;
    qryJobsClientID: TIntegerField;
    chkbugetforJob: TwwCheckBox;
    Label8: TLabel;
    cboBudgetNoDates: TwwDBComboBox;
    cboBudgetNO: TwwDBComboBox;
    QryTemp: TERPQuery;
    budgetFrom: TwwDBDateTimePicker;
    budgetTo: TwwDBDateTimePicker;
    budgetInterval: TwwDBComboBox;
    QryTempPeriodNo: TIntegerField;
    QryTempBudgetDate: TDateTimeField;
    QryTempPeriodDescription: TWideStringField;
    QryTempJobId: TIntegerField;
    QryTempJobName: TWideStringField;
    QryTempForDate: TWideStringField;
    QryTempDefault_amt1: TFloatField;
    QryTempDefault_amt2: TFloatField;
    QryTempMelbourne_amt1: TFloatField;
    QryTempMelbourne_amt2: TFloatField;
    QryTempAllClass_Amt1: TFloatField;
    QryTempAllClass_Amt2: TFloatField;
    QryTempActive: TWideStringField;
    ProgressBar: TProgressBar;
    DNMSpeedButton1: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cboBudgetNameChange(Sender: TObject);
    procedure cboBudgetNameNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkbugetforJobClick(Sender: TObject);
    procedure cboBudgetNoDatesCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure grdBudgetsEnter(Sender: TObject);
    procedure cboJobCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnNewClick(Sender: TObject);
    procedure chkFreezeColumnClick(Sender: TObject);
    procedure grdBudgetsIButtonClick(Sender: TObject);
    procedure cboBudgetNameEnter(Sender: TObject);
    procedure cboBudgetNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdBudgetsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    
  private
    fbSaveBtnClicked: boolean;
    fiAccountId         : Integer;
    fibudgetDefId       : integer;
    fsAccountName       : String;
    Budget              : TBusObjAccountBudget;
    fsDefaultCaption    : String;
    procedure RefreshTotals;
    Function SAveRecord:Boolean;

  public
    Property AccountId   : Integer write fiAccountId;
    Property AccountName : String  Write fsAccountName;
    Property BudgetDefId : Integer write fiBudgetDefID;

  end;


implementation

uses FastFuncs,CommonDbLib, CommonLib, BusObjBase, BusObjBudgetDef, tcConst;

{$R *.dfm}

procedure TfmAccountbudget.cboBudgetNameCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
    FieldList :TStringList;
    i :Integer;
begin
  inherited;
  if Modified = false then Exit;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  fiBudgetDefId :=QryBudgetDefbudgetId.asInteger;
  budgetInterval.Datafield := 'IntervalPeriod';
  BudgetTo.Datafield := 'EndDate';
  BudgetFrom.DataField := 'StartDAte';
  pnlBudgetDetails.Visible := true;
  if assigned(Budget) then freeandNil(Budget);
  Budget := TBusObjAccountBudget.Create(self);
  Budget.Connection := TMydacDataconnection.Create(Budget);
  ProgressBar.Visible := True;
  Budget.Connection.connection := Myconnection;
  Budget.AccountId := fiAccountId;
  Budget.BudgetDefId := QryBudgetDefbudgetId.asInteger;
  if cboBudgetNoDates.Items.Count > 0 then cboBudgetNoDates.Items.Clear;
  if cboBudgetNO.Items.Count > 0 then cboBudgetNO.Items.Clear;
  Budget.formLines;
  IF Budget.formLines.Dataset.Active then Budget.formLines.Dataset.Close;
  Budget.formLines.DatasetActive:= True;
  dsLines.Dataset :=Budget.formLines.Dataset;
  Budget.formLines.Refreshtotal := RefreshTotals;
  Budget.FormLines.ProgressBar := Self.ProgressBar;
  QryTemp.close;
  if not Budget.FormLines.Budgetdef.BudgetNos.IsEmpty then
  For i := 0 to Budget.FormLines.Budgetdef.BudgetNos.Count - 1 do begin
        cboBudgetNoDates.Items.add(Copy(IntToStr(Budget.FormLines.Budgetdef.BudgetNos[i].BudgetNo)+'     ' ,1,5) +  prdDesc(Budget.FormLines.Budgetdef.BudgetNos[i].StartDate ,
                Budget.FormLines.Budgetdef.BudgetNos[i].EndDate) + #9 +
          prdDesc(Budget.FormLines.Budgetdef.BudgetNos[i].StartDate,
                Budget.FormLines.Budgetdef.BudgetNos[i].EndDate) );
        cboBudgetNO.Items.add(IntToStr(Budget.FormLines.Budgetdef.BudgetNos[i].BudgetNo));
  end;
{display label}
  For i := 0 to Budget.formLines.Dataset.fields.count-1 do
    if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'PERIODNO' then
        Budget.formLines.Dataset.Fields[i].Displaylabel := 'Budget~No'
    else if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'FORDATE' then
        Budget.formLines.Dataset.Fields[i].Displaylabel := 'For Date'
    else if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = uppercase('BudgetDate') then
        Budget.formLines.Dataset.Fields[i].Displaylabel := 'Date'
    else if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = uppercase('JobName') then
        Budget.formLines.Dataset.Fields[i].Displaylabel := 'Job Name'
    else if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'PERIODDESCRIPTION' then
        Budget.formLines.Dataset.Fields[i].Displaylabel := 'Budget Period'
    else if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'BUDGETDATE' then
        Budget.formLines.Dataset.Fields[i].Displaylabel := 'Budget~Date'
    else if uppercase(Copy(Budget.formLines.Dataset.Fields[i].Fieldname, char_length(Budget.formLines.Dataset.Fields[i].Fieldname) - 4, 5)) = '_AMT1' then begin
        if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'ALLCLASS_AMT1' then
            Budget.formLines.Dataset.Fields[i].Displaylabel := 'All class~' + Budget.formLines.Budgetdef.Amount1Label
        else
            Budget.formLines.Dataset.Fields[i].Displaylabel := Copy(Budget.formLines.Dataset.Fields[i].Fieldname, 1, char_length(Budget.formLines.Dataset.Fields[i].Fieldname) - 5) +
                                        '~' + Budget.formLines.Budgetdef.Amount1Label;
        TFloatField(Budget.formLines.Dataset.Fields[i]).currency := true;
    end else if uppercase(Copy(Budget.formLines.Dataset.Fields[i].Fieldname, char_length(Budget.formLines.Dataset.Fields[i].Fieldname) - 4, 5)) = '_AMT2' then begin
        if uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'ALLCLASS_AMT2' then
            Budget.formLines.Dataset.Fields[i].Displaylabel := 'All Class~' + Budget.formLines.Budgetdef.Amount2Label
        else
            Budget.formLines.Dataset.Fields[i].Displaylabel := Copy(Budget.formLines.Dataset.Fields[i].Fieldname, 1, char_length(Budget.formLines.Dataset.Fields[i].Fieldname) - 5) +
                                    '~' + Budget.formLines.Budgetdef.Amount2Label;
        TFloatField(Budget.formLines.Dataset.Fields[i]).currency := true;
    end;

    FieldList := TStringList.Create;
    For i := 0 to Budget.formLines.Dataset.fields.count-1 do
        {following 7 fields are to hide}
        if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('ID') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('PeriodID') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('Active') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('JobId') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('PeriodNo') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('StartDate') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('EndDate') then
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('PeriodDescription') then
            FieldList.Add(uppercase(Budget.formLines.Dataset.fields[i].FieldName)+#9+'25'+#9+Budget.formLines.Dataset.fields[i].displayLabel+#9#9)
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('BudgetDate') then
            FieldList.Add(uppercase(Budget.formLines.Dataset.fields[i].FieldName)+#9+'10'+#9+Budget.formLines.Dataset.fields[i].displayLabel+#9#9)
        else if uppercase(Budget.formLines.Dataset.fields[i].FieldName) = uppercase('JobName') then
            FieldList.Add(uppercase(Budget.formLines.Dataset.fields[i].FieldName)+#9+'25'+#9+Budget.formLines.Dataset.fields[i].displayLabel+#9#9)
        {leave the all class amounts for the end}
        else if (uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) <> 'ALLCLASS_AMT1') and
            (uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) <> 'ALLCLASS_AMT2') then
            FieldList.Add(uppercase(Budget.formLines.Dataset.fields[i].FieldName)+#9+'1'+#9+Budget.formLines.Dataset.fields[i].displayLabel+#9#9);

    {adding allclass amounts at the end }
    For i := 0 to Budget.formLines.Dataset.fields.count-1 do
        if (uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'ALLCLASS_AMT1') or
            (uppercase(Budget.formLines.Dataset.Fields[i].Fieldname) = 'ALLCLASS_AMT2') then
            FieldList.Add(uppercase(Budget.formLines.Dataset.fields[i].FieldName)+#9+'1'+#9+Budget.formLines.Dataset.fields[i].displayLabel+#9+'T'+#9);

    grdBudgets.Selected := fieldList;
    grdBudgets.applySelected;

  grdBudgets.ControlInfoInDataSet := False;
  grdBudgets.ControlType.Clear;
  grdBudgets.ControlType.add('PeriodDescription;CustomEdit;cboBudgetNoDates;F');
  grdBudgets.ControlType.add('JobName;CustomEdit;cboJob;F');
  grdBudgets.ControlType.add('ForDate;CheckBox;T;F');
  if assigned(fieldList) then begin
     grdBudgets.Selected := fieldList;
    grdBudgets.applySelected;
  end;
  Budget.formLines.PopulateBudgetNos;
  {close and open to show the records in order}
  Budget.formLines.Dataset.close;
  Budget.formLines.Dataset.Open;
  chkbugetforJob.Checked := False;
  Budget.FormLines.Dataset.FindField('Jobname').Visible := chkbugetforJob.Checked = true;
  Budget.FormLines.SetLineFields;
  Budget.FormLines.CalcTotalAll;
  Budget.FormLines.Dataset.First;
  ProgressBar.Visible := False;
  Budget.Dirty := false;
  Budget.FormLines.Dirty := false;
  SetControlFocus(grdBudgets);

end;


procedure TfmAccountbudget.cboBudgetNameChange(Sender: TObject);
begin
  inherited;
    SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmAccountbudget.cboBudgetNameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  inherited;
    frmToPopup := TBaseInputGUI(GetComponentByClassName('TfmBudgetDef'));
    OnComboNotInList(Sender, LookupTable, NewValue, Accept);
    frmToPopup := nil;
end;

procedure TfmAccountbudget.FormCreate(Sender: TObject);
begin
  fsDefaultCaption := Self.Caption;
  inherited;
  fiAccountId := 0;
  fsAccountName := '';
end;

procedure TfmAccountbudget.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    if fsAccountName <> '' then begin
      TitleLabel.Caption := 'Budget for ' + fsAccountName;
      Self.Caption := replacestr(Self.Caption, fsDefaultCaption , 'Budget for ' + fsAccountName);
    end;
    fbSaveBtnClicked := false;
    inherited;
    if fiAccountId = 0 then Self.close;
    {delete records from the temporary table. this table is repopulated when the
    budget is selected, but used for the blank grid in the begennign}
    with TERPQuery.Create(nil) do Try
      Options.FlatBuffers := True;
      Connection := GetSharedMyDacConnection;
      SQl.add('delete from tmp_Budget');
      Execute;
    finally
        if Active then Close;
        Free;
    end;

    openQueries;
    if (fiBudgetDefId<> 0) then
      if QryBudgetDef.Locate('BudgetId' ,fiBudgetDefId , []) then begin
        cboBudgetName.Text := QryBudgetDefName.asString;
        budgetInterval.Datafield := 'IntervalPeriod';
        BudgetTo.Datafield := 'EndDate';
        BudgetFrom.DataField := 'StartDAte';
        if cboBudgetName.LookupTable.Locate('BudgetID' ,fiBudgetDefId, []) then
            cboBudgetNameCloseUp(cboBudgetName, cboBudgetName.LookupTable , Nil, True);
      end;
  finally
    EnableForm;
  end;
end;

procedure TfmAccountbudget.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Self.Enabled := false;
  CloseQueries;
  if Assigned(Budget) then FreeandNil(Budget);
  Action := caFree;
  inherited;

end;

procedure TfmAccountbudget.chkbugetforJobClick(Sender: TObject);
begin
  inherited;
  Budget.FormLines.Dataset.FindField('Jobname').Visible := chkbugetforJob.Checked = true;
end;
procedure TfmAccountbudget.cboBudgetNoDatesCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);

begin
  inherited;
  if cboBudgetNoDates.ItemIndex = -1 then Exit;
  Budget.FormLines.PeriodNo := FastFuncs.StrToInt(cboBudgetNo.Items[cboBudgetNoDates.ItemIndex]);
end;

procedure TfmAccountbudget.grdBudgetsEnter(Sender: TObject);
begin
  inherited;
    if cboBudgetName.Text = '' then begin
        SetControlFocus(cboBudgetName);
        Exit;
    end;
    if grdBudgets.Datasource.Dataset.Recordcount = 0 then grdBudgets.Datasource.Dataset.Insert;
end;

procedure TfmAccountbudget.cboJobCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
    FillTable.FieldByname('JobName').asString := Lookuptable.FieldByname('JobName').asString;
    FillTable.FieldByname('JobId').asInteger := Lookuptable.FieldByname('ClientID').AsInteger;
end;

procedure TfmAccountbudget.btnCancelClick(Sender: TObject);
begin
  inherited;
  fbSaveBtnClicked := false;
  Self.Close;
end;
Function TfmAccountbudget.SAveRecord:Boolean;
begin
    REsult := False;
  Budget.Formlines.Dataset.Disablecontrols;
  Try
      Budget.Formlines.PostDb;
      if Budget.Save = False then Exit;
  Finally
    Budget.Formlines.Dataset.EnableControls;
  end;
  Result := True;
end;
procedure TfmAccountbudget.btnSaveClick(Sender: TObject);
begin
  inherited;
  ProgressBar.Visible := True;
  Try
    fbSaveBtnClicked := true;
      if SaveRecord then begin
         Notify;
        Self.Close;
      end;
    finally
        ProgressBar.Visible := False;
    end;
end;

procedure TfmAccountbudget.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  MsgOption: integer;
begin
    if not assigned(Budget) then begin
        CanClose := True;
        Exit;
    end;
  if (Budget.Dirty = false) and ( Budget.FormLines.Dirty = false) then CanClose := true
  else if fbSaveBtnClicked = false then begin
    MsgOption := CommonLib.MessageDlgXP_Vista('Do you wish to Save changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if msgOption = mrYes then begin
      if Budget.Save = false then begin
        CanClose := false;
      end;
    end else if MsgOption = mrNo then RollbackTransaction
    else CanClose := false;
  end;
  if Canclose then inherited;
end;

procedure TfmAccountbudget.btnNewClick(Sender: TObject);
begin
  inherited;
  if Budget.Save = false then begin
    Exit;
  end;
  fbSaveBtnClicked := false;
  KeyId := 0;
  FormShow(Self);
end;

procedure TfmAccountbudget.chkFreezeColumnClick(Sender: TObject);
begin
  inherited;
  if chkFreezeColumn.Checked then begin
    grdBudgets.FixedCols     := 1;
  end else begin
    grdBudgets.FixedCols := 0;
  end;
end;
procedure TfmAccountbudget.RefreshTotals;
var
  ctr: integer;
  strclassName: string;
begin
  if not assigned(budget.FormLines) then Exit;
  if not Assigned(Budget.FormLines.Budgetdef) then Exit;

  Budget.CalcTotal;
  with Budget.formlines.Budgetdef.BudgetClasses.Dataset do begin
    First;
    ctr := 0;
    while Eof = false do begin
      if FieldByName('Active').AsBoolean then begin
        strclassName := Budget.FormLines.GetClassName(FieldByName('ClassId').AsInteger);
        if High(Budget.FooterTotals1) >= ctr then grdBudgets.ColumnByName(strclassName + '_Amt1').FooterValue :=
            FloatToStrF(Budget.FooterTotals1[ctr], ffCurrency, 15, CurrencyRoundPlaces);
        if High(Budget.FooterTotals2) >= ctr then grdBudgets.ColumnByName(strclassName + '_Amt2').FooterValue :=
            FloatToStrF(Budget.FooterTotals2[ctr], ffCurrency, 15, CurrencyRoundPlaces);
        ctr := ctr + 1;
      end;
      Next;
    end;
    if High(Budget.FooterTotals1) >= ctr then grdBudgets.ColumnByName('AllClass_Amt1').FooterValue :=
        FloatToStrF(Budget.FooterTotals1[ctr], ffCurrency, 15, CurrencyRoundPlaces);
    if High(Budget.FooterTotals2) >= ctr then grdBudgets.ColumnByName('AllClass_Amt2').FooterValue :=
        FloatToStrF(Budget.FooterTotals2[ctr], ffCurrency, 15, CurrencyRoundPlaces);
    grdBudgets.ColumnByName('BudgetDate').FooterValue := 'Total';
  end;
end;


procedure TfmAccountbudget.grdBudgetsIButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this account from the budget?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then Budget.FormLines.Dataset.Delete;
end;

procedure TfmAccountbudget.cboBudgetNameEnter(Sender: TObject);
var MsgOption :Integer;
begin
  inherited;
    if fiBudgetdefId <> 0 then begin
        if budget.dirty = False then MsgOption :=  mrNo else
        MsgOption := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
        if MsgOption = mrCancel then SetControlFocus(grdBudgets)
        else if MsgOption = mrYes then if not Saverecord then SetControlFocus(grdBudgets);
    end;
end;

procedure TfmAccountbudget.grdBudgetsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  with grdBudgets.Datasource.Dataset do begin
    if not Active then Exit;
    if (uppercase(Field.fieldName) = 'ALLCLASS_AMT1') or
        (uppercase(Field.fieldName) = 'ALLCLASS_AMT2') then
        AFont.Color :=clInactiveCaption;
  end;  
end;

procedure TfmAccountbudget.DNMSpeedButton1Click(Sender: TObject);
var
    ctr:Integer;
function IsAmtField(const FieldName: string): boolean;
begin
  Result := false;
  if uppercase(Copy(FieldName, char_length(fieldName) - 4, 4)) = '_AMT' then
    if uppercase(Copy(FieldName, 1, 12)) <> 'ALLCLASS_AMT' then Result := true;
end;

begin
  DisableForm;
  try
    inherited;
    with grdBudgets.datasource.dataset do begin
      First;
      While eof = False do begin
          for Ctr := 0 to FieldCount - 1 do
              if IsAmtField(Fields[Ctr].Fieldname) then begin
                  if state <> dsedit then Edit;
                  fieldByname(Fields[Ctr].Fieldname).asfloat := ctr;
              end;
          if state = dsedit then Post;
          Next;
      end;
    end;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfmAccountbudget);

end.

