unit RosterBreakList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RosterListBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,
  CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  DBCtrls, tctypes;

type
  TRosterBreakListGUI = class(TRosterListBaseGUI)
    btntimeSheet: TDNMSpeedButton;
    qryMainTimesheetcreated: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btntimeSheetClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    fLoadroster: TGeneralDatasetProc;
  Protected
    function DEfaultSelectedEmployeeID: Integer;Override;
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Property Loadroster :TGeneralDatasetProc read fLoadroster write fLoadroster;
    procedure CreateTimeSheetforRosters;
  end;


implementation

uses CommonDbLib, BaseListingForm, CommonLib, frmTimeSheetGUI;

{$R *.dfm}
function TRosterBreakListGUI.DEfaultSelectedEmployeeID: Integer;
begin
  result := inherited DEfaultSelectedEmployeeID;
  if EmployeeId <> 0 then result := EmployeeId;
end;

procedure TRosterBreakListGUI.FormCreate(Sender: TObject);
begin
  fLoadroster := nil;
  Tablename := commondblib.GetUserTemporaryTableName('RosterBreak');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('T.* ,  ');
  Qrymain.SQL.add('E.EmployeeName  ');
  Qrymain.SQL.add('from ' +Tablename +' T  ');
  Qrymain.SQL.add('inner join tblemployees E on T.EmployeeId = E.EmployeeId  ');
  Qrymain.SQL.add('order by RosterId desc,  StartTime ,RosterStarttime ') ;
  inherited;
  SelectionOption := soEmployee;
end;

procedure TRosterBreakListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if  (qrymainendtime.asDateTime =0) and (Qrymaindetails.asInteger =1) then
    if sametext(qrymainendtime.FieldName , Field.Fieldname) then Afont.color := ABrush.Color else Afont.Color := clRed;

  if  (qrymainRosterEndtime.asDateTime =0) and (qrymainRosterStarttime.asDateTime <>0) and (Qrymaindetails.asInteger <>1) then
    if sametext(qrymainRosterEndtime.FieldName , Field.Fieldname) then Afont.color := ABrush.Color else Afont.Color := clRed;
  inherited;
  if  (qrymainendtime.asDateTime =0) and (Qrymaindetails.asInteger =1) then
    if sametext(qrymainendtime.FieldName , Field.Fieldname) then Afont.color := ABrush.Color ;

  if  (qrymainRosterEndtime.asDateTime =0) and (qrymainRosterStarttime.asDateTime <>0) and (Qrymaindetails.asInteger <>1) then
    if sametext(qrymainRosterEndtime.FieldName , Field.Fieldname) then Afont.color := ABrush.Color ;

end;
procedure TRosterBreakListGUI.btntimeSheetClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if not (EmployeeHasAccess('TfrmTimeSheet')) then begin
    MessageDlgXP_vista('You don''t have enough access for the timesheet', mtInformation, [mbOK], 0);
    exit;
  end;
  if SelectedRecords =0 then begin
    MessageDlgXP_vista('Please select the records to add to timesheet', mtInformation, [mbOK], 0);
    exit;
  end;
  s:= SelectedIDs(QrymainrosterID.FieldName  , true);
  IterateProcNo := 1;
  IterateselectedRecordsReverse(True , 'Check for records already added to timesheet');
  if SelectedRecords =0 then begin
    MessageDlgXP_vista('All selected Entries are either already added to timesheet or not CLOCKED-OFF yet. Please select the records to add to timesheet', mtInformation, [mbOK], 0);
    exit;
  end;
  TfrmTimeSheet.CreateTimeSheetforRosters(Self);
end;
procedure TRosterBreakListGUI.CreateTimeSheetforRosters;
begin
  iterateProcno := 2;
  try
    IterateselectedRecords;
  finally
    iterateProcno := 0;
  end;
end;
procedure TRosterBreakListGUI.IterateselectedRecordsCallback(var Abort: boolean;
  SelIndex: Integer);
begin
  inherited;
  if iterateProcno = 1 then begin
     if qryMainTimesheetcreated.asBoolean then grdmain.UnselectRecord
     else if QrymainDetails.AsInteger <> 1 then grdmain.UnselectRecord
     else if qryMainRosterEndtime.AsDateTime =0 then grdmain.UnselectRecord;
  end else if iterateProcno = 2 then begin
    if assigned(fLoadroster) then
        fLoadroster(Qrymain);
  end;
end;

procedure TRosterBreakListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainTimesheetcreated.asBoolean := QrymaintimesheetId.asInteger <>0;
end;

procedure TRosterBreakListGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TRosterBreakListGUI);

end.
