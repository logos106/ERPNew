

unit JobBudVsActListForm;

{
  This list differs enough from other baselist forms to warrant an explanation.

  The purpose of this list is to compare, for each budget, the actuals and budgeted
  figures for the period provided.

  Remember:
    1. Each budget may have many accounts accociated with it.
    2. tblBudgetlines contains the budgeted amounts for each account on a
       by-day basis.

  qryMain's principle table is tmp_tblBudgetActuals.  This table, as the name suggests,
  is a temporary table created from tblTransactions in FormShow. It contains the
  actuals for all accounts.

  To access the budget numbers qryMain utilizes lookups to qryBudgetLines.

  qryBudgetLines accesses tblBudgetLines, Summing and grouping the specified Budget
  by AccountID.

}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwdblook, wwcheckbox, SelectionDialog, DNMPanel, kbmMemTable, wwDialog,
  Wwlocate, MemDS, DBAccess, MyAccess,ERPdbComponents, DBGrids, //CRGrid,
  wwdbdatetimepicker, ProgressDialog,  Shader, DAScript, MyScript,
  CustomInputBox;

type
  TJobBudgetVsActual = class(TBaseListingGUI)
    cboBudget: TwwDBLookupCombo;
    Label4: TLabel;
    cboClass: TwwDBLookupCombo;
    Label5: TLabel;
    chkAllClass: TwwCheckBox;
    Label6: TLabel;
    qryClass: TERPQuery;
    qryMainBudActID: TIntegerField;
    qryMainActual: TFloatField;
    qryMainConservative: TFloatField;
    qryMainAggressive: TFloatField;
    qryMainConservative_var: TFloatField;
    qryMainAggressive_var: TFloatField;
    qryMainConservative_varPerc: TFloatField;
    qryMainAggressive_varPerc: TFloatField;
    qryMainAccountID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainAccountType: TWideStringField;
    qryMainDebitsEx: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryBudgets: TERPQuery;
    procedure cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboClientsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    fsTableName :String;
    procedure CreateActuals;
    procedure DeleteTempActualsTable;
    //procedure SetupMemTables;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
    fiBudgetID: integer;
  end;

//var
//  BudVsActListGUI: TBudVsActListGUI;

implementation

{$R *.dfm}

uses
  Forms, CommonDbLib,
  DNMExceptions, AppEnvironment, CommonLib, FastFuncs, tcConst;//,   MAIN;

procedure TJobBudgetVsActual.RefreshQuery;

var
    strSQL :STring;
    Qry1:TERPQuery;
    Qry2:TERPQuery;
    Procedure RunSQL(const strSQL:String);
    begin
        With Qry1 do begin
            if Active then Close;
            SQL.clear;
            Sql.add(strSQL);
            Execute;
        end;
    end;
begin
    Qry1 := TERPQuery.Create(Self);
    Qry1.Options.FlatBuffers := True;
    try
        Qry1.Connection := commondbLib.GetSharedMyDacConnection;

        strSQL := 'drop TABLE if exists  ' + fsTableName + ';';
        RunSQL(strSQL);

        strSQL := 'CREATE TABLE  ' + fsTableName +
            ' (BudActID int(11) NOT NULL auto_increment, ' +
            ' Actual Double, ' +
            ' Conservative double, Aggressive Double, ' +
            ' Conservative_Var double, Aggressive_Var Double, ' +
            ' Conservative_VarPerc double, Aggressive_VarPerc Double, ' +
            ' PRIMARY KEY (BudActID)) ' +
            ' SELECT  AccountID, AccountName,  ClientID, ClientName , ' +
            ' ClassID, AccountType, Sum(DebitsEx) as DebitsEx, Sum(CreditsEx) as CreditsEx ' +
            ' FROM tbltransactions  ' +
            ' Where (tbltransactions.Date BETWEEN '+  QuotedStr(FormatDateTime('yy-mm-dd' , dtFrom.Date)) +
            ' AND ' + QuotedStr(FormatDateTime('yy-mm-dd' , dtTo.Date)) +')' ;
        strSQL := strSQL + ' group by AccountID, AccountName,  ClientID, ClientName , ' +
            ' ClassID, AccountType';
        RunSQL(ChangeQuery(strSQL));

        strSQL:= 'Select * from ' + fsTableName;
        Qry1.SQL.clear;
        Qry1.Sql.add(strSQL);
        Qry1.Open;

        if cboBudget.text <> '' then begin
            Qry2 := TERPQuery.Create(Self);
            Qry2.Options.FlatBuffers := True;
            Try
                Qry2.Connection := commondbLib.GetSharedMyDacConnection;
                strSQL := 'SELECT tblChartofAccounts.AccountName,  ' +
                    ' tblChartofAccounts.AccountType, ' +
                    ' bl.ClassId,tblChartofAccounts.AccountID,bl.jobId, tblClients.Company, ' +
                    ' SUM(bl.Conservative) as "Conservative", ' +
                    ' SUM(bl.Aggressive) as "Aggressive", ' +
                    ' b.Name as Budget, bl.BudgetID ' +
                    ' FROM  tblChartofAccounts ' +
                    ' inner JOIN tblBudgetLines as bl ON ' +
                    ' (tblChartofAccounts.AccountID = bl.AccountID)  ' +
                    ' AND (bl.Date BETWEEN '+  QuotedStr(FormatDateTime('yy-mm-dd' , dtFrom.Date)) +
                    ' AND '+ QuotedStr(FormatDateTime('yy-mm-dd' , dtTo.Date)) +')' +
                    ' inner JOIN tblBudgets as b ON bl.BudgetID = b.BudgetID ' +
                    ' Left join tblClients  on tblClients.clientId =  bl.jobId ' +
                    ' Where (bl.BudgetID = ' + IntToStr(qryBudgets.Fieldbyname('BudgetID').asInteger) + ' or isnull(bl.BudgetID ))  ' ;
                if chkAllClass.Checked =False then
                    strSQL := strSQL + '    AND (bl.ClassID =' + IntToStr(qryClass.FieldByname('ClassID').asInteger) + ' OR (isnull(bl.ClassID) )) ' ;
                strSQL := strSQL + '    GROUP BY AccountID, tblChartofAccounts.AccountName, tblChartofAccounts.AccountType, bl.ClassId, bl.jobId, tblClients.Company;';

                Qry2.SQL.clear;
                Qry2.Sql.add(strSQL);
                Qry2.Open;
                if Qry2.Recordcount > 0 then begin
                    Qry2.first;
                    while Qry2.Eof = False do begin
                        if not (Qry1.Locate('AccountID;ClassID;ClientID' ,
                            varArrayof([Qry2.FieldByname('AccountID').asInteger,Qry2.FieldByname('ClassId').asInteger,Qry2.FieldByname('JobID').asInteger]) , [])) then begin
                            Qry1.Insert;
                            Qry1.FieldByname('AccountID').asInteger     := Qry2.FieldByname('AccountID').asInteger;
                            Qry1.FieldByname('AccountName').asString    := Qry2.FieldByname('AccountName').asString;
                            Qry1.FieldByname('AccountType').AsString    := Qry2.FieldByname('AccountType').asString;
                            Qry1.FieldByname('ClientID').AsInteger      := Qry2.FieldByname('JobId').AsInteger;
                            Qry1.FieldByname('ClientName').asString     := Qry2.FieldByname('Company').asString;
                            Qry1.FieldByname('ClassID').asInteger       := Qry2.FieldByname('ClassID').asInteger;
                            Qry1.FieldByname('DebitsEx').asFloat        := 0;
                            Qry1.FieldByname('CreditsEx').asFloat       := 0;
                            Qry1.FieldByname('Conservative').asFloat    := 0;
                            Qry1.FieldByname('Aggressive').asFloat      := 0;
                        end;
                        if not(Qry1.State in [dsEdit,dsInsert]) then Qry1.Edit;
                        Qry1.FieldByname('Conservative').asFloat := Qry1.FieldByname('Conservative').asFloat + Qry2.fieldByname('Conservative').asFloat;
                        Qry1.FieldByname('Aggressive').asFloat := Qry1.FieldByname('Aggressive').asFloat + Qry2.fieldByname('Aggressive').asFloat;
                        if Qry1.State in [dsEdit,dsInsert] then Qry1.Post;
                        Qry2.Next;
                    end;
                end;
            Finally
                Qry2.Close;
                Freeandnil(Qry2);
            end;
        End;

        strSQL := 'update ' + fsTableName + '  Set Conservative = 0 where ifnull(Conservative,0) = 0;';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Aggressive = 0 where ifnull(Aggressive,0) = 0;';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Conservative = Round(Conservative,' +intToStr(CurrencyRoundPlaces)+ ') where ifnull(Conservative,0) <> 0;';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Aggressive = Round(Aggressive,' +intToStr(CurrencyRoundPlaces)+ ') where ifnull(Aggressive,0) <> 0;';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set DebitsEx = 0 where ifnull(DebitsEx,0) = 0;';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set CreditsEx = 0 where ifnull(CreditsEx,0) = 0;';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Actual = Round(DebitsEx - CreditsEx,' +intToStr(CurrencyRoundPlaces)+ ') where AccountType = "EXP" OR AccountType = "EXEXP" OR AccountType = "AP" Or AccountType = "AR" or AccountType = "COGS";';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Actual = Round(CreditsEx - DebitsEx, ' +intToStr(CurrencyRoundPlaces)+ ') where AccountType <> "EXP" and  AccountType <> "EXEXP" and AccountType <> "AP" and AccountType <> "AR" and AccountType <> "COGS";';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Conservative_Var =   Round(Actual-Conservative,' +intToStr(CurrencyRoundPlaces)+ ')';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Aggressive_Var =  Round(Actual-Aggressive, ' +intToStr(CurrencyRoundPlaces)+ ')';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Conservative_VarPerc = Round(Conservative_var/ Actual*100, ' +intToStr(CurrencyRoundPlaces)+ ') where Actual<> 0';
        RunSQL(strSQL);

        strSQL := 'update ' + fsTableName + '  Set Aggressive_VarPerc = Round(Aggressive_var/ Actual*100, ' +intToStr(CurrencyRoundPlaces)+ ') where Actual <> 0';
        RunSQL(strSQL);

    Finally
        if Qry1.Active then Qry1.Close;
        FreeandNil(Qry1);
    End;

  inherited;
      if (cboBudget.Text <> '') and (qryBudgets.Fieldbyname('ShowAmount2').asBoolean) then begin
        grdMain.Addfield('Aggressive');
        grdMain.Addfield('Aggressive_Var');
        grdMain.Addfield('Aggressive_VarPerc');
      end else begin
        grdMain.RemoveField('Aggressive');
        grdMain.RemoveField('Aggressive_Var');
        grdMain.RemoveField('Aggressive_VarPerc');
      end;

      if (cboBudget.Text <> '') and (qryBudgets.Fieldbyname('ShowAmount1').asBoolean) then begin
        grdMain.Addfield('Conservative');
        grdMain.Addfield('Conservative_Var');
        grdMain.Addfield('Conservative_VarPerc');
      end else begin
        grdMain.RemoveField('Conservative');
        grdMain.RemoveField('Conservative_Var');
        grdMain.RemoveField('Conservative_VarPerc');
      end;


  if cboBudget.Text = '' then Exit;

  grdMain.ColumnByName('Conservative').GroupName:=qryBudgets.FieldByName('Amount1Label').AsString;
  if qryBudgets.FieldByName('Amount1Label').AsString <> '' then begin
    grdMain.ColumnByName('Conservative').GroupName:=qryBudgets.FieldByName('Amount1Label').AsString;
    grdMain.ColumnByName('Conservative_Var').GroupName:=qryBudgets.FieldByName('Amount1Label').AsString;
    grdMain.ColumnByName('Conservative_VarPerc').GroupName:=qryBudgets.FieldByName('Amount1Label').AsString;
    grdMain.ColumnByName('Conservative').DisplayLabel := 'Amount';
    grdMain.ColumnByName('Conservative_Var').DisplayLabel := 'Variation';
    grdMain.ColumnByName('Conservative_VarPerc').DisplayLabel := 'Varn Percentage';
  end;

  if qryBudgets.FieldByName('Amount2Label').AsString <> '' then begin
    grdMain.ColumnByName('Aggressive').GroupName:=qryBudgets.FieldByName('Amount2Label').AsString;
    grdMain.ColumnByName('Aggressive_Var').GroupName:=qryBudgets.FieldByName('Amount2Label').AsString;
    grdMain.ColumnByName('Aggressive_VarPerc').GroupName:=qryBudgets.FieldByName('Amount2Label').AsString;
    grdMain.ColumnByName('Aggressive').DisplayLabel := 'Amount';
    grdMain.ColumnByName('Aggressive_Var').DisplayLabel := 'Variation';
    grdMain.ColumnByName('Aggressive_VarPerc').DisplayLabel := 'Varn Percentage';
  end;
end;

procedure TJobBudgetVsActual.cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then exit;
  RefreshQuery;
end;

procedure TJobBudgetVsActual.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then exit;
  RefreshQuery;
end;

procedure TJobBudgetVsActual.FormCreate(Sender: TObject);
begin
  fsTableName :=GetUserTemporaryTableName('jobbudgetactuals') ;
  qryMain.Sql.Text := ReplaceStr(qryMain.Sql.Text, 'tmp_jobbudgetactuals', fsTableName); // before inherited for SearchEngine
  inherited;
  if ErrorOccurred then Exit;
  fiBudgetID := 0;
end;

procedure TJobBudgetVsActual.FormShow(Sender: TObject);
begin
  fbEnableWebSearch      := true;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('BudActID,AccountID,ClientID,ClassID');
  
  if not ErrorOccurred then begin
    CreateActuals;
    qryMain.Sql.Text := ReplaceStr(qryMain.Sql.Text, 'tmp_tblBudgetActuals', fsTableName);
    self.qryClass.Open;
    self.qryBudgets.Open;
    qryClass.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive, loPartialKey]);
    cboClass.Text := AppEnv.DefaultClass.DefaultClassName;
    if fiBudgetID <> 0 then begin
      qryBudgets.Locate('BudgetID', fiBudgetID, []);
      cboBudget.Text := qryBudgets.FieldByName('Name').AsString;
    end;
    inherited;
  end else begin
    try
      raise ENoAccess.Create('You don''t have access to Budget Vs Actual Report!');
    except
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
    end;
  end;
end;

procedure TJobBudgetVsActual.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;

  RefreshQuery;
end;

procedure TJobBudgetVsActual.CreateActuals;
begin

end;

procedure TJobBudgetVsActual.FormDestroy(Sender: TObject);
begin
  DeleteTempActualsTable;
  inherited;
end;

procedure TJobBudgetVsActual.DeleteTempActualsTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTemporaryTableName('budgetactuals') + ';');
    qryTemp.Execute;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

procedure TJobBudgetVsActual.cboClientsCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then exit;
  RefreshQuery;
end;

procedure TJobBudgetVsActual.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TJobBudgetVsActual.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TJobBudgetVsActual.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TJobBudgetVsActual.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TJobBudgetVsActual);
end.
