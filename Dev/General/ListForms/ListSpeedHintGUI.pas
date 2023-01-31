unit ListSpeedHintGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseHintForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, wwcheckbox, Menus;

type
  TfrmQrySpeedHintGUI = class(TBaseHintGUI)
    BitBtn2: TDNMSpeedButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OpenedHintOwner: TObject;
    //class function Instance: TBaseHintGUI; reintroduce;
  end;

implementation
   
uses BaseListingForm,  AppEnvironment, CommonLib;
{$R *.dfm}

procedure TfrmQrySpeedHintGUI.BitBtn2Click(Sender: TObject);
begin
  inherited;
  TBaseListingGUI(OpenedHintOwner).FromListSpeed := true;
  TBaseListingGUI(OpenedHintOwner).btnCustomize.Click;
  TBaseListingGUI(OpenedHintOwner).FromListSpeed := false;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TfrmQrySpeedHintGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  AppEnv.Employee.ShowQuerySpeedNotification := not (chkDontShowHint.Checked);
  inherited;
//  frmQrySpeedHintGUI := nil;
end;

procedure TfrmQrySpeedHintGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Initialization
  RegisterClassOnce(TfrmQrySpeedHintGUI);

end.
