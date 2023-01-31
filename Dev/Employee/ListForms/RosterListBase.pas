unit RosterListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, DBCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TRosterListBaseGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainRosterId: TIntegerField;
    qryMainTimeSheetID: TIntegerField;
    qryMainClassId: TIntegerField;
    qryMainemployeeId: TIntegerField;
    qryMainDate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainRosterTime: TWideStringField;
    qryMainclockedOff: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainRosterBreaktype: TWideStringField;
    qryMainstarttime: TDateTimeField;
    qryMainEndtime: TDateTimeField;
    qryMainRosterStarttime: TDateTimeField;
    qryMainRosterEndtime: TDateTimeField;
    qryMainBreakTime: TWideStringField;
    qryMainBreakTimeinSecs: TIntegerField;
    qryMainRosterTimeinSecs: TIntegerField;
    QrymainHours :TFloatfield;
    qryMainRosterStartAt: TWideStringField;
    qryMainRosterEndAt: TWideStringField;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    pnlRosterEnd: TDNMPanel;
    lbltotaljob: TLabel;
    lbltotalbreak: TLabel;
    lbltotaltime: TLabel;
    edtRosterStartAt: TDBText;
    lblRosterStartAt: TLabel;
    edtRosterEndAt: TDBText;
    lblRosterEndAt: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    fiemployeeId: Integer;
    fitotaltime, fitotalbreak, fitotaljob:double;
    procedure setemployeeId(const Value: Integer);
    function getemployeeId: Integer;
  Protected
    Tablename :String;
    procedure SetGridColumns; Override;
    function HideIfClockedOff :Boolean; virtual;
    Procedure RefreshTotals;override;
    Procedure CalcFooter;Override;
  public
    Procedure RefreshQuery;Override;
    Property employeeId :Integer read getemployeeId write setemployeeId;
  end;


implementation

uses CommonDbLib, DbSharedObjectsObj, LogLib, CommonLib, MySQLConst, tcConst;

{$R *.dfm}


procedure TRosterListBaseGUI.CalcFooter;
begin
    if Qrymaindetails.AsInteger = 1 then fitotaltime := fitotaltime + qryMainRosterTimeinSecs.AsInteger;
    if Qrymaindetails.AsInteger = 2 then fitotalbreak := fitotalbreak + qryMainBreakTimeinSecs.AsInteger;
    if Qrymaindetails.AsInteger = 3 then fitotaljob := fitotaljob + qryMainBreakTimeinSecs.AsInteger;
end;

procedure TRosterListBaseGUI.FormCreate(Sender: TObject);
begin
(*  lbltotaltime.caption :=' ';
  lbltotalbreak.caption :=' ';
  lbltotaljob.caption :=' ';*)
  //Header.sections.clear;
  fiemployeeId := 0;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  AddCalccolumn(qryMainBreakTimeinSecs.fieldname , False);
  AddCalccolumn(qryMainRosterTimeinSecs.fieldname, False);
end;

procedure TRosterListBaseGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

function TRosterListBaseGUI.getemployeeId: Integer;
begin
  result := fiEmployeeId;
  if assigned(EmployeeLookupform) then Result := EmployeeLookupform.LookupId;
end;

procedure TRosterListBaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sametext(qryMainstarttime.FieldName , Field.Fieldname) or
     Sametext(qryMainEndtime.FieldName , Field.Fieldname) or
     Sametext(qryMainRosterTime.FieldName , Field.Fieldname) or
     Sametext(qryMainStatus.FieldName , Field.Fieldname) or
     Sametext(qryMainclockedOff.FieldName , Field.Fieldname) then ABrush.color := GridColhighLightGreen;


  if Sametext(qryMainRosterBreaktype.FieldName , Field.Fieldname) or
     Sametext(qryMainRosterStarttime.FieldName , Field.Fieldname) or
     Sametext(qryMainRosterEndtime.FieldName , Field.Fieldname) or
     Sametext(qryMainBreakTime.FieldName , Field.Fieldname) then ABrush.color := GridColhighLightYellow1;

  if (Qrymaindetails.AsInteger <> 1) and (sametext(qrymainDate.FieldName , Field.Fieldname) or
      sametext(qrymainEmployeeName.FieldName , Field.Fieldname) or
      sametext(qrymainstarttime.FieldName , Field.Fieldname) or
      sametext(qrymainEndtime.FieldName , Field.Fieldname) or
      sametext(qrymainRosterTime.FieldName , Field.Fieldname) or
      sametext(qrymainclockedOff.FieldName , Field.Fieldname) or
      sametext(qrymainStatus.FieldName , Field.Fieldname)) then Afont.color := ABrush.Color;

end;

procedure TRosterListBaseGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.ItemIndex = 0 then groupfilterString := 'Details =1'
  else if grpfilters.ItemIndex = 1 then groupfilterString := 'Details =1 or Details =3'
  else if grpfilters.ItemIndex = 2 then groupfilterString := 'Details =1 or Details =2'
  else if grpfilters.ItemIndex = 3 then groupfilterString := '';
  inherited;
end;

function TRosterListBaseGUI.HideIfClockedOff: Boolean;
begin
  REsult := False;
end;

procedure TRosterListBaseGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainstarttime.DisplayFormat  := FormatSettings.ShortTimeFormat;
  qryMainEndtime.DisplayFormat    := FormatSettings.ShortTimeFormat;
  qryMainRosterStarttime.DisplayFormat := FormatSettings.ShortTimeFormat;
  qryMainRosterEndtime.DisplayFormat   := FormatSettings.ShortTimeFormat;
  (*qryMainRosterStartAt.DisplayFormat  := FormatSettings.ShortDateformat +' '+ FormatSettings.ShortTimeFormat;
  qryMainRosterEndAt.DisplayFormat    := FormatSettings.ShortDateformat +' '+ FormatSettings.ShortTimeFormat;*)

(*  lblRosterStartAt.Font.Color := clgray;
  edtRosterStartAt.Font.Color := clgray;
  lblRosterEndAt.Font.Color := clgray;
  edtRosterEndAt.Font.Color := clgray;*)
(*  lblRosterStartAt.visible := Qrymain.recordcount >0;
  edtRosterStartAt.visible := Qrymain.recordcount >0;
  lblRosterEndAt.visible := Qrymain.recordcount >0;
  edtRosterEndAt.visible := Qrymain.recordcount >0;*)
  pnlRosterEnd.visible := Qrymain.recordcount >0;
end;

procedure TRosterListBaseGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainEndtime.AsDateTime  = 0 then qryMainRosterEndAt.AsString  := '' else qryMainRosterEndAt.asString   := Formatdatetime(formatSettings.ShortDateFormat +' '+ formatSettings.ShortTimeFormat , qryMainEndtime.AsDateTime);
  if qryMainStarttime.AsDateTime= 0 then qryMainRosterStartAt.AsString:= '' else qryMainRosterStartAt.asString := Formatdatetime(formatSettings.ShortDateFormat +' '+ formatSettings.ShortTimeFormat , qryMainStarttime.AsDateTime);
end;

procedure TRosterListBaseGUI.RefreshQuery;
begin

  With SctMain do try
    SQL.Clear;
    SQL.Add('Drop table if exists ' + tablename +';');
    SQL.Add('DROP TABLE IF EXISTS ' + tablename +';');
    SQL.Add('CREATE TABLE ' + Tablename + ' ( ' +
                ' ID              INT(1) NOT NULL AUTO_INCREMENT, ' +
                ' Details         INT(1) NOT NULL DEFAULT 0, ' +
                ' EmployeeID      INT(1) NOT NULL DEFAULT 0, ' +
                ' RosterId        INT(1) NOT NULL DEFAULT 0, ' +
                ' TimeSheetID     INT(1) NOT NULL DEFAULT 0, ' +
                ' ClassId         INT(1) NOT NULL DEFAULT 0, ' +
                ' Date            DATE NULL DEFAULT NULL, ' +
                ' StartTime       DATETIME NULL DEFAULT NULL, ' +
                ' Endtime         DATETIME NULL DEFAULT NULL, ' +
                ' RosterTimeinSecs INT(11), ' +
                ' Hours           DOUBLE, ' +
                ' RosterTime      VARCHAR(30),'+
                ' clockedOff      ENUM("T","F") NOT NULL DEFAULT "T" , ' +
                ' Status          VARCHAR(50) NOT NULL DEFAULT "", ' +
                ' RosterBreaktype VARCHAR(100) NULL DEFAULT NULL, ' +
                ' RosterStarttime DATETIME NULL DEFAULT NULL, ' +
                ' RosterEndtime   DATETIME NULL DEFAULT NULL, ' +
                ' BreakTime       VARCHAR(30),' +
                ' BreakTimeinSecs INT(11), ' +
                ' PRIMARY KEY (ID)) ' +
                ' COLLATE="utf8_general_ci" '+
                ' ENGINE=MyISAM;');
    SQL.Add('Insert ignore into ' + tablename +' (Details, EmployeeID, RosterID,ClassId,Date,StartTime,Endtime,clockedOff )'+
                                                ' SELECT 1, EmployeeID, RosterId ,ClassId, Date , starttime ,Endtime ,clockedOff   '+
                                                ' FROM tblroster '+
                                                ' Where Type = "Clocked" ' + iif(EmployeeId <> 0, ' and  employeeId = '+ inttostr(EmployeeID) , '') +
                                                iif(HideIfClockedOff , ' and ifnull(Endtime,"1899-12-30 00:00:00")="1899-12-30 00:00:00"' , '')+
                                                ' and ( starttime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +
                                                '  or Endtime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +' );');

   SQL.Add('Insert ignore into ' + tablename +' (Details, EmployeeID , RosterID,ClassId,Date,StartTime,Endtime,clockedoff , RosterBreaktype , RosterStarttime, RosterEndtime)'+
                                                ' SELECT 2, R.employeeId, R.RosterId ,R.ClassId,  R.Date ,R.starttime ,R.Endtime,R.clockedOff ,RB.RosterBreaktype ,RB.Starttime ,RB.Endtime '+
                                                ' FROM tblroster  R '+
                                                ' inner join tblrosterbreak RB on R.RosterID = RB.RosterID'+
                                                ' Where R.Type = "Clocked" ' + iif(EmployeeId <> 0, ' and  R.employeeId = '+ inttostr(EmployeeID) , '') +
                                                iif(HideIfClockedOff , ' and ifnull(RB.Endtime,"1899-12-30 00:00:00")="1899-12-30 00:00:00" and ifnull(R.Endtime,"1899-12-30 00:00:00")="1899-12-30 00:00:00" ' , '')+
                                                ' and  (R.starttime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +
                                                '  or R.Endtime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +' );');

   SQL.Add('Insert ignore into ' + tablename +' (Details, employeeId, RosterID,ClassId,Date,StartTime,Endtime,clockedoff , RosterBreaktype , RosterStarttime, RosterEndtime)'+
                                                ' SELECT 3, R.employeeId , R.RosterId ,R.ClassId ,R.Date ,R.starttime ,R.Endtime,R.clockedOff ,concat("sale #" , SL.SaleId, " - " , PT.caption , "(" , PS.Description ,")")  ,ppt.Timestart  ,ppt.TimeEnd  '+
                                                ' from tblroster R '+
                                                ' inner join tblprocessparttimesheet ppt  on R.employeeId = PPT.employeeId and  (ppt.timestart between R.starttime and R.endtime  or  '+
                                                                                                                                ' ifnull(ppt.TimeEnd, "1899-12-30 00:00:00") between R.starttime and R.endtime or   '+
                                                                                                                                ' (R.endtime = "1899-12-30 00:00:00" and ifnull(ppt.TimeEnd, "1899-12-30 00:00:00")= "1899-12-30 00:00:00" and R.StartTime <= ppt.Timestart))   '+
                                                ' inner join tblprocesspart PP on PPT.ProcessPartID = PP.ID '+
                                                ' inner join tblProcTree PT on PT.proctreeId = PP.proctreeId '+
                                                ' inner join tblsaleslines SL on SL.saleLineId = PT.masterId '+
                                                ' inner join tblprocessstep PS on PS.ID = PP.ProcessStepID '+
                                                ' Where R.Type = "Clocked" ' + iif(EmployeeId <> 0, ' and  R.employeeId = '+ inttostr(EmployeeID) , '') +
                                                iif(HideIfClockedOff , ' and ifnull(ppt.TimeEnd,"1899-12-30 00:00:00")="1899-12-30 00:00:00" and ifnull(R.Endtime,"1899-12-30 00:00:00")="1899-12-30 00:00:00" ' , '')+
                                                ' and  (R.starttime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +
                                                '  or R.Endtime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +' );');

    SQL.Add('update '+tablename +' Set RosterTimeinSecs = TIMESTAMPDIFF(second, starttime       ,if(ifnull(endtime,"1899-12-30 00:00:00")       = "1899-12-30 00:00:00" , now() ,endtime )) , '+
                                  ' RosterTime = FormatSecondsTotime(TIMESTAMPDIFF(second, starttime       ,if(ifnull(endtime,"1899-12-30 00:00:00")       = "1899-12-30 00:00:00" , now() ,endtime ))) ;');
    SQL.Add('update '+tablename +' Set BreakTimeinSecs = TIMESTAMPDIFF(second, RosterStarttime ,if(ifnull(RosterEndtime,"1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() ,RosterEndtime )),'+
                                  ' BreakTime  = FormatSecondsTotime(TIMESTAMPDIFF(second, RosterStarttime ,if(ifnull(RosterEndtime,"1899-12-30 00:00:00") = "1899-12-30 00:00:00" , now() ,RosterEndtime ))) ;');
    SQL.Add('update '+tablename +' Set hours = Round(RosterTimeinSecs /60/60, 4) where ifnull(RosterTimeinSecs,0)<>0; ');
    SQL.Add('Drop table if exists '+tablename +'1;');
    SQL.Add('Create table ' + tablename +'1 ( SELECT R.RosterId ,Max(RosterBreakId) as RosterBreakId '+
                                                ' FROM tblroster  R '+
                                                ' inner join tblrosterbreak RB on R.RosterID = RB.RosterID'+
                                                ' Where R.Type = "Clocked" and  R.employeeId = '+ inttostr(EmployeeID)+
                                                ' and  R.starttime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +
                                                '  or R.Endtime between '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateFrom)) +'  and '+ Quotedstr(formatDateTime(mySQLDateTimeformat , filterDateTo)) +'  group by R.RosterID);');

    SQL.Add(' update '+ tablename +' set Status = if(clockedOff="T" , "Clocked-OFF" , "Clocked-ON");');
    SQL.Add(' update '+tablename +' t  '+
            ' inner join '+ tablename +'1 as t1 on T.rosterId = t1.rosterId and T.details =1  '+
            ' inner join tblrosterbreak RB on T1.RosterBreakId = RB.RosterBreakId  '+
            ' Set T.status = RB.RosterBreaktype where ifnull(RosterEndtime,0) = "1899-12-30 00:00:00";');
    SQL.Add('Drop table if exists '+tablename +'1;');
    SQL.Add(' update '+tablename +' R    inner join tbltimesheets T on T.rosterId = R.RosterID Set R.timesheetId = T.ID;');
    clog(SQL.Text);
    Execute;
  finally
    SQL.Clear;
  end;
  inherited;

end;

procedure TRosterListBaseGUI.RefreshTotals;
begin
  fitotaltime:=0 ;
  fitotalbreak:= 0;
  fitotaljob:=0;
  inherited;
  CalcnshowFooter;
  lbltotaljob.Caption   := 'Total Time On Job : ' + SecondsToTime(trunc(fitotaljob), False, false , '00:00:00');
  lbltotalbreak.Caption := 'Total Time On Break : ' + SecondsToTime(trunc(fitotalbreak), False, false , '00:00:00');
  lbltotaltime.Caption  := 'Total Clocked On Time : ' + SecondsToTime(trunc(fitotaltime ), False, false , '00:00:00');
(*  lbltotaljob.Font.Color := clREd; lbltotaljob.refresh;
  lbltotalbreak.Font.Color := clNavy;lbltotalbreak.refresh;
  lbltotaltime.Font.Color := ClGreen;lbltotaltime.refresh;*)
end;

procedure TRosterListBaseGUI.setemployeeId(const Value: Integer);
begin
  fiemployeeId := Value;
  if Assigned(EmployeeLookupform)    then
    EmployeeLookupform.LookupId := Value;
end;

procedure TRosterListBaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(QrymainDetails.fieldname);
  RemoveFieldfromGrid(QrymainRosterId.fieldname);
  RemoveFieldfromGrid(QrymainTimeSheetID.fieldname);
  RemoveFieldfromGrid(QrymainHours.fieldname);
  RemoveFieldfromGrid(QrymainClassId.fieldname);
  RemoveFieldfromGrid(QrymainEmployeeId.fieldname);
  RemoveFieldfromGrid(qryMainBreakTimeinSecs.fieldname);
  RemoveFieldfromGrid(qryMainRosterTimeinSecs.fieldname);
  RemoveFieldfromGrid(qryMainRosterStartAt.fieldname);
  RemoveFieldfromGrid(qryMainRosterEndAt.fieldname);
end;

end.

