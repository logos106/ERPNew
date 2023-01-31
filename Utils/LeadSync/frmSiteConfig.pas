unit frmSiteConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JsonObject, ComCtrls, Mask;

type
  TfmSiteConfig = class(TForm)
    Label1: TLabel;
    edtName: TEdit;
    chkActive: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    gbSource: TGroupBox;
    Label2: TLabel;
    edtSourceURL: TEdit;
    Label4: TLabel;
    edtSourceDatabase: TEdit;
    Label5: TLabel;
    edtSourceUser: TEdit;
    Label6: TLabel;
    edtSourcePassword: TEdit;
    gbDest: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtDestURL: TEdit;
    edtDestDatabase: TEdit;
    edtDestUser: TEdit;
    edtDestPassword: TEdit;
    gbSyncTime: TGroupBox;
    chkTwoWaySynch: TCheckBox;
    dtNextDate: TDateTimePicker;
    dtNextTime: TDateTimePicker;
    Label10: TLabel;
    edtInterval: TMaskEdit;
    Label11: TLabel;
    Label12: TLabel;
    chkSat: TCheckBox;
    chkSun: TCheckBox;
    chkMon: TCheckBox;
    chkTues: TCheckBox;
    chkWeds: TCheckBox;
    chkThurs: TCheckBox;
    chkFri: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DoConfig(config: TJsonObject): boolean;

implementation

{$R *.dfm}

function DoConfig(config: TJsonObject): boolean;
var
  form: TfmSiteConfig;
begin
  result:= false;
  form:= TfmSiteConfig.Create(nil);
  try
    form.edtName.Text:= config.S['Name'];
    form.chkTwoWaySynch.Checked:= config.B['TwoWaySynch'];
    form.edtSourceURL.Text:= config.S['SourceURL'];
    form.edtSourceDatabase.Text:= config.S['SourceDatabase'];
    form.edtSourceUser.Text:= config.S['SourceUserName'];
    form.edtSourcePassword.Text:= config.S['SourcePassword'];
    form.edtDestURL.Text:= config.S['DestinationURL'];
    form.edtDestDatabase.Text:= config.S['DestinationDatabase'];
    form.edtDestUser.Text:= config.S['DestinationUserName'];
    form.dtNextDate.Date:= config.DT['NextSyncTime'];
    form.dtNextTime.Time:= config.DT['NextSyncTime'];
    form.edtInterval.Text:= FormatFloat('00',config.O['Interval'].I['Hours']) + ':' + FormatFloat('00',config.O['Interval'].I['Mins']);
    form.chkMon.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['1'];
    form.chkTues.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['2'];
    form.chkWeds.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['3'];
    form.chkThurs.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['4'];
    form.chkFri.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['5'];
    form.chkSat.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['6'];
    form.chkSun.Checked:= config.O['Interval'].O['DayOfTheWeek'].B['7'];
    form.edtDestPassword.Text:= config.S['DestinationPassword'];

    if form.edtName.Text = '' then
      form.chkActive.Checked:= true
    else
      form.chkActive.Checked:= config.B['Active'];
    if form.ShowModal = mrOK then begin
      result:= true;
      config.S['Name']:= form.edtName.Text;
      config.B['TwoWaySynch']:= form.chkTwoWaySynch.Checked;
      config.S['SourceURL']:= form.edtSourceURL.Text;
      config.S['SourceDatabase']:= form.edtSourceDatabase.Text;
      config.S['SourceUserName']:= form.edtSourceUser.Text;
      config.S['SourcePassword']:= form.edtSourcePassword.Text;
      config.S['DestinationURL']:= form.edtDestURL.Text;
      config.S['DestinationDatabase']:= form.edtDestDatabase.Text;
      config.S['DestinationUserName']:= form.edtDestUser.Text;
      config.S['DestinationPassword']:= form.edtDestPassword.Text;
      config.DT['NextSyncTime']:= Trunc(form.dtNextDate.Date) + Frac(form.dtNextTime.Time);
      config.O['Interval'].I['Hours']:= StrToIntDef(Copy(form.edtInterval.Text,1,2),0);
      config.O['Interval'].I['Mins']:= StrToIntDef(Copy(form.edtInterval.Text,4,2),15);
      config.O['Interval'].O['DayOfTheWeek'].B['1']:= form.chkMon.Checked;
      config.O['Interval'].O['DayOfTheWeek'].B['2']:= form.chkTues.Checked;
      config.O['Interval'].O['DayOfTheWeek'].B['3']:= form.chkWeds.Checked;
      config.O['Interval'].O['DayOfTheWeek'].B['4']:= form.chkThurs.Checked;
      config.O['Interval'].O['DayOfTheWeek'].B['5']:= form.chkFri.Checked;
      config.O['Interval'].O['DayOfTheWeek'].B['6']:= form.chkSat.Checked;
      config.O['Interval'].O['DayOfTheWeek'].B['7']:= form.chkSun.Checked;
      config.B['Active']:= form.chkActive.Checked;
    end;
  finally
    form.Free;
  end;
end;


procedure TfmSiteConfig.btnOkClick(Sender: TObject);
begin
  if edtNAme.Text = '' then begin
    MessageDlg('Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourceURL.Text = '' then begin
    MessageDlg('Source URL is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourceDatabase.Text = '' then begin
    MessageDlg('Source Database is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourceUser.Text = '' then begin
    MessageDlg('Source User Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtSourcePassword.Text = '' then begin
    MessageDlg('Source Password is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestURL.Text = '' then begin
    MessageDlg('Destination URL is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestDatabase.Text = '' then begin
    MessageDlg('Destination Database is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestUser.Text = '' then begin
    MessageDlg('Destination User Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDestPassword.Text = '' then begin
    MessageDlg('Destination Password is missing',mtInformation,[mbOk],0);
    exit;
  end;

  ModalResult:= mrOK;
end;

procedure TfmSiteConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
