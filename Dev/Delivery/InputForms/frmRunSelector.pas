unit frmRunSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess, SelectionDialog, AppEvnts,
  DB,  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, Grids,
  Wwdbigrd, Wwdbgrid, MemDS, DataState, DeliveryLib, Menus, AdvMenus, Shader;

type
  TfrmRunSelectorGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryRun: TMyQuery;
    grdRuns: TwwDBGrid;
    dsRuns: TDataSource;
    qryRunRunID: TIntegerField;
    qryRunRunName: TStringField;
    qryRunActive: TStringField;
    qryRunOperator: TStringField;
    qryRunOperatorID: TIntegerField;
    qryRunRunDate: TDateField;
    qryRunGlobalRef: TStringField;
    qryRunClassName: TStringField;
    qryRunClassID: TIntegerField;
    qryRunIsPublicHoliday: TStringField;
    tmrCheck: TTimer;
    btnNew: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure grdRunsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrCheckTimer(Sender: TObject);
    procedure grdRunsEnter(Sender: TObject);
    procedure btnNewClick(Sender: TObject);

  private
    { Private declarations }
    poRunInfo: PRunInfo;
    
  public
    { Public declarations }
    fbInitialising: boolean;
    fbAutoClose: boolean;
    property ResultRecord: PRunInfo read poRunInfo write poRunInfo default nil;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, frmRunName, CommonLib;

procedure TfrmRunSelectorGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmRunSelectorGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  ZeroMemory(ResultRecord, SizeOf(TRunInfo));
  ModalResult := mrCancel;
end;

procedure TfrmRunSelectorGUI.cmdOKClick(Sender: TObject);
begin
  inherited;
  if Assigned(ResultRecord) then begin
    // Populate result record.
    ResultRecord^.RunID      := qryRun.FieldByName('RunID').AsInteger;
    ResultRecord^.RunName    := qryRun.FieldByName('RunName').AsString;
    ResultRecord^.OperatorID := qryRun.FieldByName('OperatorID').AsInteger;
    ResultRecord^.Operator   := qryRun.FieldByName('Operator').AsString;
    ResultRecord^.Date       := qryRun.FieldByName('RunDate').AsDateTime;
    ResultRecord^.ClassID    := qryRun.FieldByName('ClassID').AsInteger;
  end;
  ModalResult := mrOk;
end;

procedure TfrmRunSelectorGUI.grdRunsDblClick(Sender: TObject);
begin
  inherited;
  cmdOk.Click;
end;

procedure TfrmRunSelectorGUI.FormCreate(Sender: TObject);
begin
  tmrCheck.Enabled := false;
  fbInitialising := true;
  Self.fbIgnoreAccessLevels := true;
  inherited;
  fbAutoClose := false;
end;

procedure TfrmRunSelectorGUI.FormShow(Sender: TObject);
begin
  try
    inherited;

    OpenQueries;
    if qryRun.RecordCount = 0 then begin
      CommonLib.MessageDlgXP_Vista('It appears you have NO Available Run Names to select! Please create your run names and try again.',
        mtWarning, [mbOK], 0);
      fbAutoClose := true;
    end;

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfrmRunSelectorGUI.FormActivate(Sender: TObject);
begin
  inherited;
  fbInitialising := false;
  tmrCheck.Enabled := true;
end;

procedure TfrmRunSelectorGUI.tmrCheckTimer(Sender: TObject);
begin
  inherited;
  if fbAutoClose then begin
    tmrCheck.Enabled := false;
    Close;
  end else begin
    tmrCheck.Enabled := false;
  end;

  Application.ProcessMessages;
end;

procedure TfrmRunSelectorGUI.grdRunsEnter(Sender: TObject);
begin
  inherited;
  cmdOk.Enabled := true;
end;

procedure TfrmRunSelectorGUI.btnNewClick(Sender: TObject);
var
  iResult: integer;
  Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmRunCreator');
  if Assigned(Form) then begin
    with TfrmRunCreator(Form) do begin
      FormStyle := fsNormal;
      iResult   := ShowModal;
    end;
    if iResult = mrOk then begin
      // Refresh List
      qryRun.Close;
      qryRun.Open;
    end;
  end;  
end;

initialization
  RegisterClassOnce(TfrmRunSelectorGUI);

end.
