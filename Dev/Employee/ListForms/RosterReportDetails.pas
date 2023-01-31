unit RosterReportDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, BaseListDetails, CustomInputBox, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TRosterReportDetailsGUI = class(TBaseListDetailsGUI)
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
    QryRosterListemployeeName: TWideStringField;
    QryRosterListStarttime: TDateTimeField;
    QryRosterListEndtime: TDateTimeField;
    QryRosterListtype: TWideStringField;
    QryRosterListseconds: TLargeintField;
    QryRosterListsseconds: TWideMemoField;
    qryMaindFrom1: TDateTimeField;
    qryMaindFrom2: TDateTimeField;
    qryMaindFrom3: TDateTimeField;
    qryMaindFrom4: TDateTimeField;
    qryMaindFrom5: TDateTimeField;
    qryMaindFrom6: TDateTimeField;
    qryMaindFrom7: TDateTimeField;
    qryMaindFrom8: TDateTimeField;
    qryMaindFrom9: TDateTimeField;
    qryMaindFrom10: TDateTimeField;
    qryMaindFrom11: TDateTimeField;
    qryMaindFrom12: TDateTimeField;
    qryMaindFrom13: TDateTimeField;
    qryMaindFrom14: TDateTimeField;
    qryMaindFrom15: TDateTimeField;
    qryMaindFrom16: TDateTimeField;
    qryMaindFrom17: TDateTimeField;
    qryMaindFrom18: TDateTimeField;
    qryMaindFrom19: TDateTimeField;
    qryMaindFrom20: TDateTimeField;
    qryMaindFrom21: TDateTimeField;
    qryMaindFrom22: TDateTimeField;
    qryMaindFrom23: TDateTimeField;
    qryMaindFrom24: TDateTimeField;
    qryMaindFrom25: TDateTimeField;
    qryMaindFrom26: TDateTimeField;
    qryMaindFrom27: TDateTimeField;
    qryMaindFrom28: TDateTimeField;
    qryMaindFrom29: TDateTimeField;
    qryMaindFrom30: TDateTimeField;
    qryMaindFrom31: TDateTimeField;
    qryMaindTo1: TDateTimeField;
    qryMaindTo2: TDateTimeField;
    qryMaindTo3: TDateTimeField;
    qryMaindTo4: TDateTimeField;
    qryMaindTo5: TDateTimeField;
    qryMaindTo6: TDateTimeField;
    qryMaindTo7: TDateTimeField;
    qryMaindTo8: TDateTimeField;
    qryMaindTo9: TDateTimeField;
    qryMaindTo10: TDateTimeField;
    qryMaindTo11: TDateTimeField;
    qryMaindTo12: TDateTimeField;
    qryMaindTo13: TDateTimeField;
    qryMaindTo14: TDateTimeField;
    qryMaindTo15: TDateTimeField;
    qryMaindTo16: TDateTimeField;
    qryMaindTo17: TDateTimeField;
    qryMaindTo18: TDateTimeField;
    qryMaindTo19: TDateTimeField;
    qryMaindTo20: TDateTimeField;
    qryMaindTo21: TDateTimeField;
    qryMaindTo22: TDateTimeField;
    qryMaindTo23: TDateTimeField;
    qryMaindTo24: TDateTimeField;
    qryMaindTo25: TDateTimeField;
    qryMaindTo26: TDateTimeField;
    qryMaindTo27: TDateTimeField;
    qryMaindTo28: TDateTimeField;
    qryMaindTo29: TDateTimeField;
    qryMaindTo30: TDateTimeField;
    qryMaindTo31: TDateTimeField;
    qryMainType1: TWideStringField;
    qryMainType2: TWideStringField;
    qryMainType3: TWideStringField;
    qryMainType4: TWideStringField;
    qryMainType5: TWideStringField;
    qryMainType6: TWideStringField;
    qryMainType7: TWideStringField;
    qryMainType8: TWideStringField;
    qryMainType9: TWideStringField;
    qryMainType10: TWideStringField;
    qryMainType11: TWideStringField;
    qryMainType12: TWideStringField;
    qryMainType13: TWideStringField;
    qryMainType14: TWideStringField;
    qryMainType15: TWideStringField;
    qryMainType16: TWideStringField;
    qryMainType17: TWideStringField;
    qryMainType18: TWideStringField;
    qryMainType19: TWideStringField;
    qryMainType20: TWideStringField;
    qryMainType21: TWideStringField;
    qryMainType22: TWideStringField;
    qryMainType23: TWideStringField;
    qryMainType24: TWideStringField;
    qryMainType25: TWideStringField;
    qryMainType26: TWideStringField;
    qryMainType27: TWideStringField;
    qryMainType28: TWideStringField;
    qryMainType29: TWideStringField;
    qryMainType30: TWideStringField;
    qryMainType31: TWideStringField;
    btnPrev: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    cmdEmail: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
  private
    fsTablename:String;
    xDateFrom , XDateTo:TDateTime;
    procedure ToBeRefreshed;
    function RosterListQry: TERPQuery;
    function FieldNo(const Value: TDateTime): Integer;
    function ReportSQL(EmployeeID:Integer = 0):String;
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
  GridFieldsObj, tcConst, AppEnvironment, EmailExtraUtils;

{$R *.dfm}
procedure TRosterReportDetailsGUI.actRefreshQryExecute(Sender: TObject);
begin
//  inherited;
  RefreshAll;
end;

procedure TRosterReportDetailsGUI.btnNextClick(Sender: TObject);
var
  Days :Integer;
begin
  inherited;
  Days := DaysBetween(filterDateFrom , Dateof(filterDateTo))+1;
  DtTo.Date   := incday(Dateof(DtTo.Date)   , days);
  Dtfrom.Date := incday(Dateof(DtTo.Date) , 0-(days-1));
  btnRequery.Click;
end;

procedure TRosterReportDetailsGUI.btnPrevClick(Sender: TObject);
var
  Days :Integer;
begin
  inherited;
  Days := DaysBetween(filterDateFrom , Dateof(filterDateTo))+1;
  Dtfrom.Date := incday(DtFrom.Date , 0-days);
  DtTo.Date   := incday(DtFrom.Date   , days-1);
  btnRequery.Click;
end;

procedure TRosterReportDetailsGUI.CalcnShowFooter;
var
  ctr:Integer;
begin
  inherited;
  for ctr := low(FooterCalcfields) to high(FooterCalcfields)-1 do
    GrdMain.ColumnByName(Qrymain.FieldByName('s' + inttostr(ctr+1)).fieldname).FooterValue :=  SecondsToTime(trunc(FooterCalcfields[ctr].Total) , False);
  ctr:=high(FooterCalcfields);
  GrdMain.ColumnByName(qryMainstot.fieldname).FooterValue :=  SecondsToTime(trunc(FooterCalcfields[ctr].Total) , True);
end;

procedure TRosterReportDetailsGUI.cmdEmailClick(Sender: TObject);
var
  s : String;
  //lMode : TSendEmailMode;
  lSilent, lSecret : boolean;
  qry : TERPQuery;
  lCount : integer;

begin
  inherited;
  lSilent := false;
  lSecret := false;

  s:= SelectedIds('employeeId' , True);
  if s= '' then
  begin
    if MessageDlgXP_Vista('You have not selected the employees to send the email to. Do you want to Email all in the list? ', mtConfirmation, [mbyes, mbno] , 0) = mrYes then begin
      Grdmain.SelectAll;
      s:= SelectedIds('employeeId' , True);
    end
    else
      Exit;
  end;

  if ReportName = '' then begin
    MessageDlgXP_Vista('Please Make / Select report Template to Email', mtWarning, [mbOK], 0);
    Exit;
  end;

  qry := tempMyQuery;
//  with tempMyQuery do begin
//  qry.SQL.add('select distinct E.EmployeeID , E.Email , E.EmployeeName from ' +fsTablename +'  T inner join tblemployees  E on T.EmployeeId = E.employeeId where ifnull(E.Email,"") <> ""');
  qry.SQL.add('select distinct E.EmployeeID , E.Email , E.EmployeeName from ' +fsTablename +'  T inner join tblemployees  E on T.EmployeeId = E.employeeId');
  qry.open;
  lCount := CheckEmailAddresses(qry, 'Employee', 'EmployeeName', 'Email');
  if lCount = 0 then
    exit;
//  lMode := EmailSendMode(qry.RecordCount, false);
(*
  lMode := EmailSendMode(lCount, false);
  case lMode of
    smNone: Exit;
    smSend: begin
      lSilent := true;
      lSecret := false;
      end;
    smSendEdit: begin
      lSilent := false;
      lSecret := false;
      end;
    smSilent: begin
      lSilent := true;
      lSecret := true;
      end;
    smSilentEdit: begin
      lSilent := false;
      lSecret := true;
      end;
    end;
*)
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
                    'Roster for the Period of ' + formatDateTime(FormatSettings.ShortDateformat,filterDateFrom)+' to ' + FormatDateTime(FormatSettings.ShortDateformat,filterdateTo) ,
                    qry.FieldByname('Email').asString ,
                    'Roster' ,
                    s,
                    ReportName,
                    getOutGoingFileName('', GetTemporaryTableNameSuffix+'_' +ReportName +qry.FieldByname('EmployeeId').asString, 'PDF'),
                    lSilent, lSecret);
      end;

      qry.Next;
    end;
  //end;
end;

procedure TRosterReportDetailsGUI.cmdPrintClick(Sender: TObject);
begin
  if chkAdvancedPrinting.Checked then begin
    templateSQL:= reportSQL;
    ReportSQLSupplied:= TRue;
  end;
  inherited;
end;

procedure TRosterReportDetailsGUI.dtFromChange(Sender: TObject);
begin
  if DaysBetween(filterDateFrom , filterDateTo) > 31 then dtto.Date := incday(filterDateFrom, 30);
  inherited;
  ToBeRefreshed;
end;

procedure TRosterReportDetailsGUI.dtToChange(Sender: TObject);
begin
  if DaysBetween(filterDateFrom , filterDateTo) > 31 then dtfrom.Date := incday(filterDateto, -30);
  inherited;
  ToBeRefreshed;
end;

function TRosterReportDetailsGUI.ExpressDetailListName: String;
begin
  REsult:= 'TrosterReportGUI';
end;

procedure TRosterReportDetailsGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  //IsGridcustomisable := false;
  CanCreatecustomReport := false;
  xDateFrom:= 0;
  XDateTo:= 0;
  fsTableName := GetUserTemporaryTableName('RosterreportDetails');
  With TempMyScript do try
      SQL.add('Drop table if Exists ' +fstablename +';');
      SQL.add('Create table ' + fstablename );
      SQL.add('(`ID` int(11) NOT NULL AUTO_INCREMENT,');
      SQL.add('`EmployeeId` int(11) NOT NULL DEFAULT 0,');
      SQL.add('`employeeName` varchar(100) , ');
      for ctr := 1 to 31 do SQL.add('`dFrom' + inttostr(ctr) +'` Datetime DEFAULT 0,');
      for ctr := 1 to 31 do SQL.add('`dTo' + inttostr(ctr) +'` Datetime DEFAULT 0,');
      for ctr := 1 to 31 do SQL.add('`Type' + inttostr(ctr) +'` VarChar(50),');
      for ctr := 1 to 31 do SQL.add('`d' + inttostr(ctr) +'` Int(11) DEFAULT 0,');
      for ctr := 1 to 31 do SQL.add('`s' + inttostr(ctr) +'` varchar(50) DEFAULT "",');
      SQL.add('`tot` Int(11) DEFAULT NULL,');
      SQL.add('`stot` varchar(50) DEFAULT NULL,');
      SQL.add('PRIMARY KEY (`ID`)');
      SQL.add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');
      Execute;
      SQL.Clear;
  finally
    Free;
  end;
  Qrymain.SQL.text := 'Select * from ' +fsTablename+' order by EmployeeName';
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

procedure TRosterReportDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
  Refreshall;
  btnCustomize.enabled := False;
  cboFilter.Items.Clear;
  cboFilter.Items.AddObject(QrymainemployeeName.Displaylabel, QrymainemployeeName);
  btnPrev.Visible := Devmode;
  btnNext.Visible := Devmode;
end;

function TRosterReportDetailsGUI.GetReportTypeID: integer;
begin
  REsult:= 112;
end;

procedure TRosterReportDetailsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  s:String;
begin
  inherited;
  if SameText(Field.FieldName , QrymainemployeeName.FieldName) then
    ABrush.Color := clwhite
  else if SameText(Field.FieldName , Qrymainstot.FieldName) then
    ABrush.Color := clTeal
  else
    try
      s:= GuiPrefs.DbGridElement[grdmain].FieldGroupname[Field.FieldName];
      if s <> '' then begin
        if   IsWorkingday(strToDate(s)) then begin
        end else ABrush.Color := $00B9FFFF;
      end;

    Except
    end;
end;

procedure TRosterReportDetailsGUI.RefreshQuery;
begin
  if Searching then RefreshAll else ToBeRefreshed;
end;
procedure TRosterReportDetailsGUI.ToBeRefreshed;
begin
  lblREfreshInfo.visible :=
              ( xDateFrom <> filterdatefrom) or
              (xdateTo   <> Filterdateto) ;
  lblREfreshInfo.Refresh;
end;

procedure TRosterReportDetailsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if fbDateRangeSupplied =False then
    if GuiPrefs.Node.Exists('Options.DateRange') then begin
      DtFrom.Date :=0;
      DtTo.Date   :=  GuiPrefs.Node['Options.DateRange.DateTo'].asDateTime;
      DtFrom.Date :=  GuiPrefs.Node['Options.DateRange.DateFrom'].asDateTime;
    end;
    if GuiPrefs.Node.Exists('Options.Print') then begin
      chkPreview.checked   :=GuiPrefs.Node['Options.Print.ShowPewview'].asBoolean;
      chkAdvancedPrinting.checked :=GuiPrefs.Node['Options.Print.AdvPrint'].asBoolean;
      ChkChooseRpt.checked :=GuiPrefs.Node['Options.Print.chooseTemplate'].asBoolean;
    end;
end;

procedure TRosterReportDetailsGUI.WriteGuiPrefExtra;
begin
  inherited;
  if fbDateRangeSupplied =False then begin
    GuiPrefs.Node['Options.DateRange.DateTo'].asDateTime   := DtTo.Date;
    GuiPrefs.Node['Options.DateRange.DateFrom'].asDateTime := DtFrom.Date;
  end;
  GuiPrefs.Node['Options.Print.ShowPewview'].asBoolean:= chkPreview.checked ;
  GuiPrefs.Node['Options.Print.AdvPrint'].asBoolean   := chkAdvancedPrinting.checked ;
  GuiPrefs.Node['Options.Print.chooseTemplate'].asBoolean   := ChkChooseRpt.checked ;
end;

function  TRosterReportDetailsGUI.RosterListQry:TERPQuery;
var
  s:String;
begin
  s:= 'Select ' +
      ' type, EmployeeId ,  employeeName , Starttime, Endtime  ,  ' +
      ' TIME_TO_SEC(TimeDiff(endtime , starttime)) seconds ,  ' +
      ' FormatSecondsTotime(TIME_TO_SEC(TimeDiff(endtime , starttime))) sseconds ' +
      ' FROM tblroster R ' +
      ' INNER JOIN tblEmployees using (EmployeeID) ' +
      ' WHERE IsOnTheRoster = "T" and  Active="T" and ' +
      '  (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T")) ' +
      '  and starttime >=' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateFrom))+'  and endtime <=' +  Quotedstr(formatDateTime(mysqlDateTimeformat , filterDateTo))
      +' order by EmployeeName, Starttime';
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
Function TRosterReportDetailsGUI.FieldNo(Const Value:TDateTime):Integer;
begin
  Result:= Daysbetween(FilterDateFrom , Value)+1;
end;
procedure TRosterReportDetailsGUI.RefreshAll;
var
  dt:TDate;
  ctr:Integer;
  FNo:Integer;
begin
  if DaysBetween(filterDateFrom , filterDateTo) > 31 then dtto.Date := incday(filterDateFrom, 30);
  Qrymain.disableControls;
  try
    closeDB(Qrymain);
    With TempMyScript do try
      SQL.add('truncate table  ' +fstablename +';');
      Execute;
      SQL.Clear;

      Qrymain.Open;
      RosterListQry;
       if QryRosterList.recordcount > 0 then begin
          QryRosterList.First;
          showProgressbar(WAITMSG , QryRosterList.Recordcount);
          try
            While QryRosterList.Eof = False do begin
              fNo:=FieldNo(QryRosterListStarttime.AsDateTime);
              if (fNo >0)  and (fNo<32) then begin
                if Qrymain.Locate('EmployeeId;Dfrom'+inttostr(fno)+';DTo' + inttostr(fno)+';type' +inttostr(fno) , VarArrayof([QryRosterListemployeeId.AsInteger, NULL, NULL, NULL]) , []) =False then begin
                  Qrymain.Append;
                  QrymainEmployeeId.AsInteger := QryRosterListEmployeeID.AsInteger;
                  QrymainEmployeeName.AsString := QryRosterListEmployeeName.AsString;
                end;
                EditDB(Qrymain);
                Qrymain.FieldByName('DFrom' +inttostr(fno)).asDateTime  := QryRosterListStarttime.AsDateTime;
                Qrymain.FieldByName('DTo' +inttostr(fno)).asDateTime    := QryRosterListEndtime.AsDateTime;
                Qrymain.FieldByName('type' +inttostr(fno)).asString     := QryRosterListType.AsString;
                Qrymain.fieldbyname('d' +inttostr(fno)).asinteger       := QryRosterListseconds.asInteger;
                Qrymain.fieldbyname('s' +inttostr(fno)).asString        := QryRosterListsseconds.AsString;
                Qrymain.Post;
              end;
              stepProgressbar;
              QryRosterList.Next;
            end;
          finally
            HideProgressbar;
          end;
       end;

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
    dt:= filterDatefrom;

    {make all columns invisible and show the fields of the selected date range}
    for ctr := 1 to 31 do begin
        guiprefs.DbGridElement[grdMain].RemoveField('DFrom' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].RemoveField('DTo' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].RemoveField('type' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].RemoveField('s' +inttostr(ctr));
        dt:= incday(dt,1);
    end;
    guiprefs.DbGridElement[grdMain].RemoveField('stot');


    for ctr := 1 to 31 do begin
      if ctr <= Daysbetween(FilterDateFrom , filterdateTo)+1 then begin
        guiprefs.DbGridElement[grdMain].AddField('DFrom' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].AddField('DTo' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].AddField('type' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].AddField('s' +inttostr(ctr));
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['type' + inttostr(ctr)]:= FormatDateTime(FormatSettings.ShortDateformat,  dt (*incday(filterDatefrom, ctr-1)*) );
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['dfrom' + inttostr(ctr)]:= FormatDateTime(FormatSettings.ShortDateformat,  dt (*incday(filterDatefrom, ctr-1)*) );
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['dto' + inttostr(ctr)]:= FormatDateTime(FormatSettings.ShortDateformat,  dt (*incday(filterDatefrom, ctr-1)*) );
        GuiPrefs.DbGridElement[grdmain].FieldGroupname['s' + inttostr(ctr)]:= FormatDateTime(FormatSettings.ShortDateformat,  dt (*incday(filterDatefrom, ctr-1)*) );
      end else begin
        guiprefs.DbGridElement[grdMain].RemoveField('DFrom' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].RemoveField('DTo' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].RemoveField('type' +inttostr(ctr));
        guiprefs.DbGridElement[grdMain].RemoveField('s' +inttostr(ctr));
      end;
      guiprefs.DbGridElement[grdMain].AddField('stot');
      dt:= incday(dt,1);
    end;

    Guiprefs.ApplyGuiPrefs;
  finally
    Qrymain.enableControls;
  end;
  xDateFrom := filterdatefrom;
  xdateTo   := Filterdateto;
  ToBeRefreshed;
end;


procedure TRosterReportDetailsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

function TRosterReportDetailsGUI.ReportSQL(EmployeeID:Integer = 0): String;
var
  ctr: Integer;
  dt:TDateTime;
begin
  REsult:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';

  result:= result + ' ~|||~{Details} Select EmployeeName ';
  for ctr:= 1 to 31 do
    result := result + ','+
               'dfrom' +inttostr(ctr) +','+
               'dTo' +inttostr(ctr) +','+
               'Time(dfrom' +inttostr(ctr) +') as TFrom' + inttostr(ctr)+','+
               'Time(dTo' +inttostr(ctr) +') as Tto' + inttostr(ctr)+','+
               'Type' +inttostr(ctr) +','+
               's' +inttostr(ctr) ;
  result:= result + ',sTot as Total ';
  (*dt:= filterDateFrom;
  for ctr:= 1 to 31 do begin
    result := result + ', ' +Quotedstr(FormatDateTime(FormatSettings.ShortDateformat,  dt)) +' as  dfrom' +inttostr(ctr) + ',' +
                              Quotedstr(FormatDateTime(FormatSettings.ShortDateformat,  dt)) +' dTo' +inttostr(ctr) +',' +
                              Quotedstr('xxxx' ) +' as Type' +inttostr(ctr) +',' +
                              Quotedstr('00:00:00') +' as s' +inttostr(ctr);
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

procedure TRosterReportDetailsGUI.SetGridColumns;
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
  RegisterClassOnce(TRosterReportDetailsGUI);

end.

