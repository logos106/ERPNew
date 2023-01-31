unit frmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, ExtCtrls, StdCtrls, wwcheckbox, datSvcControlClient,
  AdvEdit, frmBase, DNMPanel;

type
  TfmConfig = class(TfmBase)
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    Label8: TLabel;
    chkUseSSL: TwwCheckBox;
    edtXMLServerPort: TAdvEdit;
    Label7: TLabel;
    edtMaxSessionCount: TAdvEdit;
    Label9: TLabel;
    Label5: TLabel;
    edtSessionTimeoutSecondes: TAdvEdit;
    Label6: TLabel;
    Label1: TLabel;
    chkLogToFile: TwwCheckBox;
    chkLogToEvent: TwwCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    lstMessageTypes: TListBox;
    lstMessageTypesToLog: TListBox;
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btnAdd: TDNMSpeedButton;
    btnRemove: TDNMSpeedButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DoConfig(Client: TSvcControlClient): boolean;

var
  fmConfig: TfmConfig;

implementation

{$R *.dfm}

uses
  AppVarsObj, Vista_MessageDlg, LogMessageTypes;

function DoConfig(Client: TSvcControlClient): boolean;
var
  form: TfmConfig;
  x: integer;
  mt: TLogMessageType;
begin
  form:= TfmConfig.Create(nil);
  try
    for mt:= Low(TLogMessageType) to High(TLogMessageType) do begin
      form.lstMessageTypes.Items.Add(LogMessageTypeToStr(mt));
    end;
    try
      form.chkUseSSL.Checked:= Client.RemotePropertyStr['UseSSL'] = 'True';
      form.lstMessageTypesToLog.Items.CommaText:= Client.RemotePropertyStr['LogMessageTypes'];
      form.chkLogToFile.Checked:= Client.RemotePropertyStr['LogToFile'] = 'True';
      form.chkLogToEvent.Checked:= Client.RemotePropertyStr['LogToEvent'] = 'True';
      form.edtXMLServerPort.Text:= Client.RemotePropertyStr['Port'];
      form.edtMaxSessionCount.Text:= Client.RemotePropertyStr['MaxSessionCount'];
      form.edtSessionTimeoutSecondes.Text:= Client.RemotePropertyStr['SessionTimeoutSeconds'];
    except
      MessageDlgXP_Vista('Could not read information from server',mtInformation,[mbOk],0);
      result:= false;
      exit;
    end;
    for x:= 0 to form.lstMessageTypesToLog.Count -1 do begin
      if form.lstMessageTypes.Items.IndexOf(form.lstMessageTypesToLog.Items[x]) > -1 then
        form.lstMessageTypes.Items.Delete(form.lstMessageTypes.Items.IndexOf(form.lstMessageTypesToLog.Items[x]));
    end;

    result:= form.ShowModal = mrOk;
    if result then begin
      try
        if form.chkUseSSL.Checked then Client.RemotePropertyStr['UseSSL']:= 'True'
        else Client.RemotePropertyStr['UseSSL']:= 'False';
        Client.RemotePropertyStr['LogMessageTypes']:= form.lstMessageTypesToLog.Items.CommaText;
        if form.chkLogToFile.Checked then Client.RemotePropertyStr['LogToFile']:= 'True'
        else Client.RemotePropertyStr['LogToFile']:= 'False';
        if form.chkLogToEvent.Checked then Client.RemotePropertyStr['LogToEvent']:= 'True'
        else Client.RemotePropertyStr['LogToEvent']:= 'False';
        Client.RemotePropertyStr['Port']:= form.edtXMLServerPort.Text;
        Client.RemotePropertyStr['MaxSessionCount']:= form.edtMaxSessionCount.Text;
        Client.RemotePropertyStr['SessionTimeoutSeconds']:= form.edtSessionTimeoutSecondes.Text;
      except
        MessageDlgXP_Vista('Failed to save some changes to server',mtInformation,[mbOk],0);
        result:= false;
        exit;
      end;
    end;
  finally
    form.Release;
  end;
end;

procedure TfmConfig.btnAddClick(Sender: TObject);
var
  x: integer;
begin
  x:= lstMessageTypes.ItemIndex;
  if x > -1 then begin
    lstMessageTypesToLog.Items.Add(lstMessageTypes.Items[x]);
    lstMessageTypes.Items.Delete(x);
  end;
end;

procedure TfmConfig.btnRemoveClick(Sender: TObject);
var
  x: integer;
begin
  x:= lstMessageTypesToLog.ItemIndex;
  if x > -1 then begin
    lstMessageTypes.Items.Add(lstMessageTypesToLog.Items[x]);
    lstMessageTypesToLog.Items.Delete(x);
  end;
end;

end.
