unit frmInstallVideoChoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, ImgList;

type

  TInstallChoice = (icServer, icUser, icVideo);

  TfmInstallVideoChoice = class(TForm)
    btnServer: TDNMSpeedButton;
    btnVideo: TDNMSpeedButton;
    btnClient: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
    procedure btnServerClick(Sender: TObject);
    procedure btnClientClick(Sender: TObject);
  private
    { Private declarations }
  public
    SelectionResult: string;
  end;


  function SelectInstallOption(const InstallType: string): string;

implementation

{$R *.dfm}

function SelectInstallOption(const InstallType: string): string;
var
  form: TfmInstallVideoChoice;
begin
  form:= TfmInstallVideoChoice.Create(nil);
  try
    if InstallType = 'Server' then form.btnServer.Visible:= true
    else if InstallType = 'Client' then form.btnClient.Visible:= true;
    form.ShowModal;
    result:= form.SelectionResult;
  finally
    form.Release;
  end;
end;

procedure TfmInstallVideoChoice.FormCreate(Sender: TObject);
begin
  SelectionResult:= '';
  btnClient.Left:= btnServer.Left;
  btnClient.Top:= btnServer.Top;
end;

procedure TfmInstallVideoChoice.btnVideoClick(Sender: TObject);
begin
  SelectionResult:= 'Video';
  ModalResult:= mrOk;
end;

procedure TfmInstallVideoChoice.btnServerClick(Sender: TObject);
begin
  SelectionResult:= 'Server';
  ModalResult:= mrOk;
end;

procedure TfmInstallVideoChoice.btnClientClick(Sender: TObject);
begin
  SelectionResult:= 'Client';
  ModalResult:= mrOk;
end;

end.
