unit TrialBalanceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,
  AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwdblook, wwcheckbox, wwDialog, Wwlocate, SelectionDialog,
  DNMPanel, MemDS, DBAccess, MyAccess, ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
  kbmMemTable, Shader, BaseInputForm,
  Graphics, EditJust, forms, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg, TrialBalanceSQL, IntegerListObj;

type
  TTrialBalanceGUI = class(TBaseListingGUI)
    qryMainAccountName: TWideStringField;
    qryMainAccount: TWideStringField;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClassQry: TERPQuery;
    qryMainTransID: TIntegerField;
    qryMainAccountNumber: TWideStringField;
    chkUseDateRange: TCheckBox;
    qryMainAccountNameOnly: TWideStringField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsEx: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainDebitsInc: TFloatField;
    btnDeptSelect: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    chkShowallOtehr: TCheckBox;
    QryFooterSumm: TERPQuery;
    dsFooterSumm: TDataSource;
    grdFooterSumm: TwwDBGrid;
    wwIButton1: TwwIButton;
    splitterFooterSumm: TSplitter;
    QryFooterSummClassname: TWideStringField;
    QryFooterSummCreditEx: TFloatField;
    QryFooterSummDebitEx: TFloatField;
    QryFooterSummCreditinc: TFloatField;
    QryFooterSummDebitinc: TFloatField;
    QryFooterSummDiffEx: TFloatField;
    QryFooterSummDiffinc: TFloatField;
    pnlshowFooterSumm: TDNMPanel;
    chkhidediff: TCheckBox;
    pnldiff: TDNMPanel;
    lblbalance: TLabel;
    edtbalanceinc: TEdit;
    Label2: TLabel;
    edtbalanceEx: TEdit;
    btnnext: TDNMSpeedButton;
    btnPrevious: TDNMSpeedButton;
    btnTransJournal: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); Override;
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure chkUseDateRangeClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkIncludehistoryClick(Sender: TObject);
    procedure btnDeptSelectClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure chkShowallOtehrClick(Sender: TObject);
    procedure chkhidediffClick(Sender: TObject);
    procedure grdFooterSummCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure QryFooterSummAfterOpen(DataSet: TDataSet);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnnextClick(Sender: TObject);
    procedure btnTransJournalClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);

  protected
    procedure RefreshQuery; override;

    function GetReportTypeID: integer; override;
    Procedure PopulateReportTable; override;
    Procedure AssignKeyId(Popupform: TBaseInputGUI); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  private
    // fsTableName         : String;
//    fcfields: String;
    SelectedDepartmentIds: TIntegerList;
    DepartmentFieldNames: TStringList;
    TBSQLObj: TTrialBalanceReport;
//    Procedure CreateTemptable;
//    function yearstart: TDatetime;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure DisplayOrHideDepartmentFields;
    procedure RemoveAmountFields;
//    Function AllClassIds(Qry: TERPQuery): String;
    function IsAllOtherClassField(AFieldName: String): Boolean;
    procedure intTransactionList(Sender: TObject);
    procedure AdjustDateRangeGUI;
  Protected
    procedure RefreshTotals; Override;
    procedure LoadFooterValues(amountTotals: array of Double); Override;
  public
  end;

implementation

uses FastFuncs, TrialBalTransListForm, Commonlib, Systemlib,
  DateUtils, AppEnvironment, CommonDbLib, DNMLib, MySQLConst,
  busobjStockMovement, tcConst, frmPayDeptSelectionGUI, Types, StrUtils,
  GridFieldsObj, tcDataUtils, LogLib, DbSharedObjectsObj, frmMessageWithList,
  frmMessageBase, math, TransactionListForm, CommonFormLib,
  TransactionExpressList;

const
  CreditsEx = 'sum(IF ( CreditsEx -DebitsEx  >0.00 ,  CreditsEx-DebitsEx  ,0.00))';
  DebitsEx = 'sum(IF ( CreditsEx -DebitsEx  <0.00 ,  DebitsEx-CreditsEx  ,0.00)) ';
  CreditsInc = 'sum(IF ( CreditsInc-DebitsInc >0.00 ,  CreditsInc-DebitsInc,0.00)) ';
  DebitsInc = 'sum(IF ( CreditsInc-DebitsInc <0.00 ,  DebitsInc-CreditsInc,0.00)) ';

{$R *.dfm}
  { TTrialBalanceGUI }

procedure TTrialBalanceGUI.ReadGuipref;
begin
  dtFrom.Date := 0;
  if GuiPrefs.Node.Exists('General') then begin
    dtto.Date := strTodate(GuiPrefs.Node['General.DateTo'].AsString);
    chkUseDateRange.checked := StrToBoolean(GuiPrefs.Node['General.useDate'].AsString);
    fbDateRangeSupplied := true;
    AdjustDateRangeGUI;
  end
  else begin
    dtto.Date := Date + appenv.Employee.ListDaysFuture;
  end;
end;

procedure TTrialBalanceGUI.ReadnApplyGuiPrefExtra;
begin
  if GuiPrefs.Node.Exists('Options.chkShowallOtehr') then
    chkShowallOtehr.checked := GuiPrefs.Node['Options.chkShowallOtehr'].asBoolean;
  if GuiPrefs.Node.Exists('Options.chkhidediff') then
    chkhidediff.checked := GuiPrefs.Node['Options.chkhidediff'].asBoolean
  else
    chkhidediff.checked := False;
  grdFooterSumm.Width := GuiPrefs.Node['Options.grdFooterSumm'].asInteger;
end;

procedure TTrialBalanceGUI.RefreshQuery;
begin
  DoShowProgressbar(2, WAITMSG);
  try
    DoStepProgressbar();
    PopulateReportTable;
    RemoveAmountFields;
    DoStepProgressbar();
    inherited;
    DisplayOrHideDepartmentFields;
  finally
    DoHideProgressbar;
  end;
end;

procedure TTrialBalanceGUI.RefreshTotals;
begin
  inherited;
  (* edtbalanceEx.text := floattostrf(Qrymain.fieldbyname('CreditsEx').asfloat - Qrymain.fieldbyname('DebitsEx').asfloat , ffcurrency , 15,2);
    edtbalanceinc.text := floattostrf(Qrymain.fieldbyname('Creditsinc').asfloat - Qrymain.fieldbyname('Debitsinc').asfloat , ffcurrency , 15,2); *)

  edtbalanceEx.text := floattostrf(FooterValue('CreditsEx') - FooterValue('DebitsEx'),
    ffcurrency, 15, 2);
  edtbalanceinc.text := floattostrf(FooterValue('Creditsinc') - FooterValue('Debitsinc'),
    ffcurrency, 15, 2);

end;

Procedure TTrialBalanceGUI.LoadFooterValues(amountTotals: array of Double);
var
  x: integer;
  fcex, fcinc, fdex, fdinc, diffexsum, diffincsum: Double;

  Function FooterValueFromAmttotals(Const fieldname: String): Double;
  var
    ctr: integer;
  begin
    result := 0;
    if length(AmountFields) > 0 then
      for ctr := low(AmountFields) to high(AmountFields) do begin
        if sametext(AmountFields[ctr], fieldname) then begin
          result := amountTotals[ctr];
          exit;
        end;
      end;
  end;

begin
  Closedb(QryFooterSumm);
  try
    QryFooterSumm.sql.clear;
    diffexsum := 0;
    diffincsum := 0;

    fcex := FooterValueFromAmttotals('CreditsEx');
    fdex := FooterValueFromAmttotals('DebitsEx');

    fcinc := FooterValueFromAmttotals('CreditsInc');
    fdinc := FooterValueFromAmttotals('DebitsInc');
    QryFooterSumm.sql.Add('Select "All Classes" as Classname , ' + 'convert(' + Floattostr(fcex) +
      ', DECIMAL) as CreditEx, ' + 'convert(' + Floattostr(fdex) + ', DECIMAL) as DebitEx, ' +
      'convert(' + Floattostr(fcinc) + ', DECIMAL) as Creditinc, ' + 'convert(' + Floattostr(fdinc)
      + ', DECIMAL) as Debitinc, ' + 'convert(' + Floattostr((fcex - fdex)) +
      ', DECIMAL) as DiffEx, ' + 'convert(' + Floattostr((fcinc - fdinc)) +
      ', DECIMAL) as Diffinc ');

    diffexsum := fcex - fdex;
    diffincsum := fcinc - fdinc;
    diffexsum := 0;
    diffincsum := 0;

    if (not chkAllClass.checked) and (SelectedDepartmentIds.Count > 0) then begin
      for x := 0 to SelectedDepartmentIds.Count - 1 do begin
        fcex := FooterValueFromAmttotals(IntToStr(SelectedDepartmentIds[x]) + '_CreditsEx');
        fdex := FooterValueFromAmttotals(IntToStr(SelectedDepartmentIds[x]) + '_DebitsEx');

        fcinc := FooterValueFromAmttotals(IntToStr(SelectedDepartmentIds[x]) + '_CreditsInc');
        fdinc := FooterValueFromAmttotals(IntToStr(SelectedDepartmentIds[x]) + '_DebitsInc');

        QryFooterSumm.sql.Add('union Select ' +
          quotedstr(GetClassName(SelectedDepartmentIds[x])) + ' as Classname , ' +
          Floattostr(fcex) + ' as CreditEx, ' + Floattostr(fdex) + ' as DebitEx, ' +
          Floattostr(fcinc) + ' as Creditinc, ' + Floattostr(fdinc) + ' as Debitinc, ' +
          Floattostr((fcex - fdex)) + ' as DiffEx, ' + Floattostr((fcinc - fdinc)) +
          ' as Diffinc ');
        diffexsum := diffexsum + (fcex - fdex);
        diffincsum := diffincsum + (fcinc - fdinc);
        if (fcex - fdex <> 0) or (fcinc - fdinc <> 0) then
      end;
    end;
    if Qrymain.findfield(trim(inttostr(IDForallOther)) + '_creditsEx') <> nil then begin
      fcex := FooterValueFromAmttotals(inttostr(IDForallOther) + '_CreditsEx');
      fdex := FooterValueFromAmttotals(inttostr(IDForallOther) + '_DebitsEx');

      fcinc := FooterValueFromAmttotals(inttostr(IDForallOther) + '_CreditsInc');
      fdinc := FooterValueFromAmttotals(inttostr(IDForallOther) + '_DebitsInc');

      QryFooterSumm.sql.Add('union Select ' + quotedstr(GetClassName(IDForallOther)) +
        ' as Classname , ' + Floattostr(fcex) + ' as CreditEx, ' + Floattostr(fdex) +
        ' as DebitEx, ' + Floattostr(fcinc) + ' as Creditinc, ' + Floattostr(fdinc) +
        ' as Debitinc, ' + Floattostr(abs(fcex - fdex)) + ' as DiffEx, ' +
        Floattostr(abs(fcinc - fdinc)) + ' as Diffinc ');

      QryFooterSumm.sql.Add('union Select concat(C.classname ,"(" , C.active , ")") , ' +
        'null  as CreditsEx, ' + 'null  as DebitsEx, ' + 'null  as CreditsInc, ' +
        'null  as Debitsinc, null , null ' + ' from tblclass C ' + ' where C.classId not in (' +
        self.SelectedDepartmentIds.CommaText + ')');

      diffexsum := diffexsum + (fcex - fdex);
      diffincsum := diffincsum + (fcinc - fdinc);
      if (fcex - fdex <> 0) or (fcinc - fdinc <> 0) then
    end;
  finally
    Opendb(QryFooterSumm);
  end;
  grdFooterSumm.columnByname('DiffEx').FooterValue := floattostrf(diffexsum, ffcurrency, 15,
    CurrencyRoundPlaces);
  grdFooterSumm.columnByname('DiffInc').FooterValue := floattostrf(diffincsum, ffcurrency, 15,
    CurrencyRoundPlaces);

end;

procedure TTrialBalanceGUI.RemoveAmountFields;
var
  sl: TStringList;
  x: integer;
begin
  sl := TStringList.Create;
  try
    for x := Low(AmountFields) to High(AmountFields) do begin
      if (Pos('_CreditsEx', AmountFields[x]) > 0) or (Pos('_CreditsInc', AmountFields[x]) > 0) or
        (Pos('_DebitsEx', AmountFields[x]) > 0) or (Pos('_DebitsInc', AmountFields[x]) > 0) then
        sl.Add(AmountFields[x]);
    end;
    for x := 0 to sl.Count - 1 do begin
      RemoveAmountField(sl[x]);
    end;
  finally
    sl.Free;
  end;
end;

procedure TTrialBalanceGUI.FormCreate(Sender: TObject);
begin
  btnPrevious.visible := devmode;
  btnnext.visible := devmode;
  btnTransJournal.visible := devmode;
  pnldiff.visible := devmode;
  pnlshowFooterSumm.visible := true;
  fbIncludehistory := true;
//  CreateTemptable;
  TBSQLObj := TTrialBalanceReport.Create;
  TBSQLObj.APIMode := False;
  TBSQLObj.ReportClassName := self.ClassName;
  Qrymain.sql.text := StringReplace(Qrymain.sql.text, 'tmp_TB', TBSQLObj.TempTableName, [rfIgnoreCase]);
  inherited;
  SelectedDepartmentIds := TIntegerList.Create;
  DepartmentFieldNames := TStringList.Create;
  TBSQLObj.DepartmentFieldNames := DepartmentFieldNames;
  StringListForSQL := TStringList.Create;
  TBSQLObj.StringListForSQL := StringListForSQL;
  showFCFooters := true;
  if not ErrorOccurred then begin
    cboClassQry.Connection := Qrymain.Connection;
  end;
  ShowChartViewOnPopup := true;
  grdFooterSumm.TitleColor := self.Color;
  grdFooterSumm.FooterColor := self.Color;

end;

Procedure TTrialBalanceGUI.PopulateReportTable;
var
  msg: string;
// SQLList :TStringList;
// ctr,i  :Integer;
// qry: TERPQuery;
// x: integer;
// s: string;
// strSQL:String;
// Procedure ReportHeader;
// begin
// StringListForSQL.Clear;
// StringListForSQL.Add('{ReportHeader}SELECT');
// StringListForSQL.Add('CO.CompanyName,');
// StringListForSQL.Add('CO.Address,');
// StringListForSQL.Add('CO.Address2,');
// StringListForSQL.Add('CO.City,');
// StringListForSQL.Add('CO.State,');
// StringListForSQL.Add('CO.Postcode,');
// StringListForSQL.Add('Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,');
// StringListForSQL.Add('Concat("Fax ",CO.FaxNumber) AS FaxNumber,');
// StringListForSQL.Add('Concat("ABN " , CO.ABN) as ABN ,');
// if not chkAllClass.checked then
// StringListForSQL.Add('"Selected" as ClassType,')
// else StringListForSQL.Add('"All" as ClassType,');
// StringListForSQL.Add('Concat("As of : " ,' +  QuotedStr(FormatDateTime('dddd dd-mmmm-YYYY',FilterDateTo)) +   ') as  AsofDate');
// StringListForSQL.Add('FROM tblCompanyInformation AS CO;');
// StringListForSQL.Add('~|||~{RepData}');
// end;

begin
  // FCFields := '';
  // ReportHeader;
  // SQLList := TStringList.Create;
  // qry := TERPQuery.Create(nil);
  // try
  //
  // SQLList.add(CreateUserTemporaryTableSQL(fsTablename ,'tmp_TrialBalance'));
  // qry.Connection := qryMain.Connection;
  // if FConReport.RecordCount > 0 then begin
  // FCOnReport.first;
  // while FConReport.Eof = False do begin
  // SQLList.add('Alter table ' + fsTablename + ' Add column  `' + FCOnReportCode.asString + '_FCRate` Double,');
  // for ctr := low(Amountfields) to high(Amountfields) do begin
  // if ctr > 0 then SQLList.add(',');
  // SQLList.add('Add column  `' + FCOnReportCode.asString + '_' + amountfields[ctr] + '` Double' );
  // end;
  // SQLList.add(';');
  // if FCFields <> '' then FCFields := FCFields + ',' ;
  // FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
  // FCOnReport.Next;
  // end;
  // end;
  // DepartmentFieldNames.Clear;
  // if (not chkAllClass.Checked) and (SelectedDepartments.Count > 0) then begin
  // qry.SQL.Text := 'select ClassName, ClassID from tblclass where ClassId in (' + self.SelectedDepartments.CommaText + ')';
  // qry.Open;
  // while not qry.Eof do begin
  // SQLList.add('Alter table ' + fsTablename + ' Add column `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsEx` Double,');
  // SQLList.add(                               ' Add column `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsEx` Double,');
  // SQLList.add(                               ' Add column `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsInc` Double,');
  // SQLList.add(                               ' Add column `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsInc` Double;');
  // DepartmentFieldNames.Add(Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsEx');
  // DepartmentFieldNames.Add(Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsEx');
  // DepartmentFieldNames.Add(Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsInc');
  // DepartmentFieldNames.Add(Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsInc');
  // qry.Next;
  // end;
  // if chkShowallOtehr.checked then begin
  // SQLList.add('Alter table ' + fsTablename + ' Add column `' + Inttostr(IDForallOther) + '_CreditsEx` Double,');
  // SQLList.add(                               ' Add column `' + Inttostr(IDForallOther) + '_DebitsEx` Double,');
  // SQLList.add(                               ' Add column `' + Inttostr(IDForallOther) + '_CreditsInc` Double,');
  // SQLList.add(                               ' Add column `' + Inttostr(IDForallOther) + '_DebitsInc` Double;');
  // DepartmentFieldNames.Add(Inttostr(IDForallOther) + '_CreditsEx');
  // DepartmentFieldNames.Add(Inttostr(IDForallOther) + '_DebitsEx');
  // DepartmentFieldNames.Add(Inttostr(IDForallOther) + '_CreditsInc');
  // DepartmentFieldNames.Add(Inttostr(IDForallOther) + '_DebitsInc');
  // end;
  // end;
  //
  // SQLList.Add('/*');
  // if chkUseDateRange.Checked then begin
  // SQLList.Add('Date Range Selected');
  // SQLList.Add('From date '+ FormatDateTime(FormatSettings.ShortDateFormat , FilterDateFrom));
  // SQLList.Add('To date '+ FormatDateTime(FormatSettings.ShortDateFormat , FilterDateTo));
  // end else begin
  // SQLList.Add('Date Range NOT Selected');
  // SQLList.Add('To date '+ FormatDateTime(FormatSettings.ShortDateFormat , FilterDateTo));
  // end;
  // SQLList.Add('Year Start '+ FormatDateTime(FormatSettings.ShortDateFormat , Yearstart));
  // SQLList.Add('*/');
  // SQLList.Add('truncate ' + fsTablename +';');
  // SQLList.add('insert into ' + fsTablename );
  // SQLList.add('(AccountName, AccountNameOnly , AccountNumber , CreditsEx , DebitsEx , CreditsInc , DebitsInc ,');
  // if (not chkAllClass.Checked) and (SelectedDepartments.Count > 0) then
  // SQLList.add(DepartmentFieldNames.CommaText + ',');
  // SQLList.add('TransID , SortID , SortOrder , Account');
  // if FcFields <> '' then SQLList.add(', ' + FCFields);
  // SQLList.add(') Select AccountName, AccountNameOnly , AccountNumber , Sum(CreditsEx) , sum(DebitsEx) , Sum(CreditsInc) , sum(DebitsInc) ,');
  // if (not chkAllClass.Checked) and (SelectedDepartments.Count > 0) then begin
  // s:= '';
  // for x := 0 to DepartmentFieldNames.Count -1 do
  // s:= s + ' SUM(' + DepartmentFieldNames[x] + '),';
  // SQLList.add(s);
  // end;
  // SQLList.add('TransID , SortID , SortOrder , Account');
  // if FcFields <> '' then SQLList.add(', ' + FCFields);
  // SQLList.add(' from (');
  //
  // for i := 1 to 2 do begin
  // if ( i = 1) or (IncludedataPriorToClosingDate) then begin
  // {--------------- : 1}
  // strSQL:= '';
  // strSQL := strSQL +' SELECT';
  // strSQL := strSQL +' SUBSTRING(If((char_length(AccountGroup)>0),Concat(AccountGroup," - ",Trans.AccountName),Trans.AccountName),1,255) as AccountName,';
  // strSQL := strSQL +'Trans.AccountName as AccountNameOnly,';
  // strSQL := strSQL +'tblchartofaccounts.AccountNumber as AccountNumber,';
  // strSQL := strSQL +CreditsEx + ' as CreditsEx ,';
  // strSQL := strSQL +DebitsEx  + ' as DebitsEx  ,';
  // strSQL := strSQL +CreditsInc+ ' as CreditsInc,';
  // strSQL := strSQL +DebitsInc + ' as DebitsInc ,';
  //
  // if (not chkAllClass.Checked) and (SelectedDepartments.Count > 0) then begin
  // qry.First;
  // while not qry.Eof do begin
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) >0.00)    ,  (Sum(CreditsEx -DebitsEx))  ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsEx`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) <0.00 )   ,  (Sum(DebitsEx  -CreditsEx)) ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsEx`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) >0.00 ) ,  (Sum(CreditsInc-DebitsInc)) ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsInc`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) <0.00 ) ,  (Sum(DebitsInc -CreditsInc)),0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsInc`,';
  // qry.Next;
  // end;
  // if chkShowallOtehr.checked then begin
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsEx  +',0)  as `' + Inttostr(IDForallOther) + '_CreditsEx` ,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsEx   +',0)  as `' + Inttostr(IDForallOther) + '_DebitsEx`  ,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsInc +',0)  as `' + Inttostr(IDForallOther) + '_CreditsInc`,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsInc  +',0)  as `' + Inttostr(IDForallOther) + '_DebitsInc` ,';
  // end;
  // end;
  // strSQL := strSQL +'TransID as TransId,';
  // strSQL := strSQL +'0 as SortID,';
  // strSQL := strSQL +'SortOrder as SortOrder,';
  // strSQL := strSQL +'Trans.AccountName as Account ';
  // if FcFields <> '' then strSQL := strSQL +', ' + FCFields;
  // if i = 1 then strSQL := strSQL +' FROM tbltransactions as Trans' else strSQL := strSQL +' FROM tbltransactionsummarydetails as Trans';
  // strSQL := strSQL +' INNER JOIN tblchartofaccounts Using(AccountID)';
  // strSQL := strSQL +' INNER JOIN tblacctypedesc ON tblacctypedesc.AccType=Trans.AccountType';
  // strSQL := strSQL +' Where  NOT(Trans.AccountType = "EXEXP" OR Trans.AccountType = "EXINC" OR Trans.AccountType = "EXP" OR Trans.AccountType = "INC" OR Trans.AccountType = "COGS")';
  // if chkUseDateRange.Checked then
  // strSQL := strSQL +' AND Date Between  ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo))
  // else strSQL := strSQL +' AND Date <=  ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo));
  // if (i=1) and (IncludedataPriorToClosingDate)  then strSQL := strSQL +' AND Trans.Type <> "Closing Date Summary" AND Trans.Seqno <100  ';
  // strSQL := strSQL +' Group By Trans.AccountName';
  // if not chkAllClass.Checked then strSQL := strSQL +',ClassID';
  // SQLList.add(iif(i = 2, ' UNION ALL ' , '') + strSQL);
  // {--------------- : 2}
  // if (chkUseDateRange.Checked) and (FilterDateTo < yearstart) then
  // {this section not applicable if the todate selected is less than the financial year start}
  // else begin
  // strSQL:=  '';
  // strSQL := strSQL +' UNION ALL';
  // strSQL := strSQL +' SELECT';
  // strSQL := strSQL +' SUBSTRING(If((char_length(AccountGroup)>0),Concat(AccountGroup," - ",Trans.AccountName),Trans.AccountName),1,255) as AccountName,';
  // strSQL := strSQL +'Trans.AccountName as AccountNameOnly  ,';
  // strSQL := strSQL +'tblchartofaccounts.AccountNumber as AccountNumber  ,';
  // strSQL := strSQL +CreditsEx + ' as CreditsEx ,';
  // strSQL := strSQL +DebitsEx  + ' as DebitsEx  ,';
  // strSQL := strSQL +CreditsInc+ ' as CreditsInc,';
  // strSQL := strSQL +DebitsInc + ' as DebitsInc ,';
  //
  // if (not chkAllClass.Checked) and (SelectedDepartments.Count > 0) then begin
  // qry.First;
  // while not qry.Eof do begin
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) >0.00)    ,  (Sum(CreditsEx -DebitsEx))  ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsEx`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) <0.00 )   ,  (Sum(DebitsEx  -CreditsEx)) ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsEx`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) >0.00 ) ,  (Sum(CreditsInc-DebitsInc)) ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsInc`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) <0.00 ) ,  (Sum(DebitsInc -CreditsInc)),0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsInc`,';
  // qry.Next;
  // end;
  // if chkShowallOtehr.checked then begin
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsEx  +',0)  as `' + Inttostr(IDForallOther) + '_CreditsEx` ,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsEx   +',0)  as `' + Inttostr(IDForallOther) + '_DebitsEx`  ,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsInc +',0)  as `' + Inttostr(IDForallOther) + '_CreditsInc`,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsInc  +',0)  as `' + Inttostr(IDForallOther) + '_DebitsInc` ,';
  // end;
  // end;
  // strSQL := strSQL +'TransID as TransID  ,';
  // strSQL := strSQL +'0 as SortID  ,';
  // strSQL := strSQL +'SortOrder as SortOrder  ,';
  // strSQL := strSQL +'Trans.AccountName as Account';
  // if FcFields <> '' then strSQL := strSQL +', ' + FCFields;
  // if i = 1 then strSQL := strSQL +' FROM tbltransactions as Trans' else strSQL := strSQL +' FROM tbltransactionsummarydetails as Trans';
  // strSQL := strSQL +' INNER JOIN tblchartofaccounts Using(AccountID)';
  // strSQL := strSQL +' INNER JOIN tblacctypedesc ON tblacctypedesc.AccType=Trans.AccountType';
  // strSQL := strSQL +' WHERE (Trans.AccountType = "EXEXP" OR Trans.AccountType = "EXINC" OR Trans.AccountType = "EXP" OR Trans.AccountType = "INC" OR Trans.AccountType = "COGS")';
  //
  // if chkUseDateRange.Checked then begin
  // if FilterDateFrom < yearstart then
  // strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , yearstart     )) +' AND Date <=' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo))
  // else   strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)) +' AND Date <=' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo));
  // end else strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , yearstart     )) +' AND Date <=' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo));
  // //strSQL := strSQL +' AND Date <=  ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo  )) +' AND Date >=' + Quotedstr(formatDatetime(MysqlDateFormat , yearstart));
  //
  // if (i=1) and (IncludedataPriorToClosingDate)  then strSQL := strSQL +' AND Trans.Type <> "Closing Date Summary" AND Trans.Seqno <100  ';
  // strSQL := strSQL +' Group By Trans.AccountName';
  // if not chkAllClass.Checked then
  // strSQL := strSQL +',ClassID';
  // SQLList.add(strSQL);
  // end;
  // {--------------- : 3}
  // if (chkUseDateRange.Checked) and (FilterDateFrom > yearstart) then
  // {this section not applicable if the from date selected is > finanacial year start}
  // else begin
  // strSQL:= '';
  // strSQL := strSQL +' UNION ALL';
  // strSQL := strSQL +' SELECT';
  // strSQL := strSQL +' "Retained Earnings" as AccountName,';
  // strSQL := strSQL +'"Retained Earnings" as AccountNameOnly  ,';
  // strSQL := strSQL +'"" as AccountNumber  ,';
  // strSQL := strSQL +CreditsEx + ' as CreditsEx ,';
  // strSQL := strSQL +DebitsEx  + ' as DebitsEx  ,';
  // strSQL := strSQL +CreditsInc+ ' as CreditsInc,';
  // strSQL := strSQL +DebitsInc + ' as DebitsInc ,';
  //
  // if (not chkAllClass.Checked) and (SelectedDepartments.Count > 0) then begin
  // qry.First;
  // while not qry.Eof do begin
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) >0.00)    ,  (Sum(CreditsEx -DebitsEx))  ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsEx`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) <0.00 )   ,  (Sum(DebitsEx  -CreditsEx)) ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsEx`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) >0.00 ) ,  (Sum(CreditsInc-DebitsInc)) ,0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_CreditsInc`,';
  // strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) <0.00 ) ,  (Sum(DebitsInc -CreditsInc)),0.00),0.00) as `' + Inttostr(qry.FieldByName('ClassID').asInteger) + '_DebitsInc`,';
  // qry.Next;
  // end;
  // if chkShowallOtehr.checked then begin
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsEx  +',0)  as `' + Inttostr(IDForallOther) + '_CreditsEx` ,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsEx   +',0)  as `' + Inttostr(IDForallOther) + '_DebitsEx`  ,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsInc +',0)  as `' + Inttostr(IDForallOther) + '_CreditsInc`,';
  // strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsInc  +',0)  as `' + Inttostr(IDForallOther) + '_DebitsInc` ,';
  // end;
  // end;
  // strSQL := strSQL +'TransID as TransID  ,';
  // strSQL := strSQL +'0 as SortID,';
  // strSQL := strSQL +'SortOrder as SortOrder  ,';
  // strSQL := strSQL +'"Retained Earnings" as Account';
  // if FcFields <> '' then strSQL := strSQL +', ' + FCFields;
  // if i = 1 then strSQL := strSQL +' FROM tbltransactions as Trans' else strSQL := strSQL +' FROM tbltransactionsummarydetails as Trans';
  // strSQL := strSQL +' INNER JOIN tblchartofaccounts Using(AccountID)';
  // strSQL := strSQL +' INNER JOIN tblacctypedesc ON tblacctypedesc.AccType=Trans.AccountType';
  // strSQL := strSQL +' WHERE (Trans.AccountType = "EXEXP" OR Trans.AccountType = "EXINC" OR Trans.AccountType = "EXP" OR Trans.AccountType = "INC" OR Trans.AccountType = "COGS")';
  // if chkUseDateRange.Checked then begin
  // strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)) +
  // '  AND date < ' + Quotedstr(formatDatetime(MysqlDateFormat , yearstart))
  // end else strSQL := strSQL +' AND Date <  ' + Quotedstr(formatDatetime(MysqlDateFormat , yearstart));
  //
  // if (i=1) and (IncludedataPriorToClosingDate)  then strSQL := strSQL +' AND Trans.Type <> "Closing Date Summary" AND Trans.Seqno <100  ';
  // strSQL := strSQL +' Group By SortID';
  // if not chkAllClass.Checked then strSQL := strSQL +',ClassID';
  // SQLList.add(strSQL);
  // end;
  // end;
  // end;
  // SQLList.add('ORDER BY SortOrder) as TransDetails ');
  // SQLList.add(' Group by AccountName, AccountNameOnly , AccountNumber /*, TransID , SortID , SortOrder , Account */ ORDER BY SortOrder ;');
  // if FConReport.RecordCount > 0 then begin
  // FCOnReport.first;
  // while FConReport.Eof = False do begin
  // for ctr := low(Amountfields) to high(Amountfields) do
  // SQLList.add('update ' +fstablename + ' set ' +  FCOnReportCode.asString + '_' + amountfields[ctr] + '  = ' + Amountfields[ctr] + ' * ' + FCOnReportCode.asString + '_FCRate;' );
  // FConReport.next;
  // end;
  // end;
  // With ScriptMain do try
  // SQL.clear;
  // SQL.add(ChangeQuery(SQLList.text));
  // clog(SQL.text);
  // execute;
  // finally
  // SQL.clear;
  // end;
  // finally
  // FreeandNil(SQLList);
  // qry.Free;
  // end;
  // StringListForSQL.Add('select * ' );
  // StringListForSQL.Add(' from ' + fstablename );

  TBSQLObj.DateFrom := FilterDateFrom;
  TBSQLObj.DateTo := FilterDateTo;
  TBSQLObj.UseDateRange := chkUseDateRange.Checked;
  TBSQLObj.IncludePriorClosingDate := chkIncludehistory.Checked;
  TBSQLObj.AllDepartments := chkAllClass.Checked;
  TBSQLObj.AllOtherDepartments := chkShowallOtehr.Checked;
  TBSQLObj.SelectedDepartmentIDs.CommaText := SelectedDepartmentIds.CommaText;
  TBSQLObj.PopulateReportSQL(nil, msg);
  if TBSQLObj.UsingReportTables then
    if AppEnv.CompanyPrefs.TransactionTableLastUpdated <> 0 then
        Self.Caption := TitleLabel.Caption + ReportTableUpdatedtime;

end;

procedure TTrialBalanceGUI.QryFooterSummAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grdFooterSumm.selected.clear;
  grdFooterSumm.selected.Add(SelectedText('Classname', appenv.DefaultClass.ClassHeading, 20, ''));
  grdFooterSumm.selected.Add(SelectedText('CreditEx', 'Credit', 18, 'Ex'));
  grdFooterSumm.selected.Add(SelectedText('DebitEx', 'Debit', 18, 'Ex'));
  grdFooterSumm.selected.Add(SelectedText('CreditInc', 'Credit', 18, 'Inc'));
  grdFooterSumm.selected.Add(SelectedText('DebitInc', 'Debit', 18, 'Inc'));
  grdFooterSumm.selected.Add(SelectedText('DiffEx', 'Ex', 18, 'Diff'));
  grdFooterSumm.selected.Add(SelectedText('DiffInc', 'Inc', 18, 'Diff'));
  grdFooterSumm.ApplySelected;
end;

//function TTrialBalanceGUI.yearstart: TDatetime;
//begin
//  result := dateof(GetCurrentFiscalYearStart(FilterDateTo));
//end;

procedure TTrialBalanceGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.Datefrom'].AsString := DatetoStr(dtFrom.Date);
  GuiPrefs.Node['General.DateTo'].AsString := DatetoStr(dtto.Date);
  GuiPrefs.Node['General.usedate'].AsString := BooleanToStr(chkUseDateRange.checked);
  if chkAllClass.checked then
    GuiPrefs.Node['SelectedDepartments'].AsString := ''
  else
    GuiPrefs.Node['SelectedDepartments'].AsString := SelectedDepartmentIds.CommaText;
end;

procedure TTrialBalanceGUI.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['Options.chkShowallOtehr'].asBoolean := chkShowallOtehr.checked;
  GuiPrefs.Node['Options.chkhidediff'].asBoolean := chkhidediff.checked;
  GuiPrefs.Node['Options.grdFooterSumm'].asInteger := grdFooterSumm.Width;
end;

procedure TTrialBalanceGUI.grdFooterSummCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not(Samevalue(Round(QryFooterSummDiffEx.asfloat, appenv.RegionalOptions.DecimalPlaces), 0,
    LowestcurrencyDecimalValue)) then
    if sametext(QryFooterSummDiffEx.fieldname, Field.fieldname) or
      sametext(QryFooterSummCreditEx.fieldname, Field.fieldname) or
      sametext(QryFooterSummDebitEx.fieldname, Field.fieldname) then
      RednBold(AFont);
  if not(Samevalue(Round(QryFooterSummDiffinc.asfloat, appenv.RegionalOptions.DecimalPlaces), 0,
    LowestcurrencyDecimalValue)) then
    if sametext(QryFooterSummDiffinc.fieldname, Field.fieldname) or
      sametext(QryFooterSummCreditinc.fieldname, Field.fieldname) or
      sametext(QryFooterSummDebitinc.fieldname, Field.fieldname) then
      RednBold(AFont);
end;

procedure TTrialBalanceGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  HideZeroValueInNumberfield(State,Field, Afont,Abrush);
end;

procedure TTrialBalanceGUI.grdMainDblClick(Sender: TObject);
var
  frmTrialBalTransList: TComponent;
begin
  if SysUtils.sametext(trim(Qrymain.FieldByName('Account').AsString), 'Retained Earnings') then
    exit;
  if not FormStillOpen('TTrialBalTransListGUI') then begin
    frmTrialBalTransList := GetComponentByClassName('TTrialBalTransListGUI');
    if Assigned(frmTrialBalTransList) then begin
      with TTrialBalTransListGUI(frmTrialBalTransList) do begin
        chkUseDateRange.checked := self.chkUseDateRange.checked ;
        if self.chkUseDateRange.checked then
          DateFrom := self.FilterDateFrom
        else
          DateFrom := 0;
        DateTo := self.FilterDateTo;

        Accountname := self.Qrymain.FieldByName('Account').AsString;
        showdataPriorToClosingDate := IncludedataPriorToClosingDate;
        ClassIds := '%';
        FormStyle := fsmdiChild;
      end;
    end;
  end
  else begin
    frmTrialBalTransList := FindExistingComponent('TTrialBalTransListGUI');
    TForm(frmTrialBalTransList).Show;
  end;
end;

function TTrialBalanceGUI.IsAllOtherClassField(AFieldName: String): Boolean;
begin
  result := sametext(copy(trim(AFieldName) + replicatestr(' ', length(inttostr(IDForallOther))), 1,
    length(inttostr(IDForallOther))), inttostr(IDForallOther));
end;

procedure TTrialBalanceGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
var
  Qry: TERPQuery;
begin
  if IsAllOtherClassField(AFieldName) then begin
    Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      Qry.sql.text := 'Select T.ClassId , C.classname , C.active  , ' + CreditsEx +
        ' as CreditsEx, ' + DebitsEx + ' as DebitsEx, ' + CreditsInc + ' as CreditsInc, ' +
        DebitsInc + ' as Debitsinc' +
        ' from tbltransactions T inner join tblclass C on C.classid = T.classid ' +
        ' where T.classId not in (' + self.SelectedDepartmentIds.CommaText +
        ') and date between :DateFrom and :DateTo ' + ' group by T.ClassId  ' +
        ' order by Classname';

      Qry.parambyname('DateFrom').asDatetime := FilterDateFrom;
      Qry.parambyname('DateTo').asDatetime := FilterDateTo;

      Qry.Open;
      InitMsgParams;
      PopupMsgParams.Msgcaption := 'Warning';
      PopupMsgParams.Msgds := Qry;
      PopupMsgParams.fieldnames := 'classname,Active,CreditsEx,DebitsEx,CreditsInc,Debitsinc';
      PopupMsgParams.displayLabels := appenv.DefaultClass.ClassHeading +
        ',Active,CreditsEx,DebitsEx,CreditsInc,Debitsinc';
      PopupMsgParams.Custombuttons := 'OK';
      PopupMsgParams.Msg1 := 'All "Inactive ' + appenv.DefaultClass.ClassHeading +
        '" Entries - Missing in the Resport as Columns,  and Calcualted as 1 Sum as the Last Field';
      PopupMsgParams.MsgColor := self.Color;
      TfmMessageWithList.MsgDlg;

    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;

  end;
  inherited;

end;

procedure TTrialBalanceGUI.FormShow(Sender: TObject);
begin
  if not ErrorOccurred then begin
    lblClassTitle.Caption := appenv.DefaultClass.ClassHeading;
  end;
  ReadGuipref;
  SelectedDepartmentIds.CommaText := GuiPrefs.Node['SelectedDepartments'].AsString;
  chkAllClass.OnClick := nil;
  try
    chkAllClass.checked := SelectedDepartmentIds.Count = 0;
  finally
    chkAllClass.OnClick := chkAllClassClick;
  end;
  inherited;
end;

procedure TTrialBalanceGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.checked then
    GuiPrefs.Node['SelectedDepartments'].AsString := ''
  else
    GuiPrefs.Node['SelectedDepartments'].AsString := SelectedDepartmentIds.CommaText;
  RefreshQuery;
end;

procedure TTrialBalanceGUI.chkhidediffClick(Sender: TObject);
begin
  inherited;
  grdFooterSumm.visible := not(chkhidediff.checked);
  splitterFooterSumm.visible := not(chkhidediff.checked);
  splitterFooterSumm.Left:= 0;
  if grdFooterSumm.Width <= 0 then
    grdFooterSumm.Width := 100;
end;

procedure TTrialBalanceGUI.chkIncludehistoryClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkIncludehistory then
    RefreshQuery;
end;

procedure TTrialBalanceGUI.chkShowallOtehrClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TTrialBalanceGUI.chkUseDateRangeClick(Sender: TObject);
begin
  inherited;
  if not isFormshown then exit;

  AdjustDateRangeGUI;
  RefreshQuery;
end;

function TTrialBalanceGUI.GetReportTypeID: integer;
begin
  result := 79;
end;

procedure TTrialBalanceGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    try
      ReportSQLSupplied := true;
      UseStringListForSQL := true;
      inherited;
    finally
      ReportSQLSupplied := False;
      UseStringListForSQL := true;
    end;
  finally
    EnableForm;
  end;
end;

procedure TTrialBalanceGUI.FormDestroy(Sender: TObject);
begin
  TBSQLObj.Free;
  // DeleteTable(fstablename);
  FreeAndNil(SelectedDepartmentIds);
  DepartmentFieldNames.Free;
  inherited;
end;

procedure TTrialBalanceGUI.AdjustDateRangeGUI;
begin
  if chkUseDateRange.checked then begin
    dtFrom.visible := true;
    lblFrom.visible := true;
    cboDateRange.visible := true;
    lblTo.Caption := 'To';
    if dtFrom.Date = 0 then dtFrom.Date := incmonth(now, -1);
    chkUseDateRange.left := cboDateRange.left -chkUseDateRange.width -2;
  end  else begin
    dtFrom.visible := False;
    lblFrom.visible := False;
    cboDateRange.visible := False;
    lblTo.Caption := 'As Of';
    chkUseDateRange.left := dtTo.Left + dtTo.width - chkUseDateRange.width;
  end;
end;

//function TTrialBalanceGUI.AllClassIds(Qry: TERPQuery): String;
//begin
//  result := Qry.GroupConcat('ClassId');
//end;

procedure TTrialBalanceGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  inherited;
end;

procedure TTrialBalanceGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TTrialBalanceGUI.btnDeptSelectClick(Sender: TObject);
var
  fShowSubTotals: Boolean;
begin
  inherited;
  fShowSubTotals := False;
//  if DoDepartmentSelection(SelectedDepartmentIds, fShowSubTotals, true, true) then begin
  if DoDepartmentSelection(SelectedDepartmentIds, fShowSubTotals, true) then begin
    if chkAllClass.checked then
      chkAllClass.checked := False;
    if chkAllClass.checked then
      GuiPrefs.Node['SelectedDepartments'].AsString := ''
    else
      GuiPrefs.Node['SelectedDepartments'].AsString := SelectedDepartmentIds.CommaText;
    self.RefreshQuery;
  end;
end;

procedure TTrialBalanceGUI.btnnextClick(Sender: TObject);
begin
  inherited;
  SetControlFocus(dtto);
  try
    dtto.Date := incmonth(dtto.Date, 1);
  finally
    SetControlFocus(btnnext);
  end;
end;

procedure TTrialBalanceGUI.btnPreviousClick(Sender: TObject);
begin
  inherited;
  SetControlFocus(dtto);
  try
    dtto.Date := incmonth(dtto.Date, -1);
  finally
    SetControlFocus(btnPrevious);
  end;
end;

procedure TTrialBalanceGUI.btnTransJournalClick(Sender: TObject);
begin
  inherited;
  //OpenERpListForm('TTransactionListGUI', intTransactionList);
  OpenERpListForm('TTransactionExpressListGUI', intTransactionList);
end;

procedure TTrialBalanceGUI.intTransactionList(Sender: TObject);
begin
  (*if Sender is TTransactionListGUI then begin
    TTransactionListGUI(Sender).dtFrom.Date := FilterDateTo;
    TTransactionListGUI(Sender).dtto.Date := FilterDateTo;
    TTransactionListGUI(Sender).fbDateRangeSupplied := true;
  end;*)
  if Sender is TTransactionExpressListGUI then begin
    TTransactionExpressListGUI(Sender).dtFrom.Date := FilterDateTo;
    TTransactionExpressListGUI(Sender).dtto.Date := FilterDateTo;
    TTransactionExpressListGUI(Sender).fbDateRangeSupplied := true;
  end;
end;

procedure TTrialBalanceGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TTrialBalanceGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

//procedure TTrialBalanceGUI.CreateTemptable;
//begin
//  fsTablename := GetUserTemporaryTableName('tmp_TrialBalance');
//  fcfields := '';
//  Qrymain.sql.text := StringReplace(Qrymain.sql.text, 'tmp_TB', fsTablename, [rfIgnoreCase]);
//end;

procedure TTrialBalanceGUI.DisplayOrHideDepartmentFields;
var
  x: integer;
  floatField: TFloatField;
  Field: TField;
  arr: Types.TStringDynArray;
  credDebt: string;
  incEx: string;
  GridFieldList: TGridFieldList;

begin
  if (not chkAllClass.checked) and (DepartmentFieldNames.Count > 0) then begin
    { display department fields }
    for x := 0 to DepartmentFieldNames.Count - 1 do begin
      RemoveAmountField(DepartmentFieldNames[x]);
      arr := StrUtils.SplitString(DepartmentFieldNames[x], '_');
      if Pos('Credits', arr[1]) > 0 then
        credDebt := 'Credits'
      else
        credDebt := 'Debits';
      if Pos('Inc', arr[1]) > 0 then
        incEx := 'Inc'
      else
        incEx := 'Ex';

      { because we are using persistant fields we have to create a new
        field object }
      if Qrymain.findfield(DepartmentFieldNames[x]) = nil then begin
        if Qrymain.Active then
          Qrymain.Close;
        floatField := TFloatField.Create(Qrymain);
        floatField.fieldKind := fkData;
        floatField.fieldname := DepartmentFieldNames[x];
        floatField.DisplayFormat := appenv.RegionalOptions.CurrencySymbol +
          '#,###,###,###,###,##0.00;(' + appenv.RegionalOptions.CurrencySymbol +
          '#,###,###,###,###,##0.00)';
        floatField.DataSet := Qrymain;
        floatField.DisplayLabel := credDebt + ' (' + incEx + ')';
        floatField.Tag := TAG_MASK_DC;
        floatField.visible := true;
      end;
    end;
    if not Qrymain.Active then
      Qrymain.Open;
    GridFieldList := TGridFieldList.Create;
    try
      GridFieldList.LoadFromGrid(grdMain);
      for x := 0 to DepartmentFieldNames.Count - 1 do begin
        arr := StrUtils.SplitString(DepartmentFieldNames[x], '_');
        Field := Qrymain.findfield(DepartmentFieldNames[x]);
        Field.displaywidth := 15;
        if Assigned(Field) then begin
          GridFieldList.AddField(Field, GetClassName(arr[0]));
          AddAmountField(Field.fieldname);
        end;
      end;
      { remove fields from grid that are no longer in dataset }
      x := 0;
      while x < GridFieldList.Count do begin
        if Qrymain.findfield(GridFieldList.Items[x].fieldname) = nil then
          GridFieldList.Delete(x)
        else
          Inc(x);
      end;

      GridFieldList.SaveToGrid(grdMain);
    finally
      GridFieldList.Free;
    end;
  end
  else begin
    { hide unwanted fields }
    for x := 0 to Qrymain.FieldCount - 1 do begin
      Field := Qrymain.Fields[x];
      if (Pos('_CeditsInc', Field.fieldname) > 0) or (Pos('_CeditsEx', Field.fieldname) > 0) or
        (Pos('_DebitsInc', Field.fieldname) > 0) or (Pos('_DebitsEx', Field.fieldname) > 0) then
      begin
        self.RemoveFieldfromGrid(Field.fieldname);

      end;
    end;
  end;
end;

procedure TTrialBalanceGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
end;

procedure TTrialBalanceGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := true;
end;

initialization

RegisterClassOnce(TTrialBalanceGUI);

end.
