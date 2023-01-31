Unit SrvServiceGUI;

Interface 

Uses Forms, Windows, StdCtrls, Controls, ExtCtrls, Classes, AdvMemo,
  AdvPanel, AdvSplitter;

Type 
  TServerServicesGUI = Class(TForm)
    Panel5: TAdvPanel;
    memLog: TAdvMemo;
    Splitter1: TAdvSplitter;
    Panel2: TAdvPanel;
    Panel3: TAdvPanel;
    lbChecked: TLabel;
    Splitter2: TAdvSplitter;
    Panel1: TAdvPanel;
    Panel4: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    Label2: TLabel;
    Label3: TLabel;
    DNMPanel1: TAdvPanel;
    Label1: TLabel;
    memPresent: TAdvMemo;
    memAlarmLog: TAdvMemo;
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure FormDestroy(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    procedure memoSelectionChange(Sender: TObject);
  Private
  Public 
  End;
Var 
  ServerServicesGUI: TServerServicesGUI;

Implementation 

Uses SrvServiceFunctionLib;

{$R *.dfm} 

Procedure TServerServicesGUI.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin 
  memLog.Clear;
  memPresent.Clear;
  memAlarmLog.Clear;
  Self.Update;
  Inherited;
  Action := caFree;
  ServerServicesGUI := Nil;
End;

Procedure TServerServicesGUI.FormDestroy(Sender: TObject);
Begin 
  Inherited;
  ServerServicesGUI := Nil;
End;

Procedure TServerServicesGUI.FormShow(Sender: TObject);
Begin 
  Self.Caption := 'ERP Server Services v' + SrvServiceFunctionLib.VERSION;
  Self.BringToFront;
  Self.SetFocus;
End;

procedure TServerServicesGUI.memoSelectionChange(Sender: TObject);
begin
  TAdvMemo(Sender).Selection := '';
end;

End.
