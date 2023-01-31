unit RosterListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;


type
  pTimesRec = ^TTimesRec;
  TTimesRec = record
    iEmployeeID: integer;
    dtStart: TDateTime;
    dtEnd: TDateTime;
    bMatched: boolean;
  end;

type
  TRosterListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainRosterID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainStartTime: TDateTimeField;
    qryMainClockedOff: TWideStringField;
    qryMainStartedLate: TWideStringField;
    qryMainFinishedEarly: TWideStringField;
    qryMainEndTime: TDateTimeField;
    qryMainHours: TFloatField;
    qryMaindetail: TLargeintField;
    qryMainRosterBreaktype: TWideStringField;
    qryMainBreakStartTime: TDateTimeField;
    qryMainBreakEndtime: TDateTimeField;
    qryMainRosterdate: TDateField;
    qryMainfHours: TWideMemoField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainUpdateFooter(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainEndTimeGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    { Private declarations }
    Tablename: string;
    procedure CreateTempRosterTable;
    procedure CheckTimes;
    //procedure FormatEndTime;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;

  public
    { Public declarations }
  end;

implementation

uses
  CommonDbLib, DateUtils, CommonLib, BusObjRoster, DbSharedObjectsObj,
  MySQLConst;

{$R *.dfm}

{ TRosterListGUI }

procedure TRosterListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.Dateto') and (dtTo.date <> GuiPrefs.Node['Options.Dateto'].asDateTime) then begin
      dtTo.date :=  GuiPrefs.Node['Options.Dateto'].asDateTime;
      fbDateRangeSupplied := true;
    end;
    if GuiPrefs.Node.Exists('Options.Datefrom') and (dtFrom.date <> GuiPrefs.Node['Options.Datefrom'].asDateTime) then begin
      dtFrom.date :=  GuiPrefs.Node['Options.Datefrom'].asDateTime;
      fbDateRangeSupplied := true;
    end;
    actRefreshQryExecute(actRefreshQry);
end;

procedure TRosterListGUI.RefreshQuery;
begin
  if not Self.ErrorOccurred then begin
    CreateTempRosterTable;
    //FormatEndTime;
    inherited;
  end;
end;

//procedure TRosterListGUI.FormatEndTime;
//var
//  tmpDate:TDateTime;
//begin
//  if not qryMain.Active then qryMain.Open;
//  qryMain.First;
//  while not qryMain.Eof do begin
//    if qryMain.fieldbyname('EndTime').AsString <> '' then
//
//    tmpDate := qryMain.fieldbyname('EndTime').asDateTime;
//    qryMain.Edit;
//    qryMainEndTime.AsString := FormatDateTime('dd/mm/yyyy hh:mm:ss',tmpDate);
//    qryMain.Post;
//    qryMain.Next;
//  end;
//end;

procedure TRosterListGUI.CheckTimes;
var
  i: integer;
  qry: TERPQuery;
  lstRostered: TList;
  pRostered: pTimesRec;
  dtStart, dtEnd: TDateTime;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  lstRostered := TList.Create;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT RosterID, EmployeeID, Type, StartTime, EndTime, ClockedOff ' +
      'FROM tblroster ' +
      'WHERE Type in ( '+ Quotedstr(rtAllocation) +',' + quotedstr(rtBOMClocked) +') ' +
      ' AND StartTime BETWEEN ' +   Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdatefrom))+ ' and  ' +   Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateto))+ ' ' +
      'ORDER BY StartTime');
    qry.Open;
    qry.First;

    while not qry.Eof do begin
      New(pRostered);
      lstRostered.Add(pRostered);
      pRostered^.iEmployeeID := qry.FieldByName('EmployeeID').AsInteger;
      pRostered^.dtStart := qry.FieldByName('StartTime').AsDateTime;
      pRostered^.dtEnd := qry.FieldByName('EndTime').AsDateTime;
      pRostered^.bMatched := false;
      qry.Next;
    end;

    qry.Close;


    qry.SQL.Clear;
    qry.SQL.Add('SELECT ID, RosterID, EmployeeID, Type, StartTime, EndTime, ClockedOff, ' +
      'StartedLate, FinishedEarly ' +
      'FROM ' + Tablename + ' ' +
      'WHERE Type = "Clocked" ' +
      'ORDER BY StartTime');
    qry.Open;

    // now check the actual hours aginst the rostered hours
    qry.First;

    while not qry.Eof do begin
      dtStart := qry.FieldByName('StartTime').AsDateTime;
      dtEnd := qry.FieldByName('EndTime').AsDateTime;
      for i := 0 to lstRostered.Count - 1 do begin
        pRostered := lstRostered[i];
        if (not pRostered^.bMatched) and
          (pRostered^.iEmployeeId = qry.FieldByName('EmployeeID').AsInteger) and
          (((pRostered^.dtStart <= dtStart) and (pRostered^.dtEnd >= dtStart)) or
           ((pRostered^.dtStart <= dtEnd)   and (pRostered^.dtEnd >= dtEnd  )) or
           ((pRostered^.dtStart >= dtStart) and (pRostered^.dtEnd <= dtEnd  ))) then begin
          qry.Edit;

          if dtStart > pRostered^.dtStart then begin qry.FieldByName('StartedLate').AsString := 'Yes';
          end else begin qry.FieldByName('StartedLate').AsString := 'No';
          end;

          if qry.FieldByName('ClockedOff').AsString = 'T' then begin
            if dtEnd < pRostered^.dtEnd then begin qry.FieldByName('FinishedEarly').AsString := 'Yes';
            end else begin qry.FieldByName('FinishedEarly').AsString := 'No';
            end;
          end;

          qry.Post;
          pRostered^.bMatched := true;
          Break;
        end;
      end; // for i := 0....
      qry.Next;
    end;
    qry.Close;

  finally
    for i := 0 to lstRostered.Count - 1 do begin
      Dispose(lstRostered.Items[i]);
    end;
    FreeandNil(lstRostered);
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TRosterListGUI.CreateTempRosterTable;
var
  scr :TERPScript;
begin
  scr := DbSharedObj.GetScript(GetSharedMyDacConnection) ;
  try
    with scr do begin
      SQL.add('DROP TABLE IF EXISTS ' + Tablename+';');
      SQL.add('CREATE TABLE IF NOT EXISTS ' + Tablename + ' ( ');
      SQL.add('ID int(11) NOT NULL auto_increment, ');
      SQL.add('PRIMARY KEY (ID)) ');
      SQL.add('SELECT  R.GlobalRef, ' +
                      ' RosterID,  ' +
                      ' R.EmployeeID,  ' +
                      ' R.Type,  ' +
                      ' EmployeeName,  ' +
                      ' ClassName,  ' +
                      ' StartTime,  ' +
                      ' EndTime, ' +
                      ' R.ClockedOff,  ' +
                      ' R.Date,  ' +
                      ' "Not Rostered" as StartedLate,  ' +
                      ' "            " as FinishedEarly ' +
              ' FROM tblRoster as R ' +
              ' INNER JOIN tblEmployees using (EmployeeID) ' +
              ' LEFT JOIN tblClass ON tblClass.ClassID = R.ClassID ' +
              ' WHERE R.Type = "Clocked"' +
              ' AND StartTime BETWEEN ' +   Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdatefrom))+ ' and  ' +   Quotedstr(formatDateTime(MysqlDateTimeFormat , filterdateto))+ '');
      Execute;
    end;
    CheckTimes;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;


procedure TRosterListGUI.FormCreate(Sender: TObject);
begin
  Tablename         := commondblib.GetUserTemporaryTableName('tblRoster');// + GetMachineIdentification(true, true, true, true);
  qryMain.SQL.clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('0 as detail,');
  qryMain.SQL.Add('T.GlobalRef as GlobalRef ,');
  qryMain.SQL.Add('T.Date as RosterDate ,');
  //qryMain.SQL.Add(' Sum(if(ClockedOff="F" , 0 , (EndTime - StartTime))/24/360)  as Hours,');
  qryMain.SQL.Add('   Sum(if(ClockedOff="F" , 0 , ((TIME_TO_SEC(ENDTIME ) - TIME_TO_SEC(STARTTIME ))/60/60))) as Hours,');
  qryMain.SQL.Add('   FormatSecondsTotime(Sum(if(ClockedOff="F" , 0 , ((TIME_TO_SEC(ENDTIME ) - TIME_TO_SEC(STARTTIME )))))) as fHours,');
  qryMain.SQL.Add('RosterID as RosterID,');
  qryMain.SQL.Add('EmployeeID as EmployeeID,');
  qryMain.SQL.Add('EmployeeName as EmployeeName,');
  qryMain.SQL.Add('ClassName  as ClassName,');
  qryMain.SQL.Add('DATE_ADD(DATE_ADD(StartTime,INTERVAL 1 SECOND),INTERVAL -1 SECOND) as StartTime,');
  qryMain.SQL.Add('DATE_ADD(DATE_ADD(EndTime,INTERVAL 1 SECOND),INTERVAL -1 SECOND) as EndTime,');
  qryMain.SQL.Add('ClockedOff as ClockedOff,');
  qryMain.SQL.Add('StartedLate as StartedLate,');
  qryMain.SQL.Add('FinishedEarly as FinishedEarly,');
  qryMain.SQL.Add('NULL as RosterBreaktype,');
  qryMain.SQL.Add('NULL  as BreakStartTime ,');
  qryMain.SQL.Add('NULL as BreakEndtime');
  qryMain.SQL.Add('FROM  ' + Tablename +'  T');
  qryMain.SQL.Add('GROUP BY EmployeeID , T.Date');
  qryMain.SQL.Add('union all');
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('1 as detail,');
  qryMain.SQL.Add('T.GlobalRef as GlobalRef,');
  qryMain.SQL.Add('T.Date as RosterDate ,');
  //qryMain.SQL.Add('(EndTime - StartTime)  as Hours,');
  //qryMain.SQL.Add(' if(ClockedOff="F" , 0 , ((EndTime - StartTime))/24/360)  as Hours,');
  qryMain.SQL.Add('   if(ClockedOff="F" , 0 , ((TIME_TO_SEC(ENDTIME ) - TIME_TO_SEC(STARTTIME ))/60/60)) as Hours,');
  qryMain.SQL.Add('   FormatSecondsTotime(if(ClockedOff="F" , 0 , ((TIME_TO_SEC(ENDTIME ) - TIME_TO_SEC(STARTTIME ))))) as fHours,');

  qryMain.SQL.Add('RosterID as RosterID,');
  qryMain.SQL.Add('EmployeeID as EmployeeID,');
  qryMain.SQL.Add('EmployeeName as EmployeeName,');
  qryMain.SQL.Add('ClassName as ClassName,');
  qryMain.SQL.Add('DATE_ADD(DATE_ADD(StartTime,INTERVAL 1 SECOND),INTERVAL -1 SECOND) as StartTime,');
  qryMain.SQL.Add('DATE_ADD(DATE_ADD(EndTime,INTERVAL 1 SECOND),INTERVAL -1 SECOND) as EndTime,');
  qryMain.SQL.Add('ClockedOff as ClockedOff,');
  qryMain.SQL.Add('StartedLate as StartedLate,');
  qryMain.SQL.Add('FinishedEarly as FinishedEarly,');
  qryMain.SQL.Add('NULL as RosterBreaktype,');
  qryMain.SQL.Add('NULL  as BreakStartTime ,');
  qryMain.SQL.Add('NULL as BreakEndtime');
  qryMain.SQL.Add('FROM  ' + Tablename +'  T');
  qryMain.SQL.Add('union all');
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('2 as detail,');
  qryMain.SQL.Add('T.GlobalRef as GlobalRef,');
  qryMain.SQL.Add('T.Date as RosterDate ,');
  //qryMain.SQL.Add('(T.EndTime - T.StartTime)  as Hours,');
  //qryMain.SQL.Add(' if(ClockedOff="F" , 0 , ((T.EndTime - T.StartTime)/24/360))  as Hours,');
  qryMain.SQL.Add('   if(ClockedOff="F" , 0 , ((TIME_TO_SEC(T.ENDTIME ) - TIME_TO_SEC(T.STARTTIME ))/60/60)) as Hours,');
  qryMain.SQL.Add('   FormatSecondsTotime(if(ClockedOff="F" , 0 , ((TIME_TO_SEC(T.ENDTIME ) - TIME_TO_SEC(T.STARTTIME ))))) as fHours,');

  qryMain.SQL.Add('T.RosterID as RosterID,');
  qryMain.SQL.Add('T.EmployeeID as EmployeeID,');
  qryMain.SQL.Add('T.EmployeeName as EmployeeName ,');
  qryMain.SQL.Add('T.ClassName as ClassName,');
  qryMain.SQL.Add('DATE_ADD(DATE_ADD(T.StartTime,INTERVAL 1 SECOND),INTERVAL -1 SECOND) as StartTime,');
  qryMain.SQL.Add('DATE_ADD(DATE_ADD(T.EndTime,INTERVAL 1 SECOND),INTERVAL -1 SECOND) as EndTime,');
  qryMain.SQL.Add('T.ClockedOff as ClockedOff,');
  qryMain.SQL.Add('T.StartedLate as StartedLate,');
  qryMain.SQL.Add('T.FinishedEarly as FinishedEarly,');
  qryMain.SQL.Add('RB.RosterBreaktype as RosterBreaktype,');
  qryMain.SQL.Add('RB.Starttime as BreakStartTime ,');
  qryMain.SQL.Add('RB.Endtime as BreakEndtime');
  qryMain.SQL.Add('FROM  ' + Tablename +'  T');
  qryMain.SQL.Add('inner join tblrosterbreak RB  on RB.RosterID = T.RosterID');
  qryMain.SQL.Add('ORDER BY  EmployeeName,Rosterdate desc , Detail,  StartTime  DESC ');
  inherited;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TRosterListGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TRosterListGUI.FormShow(Sender: TObject);
begin
  if not ErrorOccurred then begin
    inherited;
  end else begin
    CommonLib.MessageDlgXP_Vista('You do not have access to Roster List Form', mtInformation, [mbOK], 0);
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    Exit;
  end;
end;

procedure TRosterListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRosterListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRosterListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRosterListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRosterListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
(*var
//  date1, date2: TDateTime;
  difference: double;
  wYear,wMonth,wDay,wHour, wMin, wSec, wMSec:Word;
begin
  inherited;
  DecodeDate(qryMainStartTime.AsDateTime,wYear,wMonth,wDay);
  DecodeTime(qryMainStarttime.asDateTime,wHour,wMin,wSec,wMSec);


 // date1 := EncodeDate(2006, 01, 15);
 // date2 := EncodeDate(2000, 01, 01);
  difference := qryMainEndtime.AsDateTime - qryMainStartTime.AsDateTime;
 /// ShowMessage(FormatFloat('####0.00',difference * 24));
  if difference >= 0 then
    qrymainhours.AsFloat := difference * 24
  else
    qrymainhours.AsFloat := 0;*)
end;

procedure TRosterListGUI.RefreshTotals;
begin
  inherited;
  grdMainUpdateFooter(Self);
end;

procedure TRosterListGUI.SetGridColumns;
begin
  inherited;
  if not devmode then begin
    RemoveFieldfromGrid(Qrymaindetail.FieldName);
  end;
  RemoveFieldfromGrid(QrymainRosterID.FieldName);
  RemoveFieldfromGrid(QrymainEmployeeID.FieldName);
end;

procedure TRosterListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.DateFrom'].asDateTime := dtFrom.date;
  GuiPrefs.Node['Options.Dateto'].asDateTime := dtTo.date;
end;

procedure TRosterListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if grpfilters.ItemIndex =0 then begin
  end else if (grpfilters.ItemIndex >0) and (qryMaindetail.asinteger = 0) then begin
    AFont.Style := AFont.Style +[fsBold];
  end else if (qryMaindetail.asinteger = 1) then begin
    if  (sametext(field.fieldname ,qryMainemployeeName.fieldname) or
            sametext(field.fieldname ,qryMainClassname.fieldname) or
            sametext(field.fieldname ,qryMainRosterDate.fieldname)) then
      AFont.color := aBrush.color;
  end else if qryMaindetail.asinteger = 2 then begin
    if not (sametext(field.fieldname ,qryMainRosterBreaktype.fieldname) or
            sametext(field.fieldname ,qryMainBreakStartTime.fieldname) or
            sametext(field.fieldname ,qryMainBreakEndtime.fieldname)) then
      AFont.color := aBrush.color;
    if sametext(field.fieldname ,qryMainBreakEndtime.fieldname  ) and (qryMainBreakEndtime.asDatetime   =0) then AFont.color := aBrush.color;
    if sametext(field.fieldname ,qryMainBreakStartTime.fieldname) and (qryMainBreakStartTime.asDatetime =0) then AFont.color := aBrush.color;
  end;
end;

procedure TRosterListGUI.grdMainUpdateFooter(Sender: TObject);
var
  dHours: double;
  oRecPointer: TBookmark;
begin
  inherited;
  dHours := 0;

  qryMain.DisableControls;
  oRecPointer := qryMain.GetBookmark;
  try
    qryMain.First;
    while not qryMain.Eof do begin
      if grpFilters.ItemIndex in [1,2] then
      begin
        if qryMain.FieldByName('Detail').AsInteger = 0 then
          dHours := dHours + qryMain.FieldByName('Hours').AsFloat;
      end
      else
        dHours := dHours + qryMain.FieldByName('Hours').AsFloat;
      qryMain.Next;
    end;
  finally
    qryMain.GoToBookmark(oRecPointer);
    qryMain.FreeBookmark(oRecPointer);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Hours').FooterValue := FloatToStrF(dHours, ffFixed, 15, 2);

end;


procedure TRosterListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Detail = 0' ;
    1:  GroupFilterString := 'Detail = 0 or Detail = 1';
    2:  GroupFilterString := '';
  end;
  inherited;
  if grpFilters.ItemIndex in [0,1] then begin
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainRosterBreaktype.fieldname);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainBreakStartTime.fieldname);
    GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainBreakEndtime.fieldname);
  end else begin
    GuiPrefs.DbGridElement[grdMain].AddField(qryMainRosterBreaktype.fieldname);
    GuiPrefs.DbGridElement[grdMain].AddField(qryMainBreakStartTime.fieldname);
    GuiPrefs.DbGridElement[grdMain].AddField(qryMainBreakEndtime.fieldname);
  end;
end;

procedure TRosterListGUI.qryMainEndTimeGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsDateTime > 0 then
    Text:= Sender.AsString;
end;

initialization
  RegisterClassOnce(TRosterListGUI);
end.
