unit frmRepeat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DNMSpeedButton, DateUtils, DNMPanel, BaseInputForm, ComCtrls,AdvOfficeStatusBar,
  MyAccess,ERPdbComponents, DB, MemDS, DBAccess, SelectionDialog, AppEvnts,
  CalcRepeatDates, DataState, Menus, AdvMenus, Shader, ImgList, Spin, ProgressDialog, wwdbdatetimepicker, Math;

type
  TRepeatFrm = class(TBaseInputGUI)
    qry: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlMain: TDNMPanel;
    Label1: TLabel;
    lblFinalDate: TLabel;
    lbDates: TListBox;
    Panel1: TPanel;
    rgFrequency: TRadioGroup;
    pnlDay: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    seDayDays: TSpinEdit;
    pnlWeekDay: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    seWeekDays: TSpinEdit;
    cbWeekday: TComboBox;
    pnlMonth: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    seMonthMonths: TSpinEdit;
    cbMonthBeginEnd: TComboBox;
    seMonthDays: TSpinEdit;
    Panel2: TPanel;
    rgSaturday: TRadioGroup;
    Panel3: TPanel;
    rgSunday: TRadioGroup;
    Panel4: TPanel;
    rgHoliday: TRadioGroup;
    dtBaseDate: TDateTimePicker;
    dtFinalDate: TDateTimePicker;
    lblMsg: TLabel;
    bbOK: TDNMSpeedButton;
    btnHoliday: TDNMSpeedButton;
    bbCancel: TDNMSpeedButton;
    procedure rbGroupClick(Sender: TObject);
    procedure seDayChange(Sender: TObject);
    procedure bbOKClick(Sender: TObject);
    procedure btnHolidayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    function GetBaseDate: TDateTime;
    function GetEvery: Integer;
    function GetFinalDate: TDateTime;
    function GetFrequency: Integer;
    function GetHolidayAction: Integer;
    function GetMonthBeginEnd: Integer;
    function GetMonthDays: Integer;
    function GetSaturdayAction: Integer;
    function GetSundayAction: Integer;
    function GetWeekday: Integer;
    procedure SetBaseDate(const Value: TDateTime);
    procedure SetEvery(const Value: Integer);
    procedure SetFinalDate(const Value: TDateTime);
    procedure SetFrequency(const Value: Integer);
    procedure SetHolidayAction(const Value: Integer);
    procedure SetMonthBeginEnd(const Value: Integer);
    procedure SetMonthDays(const Value: Integer);
    procedure SetSaturdayAction(const Value: Integer);
    procedure SetSundayAction(const Value: Integer);
    procedure SetWeekday(const Value: Integer);
  Protected
    procedure initform;virtual;
  public
    KeyID: integer;
    dates: TDates;
    StartBaseDate: TDateTime;
    constructor Create(const AOwner: TComponent; const DatabaseName: string); reintroduce;
    property Frequency              :Integer     read GetFrequency            write SetFrequency         ;
    property Every                  :Integer     read GetEvery                write SetEvery             ;
    property Weekday                :Integer     read GetWeekday              write SetWeekday           ;
    property MonthBeginEnd          :Integer     read GetMonthBeginEnd        write SetMonthBeginEnd     ;
    property MonthDays              :Integer     read GetMonthDays            write SetMonthDays         ;
    property SaturdayAction         :Integer     read GetSaturdayAction       write SetSaturdayAction    ;
    property SundayAction           :Integer     read GetSundayAction         write SetSundayAction      ;
    property HolidayAction          :Integer     read GetHolidayAction        write SetHolidayAction     ;
    property BaseDate               :TDateTime   read GetBaseDate             write SetBaseDate          ;
    property FinalDate              :TDateTime   read GetFinalDate            write SetFinalDate         ;
  end;

implementation

uses
  frmPublicHolidays, CommonLib, Forms, AppEnvironment, MySQLConst,
  RepeatDatesLib;

{$R *.DFM}
                           
constructor TRepeatFrm.Create(const AOwner: TComponent; const DatabaseName: string);
begin
  inherited Create(AOwner);
  KeyID := 0;
  StartBaseDate := Date;
  MyConnection.Database := DatabaseName;
end;

procedure TRepeatFrm.rbGroupClick(Sender: TObject);
begin

  if (Sender = rgSaturday) and (rgSaturday.ItemIndex =2) and (rgSunday.itemindex =3) then begin
    TimerMsg(lblMsg , 'Since ''Shift Before'' is Selected for ''Sunday'', It is not possible to do ''Shift After'' for ''Saturday''');
    rgSaturday.ItemIndex:= 3;
  end;
  if (Sender = rgSunday) and (rgSaturday.ItemIndex =2) and (rgSunday.itemindex =3) then begin
    TimerMsg(lblMsg , 'Since ''Shift After'' is Selected for ''Saturday'', It is not possible to do ''Shift Before'' for ''Sunday''');
    rgSunday.ItemIndex:= 2;
  end;

  if Sender = rgFrequency then begin
    pnlDay.Visible     := rgFrequency.ItemIndex = 0;
    pnlWeekDay.Visible := rgFrequency.ItemIndex = 1;
    pnlMonth.Visible   := rgFrequency.ItemIndex = 2;
    rgSaturday.Enabled := not pnlWeekDay.Visible;
    rgSunday.Enabled   := not pnlWeekDay.Visible;
    bbOk.Enabled       := true;
  end;
  seDayChange(Sender);
end;
procedure TRepeatFrm.seDayChange(Sender: TObject);
  var
    i:Integer;
    function repeatFrequency:Integer;
    begin
            if rgFrequency.ItemIndex = 0 then result := seDayDays.Value
       else if rgFrequency.ItemIndex = 1 then result := seWeekDays.Value
       else result :=  seMonthMonths.Value;
    end;

    function RepeatWeekDay:Integer;
    begin
            if rgFrequency.ItemIndex < 1 then result := cbWeekDay.ItemIndex
       else if rgFrequency.ItemIndex = 1 then result := Math.Max(cbWeekDay.ItemIndex, 0)
       else begin result :=  cbMonthBeginEnd.itemindex;
                  result := result +cbWeekDay.Items.Count; // to use TDayOfWeek class
       end;
    end;
begin
  lbDates.Items.Clear;
  DoCalcRepeatDates(repeatFrequency,
                    InttoPeriod(rgFrequency.ItemIndex),
                    dtBaseDate.Date,dtFinalDate.Date,
                    IntToOnHoliday(rgSaturday.itemindex),
                    IntToOnHoliday(rgSunday.itemindex),
                    ohPost,ohPost,ohPost,ohPost,ohPost,
                    IntToOnHoliday(rgHoliday.itemindex),
                    InttoDateOfWeek(RepeatWeekDay),
                    seMonthDays.Value,
                    dates);
      for i := low(dates) to high(dates) do begin
        lbDates.Items.Add(FormatDateTime('dd.mmm.yyy dddd', dates[i ]));
      end;

(*var
  CalcRepeatDates: TCalcRepeatDates;
  i: integer;
begin
 CalcRepeatDates := TCalcRepeatDates.Create;
  try
    with CalcRepeatDates do begin
      case rgFrequency.ItemIndex of
        0:
          begin
            OfPeriod := opDay;
            Every := seDayDays.Value;
          end;
        1:
          begin
            OfPeriod := opWeek;
            Every := seWeekDays.Value;
            case cbWeekDay.ItemIndex of
              0: DayOfWeek := doSU;
              1: DayOfWeek := doMO;
              2: DayOfWeek := doTU;
              3: DayOfWeek := doWE;
              4: DayOfWeek := doTH;
              5: DayOfWeek := doFR;
              6: DayOfWeek := doSA;
            end;
          end;
        2:
          begin
            OfPeriod := opMonth;
            Every := seMonthMonths.Value;
            case cbMonthBeginEnd.ItemIndex of
              0: DayOfWeek := doSOM;
              1: DayOfWeek := doEOM;
            end;
            MonthOffset := seMonthDays.Value;
          end;
      end;
      BaseDate := dtBaseDate.Date;
      FinalDate := dtFinalDate.Date;


      qry.SQL.Text := Format('SELECT Day FROM tblpublicholidays ' + 'WHERE Day > "%s" AND Day <= "%s"',
        [FormatDateTime(MysqlDateFormat, DateOf(BaseDate)), FormatDateTime(MysqlDateFormat, DateOf(FinalDate))]);
      qry.Open;
      Setlength(Holidays, qry.RecordCount);
      while not qry.Eof do begin
        Holidays[qry.RecNo - 1] := qry.FieldByName('Day').AsDateTime;
        qry.Next;
      end;

      OnSaturday := TOnHoliday(rgSaturday.ItemIndex);
      OnSunday := TOnHoliday(rgSunday.ItemIndex);
      OnHoliday := TOnHoliday(rgHoliday.ItemIndex);

      lbDates.Items.Clear;
      Setlength(dates, Length(ScheduledDates));

      for i := low(ScheduledDates) to high(ScheduledDates) do begin
        lbDates.Items.Add(FormatDateTime('dd.mmm.yyy dddd', ScheduledDates[i ]));
        dates[i]:= ScheduledDates[i ];
      end;
    end;
  finally
    FreeAndNil(CalcRepeatDates);
  end;*)
end;
procedure TRepeatFrm.bbOKClick(Sender: TObject);
begin
  ModalResult := 1;
end;

procedure TRepeatFrm.btnHolidayClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmPublicHolidaysGUI');
  if Assigned(Form) then begin
    with TfrmPublicHolidaysGUI(Form) do begin
      qryHolidays.Connection := qry.Connection;
      Position  := poScreenCenter;
      FormStyle := fsNormal;
      ShowModal;
      seDayChange(Sender);
    end;
  end;
end;

procedure TRepeatFrm.FormShow(Sender: TObject);
begin
  inherited;
  initform;
end;
procedure TRepeatFrm.initform;
begin
  DisableForm;
  try
    inherited;
    dtBaseDate.Date := StartBaseDate;
    dtFinalDate.Date := incday(StartBaseDate , 14);
    TitleLabel.Caption := ReplaceStr(Self.Caption, AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel), '');
  finally
    EnableForm;
  end;    
end;

procedure TRepeatFrm.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;

end;
function TRepeatFrm.GetBaseDate       : TDateTime ;begin  result := dtBaseDate.DateTime       ;end;
function TRepeatFrm.GetEvery          : Integer   ;begin  REsult := seDayDays.Value           ;end;
function TRepeatFrm.GetFinalDate      : TDateTime ;begin  REsult := dtFinalDate.DateTime      ;end;
function TRepeatFrm.GetFrequency      : Integer   ;begin  REsult := rgFrequency.ItemIndex     ;end;
function TRepeatFrm.GetHolidayAction  : Integer   ;begin  result := rgHoliday.ItemIndex       ;end;
function TRepeatFrm.GetMonthBeginEnd  : Integer   ;begin  REsult := cbMonthBeginEnd.ItemIndex ;end;
function TRepeatFrm.GetMonthDays      : Integer   ;begin  result := seMonthDays.Value         ;end;
function TRepeatFrm.GetSaturdayAction : Integer   ;begin  result := rgSaturday.ItemIndex      ;end;
function TRepeatFrm.GetSundayAction   : Integer   ;begin  result := rgSunday.ItemIndex        ;end;
function TRepeatFrm.GetWeekday        : Integer   ;begin  result := cbWeekday.ItemIndex       ;end;
procedure TRepeatFrm.SetBaseDate        (const Value: TDateTime );begin  dtBaseDate.DateTime      := value;end;
procedure TRepeatFrm.SetEvery           (const Value: Integer   );begin  seDayDays.Value          := Value;end;
procedure TRepeatFrm.SetFinalDate       (const Value: TDateTime );begin  dtFinalDate.DateTime     := Value;end;
procedure TRepeatFrm.SetFrequency       (const Value: Integer   );begin  rgFrequency.ItemIndex    := Value;end;
procedure TRepeatFrm.SetHolidayAction   (const Value: Integer   );begin  rgHoliday.ItemIndex      := Value;end;
procedure TRepeatFrm.SetMonthBeginEnd   (const Value: Integer   );begin  cbMonthBeginEnd.ItemIndex:= Value;end;
procedure TRepeatFrm.SetMonthDays       (const Value: Integer   );begin  seMonthDays.Value        := Value;end;
procedure TRepeatFrm.SetSaturdayAction  (const Value: Integer   );begin  rgSaturday.ItemIndex     := Value;end;
procedure TRepeatFrm.SetSundayAction    (const Value: Integer   );begin  rgSunday.ItemIndex       := Value;end;
procedure TRepeatFrm.SetWeekday         (const Value: Integer   );begin  cbWeekday.ItemIndex      := Value;end;

initialization
  RegisterClassOnce(TRepeatFrm);
end.


