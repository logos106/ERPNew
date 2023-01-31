unit ProfitandLossSummaryReport;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/11/05  1.00.01 BJ   Implemented the advance Printing option
                        New template type created - profit and loss - sumary
                        and the advance printing lists all the reports of the type
                        to choose from
 27/03/06  1.00.02 DSP  Advanced printing check box is now hidden and the
                        pnlAdvPrinting panel is always shown.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, ReportTransactionsTable, MyAccess,ERPdbComponents, MemDS,
  DBAccess, wwdbdatetimepicker,
  MessageConst, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProfitLossSummaryGUI = class(TBaseListingGUI)
    qryMainPeriod: TWideStringField;
    qryMainYear: TIntegerfield;
    lblREfreshInfo: TLabel;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkIncludehistoryClick(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
  private
    { Private declarations }
    ReportTransactionTableObj: TReportTransactionTableObj;
//    PrevDateTo: TDateTime;
//    PrevDateFrom: TDateTime;
    SQLString: string;
    FCFields :String;
    fstablename :String;
    PeriodName: string;
    xdatefrom, xdateTo:TDateTime;
    function GetUserTempPLSummaryName: string;
    procedure CreateTempPLSummaryTable;
    procedure AddDataToTempPLSummaryTable;
    procedure LabelChange;
    Procedure CreateTranstable;
    Procedure ToBeRefreshed;


  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;
    Procedure PopulateReportTable; override;
//    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
    procedure RefreshAll;Override;
  public

    { Public declarations }
  end;


implementation

uses FastFuncs,CommonDbLib,  DateUtils, AppEnvironment, CommonLib, MySQLConst,
  tcConst;

{$R *.dfm}

{ TProfitLossSummaryGUI }

procedure TProfitLossSummaryGUI.actRefreshQryExecute(Sender: TObject);
begin
  RefreshAll;

end;

procedure TProfitLossSummaryGUI.AddDataToTempPLSummaryTable;
var
  InsertSQL: string;
  qryTemp: TERPCommand;
  QueryList :TStringlist;
  ctr :Integer;
  function TransTablename(Loopno :Integer):String;
  begin
    if ctr= 1 then result := 'tbltransactions' else result := 'tbltransactionsummarydetails';
  end;
begin
  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + fsTablename + '(Date,';
    if ActiveClasses.recordcount > 0 then begin
        ActiveClasses.first;
        While ActiveClasses.eof = false do begin
            insertSQl := InsertSQL + '`' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumn`,' ;
            ActiveClasses.Next;
        end;
    end;
    insertSQl := InsertSQL + '`TotalAmount`,' ;
    InsertSQL := InsertSQL + 'FilterDate,FilterWeekday,FilterWeekdayNumber,FilterWeekNumber,FilterMonthNumber,FilterMonthName,' +
    'FilterQuarterNumber,FilterYEAR ';
    if FCFields <> '' then InsertSQL := InsertSQL + ',' +FCFields;
    InsertSQL := InsertSQL + ')' ;
    QueryList :=TStringlist.create;
    ReportTransactionTableObj.GetClasses;
    TRy
          QueryList.Add('Delete from ' + fstablename + ';');

          for ctr:= 1 to 2 do begin
            if (ctr=1) or ((IncludedataPriorToClosingDate) and (dtfrom.Date < appenv.CompanyPrefs.SummarisedTransDate))  then begin
              QueryList.Add(InsertSQL);
              QueryList.Add('SELECT Min(Date) as Date, ');

                if ActiveClasses.recordcount > 0 then begin
                    ActiveClasses.first;
                    While ActiveClasses.eof = false do begin
                        QueryList.Add('If(ClassID=' + IntToStr(ActiveClasses.FieldByname('ClassId').asInteger) +
                         '  ,-(TRUNCATE(Sum(DebitsEx)+0.001,2)-TRUNCATE(Sum(CreditsEx)+0.001,2)),0.00),');
                        ActiveClasses.Next;
                    end;
                end;
              QueryList.Add('-(TRUNCATE(Sum(DebitsEx)+0.001,2)-TRUNCATE(Sum(CreditsEx)+0.001,2)) as TotalAmount , ');
              QueryList.Add('Date as FilterDate,');
              QueryList.Add('DAYNAME(Date) as FilterWeekday,');
              QueryList.Add('WEEKDAY(Date) as FilterWeekdayNumber,');
              QueryList.Add('WEEK(Date,3)  AS FilterWeekNumber,');
              QueryList.Add('MONTH(Date) as FilterMonthNumber,');
              QueryList.Add('MONTHNAME(Date) as FilterMonthName,');
              QueryList.Add('QUARTER(Date) AS FilterQuarterNumber,');
              QueryList.Add('YEAR(Date) AS FilterYEAR ');
              if FCfields <> '' then
                QueryList.Add(',' + FCFields);
              QueryList.Add('FROM ' +Transtablename(ctr)+'  as Trans  ');
              QueryList.Add('WHERE (AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
              QueryList.Add('AND Date Between ' + Quotedstr(FormatDateTime(MysqlDateFormat, dtfrom.DateTime)) +  ' AND ' + Quotedstr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)) + '  ');
              if (ctr=1) and (IncludedataPriorToClosingDate)  then QueryList.Add('AND Trans.Type <> "Closing Date Summary"');
              QueryList.Add('GROUP BY TransID ;');
            end;
          end;


          if FConReport.RecordCount > 0 then begin
            QueryList.Add(' update ' + fsTablename + ' Set ');
            FCOnReport.first;
            while FConReport.Eof = False do begin
                for ctr := low(Amountfields) to high(Amountfields) do begin
                    if (FConReport.recno>1) or (ctr > low(Amountfields)) then QueryList.add(',');
                    QueryList.Add('`'+FCOnReportCode.asString + '_' + AmountFields[ctr] + '` = `' +amountfields[ctr] +  '` * `' + FCOnReportCode.asString + '_FCRate`');
                end;
                FCOnReport.Next;
            end;
          end;


        qryTemp := TERPCommand.Create(nil);
        qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryTemp.Sql.text := ChangeQuery(querylist.text);
          qryTemp.Execute;
        finally
          FreeAndNil(qryTemp);
        end;
    Finally
        ReportTransactionTableObj.ClearClasses;
        freeandnil(QueryList);
    end;
end;


procedure TProfitLossSummaryGUI.LabelChange;
  Procedure Addforeigncurrencies;
  begin
        if FConReport.RecordCount = 0 then Exit;
        FConReport.First;
        while FConReport.Eof = False do begin
            AddGridSelectedfield(FCOnReportCode.asString + '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_Amountcolumn' ,10 , FCOnReportCode.asString , 'Income Amount(' + ActiveClasses.fieldbyname('classname').asString  +')' );
            if qrymain.findfield(FCOnReportCode.asString + '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_Amountcolumn' ) <> nil then
                TFloatfield(Qrymain.findfield(FCOnReportCode.asString + '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_Amountcolumn')).displayformat :=FConReportSymbol.asString +DOUBLE_FIELD_MASK;
            FConReport.Next;
        end;
  end;
  Procedure AddforeigncurrencyTotal;
  begin
        if FConReport.RecordCount = 0 then Exit;
        FConReport.First;
        while FConReport.Eof = False do begin
            AddGridSelectedfield(FCOnReportCode.asString + '_totalamount'   , 15, FCOnReportCode.asString , 'Total Amount' );
            if qrymain.findfield(FCOnReportCode.asString + '_totalamount') <> nil then
                TFloatfield(qrymain.findfield(FCOnReportCode.asString + '_totalamount')).displayformat :=FConReportSymbol.asString +DOUBLE_FIELD_MASK;
            FConReport.Next;
        end;
  end;
begin
    if grdmain.titlelines<2 then grdmain.titlelines := 2;
    FieldList := TStringList.Create;
    try
        AddGridSelectedfield('Period',10 , PeriodName );
        if grpFilters.ItemIndex < 5 then AddGridSelectedfield('Year',10 , 'Year' );
        if ActiveClasses.recordcount > 0 then begin
            ActiveClasses.First;
            while ActiveClasses.Eof = False do begin
                if ReportonForeignCurrency then begin
                    AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumn',10 ,Appenv.RegionalOptions.ForeignExDefault,  'Income Amount(' + ActiveClasses.fieldbyname('classname').asString  +')' );
                    TFloatfield(Qrymain.findField((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumn')).currency := true;
                    Addforeigncurrencies;
                end else AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) +'_AmountColumn',10 , 'Income Amount(' + ActiveClasses.fieldbyname('classname').asString  +')');
                ActiveClasses.Next;
            end;
        end;

        if ReportonForeignCurrency then begin
            AddGridSelectedfield('TotalAmount' ,10 , Appenv.RegionalOptions.ForeignExDefault , 'Total Amount' );
            Addforeigncurrencytotal;
        end else
            AddGridSelectedfield('TotalAmount' ,10 , 'Total Amount' );
        grdMain.Selected := FieldList;
        grdMain.ApplySelected;
    finally
        FreeAndNil(FieldList);
    end;
end;


procedure TProfitLossSummaryGUI.CreateTempPLSummaryTable;
var
  qryTemp: TERPCommand;
  ctr :Integer;
  TempList: TStringList;
begin
    TempList := TStringList.Create;
    qryTemp := TERPCommand.Create(nil);
    try
        qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

        TempList.Add('DROP TABLE IF EXISTS ' + fsTablename + ';');
        TempList.Add('CREATE TABLE ' + fsTablename );
        TempList.Add('(ID int(11) NOT NULL auto_increment, ');
        TempList.Add('Date date default NULL, ');
        FCFields := '';
        for ctr := low(AmountfieldS) to high(AmountFields) do begin
            TempList.Add('`'+AmountFields[ctr] + '` Double,');
        end;
        if FConReport.RecordCount > 0 then begin
            FCOnReport.first;
            while FConReport.Eof = False do begin
                TempList.Add(FCOnReportCode.asString + '_FCRate double default NULL,');
                for ctr := low(AmountfieldS) to high(AmountFields) do begin
                    TempList.Add('`'+FCOnReportCode.asString + '_' + AmountFields[ctr] + '` Double,');
                end;
                if FCFields <> '' then FCFields := FCFields + ',' ;
                FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
                FCOnReport.Next;
            end;
        end;
        TempList.Add('FilterDate            date default NULL,');
        TempList.Add('FilterWeekday         varchar(255) default NULL,');
        TempList.Add('FilterWeekdayNumber   int(11) default NULL,');
        TempList.Add('FilterWeekNumber      int(11) default NULL,');
        TempList.Add('FilterMonthNumber     int(11) default NULL,');
        TempList.Add('FilterMonthName       varchar(255) default NULL,');
        TempList.Add('FilterQuarterNumber   int(11) default NULL,');
        TempList.Add('FilterYEAR int(11)    default NULL, ');
        TempList.Add('PRIMARY KEY  (ID)) ');
        TempList.Add(' ENGINE=MyISAM;');

        qryTemp.SQL.text :=ChangeQuery(TempList.text);
        qryTemp.Execute;
    finally
        FreeAndNil(TempList);
        FreeAndNil(qryTemp);
    end;
end;

function TProfitLossSummaryGUI.GetUserTempPLSummaryName: string;
begin
  Result := 'tmp_PLSummary_' + GetMachineIdentification(true, true, true, true);
end;

procedure TProfitLossSummaryGUI.RefreshQuery;
begin
  if Searching then RefreshAll else ToBeRefreshed;
  if (not qryMain.Active) and (qryMain.SQL.Count > 0) then
    qryMain.Open;
end;


procedure TProfitLossSummaryGUI.RefreshAll;
var
  PeriodField: string;
  GroupByField: string;
  OrderByField: string;
  ctr:Integer;
  I:Integer;
  TempList :TStringList;
  TempSQLList :TStringList;
    Procedure AddCaptions;
    begin
        if FConReport.RecordCount = 0 then Exit;
        FConReport.First;
        StringListForSQL.add(',' + Quotedstr(Appenv.RegionalOptions.ForeignExDefault)  + ' as Defaultcurrency_Caption' );
        While FConReport.eof = False do begin
            StringListForSQL.add(',' + Quotedstr(FCOnReportCode.asString)  + ' as `' +  FCOnReportCode.asString + '_Caption`' );
            FConReport.Next;
        end;
        if ActiveClasses.recordcount > 0 then begin
            ActiveClasses.First;
            while ActiveClasses.Eof = False do begin
                StringListForSQL.add(',`' + Quotedstr(ActiveClasses.fieldByname('ClassName').asString)  + '` as `' +  (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_Caption`' );
                ActiveClasses.Next;
            end;
        end;
    end;
    Procedure ReportHeader;
    begin
        StringListForSQL.Clear;
        StringListForSQL.Add('{ReportHeader}Select ');
        StringListForSQL.Add('"Profit and Loss Summary (Day)" as ReportCaption, ');
        StringListForSQL.Add(QuotedStr(FormatDateTime('dd/mm/yyyy',DtFrom.Date )) +   ' as FromDate, ');
        StringListForSQL.Add(QuotedStr(FormatDateTime('dd/mm/yyyy',Dtto.Date)) +   ' as ToDate,');
        StringListForSQL.Add('CO.CompanyName,');
        StringListForSQL.Add('CO.Address,');
        StringListForSQL.Add('CO.Address2,');
        StringListForSQL.Add('CO.City,');
        StringListForSQL.Add('CO.State,');
        StringListForSQL.Add('CO.Postcode,');
        StringListForSQL.Add('Concat_WS("", "Phone ",CO.PhoneNumber) AS PhoneNumber,');
        StringListForSQL.Add('Concat_WS("", "Fax ",CO.FaxNumber) AS FaxNumber,');
        StringListForSQL.Add('CO.ABN ,   ' );
        if grpFilters.ItemIndex < 5 then StringListForSQL.Add(Quotedstr(PeriodName+ ' / Year')+ '  as PeriodCaption ')
        else StringListForSQL.Add( Quotedstr(PeriodName)+ '  as PeriodCaption ');
        StringListForSQL.Add('FROM tblCompanyInformation AS CO');
        StringListForSQL.Add('~|||~{RepData}');
    end;

  Procedure Getfilteroptions;
  begin
    case grpFilters.ItemIndex of
        0:begin {Day}
            PeriodField := 'DATE_FORMAT(FilterDate, "%d/%m/%Y")';
            PeriodName := 'Date';
            GroupByField := 'FilterDate';
            OrderByField := 'FilterDate';
          end;
        1:begin {Weekday}
            PeriodField := 'FilterWeekday';
            PeriodName := 'Weekday';
            GroupByField := 'FilterWeekdayNumber,FilterYEAR';
            OrderByField := 'FilterYEAR,FilterWeekdayNumber';
          end;
        2:begin {Week}
            PeriodField := 'FilterWeekNumber';
            PeriodName := 'Week Number';
            GroupByField := 'FilterWeekNumber,FilterYEAR';
            OrderByField := 'FilterYEAR,FilterWeekNumber';
          end;
        3:begin {Month}
            PeriodField := 'FilterMonthName';
            PeriodName := 'Month';
            GroupByField := 'FilterMonthNumber,FilterYEAR';
            OrderByField := 'FilterYEAR,FilterMonthNumber';
          end;
        4:begin {Quarter}
            PeriodField := 'FilterQuarterNumber';
            PeriodName := 'Quarter';
            GroupByField := 'FilterQuarterNumber,FilterYEAR';
            OrderByField := 'FilterYEAR,FilterQuarterNumber';
          end;
        5:begin {Year}
            PeriodField := 'FilterYEAR';
            PeriodName := 'Year';
            GroupByField := 'FilterYEAR';
            OrderByField := 'FilterYEAR';
          end;
      end;
  end;
begin
try
    getfilterOptions;
    ReportHeader;
    TempList := TStringList.Create;
    try
        for I:= 1 to 2 do begin
            if I= 1 then TempSQLList := TempList else TempSQLList :=StringListForSQL;
            TempSQLList.Add('SELECT ');
            if I= 1 then
                TempSQLList.Add('concat(' + PeriodField + ',"")  as Period ,FilterYEAR as Year  ')
            else if grpFilters.ItemIndex < 5 then
                TempSQLList.Add('concat(' + PeriodField + '," / ",FilterYEAR) as Period  ')
            else
                TempSQLList.Add(PeriodField + ' as Period  ');

            for ctr := low(AmountFields) to high(AmountFields) do
                TempSQLList.Add(',Sum(`' + amountfields[ctr] + '`) as `' + AmountFields[ctr] + '` ');

            if FConReport.RecordCount > 0 then begin
                FCOnReport.first;
                while FConReport.Eof = False do begin
                    for ctr := low(AmountFields) to high(AmountFields) do
                        TempSQLList.Add(',Sum(`' + FCOnReportCode.asString + '_' + amountfields[ctr]+ '`) as `' + FCOnReportCode.asString + '_' + Amountfields[ctr] + '` ');
                    FCOnReport.Next;
                end;
            end;

            if I= 2 then AddCaptions; // only for the repot
            TempSQLList.Add('FROM ' + fsTablename );
            TempSQLList.Add('GROUP BY ' + GroupByField );
            TempSQLList.Add('ORDER By ' + OrderByField + ';');
        end;
        if Qrymain.Active then Qrymain.close;
        Qrymain.SQL.clear;
        Qrymain.SQL :=TempList;
        RefreshOrignalSQL;

    finally
        FreeAndNil(TempList);
    end;

    SQLString := Qrymain.SQL.Text;
    if grpFilters.ItemIndex = 5 then begin
        SQLString := ReplaceStr(SQLString, 'SELECT ', 'SELECT '''' , ');
        SQLString := ReplaceStr(SQLString, ' as Period', ' as year, " " as Period  ');
    end;

    inherited RefreshQuery;
    RefreshTotals;
    LabelChange;
    if (not (dtFrom.DroppedDown) and (dtFrom.DateTime <= IncDay(AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)))) and ( IncludedataPriorToClosingDate = False) then begin
        CommonLib.MessageDlgXP_Vista('The From Date Selected Is Prior To The Closing Date.' + #13 + #10 + #13 + #10 +
          ' - All Transactions Prior To This Date Are Summarised ' + #13 + #10 +
          '    to One Entry On This Date.' + #13 + #10 + #13 + #10 +
          ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)), mtInformation, [mbOK], 0);
    end;

finally
    xDateFrom := filterdatefrom;
    xdateTo   := Filterdateto;
    ToBeRefreshed;
end;
end;

procedure TProfitLossSummaryGUI.RefreshTotals;
begin
    inherited;
end;

procedure TProfitLossSummaryGUI.ToBeRefreshed;
begin
lblREfreshInfo.visible := ( xDateFrom <> filterdatefrom) or
              (xdateTo   <> Filterdateto) ;

end;


procedure TProfitLossSummaryGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    AddDataToTempPLSummaryTable;
    RefreshQuery;
  end;
end;

procedure TProfitLossSummaryGUI.dtFromChange(Sender: TObject);
begin
  inherited;

end;

//function TProfitLossSummaryGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtFrom.DateTime = PrevDateFrom) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateFrom := dtFrom.DateTime;
//end;

//function TProfitLossSummaryGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (dtTo.DateTime = PrevDateTo) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateTo := dtTo.DateTime;
//end;

Procedure TProfitLossSummaryGUI.CreateTranstable;
begin
    PopulateReportTable;
end;
Procedure TProfitLossSummaryGUI.PopulateReportTable;
begin
    CreateTempPLSummaryTable;
    AddDataToTempPLSummaryTable;
end;
procedure TProfitLossSummaryGUI.FormCreate(Sender: TObject);
begin
  fbIncludehistory:= True;
  IsGridcustomisable      := False;
  CanCreatecustomReport   := False;
  ReportonForeignCurrency := True;
  inherited;
  qryMain.SQL.Clear;
  showFCFooters := true;
  fsTablename := GetUserTempPLSummaryName;
  StringListForSQL:=TStringList.create;
  if not ErrorOccurred then begin
    ReportTransactionTableObj := TReportTransactionTableObj.Create(True);
    CreateTranstable;
  end;
  ShowChartViewOnPopup := True;
end;

procedure TProfitLossSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  qryMain.Close;

  AddDataToTempPLSummaryTable;
  inherited;
  RefreshQuery;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

procedure TProfitLossSummaryGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
end;

procedure TProfitLossSummaryGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(ReportTransactionTableObj);
  DeleteTable(fstablename);
  inherited;
end;

procedure TProfitLossSummaryGUI.FormShow(Sender: TObject);
begin
  refreshall;
  inherited;
end;

procedure TProfitLossSummaryGUI.chkIncludehistoryClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TProfitLossSummaryGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := true;
    try
      inherited;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

function TProfitLossSummaryGUI.GetReportTypeID: integer;
begin
  Result := 77;
end;

procedure TProfitLossSummaryGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= not self.ReportTransactionTableObj.DoingRefresh;
end;

initialization
  RegisterClassOnce(TProfitLossSummaryGUI);
end.





