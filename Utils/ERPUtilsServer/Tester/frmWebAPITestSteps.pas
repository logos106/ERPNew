unit frmWebAPITestSteps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WebApiTestObj, StdCtrls, ExtCtrls, DNMSpeedButton, DNMPanel, Shader,
  frmBaseTestSteps, TesterObj, ProgressDialog;

type
  TfmWebApiTestSteps = class(TfmBaseTestSteps)
    Label1: TLabel;
    edtERPServer: TEdit;
    lblInternetAddress: TLabel;
    edtPublicIP: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fShowPublicIP: boolean;
    fTestingInProgress: boolean;
    ProgDialog: TProgressDialog;
    procedure SetERPServer(const Value: string);
    procedure SetPublicIP(const Value: string);
    function GetERPServer: string;
    function GetPublicIP: string;
    function GetShowPublicIP: boolean;
    procedure SetShowPublicIP(const Value: boolean);
    procedure DoOnTestStart(Step: TTestStep);
    procedure DoOnTestEnd(Step: TTestStep);
  public
    property ERPServer: string read GetERPServer write SetERPServer;
    property PublicIP: string read GetPublicIP write SetPublicIP;
    property ShowPublicIP: boolean read GetShowPublicIP write SetShowPublicIP;
  end;

var
  fmWebApiTestSteps: TfmWebApiTestSteps;

implementation

{$R *.dfm}

uses
  TestItemGUI, JsonObject, Vista_MessageDlg;

procedure TfmWebApiTestSteps.btnTestClick(Sender: TObject);
var
  context: TJsonObject;
begin
  context := JO;
  fTestingInProgress := True;
  try
    context.S['ERPServer'] := ERPServer;
    context.S['PublicIP'] := PublicIP;
    Tester.Reset;
    Application.ProcessMessages;
    Tester.Test(context);
  finally
    context.Free;
    fTestingInProgress := False;
  end;
end;

procedure TfmWebApiTestSteps.DoOnTestEnd(Step: TTestStep);
begin
  ProgDialog.Free;
end;

procedure TfmWebApiTestSteps.DoOnTestStart(Step: TTestStep);
begin
  ProgDialog := TProgressDialog.Create(nil);
  ProgDialog.MaxValue := 100;
  ProgDialog.MinValue := 1;
  ProgDialog.Step := 1;
  ProgDialog.Value := 50;
  ProgDialog.TimerUpdate := true;
  ProgDialog.Caption := 'Please Wait .. Testing Step: ' + IntToStr(Step.StepNumber); //  Step.Caption;
  ProgDialog.Execute;
end;

procedure TfmWebApiTestSteps.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if fTestingInProgress then begin
    CanClose := false;
    Vista_MessageDlg.MessageDlgXP_Vista('Can not exit until all tests are complete.',mtInformation,[mbOk],0);
  end;
end;

procedure TfmWebApiTestSteps.FormCreate(Sender: TObject);
begin
  inherited;
  fTestingInProgress := False;
  fShowPublicIP := True;
  Tester := TWebApiTestList.Create;
  Tester.OnTestStepStart := Self.DoOnTestStart;
  Tester.OnTestStepFinish := Self.DoOnTestEnd;
end;

procedure TfmWebApiTestSteps.FormDestroy(Sender: TObject);
begin
  Tester.Free;
end;

function TfmWebApiTestSteps.GetERPServer: string;
begin
  result := edtERPServer.Text;
end;

function TfmWebApiTestSteps.GetPublicIP: string;
begin
  result := edtPublicIP.Text;
end;

function TfmWebApiTestSteps.GetShowPublicIP: boolean;
begin
  result := fShowPublicIP;
end;

procedure TfmWebApiTestSteps.SetERPServer(const Value: string);
begin
  edtERPServer.Text:= Value;
end;

procedure TfmWebApiTestSteps.SetPublicIP(const Value: string);
begin
  edtPublicIP.Text := Value;
end;

procedure TfmWebApiTestSteps.SetShowPublicIP(const Value: boolean);
begin
  fShowPublicIP := Value;
  lblInternetAddress.Visible := fShowPublicIP;
  edtPublicIP.Visible := fShowPublicIP;
  Label3.Visible := fShowPublicIP;
end;

initialization
  RegisterClass(TfmWebApiTestSteps);

end.
