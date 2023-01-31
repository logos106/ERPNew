unit ProfitandLossPeriodReportBase;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 08/11/05  1.00.02 BJ   Advance printing implemented. Fields added for the
                        budget amounts too, if not required, should be removed
                        from the report. Seting the flag to FALSE in the scree
                        WILL NOT remove fields from the report.
                        Maximum 20 sets of amount fields available in the report ,
                        the rest will be ignored.
 21/12/05  1.00.03 BJ   Report with a defualt budget selected when called from the
                        budget section in the main menu
                        New field to show the %age of the actual amounts against to the
                        Total Amount
                        Lock the accountname and type when scrolling to the right side
 13/01/06  1.00.04 BJ   %age sign added for the Percentage field
                        Customise button is disabled.
                        An option added to hide and show the budget Variance field
 24/08/06 1.00.05  BJ   RefreshQuery is called twice from the formshow when the report is
                        calledfor budget, and so the message for the fromdate < closing
                        date is being displayed twice:Corrected.
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, ReportTransactionsTable, MyAccess,ERPdbComponents,
  DBAccess, MemDS, wwdbdatetimepicker, ProgressDialog, wwdblook,
   Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, ReportSQLProfitAndLossPeriod, DNMAction, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProfitLossPeriodBase = class(TBaseListingGUI)
    BitBtn1: TDNMSpeedButton;
    qryBudLines: TERPQuery;
    qryBudgets: TERPQuery;
    Label4: TLabel;
    chkBudget: TCheckBox;
    chkHidePercentage: TCheckBox;
    cbkFreezeAccountname: TCheckBox;
    chkHideVariance: TCheckBox;
    QryAccountTypes: TERPQuery;
    QryAccountTypesAccType: TWideStringField;
    QryAccountTypesForeignCurrencyRatetype: TWideStringField;
    lblREfreshInfo: TLabel;
    cboBudget: TwwDBLookupCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkBudgetClick(Sender: TObject);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure cmdPrintClick(Sender: TObject);
    procedure cbkFreezeAccountnameClick(Sender: TObject);
    procedure chkHidePercentageClick(Sender: TObject);
    procedure chkHideVarianceClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkIncludehistoryClick(Sender: TObject);
    procedure grdMainColWidthChanged(Sender: TObject; Column: Integer);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure qryBudgetsBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }

    ReportTransactionTableObj: TReportTransactionTableObj;

    fbonformshow:Boolean;
    FcOnReportCount: integer;
    procedure ClearColumns;
    procedure LabelChange;
    procedure SetVisibleColumns;
    procedure RefreshBudgetcombo(OnShow: boolean = false);
    Function getGridFieldcolumnNo :Integer;
    Procedure CreateTranstable;
    procedure MakeReportTable;
    procedure OnshowProfitandLossGUI(Sender: TObject);
    procedure MakeMainQryTablenSQL;
    procedure changeToDate(const Value: TDateTime);
    procedure initFCFields; Override;
  protected
    StringListForReportSQL: TStringList;
    Tablename :String;
    fStringListForSQL :TStringList;
    ColumnCount:Integer;
    amtPercent:double;
    reportCaption :String;
    Qrymaintablename :String;
    TransTableName :String;
    xDateFrom, xdateto:TDateTime;
    fifilterOption:integer;
    xshowBudget :boolean;
    xIncludehistory:Boolean;
    Procedure ToBeRefreshed;virtual;
    procedure RefreshQuery; override;
    function GetReportTypeID: integer; override;
    Procedure PopulateReportTable; override;

    {REPORT SPECIFIC}

    {FUNCTIONS TO SHARE}
    Procedure AddQuery(var str:String ; const Value:string );
    Function AddtotalFCField(AmountZero :Boolean = False ):String ;
    Function Othersfilter(Const sSortID:String):String;virtual;
    function DoDtFromChange(Sender:Tobject): boolean; override;
    function DoDtToChange(Sender: TObject): boolean; override;
    procedure RefreshAll;Override;
    Procedure DoRefreshQuery;virtual;
    function DoEmailIfToBeEmailed: boolean;Override;
    Procedure AddExtrafields(pColumn: pColumnRec);Virtual;
    function getColWidth(colPrefix: String): Integer; Virtual;
    function LstColumn :TList;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; override;
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,CommonDbLib,  DateUtils, StrUtils, TransAccountDetailsForm,
  ProfitandLossReportForm, AppContextObj, CommonLib, AppEnvironment,
  MySQLConst, CommonFormLib,  tcConst, ProfitnLosschart, SystemLib, (*ProfitandLossReportByPeriodCompare, *)DateTimeUtils, DNMLib,
  ProfitandLossPeriodCompare;

{$R *.dfm}

{ TProfitLossPeriodGUI }
procedure TProfitLossPeriodBase.RefreshBudgetCombo(OnShow: boolean = false);
var
  fibudgetId: integer;
begin
  fiBudgetId := 0;
  if qryBudgets.Active then if cboBudget.Text <> '' then
    fiBudgetId := qryBudgets.FieldByName('budgetId').AsInteger;
  if qryBudgets.Active then qryBudgets.Close;
  qryBudgets.Open;
  if (fiBudgetId <> 0 )and (qryBudgets.Locate('budgetId', fibudgetId, []))  then begin
     cbobudget.Text := qryBudgets.FieldByName('Name').AsString;
     chkBudget.Checked := true;
  end else {Set a default budget if recport called from budget}
  if AppContext['ProfitAndLoss'].VarExists('Budget') then if AppContext['ProfitAndLoss'].VarByname['Budget'] = 'T' then if OnShow then if qryBudgets.RecordCount > 0 then begin
          chkBudget.Checked := true;
          qryBudgets.First;
          cbobudget.Visible := true;
          cbobudget.Text := qryBudgets.FieldByName('Name').AsString;
        end;
end;

Function TProfitLossPeriodBase.getColWidth(colPrefix:String):Integer;
begin
  if GuiPrefs.Node.Exists('General.columnWidths.' +colPrefix) then
    result:= GuiPrefs.Node['General.columnWidths.' +colPrefix ].asInteger
  else result := 10;
end;
procedure TProfitLossPeriodBase.LabelChange;
var
  pColumn: pColumnRec;
  I, ColumnCount: integer;
  groupPrefix:String;
  FieldPrefix:String;

  Procedure Addforeigncurrencies;
  begin
        if FConReport.RecordCount = 0 then Exit;
        FConReport.First;
        while FConReport.Eof = False do begin
            AddGridSelectedfield(FCOnReportCode.asString + '_' + FieldPrefix +IntToStr(pColumn^.ColumnNo)  , 15, FCOnReportCode.asString , groupPrefix );
            if qrymain.findfield(FCOnReportCode.asString + '_' + FieldPrefix +IntToStr(pColumn^.ColumnNo)) <> nil then
                TFloatfield(qrymain.findfield(FCOnReportCode.asString + '_' + FieldPrefix +IntToStr(pColumn^.ColumnNo))).currency:= TRUE;
            FConReport.Next;
        end;
  end;
  Procedure AddforeigncurrencyTotal;
  begin
    if FConReport.RecordCount = 0 then Exit;
    FConReport.First;
    while FConReport.Eof = False do begin
        AddGridSelectedfield(FCOnReportCode.asString + '_totalamount'   , 15, FCOnReportCode.asString , groupPrefix );
        if qrymain.findfield(FCOnReportCode.asString + '_totalamount') <> nil then
            TFloatfield(qrymain.findfield(FCOnReportCode.asString + '_totalamount')).currency:= True;
        FConReport.Next;
    end;
  end;
begin
    for I:= 0 to (*20*)Qrymain.Fields.Count-1 do begin
        if Qrymain.findfield('amount_'      + IntToStr(I)) <> nil then TFloatfield(Qrymain.findfield('amount_'      + IntToStr(I))).currency := True;
        if Qrymain.findfield('amount1_'     + IntToStr(I)) <> nil then TFloatfield(Qrymain.findfield('amount1_'     + IntToStr(I))).currency := True;
        if Qrymain.findfield('amount1_V'    + IntToStr(I)) <> nil then TFloatfield(Qrymain.findfield('amount1_V'    + IntToStr(I))).currency := True;
        if Qrymain.findfield('amount2_'     + IntToStr(I)) <> nil then TFloatfield(Qrymain.findfield('amount2_'     + IntToStr(I))).currency := True;
        if Qrymain.findfield('amount2_v'    + IntToStr(I)) <> nil then TFloatfield(Qrymain.findfield('amount2_v'    + IntToStr(I))).currency := True;
        if Qrymain.findfield('change_'      + IntToStr(I)) <> nil then TFloatfield(Qrymain.findfield('change_'      + IntToStr(I))).currency := True;
    end;
    if Qrymain.findfield('totalAmount') <> nil then TFloatfield(Qrymain.findfield('totalAmount')).currency := True;
    FieldList := TStringList.Create;
    try
        ColumnCount := LstColumn.Count - 1;
        AddGridSelectedfield('AccountTypeDesc',getColWidth('AccountTypeDesc') , 'Account Type'  );
        AddGridSelectedfield('AccountName',getColWidth('AccountName'),'Account Name');
        for I := 0 to ColumnCount do begin
            groupPrefix := '';
            pColumn := LstColumn.Items[I];
            grdMain.TitleLines := 2;
            {if buget not selected}
            if (chkBudget.Checked = false) or (cboBudget.Text = '') then begin
                if ReportonForeignCurrency then begin
                    groupPrefix := pColumn^.ColumnName;
                    AddGridSelectedfield('Amount_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount_'),Appenv.RegionalOptions.ForeignExDefault,groupPrefix);
                    FieldPrefix :='Amount_';
                    Addforeigncurrencies;
                end else begin
                    AddGridSelectedfield('Amount_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount_'), 'Amount' , pColumn^.ColumnName );
                    if (I > 0) and (self is TProfitandLossPeriodCompareGUI) then begin
                      AddGridSelectedfield('Change_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Change_'), 'Change' , pColumn^.ColumnName );
                      AddGridSelectedfield('ChangePercent_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('ChangePercent_'), 'Change %' , pColumn^.ColumnName );
                    end;
                end;
                if (chkHidePercentage.Checked = false)  then begin
                    AddGridSelectedfield('Percentage_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Percentage_'),'Percentage on~Total'(* + pColumn^.ColumnName*) , pColumn^.ColumnName);
                    grdMain.TitleLines := 4;
                end;
            end;


            {when budget is selected}
            if chkBudget.Checked then
                if cboBudget.Text <> '' then begin
                    grdMain.titleLines := 3;
                    if ReportonForeignCurrency then begin
                        groupPrefix := 'Actual ' +pColumn^.ColumnName;
                        AddGridSelectedfield('Amount_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount_'),Appenv.RegionalOptions.ForeignExDefault ,groupPrefix);
                        FieldPrefix :='Amount_';
                        Addforeigncurrencies;
                    end else
                        AddGridSelectedfield('Amount_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount_'),'Actual~' + pColumn^.ColumnName );
                    if chkHidePercentage.Checked = false then
                        AddGridSelectedfield('Percentage_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Percentage_'),'Total~' + pColumn^.ColumnName , 'Percentage on');
                    {budget amount -1}
                    if qryBudgets.FieldByName('Showamount1').AsBoolean then begin
                        if ReportonForeignCurrency then begin
                            groupPrefix := 'Budget ' + pColumn^.ColumnName + ' ' +pColumn^.Amt1;
                            AddGridSelectedfield('Amount1_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),Appenv.RegionalOptions.ForeignExDefault ,groupPrefix);
                            FieldPrefix :='Amount1_';
                            Addforeigncurrencies;
                        end   else
                            AddGridSelectedfield('Amount1_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),'Budget~' + pColumn^.ColumnName + '~' + pColumn^.Amt1);

                        if chkHideVariance.Checked = false then begin
                            if ReportonForeignCurrency then begin
                                groupPrefix := 'Variance ' + pColumn^.ColumnName + ' ' + pColumn^.Amt1 ;
                                AddGridSelectedfield('Amount1_v' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),Appenv.RegionalOptions.ForeignExDefault,groupPrefix );
                                FieldPrefix :='Amount1_v';
                                Addforeigncurrencies;
                            end else
                                AddGridSelectedfield('Amount1_v' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),'Variance~' + pColumn^.ColumnName + '~' + pColumn^.Amt1 );
                        End;
                    End;
                    {budget amount -2}
                    if qryBudgets.FieldByName('Showamount2').AsBoolean then begin
                        if ReportonForeignCurrency then begin
                            groupPrefix := 'Budget ' +pColumn^.ColumnName + ' ' + pColumn^.Amt2;
                            AddGridSelectedfield('Amount2_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),AppEnv.RegionalOptions.ForeignExDefault ,groupPrefix );
                            FieldPrefix :='Amount2_';
                            Addforeigncurrencies;
                        end else
                            AddGridSelectedfield('Amount2_' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),'Budget~' + pColumn^.ColumnName + '~' + pColumn^.Amt2 );

                        if chkHideVariance.Checked = false then begin
                            if ReportonForeignCurrency then begin
                                groupPrefix := 'Variance ' +pColumn^.ColumnName+ ' ' + pColumn^.Amt2;
                                AddGridSelectedfield('Amount2_v' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),AppEnv.RegionalOptions.ForeignExDefault ,groupPrefix );
                                FieldPrefix :='Amount2_v';
                                Addforeigncurrencies;
                            end else
                                AddGridSelectedfield('Amount2_v' +IntToStr(pColumn^.ColumnNo) ,getColWidth('Amount'),'Variance~' + pColumn^.ColumnName + '~' + pColumn^.Amt2 );
                        end;
                    end;
                end;
                AddExtrafields(pColumn);
            end;

        if ReportonForeignCurrency then begin
            groupPrefix := 'Total Amount';
            AddGridSelectedfield('TotalAmount' ,getColWidth('TotalAmount'), AppEnv.RegionalOptions.ForeignExDefault , groupPrefix);
            AddforeigncurrencyTotal;
        end else begin
            AddGridSelectedfield('TotalAmount' ,getColWidth('TotalAmount'), 'Total Amount' );
        end;

        grdMain.Selected := FieldList;
        grdMain.ApplySelected;
    finally
        FreeAndNil(FieldList);
    end;
end;


function TProfitLossPeriodBase.LstColumn: TList;
begin
  Result := TReportSQLProfitAndLossBase(ReportSQLObj).LstColumn;
end;

procedure TProfitLossPeriodBase.RefreshQuery;
begin
  ReportSQLObj.DateFrom := filterDateFrom;
  ReportSQLObj.dateTo:= filterDateTo;
  if Searching then RefreshAll else ToBeRefreshed;
end;

Procedure TProfitLossPeriodBase.MakeMainQryTablenSQL;
begin
    TReportSQLProfitAndLossBase(ReportSQLObj).MakeMainQryTable;
    Qrymain.SQL.clear;
    Qrymain.SQL.add('Select * from ' +Qrymaintablename +' order by FinalOrder,AccountHeaderOrder,AccountSub1Order,AccountSub2Order ,AccountSub3Order,TotalAmount');
end;

procedure TProfitLossPeriodBase.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('General') then begin
      cbkFreezeAccountname.checked     := GuiPrefs.Node['General.FreezeAccountname'].AsBoolean;
      if cbkFreezeAccountname.checked then begin
        grdMain.FixedCols := 2;
      end
      else
        grdMain.FixedCols := 0;
      chkHidePercentage.checked := GuiPrefs.Node['General.HidePercentage'].AsBoolean;
      chkHideVariance.checked := GuiPrefs.Node['General.HideVariance'].AsBoolean;
    end;
end;

Procedure TProfitLossPeriodBase.RefreshAll;
begin
    ProcessingCursor(True);
    try
      showProgressbar(WAITMSG, 10);
      try
          stepProgressbar;
          if qryBudgets.active =false then begin
            qryBudgets.Connection := Qrymain.Connection;
            RefreshBudgetCombo(False);
          end;
          stepProgressbar;
          ReportSQLObj.DateFrom := filterDateFrom;
          ReportSQLObj.dateTo:= filterDateTo;

               if grpfilters.itemindex = 0 then  TReportSQLProfitAndLossBase(ReportSQLObj).PeriodType := ptMonth
          else if grpfilters.itemindex = 1 then  TReportSQLProfitAndLossBase(ReportSQLObj).PeriodType := pt2month
          else if grpfilters.itemindex = 2 then  TReportSQLProfitAndLossBase(ReportSQLObj).PeriodType := ptQuarter
          else if grpfilters.itemindex = 3 then  TReportSQLProfitAndLossBase(ReportSQLObj).PeriodType := pt6Month
          else TReportSQLProfitAndLossBase(ReportSQLObj).PeriodType := ptYear;

          stepProgressbar;

          //ProcessingCursor(True);
          //try
            FcOnReportCount:= FcOnReport.RecordCount;
            stepProgressbar;
            PopulateReportTable;
            stepProgressbar;
            qrymain.fields.clear;
            MakeMainQryTablenSQL;
            stepProgressbar;
            DoRefreshQuery;
            stepProgressbar;

            SetVisibleColumns;
            GroupFilterString := 'HideTotal=' + QuotedStr('T');
            self.ApplyQueryFilter;
            LabelChange;
        finally
          HideProgressbar;
        end;
        if ((not (fbonformshow)) and  (not (dtFrom.DroppedDown)) and (dtFrom.DateTime < IncDay(AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)))) and ( IncludedataPriorToClosingDate = False) then begin
          CommonLib.MessageDlgXP_Vista('The From Date Selected Is Prior To The Closing Date.' + #13 + #10 + #13 + #10 +
            ' - All Transactions Prior To This Date Are Summarised ' + #13 + #10 +
            '    to One Entry On This Date.' + #13 + #10 + #13 + #10 +
            ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)),
            mtInformation, [mbOK], 0);
        end;
      finally
        ProcessingCursor(False);
        xDateFrom := filterdatefrom;
        xdateTo   := Filterdateto;
        fifilterOption := grpfilters.itemindex;
        xshowBudget :=chkBudget.checked;
        xIncludehistory := IncludedataPriorToClosingDate;
        ToBeRefreshed;
      end;
end;

procedure TProfitLossPeriodBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if ErrorOccurred then Exit;
end;

function TProfitLossPeriodBase.DoDtFromChange(Sender:TObject): boolean;
begin
  result:= false;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) or (Screen.activecontrol <> sender) then Exit;
  if not (dtFrom.DroppedDown) then begin
    RefreshBudgetCombo;
    RefreshQuery;
    result:= true;
  end;
end;

function TProfitLossPeriodBase.DoDtToChange(Sender:TObject): boolean;
begin
  result:= false;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) or (Screen.activecontrol <> sender) then Exit;
  if not (dtTo.DroppedDown) then begin
    RefreshBudgetCombo;
    RefreshQuery;
    result:= true;
  end;
end;
procedure TProfitLossPeriodBase.DoRefreshQuery;
begin
  inherited RefreshQuery;
end;

procedure TProfitLossPeriodBase.dtFromChange(Sender: TObject);
begin
  dtFrom.OnChange := nil;
  try
    if (grpFilters.itemindex = 2) and (dtFrom.Date <> GetCurrentFiscalYearStart(dtFrom.Date)) then begin dtFrom.Date := GetCurrentFiscalYearStart(dtFrom.Date)   ; TimerMsg(FilterLabel , 'Report is selected to view ''Yearly'', date is changed to the Start of the year');
    end else if (grpFilters.itemindex = 1) and (dtFrom.Date <> StartOfTheQuarter(dtFrom.Date))  then begin dtFrom.Date := StartOfTheQuarter(dtFrom.Date); TimerMsg(FilterLabel , 'Report is selected to view ''Quarterly'', date is changed to the Start of the quarter');
    end else if (grpFilters.itemindex = 0) and (dtFrom.Date <> StartOfTheMonth(dtFrom.Date))    then begin dtFrom.Date := StartOfTheMonth(dtFrom.Date)  ; TimerMsg(FilterLabel , 'Report is selected to view ''Monthly'', date is changed to the Start of the Month');
    end;
  finally
    dtFrom.OnChange := dtFromChange;
  end;
  inherited;
end;

procedure TProfitLossPeriodBase.dtToChange(Sender: TObject);
begin
  dtTo.OnChange := nil;
  try
    if (grpFilters.itemindex = 2) and (dtFrom.Date <> (IncYear(GetCurrentFiscalYearStart(dtTo.Date),1) -1))     then begin dtTo.Date := IncYear(GetCurrentFiscalYearStart(dtTo.Date),1) -1; TimerMsg(FilterLabel , 'Report is selected to view ''Yearly'', date is changed to the End of the year');
    end else if (grpFilters.itemindex = 1) and (dtFrom.Date <> EndOfTheQuarter(dtTo.Date))  then begin dtTo.Date := EndOfTheQuarter(dtTo.Date);TimerMsg(FilterLabel , 'Report is selected to view ''Quarterly'', date is changed to the End of the Quarter');
    end else if (grpFilters.itemindex = 0) and (dtFrom.Date <> EndOfTheMonth(dtTo.Date))    then begin dtTo.Date := EndOfTheMonth(dtTo.Date)  ;TimerMsg(FilterLabel , 'Report is selected to view ''Monthly'', date is changed to the End of the month');
    end;
  finally
    dtTo.OnChange := dtToChange;
  end;
  inherited;
end;

Procedure TProfitLossPeriodBase.MakeReportTable;
begin
  TransTableName := TReportSQLProfitAndLossBase(ReportSQLObj).TransTableName;//commondbLib.CreateUserTemporaryTable(TABLE_PROFITANDLOSSREPORT , 'period');
end;
Procedure TProfitLossPeriodBase.PopulateReportTable;
begin
  ReportSQLObj.Prepareforreport;
end;

procedure TProfitLossPeriodBase.qryBudgetsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryBudgets.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  qryBudgets.ParamByName('Dateto').AsDateTime := filterDateto;
end;

Procedure TProfitLossPeriodBase.CreateTranstable;
begin
  MakeReportTable;
end;

procedure TProfitLossPeriodBase.FormCreate(Sender: TObject);
begin
  grpFilters.items.clear;
  grpFilters.items.Add(Month1);
  grpFilters.items.Add(Months2);
  grpFilters.items.Add(Months3);
  grpFilters.items.Add(Months6);
  grpFilters.items.Add(Months12);

  fbIncludehistory:= True;
  fStringListForSQL := TStringList.Create;
  amtPercent              := 0;
  IsGridcustomisable      := false;
  CanCreatecustomReport   := False;
  ReportonForeignCurrency := true;
  Qrymaintablename        := TReportSQLProfitAndLossBase(ReportSQLObj).Qrymaintablename;//GetUserTemporaryTableName('tmp_PL'+Self.Classname);
  inherited;
  fbonformshow :=   False;
  if ErrorOccurred then Exit;
  fbIgnoreAccessLevels := true;
  ReportTransactionTableObj := TReportTransactionTableObj.Create(True);
  CreateTransTable;
  ShowChartViewOnPopup := True;
  NonSearchReport := True;
  if assigned(fReportSQLObj) then
    fReportSQLObj.OnChangeToDate := changeToDate;
end;
procedure TProfitLossPeriodBase.changeToDate(const Value:TDateTime);
begin
  dtto.Date := Value;
  MessageDlgXP_Vista('Date Range and the options selected will make too many columns for the report.' +NL+'The Date  Range is automatically adjusted.', mtInformation, [mbOK], 0);
end;
procedure TProfitLossPeriodBase.grpFiltersClick(Sender: TObject);
begin
  dtFromChange(dtfrom);  dtToChange(dtto); // this is to make sure the date range is selected according to the option
  TReportSQLProfitAndLossBase(ReportSQLObj).periodtype := InttoPeriodtype(grpFilters.itemindex);
  if Assigned(Screen.Activecontrol) and Assigned(Screen.Activecontrol.Parent) then
    if Screen.Activecontrol.Parent.Name <> grpFilters.Name then Exit;
  inherited;
  RefreshQuery;
end;
procedure TProfitLossPeriodBase.initFCFields;
begin
  inherited;
  ReportonForeignCurrency:= TRue;
end;

Function TProfitLossPeriodBase.getGridFieldcolumnNo:Integer ;
var
    fsFieldName :STring;
begin
    Result := -1;
    fsFieldName := grdMain.GetActiveField.FieldName;
    if  FastFuncs.PosEx('_', fsFieldName)<> 0 then begin
        while FastFuncs.PosEx('_', fsFieldName)<> 0 do
            fsFieldName := Trim(copy(fsFieldName ,FastFuncs.PosEx('_', fsFieldName)+1 , char_length(fsFieldName)));
    end else fsFieldName := '';
    if fsFieldName <> '' then begin
        if uppercase(copy(fsFieldName,1,1)) = 'V' then fsFieldName := copy(fsFieldName , 2, char_length(fsFieldName));
        Try
            Result := FastFuncs.StrToInt(fsFieldName)-1;
        Except
            Result := -1;
        end;
    end;
end;

procedure TProfitLossPeriodBase.grdMainDblClick(Sender: TObject);
var
  sTitles,sFilter,  sSortID, sAccName: string;
  frmTransAccountDetails: TComponent;
  ficolumnNo :Integer;
    pColumn: pColumnRec;

begin
  sFilter := '';
  sSortID := '';
  sAccName := '';
  sTitles := '';

  sSortID := Trim(qryMain.FieldByName('AccountType').AsString);
  sAccName := Trim(qryMain.FieldByName('AccountName').AsString);
  sTitles := Trim(qryMain.FieldByName('AccountTypeDesc').AsString);


  fiColumnNo := getGridFieldcolumnNo;

  if not (Empty(sSortID) and Empty(sAccName) and Empty(sTitles)) then begin
    if not FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
      if Assigned(frmTransAccountDetails) then begin
        with  TTransAccountDetailsGUI(frmTransAccountDetails) do begin
          ToDate := self.dtTo.DateTime;
          FromDate := self.dtFrom.DateTime;
          fbDateRangeSupplied := true;
          InverseCreditvsDebits := True;
          if Sysutils.SameText(sAccname , 'Others') then begin
            sFilter := Othersfilter(sSortID);
            if sfilter = '' then exit;
          end else if AnsiContainsText(sSortID, 'INC') and Empty(sAccName) then begin
            sFilter := '(AccountType = "EXINC" OR AccountType = "INC")';
          end else if AnsiContainsText(sSortID, 'INC') and not Empty(sAccName) then begin
            sFilter := '(AccountType = "EXINC" OR AccountType = "INC") AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sSortID, 'COGS') and Empty(sAccName) then begin
            sFilter := 'AccountType = "COGS"';
          end else if AnsiContainsText(sSortID, 'COGS') and not Empty(sAccName) then begin
            sFilter := 'AccountType = "COGS" AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sSortID, 'EXP') and Empty(sAccName) then begin
            sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP")';
          end else if AnsiContainsText(sSortID, 'EXP') and not Empty(sAccName) then begin
            sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP") AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sTitles, 'Net Income') and Empty(sAccName) then begin
            sFilter :=
              '((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")';
          end else if AnsiContainsText(sTitles, 'Gross Profit') and Empty(sAccName) then begin
            sFilter :=
              '(AccountType = "COGS" OR (AccountType = "EXINC" OR AccountType = "INC"))';
          end else if (Trim(Self.Qrymain.FieldByName('AccountSub3Order').AsString) <> '') and (Trim(Self.Qrymain.FieldByName('AccountSub3Order').AsString) <> 'ZZZZZZZZZZZZ') then begin
            sFilter := 'COALevel4 = ' + QuotedStr(Trim(Self.Qrymain.FieldByName('AccountSub3Order').AsString));
          end else if (Trim(Self.Qrymain.FieldByName('AccountSub2Order').AsString) <> '') and (Trim(Self.Qrymain.FieldByName('AccountSub2Order').AsString) <> 'ZZZZZZZZZZZZ') then begin
            sFilter := 'COALevel3 = ' + QuotedStr(Trim(Self.Qrymain.FieldByName('AccountSub2Order').AsString));
          end else if (Trim(Self.Qrymain.FieldByName('AccountSub1Order').AsString) <> '') and (Trim(Self.Qrymain.FieldByName('AccountSub1Order').AsString) <> 'ZZZZZZZZZZZZ') then begin
            sFilter := 'COALevel2 = ' + QuotedStr(Trim(Self.Qrymain.FieldByName('AccountSub1Order').AsString));
          end else if (Trim(Self.Qrymain.FieldByName('AccountHeaderOrder').AsString) <> '') and (Trim(Self.Qrymain.FieldByName('AccountHeaderOrder').AsString) <> 'ZZZZZZZZZZZZ') then begin
            sFilter := 'COALevel1 = ' + QuotedStr(Trim(Self.Qrymain.FieldByName('AccountHeaderOrder').AsString));
          end;
          if sFilter <> '' then begin
            qryMain.SQL.Add('AND ' + sFilter + ' Group by TransID;');
            WhereString := 'AND (' + sFilter + ')';
          end else begin
            qryMain.SQL.Add( ' Group by TransID;');
            WhereString := '';
          end;

          {change the list date if called for a period field }
          if fiColumnNo >= 0 then begin
              pColumn := LstColumn.Items[fiColumnNo];
              if dateof(pColumn^.ColumnFrom) < self.dtFrom.date then
                TTransAccountDetailsGUI(frmTransAccountDetails).FromDAte := self.dtFrom.date
              else
                TTransAccountDetailsGUI(frmTransAccountDetails).FromDAte := dateof(pColumn^.ColumnFrom);
              if  dateof(pColumn^.columnto) > self.dtTo.date then
                TTransAccountDetailsGUI(frmTransAccountDetails).ToDate := self.dtTo.date
              else
              TTransAccountDetailsGUI(frmTransAccountDetails).ToDate := dateof(pColumn^.columnto);
          end;

          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      frmTransAccountDetails := FindExistingComponent('TTransAccountDetailsGUI');
      fbDateRangeSupplied := true;
      TForm(frmTransAccountDetails).Show;
    end;
  end;
end;

procedure TProfitLossPeriodBase.FormDestroy(Sender: TObject);
begin
  if not ErrorOccurred then begin
    ClearColumns;
    FreeandNil(ReportTransactionTableObj);
  end;
  FreeAndNil(StringListForReportSQL);
  fStringListForSQL.Free;
  inherited;
end;

procedure TProfitLossPeriodBase.ClearColumns;
begin
  TReportSQLProfitAndLossBase(ReportSQLObj).ClearColumns;
end;

procedure TProfitLossPeriodBase.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not qryMain.Active then Exit;
  if (qryMain.FieldByName('AccountID').AsString = '0') then
  if not(Sysutils.SameText(Qrymain.fieldbyname('AccountName').asString , 'Others')) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
  if (FastFuncs.posex('AMOUNT1_V' , uppercase(Field.fieldname) ) <> 0) or
        (FastFuncs.posex('AMOUNT2_V' , uppercase(Field.fieldname) ) <> 0)    then
            AFont.Color := clMaroon;

  if (FastFuncs.posex(uppercase('amount_') , uppercase(Field.fieldname) ) <> 0) or
      (FastFuncs.posex(uppercase('amount1_') , uppercase(Field.fieldname) ) <> 0) or
      (FastFuncs.posex(uppercase('amount2_') , uppercase(Field.fieldname) ) <> 0) or
      (FastFuncs.posex(uppercase('totalamount') , uppercase(Field.fieldname) ) <> 0)  then
        if field.Asfloat = 0 then
          {0 should be displayed for the income tax}
            AFont.Color := Abrush.color;

  if FastFuncs.PosEx(uppercase('Percentage') , uppercase(Field.fieldname) ) <> 0  then begin
    if Qrymain.fieldByname('HidePercentage').asString = 'T' then AFont.Color := Abrush.color;
  end;
end;

procedure TProfitLossPeriodBase.SetVisibleColumns;
var
  pColumn: pColumnRec;
  I, ColumnCount: integer;
begin
  for I := 0 to qryMain.FieldCount - 1 do begin
    qryMain.Fields[I].Visible := false;
  end;
  grdMain.ControlType.Clear;
  qryMain.FieldByName('AccountTypeDesc').Visible := true;
  qryMain.FieldByName('AccountName').Visible := true;
  ColumnCount := LstColumn.Count - 1;
  for I := 0 to ColumnCount do begin
    pColumn := LstColumn.Items[I];
    qryMain.FieldByName('Amount_' +IntToStr(pColumn^.ColumnNo)).Visible := true;
    qryMain.FieldByName('Amount_' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
    qryMain.FieldByName('Percentage_' +IntToStr(pColumn^.ColumnNo)).Visible := true;
    qryMain.FieldByName('Percentage_' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
    if I > 0 then begin
      qryMain.FieldByName('Change_' +IntToStr(pColumn^.ColumnNo)).Visible := true;
      qryMain.FieldByName('Change_' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
      qryMain.FieldByName('ChangePercent_' +IntToStr(pColumn^.ColumnNo)).Visible := true;
      qryMain.FieldByName('ChangePercent_' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
      TFloatField(qryMain.FieldByName('ChangePercent_' +IntToStr(pColumn^.ColumnNo))).DisplayFormat := '0%;(0%)';
    end;

    if chkBudget.Checked then if cboBudget.Text <> '' then begin
        qryMain.FieldByName('Amount1_' +IntToStr(pColumn^.ColumnNo)).Visible := true;
        qryMain.FieldByName('Amount1_' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
        qryMain.FieldByName('Amount1_v' +IntToStr(pColumn^.ColumnNo)).Visible := true;
        qryMain.FieldByName('Amount1_v' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;

        qryMain.FieldByName('Amount2_' +IntToStr(pColumn^.ColumnNo)).Visible := true;
        qryMain.FieldByName('Amount2_' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
        qryMain.FieldByName('Amount2_v' +IntToStr(pColumn^.ColumnNo)).Visible := true;
        qryMain.FieldByName('Amount2_v' +IntToStr(pColumn^.ColumnNo)).Alignment := taRightJustify;
      end;
  end;
  qryMain.FieldByName('TotalAmount').Visible := true;
  qryMain.FieldByName('TotalAmount').Alignment := taRightJustify;

  qryMain.FieldByName('FinalOrder').Visible := False;
  qryMain.FieldByName('AccountHeaderOrder').Visible := False;
  qryMain.FieldByName('AccountSub1Order').Visible := False;
  qryMain.FieldByName('AccountSub2Order').Visible := False;
  qryMain.FieldByName('AccountSub3Order').Visible := False;
  qryMain.FieldByName('HideTotal').Visible := False;

  grdMain.RemoveField('FinalOrder');
  grdMain.RemoveField('AccountHeaderOrder');
  grdMain.RemoveField('AccountSub1Order');
  grdMain.RemoveField('AccountSub2Order');
  grdMain.RemoveField('AccountSub3Order');
  grdMain.RemoveField('HideTotal');
end;

procedure TProfitLossPeriodBase.ToBeRefreshed;
begin
  lblREfreshInfo.visible := ( xDateFrom <> filterdatefrom) or
              (xdateTo   <> Filterdateto) or
              (xshowBudget <> chkBudget.checked) or
              (xIncludehistory <> IncludedataPriorToClosingDate) or
              (fifilterOption <> grpfilters.itemindex) or
              (FcOnReportCount <> FcOnReport.RecordCount);
end;

procedure TProfitLossPeriodBase.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.FreezeAccountname'].AsBoolean  := cbkFreezeAccountname.checked;
  if cbkFreezeAccountname.checked then begin
    GuiPrefs.Node['General.ColWidths.C1'].AsInteger := grdMain.ColWidths[1];
    GuiPrefs.Node['General.ColWidths.C2'].AsInteger := grdMain.ColWidths[2];
  end;
  GuiPrefs.Node['General.HidePercentage'].AsBoolean     := chkHidePercentage.checked;
  GuiPrefs.Node['General.HideVariance'].AsBoolean       := chkHideVariance.checked;
end;

procedure TProfitLossPeriodBase.BitBtn1Click(Sender: TObject);
begin
  OpenERPListForm('TProfitandLossGUI' , OnshowProfitandLossGUI);
  Self.Close;
end;
procedure TProfitLossPeriodBase.OnshowProfitandLossGUI(Sender:TObject);
begin
  if TProfitandLossGUI(Sender).dtTo.DateTime   <> self.dtTo.DateTime   then TProfitandLossGUI(Sender).dtTo.DateTime   := self.dtTo.DateTime;
  if TProfitandLossGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TProfitandLossGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
  TProfitandLossGUI(Sender).fbDateRangeSupplied := true;
  TProfitandLossGUI(Sender).fbIncludehistory    := fbIncludehistory;
  TProfitandLossGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
end;
procedure TProfitLossPeriodBase.FormShow(Sender: TObject);
begin
  inherited;
  fbonformshow := True;
  GuiPrefs.Active := false;
  if AppContext['ProfitAndLoss'].VarExists('Budget') then AppContext.DeleteContext('ProfitAndLoss');
  fbonformshow := False;
  chkHideVariance.Enabled := chkBudget.Checked;

  refreshall;

  if cbkFreezeAccountname.checked then begin
    if GuiPrefs.Node['General.ColWidths.C1'].AsInteger > 0 then
      grdMain.ColWidths[1] := GuiPrefs.Node['General.ColWidths.C1'].AsInteger;
    if GuiPrefs.Node['General.ColWidths.C2'].AsInteger > 0 then
      grdMain.ColWidths[2] := GuiPrefs.Node['General.ColWidths.C2'].AsInteger;
  end;
end;

procedure TProfitLossPeriodBase.cboBudgetCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Screen.Activecontrol.Name <> cbobudget.Name then Exit;
  RefreshQuery;
end;

procedure TProfitLossPeriodBase.chkBudgetClick(Sender: TObject);
begin
  inherited;
  if Screen.Activecontrol.Name <> chkBudget.Name then Exit;
  cboBudget.Visible := chkBudget.Checked;

  if chkBudget.Checked = false then RefreshQuery
  else if cboBudget.Text <> '' then RefreshQuery;

  chkHideVariance.Enabled := chkBudget.Checked;
end;

procedure TProfitLossPeriodBase.grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if (FastFuncs.posex('AMOUNT1_V' , uppercase(AFieldName) ) <> 0) or
        (FastFuncs.posex('AMOUNT2_V' , uppercase(AFieldName) ) <> 0)    then
            AFont.Color := clMaroon;

end;

procedure TProfitLossPeriodBase.grdMainColWidthChanged(Sender: TObject; Column: Integer);
const
  ColumnstoAdjustwidth : Array [1..6] of string = ('Amount_' , 'Percentage_' ,'TotalAmount',  'Amount' , '_amt', '_Percent');
var
  ctr:Integer;
begin
  inherited;
  for ctr:= low(ColumnstoAdjustwidth) to high(ColumnstoAdjustwidth) do
    if StartsText(ColumnstoAdjustwidth[ctr] , grdmain.Columns[column-1].fieldname) then begin
      GuiPrefs.Node['General.columnWidths.' + ColumnstoAdjustwidth[ctr] ].asInteger := grdmain.Columns[column-1].displaywidth;
      Labelchange;
      Exit;
    end;

  for ctr:= low(ColumnstoAdjustwidth) to high(ColumnstoAdjustwidth) do
    if EndsText(ColumnstoAdjustwidth[ctr], grdmain.Columns[column-1].fieldname  ) then begin
      GuiPrefs.Node['General.columnWidths.' + ColumnstoAdjustwidth[ctr] ].asInteger :=grdmain.Columns[column-1].displaywidth;
      Labelchange;
      Exit;
    end;

  GuiPrefs.Node['General.columnWidths.' + grdmain.Columns[column-1].fieldname ].asInteger :=grdmain.Columns[column-1].displaywidth;
end;

function TProfitLossPeriodBase.GetReportTypeID: integer;
begin
  Result := 76;
end;

procedure TProfitLossPeriodBase.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
  if chkAdvancedPrinting.checked then begin
    ReportSQLSupplied := true;
    UseStringListForSQL := false;
    try
      TemplateSQL := '';
      TemplateSQL := TReportSQLProfitAndLossBase(ReportSQLObj).ReportSQL;
      inherited;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
      TemplateSQL         := '';
    end;
  end else begin
    inherited;
  end;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossPeriodBase.cbkFreezeAccountnameClick(Sender: TObject);
begin
  inherited;
  if not(Screen.activecontrol = cbkFreezeAccountname) then exit;

  if cbkFreezeAccountname.Checked then begin
    grdMain.SelectedField := qryMain.Fields[3];
    grdMain.FixedCols     := 2;
  end else begin
    grdMain.FixedCols := 0;
  end;

end;

procedure TProfitLossPeriodBase.chkHidePercentageClick(Sender: TObject);
begin
  inherited;
  LabelChange;
end;

procedure TProfitLossPeriodBase.chkHideVarianceClick(Sender: TObject);
begin
  inherited;
  LabelChange;
end;

procedure TProfitLossPeriodBase.chkIncludehistoryClick(Sender: TObject);
begin
  inherited;
  TReportSQLProfitAndLossBase(ReportSQLObj).IncludedataPriorToClosingDate := chkIncludehistory.checked;
  ToBeRefreshed;
end;

procedure TProfitLossPeriodBase.actRefreshQryExecute(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;
  RefreshAll;
end;

procedure TProfitLossPeriodBase.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossPeriodBase.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossPeriodBase.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


procedure TProfitLossPeriodBase.AddExtrafields(pColumn: pColumnRec);
begin
// descendants will override if requered
end;

Procedure TProfitLossPeriodBase.AddQuery(var str:String ; const Value:string );begin str:= str+value;end;

Function TProfitLossPeriodBase.AddtotalFCField(AmountZero :Boolean = False ):String ;
var strSQL:String;
begin
  strSQL:= '';
  if FConReport.RecordCount > 0 then begin
      FCOnReport.First;
      while FConReport.Eof = False do begin
          if AmountZero then
              AddQuery(strSQL,'  0 as ' + FCOnReport.FieldByname('Code').asString + '_totalAmount,')
          else
              AddQuery(strSQL,' sum(' + FCOnReport.FieldByname('Code').asString + '_totalAmount),');
          FCOnReport.Next;
      End;
  End;
  result := strSQL;
end;
function TProfitLossPeriodBase.Othersfilter(const sSortID: String): String;
begin
  Result  := '';
end;

procedure TProfitLossPeriodBase.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= not self.ReportTransactionTableObj.DoingRefresh;
end;
function TProfitLossPeriodBase.DoEmailIfToBeEmailed:boolean;
begin
  DisableForm;
  try
    ReportSQLSupplied := true;
    UseStringListForSQL := false;
    try
      TemplateSQL := TReportSQLProfitAndLossBase(ReportSQLObj).ReportSQL;
      result:= inherited DoEmailIfToBeEmailed;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

end.









