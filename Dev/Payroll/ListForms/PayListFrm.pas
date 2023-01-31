unit PayListFrm;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  StrUtils, wwcheckbox, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, kbmMemTable, DBAccess, MyAccess,ERPdbComponents, ProgressDialog,
  wwdbdatetimepicker,  wwdblook, Shader, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPayListingGUI = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainPayDate: TDateField;
    qryMainPayPeriods: TWordField;
    qryMainWages: TFloatField;
    qryMainCommission: TFloatField;
    qryMainSalarySacrifice: TFloatField;
    qryMainDeductions: TFloatField;
    qryMainWorkplacegiving: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainSundries: TFloatField;
    qryMainSuperannuation: TFloatField;
    qryMainGross: TFloatField;
    qryMainTax: TFloatField;
    qryMainPay: TWideStringField;
    qryMainCDEP: TCurrencyField;
    chkUseDatePaid: TCheckBox;
    qryMainPaid: TWideStringField;
    actReversePays: TAction;
    qryMainPayPeriod: TWideStringField;
    qryMainClassName: TWideStringField;
    Label7: TLabel;
    wwExpandButton1: TwwExpandButton;
    grdJournals: TwwDBGrid;
    qryJournals: TERPQuery;
    dsJournals: TDataSource;
    qryJournalsAccount: TWideStringField;
    qryJournalsDescription: TWideStringField;
    qryJournalsCredit: TFloatField;
    qryJournalsDebit: TFloatField;
    qryMainGL: TWideStringField;
    qryMainPayID: TIntegerField;
    qryMainDeleted: TWideStringField;
    qryMainPayNo: TIntegerField;
    qryJournalsGlobalRef: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryBankDetails: TERPQuery;
    qryMainBSB: TWideStringField;
    qryMainBankAccNo: TWideStringField;
    qryPayPaySplits: TERPQuery;
    grdSplits: TwwDBGrid;
    wwExpandButton2: TwwExpandButton;
    qryMainSplits: TWideStringField;
    DSPayPaySplits: TDataSource;
    qryPayPaySplitsEmployeeName: TWideStringField;
    qryPayPaySplitsDeleted: TWideStringField;
    qryPayPaySplitsType: TWideStringField;
    qryPayPaySplitsBSB: TWideStringField;
    qryPayPaySplitsAccountNo: TWideStringField;
    qryPayPaySplitsBankCode: TWideStringField;
    qryPayPaySplitsBankDescription: TWideStringField;
    qryPayPaySplitsAmount: TFloatField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainNetCombined: TFloatField;
    qryMainNetOnly: TFloatField;
    DNMSpeedButton1: TDNMSpeedButton;
    btnPrintPayslips: TDNMSpeedButton;
    qryMainDatePaid: TDateTimeField;
    qryMainDetail: TWideStringField;
    grdDetail: TwwDBGrid;
    ebnDetail: TwwExpandButton;
    qryDetail: TERPQuery;
    dsDetail: TDataSource;
    qryMainEmployeeID: TIntegerField;
    qryDetailDatePaid: TWideStringField;
    qryDetailHours: TFloatField;
    qryDetailGross: TFloatField;
    qryDetailFedTax: TFloatField;
    qryDetailSocTax: TFloatField;
    qryDetailMedTax: TFloatField;
    qryDetailStateTax: TFloatField;
    qryDetailOST: TFloatField;
    qryDetailLIT: TFloatField;
    qryDetailPlan: TFloatField;
    qryDetailOther: TFloatField;
    qryDetailNet: TFloatField;
    qryDetailCheckNum: TLargeintField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure wwExpandButton1BeforeExpand(Sender: TObject);
    procedure wwExpandButton1AfterExpand(Sender: TObject);
    procedure grdJournalsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdJournalsCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure qryJournalsAfterOpen(DataSet: TDataSet);
    procedure wwExpandButton1BeforeCollapse(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure wwExpandButton2BeforeExpand(Sender: TObject);
    procedure wwExpandButton2BeforeCollapse(Sender: TObject);
    procedure btnPrintReportClick(Sender: TObject);
    procedure wwExpandButton1AfterCollapse(Sender: TObject);
    procedure wwExpandButton2AfterExpand(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryPayPaySplitsBeforeOpen(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnPrintPayslipsClick(Sender: TObject);
    procedure ebnDetailBeforeExpand(Sender: TObject);
    procedure ebnDetailAfterExpand(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);

  private
    { Private declarations }
    sFilter: string;
    EmpStr: string;
    AddTable: string;
    Field2: string;
    bFirstOpen: boolean;
    procedure SetDateFilter;
    procedure SetSplitSQL(iPayID:Integer);
    procedure LoadSQL;
    procedure SetupCustomFields;
    procedure PrintPayHistory;
    procedure PrintPayHistory2;
    procedure Printpayslip;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); override;
    function GetReportTypeID :Integer ; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses FastFuncs,Forms, CommonDbLib,
  //PayFunctionObj,
  CommonLib,BusObjPayUtils, MySQLConst, BaseInputForm, AppEnvironment,
  JsonObject, tcTypes , BusObjPayBase , chequeLib, tcConst, PayAccounts,
  tcDataUtils, DbSharedObjectsObj;

procedure TPayListingGUI.RefreshQuery;
var
  I: Integer;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('dtFrom').AsDateTime := 0;
    qryMain.Params.ParamByName('dtTo').AsDateTime := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('dtFrom').AsString := FormatDateTime(MysqlDateFormat, dtFrom.Date);
    qryMain.Params.ParamByName('dtTo').AsString := FormatDateTime(MysqlDateFormat, dtTo.Date);
  end;

  SetDateFilter;

  inherited;

  if AppEnv.RegionalOptions.RegionType <> rUSA then begin
    for I := 0 to grdMain.FieldCount - 1 do begin
      if grdMain.FieldName(I) = 'Detail' then begin
        grdMain.Fields[I - 1].Visible := False;
        Break;
      end;
    end;
  end;


end;

procedure TPayListingGUI.SetSplitSQL(iPayID:Integer);
var
  dAmountRemainder: double;
  qryTemp:TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  Try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

    qryTemp.SQL.Clear;
    qryTemp.SQL.Text :='SELECT '+
                              'Sum(CASE PS.Type '+
                              'WHEN "$" THEN Round(PS.Amount,'+inttostr(CurrencyRoundPlaces)+') '+
                              'WHEN "%" THEN Round((PS.Amount/100)*P.Net,'+inttostr(CurrencyRoundPlaces)+') '+
                              'ELSE 0.00 END) as Amount, '+
                              'P.Net,P.Deleted '+
                              'FROM tblpays AS P '+
                              'INNER JOIN tblpayssplits AS PS on PS.PayID = P.PayID '+
                              'WHERE (P.PayID = ' + IntToStr(iPayID) + ') AND (P.Deleted = "F" )' +
                              'Group By P.Net; ';
    qryTemp.Open;
    dAmountRemainder := qryTemp.FieldByName('Net').asFloat - qryTemp.FieldByName('Amount').asFloat;
    qryTemp.Close;
  finally
    FreeAndNil(qryTemp);
  end;
  qryPayPaySplits.ParamByName('xPayID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
  qryPayPaySplits.ParamByName('xRemainder').AsFloat := dAmountRemainder;
end;

procedure TPayListingGUI.SetDateFilter;
begin
  if chkIgnoreDates.Checked then begin
    if chkUseDatePaid.Checked then begin
      sFilter := 'DatePaid Between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, 0));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, SysUtils.MaxDateTime));
    end else begin
      sFilter := 'PayDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, 0));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, SysUtils.MaxDateTime));
    end;
  end
  else begin
    if chkUseDatePaid.Checked then begin
      sFilter := 'DatePaid Between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtFrom.Date));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtTo.Date));
    end else begin
      sFilter := 'PayDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date));
    end;
  end;
end;

procedure TPayListingGUI.SetGridColumns;
begin
  inherited;
  if AppEnv.RegionalOptions.RegionType <> rAUST then begin
    RemoveFieldfromGrid('CDEP');
    RemoveFieldfromGrid('Superannuation');
  end;
end;

procedure TPayListingGUI.grpFiltersClick(Sender: TObject);
begin
  SetDateFilter;
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Deleted=' + QuotedStr('F');
        SetDateFilter;
        sFilter := sFilter + ' AND Deleted=' + QuotedStr('F');
      end;
    1: 
      begin
        GroupFilterString := 'Deleted=' + QuotedStr('T');
        SetDateFilter;
        sFilter := sFilter + ' AND Deleted=' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TPayListingGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  Pay:Tpaybase;
  PayUtils:Tpayutils;
  sSQL:String;
begin
  inherited;

  if IterateProcno = 1 then begin
    if QrymainDeleted.AsBoolean  then begin
      MessageDlgXP_Vista('Pay ID #' + inttostr(Qrymainpayid.asInteger) + ' of '+  Quotedstr(qrymainEmployeeName.asString) + ' is deleted. '+NL+
                          'Its not possible to print cheque for a deleted pay.', mtWarning, [mbOK], 0);
      exit;
    end;
    Pay := Tpaybase.Create(Self  , QrymainPayid.asInteger , TERPConnection(Qrymain.Connection) );
    try
      Pay.Load(QrymainPayid.asInteger );
      PayUtils := TPayUtils.Create(Self,Pay.Connection.Connection);
//      if AppEnv.RegionalOptions.RegionType = rUSA then begin
//        sSQL:= PayUtils.PrintPaySlipSQLUSA(Pay);
//      end else begin
      sSQL:= PayUtils.PrintPaySlipSQL(Pay);
//      end;
      ssql:= PaychequeSQL(Pay.ID , Pay.Gross, Pay.Net) + '~|||~'+SSQL;
      ReportSQLSupplied := True;
      PrintTemplateReport(ReportToPrint, sSQL, not(AppEnv.Employee.ShowPreview), 1 , nil , '', true );
      if PrintTemplate.CancelPreviewAll then abort := TRue;
    finally
      Freeandnil(PayUtils);
      Freeandnil(Pay);
    end;
  end else if IterateProcno = 2 then begin
     Printpayslip;
  end;
end;

procedure TPayListingGUI.Printpayslip;
Var
  tmpPayFunction: TPayUtils;
  ssql:String;
begin
  DisableForm;
  try
    inherited;
    tmpPayFunction := TPayUtils.Create(Self);
    try
      //tmpPayFunction.PrintUnprocessedPaysReport(true , qrymainpayid.asInteger);
      ssql:= tmpPayFunction.PaysReportSQL(true , qrymainpayid.asInteger);
      ReportSQLSupplied := True;
      PrintTemplateReport('Payslip Report' , ssql, not(Appenv.Employee.ShowPreview) , 1 );
    finally
      FreeAndNil(tmpPayFunction);
    end;
  finally
    EnableForm;
  end;
end;

procedure TPayListingGUI.actExecuteFilterExecute(Sender: TObject);
begin
  if (LeftStr(qryMain.Filter, 9) = '[Employee') then begin
    EmpStr   := 'AND Concat(FirstName," ",LastName)=' + FastFuncs.RightStr(qryMain.Filter,
      char_length(qryMain.Filter) - FastFuncs.PosEx('=', qryMain.Filter));
    AddTable := ' LEFT JOIN tblemployees ON tblpays.EmployeeID=tblemployees.EmployeeID ';
    Field2   := 'Concat(FirstName," ",LastName) AS "Employee Name", 1 AS ID';
    sFilter  := sFilter + EmpStr + ' GROUP BY ID';
  end;
  inherited;
end;

procedure TPayListingGUI.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
  sl: TStringList;
  x: integer;
begin
  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryJournals.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryJournals.ParamCheck := true;

  qryDetail.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryDetail.ParamCheck := true;

  LoadSQL;
  sl := TStringList.Create;
  try
    with TFloatField.Create(Self) do begin
      Currency := True;
      fieldKind := fkData;
      fieldname := 'CompanyTax';
      name := ComponentName(self, 'qryMainCompanyTax');
      DisplayLabel := 'Company Tax';
      DataSet := qryMain;
      visible := True;
    end;

    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Add('select TaxName, ID from tblpaytaxconfig where Active = "T"');
      qry.SQL.Add('and RegionId = ' + IntToStr(AppEnv.RegionalOptions.Id));
      qry.Open;
      while not qry.Eof do begin

        with TFloatField.Create(Self) do begin
          Currency := True;
          fieldKind := fkData;

//          if Assigned(qryMain.FindField(qry.FieldByName('TaxName').AsString)) then begin
//            y:= 1;
//            while Assigned(qryMain.FindField(qry.FieldByName('TaxName').AsString + IntToStr(y))) do
//              Inc(y);
//            fieldName := qry.FieldByName('TaxName').AsString + IntToStr(y);
//          end
//          else
//            fieldname := qry.FieldByName('TaxName').AsString;
          fieldName := 'TaxConfig_' + qry.FieldByName('TaxName').AsString;
          sl.Add(fieldname);
          name := ComponentName(self, ReplaceStr(ReplaceStr('qryMain'+fieldname, '-','_'),' ','_'));
          DisplayLabel := qry.FieldByName('TaxName').AsString;
          DataSet := qryMain;
          visible := True;
        end;

        qry.Next;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;

    inherited;

    AddCalcColumn(qryMainWages.FieldName, true);
    AddCalcColumn(qryMainCommission.FieldName, true);
    AddCalcColumn(qryMainDeductions.FieldName, true);
    AddCalcColumn(qryMainWorkplacegiving.FieldName, true);
    AddCalcColumn(qryMainAllowances.FieldName, true);
    AddCalcColumn(qryMainSundries.FieldName, true);
    AddCalcColumn(qryMainGross.FieldName, true);
    AddCalcColumn(qryMainTax.FieldName, true);
    AddCalcColumn(qryMainNetCombined.FieldName, true);
    AddCalcColumn(qryMainNetOnly.FieldName, true);
    AddCalcColumn(qryMainSalarySacrifice.FieldName, true);
    AddCalcColumn(qryMainSuperannuation.FieldName, true);

    AddCalcColumn('CompanyTax', true);
    for x := 0 to sl.Count -1 do
      AddCalcColumn(sl[x], true);

  finally
    sl.Free;
  end;
end;

procedure TPayListingGUI.actClearFilterExecute(Sender: TObject);
begin
  SetDateFilter;
  inherited;
end;

procedure TPayListingGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnPrintPayslips.visible := Devmode;
  if not qryMain.Active then Exit;
  if devmode then
    Showcontrolhint(chkUseDatePaid , 'ATO Requires Actual Payment Date. ie : Checked');
  //  tblpays.Open;
  qryMain.FieldByName('Paid').DisplayWidth := 8;
  qryMain.FieldByName('Pay').DisplayWidth := 8;
  grdMain.SetControlType('Paid', fctCustom, 'chkPaid');
  grdMain.SetControlType('Pay', fctCustom, 'chkPay');
  grdMain.Invalidate;
  grdMain.RefreshDisplay;

  qryMain.FieldByName('Pay').Visible := false;
  if Owner.Name = 'frmEmployeeFrm' then begin
    qryMain.FieldByName('EmployeeName').Visible := false;
    qryMain.FieldByName('Paid').Visible         := false;
  end;
  GuiPrefs.DbGridElement[grdMain].RemoveField('PayId');
  SetupCustomFields;
  grdMain.OnTitleButtonClick:= grdMainTitleButtonClick;
end;

function TPayListingGUI.GetReportTypeID: Integer;
begin
  Result := 129;  // 32
end;

procedure TPayListingGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPayListingGUI.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
  LoadSQL;
  RefreshQuery;
end;

procedure TPayListingGUI.LoadSQL;
var
  qry: TERPQuery;
  fieldname: string;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('''Exp'' AS ''Detail'',');
  qryMain.SQL.Add('tblPays.GlobalRef as GlobalRef,');
  qryMain.SQL.Add('tblPays.PayID as PayID,');
  qryMain.SQL.Add('tblPays.EmployeeID AS ''EmployeeID'',');
  qryMain.SQL.Add('tblPays.PayPeriod as PayPeriod,');
  qryMain.SQL.Add('Concat(FirstName,'' '',LastName) AS ''EmployeeName'',');
  qryMain.SQL.Add('PayDate AS ''Pay Date'',');
  qryMain.SQL.Add('DatePaid AS ''Date Paid'',');
  qryMain.SQL.Add('PayPeriods AS ''Pay Periods'',');
  qryMain.SQL.Add('ROUND(tblPays.Wages, '+inttostr(CurrencyRoundPlaces)+') As Wages,');
  qryMain.SQL.Add('ROUND(tblPays.Commission, '+inttostr(CurrencyRoundPlaces)+') AS Commission,');
  qryMain.SQL.Add('ROUND(tblPays.Deductions, '+inttostr(CurrencyRoundPlaces)+') AS Deductions,');
  qryMain.SQL.Add('ROUND(tblPays.Workplacegiving, '+inttostr(CurrencyRoundPlaces)+') AS Workplacegiving,');
  qryMain.SQL.Add('ROUND(tblPays.Allowances, '+inttostr(CurrencyRoundPlaces)+') AS Allowances,');
  qryMain.SQL.Add('ROUND(tblPays.CDEPGross, '+inttostr(CurrencyRoundPlaces)+') AS CDEP,');
  qryMain.SQL.Add('ROUND(tblPays.Sundries, '+inttostr(CurrencyRoundPlaces)+') AS Sundries,');
  qryMain.SQL.Add('ROUND(tblPays.Superannuation, '+inttostr(CurrencyRoundPlaces)+') AS Superannuation,');
  qryMain.SQL.Add('ROUND(tblPays.Gross, '+inttostr(CurrencyRoundPlaces)+') AS Gross,');
  qryMain.SQL.Add('ROUND(tblPays.Tax, '+inttostr(CurrencyRoundPlaces)+') AS Tax,');
  qryMain.SQL.Add('ROUND(tblPays.Net, '+inttostr(CurrencyRoundPlaces)+') AS NetCombined,');
  qryMain.SQL.Add('ROUND(Sum(-pt.Amount), '+inttostr(CurrencyRoundPlaces)+') AS NetOnly,');
  qryMain.SQL.Add('Paid as Paid,');
  qryMain.SQL.Add('Pay as Pay,');
  qryMain.SQL.Add('tblClass.ClassName as ClassName,');
  qryMain.SQL.Add('"G/L" AS "G/L",');
  qryMain.SQL.Add('"Splits" AS "Splits",');
  qryMain.SQL.Add('tblPays.Deleted as Deleted,');
  qryMain.SQL.Add('tblPays.PayID as PayNo,');
  qryMain.SQL.Add('FirstName as FirstName,');
  qryMain.SQL.Add('LastName as LastName,');

  qryMain.SQL.Add('CompanyTax as CompanyTax,');
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select TaxName, ID from tblpaytaxconfig where Active = "T"');
    qry.Open;
    while not qry.Eof do begin
      fieldName := 'TaxConfig_' + qry.FieldByName('TaxName').AsString;
//      qryMain.SQL.Add('(select Sum(Amount) as Ammount from tblPayTax where tblpayTax.PayID = tblpays.PayID and tblPayTax.PayTaxConfigId = ' + IntToStr(qry.FieldByName('Id').AsInteger) +') as `' + qry.FieldByName('TaxName').AsString + '`,');
      qryMain.SQL.Add('(select Sum(Amount) as Ammount from tblPayTax where tblpayTax.PayID = tblpays.PayID and tblPayTax.PayTaxConfigId = ' + IntToStr(qry.FieldByName('Id').AsInteger) +') as `' + fieldname + '`,');

      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  qryMain.SQL.Add('(select Sum(AmountPaid) as AmountPaid from tblpayssuperannuation INNER JOIN tblsupertype ST USING(SuperTypeID) where ST.Description="Salary Sacrifice" and tblpayssuperannuation.PayID = tblpays.PayID ) as `SalarySacrifice`,');
  qryMain.SQL.Add('CUSTFLD1 as CUSTFLD1,');
  qryMain.SQL.Add('CUSTFLD2 as CUSTFLD2,');
  qryMain.SQL.Add('CUSTFLD3 as CUSTFLD3,');
  qryMain.SQL.Add('CUSTFLD4 as CUSTFLD4,');
  qryMain.SQL.Add('CUSTFLD5 as CUSTFLD5,');
  qryMain.SQL.Add('CUSTFLD6 as CUSTFLD6,');
  qryMain.SQL.Add('CUSTFLD7 as CUSTFLD7,');
  qryMain.SQL.Add('CUSTFLD8 as CUSTFLD8,');
  qryMain.SQL.Add('CUSTFLD9 as CUSTFLD9,');
  qryMain.SQL.Add('CUSTFLD10 as CUSTFLD10,');
  qryMain.SQL.Add('CUSTFLD11 as CUSTFLD11,');
  qryMain.SQL.Add('CUSTFLD12 as CUSTFLD12,');
  qryMain.SQL.Add('CUSTFLD13 as CUSTFLD13,');
  qryMain.SQL.Add('CUSTFLD14 as CUSTFLD14,');
  qryMain.SQL.Add('CUSTFLD15 as CUSTFLD15');
  qryMain.SQL.Add('FROM tblPays ');
  qryMain.SQL.Add('LEFT JOIN tblEmployees ON tblPays.EmployeeID=tblEmployees.EmployeeID');
  qryMain.SQL.Add('LEFT JOIN tblClass ON tblPays.ClassID = tblClass.ClassID');
//  qryMain.SQL.Add('Left JOIN tblPaysTransactions pt on pt.PayID = tblPays.PayID and pt.AccountId = ' +
//    IntToStr(AppEnv.PayPrefs.NetWagesAccountID));
  qryMain.SQL.Add('Left JOIN tblPaysTransactions pt on pt.PayID = tblPays.PayID and pt.AccountId in (' +
    PayAccounts.NetWagesAccountIDList + ')');
  if not chkUseDatePaid.Checked then
    qryMain.SQL.Add('WHERE tblPays.PayDate Between :dtFrom AND :dtTo AND Paid=''T''')
  else
    qryMain.SQL.Add('WHERE tblPays.DatePaid Between :dtFrom AND :dtTo AND Paid=''T''');
  qryMain.SQL.Add('GROUP By tblPays.PayID');
  qryMain.SQL.Add('ORDER BY FirstName, PayDate');
  RefreshOrignalSQL;
end;

procedure TPayListingGUI.wwExpandButton1BeforeExpand(Sender: TObject);
begin
  inherited;
  qryJournals.Close;
  qryJournals.ParamByName('xPayID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
  qryJournals.Open;
  grdMain.Options := grdMain.Options - [dgShowFooter];

end;

procedure TPayListingGUI.wwExpandButton1AfterExpand(Sender: TObject);
var
  dCredits, dDebits: double;
begin
  {Grid Setup}
  grdJournals.Top := grdMain.Top + 42;
  grdJournals.Left := grdMain.Left;
  grdJournals.Width := grdMain.Width - 25;
  grdJournals.Height := grdMain.Height - 65;
  inherited;
  dCredits := 0.00;
  dDebits := 0.00;
  qryJournals.DisableControls;
  qryJournals.First;
  while not qryJournals.Eof do begin
    dCredits := dCredits + qryJournals.FieldByName('Credit').AsFloat;
    dDebits  := dDebits + qryJournals.FieldByName('Debit').AsFloat;
    qryJournals.Next;
  end;
  qryJournals.EnableControls;
  qryJournals.First;
  grdJournals.ColumnByName('Credit').FooterValue := FloatToStrF(dCredits, ffCurrency, 15, CurrencyRoundPlaces);
  grdJournals.ColumnByName('Debit').FooterValue := FloatToStrF(dDebits, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TPayListingGUI.grdJournalsTitleButtonClick(Sender: TObject; AFieldName: string);
var 
  tmpIndex: string;
begin
  Processingcursor(True);
  try
    if qryJournals.FindField(AFieldName) <> nil then begin
      if (qryJournals.FieldByName(AFieldName).FieldKind <> fkLookup) and
        (qryJournals.FieldByName(AFieldName).FieldKind <> fkCalculated) and
        (qryJournals.FieldByName(AFieldName).DataType <> ftWideMemo) and
        (qryJournals.FieldByName(AFieldName).DataType <> ftMemo) then begin
        qryJournals.DisableControls;
        if (FastFuncs.PosEx(QuotedStr(AFieldName) + ' ASC CIS', qryJournals.IndexFieldNames) <> 0) then begin
          if not empty(BaseIndexFieldNames) and (FastFuncs.PosEx(QuotedStr(AFieldName), BaseIndexFieldNames) = 0) then begin
            tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BaseIndexFieldNames;
          end else begin
            tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
          end;
          qryJournals.IndexFieldNames := tmpIndex;
        end else begin
          if not empty(BaseIndexFieldNames) and (FastFuncs.PosEx(QuotedStr(AFieldName), BaseIndexFieldNames) = 0) then begin
            tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + BaseIndexFieldNames;
          end else begin
            tmpIndex := QuotedStr(AFieldName) + ' ASC CIS;';
          end;
          try
            qryJournals.IndexFieldNames := '';
            Application.ProcessMessages;          
            qryJournals.IndexFieldNames := tmpIndex;
          except
          end;
        end;
        qryJournals.EnableControls;
      end;
    end;
  finally
    Processingcursor(False);
  end;
end;

procedure TPayListingGUI.grdJournalsCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not bFirstOpen then begin
    if (FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' ASC CIS;', qryJournals.IndexFieldNames) > 0) then begin
      TitleImageAttributes.ImageIndex := 3;
    end else if FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' DESC CIS;', qryJournals.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 4;
    end else begin
      TitleImageAttributes.ImageIndex := -1;
    end;
  end;
end;

procedure TPayListingGUI.qryJournalsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  bFirstOpen := true;
  qryJournals.IndexFieldNames := 'Account ASC CIS,Description ASC CIS;';
  bFirstOpen := false;
end;

procedure TPayListingGUI.wwExpandButton1BeforeCollapse(Sender: TObject);
begin
  inherited;
  grdMain.Options := grdMain.Options + [dgShowFooter];
end;

procedure TPayListingGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainDatePaid.displayformat := shortdateformat;
end;

procedure TPayListingGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryBankDetails.Close;
  qryBankDetails.Params.ParamByName('xID').AsString := qryMainEmployeeID.AsString;
  qryBankDetails.Open;
  If (qryBankDetails.RecordCount>0) then Begin
    qryMainBSB.AsString := qryBankDetails.FieldByName('BSB').AsString;
    qryMainBankAccNo.AsString := qryBankDetails.FieldByName('AccountNo').AsString;
  end else Begin
    qryMainBSB.AsString := '';
    qryMainBankAccNo.AsString := '';
  end;
  qryBankDetails.Close;

//
end;

procedure TPayListingGUI.qryPayPaySplitsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TPayListingGUI.wwExpandButton2BeforeExpand(Sender: TObject);
begin
  inherited;
  qryPayPaySplits.Close;
  SetSplitSQL(qryMain.FieldByName('PayID').AsInteger);
  qryPayPaySplits.Open;
  grdMain.Options := grdMain.Options - [dgShowFooter];
end;

procedure TPayListingGUI.wwExpandButton2BeforeCollapse(Sender: TObject);
begin
  inherited;
  grdMain.Options := grdMain.Options + [dgShowFooter];
end;

procedure TPayListingGUI.btnPrintPayslipsClick(Sender: TObject);
begin
  inherited;
  iterateprocno := 2;
  IterateSelectedRecords;
end;

procedure TPayListingGUI.btnPrintReportClick(Sender: TObject);
begin

  PrintPayHistory2;
end;

procedure TPayListingGUI.PrintPayHistory2;
var
  SQL: string;
begin
  SQL := '{Payroll}' +
    'SELECT p.EmpName, e.ABN, ' +
    ' DATE_FORMAT(DatePaid, "%m/%d/%Y") AS DatePaid, ' +
    ' 0 AS CheckNum,	r.Qty AS Hours, p.Gross, p.FITWages, ' +
    ' SUM(IF(c.GroupType="Federal", t.Amount , 0)) AS FedTax, ' +
		' p.SocWages, ' +
		' SUM(IF(c.GroupType="SocialSecurity" AND c.TaxType="Employee", t.Amount , 0)) AS SocTax, ' +
		' p.MedWages, ' +
		' SUM(IF(c.GroupType="Medicare" AND c.TaxType="Employee", t.Amount , 0)) AS MedTax, ' +
		' p.StateWages, ' +
		' SUM(IF(c.GroupType="State", t.Amount , 0)) AS StateTax, ' +
		' p.Deductions, p.Tax, p.Net ' +
	  'FROM tblpays p LEFT JOIN tblpaytax t ON p.PayID=t.PayID ' +
		' LEFT JOIN tblpaytaxconfig c ON t.PayTaxConfigId=c.ID ' +
		' LEFT JOIN tblpayspayrates r ON p.PayID=r.PayID ' +
		' LEFT JOIN tblemployees e ON p.EmployeeID=e.EmployeeID ' +
	  'WHERE DATE_FORMAT(DatePaid, "%Y-%m-%d")="' + FormatDateTime(MysqlDateFormat, qryMainDatePaid.AsDateTime) + '" AND p.Paid="T" ' +
	  'GROUP BY p.EmployeeId, p.PayID ' +
    ' ~|||~ ' +
    '{Company} ' +
    'SELECT CompanyName FROM tblcompanyinformation ';

  ReportSQLSupplied := True;
  PrintTemplateReport('Pay History Report 2', SQL, False, 1);
end;

procedure TPayListingGUI.PrintPayHistory;
var
  Json: TJsonObject;
  sql: string;

  function GetTemplateWhere: string;
  begin
    result:= ' where (P.Paid = "T") ';
    if not chkIgnoreDates.Checked then begin
      if result <> '' then result:= result + ' and ';
      if chkUseDatePaid.Checked then
        result:= result + '(P.DatePaid between "' +
          FormatDateTime(Mysqldatetimeformat,filterdateFrom) + '" and "' +
          FormatDateTime(MySQlDateTimeformat,FilterdateTo) + '")'
      else
        result:= result + '(P.PayDate between "' +
          FormatDateTime('yyyy-mm-dd',Filterdatefrom) + '" and "' +
          FormatDateTime('yyyy-mm-dd',FilterDateTo) + '")';
    end;
    if grpFilters.ItemIndex = 0 then begin
      if result <> '' then result:= result + ' and ';
      result:= result + '(P.Deleted <> "T")';
    end
    else if grpFilters.ItemIndex = 1 then begin
      if result <> '' then result:= result + ' and ';
      result:= result + '(P.Deleted = "T")';
    end;
    if result <> '' then result:= result + ' ';
  end;

begin
  DisableForm;
  Processingcursor(True);
  try
    sql:=
      '{Master}SELECT P.PayID, P.EmployeeID,  CO.CompanyName, ' +
      'CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
      'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
      'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN AS ABN, ' +
      'P.PayDate, P.Wages, P.Commission, P.Deductions, P.Workplacegiving, P.Allowances, ' +
      'P.Sundries, P.Superannuation, P.Gross, P.Tax, P.Net, P.CDEPGross, P.EmpName, ' +
      'date_format(P.PayDate ,"%m/%Y")  as Paymonth ' +
      'FROM tblCompanyInformation AS CO,   tblpays AS P ' +
      GetTemplateWhere +
      'ORDER BY P.EmpName, P.PayDate ' +
      '  ~|||~{Detail} SELECT  P.PayDate, PR.PayID, PR.Qty, PR.Amount, PR.LineTotal, R.Description ' +
      'FROM tblpays AS P ' +
      'LEFT JOIN tblpayspayrates AS PR Using(PayID) ' +
      'LEFT JOIN tblpayrates AS R ON PR.PayRateID = R.RateID ' +
      'ORDER BY P.PayID, PR.Qty';

    Json:= JO;
    try
      Json.O['1'].S['master']:= 'Master';
      Json.O['1'].S['detail']:= 'Detail';
      Json.O['1'].S['masterfields']:= 'PayID';
      Json.O['1'].S['detailfields']:= 'PayID';

      ReportSQLSupplied := true;
      PrintTemplateReport('Pay History Report', sql, False, 1, Json);
    finally
      Json.Free;
    end;
  finally
    Processingcursor(False);
    EnableForm;
  end;
end;


procedure TPayListingGUI.wwExpandButton1AfterCollapse(Sender: TObject);
begin
  inherited;
  grdMain.RedrawGrid;
  Self.Update;
end;

procedure TPayListingGUI.wwExpandButton2AfterExpand(Sender: TObject);
begin
  inherited;
  {Grid Setup}
  grdSplits.Top := grdMain.Top + 42;
  grdSplits.Left := grdMain.Left;
  grdSplits.Width := grdMain.Width - 25;
  grdSplits.Height := grdMain.Height - 65;
end;

procedure TPayListingGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListingGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListingGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListingGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    if chkAdvancedPrinting.Checked then begin
      if AppEnv.RegionalOptions.RegionType = rUSA then
        PrintPayHistory2
      else
        PrintPayHistory;
    end
    else
      inherited;

  finally
    EnableForm;
  end;
end;

procedure TPayListingGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  ReportToPrint := '';
  if isTochooseTemplate then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      ReportToPrint := trim(dlgReportSelect.SelectedItems.Text);
  end;
  if ReportToPrint = '' then tcdatautils.GetDefaultReport(GetReportTypeID);
  if ReportToPrint = '' then ReportToPrint := 'Pay Cheque';
  IterateProcNo:= 1;
  IterateSelectedRecords;
end;

procedure TPayListingGUI.ebnDetailAfterExpand(Sender: TObject);
begin
  inherited;

  grdDetail.Width := grdMain.Width - 25;
  grdDetail.Height := grdMain.Height - 65;
end;

procedure TPayListingGUI.ebnDetailBeforeExpand(Sender: TObject);
begin
  inherited;

  qryDetail.Close;

  if chkIgnoreDates.Checked then begin
    qryDetail.Params.ParamByName('dtFrom').AsDateTime := 0;
    qryDetail.Params.ParamByName('dtTo').AsDateTime := SysUtils.MaxDateTime;
  end
  else begin
    qryDetail.Params.ParamByName('dtFrom').AsString := FormatDateTime(MysqlDateFormat, dtFrom.Date);
    qryDetail.Params.ParamByName('dtTo').AsString := FormatDateTime(MysqlDateFormat, dtTo.Date);
  end;

  //  SetDateFilter;

  qryDetail.ParamByName('empId').AsInteger := qryMainEmployeeID.AsInteger;

  qryDetail.Open;
end;

procedure TPayListingGUI.grdMainDblClick(Sender: TObject);
//var form: TBaseInputGUI;
begin
//  { form TfrmEmployeePay was not designed to have its keyid changed and
//    formshow called more than once (it crashes), also not designed to have
//    more than one instance open at a time!! ...
//    so always close existing instance before opening/re-showing new }
//  form:= TBaseInputGUI(FindExistingComponent('TfrmEmployeePay'));
//  if Assigned(form) then begin
//    form.Close;
//    Application.ProcessMessages;
//  end;
//  if not FormStillOpen('TfrmEmployeePay') then begin
    inherited;
//  end;
end;

procedure TPayListingGUI.SetupCustomFields;
var
  qry: TMyQuery;
  x: integer;
  xStr: string;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select * from tblcustomfields';
    qry.Open;
    for x:= 1 to 15 do begin
      xStr:= IntToStr(x);
      if qry.FieldByName('CFEmpl' + xStr).AsBoolean then begin
        qryMain.FieldByName('CUSTFLD' + xStr).DisplayLabel :=
          qry.FieldByName('CFLabel' + xStr).AsString;
      end
      else begin
        GuiPrefs.DbGridElement[grdMain].RemoveField('CUSTFLD' + xStr);
      end;
    end;
  finally
    qry.Free;
  end;
end;

initialization
  RegisterClassOnce(TPayListingGUI);
end.
