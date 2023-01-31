unit PbxPopupFrm;
{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 23/12/05  1.00.02 AL   Added button "Add to Client"
                        Changed SQL in GetCallerName to look in additional table
 29/12/05  1.00.03 AL   Added hideTimer and labelCounter
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Buttons, DNMSpeedButton, wwdblook, ExtCtrls, DNMPanel, MPlayer, CustomInputBox, DBAccess,
  MyAccess, DataState, Menus, AdvMenus, MemDS, Shader;

const
  SX_GetCaller = WM_USER + 100;

type
  TPbxPopupGUI = class(TBaseInputGUI)
    lblCallerNum: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblName: TLabel;
    btnClose: TDNMSpeedButton;
    btnTransfer: TDNMSpeedButton;
    cboTransfer: TwwDBLookupCombo;
    qryExtensions: TMyQuery;
    cboReply: TComboBox;
    btnReply: TDNMSpeedButton;
    lblReplyLabel: TLabel;
    lblReply: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnView: TDNMSpeedButton;
    btnRecord: TDNMSpeedButton;
    MediaPlayer1: TMediaPlayer;
    dlgRef: TCustomInputBox;
    btnAddToClient: TDNMSpeedButton;
    btnMessage: TDNMSpeedButton;
    timerHide: TTimer;
    labelCounter: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnReplyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRecordClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnAddToClientClick(Sender: TObject);
    procedure btnMessageClick(Sender: TObject);
    procedure timerHideTimer(Sender: TObject);
    procedure labelCounterClick(Sender: TObject);
    procedure pnlHeaderClick(Sender: TObject);
  private
    { Private declarations }
    iClientID: integer;
    bFirstTime: boolean;
    sRef: string;
    bAddToClientUsed: boolean;
    procedure GetCallerName(var Msg: TMessage); message SX_GetCaller;
    Procedure StopTimer;
  public
    { Public declarations }
    fiCallHandle: integer;
    fsExt: string;
    fsFromExt: string;
    fsAction: string;
    fsReply: string;
  end;

//var
//  PbxPopupGUI: TPbxPopupGUI;

implementation

uses
  frmCustomerfrm, CommonDbLib, MMSystem, strUtils,  DNMLib, 
  MAIN, CommonLib, GlobalListGUI, frmMessages, AppEnvironment, FastFuncs;

{$R *.dfm}

procedure TPbxPopupGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  bFirstTime := true;
  iClientID := 0;
  bAddToClientUsed := false;
  if AppEnv.CompanyPrefs.CallMonitorHideTime > 0 then begin
    timerHide.Enabled := true;
    labelCounter.Caption := 'Click here to prevent closing this window in '+ FastFuncs.IntToStr(AppEnv.CompanyPrefs.CallMonitorHideTime)+' seconds';
    labelCounter.Visible := true;
  end;
end;

procedure TPbxPopupGUI.GetCallerName(var Msg: TMessage);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  if lblCallerNum.Caption <> 'Private No' then begin
    try
      with qry do begin
        SQL.Clear;
        SQL.Add('SELECT C.ClientID, Company' +
          ' FROM tblClients C' +
          ' LEFT JOIN tblClientsOtherPhones COP ON COP.ClientID = C.ClientID '+
          ' WHERE (C.Phone = :xPhone) OR (COP.Phone = :xPhone1)');
        ParamByName('xPhone').asString := lblCallerNum.Caption;
        ParamByName('xPhone1').asString := lblCallerNum.Caption;
        Open;
        if not IsEmpty then begin
          lblName.Caption := qry.FieldByName('Company').AsString;
          iClientID := qry.FieldByName('ClientID').AsInteger;
        end else begin
          lblName.Caption := 'Unknown';
          btnView.Enabled := false;
          btnAddToClient.Enabled := false;
        end;
      end;
    finally
      FreeAndNil(qry);
    end;
  end {if}
  else begin
    lblName.Caption := 'Unknown';
    btnView.Enabled := false;
    btnAddToClient.Enabled := false;
  end;

  // also fill in query
  qryExtensions.Connection := MainForm.PbxConnection;
  qryExtensions.Open;
end;

procedure TPbxPopupGUI.FormShow(Sender: TObject);
begin
  inherited;

  self.Left := 5 + Random(10);
  self.Top := 5 + Random(10);

  if fsAction = 'T' then begin
    TitleLabel.Caption := 'Transfer Request';
    cboTransfer.Visible := false;
    btnTransfer.Visible := false;
    btnClose.Enabled    := false;
    cboReply.Visible    := true;
    btnReply.Visible    := true;
    btnRecord.Enabled   := true;
  end else if fsAction = 'R' then begin
    TitleLabel.Caption := 'Transfer Reply';
    cboTransfer.Visible   := false;
    btnTransfer.Visible   := false;
    lblReplyLabel.Visible := true;
    lblReply.Visible      := true;
    lblReply.Caption      := fsReply;
    btnRecord.Enabled     := true;
  end;

  PostMessage(self.Handle, SX_GetCaller, 0, 0);  // fill in the client name later
  //Deactivate;
end;

procedure TPbxPopupGUI.btnTransferClick(Sender: TObject);
var
  qry: TMyQuery;
begin
  if Empty(FastFuncs.Trim(cboTransfer.Text)) then begin
    Exit;
  end;


  // create a 'Transfer' in call table
  qry := TMyQuery.Create(self);
  try
    qry.Connection := MainForm.PbxConnection;
    with qry do begin
      Sql.Clear;
      Sql.Add('INSERT tblcalls ' +
        '(CallHandle, ' +
        'CallerNumber, ' +
        'Ext, ' +
        'Action, ' +
        'FromExt, ' +
        'StateDescription, ' +
        'State, ' +
        'Alarm) ' +
        'VALUES ' +
        '(:xCallHandle, ' +
        ':xCallerNumber, ' +
        ':xExt, ' +
        '"T", ' +
        ':xFromExt, ' +
        ':xStateDescription, ' +
        ':xState, ' +
        '"T")');
      with qry.Params do begin
        ParamByName('xCallHandle').asInteger := fiCallHandle;
        ParamByName('xCallerNumber').asString := lblCallerNum.Caption;
        ParamByName('xExt').asString := qryExtensions.FieldByName('Extension').AsString;
        ParamByName('xFromExt').asString := fsExt;
        ParamByName('xState').asInteger := 0;
        ParamByName('xStateDescription').asString := 'Popup Transfer';
      end;
      Execute;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
    self.Close;
    btnClose.Enabled := true;     // not used at the moment cuz we close it
  end;
end;

procedure TPbxPopupGUI.btnReplyClick(Sender: TObject);
var
  qry: TMyQuery;
begin
  // create a 'Reply' in call table

  qry := TMyQuery.Create(self);
  try
    qry.Connection := MainForm.PbxConnection;
    with qry do begin
      Sql.Clear;
      Sql.Add('INSERT tblcalls ' +
        '(CallHandle, ' +
        'CallerNumber, ' +
        'Ext, ' +
        'Action, ' +
        'FromExt, ' +
        'StateDescription, ' +
        'State, ' +
        'Reply, ' +
        'Alarm) ' +
        'VALUES ' +
        '(:xCallHandle, ' +
        ':xCallerNumber, ' +
        ':xExt, ' +
        '"R", ' +
        ':xFromExt, ' +
        ':xStateDescription, ' +
        ':xState, ' +
        ':xReply, ' +
        '"T")');
      with qry.Params do begin
        ParamByName('xCallHandle').asInteger := fiCallHandle;
        ParamByName('xCallerNumber').asString := lblCallerNum.Caption;
        ParamByName('xExt').asString := fsFromExt;
        ParamByName('xFromExt').asString := fsExt;
        ParamByName('xState').asInteger := 0;
        ParamByName('xReply').asString := cboReply.Text;
        ParamByName('xStateDescription').asString := 'Popup Reply';
      end;
      Execute;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
    btnClose.Enabled := true;
  end;
end;

procedure TPbxPopupGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  if (not bAddToClientUsed) and (iClientId = 0) then begin
    if CommonLib.MessageDlgXP_Vista('Do you wish to save this number?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      btnAddToClientClick(nil);
    end;
  end;
  Close;
end;

procedure TPbxPopupGUI.btnViewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmCustomer');
  If not Assigned(tmpComponent) then Exit;
  with TfrmCustomer(tmpComponent) do begin
    KeyID     := iClientID;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPbxPopupGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPbxPopupGUI.btnRecordClick(Sender: TObject);
var
  bValidFileName: boolean;
  sFileName: string;

  procedure PostToDB;
  var
    qry: TMyQuery;
  begin
    qry := TMyQuery.Create(self);
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      with qry do begin
        Sql.Clear;
        Sql.Add('INSERT tblcallrecordings ' +
          '(Time, ' +
          'ClientID, ' +
          'ClientName, ' +
          'Reference, ' +
          'Employee, ' +
          'Extension) ' +
          'VALUES ' +
          '(:xTime, ' +
          ':xClientID, ' +
          ':xClientName, ' +
          ':xReference, ' +
          ':xEmployee, ' +
          ':xExtension)');
        with qry.Params do begin
          ParamByName('xTime').AsDateTime := Now;
          ParamByName('xClientID').asInteger := iClientID;
          ParamByName('xClientName').AsString := lblName.Caption;
          ParamByName('xReference').AsString := sRef;
          ParamByName('xEmployee').AsString := AppEnv.Employee.LogonName;
          ParamByName('xExtension').AsString := qryExtensions.FieldByName('Extension').AsString;
        end;
        Execute;
      end;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;
  end;
begin  // procedure btnRecordClick
  inherited;
  if btnRecord.Caption = 'Record' then begin
    // get call ref to use as filename

    if iClientID = 0 then begin
      sRef := lblCallerNum.Caption;
    end else begin
      if FastFuncs.StrLength(FastFuncs.Trim(lblName.Caption)) > 25 then begin
        sRef := FastFuncs.LeftStr(FastFuncs.Trim(lblName.Caption), 25);
      end else begin
        sRef := FastFuncs.Trim(lblName.Caption);
      end;
    end;
    sRef := sRef + FormatDateTime(' dd-mmm-yy hhnn ss', Now());

    bValidFileName := false;
    while (not bValidFileName) do begin
      dlgRef.DefaultString := sRef;
      if dlgRef.Execute then begin
        sRef := dlgRef.InputResult;
      end else begin
        Exit;  // quit recording
      end;
      if not IsValidFileName(sRef) then begin
        CommonLib.MessageDlgXP_Vista('The Reference you entered cannot be used as a Valid File Name.' + #13 + #10 +
          'TRY AGAIN', mtError, [mbOK], 0);
      end else begin
        bValidFileName := true;
      end;
    end;

    if bFirstTime then begin
      bFirstTime := false;
      sFileName := AppEnv.CompanyPrefs.RecordingDirectory + '\' + 'template.wav';
      if not FileExists(sFileName) then begin
        if not CreateNewWaveFile(sFileName) then begin
          CommonLib.MessageDlgXP_Vista('Could not Create Template Wave file', mtError, [mbOK], 0);
          Exit;
        end;
      end;
      MediaPlayer1.FileName := sFileName;
      MediaPlayer1.Open;
    end;
    MediaPlayer1.DeviceType := dtWaveAudio;
    MediaPlayer1.StartPos   := 0;
    MediaPlayer1.StartRecording;
    btnRecord.Caption := 'Stop recording';
  end else begin
    sFileName := AppEnv.CompanyPrefs.RecordingDirectory + '\' + sRef + '.wav';
    MediaPlayer1.Stop;
    MediaPlayer1.FileName := sFileName;  // save to the new file
    MediaPlayer1.Save;
    PostToDB;
    btnRecord.Caption := 'Record';
  end;
end;


procedure TPbxPopupGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if btnRecord.Caption = 'Stop Recording' then begin
    if CommonLib.MessageDlgXP_Vista('Are you sure you wish to Cancel this Recording?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      CanClose := true;
    end else begin
      MediaPlayer1.Stop;
      CanClose := false;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TPbxPopupGUI.btnAddToClientClick(Sender: TObject);
Var GlobalListFrm : TGlobalListFrm;
begin
  bAddToClientUsed := true;
   GlobalListFrm := TGlobalListFrm.Create(Application);
   GlobalListFrm.bAddPhoneMode := true;
   GlobalListFrm.sPhone := lblCallerNum.Caption;;
   GlobalListFrm.ShowModal;
end;

procedure TPbxPopupGUI.btnMessageClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmMessagesGUI');
  If not Assigned(tmpComponent) then Exit;
  with TfrmMessagesGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    NewMessage;
    //iClientId := 1; // this line for testing only
    if iClientId <> 0 then begin
       qryMessages.FieldByName('FromId').AsInteger := iClientId;
    end;
    BringToFront;
  end;
end;

procedure TPbxPopupGUI.timerHideTimer(Sender: TObject);
begin
  //inherited;
  if AppEnv.CompanyPrefs.CallMonitorHideTime > 0 then begin
    if (Trunc(timerHide.Interval) >=  Trunc(AppEnv.CompanyPrefs.CallMonitorHideTime * 1000)) then Close;
  end;
end;

procedure TPbxPopupGUI.StopTimer;
begin
  timerHide.Enabled := false;
  labelCounter.Visible := false;
end;

procedure TPbxPopupGUI.labelCounterClick(Sender: TObject);
begin
  inherited;
  StopTimer;
end;
procedure TPbxPopupGUI.pnlHeaderClick(Sender: TObject);
begin
  inherited;
  {this for testing only}
//  btnView.Enabled := true;
//  iClientID := 1;
end;

initialization
  RegisterClassOnce(TPbxPopupGUI);

end.


