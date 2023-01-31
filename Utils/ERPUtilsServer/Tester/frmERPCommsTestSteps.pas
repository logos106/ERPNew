unit frmERPCommsTestSteps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseTestSteps, StdCtrls, Shader, DNMSpeedButton, ExtCtrls,
  DNMPanel;

type
  TfmERPCommsTestSteps = class(TfmBaseTestSteps)
    procedure FormCreate(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmERPCommsTestSteps: TfmERPCommsTestSteps;

implementation

uses
  ERPCommsTestObj, JsonObject;

{$R *.dfm}

procedure TfmERPCommsTestSteps.btnTestClick(Sender: TObject);
var
  context: TJsonObject;
begin
  context := JO;
  try
    Tester.Reset;
    Application.ProcessMessages;
    Tester.Test(context);
  finally
    context.Free;
  end;
end;

procedure TfmERPCommsTestSteps.FormCreate(Sender: TObject);
begin
  inherited;
  Tester := TWebApiTestList.Create;

end;

end.
