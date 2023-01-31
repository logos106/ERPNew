unit ProfitnLosschartBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitandLossPeriodReportBase, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  BaseListingForm, wwcheckbox, DNMAction, CustomInputBox;

type
  TProfitnLosschartBaseGUI = class(TProfitLossPeriodBase)
    qryMainperiod: TWideStringField;
    qryMainExp: TFloatField;
    qryMainInc: TFloatField;
    qryMainCogs: TFloatField;
    qryMainPrevyrExp: TFloatField;
    qryMainPrevyrInc: TFloatField;
    qryMainPrevyrCogs: TFloatField;
    qryMainGross: TFloatField;
    qryMainPrevYrgross: TFloatField;
    qryMainDateFrom: TDateTimeField;
    qryMainDateTo: TDateTimeField;
    qryMainPrevdateFrom: TDateTimeField;
    qryMainPrevdateto: TDateTimeField;
    qryMainNetIncome: TFloatField;
    qryMainPrevYrNetIncome: TFloatField;
    grpGraph: TRadioGroup;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure grpViewClick(Sender: TObject);
    procedure grpGraphClick(Sender: TObject);
  private
    procedure MakeQry;
    procedure BeforeShowTransAccountDetails(Sender: TObject);
  Protected
    fbShowgrpGraph:Boolean;
    Tablename :String;
    procedure RefreshAll;Override;
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;override;
    procedure Setcharttolaunch(const Value: string); override;
    Function PeriodSumData(FromDate, ToDate:TDateTime;Columnname:String):String;virtual;abstract;
    Function CharttoView:String;virtual;abstract;
  public
    procedure showGraph;Override;
  end;

implementation

uses CommonLib,  dateutils, MySQLConst, CommonDbLib, CommonFormLib,
  TransAccountDetailsForm, AppEnvironment, DNMLib, ReportSQLProfitAndLossPeriod;

{$R *.dfm}

{ TProfitnLosschartGUI }

procedure TProfitnLosschartBaseGUI.FormCreate(Sender: TObject);
begin
  fbShowgrpGraph:= False;
(*  tablename := GetUserTemporaryTableName('ProfitnLosschart');
  Qrymain.SQL.Text := 'Select * from ' + tablename;*)
  Qrymain.SQL.Text := 'Select * from ' + tablename;
  inherited;
  ReportonForeignCurrency := False;
  AddCalcColumn(qryMainExp.fieldname , True);
  AddCalcColumn(qryMainInc.fieldname , True);
  AddCalcColumn(qryMainCogs.fieldname , True);
  AddCalcColumn(qryMainPrevyrExp.fieldname , True);
  AddCalcColumn(qryMainPrevyrInc.fieldname , True);
  AddCalcColumn(qryMainPrevyrCogs.fieldname , True);
  AddCalcColumn(qryMainGross.fieldname , True);
  AddCalcColumn(qryMainPrevYrgross.fieldname , True);
  AddCalcColumn(qryMainNetIncome.fieldname , True);
  AddCalcColumn(qryMainPrevYrNetIncome.fieldname , True);
  SearchMode:= smFullList;
end;

procedure TProfitnLosschartBaseGUI.FormShow(Sender: TObject);
begin
  dtfrom.date := 0;
  Dtto.Date := Date;
  dtfrom.date := GetCurrentFiscalYearStart(date);
  fbDateRangeSupplied:= True;
  inherited;
end;

procedure TProfitnLosschartBaseGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  //inherited;

end;

procedure TProfitnLosschartBaseGUI.grdMainDblClick(Sender: TObject);
begin
  OpenERPListForm('TTransAccountDetailsGUI' , BeforeShowTransAccountDetails);
end;
procedure TProfitnLosschartBaseGUI.grpGraphClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= CharttoView;
  if sameText(s, charttolaunch) then exit;
  TitleLabel.Caption := s;
  Self.Caption := s;
  charttolaunch:=s;
  RefreshGraph;
end;

procedure TProfitnLosschartBaseGUI.grpViewClick(Sender: TObject);
begin
  inherited;
  grpGraph.Visible := fbShowgrpGraph and (grpView.ItemIndex = 0);
end;

Procedure TProfitnLosschartBaseGUI.BeforeShowTransAccountDetails(Sender :TObject);
var
  sfilter:String;
begin
  if Sametext(ActiveFieldname ,QrymainExp.FieldName )  or Sametext(ActiveFieldname ,qryMainPrevyrExp.FieldName ) then begin
    sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP")';
  end else if Sametext(ActiveFieldname ,Qrymaininc.FieldName ) or Sametext(ActiveFieldname ,QrymainPrevyrinc.FieldName )  then begin
    sFilter := '(AccountType = "EXINC" OR AccountType = "INC")';
  end else if Sametext(ActiveFieldname ,Qrymaincogs.FieldName ) or Sametext(ActiveFieldname ,QrymainPrevyrcogs.FieldName ) then begin
    sFilter := 'AccountType = "COGS"';
  end else if Sametext(ActiveFieldname ,Qrymaingross.FieldName ) or Sametext(ActiveFieldname ,QrymainPrevYrgross.FieldName ) then begin
    sFilter := '(AccountType = "COGS" OR (AccountType = "EXINC" OR AccountType = "INC"))';
  end else if Sametext(ActiveFieldname ,QrymainNetIncome.FieldName ) or Sametext(ActiveFieldname ,QrymainPrevYrNetIncome.FieldName ) then begin
    sFilter := '((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")';
  end;

  With TTransAccountDetailsGUI(Sender) do begin

    CallingClassName:= Self.ClassName;
    fbIncludehistory:= True;
    chkIncludehistory.checked := True;
    pnlIncludehistory.Visible:=  True;
    if     Sametext(ActiveFieldname ,QrymainExp.FieldName    )
        or Sametext(ActiveFieldname ,Qrymaininc.FieldName    )
        or Sametext(ActiveFieldname ,Qrymaincogs.FieldName   )
        or Sametext(ActiveFieldname ,Qrymainperiod.FieldName )
        or Sametext(ActiveFieldname ,Qrymaingross.FieldName  )
        or Sametext(ActiveFieldname ,QrymainNetIncome.FieldName  ) then begin
      FromDate := QrymainDateFrom.AsDateTime;
      ToDate   := QrymainDateTo.AsDateTime;
    end else begin
      FromDate := QrymainPrevDateFrom.AsDateTime;
      ToDate   := QrymainPrevDateTo.AsDateTime;
    end;

    fbDateRangeSupplied := true;

    if sFilter <> '' then begin
      qryMain.SQL.Add('AND ' + sFilter + ' Group by TransID;');
      WhereString := 'AND (' + sFilter + ')';
    end else begin
      qryMain.SQL.Add( ' Group by TransID;');
      WhereString := '';
    end;
    if (Fromdate < Appenv.companyprefs.SummarisedTransDate) or  (toDate <Appenv.companyprefs.SummarisedTransDate) then
      TimerMsg(lblDateComments , 'The date range for the drill down falls before the ''Closing Date'' and data before the ''Closing Date'' are not Available for this report');
  end;
end;
Procedure TProfitnLosschartBaseGUI.MakeQry;
var
  FromDate, ToDate, StartDate, EndDate: TDateTime;
  TempColumnCount:Integer;
  ColumnName:String;
  s:String;
begin
    StartDate := filterdateFrom;
    EndDate   := filterDateto;
    TempColumnCount := 0;
    FromDate := StartDate;
    (*ToDate := EndDate;
    case grpFilters.ItemIndex of
        0:  ToDate := IncMonth(StartDate, TempColumnCount);
        1:  ToDate := IncQuarter(StartDate, TempColumnCount);
        2:  ToDate := IncYear(StartDate, TempColumnCount);
    end;*)
    ToDate := incsecond(StartDate, -1);
    With  ScriptMain do try
      SQL.Clear;
      SQl.Add('Drop table if exists ' +tablename +';' + 'Create table ' + tablename );
        repeat
            TempColumnCount := TempColumnCount + 1;
            case grpFilters.ItemIndex of
                0:begin {Month}
                    FromDate := IncSecond(ToDate);
                    ToDate  := EndOfTheMonth(IncMonth(StartDate, TempColumnCount - 1));
                    ColumnName := dotranslate(GetMonthName(MonthOfTheYear(FromDate))) + '(' +IntToStr(YearOf(FromDate)) + ')';
                  end;
                1:begin {Quarter}
                    FromDate := IncSecond(ToDate);
                    ToDate := EndOfTheQuarter(IncQuarter(StartDate, TempColumnCount - 1));
                    ColumnName := dotranslate('Quarter')+' '+ IntToStr(QuarterOf(FromDate)) + '(' +IntToStr(YearOf(FromDate)) + ')';
                  end;
                2:begin {Year}
                    FromDate := IncSecond(ToDate);
                    ToDate := EndOfAYear(YearOf(IncYear(StartDate, TempColumnCount - 1)));
                    ColumnName := dotranslate('Year')+' - ' +IntToStr(YearOf(FromDate));
                end;
            end;
          if todate > enddate then todate := enddate;
          if fromdate <Todate then begin
            s:=PeriodSumData(FromDate, ToDAte, Columnname);
            if trim(s)<> '' then begin
              if (SQL.Count >1) then SQL.Add('union all ');
              SQL.add(s);
            end;
          end;
        until ToDate >= EndDate;
    finally
      Execute;
    end;
  //  RefreshOrignalSQL(false);
end;

procedure TProfitnLosschartBaseGUI.RefreshAll;
begin
  Qrymain.DisableControls;
  try
    if  Qrymain.Active then Qrymain.Close;
    PopulateReportTable;
    MakeQry;
    DoRefreshQuery;
    xDateFrom:= FilterdateFrom;
    xdateto:= FilterdateTo;
    fifilterOption := grpfilters.itemindex;
    xIncludehistory := IncludedataPriorToClosingDate;
    xshowBudget :=chkBudget.checked;
    ToBeRefreshed;
  finally
    Qrymain.EnableControls;
  end;
end;

procedure TProfitnLosschartBaseGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TProfitnLosschartBaseGUI.Setcharttolaunch(const Value: string);
begin
  inherited;
  if value <> '' then begin
    TitleLabel.Caption := Value;
    Self.Caption := Value;
  end;

//  if SameText(Value,'Profit n Loss Chart') then
end;

procedure TProfitnLosschartBaseGUI.SetGridColumns;
begin
  inherited;
(*  RemoveFieldfromGrid(QrymainDateFrom.FieldName);
  RemoveFieldfromGrid(QrymainDateTo.FieldName);
  RemoveFieldfromGrid(QrymainPrevdateFrom.FieldName);
  RemoveFieldfromGrid(QrymainPrevdateto.FieldName);*)
end;

procedure TProfitnLosschartBaseGUI.showGraph;
begin
  inherited;
  if sametext(charttolaunch , 'Gross Profit')  or sametext(charttolaunch , 'Net Income') or sametext(charttolaunch,'Profit n Loss Chart')   then  begin
    fbShowgrpGraph:= True;
  end;
  grpGraph.Visible := fbShowgrpGraph ;
end;


end.

