unit frmBaseTestSteps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Shader, DNMSpeedButton, ExtCtrls, DNMPanel, TesterObj;

type
  TfmBaseTestSteps = class(TForm)
    pnlMain: TDNMPanel;
    ScrollBox: TScrollBox;
    btnTest: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBoxResize(Sender: TObject);
  private
    fTester: TTestList;
    procedure SetTester(const Value: TTestList);
  protected
    property Tester: TTestList read fTester write SetTester;
  public
    { Public declarations }
  end;

var
  fmBaseTestSteps: TfmBaseTestSteps;

implementation

{$R *.dfm}

uses
  TestItemGUI, JsonObject;


procedure TfmBaseTestSteps.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmBaseTestSteps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmBaseTestSteps.FormCreate(Sender: TObject);
begin
  TitleLabel.Caption := self.Caption;
end;

procedure TfmBaseTestSteps.ScrollBoxResize(Sender: TObject);
var
  x: integer;
begin
  for x:= 0 to ComponentCount -1 do begin
    if Components[x] is TTestItemFrame then
      TTestItemFrame(Components[x]).Width := ScrollBox.ClientWidth;
  end;
end;

procedure TfmBaseTestSteps.SetTester(const Value: TTestList);
var
  x: integer;
  LastFrame, Frame: TTestItemFrame;
begin
  fTester := Value;
  LastFrame:= nil;
  while ScrollBox.ComponentCount > 0 do
    ScrollBox.Components[0].Free;
  for x := 0 to Tester.Count -1 do begin
    Frame:= TTestItemFrame.Create(self);
    Frame.Name:= 'ItemFrame' + IntToStr(x);
    Frame.Parent := ScrollBox;
    Frame.Left := 0;
    Frame.Width := ScrollBox.ClientWidth;
    if Assigned(LastFrame) then
      Frame.Top := LastFRame.Top + LastFrame.Height
    else
      Frame.Top := 0;
    LastFrame:= Frame;
    Frame.TestStep := Tester.Item[x];
  end;
end;


end.
