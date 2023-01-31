
unit BudVsActListForm;

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
  Wwlocate, MemDS, DBAccess, MyAccess,ERPdbComponents, DBGrids,
  wwdbdatetimepicker, ProgressDialog,  Shader, DAScript, MyScript,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBudVsActListGUI = class(TBaseListingGUI)
    cboBudget: TwwDBLookupCombo;
    Label4: TLabel;
    cboClass: TwwDBLookupCombo;
    Label5: TLabel;
    chkAllClass: TwwCheckBox;
    Label6: TLabel;
    qryBudLines: TERPQuery;
    qryBudgets: TERPQuery;
    qryClass: TERPQuery;
    qryMainAccountID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainAccounttype2: TWideStringField;
    qryMainActual: TFloatField;
    qryMainconservative: TFloatField;
    qryMainAggressive: TFloatField;
    qryMainConVarn: TFloatField;
    qryMainAggVarn: TFloatField;
    qryMainConPercent: TFloatField;
    qryMainAggPercent: TFloatField;
    procedure cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    fstablename :String;
    FCFields :String;
    fsbudgetTablename,
    fsreporttablename: string;
    procedure CreateActuals;
    Procedure CreateTranstable ;
  protected
    procedure RefreshQuery; override;
    Procedure PopulateReportTable; override;
  public
    { Public declarations }
    fiBudgetID: integer;
  end;

implementation

{$R *.dfm}

uses
  Forms, CommonDbLib,
  DNMExceptions, AppEnvironment, CommonLib, FastFuncs, MySQLConst;

procedure TBudVsActListGUI.RefreshQuery;
var
    scr: TERPScript;
    ctr                 :Integer;
    SCode               :String;
    conCaption          :String;
    AggCaption          :String;
    x_colWidth          :Integer;
    Prog: TProgressDialog;
begin
    x_colWidth:= 15;
    scr := TERPScript.Create(nil);
    Prog := TProgressDialog.Create(nil);
    try
        Prog.TimerUpdate := true;
        Prog.MaxValue := 100;
        Prog.Value := 50;
        Prog.Caption := 'Loading Data';
        Prog.Step := 1;
        Prog.Execute;
        scr.Connection:= qryMain.Connection;
        //get the budgeted amount
        scr.SQL.add('Drop table if exists ' + fsbudgetTablename + ';' );
        scr.SQL.add('create table ' + fsbudgetTablename );
        scr.SQL.Add('SELECT coa.AccountID,');
        scr.SQL.Add('SUM(bl.Conservative) as "Conservative",');
        scr.SQL.Add('SUM(bl.Aggressive) as "Aggressive",');
        scr.SQL.Add('b.Name as Budget, bl.BudgetID');
        scr.SQL.Add('FROM tblchartofaccounts as coa');
        scr.SQL.Add('LEFT JOIN tblBudgetLines as bl ON');
        scr.SQL.Add('(coa.AccountID = bl.AccountID) ');
        scr.SQL.Add('AND (bl.Date BETWEEN  '+ Quotedstr(FormatDatetime(MysqlDateFormat, dtfrom.DateTime))  + ' AND  '+ Quotedstr(FormatDatetime(MysqlDateFormat, dtto.DateTime)) +') ');
        scr.SQL.Add('LEFT JOIN tblBudgets as b ON bl.BudgetID = b.BudgetID ');
        scr.SQL.Add('WHERE ');
        if Empty(cboBudget.Text) then
             scr.SQL.Add('(isnull(bl.BudgetID ) OR bl.BudgetID = 999999 )')
        else scr.SQL.Add('(isnull(bl.BudgetID ) OR (bl.BudgetID = ' + IntToStr(qryBudgets.FieldByName('BudgetID').AsInteger) +'))' );
        if (Empty(cboClass.Text)) or (chkAllClass.Checked) then
        else    scr.SQL.Add('AND ((isnull(bl.ClassID)) OR bl.ClassID = ' + IntToStr(qryClass.FieldByName('ClassID').asInteger)+' )');
        scr.SQL.Add('GROUP BY AccountID;');

        scr.SQL.Add('DROP TABLE IF EXISTS ' + fsreporttablename+';');
        scr.SQL.Add('CREATE TABLE ' + fsreporttablename );
        scr.SQL.Add('(BudActID int(11) NOT NULL auto_increment, ');
        scr.SQL.Add('AccountID int(11), AccountName varchar(100),');
        scr.SQL.Add('ClassID int(11), `Date` Datetime, ');
        scr.SQL.Add('AccountType varchar(20), `Account type` varchar(100), ');
        scr.SQL.Add('DebitsEx Double, CreditsEx Double,');
        scr.SQL.Add('Actual Double, ');
        scr.SQL.Add('conservative Double, Aggressive  Double, ');
        scr.SQL.Add('ConVarn      Double, AggVarn     Double ,');
        scr.SQL.Add('ConPercent   Double, AggPercent  Double,');
        if FConReport.RecordCount > 0 then begin
            FCOnReport.first;
            while FConReport.Eof = False do begin
                scr.SQL.add(FCOnReportCode.asString + '_FCRate          Double,');
                for ctr := low(Amountfields) to high(Amountfields) do
                    scr.SQL.add(FCOnReportCode.asString + '_' + Amountfields[ctr] + ' Double,' );
                FCOnReport.Next;
            end;
        end;
        scr.SQL.Add('PRIMARY KEY (BudActID)); ');

        scr.SQL.Add('insert into ' + fsreporttablename);
        scr.SQL.Add('(AccountID , AccountName ,ClassID , `Date` , AccountType , `Account type` , Actual');
        if FConReport.RecordCount > 0 then begin
            FCOnReport.first;
            while FConReport.Eof = False do begin
                scr.SQL.add(',' + FCOnReportCode.asString + '_Actual' );
                FCOnReport.Next;
            end;
        end;
        scr.SQL.Add(')');
        scr.SQL.Add('SELECT AccountID ,AccountName ,ClassID ,Date , AccountType , `Account type`,');
        scr.SQL.Add('Sum(Actual) ');
        if FConReport.RecordCount > 0 then begin
            FCOnReport.first;
            while FConReport.Eof = False do begin
                scr.SQL.add(',sum(' + FCOnReportCode.asString + '_Actual)' );
                FCOnReport.Next;
            end;
        end;
        scr.SQL.Add('FROM ' + fstablename);
        scr.SQL.Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateFormat , dtfrom.datetime)) + ' and ' +
                    QuotedStr(FormatDateTime(MysqlDateFormat , Dtto.Datetime)));
        if (chkAllClass.checked) or (empty(cboClass.text)) then else
        scr.SQL.add(' AND ClassId = ' + IntToStr(qryClass.FieldByname('classId').asInteger));
        scr.SQL.Add('GROUP BY AccountID ORDER BY AccountName , `Account type`;');

        scr.SQL.Add('update ' + fsbudgetTablename + ' bt inner join ' + fsreporttablename +' tmp ');
        scr.SQL.add(' on bt.AccountId = tmp.accountId ');
        scr.SQL.add('set tmp.Conservative = bt.Conservative, tmp.Aggressive = bt.Aggressive;');
        scr.SQL.Add('update ' + fsreporttablename );
        scr.SQL.Add('set conVarn = Actual -Conservative,');
        scr.SQL.Add('AggVarn = Actual -Aggressive, ');
        scr.SQL.Add('ConPercent = abs(convarn/Actual*100), ');
        scr.SQL.Add('AggPercent = abs(AggVarn/actual*100);');

        if FConReport.RecordCount > 0 then begin
            FCOnReport.first;
            while FConReport.Eof = False do begin
                SCode :=FConReportcode.AsString;
                scr.SQL.Add('Update  ' + fsreporttablename );
                scr.SQL.Add('set ' + SCode + '_FCRate' + '  =   ');
                scr.SQL.Add('   (SELECT SellRate from tblcurrencyconversionhistory as main  ');
                scr.SQL.Add('    where date <=  ' + fsreporttablename + '.date  ');
                scr.SQL.Add('    and main.Code = ' + quotedStr(sCode)  );
                scr.SQL.Add('    and main.Date in   ');
                scr.SQL.Add('       (Select max(date) from tblcurrencyconversionhistory as sub   ');
                scr.SQL.Add('        where sub.CurrencyID = main.CurrencyID    ');
                scr.SQL.Add('        and date <=  ' + fsreporttablename + '.date )  ');
                scr.SQL.Add('union  ');
                scr.SQL.Add('SELECT SellRate  ');
                scr.SQL.Add('from tblcurrencyconversion  ');
                scr.SQL.Add('where active = ''T''  ');
                scr.SQL.Add('and tblcurrencyconversion.Code = ' + quotedStr(sCode)  );
                scr.SQL.Add('and currencyId not in   ');
                scr.SQL.Add('   (select currencyId from tblcurrencyconversionhistory    ');
                scr.SQL.Add('    where  date <=  ' + fsreporttablename + '.date)  )   ');
                scr.SQL.Add('    Where ifnull(' + SCode + '_FCRate,0) = 0;');
                scr.SQL.Add('update ' + fsreporttablename );
                scr.SQL.Add('Set ' );
                scr.SQL.Add( FConReportCode.asString +'_Aggressive = Aggressive* ' + FConReportCode.asString +'_FCRate,');
                scr.SQL.Add( FConReportCode.asString +'_Conservative = Conservative* ' + FConReportCode.asString +'_FCRate,');
                scr.SQL.Add( FConReportCode.asString +'_convarn = Convarn* ' + FConReportCode.asString +'_FCRate,');
                scr.SQL.Add( FConReportCode.asString +'_Aggvarn = Aggvarn* ' + FConReportCode.asString +'_FCRate;');
                FConReport.next;
            end;
        end;

        {  add all other accounts that don't have any amounts  }
        scr.SQL.Add('insert into ' + fsreporttablename);
        scr.SQL.Add('(AccountID , AccountName ,ClassID , `Date` , AccountType , `Account type` , Actual)');
        scr.SQL.Add('select A.AccountId, A.AccountName, NUll as ClassID, Null as `Date`, A.AccountType, AD.AccDesc as `Account type`, 0.0 as Actual');
        scr.SQL.Add('from tblChartOfAccounts A, tblacctypedesc AD');
        scr.SQL.Add('where AD.AccType = A.AccountType');
        scr.SQL.Add('and A.Active = "T"');
        scr.SQL.Add('and A.AccountID not in (select distinct AccountID from ' + fsreporttablename + ');');

        scr.Execute;
    finally
      scr.Free;;
      Prog.Free;
    end;

    inherited;
    TFloatfield(qryMain.FindField('AggPercent')).Displayformat:= '%####0.00';
    TFloatfield(qryMain.FindField('ConPercent')).Displayformat:= '%####0.00';
    FieldList := TStringList.Create;
    try
        AddGridSelectedfield('Account Type',20 , 'Account Type'  );
        AddGridSelectedfield('AccountName',30,'Account Name');
        if FConReport.RecordCount > 0 then begin
            qryMain.FieldByName('Actual').Visible:= true;
            AddGridSelectedfield('Actual',x_colWidth,Appenv.RegionalOptions.ForeignExDefault , 'Actual');
            FCOnReport.first;
            while FConReport.Eof = False do begin
                qryMain.FieldByName(FConReportCode.asString + '_Actual').Visible:= true;
                AddGridSelectedfield(FConReportCode.asString + '_Actual',x_colWidth,FConReportCode.asString , 'Actual');
                FConReport.Next;
            end;
        end else begin
          qryMain.FieldByName('Actual').Visible:= true;
          AddGridSelectedfield('Actual',x_colWidth, 'Actual');
        end;
        if not Empty(cboBudget.Text) then begin
            ConCaption := qryBudgets.FieldByName('Amount2Label').AsString;
            AggCaption := qryBudgets.FieldByName('Amount1Label').AsString;
            if ConCaption= ''  then ConCaption :='Conservative';
            if AggCaption = '' then AggCaption :='Aggressive';

            if qryBudgets.Fieldbyname('ShowAmount2').asBoolean then begin
                if FConReport.RecordCount > 0 then begin
                    qryMain.FieldByName('Aggressive').Visible:= true;
                    AddGridSelectedfield('Aggressive',x_colWidth,Appenv.RegionalOptions.ForeignExDefault , AggCaption);
                    FCOnReport.first;
                    while FConReport.Eof = False do begin
                        qryMain.FieldByName(FConReportCode.asString+ '_Aggressive').Visible:= true;
                        AddGridSelectedfield(FConReportCode.asString+ '_Aggressive',x_colWidth,FConReportCode.asString , AggCaption);
                        FConReport.Next;
                    end;
                end else begin
                  qryMain.FieldByName('Aggressive').Visible:= true;
                  AddGridSelectedfield('Aggressive',x_colWidth, AggCaption);
                end;
                if FConReport.RecordCount > 0 then begin
                    qryMain.FieldByName('aggvarn').Visible:= true;
                    AddGridSelectedfield('aggvarn',x_colWidth,Appenv.RegionalOptions.ForeignExDefault , AggCaption+' Variation');
                    FCOnReport.first;
                    while FConReport.Eof = False do begin
                        qryMain.FieldByName(FConReportCode.asString+ '_aggvarn').Visible:= true;
                        AddGridSelectedfield(FConReportCode.asString+ '_aggvarn',x_colWidth,FConReportCode.asString , AggCaption+' Variation');
                        FConReport.Next;
                    end;
                end else begin
                  qryMain.FieldByName('aggvarn').Visible:= true;
                  AddGridSelectedfield('aggvarn',x_colWidth, AggCaption+' Variation');
                end;
                qryMain.FieldByName('aggPercent').Visible:= true;
                AddGridSelectedfield('aggPercent',x_colWidth, AggCaption+'~Percentage');
            end;

            if qryBudgets.Fieldbyname('ShowAmount1').asBoolean then begin
                if FConReport.RecordCount > 0 then begin
                    qryMain.FieldByName('Conservative').Visible:= true;
                    AddGridSelectedfield('Conservative',x_colWidth,Appenv.RegionalOptions.ForeignExDefault , ConCaption);
                    FCOnReport.first;
                    while FConReport.Eof = False do begin
                        qryMain.FieldByName(FConReportCode.asString+ '_Conservative').Visible:= true;
                        AddGridSelectedfield(FConReportCode.asString+ '_Conservative',x_colWidth,FConReportCode.asString , ConCaption);
                        FConReport.Next;
                    end;
                end else begin
                  qryMain.FieldByName('Conservative').Visible:= true;
                  AddGridSelectedfield('Conservative',x_colWidth, ConCaption);
                end;
                if FConReport.RecordCount > 0 then begin
                    qryMain.FieldByName('ConVarn').Visible:= true;
                    AddGridSelectedfield('ConVarn',x_colWidth,Appenv.RegionalOptions.ForeignExDefault , ConCaption+' Variation');
                    FCOnReport.first;
                    while FConReport.Eof = False do begin
                        qryMain.FieldByName(FConReportCode.asString+ '_ConVarn').Visible:= true;
                        AddGridSelectedfield(FConReportCode.asString+ '_ConVarn',x_colWidth,FConReportCode.asString , ConCaption+' Variation');
                        FConReport.Next;
                    end;
                end else begin
                  qryMain.FieldByName('ConVarn').Visible:= true;
                  AddGridSelectedfield('ConVarn',x_colWidth, ConCaption+' Variation');
                end;
                qryMain.FieldByName('ConPercent').Visible:= true;
                AddGridSelectedfield('ConPercent',x_colWidth, ConCaption+'~Perrcentage');
            end;
        end;
        grdMain.Selected := FieldList;
        grdMain.ApplySelected;
    finally
        FreeAndNil(FieldList);
    end;
end;

procedure TBudVsActListGUI.cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then exit;
  inherited;
  if Modified = false then Exit;

  if qryMain.SQL.Strings[qryMain.SQL.Count - 1] = 'LIMIT 0' then begin
    qryMain.SQL.Delete(qryMain.SQL.Count - 1);
  end;

  RefreshQuery;
  {change the display label of amount columns based on the label specified in the budget. }
end;

procedure TBudVsActListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainConVarn.Value := qryMain.FieldByName('Actual').AsCurrency - qryMain.FieldByName('Conservative').AsCurrency;
  qryMainAggVarn.Value := qryMain.FieldByName('Actual').AsCurrency - qryMain.FieldByName('Aggressive').AsCurrency;
  qryMainConPercent.Value := DivZer(qryMainConVarn.AsCurrency, qryMain.FieldByName('Conservative').AsCurrency) * 100;
  qryMainAggPercent.Value := DivZer(qryMainAggVarn.AsCurrency, qryMain.FieldByName('Aggressive').AsCurrency) * 100;
end;

procedure TBudVsActListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then exit;
  inherited;
  RefreshQuery;
end;

procedure TBudVsActListGUI.FormCreate(Sender: TObject);
begin
  IsGridcustomisable      := false;
  CanCreatecustomReport   := False;
  ReportonForeignCurrency := True;
  fsbudgetTablename :=GetUserTemporaryTableName('budgets');
  fsreporttablename := GetUserTemporaryTableName('budgetvsActual');
  qryMain.SQL.Clear;
  qryMain.SQL.Add('select *');
  qryMain.SQL.Add('from ' + fsreporttablename);
  qryMain.SQL.Add('ORDER BY AccountType');
  inherited;
  if ErrorOccurred then Exit;

  fiBudgetID := 0;
  CreateTranstable;

end;
Procedure TBudVsActListGUI.CreateTranstable;
begin
    PopulateReportTable;
end;
procedure TBudVsActListGUI.FormShow(Sender: TObject);
begin
    fbEnableWebSearch      := true;
  if not ErrorOccurred then begin
    CreateActuals;
    qryMain.Sql.Text := ReplaceStr(qryMain.Sql.Text, 'tmp_tblBudgetActuals', fstablename);
    inherited;
    self.qryClass.Open;
    self.qryBudgets.Open;
    qryClass.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive, loPartialKey]);
    cboClass.Text := AppEnv.DefaultClass.DefaultClassName;
    if fiBudgetID <> 0 then begin
      qryBudgets.Locate('BudgetID', fiBudgetID, []);
      cboBudget.Text := qryBudgets.FieldByName('Name').AsString;
    end;
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

procedure TBudVsActListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;

  RefreshQuery;
end;
Procedure TBudVsActListGUI.PopulateReportTable;
var
  scr: TERPScript;
  Prog: TProgressDialog;
begin
    fsTableName := GetUserTemporaryTableName('budgetactuals');
    scr:= TERPScript.Create(nil);
    Prog := TProgressDialog.Create(nil);
    try
      Prog.TimerUpdate := true;
      Prog.MaxValue := 100;
      Prog.Value := 50;
      Prog.Caption := 'Loading Data';
      Prog.Step := 1;
      Prog.Execute;
      scr.Connection:= qryMain.Connection;
      scr.SQL.Add('DROP TABLE IF EXISTS ' + fstablename+';');
      scr.SQL.Add('FLUSH QUERY CACHE;');
      scr.SQL.Add('CREATE TABLE ' + fstablename );
      scr.SQL.Add('(BudActID int(11) NOT NULL auto_increment, ');
      scr.SQL.Add('AccountID int(11), AccountName varchar(100),');
      scr.SQL.Add('ClassID int(11), `Date` Datetime, ');
      scr.SQL.Add('AccountType varchar(20), `Account type` varchar(100), ');
      scr.SQL.Add('DebitsEx Double, CreditsEx Double,');
      scr.SQL.Add('Actual Double, ');
      FCFields := '';
      if FConReport.RecordCount > 0 then begin
          FCOnReport.first;
          while FConReport.Eof = False do begin
              scr.SQL.add(FCOnReportCode.asString + '_FCRate          Double,');
              scr.SQL.add(FCOnReportCode.asString + '_Actual          Double,');
              if FCFields <> '' then FCFields := FCFields + ',' ;
              FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
              FCOnReport.Next;
          end;
      end;
      scr.SQL.Add('PRIMARY KEY (BudActID), ');
      scr.SQL.Add('INDEX AccountIDIdx (AccountID),');
      scr.SQL.Add('INDEX AccountTypeIdx (AccountType));');

      scr.SQL.Add('insert into ' + fstablename);
      scr.SQL.Add('(AccountID, AccountName,  ClassID, Date, AccountType, DebitsEx, CreditsEx ');
      if FCFields <> '' then scr.SQL.add(',' + FCFields);
      scr.SQL.add(')');
      scr.SQL.Add('SELECT  AccountID, AccountName,  ClassID, Date, AccountType, ');
      scr.SQL.Add('DebitsEx, CreditsEx  ');
      if FCFields <> '' then scr.SQL.add(',' + FCFields);
      scr.SQL.Add('FROM tbltransactions;');

      scr.SQL.Add('insert into ' + fstablename);
      scr.SQL.Add('(AccountID, AccountName,  DebitsEx, CreditsEx ) ');
      scr.SQL.Add('Select coa.AccountId, coa.AccountName , 0,0  ');
      scr.SQL.Add('from tblchartofaccounts coa ');
      scr.SQL.Add('left join ' + fsTablename + ' tmp on coa.accountId = tmp.accountId ');
      scr.SQL.Add('where ifnull(tmp.accountId, 0) = 0 and coa.active = "T";');

      scr.SQL.Add('update ' + fstablename);
      scr.SQL.Add('inner join tblacctypedesc ');
      scr.SQL.Add('on tblacctypedesc.AccType = ' + fsTablename + '.AccountType ');
      scr.SQL.Add('set ' + fsTablename + '.`Account type` = tblacctypedesc.AccDesc;');

      scr.SQL.Add('update ' + fstablename);
      scr.SQL.Add('Set Actual = (DebitsEx - CreditsEx ) ');
      scr.SQL.Add('Where (AccountType = "EXP" OR AccountType = "EXEXP" ');
      scr.SQL.Add('OR AccountType = "AP" Or AccountType = "AR" or AccountType = "COGS");');

      scr.SQL.Add('update ' + fstablename);
      scr.SQL.Add('Set Actual = (CreditsEx - DebitsEx)  ');
      scr.SQL.Add('Where (AccountType <> "EXP" and AccountType <> "EXEXP" ');
      scr.SQL.Add('and AccountType <> "AP" and AccountType <> "AR" and AccountType <> "COGS");');

      if FConReport.RecordCount > 0 then begin
          FCOnReport.first;
          while FConReport.Eof = False do begin
              scr.SQL.add('update ' + fstablename + ' Set ' + FCOnReportCode.asString + '_Actual = Actual * ' + FCOnReportCode.asString + '_FCRate;' );
              FCOnReport.Next;
          end;
      end;
      Scr.SQL.text := ChangeQuery(Scr.SQL.text);
     scr.Execute;
  finally
     scr.Free;
     Prog.Free;
  end;
end;

procedure TBudVsActListGUI.CreateActuals;
begin

end;

procedure TBudVsActListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;
end;


procedure TBudVsActListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudVsActListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudVsActListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudVsActListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudVsActListGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= True;
end;

initialization
  RegisterClassOnce(TBudVsActListGUI);
end.
