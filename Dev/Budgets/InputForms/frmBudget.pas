unit frmBudget;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/05  1.00.00 BJ  Initial version.
 21/12/05  1.00.01 BJ  Budgetname - notinlist impelented. correted the alignment
 17/01/06  1.00.02 BJ  Period no is disabled. When the budget is selected,
                       the next period is automaitically displayed, it is not
                       possible to skip any period - ie, if need to create period 3
                       records for period 1 and 2 shoudl exists.

                       When a new record is created, selecting the budget name will
                       display the budget's all accounts for the new record.If need to
                       add a new account name, the account name is added for
                       all the rest of the periods after a confirmation
 17/02/06  1.00.03 BJ  Introduced copytoallPeriod option
                       Double click on the grid to see the budget of the selected account
                       for all periods of the seelected budget
                       Deleting an account from the list will store the line with 0 amounts
                       if the account is already added to the budget definition
 09/03/06  1.00.04 DSP Changed handling of access levels.
 26/04/06  1.00.05 DSP Changed position of date combo boxes so they are aligned.
 19/09/06  1.00.06 DSP Added DBMemo for notes. 

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  wwdblook, wwdbdatetimepicker, Wwdotdot, Wwdbcomb,
  StdCtrls, Mask, wwdbedit, ExtCtrls, DNMPanel, BusObjBudget,
  MemDS, wwcheckbox, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, wwclearbuttongroup, wwradiogroup, DBCtrls, Shader,
  dmGUIStylers,BusObjBase, ImgList, ProgressDialog;

const
    SX_BUDGETNOTINLIST = WM_USER+125;
type
  TfmBudget = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    DNMPanel5: TDNMPanel;
    Label4: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    dsBudget: TDataSource;
    qryAccounts: TERPQuery;
    qryAccountsAccountId: TIntegerField;
    qryAccountsAccountname: TWideStringField;
    cboBudgetName: TwwDBLookupCombo;
    QryBudgetDef: TERPQuery;
    dsBudgetDef: TDataSource;
    Budget_Dataset: TERPQuery;
    Budget_DatasetBudgetPeriodID: TIntegerField;
    Budget_DatasetBudgetId: TIntegerField;
    Budget_DatasetBudgetDate: TDateTimeField;
    Budget_DatasetBudgetNo: TIntegerField;
    Budget_DatasetStartDate: TDateTimeField;
    Budget_DatasetEndDate: TDateTimeField;
    Budget_DatasetActive: TWideStringField;
    Budget_DatasetEditedFlag: TWideStringField;
    pnlBudgetDetails: TDNMPanel;
    budgetFrom: TwwDBDateTimePicker;
    budgetTo: TwwDBDateTimePicker;
    BudgetInterval: TwwDBComboBox;
    mnuFreezegrdcol: TAdvPopupMenu;
    mnuFreezecol: TMenuItem;
    BudgetLines_Dataset: TERPQuery;
    dsBudgetLines_Dataset: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    DNMPanel2: TDNMPanel;
    cboAccountname: TwwDBLookupCombo;
    pnlPeriod: TDNMPanel;
    Label3: TLabel;
    pnlPeriods: TDNMPanel;
    wwDBDateTimePicker3: TwwDBDateTimePicker;
    wwDBDateTimePicker4: TwwDBDateTimePicker;
    cboBudgetNoDates: TwwDBComboBox;
    grdBudgets: TwwDBGrid;
    grdBudgetsIButton: TwwIButton;
    chkFreezeColumn: TwwCheckBox;
    Label7: TLabel;
    cboJob: TwwDBLookupCombo;
    qryJobs: TERPQuery;
    qryJobsClientID: TIntegerField;
    qryJobsJobNumber: TIntegerField;
    qryJobsJobName: TWideStringField;
    Label8: TLabel;
    chkbugetforJob: TwwCheckBox;
    edtBudgetNo: TwwDBEdit;
    qryAccountsNewAccount: TWideStringField;
    cboBudgetNO: TwwDBComboBox;
    dtBudgetDate: TwwDBDateTimePicker;
    btnCopy: TDNMSpeedButton;
    ProgressBar: TProgressBar;
    Label9: TLabel;
    qryAccountsAccountType: TWideStringField;
    dbmNotes: TDBMemo;
    Label10: TLabel;
    Budget_DatasetNotes: TWideMemoField;
    qryJobsCompany: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnExport: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cboBudgetNoDatesCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure cboBudgetNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboAccountnameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdBudgetsEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure cboBudgetNoDatesEnter(Sender: TObject);
    procedure chkActiveEnter(Sender: TObject);
    procedure cboAccountnameEnter(Sender: TObject);
    procedure grdBudgetsIButtonClick(Sender: TObject);
    procedure cboAccountnameDropDown(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkFreezeColumnClick(Sender: TObject);
    procedure chkbugetforJobClick(Sender: TObject);
    procedure cboJobDropDown(Sender: TObject);
    procedure cboJobCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure cboBudgetNameNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboBudgetNameChange(Sender: TObject);
    procedure grdBudgetsKeyPress(Sender: TObject; var Key: Char);
    procedure dtBudgetDateEnter(Sender: TObject);
    procedure grdBudgetsDblClick(Sender: TObject);
    procedure grdBudgetsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnCopyClick(Sender: TObject);
    procedure cboBudgetNameEnter(Sender: TObject);
    procedure cboBudgetNameDropDown(Sender: TObject);
    procedure cboBudgetNameExit(Sender: TObject);
    procedure grdBudgetsColWidthChanged(Sender: TObject; Column: Integer);
    procedure btnExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }

    Budget: TBusObjBudget;
    fbSaveBtnClicked: boolean;
    fbNewBudget :boolean;
    FieldList :TStringList;
    updatingcheckBox : boolean;
    NameNotInList :Boolean;
    fsBudgetNAme :String;
    fiBudgetDefId: Integer;
    procedure RefreshTotals;
    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    procedure CreateBudgetAccounts;
    function BudgetSaved: Boolean;
    procedure CloseObjects;
    procedure BudgetNotInList(var Message: TMessage); message SX_BUDGETNOTINLIST;
    Procedure SetGridFields;
    procedure NextPeriod(xbudgetID: Integer);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);override;
    procedure GetGridColumnWidths;
    Property BudgetDefId :Integer read fiBudgetDefId write fiBudgetDefId;
  protected
    procedure CompleteComboNotInList(const aObserver: TObject); override;

  end;


implementation

uses FastFuncs,FormFactory, BusObjBudgetDef, CommonLib, CommonDbLib,
  frmAccountbudget, frmBudgetCopy, Budget, DNMExceptions, frmBudgetDef,
  BusObjConst, AppEnvironment, tcConst, frmBudgetExportImportSelect,
  BusObjGLAccount, BusObjClient, DateTimeUtils;

{$R *.dfm}
procedure TfmBudget.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TBusObjBudget then TBusObjBudget(Sender).Dataset             := Budget_Dataset
        else if Sender is TBusObjFormLines then TBusObjFormLines(Sender).Dataset  := BudgetLines_Dataset;
    end;
end;
procedure TfmBudget.FormCreate(Sender: TObject);
begin
  AllowGridSorting  := True;
  fiBudgetDefId := 0;
  inherited;
//  fbTabSettingEnabled := false;
  fbNewBudget := True;
  updatingcheckBox := False;

  Budget                        := TBusObjBudget.create(Self);
  Budget.connection             := TMyDacDataConnection.Create(Budget);
  Budget.Connection.connection  := Myconnection;
  Budget.BusObjEvent            := DoBusinessObjectEvent;
  Budget.FormLines.OwnerBudget  := Budget;
  Budget.FormLines.BusObjEvent  := DoBusinessObjectEvent;
  Budget.formLines.Refreshtotal := RefreshTotals;
  Budget.TableName              := 'tmp_Budget' + GetTemporaryTableNameSuffix;

  GuiPrefs.Active := True;
end;

procedure TfmBudget.FormShow(Sender: TObject);
var
  i: Integer;
  frm:TForm;
begin
  DisableForm;
  try
    try
        inherited;

        {cboAccountname is embedded in the Grid dynamically after the budget is
        selected, so set the left to outside the form's boundary so will not be
        visible when it is not embedded(when the budget is not selected)}
        NameNotInList         := False;
        cboAccountname.Left   := 2500;
        cbojob.Left           := 2500;
        fbSaveBtnClicked      := false;
        fbNewBudget           := Keyid = 0;

        if QryBudgetDef.Active= false then QryBudgetDef.Open;
        if qryBudgetDef.RecordCount = 0 then begin
          frm := TForm(GetComponentByClassType(getClass('TfmBudgetDef'),True));
          frm.FormStyle := fsMDIChild;
          frm.BringToFront;
          Self.Release;
          Exit;
        end;
        if qryJobs.Active     = false then qryJobs.Open;

        if (keyId >0)  or (BudgetDefId<>0) then begin
            BudgetFrom.Datafield := 'StartDAte';
            BudgetTo.Datafield   := 'EndDate';
            BudgetInterval.Datafield := 'IntervalPeriod';
        end else begin
            BudgetFrom.Datafield := '';
            BudgetTo.Datafield   := '';
            BudgetInterval.Datafield := '';
        end;
        pnlPeriods.Visible        := (KeyId > 0) ;
        pnlPeriod.Visible         := (KeyId > 0) ;
        cboBudgetNoDates.Enabled  := (KeyId = 0) ;

        Budget.Connection.BeginTransaction;

        if (KeyId <= 0) and (BudgetDefId=0) then begin
            Budget.New;
            KeyId := Budget.ID;
            cboBudgetName.Text := '';
            Budget.OpenLines;
        end else begin
          if BudgetDefId <> 0 then begin
            Budget.New;
            KeyId := Budget.ID;
            Budget.BudgetId :=BudgetDefId;
          end else begin
            Budget.Load(KeyId);
          end;
          QryBudgetDef.Locate('BudgetId', Budget.BudgetId, []);
          cboBudgetName.Text := Budget.BudgetDefinition.BudgetName;
          if BudgetLines_Dataset.Active then BudgetLines_Dataset.Close;
          Budget.OpenLines;
          RefreshTotals;
          Budget.FormLines.CalcTotalAll;
          if qryAccounts.Active  then qryAccounts.Close;
          for i := 0 to qryAccounts.SQl.count-1 do begin
              qryAccounts.SQL[i] := replaceStr(qryAccounts.SQL[i], 'tmp_budgets' ,' ' + Budget.TableName + ' ');
              qryAccounts.SQL[i] := replaceStr(qryAccounts.SQL[i], ':BudgetID' ,IntToStr(QryBudgetDef.FieldByname('budgetId').asInteger));
          end;
          qryAccounts.Open;
        end;
        chkbugetforJob.Checked := true;
        FieldList := TStringList.Create;
        SetGridfields;



       (* grdBudgets.ControlInfoInDataSet := False;
        grdBudgets.ControlType.Clear;
        grdBudgets.ControlType.add('AccountName;CustomEdit;cboAccountname;F');
        grdBudgets.ControlType.add('JobName;CustomEdit;cboJob;F');
        grdBudgets.ControlType.add('ForDate;CheckBox;T;F');
        grdBudgets.ControlType.add('BudgetDate;CustomEdit;dtBudgetDate;F');
        if assigned(fieldList) then begin
            grdBudgets.Selected := fieldList;
            grdBudgets.applySelected;
        end;*)

        {ApplyDatasetEvents is set to false to avoid executing them for the internal process
        of the object}
        Budget.ApplyDatasetEvents := true;
        if KeyId > 0 then     CreateBudgetAccounts;
        Budget.Dirty := false;
        Budget.formLines.Dirty := false;
        grdBudgets.DataSource.DataSet.FieldByName('SortId').Visible:= false;
        GetGridColumnWidths;
    except
      on EAbort do HandleEAbortException;

      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;

      on e: Exception do raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TfmBudget.BudgetNotInList(var Message: TMessage);
var
    Accept :Boolean;
begin
    fLastComboAccessed  := cboBudgetName;
    frmToPopup          := TBaseInputGUI(GetComponentByClassName('TfmBudgetDef'));
    if Assigned(frmToPopup) then begin
      Accept              := True;
      cboBudgetName.Text  :=fsBudgetNAme;
      OnComboNotInList(cboBudgetName, cboBudgetName.LookupTable, fsBudgetNAme, Accept);
      NameNotInList       := True;
      if not Accept then exit;
      SetcontrolFocus(frmToPopup);
      TfmBudgetDef(frmToPopup).EdtName.Text :=   fsBudgetNAme;
      frmToPopup          := nil;
      NameNotInList       := True;
      RollbackTransaction;
      if Assigned(Budget)      then Budget.Dirty      := False;
      if Assigned(Budget.formLines) then Budget.formLines.Dirty := False;
      Self.Close;
    end
    else begin
      Accept              := False;
    end;
end;
procedure TfmBudget.CloseObjects;
begin
end;

function TfmBudget.BudgetSaved: Boolean;
begin
  Budget.FormLines.dataset.DisableControls;
  try
      Result := Budget.Save;
  finally
     Budget.FormLines.dataset.Enablecontrols;
  end;
end;

procedure TfmBudget.btnSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    fbSaveBtnClicked := true;
    if BudgetSaved then begin
      Notify;
      Self.Close;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmBudget.btnCancelClick(Sender: TObject);
begin
  inherited;
  fbSaveBtnClicked := false;
  Self.Close;
end;

procedure TfmBudget.cboBudgetNoDatesCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  if cboBudgetNoDates.ItemIndex = -1 then Exit;
  Budget.BudgetNo := FastFuncs.StrToInt(cboBudgetNo.Items[cboBudgetNoDates.ItemIndex]);
  pnlPeriods.Visible := true;
  pnlPeriod.Visible := true;
  SetControlFocus(grdBudgets);
end;



procedure TfmBudget.cboBudgetNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
    inherited;
    if Modified = false then Exit;

    if NameNotInList then Exit;

    SaveLastComboAccessed(fLastComboAccessed ,Sender);

    pnlBudgetDetails.Visible := true;
    BudgetFrom.Datafield := 'StartDAte';
    BudgetTo.Datafield := 'EndDate';
    BudgetInterval.Datafield := 'IntervalPeriod';

    BudgetLines_Dataset.Close;
    cboBudgetName.Text := LookupTable.FieldByName('Name').AsString;
    BudgetDefId:= LookupTable.FieldByName('BudgetId').AsInteger;
    NextPeriod(LookupTable.FieldByName('BudgetId').AsInteger);
end;
procedure TfmBudget.NextPeriod(xbudgetID:Integer);
var
  ctr: integer;
begin
    Budget.BudgetId := xbudgetID;
    if cboBudgetNoDates.Items.Count > 0 then cboBudgetNoDates.Items.Clear;
    if cboBudgetNO.Items.Count > 0 then cboBudgetNO.Items.Clear;
    if Budget.BudgetId <> 0 then begin
        if not Budget.BudgetNos.IsEmpty then
        for ctr := 0 to Budget.BudgetNos.Count - 1 do begin
          if Budget.BudgetNos[ctr].BudgetRecExists = false then begin
            cboBudgetNoDates.Items.add(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Budget.BudgetNos[ctr].StartDate) + '   to   ' +
              FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Budget.BudgetNos[ctr].EndDate) + #9 + IntToStr(Budget.BudgetNos[ctr].BudgetNo));
            cboBudgetNO.Items.add(IntToStr(Budget.BudgetNos[ctr].BudgetNo));
          end;
        end;
    end;
    cboBudgetNoDates.Applylist;
    if cboBudgetNoDates.Items.Count = 0 then begin
        CommonLib.MessageDlgXP_Vista('All the periods for this budget definition are already created. New records cannot be created.'
                 ,mtWarning , [mbOk] , 0);
        TRy

                {if all budgets are already created open the last budget}
                KeyId := Budget.budgetDefinition.IDOfCurrentPeriod;
                RollbackTransaction ;
                FormShow(Self);
                SetControlFocus(cboBudgetName);
        Except

        end;
        Exit;
    end;
    Budget.OpenLines;
    if fbNewBudget then begin
        cboBudgetNoDates.ItemIndex := 0;
        cboBudgetNoDatesCloseUp(cboBudgetNoDates, True);
    end;

    if qryAccounts.Active  then qryAccounts.Close;
    for ctr := 0 to qryAccounts.SQl.count-1 do begin
        qryAccounts.SQL[ctr] := replaceStr(qryAccounts.SQL[ctr], 'tmp_budgets' ,' ' + Budget.TableName + ' ');
        qryAccounts.SQL[ctr] := replaceStr(qryAccounts.SQL[ctr], ':BudgetID' ,IntToStr(QryBudgetDef.FieldByname('budgetId').asInteger));
    end;
    qryAccounts.Open;

    CreateBudgetAccounts;
    SetControlFocus(grdBudgets);
    if BudgetLines_Dataset.recordcount = 0 then BudgetLines_Dataset.Insert;
    SetGridFields;
end;

Procedure TfmBudget.CreateBudgetAccounts;
var
  strSql: String ;
begin
  strSql :=      ' Select distinct tblBudgetperiodlines.AccountId , tblChartofAccounts.Accountname' +
          ' from tblBudgetperiodlines' +
          ' inner join tblBudgetperiods  on tblBudgetperiods.budgetPeriodid = tblBudgetperiodlines.BudgetPeriodId' +
          ' inner join tblChartofAccounts on tblChartofAccounts.AccountId = tblBudgetperiodlines.AccountId' +
          ' where tblBudgetperiodlines.budgetId = ' + IntToStr(Budget.BudgetID) +
          ' order by tblBudgetperiodlines.SortId';
  with TERPQuery.create(self) do try
      Options.FlatBuffers := True;
      Connection := Self.MyConnection;
      SQl.add(strSql);
      Open;
      if recordcount = 0 then Exit;
      First;
      {create all the accounts of the budget}
      while Eof = false do begin
          if BudgetLines_Dataset.Locate('AccountID',FieldByname('AccountId').asInteger , []) = False then begin
              BudgetLines_Dataset.insert;
              qryAccounts.Locate('AccountId' ,FieldByname('AccountId').asInteger , []);
              BudgetLines_Dataset.fieldbyname('AccountId').asInteger := FieldByname('AccountId').asInteger;
              BudgetLines_Dataset.fieldbyname('Accountname').asString := FieldByname('AccountName').asString;
              cboAccountnameCloseUp(cboAccountname ,cboAccountname.LookupTable, cboAccountname.Datasource.dataset, True);
              if BudgetLines_Dataset.State in [dsEdit,dsInsert] then  BudgetLines_Dataset.Post;
          end;
          Next;
      end;
  finally
      Free;
  end;
end;

procedure TfmBudget.cboAccountnameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if (fbNewBudget = False ) or (edtBudgetNo.Text <> '') (*and (FastFuncs.StrToInt(Trim(edtBudgetNo.Text)))) > 1))*)  then
      if qryAccountsNewAccount.asString = 'T' then begin
        if CommonLib.MessageDlgXP_Vista('This account is not defined for the currently selected budget.' + chr(13) +
                        'Selecting this will add it to the budget Definition. Do you wish to add this account?' , mtconfirmation, [mbYes, mbNo] , 0) = mrNo then begin
            BudgetLines_Dataset.Cancel;
            Exit;
        end;
        if Budget.Connection.Connection.intransaction = False then
            TMydacDataConnection(Budget.Connection).BeginTransaction;
        if not Budget.BudgetDefinition.AddnewAccount(qryAccountsAccountId.asInteger, Budget.BudgetNo) then begin
            BudgetLines_Dataset.Cancel;
            Exit;
        end;
      end;
  with BudgetLines_Dataset do begin
    if State in [dsEdit, dsInsert] then else Edit;
    FieldByName('AccountId').AsInteger  := LookupTable.FieldByName('AccountId').AsInteger;
    if State in [dsEdit, dsInsert] then
        FieldByName('AccountName').AsString := LookupTable.FieldByName('AccountName').AsString;
    if State in [dsEdit, dsInsert] then Post;
  end;
end;

procedure TfmBudget.grdBudgetsEnter(Sender: TObject);
begin
  inherited;
  if edtBudgetNo.Text = '' then begin
    HintDisabledSetFocus:= True;
    Try
        SetControlFocus(cboBudgetName);
    Finally
        HintDisabledSetFocus := False;
    end;
    Exit;
  end;

  if BudgetLines_Dataset.FindField('AllClass_Amt1') <> nil then
    BudgetLines_Dataset.FindField('AllClass_Amt1').ReadOnly := true;
  if BudgetLines_Dataset.FindField('AllClass_Amt2') <> nil then
    BudgetLines_Dataset.FindField('AllClass_Amt2').ReadOnly := true;
  if BudgetLines_Dataset.recordcount > 0 then
      grdBudgets.SetActivefield('Fordate');
end;

procedure TfmBudget.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  MsgOption: integer;
begin
if (not (Assigned(Budget)))  then CanClose := true
  else if (Budget.Dirty = false) and ( Budget.formLines.Dirty = false) then CanClose := true
  else if fbSaveBtnClicked = false then begin
    MsgOption := CommonLib.MessageDlgXP_Vista('Do you wish to Save changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if msgOption = mrYes then begin
      Budget.FormLines.dataset.DisableControls;
      Try
        Budget.Save;
      Finally
        Budget.FormLines.dataset.Enablecontrols;
      End;
      if Budget.BudgetSaved = false then begin
        CanClose := false;
      end;
    end else if MsgOption = mrNo then RollbackTransaction
    else CanClose := false;
  end;
  if Canclose then inherited;
end;

procedure TfmBudget.cboBudgetNoDatesEnter(Sender: TObject);
begin
  inherited;
  if cboBudgetName.Text = '' then SetControlFocus(cboBudgetName)
  else
    SetControlFocus(cboBudgetNoDates);
end;

procedure TfmBudget.chkActiveEnter(Sender: TObject);
begin
  inherited;
  if edtBudgetNo.Text = '' then begin
    SetControlFocus(edtBudgetNo);
    Exit;
  end;
end;

procedure TfmBudget.cboAccountnameEnter(Sender: TObject);
begin
  inherited;
  if edtBudgetNo.Text = '' then begin
    SetControlFocus(edtBudgetNo);
    Exit;
  end;
end;

procedure TfmBudget.grdBudgetsIButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this account from the budget?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then Budget.FormLines.Delete;
    {This makes the record inactive
    The form has a filter for showing only the active records,
    the record disappears from the list}
end;

procedure TfmBudget.RefreshTotals;
var
  ctr: integer;
  strclassName: string;
begin
  if not Assigned(Budget.BudgetDefinition) then Exit;
  if not Assigned(budget.Formlines) then Exit;

  Budget.CalcTotal;
  with Budget.BudgetDefinition.BudgetClasses.Dataset do begin
    First;
    ctr := 0;
    while Eof = false do begin
      if FieldByName('Active').AsBoolean then begin
        strclassName := Budget.GetClassName(FieldByName('ClassId').AsInteger);
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
  Budget.FormLines.AmountChanged := false;
end;

procedure TfmBudget.cboAccountnameDropDown(Sender: TObject);
begin
  inherited;
  if not qryAccounts.Active  then qryAccounts.Open;
end;

procedure TfmBudget.btnNewClick(Sender: TObject);
var
  xBudgetID:Integer;
begin
  DisableForm;
  try
    inherited;
    fbSaveBtnClicked := false;
    Budget.FormLines.dataset.DisableControls;
    try
        Budget.Save;
    finally
       Budget.FormLines.dataset.Enablecontrols;
    end;
    if Budget.BudgetSaved = false then begin
      Exit;
    end;
    (*BudgetDefId := budget.budgetId;
    Budget.Kill;
    BudgetName :=cboBudgetName.Text;
    KeyId := 0;
    FormShow(Self);*)
    xBudgetID:=Budget.budgetID;
    Budget.Kill;
    Budget.NEw;
    KeyId:=0;
    fbNewBudget:= true;
    NextPeriod(xBudgetID);
  finally
    EnableForm;
  end;  
  SetControlFocus(grdBudgets);
end;

procedure TfmBudget.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseObjects;
  if assigned(FieldList) then FreeandNil(FieldList);
  inherited;
  Action := caFree;
end;

procedure TfmBudget.chkFreezeColumnClick(Sender: TObject);
begin
  inherited;
    if updatingcheckBox then Exit;
    updatingcheckBox := true;
    Try
        if chkFreezeColumn.Checked then begin
            if (cboBudgetNoDates.Enabled) and (cboBudgetNoDates.Items.Count = 0) then begin
                chkFreezeColumn.Checked := False;
                Exit;
            end;
            grdBudgets.SelectedField := Budget.FormLines.DataSet.Fields[3];
            grdBudgets.FixedCols     := 1;
        end else begin
            grdBudgets.FixedCols := 0;
        end;
    Finally
        updatingcheckBox := False;
    end;
end;

procedure TfmBudget.chkbugetforJobClick(Sender: TObject);
begin
  inherited;
  if updatingcheckBox then Exit;
  updatingcheckBox := True;
  Try
    if (cboBudgetNoDates.Items.Count = 0) and (KeyId = 0) then begin
        chkbugetforJob.Checked := False;
        Exit;
    end;
    Budget.FormLines.Dataset.FindField('Jobname').Visible := chkbugetforJob.Checked = true;
  Finally
    updatingcheckBox := False;
  End;
end;

procedure TfmBudget.cboJobDropDown(Sender: TObject);
begin
  inherited;
  if BudgetLines_Dataset.State = dsBrowse then BudgetLines_Dataset.Edit;
end;

procedure TfmBudget.cboJobCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  inherited;
  if Modified = false then Exit;
  with BudgetLines_Dataset do begin
    if State in [dsEdit, dsInsert] then else Edit;
    FieldByName('JobId').AsInteger  := LookupTable.FieldByName('ClientId').AsInteger;
    FieldByName('JobName').AsString := LookupTable.FieldByName('Company').AsString;
    if State in [dsEdit, dsInsert] then Post;
  end;
end;


procedure TfmBudget.cboBudgetNameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
    fsBudgetNAme:=TwwDBLookupCombo(Sender).TExt;   
    PostMessage(Self.Handle , SX_BUDGETNOTINLIST , 0 ,0);
end;

procedure TfmBudget.cboBudgetNameChange(Sender: TObject);
begin
  inherited;
    SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmBudget.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  if Cancelled then  begin
    if Assigned(fLastComboAccessed) then     begin
      fLastComboAccessed.Text := '';
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboBudgetName') then begin
        fLastComboAccessed.LookupTable.Close;
        fLastComboAccessed.LookupTable.Open;
      end;
    end;
  end else if (Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed)) then  begin
    if Sysutils.SameText(fLastComboAccessed.Name, 'cboBudgetName') then begin
        with fLastComboAccessed do begin
            LookupTable.Close;
            LookupTable.Open;
            if LookupTable.Locate('BudgetID' ,TBaseInputGUI(aObject).KeyID , []) then begin
                cboBudgetNameCloseup(fLastComboAccessed, LookupTable,Nil , True);
            end;
        end
    end;
  end;
end;

procedure TfmBudget.CompleteComboNotInList(const aObserver: TObject);
begin
  if Assigned(fLastComboAccessed) then
    if fLastComboAccessed.Enabled then
        if fLastComboAccessed.Visible then
            SetControlFocus(fLastComboAccessed);
end;

procedure TfmBudget.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) then
    if fLastComboAccessed.Enabled then
      if fLastComboAccessed.Visible then
        SetControlFocus(fLastComboAccessed);
end;

procedure TfmBudget.grdBudgetsKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if uppercase(grdBudgets.GetActiveField.FieldName) = uppercase('budgetdate') then
    if BudgetLines_Dataset.findField('budgetdate').readonly then
        if (Key >= '0') and (Key <= '9') then
            CommonLib.MessageDlgXP_Vista('Please enable ''For date'' to allcoate a date for this entry.' , mtWarning, [mbOK] , 0);
  (* if key = #13 then
    if grdBudgets.Datasource.dataset.State in [dsEdit,dsInsert] then //grdBudgets.Datasource.dataset.Post
    else grdBudgetsDblClick(grdBudgets) ;*)
end;

procedure TfmBudget.dtBudgetDateEnter(Sender: TObject);
begin
  inherited;
    if BudgetLines_Dataset.findField('budgetdate').readonly then
            CommonLib.MessageDlgXP_Vista('Please enable ''For date'' to allcoate a date for this entry.' , mtWarning, [mbOK] , 0);

end;

procedure TfmBudget.grdBudgetsDblClick(Sender: TObject);
var
  fiBudgetdefId :Integer;
  fiAccountId :Integer;
  fsAccountName :String;
  Form : TComponent;
  MsgOption: integer;
  recSaved :boolean;
begin
  fiBudgetdefId := QryBudgetDef.FieldByname('budgetId').asInteger;
  fiAccountId := BudgetLines_Dataset.FieldByname('AccountID').asInteger;
  fsAccountName := BudgetLines_Dataset.FieldByname('AccountName').asString;
  {if the account is not selected in the current record - new recrd -
  the Account budget form cannot be openend}
  if (fiAccountId =0) or (fsAccountname = '') then Exit;

  fbSaveBtnClicked := true;
  if (Budget.Dirty = false) and ( Budget.formLines.Dirty = false)    then
    recSaved := True
  else begin
    MsgOption := CommonLib.MessageDlgXP_Vista('Opening the Account''s budget will Save the current changes. ' + chr(13) + ' Do you wish to Save?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if msgOption = mrYes then begin
        Budget.FormLines.dataset.Disablecontrols;
        try
            recSaved := Budget.Save
        finally
            Budget.FormLines.dataset.Enablecontrols;
        end;
    end else recSaved := MsgOption = mrNo;
  end;

  if not recSaved then Exit;

    Form := GetComponentByClassName('TfmAccountbudget');
    if Assigned(Form) then begin
    with TfmAccountbudget(Form) do begin
      AttachObserver(Self);
      AccountId := fiAccountID;
      AccountName := fsAccountName;
      BudgetdefId :=fiBudgetDefId;
      FormStyle := fsMDIChild;
      BringToFront;
      cboBudgetNameCloseUp(cboBudgetName, cboBudgetName.LookupTable , Nil, True);
    end;

  end;
  Notify;
  Self.Close;
end;

procedure TfmBudget.grdBudgetsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  with grdBudgets.Datasource.Dataset do begin
  if NameNotInList then Exit;
    if not Active then Exit;
    if (uppercase(Field.fieldName) = 'ALLCLASS_AMT1') or
        (uppercase(Field.fieldName) = 'ALLCLASS_AMT2') then
        AFont.Color :=clInactiveCaption;
  end;
end;

procedure TfmBudget.btnCopyClick(Sender: TObject);
var
  form : TfmBudgetCopy;
  Ctr :Integer;
  Budgetdef: TBusObjBudgetDef;
  BudgetFrom :Integer;
begin
  DisableForm;
  try

    inherited;
    Form := TfmBudgetCopy(GetComponentByClassName('TfmBudgetCopy'));
    Try
      with form  do begin
        lblCopy.Caption :='This will Save the record and overwrite all the periods of ' +Trim(cboBudgetName.Text) +
                  ' after ' + FormatDatetime('dd/mm/yyyy' , wwDBDateTimePicker4.date);
        ShowModal;
        if Form.ModalResult = MrOk then begin
          ProcessingCursor(True);
          Application.ProcessMessages;
          if Budget.Save then begin
              if Trim(edtVariationAmt.Text) = '' then edtVariationAmt.Text := '0';
              Budgetdef := TBusObjBudgetDef.Create(Application);
              Budgetdef.Connection := Budget.connection;
              Budgetdef.Connection.BeginTransaction;
              Budget.formLines.Dirty := False;
              Budgetdef.CommitOnSave := False;
              BudgetDef.Load(QryBudgetDef.FieldByName('BudgetId').AsInteger);
              Try
                  ProgressBar.Min := 0;
                  if not budget.budgetdefinition.budgetnos.IsEmpty then
                      ProgressBar.Max :=budget.budgetdefinition.budgetnos.count
                  else ProgressBar.Max :=0;
                  ProgressBar.Visible := True;
                  BudgetFrom := FastFuncs.StrToInt(edtBudgetNo.Text);
                  CloseObjects;
                  if not BudgetDef.budgetnos.IsEmpty then
                  For ctr := 0 to BudgetDef.budgetnos.count-1 do begin
                      ProgressBar.StepIt;
                      Application.ProcessMessages;
                          if BudgetDef.budgetnos[ctr].BudgetNo > FastFuncs.StrToInt(Trim(edtBudgetNo.Text)) then begin
                              if not (Budgetdef.CopyBudget(form.rdbVariationOption.ItemIndex, form.rdbVariationType.ItemIndex, strToFloat(form.edtVariationAmt.Text), BudgetDef.BudgetName, BudgetDef.Description,
                                  0,BudgetDef.ID, BudgetFrom, BudgetDef.budgetnos[ctr].BudgetNo)) then begin
                                  CommonLib.MessageDlgXP_Vista('Copying Budget Periods failed' , mtWarning, [mbOK], 0);
                                  Exit;
                              end;
                              BudgetFrom :=BudgetDef.budgetnos[ctr].BudgetNo;
                          end;
                  end;
                  BudgetDef.connection.CommitTransaction;
              Finally
                  FreeandNil(Budgetdef);
                  ProgressBar.Visible := False;
              end;

              SetControlFocus(btnCopy);
              pnlVariation.Visible := False;
              Notify;
              Self.Close;
              {Close the list form if copy is done.
              Copy deletes the period records and recreates which will change the ID
              and if the list is not refreshed, the list query will give the Old IDs }
              with TBudgetGUI(GetComponentByClassName('TBudgetGUI')) do Try
                  if visible then RefreshQuery ;
             Finally
                  if not visible then Free;
              end;

          end else
            CommonLib.MessageDlgXP_Vista('Saving Budget failed.' , mtWarning, [mbOK], 0);
        end;
      end;
    finally
      FreeandNil(form);
      ProcessingCursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmBudget.btnExportClick(Sender: TObject);
var
  aFileName: string;
  ds: TDataset;
  bm: TBookmark;
  IOFile: TextFile;
  fieldList: TStringList;
  x: integer;
  line: TStringList;
  dlg: TProgressDialog;
begin
  if GetImportExportFileName(aFileName, true) then begin
    if FileExists(aFileName) then begin
      if CommonLib.MessageDlgXP_Vista('Is it ok to overwrite the existing file?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
        exit;
      if not DeleteFile(aFileNAme) then begin
        CommonLib.MessageDlgXP_Vista('Could not delete the existing file.',mtInformation,[mbOk],0);
        exit;
      end;
    end;
    fieldList := TStringList.Create;
    line := TStringList.Create;
    dlg := TProgressDialog.Create(nil);
    try
      fieldList.CommaText := 'AccountName,JobName,BudgetDate,ForDate';

      AssignFile(IOFile, aFileName);
      Rewrite(IOFile);
      try


        ds := grdBudgets.DataSource.DataSet;
        ds.DisableControls;
        try
          bm := ds.GetBookmark;
          try
            ds.First;
            //if
            for x := 0 to ds.FieldCount -1 do begin
              //if Pos(Budget.Amt1Label,ds.Fields[x].FieldName) then
              if not (SameText(ds.Fields[x].FieldName,'AllClass_Amt1') or SameText(ds.Fields[x].FieldName,'AllClass_Amt2')) then begin
                if (Pos('_Amt1',ds.Fields[x].FieldName) > 0) or (Pos('_Amt2',ds.Fields[x].FieldName) > 0) then
                  fieldList.Add(ds.Fields[x].FieldName);
              end;
            end;
            dlg.Caption := 'Exporting Data';
            dlg.Step:= 1;
            dlg.MaxValue := ds.RecordCount;
            dlg.Execute;
            WriteLn(IOFile,fieldList.CommaText);
            while not ds.Eof do begin
              line.Clear;
              for x := 0 to fieldList.Count -1 do begin
                //if line <> '' then line := line + ',';
                if SameText(fieldList[x],'BudgetDate') then begin
                  if SameText(ds.FieldByName('ForDate').AsString,'T') then
                    //line := line + '"' + FormatDateTime('yyyy-mm-dd',ds.FieldByName('BudgetDate').AsDateTime) + '"'
                    line.Add(FormatDateTime('yyyy-mm-dd',ds.FieldByName('BudgetDate').AsDateTime))
                  else
                    //line := line + '""';
                    line.Add('');
                end
//                else if SameText(fieldList[x],'ForDate') then begin
//                  if SameText(ds.FieldByName('ForDate').AsString,'T') then
//                    //line := line + '"True"'
//                    line.Add('True')
//                  else
//                    //line := line + '"False"';
//                    line.Add('False');
//                end
                else begin
//                  if ds.FieldByName(fieldList[x]) is TFloatField then
//                    line := line + ds.FieldByName(fieldList[x]).AsString
//                  else
//                    line := line + '"' + ds.FieldByName(fieldList[x]).AsString + '"';
                  line.Add(ds.FieldByName(fieldList[x]).AsString);
                end;

              end;
              WriteLn(IOFile,line.CommaText);
              dlg.StepIt;
              ds.Next;
            end;
            ds.GotoBookmark(bm);
          finally
            ds.FreeBookmark(bm);
          end;
        finally
          ds.EnableControls;
        end;
      finally
        CloseFile(IOFile);
      end;
    finally
      fieldList.Free;
      line.Free;
      dlg.Free;
    end;
  end;
end;

procedure TfmBudget.btnImportClick(Sender: TObject);
var
  aFileName: string;
  ds: TDataset;
  IOFile: TextFile;
  fieldList: TStringList;
  x: integer;
  line: TStringList;
  dlg: TProgressDialog;
  s: string;
  lineNo: integer;
  accountList: TStringList;
  qry: TERPQuery;
  BudgetDateReadOnlySave: boolean;
  LastSortId: integer;
begin
  BudgetDateReadOnlySave:=false;
  lineNo := 0;
  LastSortId := 0;
  if GetImportExportFileName(aFileName, true) then begin
    if not FileExists(aFileName) then begin
      CommonLib.MessageDlgXP_Vista('Selected file does not exist.',mtInformation,[mbOk],0);
      exit;
    end;

    fieldList := TStringList.Create;
    line := TStringList.Create;
    accountList := TStringList.Create;
    dlg := TProgressDialog.Create(nil);
    Budget.RawMode := true;
    try
      accountList.CaseSensitive := false;
      dlg.Step := 1;
      dlg.MaxValue := 100;
      dlg.Caption := 'Importing Data';
      dlg.Execute;
      ds := grdBudgets.DataSource.DataSet;
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection := TMyQuery(ds).Connection;
        qry.SQL.Add('select AccountName, SortID');
        qry.SQL.Add('from ' + Budget.TableName);
        qry.SQL.Add('where Active = "T"');
        qry.Open;
        while not qry.Eof do begin
          if qry.FieldByName('SortID').AsInteger > LastSortID then
            LastSortID := qry.FieldByName('SortID').AsInteger;
          accountList.Add(qry.FieldByName('AccountName').AsString);
          qry.Next;
        end;
      finally
        qry.Free;
      end;

      AssignFile(IOFile, aFileName);
      Reset(IOFile);
      try
        ds.DisableControls;
        try
          while not Eof(IOFile) do begin
            ReadLn(IOFile,s);
            Inc(lineNo);
            if fieldList.Count = 0 then begin
              fieldList.CommaText := s;
              for x := 0 to fieldList.Count -1 do begin
                if ds.FindField(fieldList[x]) = nil then begin
                  CommonLib.MessageDlgXP_Vista('The field ' + fieldList[x] + ' in the import file, does not exist in the budget.',mtWarning,[mbOk],0);
                  ds.Cancel;
                  exit;
                end;
              end;
            end
            else begin
              line.CommaText := s;
              if line.Count <> fieldList.Count then begin
                CommonLib.MessageDlgXP_Vista('The number of fields (' + IntToStr(line.Count) + ' for line ' + IntToStr(lineNo) + ' does not match the number of header fields in the file ' + IntToStr(fieldList.Count),mtWarning,[mbOk],0);
                ds.Cancel;
                exit;
              end;
              ds.Append;
              for x := 0 to fieldList.Count -1 do begin
                if SameText(fieldList[x],'AccountName') then begin
                  if line[x] = '' then begin
                    CommonLib.MessageDlgXP_Vista('Account Name is missing frome line ' + IntToStr(lineNo) + ' of the import file.',mtWarning,[mbOk],0);
                    ds.Cancel;
                    exit;
                  end;
                  if accountList.IndexOf(line[x]) > -1 then begin
                    CommonLib.MessageDlgXP_Vista('Account Name ('+line[x]+') has already been used in budget for line ' + IntToStr(lineNo) + ' of the import file.',mtWarning,[mbOk],0);
                    ds.Cancel;
                    exit;
                  end;
                  ds.FieldByName(fieldList[x]).AsString := line[x];
                  ds.FieldByName('AccountId').AsInteger := TAccount.IDToggle(line[x],MyConnection);
                  if ds.FieldByName('AccountId').AsInteger < 1 then begin
                    CommonLib.MessageDlgXP_Vista('Account Name is not found for line ' + IntToStr(lineNo) + ' of the import file.',mtWarning,[mbOk],0);
                    ds.Cancel;
                    exit;
                  end;

                  ds.FieldByName('AccountNumber').AsString := TAccount.AccountNumberForName(line[x], MyConnection);
                end
                else if SameText(fieldList[x],'JobName') then begin
                  if line[x] <> '' then begin
                    ds.FieldByName(fieldList[x]).AsString := line[x];
                    ds.FieldByName('JobId').AsInteger := TJob.IDToggle(line[x], MyConnection);
                  end;
                end
                else if SameText(fieldList[x],'BudgetDate') then begin
                  BudgetDateReadOnlySave := ds.FieldByName('BudgetDate').ReadOnly;
                  ds.FieldByName('BudgetDate').ReadOnly := false;
                  try
                    if line[x] <> '' then begin
                      if line[fieldList.IndexOf('ForDate')] = 'T' then
                        ds.FieldByName(fieldList[x]).AsDateTime := StrToDateTimeFmt('yyyy-mm-dd',line[x])
                      else
                        ds.FieldByName(fieldList[x]).Clear;
                    end
                    else
                      ds.FieldByName(fieldList[x]).Clear;
                  finally
                    ds.FieldByName('BudgetDate').ReadOnly := BudgetDateReadOnlySave;
                  end;
                end
                else begin
                  if line[x] <> '' then
                    ds.FieldByName(fieldList[x]).AsString := line[x];

                end;
              end;
              ds.Post;
              dlg.Value := dlg.Value + 1;
              if dlg.Value > dlg.MaxValue then
                dlg.Value := 1;
            end;
          end;

        finally
          ds.FieldByName('BudgetDate').ReadOnly := BudgetDateReadOnlySave;
          ds.EnableControls;
        end;
      finally
        CloseFile(IOFile);
      end;
    finally
      fieldList.Free;
      line.Free;
      accountList.Free;
      dlg.Free;
      Budget.RawMode := false;
    end;
  end;
end;

procedure TfmBudget.cboBudgetNameEnter(Sender: TObject);
var
    MsgOption :Integer;
begin
  inherited;
  if Budget = nil then Exit;
  if NameNotInList then begin
    NameNotInList:= False;
    cbobudgetName.Text := '';
    Exit;
  end;
    if budget.formlines.dirty = False then MsgOption :=  mrNo else
        MsgOption := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    if MsgOption = mrCancel then SetControlFocus(grdBudgets)
    else if MsgOption = mrYes then if not BudgetSaved then SetControlFocus(grdBudgets) else begin
        budget.formlines.dirty := False;
        Budget.Dirty := False;
    end;
end;

procedure TfmBudget.cboBudgetNameDropDown(Sender: TObject);
begin
  inherited;
    NameNotInList := False;
end;

procedure TfmBudget.cboBudgetNameExit(Sender: TObject);
begin
  inherited;
  NameNotInList:= False; 
end;

procedure TfmBudget.grdBudgetsColWidthChanged(Sender: TObject;
  Column: Integer);
var
  x: integer;
begin
  inherited;
  GuiPrefs.Node.DeleteByName('Grid.ColWidths');
  for x:= 0 to grdBudgets.FieldCount -1 do begin
    GuiPrefs.Node['Grid.ColWidths.' + grdBudgets.Columns[x].FieldName].AsInteger:= grdBudgets.ColWidths[x];
  end;
  GuiPrefs.SavePrefs;
end;

procedure TfmBudget.GetGridColumnWidths;
var
  x: integer;
begin
  for x:= 0 to grdBudgets.FieldCount -1 do begin
    if GuiPrefs.Node.Exists('Grid.ColWidths.' + grdBudgets.Columns[x].FieldName) then
      grdBudgets.ColWidths[x]:= GuiPrefs.Node['Grid.ColWidths.' + grdBudgets.Columns[x].FieldName].AsInteger;
  end;
end;

procedure TfmBudget.SetGridFields;
var
  i:Integer;
begin
  For i := 0 to BudgetLines_Dataset.fields.count-1 do
      if  Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'ID')  then
      else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'AccountId')  then
      else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'SortID')  then
      else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'Active')  then
      else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'JobId')  then
      else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'AccountName') then
          FieldList.Add(BudgetLines_Dataset.fields[i].FieldName+#9+'25'+#9+BudgetLines_Dataset.fields[i].displayLabel+#9#9)
      else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'AccountNumber') then begin
        if appenv.CompanyPrefs.ShowAccountNumberinBudget then
            FieldList.Add(BudgetLines_Dataset.fields[i].FieldName+#9+'10'+#9+'Account No'+#9+'T'+#9);
      end else if Sysutils.SameText(BudgetLines_Dataset.fields[i].FieldName , 'JobName') then begin
          if chkbugetforJob.Checked then
              FieldList.Add(BudgetLines_Dataset.fields[i].FieldName+#9+'20'+#9+BudgetLines_Dataset.fields[i].displayLabel+#9#9);
      end else if (not(Sysutils.SameText(Budget.formLines.Dataset.Fields[i].Fieldname, 'ALLCLASS_AMT1'))) and
          (not(Sysutils.SameText(Budget.formLines.Dataset.Fields[i].Fieldname, 'ALLCLASS_AMT2'))) then
          FieldList.Add(BudgetLines_Dataset.fields[i].FieldName+#9+'10'+#9+BudgetLines_Dataset.fields[i].displayLabel+#9#9);

  For i := 0 to BudgetLines_Dataset.fields.count-1 do
      if (Sysutils.SameText(Budget.formLines.Dataset.Fields[i].Fieldname, 'ALLCLASS_AMT1')) or
          (Sysutils.SameText(Budget.formLines.Dataset.Fields[i].Fieldname, 'ALLCLASS_AMT2')) then
          FieldList.Add(BudgetLines_Dataset.fields[i].FieldName+#9+'10'+#9+BudgetLines_Dataset.fields[i].displayLabel+#9#9);

  grdBudgets.Selected := fieldList;
  grdBudgets.applySelected;
end;

initialization
  RegisterClassOnce(TfmBudget);

  with FormFact do begin
    RegisterMe(TfmBudget, 'TBudgetGUI_*=BudgetPeriodID');
  end;
end.
