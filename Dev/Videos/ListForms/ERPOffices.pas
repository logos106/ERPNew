unit ERPOffices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, Mask, wwdbedit, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPOfficesGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainLocation: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainSundayStartsAt: TTimeField;
    qryMainMondayStartsAt: TTimeField;
    qryMainTuesdayStartsAt: TTimeField;
    qryMainWednesDayStartsAt: TTimeField;
    qryMainThursDayStartsAt: TTimeField;
    qryMainFridayStartsAt: TTimeField;
    qryMainSaturdayStartsAt: TTimeField;
    qryMainSundayStopsAt: TTimeField;
    qryMainMondayStopsAt: TTimeField;
    qryMainTuesdayStopsAt: TTimeField;
    qryMainWednesdayStopsAt: TTimeField;
    qryMainThursdayStopsAt: TTimeField;
    qryMainFridayStopsAt: TTimeField;
    qryMainSaturdayStopsAt: TTimeField;
    btnUpdate: TDNMSpeedButton;
    qryMainLocaltime: TDateTimeField;
    qryMainTimeZone: TFloatField;
    qryMainOpenStatus: TWideStringField;
    qryMainSunday: TWideStringField;
    qryMainMonday: TWideStringField;
    qryMainTuesday: TWideStringField;
    qryMainWednesDay: TWideStringField;
    qryMainThursDay: TWideStringField;
    qryMainFriday: TWideStringField;
    qryMainSaturday: TWideStringField;
    qryMainShortDay: TWideStringField;
    qryMainShortDayStopAt: TTimeField;
    qryMainStopsAt: TTimeField;
    qryMainStartsAt: TTimeField;
    tmrRefreshQuery: TTimer;
    qryMainWebAddress: TWideStringField;
    edtPhonenumber: TwwDBEdit;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure tmrRefreshQueryTimer(Sender: TObject);
    procedure grdMainMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure grdMainMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  private
    gridcol :Integer;
    (*function LocationIndex: Integer;*)
    (*function OpenStatusIndex: Integer;*)
    (*function PhoneIndex: Integer;*)
    procedure CallERP;
    procedure InitTimer;

  Protected
    function TeamviewerIndex: Integer;Virtual;
    //procedure InitGridcontrols(Field: TField;AFont: TFont; ABrush: TBrush);virtual;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, ERPDocsDBObj, AppEnvironment,dateutils, ERPLib, frmPhoneButton,
  ShellAPI,  tcConst;

const
  dowMonday   = 1;
  dowTuesday  = 2;
  dowWednesday= 3;
  dowThursday = 4;
  dowFriday   = 5;
  dowSaturday = 6;
  dowSunday   = 7;

{$R *.dfm}
procedure TERPOfficesGUI.btnUpdateClick(Sender: TObject);
var
  ERPDocsDB : TERPDocsDB;
begin
  inherited;
  ERPDocsDB := TERPDocsDB.Create;
  try
    ERPDocsDB.Server := appEnv.AppDb.Server;
    ERPDocsDB.ERPDatabase := appEnv.AppDb.Database;
    ERPDocsDB.UploadERPOffices;
    MessageDlgXP_Vista('Changes are Uploaded', mtInformation, [mbOK], 0);
  finally
    FreeandNil(ERPDocsDB);
  end;
end;

procedure TERPOfficesGUI.FormCreate(Sender: TObject);
begin
  gridcol := -1;
  EnableChangeForm := False;
  inherited;
  AutoSetColumnControlType:= false;
  btnUpdate.enabled := IsERPCustomEnabled;
  inittimer;
end;
Procedure TERPOfficesGUI.InitTimer;
var
  i:Integer;
begin
    i:= 30- trunc(Frac(MinutesBetween(now() , date())/30)*30);
    if i=0 then i:= 30;
    tmrRefreshQuery.Interval := i*60*1000;
    tmrRefreshQuery.enabled := True;
end;
procedure TERPOfficesGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  d:Integer;
begin
  inherited;
  if Sametext(Field.FieldName ,   qryMainPhone.FieldName   ) then begin
    if  (qryMainPhone.AsString <> '') then begin
      Afont.Style := Afont.Style  +[fsUnderline];
      if (gdSelected in State) or (gdRowSelected in state )  then Afont.Color := clwhite         else Afont.Color := clNavy;
    end;
  end;

  if Sametext(Field.FieldName ,   qryMainSundayStartsAt.FieldName   ) and (qryMainSundayStartsAt.asDatetime   =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainMondayStartsAt.FieldName   ) and (qryMainMondayStartsAt.asDatetime   =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainTuesdayStartsAt.FieldName  ) and (qryMainTuesdayStartsAt.asDatetime  =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainWednesDayStartsAt.FieldName) and (qryMainWednesDayStartsAt.asDatetime=0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainThursDayStartsAt.FieldName ) and (qryMainThursDayStartsAt.asDatetime =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainFridayStartsAt.FieldName   ) and (qryMainFridayStartsAt.asDatetime   =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainSaturdayStartsAt.FieldName ) and (qryMainSaturdayStartsAt.asDatetime =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainSundayStopsAt.FieldName    ) and (qryMainSundayStopsAt.asDatetime    =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainMondayStopsAt.FieldName    ) and (qryMainMondayStopsAt.asDatetime    =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainTuesdayStopsAt.FieldName   ) and (qryMainTuesdayStopsAt.asDatetime   =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainWednesdayStopsAt.FieldName ) and (qryMainWednesdayStopsAt.asDatetime =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainThursdayStopsAt.FieldName  ) and (qryMainThursdayStopsAt.asDatetime  =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainFridayStopsAt.FieldName    ) and (qryMainFridayStopsAt.asDatetime    =0) then Abrush.Color := GridColhighLightOrange;
  if Sametext(Field.FieldName ,   qryMainSaturdayStopsAt.FieldName  ) and (qryMainSaturdayStopsAt.asDatetime  =0) then Abrush.Color := GridColhighLightOrange;

  d:= DayofTheweek(qryMainLocaltime.asDatetime); //1 through 7 -> where 1 indicates Monday and 7 indicates Sunday
  if d= dowMonday     then if Sametext(Field.FieldName ,   qryMainMondayStartsAt.FieldName   ) or Sametext(Field.FieldName ,   qryMainMondayStopsAt.FieldName    ) then Abrush.Color := GridColhighLightGreen;
  if d= dowTuesday    then if Sametext(Field.FieldName ,   qryMainTuesdayStartsAt.FieldName  ) or Sametext(Field.FieldName ,   qryMainTuesdayStopsAt.FieldName   ) then Abrush.Color := GridColhighLightGreen;
  if d= dowWednesday  then if Sametext(Field.FieldName ,   qryMainWednesDayStartsAt.FieldName) or Sametext(Field.FieldName ,   qryMainWednesdayStopsAt.FieldName ) then Abrush.Color := GridColhighLightGreen;
  if d= dowThursday   then if Sametext(Field.FieldName ,   qryMainThursDayStartsAt.FieldName ) or Sametext(Field.FieldName ,   qryMainThursdayStopsAt.FieldName  ) then Abrush.Color := GridColhighLightGreen;
  if d= dowFriday     then if Sametext(Field.FieldName ,   qryMainFridayStartsAt.FieldName   ) or Sametext(Field.FieldName ,   qryMainFridayStopsAt.FieldName    ) then Abrush.Color := GridColhighLightGreen;
  if d= dowSaturday   then if Sametext(Field.FieldName ,   qryMainSaturdayStartsAt.FieldName ) or Sametext(Field.FieldName ,   qryMainSaturdayStopsAt.FieldName  ) then Abrush.Color := GridColhighLightGreen;
  if d= dowSunday     then if Sametext(Field.FieldName ,   qryMainSundayStartsAt.FieldName   ) or Sametext(Field.FieldName ,   qryMainSundayStopsAt.FieldName    ) then Abrush.Color := GridColhighLightGreen;
  //InitGridcontrols(Field,Afont,ABrush);
end;
(*procedure TERPOfficesGUI.InitGridcontrols(Field: TField;AFont: TFont; ABrush: TBrush);
begin
  if Sametext(Field.FieldName, Qrymainphone.FieldName) then begin
    edtPhone.color      := ABrush.color;
    edtPhone.font.color := AFont.color;
  end else if Sametext(Field.FieldName, QrymainOpenStatus.FieldName) then begin
    edtOpenStatus.color := ABrush.color;
    edtOpenStatus.font.color := AFont.color;
  end else if Sametext(Field.FieldName, QrymainLocation.FieldName) then begin
    edtLocation.color   := ABrush.color;
    edtLocation.font.color   := AFont.color;
  end;
end;*)
procedure TERPOfficesGUI.grdMainKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := chr(0);
end;
Procedure TERPOfficesGUI.CallERP;
var
  PhoneButton:TPhoneButton;
begin
  PhoneButton           := TPhoneButton.Create(Self);
  try
    PhoneButton.name      := MakePhonebuttonname(edtPhonenumber.name);
    PhoneButton.Parent    := edtPhonenumber.Parent;
    PhoneButton.PhoneEdit := edtPhonenumber;
    PhoneButton.visible   :=  False;
    PhoneButton.Phonebutton.Click;
  finally
    Freeandnil(PhoneButton);
  end;
end;

procedure TERPOfficesGUI.grdMainMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
var
  url:String;
begin
  inherited;
  if Sametext(ActiveFieldname , Qrymainphone.fieldname ) and (qryMainPhone.AsString <> '') then begin
    CallERP;
  end else if Sametext(ActiveFieldname , QrymainLocation.fieldname ) and (qryMainwebaddress.AsString <> '') then begin
    url := qryMainwebaddress.AsString;
    ShellExecute(0, nil, pchar(url), '','', SW_SHOWDEFAULT);
  end;
end;

procedure TERPOfficesGUI.grdMainMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
begin
(*var
  col:Integer;
begin
  inherited;
  col := GridCurrentColumnIndex(x,y);
  if col = gridcol then exit;
  logtext(inttostr(col) +','+ inttostr(LocationIndex) +','+','+ inttostr(PhoneIndex) +','+ inttostr(OpenStatusIndex) +','+ inttostr(TeamviewerIndex) );
  if  (col = LocationIndex ) or
      (col = PhoneIndex ) or
      (col = TeamviewerIndex ) then  begin
    HandPointCursor(True);
  end else begin
    HandPointCursor(False);
  end;
  gridcol  := col;*)
end;
(*Function TERPOfficesGUI.LocationIndex:Integer;begin   REsult := Qrymainlocation.Index;end;*)
(*Function TERPOfficesGUI.PhoneIndex:Integer;begin   REsult := QrymainPhone.Index;end;*)
(*Function TERPOfficesGUI.OpenStatusIndex:Integer;begin   REsult := QrymainOpenStatus.Index;end;*)
Function TERPOfficesGUI.TeamviewerIndex:Integer;begin   REsult := -1;end;

procedure TERPOfficesGUI.qryMainCalcFields(DataSet: TDataSet);
var
  d:Integer;
begin
  inherited;
  qryMainLocaltime.asDatetime := IncMinute(inchour(NowUTC , trunc(qryMainTimeZone.asFloat)) , trunc((qryMainTimeZone.asFloat- trunc(qryMainTimeZone.asFloat))*60) );
  d:= DayofTheweek(qryMainLocaltime.asDatetime); //1 through 7 -> where 1 indicates Monday and 7 indicates Sunday
  qryMainOpenStatus.asString := 'Closed';
       if (d= dowMonday   ) and  (qryMainMonday.asboolean     = False ) then
  else if (d= dowTuesday  ) and  (qryMainTuesday.asboolean    = False ) then
  else if (d= dowWednesday) and  (qryMainWednesday.asboolean  = False ) then
  else if (d= dowThursday ) and  (qryMainThursday.asboolean   = False ) then
  else if (d= dowFriday   ) and  (qryMainFriday.asboolean     = False ) then
  else if (d= dowSaturday ) and  (qryMainSaturday.asboolean   = False ) then
  else if (d= dowSunday   ) and  (qryMainSunday.asboolean     = False ) then
  else if (((d= dowMonday   ) and  (sametext(qryMainShortDay.asString,'Mon') )) or
           ((d= dowTuesday  ) and  (sametext(qryMainShortDay.asString,'Tue') )) or
           ((d= dowWednesday) and  (sametext(qryMainShortDay.asString,'Wed') )) or
           ((d= dowThursday ) and  (sametext(qryMainShortDay.asString,'Thur') )) or
           ((d= dowFriday   ) and  (sametext(qryMainShortDay.asString,'Fri') )) or
           ((d= dowSaturday ) and  (sametext(qryMainShortDay.asString,'Sat') )) or
           ((d= dowSunday   ) and  (sametext(qryMainShortDay.asString,'Sun') ))) and
          ((timeof(qryMainLocaltime.asDatetime) >= QrymainShortDayStopAt.asDatetime) or (timeof(qryMainLocaltime.asDatetime) < QrymainStartsAt.asDatetime)) then
  else if  (timeof(qryMainLocaltime.asDatetime) >= QrymainStopsAt.asDatetime) or (timeof(qryMainLocaltime.asDatetime) < QrymainStartsAt.asDatetime) then
  else qryMainOpenStatus.asString := 'Open';

end;

procedure TERPOfficesGUI.RefreshQuery;
begin
  inherited;
  grdmain.options:= grdmain.options +[dgEditing];
  //grdmain.readonly := True;
end;


procedure TERPOfficesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(QrymainTimeZone.fieldname);
  RemoveFieldfromGrid(QrymainSunday.fieldname);
  RemoveFieldfromGrid(QrymainMonday.fieldname);
  RemoveFieldfromGrid(QrymainTuesday.fieldname);
  RemoveFieldfromGrid(QrymainWednesDay.fieldname);
  RemoveFieldfromGrid(QrymainThursDay.fieldname);
  RemoveFieldfromGrid(QrymainFriday.fieldname);
  RemoveFieldfromGrid(QrymainSaturday.fieldname);
  RemoveFieldfromGrid(qryMainShortDay.fieldname);
  RemoveFieldfromGrid(qryMainShortDayStopAt.fieldname);
  RemoveFieldfromGrid(qryMainStopsAt.fieldname);
  RemoveFieldfromGrid(qryMainStartsAt.fieldname);
end;

procedure TERPOfficesGUI.tmrRefreshQueryTimer(Sender: TObject);
begin
  inherited;
  Closedb(Qrymain);
  RefreshQuery;
  tmrRefreshQuery.Interval := 30*60*1000;
end;

initialization
  RegisterClassOnce(TERPOfficesGUI);

end.
