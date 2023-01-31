unit RosterEditFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, wwdbdatetimepicker, DNMPanel, DBAccess, MyAccess,ERPdbComponents,
  DataState, Menus, AdvMenus, MemDS, Shader, ImgList, ProgressDialog, DBCtrls,
  wwcheckbox;

type
  TRosterEditGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryRoster: TERPQuery;
    dsRoster: TDataSource;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    lblDateTo: TLabel;
    lbldtpEnd: TLabel;
    ChkclockOff: TwwCheckBox;
    Label1: TLabel;
    dtDate: TwwDBDateTimePicker;
    dtpStart: TwwDBDateTimePicker;
    dtpEnd: TwwDBDateTimePicker;
    dtDateTo: TwwDBDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure ChkclockOffClick(Sender: TObject);
    procedure dtDateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fbDirectUpdate: boolean;
    fbOk: boolean;
    
  end;

implementation

uses
  CommonDbLib, FormFactory, DNMExceptions, 
  CommonLib, dateutils, AppEnvironment;


{$R *.dfm}

{ TRosterEditGUI }

procedure TRosterEditGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Notify;
  Action := caFree;
end;

procedure TRosterEditGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    if fbDirectUpdate then begin    // update tblroster directly
      dtpStart.DataSource     := dsRoster;      dtpStart.DataField    := 'StartTime';
      dtpEnd.DataSource       := dsRoster;      dtpEnd.DataField      := 'EndTime';
      dtDateTo.DataSource     := dsRoster;      dtDateTo.DataField    := 'EndTime';
      ChkclockOff.DataSource  := dsRoster;      ChkclockOff.DataField := 'clockedOff';
      ChkclockOff.DataSource  := dsRoster;      ChkclockOff.DataField := 'clockedOff';
      dtDate.DataSource       := dsRoster;      dtDate.DataField      := 'StartTime';
      try
        inherited;

        if qryRoster.Active then begin
          if not (qryRoster.State in [dsBrowse]) then begin
            Postdb(qryRoster);
            Notify;
          end;
          CloseQueries;
        end;

        qryRoster.Connection := CommonDbLib.GetSharedMyDacConnection;
        qryRoster.ParamByName('xRosterID').asInteger := KeyID;
        qryRoster.Open;
        EditNoAbort(qryRoster);
        SetControlFocus(dtpStart);
        dtpEnd.Visible := qryRoster.Fieldbyname('clockedOff').asBoolean;
        dtDateTo.Visible := qryRoster.Fieldbyname('clockedOff').asBoolean;
        lblDateTo.Visible := qryRoster.Fieldbyname('clockedOff').asBoolean;
        lbldtpEnd.Visible := qryRoster.Fieldbyname('clockedOff').asBoolean;
      except
        on EAbort do HandleEAbortException;
        on e: ENoAccess do HandleNoAccessException(e);
        else raise;
      end;
    end else begin
      // get here
      btnSave.Caption := 'OK';
    end;
  finally
    EnableForm;
  end;  
end;

procedure TRosterEditGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbDirectUpdate := true;
  fbOk := false;
//  dtDateTo.Visible := Devmode;
end;

procedure TRosterEditGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if fbDirectUpdate then begin
    editdb(qryRoster);
    if qryRoster.Fieldbyname('clockedOff').asBoolean= False then
      qryRoster.Fieldbyname('EndTime').AsDateTime := 0
    else if (dtpStart.Time > dtpEnd.Time)  then begin
      CommonLib.MessageDlgXP_Vista('End Time must be less than Start Time', mtWarning, [mbOK], 0);
      Exit;
    end;
    Postdb(qryRoster);
  end else begin
    if (dtpStart.Time > dtpEnd.Time)  then begin
      CommonLib.MessageDlgXP_Vista('End Time must be less than Start Time', mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
  fbOk := true;
  Close;
end;

procedure TRosterEditGUI.ChkclockOffClick(Sender: TObject);
begin
  inherited;
  if fbDirectUpdate then begin
      dtpEnd.Visible := ChkclockOff.Checked;
      dtDateTo.Visible := ChkclockOff.Checked;
      lblDateTo.Visible := ChkclockOff.Checked;
      lbldtpEnd.Visible := ChkclockOff.Checked;
      if ChkclockOff.Checked then begin
        editdb(qryRoster);
        if qryRoster.Fieldbyname('EndTime').AsDateTime =0 then begin //qryRoster.Fieldbyname('EndTime').AsDateTime := Now;
            qryRoster.Fieldbyname('EndTime').AsDateTime := dtDate.Date + timeof(Now);
            if qryRoster.Fieldbyname('EndTime').AsDateTime < qryRoster.Fieldbyname('StartTime').AsDateTime then
              qryRoster.Fieldbyname('EndTime').AsDateTime := StartOfTheDay(qryRoster.Fieldbyname('StartTime').AsDateTime) + TimeOf(Appenv.companyPrefs.EndOfday);
            if qryRoster.Fieldbyname('EndTime').AsDateTime < qryRoster.Fieldbyname('StartTime').AsDateTime then
              qryRoster.Fieldbyname('EndTime').AsDateTime := incsecond(qryRoster.Fieldbyname('StartTime').AsDateTime,Appenv.companyPrefs.SecondsInaday);
        end;
        setcontrolfocus(dtpEnd);
      end;
  end;
end;

procedure TRosterEditGUI.dtDateChange(Sender: TObject);
begin
  inherited;
  if not IsFormshown then exit;
  if not qryRoster.active then exit;
  if fbDirectUpdate then begin
      editdb(qryRoster);
      qryRoster.Fieldbyname('StartTime').AsDateTime := dtDate.Date + timeof(qryRoster.Fieldbyname('StartTime').AsDateTime);
      if qryRoster.Fieldbyname('EndTime').AsDateTime <>0 then begin //qryRoster.Fieldbyname('EndTime').AsDateTime := Now;
        if dateof(qryRoster.Fieldbyname('EndTime').AsDateTime) <> dateof(qryRoster.Fieldbyname('StartTime').AsDateTime) then begin
            qryRoster.Fieldbyname('EndTime').AsDateTime := dtDate.Date + timeof(qryRoster.Fieldbyname('EndTime').AsDateTime);
            if qryRoster.Fieldbyname('EndTime').AsDateTime < qryRoster.Fieldbyname('StartTime').AsDateTime then
              qryRoster.Fieldbyname('EndTime').AsDateTime := StartOfTheDay(qryRoster.Fieldbyname('StartTime').AsDateTime) + TimeOf(Appenv.companyPrefs.EndOfday);
            if qryRoster.Fieldbyname('EndTime').AsDateTime < qryRoster.Fieldbyname('StartTime').AsDateTime then
              qryRoster.Fieldbyname('EndTime').AsDateTime := incsecond(qryRoster.Fieldbyname('StartTime').AsDateTime,Appenv.companyPrefs.SecondsInaday);
        end;
      end;
      Postdb(qryRoster);
      editdb(qryRoster);
  end else if dtDate.Date <> dtDateTo.Date then begin
    dtDateTo.Date :=dtDate.Date;
    dtpEnd.Time := dtDate.Date + dtpEnd.Time;
  end;
end;

procedure TRosterEditGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TRosterEditGUI);
  with FormFact do begin
    RegisterMe(TRosterEditGUI, 'TRosterListGUI_*=RosterID');
  end;
end.
