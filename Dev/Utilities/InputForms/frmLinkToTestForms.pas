unit frmLinkToTestForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton;

type
  TfmLinkToTestForms = class(TBaseForm)
    btnCancel: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    btnCHeckSiteIntergration: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnCHeckSiteIntergrationClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLinkToTestForms: TfmLinkToTestForms;

implementation

{$R *.dfm}

uses
  //CommonFormLib,
  frmWebAPITestSteps, CommonDbLib, frmSiteIntergrationTestSteps, MAIN;

procedure TfmLinkToTestForms.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmLinkToTestForms.btnCHeckSiteIntergrationClick(Sender: TObject);
var
  SiteIntTest: TfmSiteIntergrationTestSteps;
begin
  inherited;
  SiteIntTest := TfmSiteIntergrationTestSteps.Create(nil);
  SiteIntTest.ERPServer:= CommonDBLib.GetSharedMyDacConnection.Server;
  SiteIntTest.FormStyle:= fsMDIChild;
  SiteIntTest.BringToFront;
  mainform.SubformPostionMiddle(SiteIntTest);
  Close;
end;

procedure TfmLinkToTestForms.DNMSpeedButton1Click(Sender: TObject);
var
  ApiTest: TfmWebApiTestSteps;
begin
  inherited;
  ApiTest:= TfmWebApiTestSteps.Create(nil);
  ApiTest.ERPServer:= CommonDBLib.GetSharedMyDacConnection.Server;
  ApiTest.PublicIP := '';
  ApiTest.FormStyle:= fsMDIChild;
  ApiTest.BringToFront;
  Close;
end;

procedure TfmLinkToTestForms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

initialization
  RegisterClass(TfmLinkToTestForms);

end.
