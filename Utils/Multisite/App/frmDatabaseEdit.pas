unit frmDatabaseEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DNMSpeedButton, ExtCtrls, DNMPanel, MultisiteConfigObj,
  StdCtrls, Mask;

type
  TfmDatabaseEdit = class(TfmBaseEdit)
    Label1: TLabel;
    edtDatabaseName: TEdit;
    Label2: TLabel;
    edtInterval: TMaskEdit;
    chkSyncActive: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    function GetCheckInterval: TDateTime;
    procedure SetCheckInterval(const Value: TDateTime);
    function Validate: boolean;
  public
    property CheckInterval: TDateTime read GetCheckInterval write SetCheckInterval;
  end;

  function DoDatabaseEdit(config: TDatabase): boolean;

implementation

{$R *.dfm}

function DoDatabaseEdit(config: TDatabase): boolean;
var
  form: TfmDatabaseEdit;
begin
  form:= TfmDatabaseEdit.Create(Application);
  try
    form.edtDatabaseName.Text:= Config.DatabaseName;
    form.CheckInterval:= Config.CheckInterval;
    form.chkSyncActive.Checked:= Config.SynchronizationActive;
    result:= form.ShowModal = mrOk;
    if result then begin
      Config.DatabaseName:= form.edtDatabaseName.Text;
      Config.CheckInterval:= form.CheckInterval;
      Config.SynchronizationActive:= form.chkSyncActive.Checked;
    end;
  finally
    form.Free;
  end;
end;

{ TfmDatabaseEdit }

function TfmDatabaseEdit.GetCheckInterval: TDateTime;
var
  mins, secs: integer;
begin
  mins:= StrToInt(Copy(edtInterval.Text,1,2));
  secs:= StrToInt(Copy(edtInterval.Text,4,2));
  result:= EncodeTime(0,mins,secs,0);
end;

procedure TfmDatabaseEdit.SetCheckInterval(const Value: TDateTime);
begin
  edtInterval.Text:= FormatDateTime('nn:ss',Value)
end;

procedure TfmDatabaseEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

function TfmDatabaseEdit.Validate: boolean;
var
  mins, secs: integer;
begin
  result:= false;
  if Trim(edtDatabaseName.Text) = '' then begin
    MessageDlg('Database Name can not be blank',mtInformation,[mbOk],0);
    exit;
  end;
  mins:= StrToInt(Copy(edtInterval.Text,1,2));
  secs:= StrToInt(Copy(edtInterval.Text,4,2));
  if (mins = 0) and (secs < 5) then begin
    MessageDlg('Check Interval can not be less than 5 seconds',mtInformation,[mbOk],0);
    exit;
  end;
  result:= true;
end;

procedure TfmDatabaseEdit.btnOKClick(Sender: TObject);
begin
  inherited;
  if Validate then
    ModalResult:= mrOk;
end;

end.
