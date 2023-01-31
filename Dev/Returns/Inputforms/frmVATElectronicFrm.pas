unit frmVATElectronicFrm;
      {PROTOCOL STATES: Submission,Polling,ResponseRecieved,DeleteResponse,ErrorState  }

interface

uses
  Forms,MyAccess,ERPdbComponents,BaseInputForm, ExtCtrls, DB, MemDS, DBAccess, StdCtrls,
  DNMPanel, Grids, Wwdbigrd, Wwdbgrid, Controls, DNMSpeedButton, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, Graphics, Classes,UKElectronic,
  Dialogs, wwdbdatetimepicker, Shader, ComCtrls, ImgList, ProgressDialog;

type
  TRec = class(TObject)
  private
  public
    sDocType            : string;
    sID                 : string;
    sState              : string;
    sCorrelationID      :string;
  end;

type
  TfrmVATElectronic = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    Label3: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    MemoError: TMemo;
    DNMPanel3: TDNMPanel;
    Label7: TLabel;
    Label8: TLabel;
    dtpFrom: TwwDBDateTimePicker;
    dtpTo: TwwDBDateTimePicker;
    btnRecovery: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    Label2: TLabel;
    lblType: TLabel;
    Label4: TLabel;
    lblNumber: TLabel;
    Label5: TLabel;
    lblLocation: TLabel;
    lblState: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    ProgressBar: TProgressBar;
    DNMPanel6: TDNMPanel;
    Label9: TLabel;
    DNMPanel4: TDNMPanel;
    btnClose: TDNMSpeedButton;
    grdSubs: TStringGrid;
    btnStop: TDNMSpeedButton;
    btnProcess: TDNMSpeedButton;
    lblMode: TLabel;
    Timer1: TTimer;
    MemoAction: TMemo;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure btnRecoveryClick(Sender: TObject);
    procedure IncrementProgressBar;
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    fSavedColor:TColor;
    fVatReturnID:integer;
    fYear:integer;
    fMonth:string;
    Electronic:TUKElectronic;
  public
    property VatReturnID :integer read fVatReturnID write fVatReturnID;
    property Year:integer read fYear write fYear;
    property Month: string read fMonth write fMonth;
    procedure DoMessageEvent(const Sender: TUKElectronic; const EventType, Value: string);
  end;

implementation
uses
  CommonLib,SysUtils,AppEnvironment;
{$R *.dfm}

procedure TfrmVATElectronic.IncrementProgressBar;
begin
  try
    ProgressBar.Position := ProgressBar.Position + 1;
  except

  end;
end;

procedure TfrmVATElectronic.DoMessageEvent(const Sender: TUKElectronic; const EventType, Value: string);
  begin
  if Value = 'Stop' then begin
    CommonLib.MessageDlgXP_Vista('The Gateway has responded with a fatal error. Check your authentication', mtInformation , [mbOK], 0);
    MemoAction.Lines.Add('Stop  ' + FormatDateTime('dd-mmmm-YYYY hh:mm:ss',Now));
  end else if Value = 'Poll' then begin
    lblState.caption := 'Re-polling...';
    IncrementProgressBar;
    MemoAction.Lines.Add('Poll  ' + FormatDateTime('dd-mmmm-YYYY hh:mm:ss',Now));
  end else if Value = 'Finalise' then begin
    CommonLib.MessageDlgXP_Vista('The Gateway has accepted this submission.', mtInformation , [mbOK], 0);
    MemoAction.Lines.Add('Delete  ' + FormatDateTime('dd-mmmm-YYYY hh:mm:ss',Now));
  end else if Value = 'Submit' then begin
    lblState.caption := 'Submitting...';
    MemoAction.Lines.Add('Submit  ' + FormatDateTime('dd-mmmm-YYYY hh:mm:ss',Now));
  end else if Value = 'HandleBodyErrors' then
    CommonLib.MessageDlgXP_Vista('The Gateway has responded with a business data error.', mtInformation , [mbOK], 0)
  else if Value = 'manyAttempts' then begin
    lblState.caption := 'Excessive attempts.';
    CommonLib.MessageDlgXP_Vista('The Gateway may be busy at this time or the response may have previously been lost in transmisson. Try "Get List".', mtInformation , [mbOK], 0);
  end else if Value = 'DataSubmitError' then
    lblState.caption := 'Submission Error in list.'
  else if Value = 'RequestData' then begin
    lblState.caption := 'Requesting list...';
    MemoAction.Lines.Add('Data Request  ' + FormatDateTime('dd-mmmm-YYYY hh:mm:ss',Now));
  end else if Value = 'Delete' then lblState.caption := 'Finalising submission...'
  else if EventType = 'UpdateStatus' then lblState.caption := Value
  else if EventType = 'UpdateErrorMsg' then MemoError.Text := Value
  else if EventType = 'UpdateErrorType' then lblType.caption := Value
  else if EventType = 'UpdateErrorNumber' then lblNumber.caption := Value
  else if EventType = 'UpdateErrorLocation' then lblLocation.caption := Value
  else if EventType = 'Status' then lblState.caption := Value
  else if EventType = 'Finalised' then CommonLib.MessageDlgXP_Vista(value, mtInformation , [mbOK], 0)
  else if EventType = 'MissingListDates' then CommonLib.MessageDlgXP_Vista(value, mtWarning , [mbOK], 0)
  else if EventType = 'MissingData' then CommonLib.MessageDlgXP_Vista(value, mtWarning , [mbOK], 0)
  else if EventType = 'TransmissionFailure' then CommonLib.MessageDlgXP_Vista(value, mtWarning , [mbOK], 0)
  else if EventType = 'SuccessFound' then begin
    if CommonLib.MessageDlgXP_Vista(value, mtConfirmation, [mbYes, mbNo], 0) = mrYes then Electronic.FinaliseList;
  end else if EventType = 'OfferTrySubmitAgain' then begin
    if CommonLib.MessageDlgXP_Vista(value, mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      Electronic.ReSubmit;
    end;
  end else if EventType = 'errorlist' then begin
    MemoError.Lines.Add(value);
  end;

  Application.ProcessMessages;
end;

procedure TfrmVATElectronic.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmVATElectronic.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;


procedure TfrmVATElectronic.FormShow(Sender: TObject);
begin
  inherited;
  Electronic.OnMessageChange := DoMessageEvent;

  Electronic.DeclarationType := 'VAT';
  Electronic.GenericKeyID := VatReturnID;
  Electronic.TestValue := '1';
  Electronic.Year := fYear;
  Electronic.Month := fMonth;

  grdSubs.Cols[0].Add('Document Type');
  grdSubs.Cols[1].Add('ID');
  grdSubs.Cols[2].Add('Protocol State');
  grdSubs.Cols[3].Add('CorrelationID');

  grdSubs.ColWidths[0] := 100;
  grdSubs.ColWidths[1] := 50;
  grdSubs.ColWidths[2] := 200;
  grdSubs.ColWidths[3] := 300;

  fSavedColor := btnStop.Color;
  if AppEnv.CompanyPrefs.UKGatewayIsLive then lblMode.caption := 'Live Mode' else lblMode.caption := 'Test Mode';
  Timer1.Enabled := True;
end;


procedure TfrmVATElectronic.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(Electronic) then FreeAndNil(Electronic);
end;


procedure TfrmVATElectronic.btnProcessClick(Sender: TObject);
begin
  inherited;
  Processingcursor(True);
  ProgressBar.Max := AppEnv.CompanyPrefs.VATMaxAttemptsPerSession;
  try
    Electronic.Execute;
  finally
    Processingcursor(False);
    ProgressBar.Position := 0;
  end;
end;

procedure TfrmVATElectronic.btnRecoveryClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  Processingcursor(True);
  try
    ProgressBar.Max := 3;
    ProgressBar.Position := 1;
    //clear grid
    grdSubs.Rowcount := 2;
    grdSubs.Cells[0,1] := '';
    grdSubs.Cells[1,1] := '';
    grdSubs.Cells[2,1] := '';
    grdSubs.Cells[3,1] := '';
    if AppEnv.CompanyPrefs.UKGatewayIsLive then
      Electronic.TestValue := '0'
    else
      Electronic.TestValue := '1';

    Electronic.DeclarationType := 'VAT';
    Electronic.ListStartDate := dtpFrom.Text;
    Electronic.ListEndDate   := dtpTo.Text;
    Electronic.SendDataRequest;
    ProgressBar.Position := 2;
    for i := 0 to (Electronic.GatewayList.Count - 1) do begin
      grdSubs.RowCount := grdSubs.RowCount + 1;
      grdSubs.Cells[0,i + 1] := TRec(Electronic.GatewayList[i]).sDocType;
      grdSubs.Cells[1,i + 1] := TRec(Electronic.GatewayList[i]).sID;
      grdSubs.Cells[2,i + 1] := TRec(Electronic.GatewayList[i]).sState;
      grdSubs.Cells[3,i + 1] := TRec(Electronic.GatewayList[i]).sCorrelationID;
    end;
    ProgressBar.Position := 3;
    // for any unfinalised declarations take appropriate action
  finally
    Processingcursor(False);
    ProgressBar.Position := 0;
  end;
  Electronic.ProcessGatewayList;
end;

procedure TfrmVATElectronic.btnStopClick(Sender: TObject);
begin
  inherited;
  if not Electronic.Stop then begin
    Electronic.Stop := True;
    btnStop.Color := clRed;
  end else begin
    Electronic.Stop := False;
    btnStop.Color := fSavedColor;
  end;
end;

procedure TfrmVATElectronic.FormCreate(Sender: TObject);
begin
  inherited;
  Electronic := TUKElectronic.Create;
end;

procedure TfrmVATElectronic.Timer1Timer(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := False;
  Electronic.Initialise;
end;

initialization
  RegisterClassOnce(TfrmVATElectronic);
end.
