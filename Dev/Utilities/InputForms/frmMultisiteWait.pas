unit frmMultisiteWait;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseHintForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, wwcheckbox, DNMPanel,
  ProgressTime;

type
  TMultisiteWaitGUI = class(TBaseHintGUI)
    ProgressTime1: TProgressTime;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  Forms;

{$R *.dfm}

procedure TMultisiteWaitGUI.FormShow(Sender: TObject);
begin
  inherited;
  ProgressTime1.Start('Working...');
  Application.ProcessMessages;
end;

procedure TMultisiteWaitGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  CanClose := false;
end;

end.
