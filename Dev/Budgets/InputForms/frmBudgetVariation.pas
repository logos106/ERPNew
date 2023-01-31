{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/05  1.00.00 BJ  Initial version.
 22/12/05  1.00.01 BJ  changing the components and tab orders created few bugs - fixed
                       Budget moved to the top and is the first selection to be made
}
unit frmBudgetVariation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, Mask, wwdbedit,
  wwdbdatetimepicker, wwdblook, ExtCtrls, DNMPanel, MemDS, Wwdotdot,
  Wwdbcomb, BusObjBase, wwclearbuttongroup,
  wwradiogroup, Menus, AdvMenus, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar,
  Shader, ImgList, ProgressDialog;

type
  TfmBudgetVariation = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel5: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    QryBudgetDef: TERPQuery;
    QryBudgetDefbudgetId: TIntegerField;
    QryBudgetDefName: TWideStringField;
    QryBudgetDefDescription: TWideStringField;
    QryBudgetDefStartDAte: TDateTimeField;
    QryBudgetDefEndDate: TDateTimeField;
    QryBudgetDefIntervalPeriod: TWideStringField;
    dsQryBudgetDef: TDataSource;
    DataSource1: TDataSource;
    MyQuery1: TERPQuery;
    MyQuery1AutoId: TIntegerField;
    MyQuery1AccountID: TIntegerField;
    MyQuery1Accountname: TWideStringField;
    MyQuery1RecSelected: TWideStringField;
    MyQuery1VarAmount: TFloatField;
    MyQuery1VarType: TWideStringField;
    MyQuery1IncDec: TWideStringField;
    pnlBudget: TDNMPanel;
    pnlVariation: TDNMPanel;
    Label3: TLabel;
    rdbVariationOption: TwwRadioGroup;
    rdbVariationType: TwwRadioGroup;
    edtVariationAmt: TwwDBEdit;
    DNMPanel6: TDNMPanel;
    rdbActionOption: TwwRadioGroup;
    rdbBudgetOption: TwwRadioGroup;
    DNMPanel7: TDNMPanel;
    Label1: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cboBudget: TwwDBLookupCombo;
    edtInterval: TwwDBEdit;
    edtStartDAte: TwwDBDateTimePicker;
    edtEndDate: TwwDBDateTimePicker;
    pnlcopybudget: TDNMPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtBudgetName: TwwDBEdit;
    edtBudgetDescription: TwwDBEdit;
    dtStartDate: TwwDBDateTimePicker;
    DNMPanel8: TDNMPanel;
    Label5: TLabel;
    chkShowAccounts: TwwCheckBox;
    DNMPanel3: TDNMPanel;
    wwDBGrid1: TwwDBGrid;
    wwRadioGroup2: TwwRadioGroup;
    wwRadioGroup1: TwwRadioGroup;
    ProgressBar: TProgressBar;
    pnlPeriod: TDNMPanel;
    Label2: TLabel;
    Label8: TLabel;
    CboToPeriod: TwwDBComboBox;
    cboBudgetNoDates: TwwDBComboBox;
    edtBudgetNo: TwwDBEdit;
    edtToPeriod: TwwDBEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure rdbActionOptionEnter(Sender: TObject);
    procedure rdbBudgetOptionClick(Sender: TObject);
    procedure cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboBudgetNoDatesCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure CboToPeriodCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure rdbActionOption1Click(Sender: TObject);
    procedure edtBudgetNoEnter(Sender: TObject);
    procedure edtToPeriodEnter(Sender: TObject);
    procedure chkShowAccountsClick(Sender: TObject);
    procedure Myquery1VarAmountChange(Sender: TField);
  private
    { Private declarations }
    MyDAcDataconnection1: TMyDAcDataconnection;
    FormShowing :Boolean;
    tmpTableName :String;
    function IsValidData(fiTabOrder: integer): boolean;
    procedure DoApply;
    function ChangeBudget: boolean;
    function ChangePeriod: boolean;
    function Copybudget: boolean;
    function CopyPeriod: boolean;
    procedure showcomponents;
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,CommonLib, CommonDbLib, BusObjBudget, BusObjBudgetDef,
      AppEnvironment, DNMLib;

{$R *.dfm}
function TfmBudgetVariation.ChangeBudget: boolean;
var
  Budget: TBusObjBudgetDef;
begin
  Budget := TBusObjBudgetDef.Create(Application);
  try
    Budget.Connection := MyDAcDataconnection1;
    Budget.Load(QryBudgetDef.FieldByName('BudgetId').AsInteger);
    if chkShowAccounts.checked then begin
        Budget.SelectedAccounts := Myquery1;
        Budget.TmpTableName := tmpTableName;
    end;
    Result := Budget.ChangeBudget(rdbVariationOption.ItemIndex, rdbVariationType.ItemIndex, strValue(edtVariationAmt.Text));
  finally
    FreeAndNil(Budget);
  end;
end;

function TfmBudgetVariation.ChangePeriod: boolean;
var
  Budget: TBusObjbudget;
begin
  Budget := TBusObjbudget.Create(Application);
  try
    Budget.Connection := MyDAcDataconnection1;
    Budget.LoadSelect('BudgetID = ' + IntToStr(cboBudget.LookupTable.FieldByName('BudgetId').AsInteger) + ' and budgetNo = ' + edtBudgetNo.Text);
    if chkShowAccounts.checked then begin
        Budget.SelectedAccounts := Myquery1;
        Budget.TmpTableName := tmpTableName;
    end;
    Result := Budget.ChangePeriod(rdbVariationOption.ItemIndex, rdbVariationType.ItemIndex, strValue(edtVariationAmt.Text));
  finally
    FreeAndNil(Budget);
  end;
  
end;

function TfmBudgetVariation.Copybudget: boolean;
var
  Budget: TBusObjBudgetDef;
begin
  Budget := TBusObjBudgetDef.Create(Application);
  try
    Budget.Connection := MyDAcDataconnection1;
    Budget.Load(QryBudgetDef.FieldByName('BudgetId').AsInteger);
    if chkShowAccounts.checked then begin
        Budget.SelectedAccounts := Myquery1;
        Budget.TmpTableName := TmpTableName;
    end;
    Result := Budget.CopyBudget(rdbVariationOption.ItemIndex, rdbVariationType.ItemIndex,
      strValue(edtVariationAmt.Text), edtBudgetName.Text, edtBudgetDescription.Text, dtStartDate.Date);
  finally
    FreeAndNil(Budget);
  end;
end;

function TfmBudgetVariation.CopyPeriod: boolean;
var
  Budget: TBusObjBudgetDef;
begin
  Budget := TBusObjBudgetDef.Create(Application);
  try
    Budget.Connection := MyDAcDataconnection1;
    Budget.Load(QryBudgetDef.FieldByName('BudgetId').AsInteger);
    if chkShowAccounts.checked then begin
        Budget.SelectedAccounts := Myquery1;
        Budget.TmpTableName := tmpTableName;
    end;
    Result := Budget.CopyBudget(rdbVariationOption.ItemIndex, rdbVariationType.ItemIndex,
      strValue(edtVariationAmt.Text), edtBudgetName.Text, edtBudgetDescription.Text, dtStartDate.Date,
      QryBudgetDef.FieldByName('BudgetId').AsInteger, FastFuncs.StrToInt(edtBudgetNo.Text), FastFuncs.StrToInt(edtToPeriod.Text));
  finally
    FreeAndNil(Budget);
  end;
end;

procedure TfmBudgetVariation.DoApply;
var
  isUpdated: boolean;
begin
  if IsValidData(11) = false then Exit;
  MyDAcDataconnection1 := TMyDAcDataconnection.Create(Self);
  MyDAcDataconnection1.Connection := MyConnection;

  IsUpdated := false;
  if rdbActionOption.ItemIndex = 0 then if rdbBudgetOption.ItemIndex = 0 then isUpdated := ChangeBudget
    else if rdbBudgetOption.ItemIndex = 1 then isUpdated := ChangePeriod;
  if rdbActionOption.ItemIndex = 1 then if rdbBudgetOption.ItemIndex = 0 then isUpdated := CopyBudget
    else if rdbBudgetOption.ItemIndex = 1 then isUpdated := CopyPeriod;
  if IsUpdated then begin
    MyDAcDataconnection1.CommitTransaction;
    Self.Close;
  end else begin
    CommonLib.MessageDlgXP_Vista('Update Failed' , mtWarning, [mbOk], 0);
  end;
end;

function TfmBudgetVariation.IsValidData(fiTabOrder: integer): boolean;
begin
  Result := True;
  if FormShowing then Exit;
  Result := false;
  if fiTabOrder > 0 then if cboBudget.Text = '' then begin
       CommonLib.MessageDlgXP_Vista('Please select the Budget to be copied/Changed', mtWarning, [mbOK], 0);
      SetControlFocus(cboBudget);
      Exit;
    end;

  if fiTabOrder > 1 then if rdbActionOption.ItemIndex = -1 then begin
      CommonLib.MessageDlgXP_Vista('Please select the Change/Copy option.', mtWarning, [mbOK], 0);
      SetControlFocus(rdbActionOption);
      Exit;
    end;
  if fiTabOrder > 2 then if rdbBudgetOption.ItemIndex = -1 then begin
      CommonLib.MessageDlgXP_Vista('Please select Budget/Period option ', mtWarning, [mbOK], 0);
      SetControlFocus(rdbBudgetOption);
      Exit;
    end;

  if (fiTabOrder = 3) then if rdbBudgetOption.ItemIndex = 0 then begin
      ExitFocus(Self);
      Exit;
    end;
  if fiTabOrder in [4,5,6] then
    if (rdbBudgetOption.ItemIndex = 1) or (rdbActionOption.ItemIndex =0)  then begin
      ExitFocus(self);
      Exit;
    end;
  if fiTabOrder > 6 then begin
    if rdbActionOption.ItemIndex =1 then
    if rdbBudgetOption.ItemIndex = 0 then begin
      if edtBudgetName.Text = '' then begin
        CommonLib.MessageDlgXP_Vista('Please give the name of the new budget to be created.', mtWarning, [mbOK], 0);
        SetControlFocus(edtBudgetName);
        Exit;
      end;
      if (dtStartDate.Date = null) or (dtStartDate.Date = 0) then begin
        CommonLib.MessageDlgXP_Vista('Please give the start date of the new Budget', mtWarning, [mbOK], 0);
        SetControlFocus(dtStartDate);
        Exit;
      end;
    end;
    if rdbBudgetOption.ItemIndex = 1 then begin
      if edtBudgetNo.Text = '' then begin
        CommonLib.MessageDlgXP_Vista('Please select the Period', mtWarning, [mbOK], 0);
        SetControlFocus(cboBudgetNoDates);
        Exit;
      end;
      if rdbActionOption.ItemIndex = 1 then
        if edtToPeriod.Text = '' then begin
            CommonLib.MessageDlgXP_Vista('Please select the Period copy to', mtWarning, [mbOK], 0);
            SetControlFocus(cboToPeriod);
            Exit;
        end;
    end;
  end;

  if fiTabOrder = 11 then begin
    if rdbVariationOption.ItemIndex = -1 then begin
      CommonLib.MessageDlgXP_Vista('Please select the Variation Option', mtWarning, [mbOK], 0);
      SetControlFocus(rdbVariationOption);
      Exit;
    end;
    if rdbVariationType.ItemIndex = -1 then begin
      CommonLib.MessageDlgXP_Vista('Please select the Variation Type', mtWarning, [mbOK], 0);
      SetControlFocus(rdbVariationType);
      Exit;
    end;
    if rdbActionOption.ItemIndex =1 then
        if rdbBudgetOption.ItemIndex = 0 then
            with TERPQuery.Create(Self) do try
              Options.FlatBuffers := True;
              Connection := Self.MyConnection;
              SQL.add('Select * from tblBudgets where name = ' + QuotedStr(edtBudgetName.Text));
              Open;
              if RecordCount > 0 then begin
                CommonLib.MessageDlgXP_Vista('Budget with this name already exists', mtWarning, [mbOK], 0);
                SetControlFocus(edtBudgetName);
                Exit;
              end;
            finally
                if Active then Close;
                Free;
            end;
    if chkShowAccounts.Checked then begin
        Try
          Myquery1.filter := 'RecSelected = ''T'' ';
          Myquery1.filtered := true;
          Myquery1.first;
          Myquery1.Last;
          if Myquery1.recordcount = 0 then begin
            CommonLib.MessageDlgXP_Vista('Please select at least one account to be copied/changed' +
                        chr(13) + 'OR Deselect ''Choose Account'' which will copy/change all the accounts of the selected budget', mtWarning, [mbOK], 0);
            SetControlFocus(wwDBGrid1);
            Exit;
          end;

        finally
            Myquery1.filtered := False;
        End;
    end else begin
        if strValue(edtVariationAmt.Text) = 0 then if rdbActionOption.ItemIndex = 0 then begin
            CommonLib.MessageDlgXP_Vista('Please give the amount variation', mtWarning, [mbOK], 0);
            SetControlFocus(edtVariationAmt);
            Exit;
          end;
    end;
  end;
  Result := true;
end;

procedure TfmBudgetVariation.rdbActionOptionEnter(Sender: TObject);
begin
  inherited;
  if (fsCreating in self.FormState) or (fsShowing in self.FormState) then
    exit;
  IsValidData(TWinControl(Sender).TabOrder);
end;

procedure TfmBudgetVariation.rdbBudgetOptionClick(Sender: TObject);
begin
  inherited;
  if (fsCreating in self.FormState) or (fsShowing in self.FormState) then
    exit;
  showcomponents;
end;

procedure TfmBudgetVariation.showcomponents;
var
  comp: TComponent;
  StatusAndToolbarHeight:integer;
  selfHeight :integer;
begin
  {assign the top when opening the form}
  if Formshowing then begin
      SelfHeight := 0;
      SelfHeight := SelfHeight + DNMPanel1.height;
      SelfHeight := SelfHeight + DNMPanel7.height;
      SelfHeight := SelfHeight + DNMPanel6.height;
      SelfHeight := SelfHeight + pnlcopybudget.height;
      SelfHeight := SelfHeight + DNMPanel3.height;
      SelfHeight := SelfHeight + pnlVariation.height;
      SelfHeight := SelfHeight + DNMPanel5.height;
      SelfHeight := SelfHeight + DNMPanel8.height;
      comp := CommonLib.FindControlClass(Application.MainForm, 'TToolBar');
      StatusAndToolbarHeight := 0;
      if Assigned(comp) then
          StatusAndToolbarHeight := TToolBar(comp).Height;
      comp := CommonLib.FindControlClass(Application.MainForm, 'TAdvOfficeStatusBar');
      if Assigned(comp) then
          StatusAndToolbarHeight := StatusAndToolbarHeight + TAdvOfficeStatusBar(comp).Height;
      Self.top := System.Round((Application.MainForm.ClientHeight  - StatusAndToolbarHeight - SelfHeight) /2);
  end;
  pnlPeriod.Visible             := rdbBudgetOption.ItemIndex = 1;
  pnlcopybudget.Visible         := (rdbBudgetOption.ItemIndex = 0) and (rdbActionOption.ItemIndex =1);
  CboToPeriod.Visible           := (rdbBudgetOption.ItemIndex = 1) and (rdbActionOption.ItemIndex =1);
  Label8.Visible                := (rdbBudgetOption.ItemIndex = 1) and (rdbActionOption.ItemIndex =1);
  DnmPanel8.visible             := False;
  DNMPanel3.Visible           :=   chkShowAccounts.Checked;
  pnlVariation.visible          := not (chkShowAccounts.Checked);
  DnmPanel8.Visible             := True;
end;

procedure TfmBudgetVariation.cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  ctr: integer;
  Budget: TBusObjBudgetDef;
  MyDAcDataconnection1: TMyDacDataConnection;
begin
  if not Modified then exit;
  inherited;
  edtInterval.Datafield := 'IntervalPeriod';
  edtStartDate.Datafield:= 'StartDAte';
  edtEndDate.Datafield  := 'EndDate';
  if Modified = false then Exit;
  cboBudget.Text := LookupTable.FieldByName('Name').AsString;
  Budget := TBusObjBudgetDef.Create(Application);
  MyDAcDataconnection1 := TMyDacDataConnection.Create(Budget);
  try
    MyDAcDataconnection1.Connection := MyConnection;
    Budget.Connection := MyDAcDataconnection1;
    Budget.Load(LookupTable.FieldByName('BudgetId').AsInteger);
    if chkShowAccounts.checked then begin
        Budget.SelectedAccounts := Myquery1;
        Budget.TmpTableName := tmpTableName;
    end;
    if cboBudgetNoDates.Items.Count > 0 then cboBudgetNoDates.Items.Clear;
    if CboToPeriod.Items.Count > 0 then CboToPeriod.Items.Clear;
   if Budget.ID <> 0 then begin
      if not Budget.BudgetNos.IsEmpty then
      for ctr := 0 to Budget.BudgetNos.Count - 1 do begin
        if Budget.BudgetNos[ctr].BudgetRecExists = false then begin
          CboToPeriod.Items.add(copy(IntToStr(Budget.BudgetNos[ctr].BudgetNo)+'     ' , 1,5) +  FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Budget.BudgetNos[ctr].StartDate) + '   to   ' +
            FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Budget.BudgetNos[ctr].EndDate) + #9 + IntToStr(Budget.BudgetNos[ctr].BudgetNo));
        end else begin
          cboBudgetNoDates.Items.add(copy(IntToStr(Budget.BudgetNos[ctr].BudgetNo)+'     ',1,5) + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Budget.BudgetNos[ctr].StartDate) + '   to   ' +
            FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, Budget.BudgetNos[ctr].EndDate) + #9 + IntToStr(Budget.BudgetNos[ctr].BudgetNo));
        end;
      end;
    end;
  finally
    FreeAndNil(Budget);
  end;
end;

procedure TfmBudgetVariation.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if  (AccessLevel > 2) then
    begin
      PostMessage(Handle, WM_CLOSE, 0, 0);
      Exit;
    end;

    FormShowing := True;
     {validation is absed on the tab order, so just setting it back incase if it is changed at design time}
      DNMPanel3.TabOrder              := 10;
      edtVariationAmt.TabOrder        := 9;
      rdbVariationType.TabOrder       := 8;
      rdbVariationOption.TabOrder     := 7;
      dtStartDate.TabOrder            := 6;
      edtBudgetDescription.TabOrder   := 5;
      edtBudgetName.TabOrder         := 4;
      pnlPeriod.TabOrder              := 3;
      rdbBudgetOption.TabOrder        := 2;
      rdbActionOption.TabOrder        := 1;
      cboBudget.TabOrder              := 0;

    if QryBudgetDef.Active = false then QryBudgetDef.Open;
    SetControlFocus(cboBudget);
    showcomponents;
    FormShowing := False;
  finally
    EnableForm;
  end;   
end;

procedure TfmBudgetVariation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    (*With TERPQuery.Create(nil) do Try
        if Trim(tmpTableName) <> '' then begin
            Options.FlatBuffers := True;
            Connection := Self.MyConnection;
            SQL.add('Drop table if Exists ' + tmpTableName);
            Execute;
        end;
    finally
        if Active then Close;
        Free;
    end;*)
    DestroyUserTemporaryTable(tmpTableName);
  inherited;
  Self.Enabled := false;
  CloseQueries;
  Action := caFree;
  inherited;
end;

procedure TfmBudgetVariation.cboBudgetNoDatesCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  if cboBudgetNoDates.ItemIndex <> -1 then edtBudgetNo.Text := cboBudgetNoDates.Value;
end;

procedure TfmBudgetVariation.CboToPeriodCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  if CboToPeriod.ItemIndex <> -1 then edtToPeriod.Text := CboToPeriod.Value;
end;

procedure TfmBudgetVariation.btnSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Myquery1.Disablecontrols;
    Try
      if DNMPanel3.Visible then
          if Myquery1.State = dsEdit then
              Myquery1.Post;
      DoApply;
    Finally
      Myquery1.enableControls;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmBudgetVariation.btnCancelClick(Sender: TObject);
begin
  inherited;
  try
  if MyConnection.InTransaction then MyConnection.Rollback;
  except
    // silent exception 
  end;
  Self.Close;
end;

procedure TfmBudgetVariation.FormCreate(Sender: TObject);
begin
  inherited;
  tmpTableName:='';
  ChangeCurrencyNameinRAdioGroup(rdbVariationType);
end;

procedure TfmBudgetVariation.FormResize(Sender: TObject);
begin
  inherited;
//   rdbActionOption.Invalidate;
//   rdbBudgetOption.Invalidate;
//   rdbVariationOption.Invalidate;
//   rdbVariationType.Invalidate;
end;

procedure TfmBudgetVariation.rdbActionOption1Click(Sender: TObject);
begin
  inherited;
    showcomponents;
end;

procedure TfmBudgetVariation.edtBudgetNoEnter(Sender: TObject);
begin
  inherited;
    SetControlFocus(cboBudgetNoDates);
end;

procedure TfmBudgetVariation.edtToPeriodEnter(Sender: TObject);
begin
  inherited;
    SetControlFocus(CboToPeriod);
end;

procedure TfmBudgetVariation.chkShowAccountsClick(Sender: TObject);
var
    strSql :String;
    Qry :TERPQuery;
begin
  inherited;
    if chkShowAccounts.Checked = False then begin
        showcomponents;
        Exit;
    end;
    if not IsValidData(10) then begin
        chkShowAccounts.Checked := False;
        Exit;
    end;
    showcomponents;
    Qry := TERPQuery.Create(nil);
    With Qry do try
        Options.FlatBuffers := True;
        Connection := Self.MyConnection;
        tmpTableName := GetUserTemporaryTableName('BudgetVariation');
        SQL.add('DROP TABLE if exists ' + tmpTableName);
        Execute;
        SQL.clear;
        SQL.add('CREATE TABLE ' + tmpTableName);
        SQL.add('( AutoId INT AUTO_INCREMENT, AccountID Int , Accountname VarChar(100) ,  ');
        SQL.add('RecSelected Enum(''T'', ''F'') default ''F'' , `VarAmount` double default "0" , VarType Enum(''P'',''D'' ) default ''P'',  ');
        SQL.add('IncDec Enum(''I'',''D'') default ''I'' , ');
        SQL.add('PRIMARY KEY(AutoID), UNIQUE(AutoID)) ' );
        Execute;
        strSql := 'INSERT HIGH_PRIORITY INTO ' + tmpTableName + ' (AccountID, AccountName, RecSelected )' ;
        strSql :=  strSql + ' Select distinct tblBudgetperiodlines.AccountId , tblChartofAccounts.Accountname, "T" ' +
            ' from tblBudgetperiodlines' +
            ' inner join tblBudgetperiods  on tblBudgetperiods.budgetPeriodid = tblBudgetperiodlines.BudgetPeriodId' +
            ' inner join tblChartofAccounts on tblChartofAccounts.AccountId = tblBudgetperiodlines.AccountId' +
            ' where tblBudgetperiodlines.budgetId = ' + IntToStr(QryBudgetDef.FieldByname('BudgetID').asInteger);// + ' and tblBudgetperiods.budgetno = 1';
        if rdbBudgetOption.ItemIndex = 1 then
            if Trim(edtBudgetNo.Text) <> '' then
                StrSql := strSql + ' and tblBudgetperiods.BudgetNo = ' + edtBudgetNo.Text;
        SQL.clear;
        SQL.add(StrSql);
        Execute;
        if Myquery1.Active then Myquery1.close;
        Myquery1.SQL.clear;
        Myquery1.SQL.add('Select * from ' + tmpTableName  + ' order by accountName');
        Myquery1.Open;
    Finally
        if Active then close;
        FreeandNil(qry);
    end;
end;

procedure TfmBudgetVariation.Myquery1VarAmountChange(Sender: TField);
begin
  inherited;
  Myquery1.FieldByname('RecSelected').asString := 'T';

end;

initialization
  RegisterClassOnce(TfmBudgetVariation);
end.
