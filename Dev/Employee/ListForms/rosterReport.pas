unit rosterReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, BaseListExpress, CustomInputBox, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TrosterReportGUI = class(TBaseListExpressGUI)
    qryMainID: TIntegerField;
    qryMainEmployeeId: TIntegerField;
    qryMainemployeeName: TWideStringField;
    qryMaind1: TIntegerField;
    qryMaind2: TIntegerField;
    qryMaind3: TIntegerField;
    qryMaind4: TIntegerField;
    qryMaind5: TIntegerField;
    qryMaind6: TIntegerField;
    qryMaind7: TIntegerField;
    qryMaind8: TIntegerField;
    qryMaind9: TIntegerField;
    qryMaind10: TIntegerField;
    qryMaind11: TIntegerField;
    qryMaind12: TIntegerField;
    qryMaind13: TIntegerField;
    qryMaind14: TIntegerField;
    qryMaind15: TIntegerField;
    qryMaind16: TIntegerField;
    qryMaind17: TIntegerField;
    qryMaind18: TIntegerField;
    qryMaind19: TIntegerField;
    qryMaind20: TIntegerField;
    qryMaind21: TIntegerField;
    qryMaind22: TIntegerField;
    qryMaind23: TIntegerField;
    qryMaind24: TIntegerField;
    qryMaind25: TIntegerField;
    qryMaind26: TIntegerField;
    qryMaind27: TIntegerField;
    qryMaind28: TIntegerField;
    qryMaind29: TIntegerField;
    qryMaind30: TIntegerField;
    qryMaind31: TIntegerField;
    qryMaintot: TIntegerField;
    qryMains1: TWideStringfield;
    qryMains2: TWideStringfield;
    qryMains3: TWideStringfield;
    qryMains4: TWideStringfield;
    qryMains5: TWideStringfield;
    qryMains6: TWideStringfield;
    qryMains7: TWideStringfield;
    qryMains8: TWideStringfield;
    qryMains9: TWideStringfield;
    qryMains10: TWideStringfield;
    qryMains11: TWideStringfield;
    qryMains12: TWideStringfield;
    qryMains13: TWideStringfield;
    qryMains14: TWideStringfield;
    qryMains15: TWideStringfield;
    qryMains16: TWideStringfield;
    qryMains17: TWideStringfield;
    qryMains18: TWideStringfield;
    qryMains19: TWideStringfield;
    qryMains20: TWideStringfield;
    qryMains21: TWideStringfield;
    qryMains22: TWideStringfield;
    qryMains23: TWideStringfield;
    qryMains24: TWideStringfield;
    qryMains25: TWideStringfield;
    qryMains26: TWideStringfield;
    qryMains27: TWideStringfield;
    qryMains28: TWideStringfield;
    qryMains29: TWideStringfield;
    qryMains30: TWideStringfield;
    qryMains31: TWideStringfield;
    qryMainstot: TWideStringfield;
    lblREfreshInfo: TLabel;
    QryRosterList: TERPQuery;
    QryRosterListEmployeeId: TIntegerField;
    QryRosterListstartdate: TDateField;
    QryRosterListstarttime: TDateTimeField;
    QryRosterListseconds: TFloatField;
    btnPrev: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    cmdEmail: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
  private
    fsTablename:String;
    xDateFrom , XDateTo:TDateTime;
    procedure ToBeRefreshed;
    function RosterListQry: TERPQuery;
    function FieldNo(const Value: TDateTime): Integer;
    function ReportSQL(EmployeeID:Integer=0): String;
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals; override;
    Procedure CalcnShowFooter; override;
    procedure RefreshAll;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Function ExpressDetailListName:String;Override;
    function GetReportTypeID: integer; Override;

  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, CommonDbLib, MySQLConst, dateutils,  ManufactureLib,
  GridFieldsObj, AppEnvironment, EmailExtraUtils;

{$R *.dfm}
procedure TrosterReportGUI.actRefreshQryExecute(Sender: TObject);
begin
//  inherited;
  RefreshAll;
end;

procedure TrosterReportGUI.btnNextClick(Sender: TObject);
var
  Days :Integer;
begin
  inherited;
  Days := DaysBetween(filterDateFrom , Dateof(filterDateTo))+1;
  DtTo.Date   := incday(Dateof(DtTo.Date)   , days);
  Dtfrom.Date := incday(Dateof(DtTo.Date) , 0-(days-1));
  btnRequery.Click;

end;

procedure TrosterReportGUI.btnPrevClick(Sender: TObject);
var
  Days :Integer;
begin
  inherited;
  Days := DaysBetween(filterDateFrom , Dateof(filterDateTo))+1;
  Dtfrom.Date := incday(DtFrom.Date , 0-days);
  DtTo.Date   := incday(DtFrom.Date   , days-1);
  btnRequery.Click;
end;

procedure TrosterReportGUI.CalcnShowFooter;
var
  ctr:Integer;
begin
  inherited;
  for ctr := low(FooterCalcfields) to high(FooterCalcfields)-1 do
    GrdMain.ColumnByName(Qrymain.FieldByName('s' + inttostr(ctr+1)).fieldname).FooterValue :=  SecondsToTime(trunc(FooterCalcfields[ctr].Total) , False);
  ctr:=high(FooterCalcfields);
  GrdMain.ColumnByName(qryMainstot.fieldname).FooterValue :=  SecondsToTime(trunc(FooterCalcfields[ctr].Total) , True);
end;

procedure TrosterReportGUI.cmdEmailClick(Sender: TObject);
var
  s:String;
  qry : TERPQuery;
  lCount : integer;
//  lMode : TSendEmailMode;
  lSilent, lSecret : boolean;
begin
  inherited;
  lSilent := false;
  lSecret := false;

  s:= SelectedIds('employeeId' , True);
  if s= '' then begin
    if MessageDlgXP_Vista('You have not selected the employees to send the email to. Do you want to Email all in the list? ', mtConfirmation, [mbyes, mbno] , 0) = mrYes then begin
      Grdmain.SelectAll;
      s:= SelectedIds('employeeId' , True);
    end else begin
      Exit;
    end;
  end;

  if ReportName = '' then begin
    MessageDlgXP_Vista('Please Make / Select report Template to Print', mtWarning, [mbOK], 0);
    Exit;
  end;

  qry := tempMyQuery;
  qry.SQL.add('select distinct E.EmployeeID , E.Email , E.EmployeeName from ' +fsTablename +'  T inner join tblemployees  E on T.EmployeeId = E.employeeId');
  qry.open;

  lCount := CheckEmailAddresses(qry, 'Employee', 'EmployeeName', 'Email');
  if lCount = 0 then
    exit;

  if not EmailSilentSecret(lCount, false, lSilent, lSecret) then
    exit;


  qry.First;
  ReportSQLSupplied:= TRue;
  While not qry.eof do
  begin
    if (qry.FieldByName('email').AsString <> '') then
    begin
      FilterLabel.Visible := False;
      TimerMsg(FilterLabel , 'Emailing Roster to ' + qry.Fieldbyname('employeeName').AsString);
      s:= ReportSQL(qry.FieldByname('EmployeeId').asInteger);
      if devmode then
        PrintTemplateReport(ReportName, s , False, 1);
      Emailreport(AppEnv.AccessLevels.GetFormDescription(Self.classname) ,
                  'Roster for the Period of ' + formatDateTime(FormatSettings.shortDateformat,filterDateFrom)+' to ' + FormatDateTime(FormatSettings.ShortDateformat,filterdateTo) ,
                  qry.FieldByname('Email').asString ,
                  'Roster' ,
                  s,
                  ReportName ,
                  getOutGoingFileName('', GetTemporaryTableNameSuffix+'_' +ReportName +inttostr(qry.FieldByname('EmployeeId').asInteger) , 'PDF'),
                  lSilent, lSecret);
    end;
    qry.Next;
  end;
end;

procedure TrosterReportGUI.cmdPrintClick(Sender: TObject);
begin
  if chkAdvancedPrinting.Checked then begin
    templateSQL:= reportSQL;
    ReportSQLSupplied:= TRue;
  end;
  inherited;
end;

function TrosterReportGUI.ExpressDetailListName: String;
begin
  REsult:= 'TRosterReportDetailsGUI';
end;

procedure TrosterReportGUI.dtFromChange(Sender: TObject);
begin
  if DaysBetween(filterDateFrom , filterDateTo) > 31 then dtto.Date := incday(filterDateFrom, 30);
  inherited;
  ToBeRefreshed;
end;

procedure TrosterReportGUI.dtToChange(Sender: TObject);
begin
  if DaysBetween(filterDateFrom , filterDateTo) > 31 then dtfrom.Date := incday(filterDateto, -30);
  inherited;
  ToBeRefreshed;
end;

function TrosterReportGUI.FieldNo(const Value: TDateTime): Integer;
begin
  Result:= Daysbetween(FilterDateFrom , Value)+1;
end;

procedure TrosterReportGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  //IsGridcustomisable := false;
  CanCreatecustomReport := false;
  xDateFrom:= 0;
  XDateTo:= 0;
  fsTableName := GetUserTemporaryTableName('Rosterreport');

    With TempMyScript do try
      SQL.add('Drop table if Exists ' +fstablename +';');
      SQL.add('Create table ' + fstablename );
      SQL.add('(`ID` int(11) NOT NULL AUTO_INCREMENT,');
      SQL.add('`EmployeeId` int(11) NOT NULL DEFAULT 0,');
      SQL.add('`employeeName` varchar(100) , ');
      for ctr := 1 to 31 do SQL.add('`d' + inttostr(ctr) +'` Int(11) DEFAULT 0,');

      for ctr := 1 to 31 do SQL.add('`s' + inttostr(ctr) +'` varchar(50) DEFAULT "",');
      SQL.add('`tot` Int(11) DEFAULT NULL,');
      SQL.add('`stot` varchar(50) DEFAULT NULL,');
      SQL.add('PRIMARY KEY (`ID`)');
      SQL.add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');
      execute;

    finally
      Free;
    end;
        Qrymain.SQL.text := 'Select * from ' +fsTablename;
  inherited;
  AddcalcColumn(Qrymaind1.FieldName, false);
  AddcalcColumn(Qrymaind2.FieldName, false);
  AddcalcColumn(Qrymaind3.FieldName, false);
  AddcalcColumn(Qrymaind4.FieldName, false);
  AddcalcColumn(Qrymaind5.FieldName, false);
  AddcalcColumn(Qrymaind6.FieldName, false);
  AddcalcColumn(Qrymaind7.FieldName, false);
  AddcalcColumn(Qrymaind8.FieldName, false);
  AddcalcColumn(Qrymaind9.FieldName, false);
  AddcalcColumn(Qrymaind10.FieldName, false);
  AddcalcColumn(Qrymaind11.FieldName, false);
  AddcalcColumn(Qrymaind12.FieldName, false);
  AddcalcColumn(Qrymaind13.FieldName, false);
  AddcalcColumn(Qrymaind14.FieldName, false);
  AddcalcColumn(Qrymaind15.FieldName, false);
  AddcalcColumn(Qrymaind16.FieldName, false);
  AddcalcColumn(Qrymaind17.FieldName, false);
  AddcalcColumn(Qrymaind18.FieldName, false);
  AddcalcColumn(Qrymaind19.FieldName, false);
  AddcalcColumn(Qrymaind20.FieldName, false);
  AddcalcColumn(Qrymaind21.FieldName, false);
  AddcalcColumn(Qrymaind22.FieldName, false);
  AddcalcColumn(Qrymaind23.FieldName, false);
  AddcalcColumn(Qrymaind24.FieldName, false);
  AddcalcColumn(Qrymaind25.FieldName, false);
  AddcalcColumn(Qrymaind26.FieldName, false);
  AddcalcColumn(Qrymaind27.FieldName, false);
  AddcalcColumn(Qrymaind28.FieldName, false);
  AddcalcColumn(Qrymaind29.FieldName, false);
  AddcalcColumn(Qrymaind30.FieldName, false);
  AddcalcColumn(Qrymaind31.FieldName, false);
  AddcalcColumn(Qrymaintot.FieldName, false);
end;

procedure TrosterReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  Refreshall;
  btnCustomize.enabled := False;
  cboFilter.Items.Clear;
  cboFilter.Items.AddObject(QrymainemployeeName.Displaylabel, QrymainemployeeName);
  btnPrev.Visible := Devmode;
  btnNext.Visible := Devmode;
end;

function TrosterReportGUI.GetReportTypeID: integer;
begin
  REsult:= 111;
end;
function TrosterReportGUI.ReportSQL(EmployeeID:Integer=0): String;
var
  ctr: Integer;
  dt:TDateTime;
begin
  REsult:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';

  result:= result + ' ~|||~{Details} Select EmployeeName ';
  for ctr:= 1 to 31 do
    result := result + ', s' +inttostr(ctr);
  result:= result + ',sTot as Total ';
  (*for ctr:= 1 to 31 do begin
    result := result + ', ' + Quotedstr('00:00:00') +' as s' +inttostr(ctr);
    dt:= incDay(dt,1);
  end;
  result:= result + ',' + Quotedstr('00:00:00') +' as Total ';*)

  result:= result + ' from ' + fstablename ;
  if EmployeeID <> 0 then result:= result + ' where  EmployeeID = ' + inttostr(EmployeeID );
  result:= result + ' order by EmployeeName';

  result:= result + ' ~|||~{Dates}Select ' ;
  dt:= filterDatefrom;
  for ctr := 1 to 31 do begin
    if ctr <= Daysbetween(FilterDateFrom , filterdateTo)+1 then result := result + Quotedstr(formatDatetime(FormatSettings.ShortDateformat ,dt))+' as Date'+inttostr(ctr)
    else result := result + Quotedstr('')+' as Date'+inttostr(ctr);
    result := result + ',';
    dt:= incday(dt,1);
  end;
  REsult := result  + Quotedstr(formatDatetime(FormatSettings.ShortDateformat ,filterDateFrom))+' as DateFrom, ';
  REsult := result +  Quotedstr(formatDatetime(FormatSettings.ShortDateformat ,filterDateto))+' as DateTo ';
end;

procedure TrosterReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if SameText(Field.FieldName , QrymainemployeeName.FieldName) then
    ABrush.Color := clwhite
  else if SameText(Field.FieldName , Qrymainstot.FieldName) then
    ABrush.Color := clTeal
  else
    try
      if   IsWorkingday(strToDate(field.DisplayLabel)) then else ABrush.Color := $00B9FFFF;
    Except
    end;
end;

procedure TrosterReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
(*var
  ctr:Integer;
  s:String;
begin
  inherited;
  for ctr:= 0 to 30 do
    try
      Qrymain.FieldByName('s' + inttostr(ctr+1)).DisplayLabel := FormatDateTime(FormatSettings.ShortDateformat,  incday(filterDatefrom, ctr));
    Except
    end;
  s := GetSelectedTExtFromFields(grdmain,True);
  grdmain.Selected.Text := s;
  grdmain.ApplySelected;
  GuiPrefs.DbGridElement[grdMain].UpdateGridSelected(s);*)
end;

procedure TrosterReportGUI.RefreshQuery;
begin
  openDB(Qrymain);
  if Searching then RefreshAll else ToBeRefreshed;
end;
procedure TrosterReportGUI.ToBeRefreshed;
begin
  lblREfreshInfo.visible :=
              ( xDateFrom <> filterdatefrom) or
              (xdateTo   <> Filterdateto) ;
end;

procedure TrosterReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if fbDateRangeSupplied =False then
    if GuiPrefs.Node.Exists('Options.DateRange') then begin
      DtFrom.Date :=0;
      DtTo.Date   :=  GuiPrefs.Node['Options.DateRange.DateTo'].asDateTime;
      DtFrom.Date :=  GuiPrefs.Node['Options.DateRange.DateFrom'].asDateTime;
    end;
    if GuiPrefs.Node.Exists('Options.Print') then begin
      chkPreview.checked    :=GuiPrefs.Node['Options.Print.ShowPewview'].asBoolean;
      chkAdvancedPrinting.checked :=GuiPrefs.Node['Options.Print.AdvPrint'].asBoolean;
      ChkChooseRpt.checked :=GuiPrefs.Node['Options.Print.chooseTemplate'].asBoolean;
    end;
end;

procedure TrosterReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  if fbDateRangeSupplied =False then begin
    GuiPrefs.Node['Options.DateRange.DateTo'].asDateTime   := DtTo.Date;
    GuiPrefs.Node['Options.DateRange.DateFrom'].asDateTime := DtFrom.Date;
  end;
  GuiPrefs.Node['Options.Print.ShowPewview'].asBoolean  := chkPreview.checked ;
  GuiPrefs.Node['Options.Print.AdvPrint'].asBoolean   := chkAdvancedPrinting.checked ;
  GuiPrefs.Node['Options.Print.chooseTemplate'].asBoolean   := ChkChooseRpt.checked ;
end;

procedure TrosterReportGUI.RefreshAll;
var
  dt:TDate;
  ctr:Integer;
  s:String;
  scr : TERPScript;
begin
  Qrymain.disableControls;
  try
    if DaysBetween(filterDateFrom , filterDateTo) > 31 then dtto.Date := incday(filterDateFrom, 30);
    closeDB(Qrymain);
//    With TempMyScript do try
    scr := TempMyScript;
    with scr do
    try
(*      SQL.add('Drop table if Exists ' +fstablename +';');
      SQL.add('Create table ' + fstablename );
      SQL.add('(`ID` int(11) NOT NULL AUTO_INCREMENT,');
      SQL.add('`EmployeeId` int(11) NOT NULL DEFAULT 0,');
      SQL.add('`employeeName` varchar(100) , ');
      for ctr := 1 to 31 do SQL.add('`d' + inttostr(ctr) +'` Int(11) DEFAULT 0,');
      for ctr := 1 to 31 do SQL.add('`s' + inttostr(ctr) +'` varchar(50) DEFAULT "",');
      SQL.add('`tot` Int(11) DEFAULT NULL,');
      SQL.add('`stot` varchar(50) DEFAULT NULL,');
      SQL.add('PRIMARY KEY (`ID`)');
      SQL.add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');*)
     (* SQL.add('insert into ' + fsTablename ) ;
      SQL.add('(EmployeeId ,employeeName, ');
      SQL.add('d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28,d29,d30,d31)');
      SQL.add('Select distinct ');
      SQL.add('EmployeeId ,  employeeName');
      dt:= filterDateFrom;
      ctr:= 1;
      While (ctr<=31) do begin
        if (dt<=dtTo.Date)  then begin
          SQL.add(', (Select sum(TIME_TO_SEC(TimeDiff(endtime , starttime))) '+
                  ' FROM tblroster R1 WHERE IsOnTheRoster = "T" and  Active="T"  '+
                  ' and   (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T"))  '+
                  ' and starttime >= ' +  Quotedstr(formatDateTime(mysqlDateTimeformat , dt))+' and endtime <' +  Quotedstr(formatDateTime(mysqlDateTimeformat , incday(dt,1)))+' '+
                  ' and R1.employeeID = R.EmployeeId) as d' + inttostr(ctr)+'' );
          dt:= incday(dt,1);
        end;
        ctr:= ctr+1;
      end;
      SQL.add('FROM tblroster R');
      SQL.add('INNER JOIN tblEmployees using (EmployeeID)');
      SQL.add('WHERE IsOnTheRoster = "T" and  Active="T" and');
      SQL.add(' (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T"))');
      SQL.add(' and starttime >=' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateFrom))+' and endtime <' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateto))+';');*)
       SQL.add('truncate table ' + fstablename +';');
       SQL.add('insert into ' + fsTablename ) ;
      SQL.add('(EmployeeId ,employeeName ) ');
      SQL.add('Select distinct ');
      SQL.add('EmployeeId ,  employeeName');
      SQL.add('FROM tblroster R');
      SQL.add('INNER JOIN tblEmployees using (EmployeeID)');
      SQL.add('WHERE IsOnTheRoster = "T" and  Active="T" and');
      SQL.add(' (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T"))');
      SQL.add(' and starttime >=' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateFrom))+' and endtime <' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateto))+';');
      RosterListQry;
      if QryRosterList.RecordCount >0 then begin
        QryRosterList.First;
        While QryRosterList.Eof = False do begin
          SQL.Add('update ' +fstablename +' Set d' + inttostr(FieldNo(QryRosterListstartdate.AsDateTime)) + ' = d' + inttostr(FieldNo(QryRosterListstartdate.AsDateTime)) + ' + ' +
                        inttostr(QryRosterListSeconds.AsInteger)+' where EmployeeId = ' + inttostr(QryRosterListEmployeeId.AsInteger)+';');
          QryRosterList.Next;
        end;
      end;

      for ctr := 1 to 31 do
        SQL.add(' update ' + fstablename + ' set s' +inttostr(ctr) +' = "";' +
                ' update ' + fstablename + ' set s' +inttostr(ctr) +' = FormatSecondsTotime(d' +inttostr(ctr)+') where ifnull(d' +inttostr(ctr)+',0)<> 0;');


      SQL.add(' update ' + fstablename + ' set tot = ifnull(d1,0)+'+
                                                      ' ifnull(d2,0)+'+
                                                      ' ifnull(d3,0)+'+
                                                      ' ifnull(d4,0)+'+
                                                      ' ifnull(d5,0)+'+
                                                      ' ifnull(d6,0)+'+
                                                      ' ifnull(d7,0)+'+
                                                      ' ifnull(d8,0)+'+
                                                      ' ifnull(d9,0)+'+
                                                      ' ifnull(d10,0)+'+
                                                      ' ifnull(d11,0)+'+
                                                      ' ifnull(d12,0)+'+
                                                      ' ifnull(d13,0)+'+
                                                      ' ifnull(d14,0)+'+
                                                      ' ifnull(d15,0)+'+
                                                      ' ifnull(d16,0)+'+
                                                      ' ifnull(d17,0)+'+
                                                      ' ifnull(d18,0)+'+
                                                      ' ifnull(d19,0)+'+
                                                      ' ifnull(d20,0)+'+
                                                      ' ifnull(d21,0)+'+
                                                      ' ifnull(d22,0)+'+
                                                      ' ifnull(d23,0)+'+
                                                      ' ifnull(d24,0)+'+
                                                      ' ifnull(d25,0)+'+
                                                      ' ifnull(d26,0)+'+
                                                      ' ifnull(d27,0)+'+
                                                      ' ifnull(d28,0)+'+
                                                      ' ifnull(d29,0)+'+
                                                      ' ifnull(d30+d31,0);');
      SQL.add(' update ' + fstablename + ' set stot = FormatSeconds(0,tot);');
      Execute;
    finally
      Free;
    end;
    inherited RefreshQuery;
    dt:=  filterDatefrom;

    {make all columns invisible and show the fields of the selected date range}
    for ctr := 1 to 31 do begin
      guiprefs.DbGridElement[grdMain].RemoveField('s' +inttostr(ctr));
      dt:= incday(dt,1);
    end;
    guiprefs.DbGridElement[grdMain].RemoveField('stot');

    dt:=  filterDatefrom;
    for ctr := 1 to 31 do begin
      if ctr <= Daysbetween(FilterDateFrom , filterdateTo)+1 then begin
        guiprefs.DbGridElement[grdMain].AddField('s' +inttostr(ctr));
        Qrymain.FieldByName('s' + inttostr(ctr)).DisplayLabel := FormatDateTime(FormatSettings.ShortDateformat,  dt{incday(dt, ctr-1)});
      end else begin
      end;
      dt:= incday(dt,1);
    end;
    guiprefs.DbGridElement[grdMain].AddField('stot');

    s := GetSelectedTExtFromFields(grdmain,True);
    grdmain.Selected.Text := s;
    grdmain.ApplySelected;
  finally
    Qrymain.enableControls;
  end;
  xDateFrom := filterdatefrom;
  xdateTo   := Filterdateto;
  ToBeRefreshed;
end;

procedure TrosterReportGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

function TrosterReportGUI.RosterListQry: TERPQuery;
var
  s:String;
begin
  s:= 'Select EmployeeId , date(starttime) startdate, starttime , sum(TIME_TO_SEC(TimeDiff(endtime , starttime))) seconds' +
      ' FROM tblroster R1 WHERE  (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T"))  ' +
      ' and starttime >= ' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateFrom))+'  and endtime <=' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateTo)) +
      ' group by employeeID  , date(starttime)';
  if (QryRosterList.Active) and (Sametext(QryRosterList.SQL.Text , s)) then begin
    REsult:= QryRosterList;
    Exit;
  end;
  closedb(QryRosterList);
  QryRosterList.SQL.Clear;
  QryRosterList.SQL.Add(s);
  QryRosterList.Open;
  result:= QryRosterList;
end;

procedure TrosterReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainD1.FieldName);
  RemoveFieldfromGrid(QrymainD2.FieldName);
  RemoveFieldfromGrid(QrymainD3.FieldName);
  RemoveFieldfromGrid(QrymainD4.FieldName);
  RemoveFieldfromGrid(QrymainD5.FieldName);
  RemoveFieldfromGrid(QrymainD6.FieldName);
  RemoveFieldfromGrid(QrymainD7.FieldName);
  RemoveFieldfromGrid(QrymainD8.FieldName);
  RemoveFieldfromGrid(QrymainD9.FieldName);
  RemoveFieldfromGrid(QrymainD10.FieldName);
  RemoveFieldfromGrid(QrymainD11.FieldName);
  RemoveFieldfromGrid(QrymainD12.FieldName);
  RemoveFieldfromGrid(QrymainD13.FieldName);
  RemoveFieldfromGrid(QrymainD14.FieldName);
  RemoveFieldfromGrid(QrymainD15.FieldName);
  RemoveFieldfromGrid(QrymainD16.FieldName);
  RemoveFieldfromGrid(QrymainD17.FieldName);
  RemoveFieldfromGrid(QrymainD18.FieldName);
  RemoveFieldfromGrid(QrymainD19.FieldName);
  RemoveFieldfromGrid(QrymainD20.FieldName);
  RemoveFieldfromGrid(QrymainD21.FieldName);
  RemoveFieldfromGrid(QrymainD22.FieldName);
  RemoveFieldfromGrid(QrymainD23.FieldName);
  RemoveFieldfromGrid(QrymainD24.FieldName);
  RemoveFieldfromGrid(QrymainD25.FieldName);
  RemoveFieldfromGrid(QrymainD26.FieldName);
  RemoveFieldfromGrid(QrymainD27.FieldName);
  RemoveFieldfromGrid(QrymainD28.FieldName);
  RemoveFieldfromGrid(QrymainD29.FieldName);
  RemoveFieldfromGrid(QrymainD30.FieldName);
  RemoveFieldfromGrid(QrymainD31.FieldName);
  RemoveFieldfromGrid(QrymainEmployeeId.FieldName);
  RemoveFieldfromGrid(QrymainId.FieldName);
  RemoveFieldfromGrid(Qrymaintot.FieldName);
end;

initialization
  RegisterClassOnce(TrosterReportGUI);

end.

