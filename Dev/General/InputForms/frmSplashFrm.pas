unit frmSplashFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, OleCtrls, WallPaper, AdvPicture,
  frmBase, StdCtrls, Menus;

type
  TfrmSplash = class(TfrmBaseGUI)
    Timer1: TTimer;
    AdvPicture1: TAdvPicture;
    Label1: TLabel;
    Shape1: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    //procedure FormPaint(Sender: TObject);

  private
    { Private declarations }
  Protected
    function ignorelogInuseform:boolean;Override;

  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

uses
  IniFiles, DNMLib,systemlib;

{$R *.DFM}

procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
    Procedure AppNameChange;
    var
      ini: TMemIniFile;
    begin
      If FileExists(SystemLib.ExeDir + 'Name.ini') then Begin
        ini:= TMemIniFile.Create(SystemLib.ExeDir + 'Name.ini');
        try
            Application.Title := ini.ReadString('AppName', 'Title','ERP');
        finally
          FreeandNil(ini);
        end;
      end;
    end;
begin
  inherited;
  AppNameChange;
  If FileExists(ExeDir + 'Splash.jpg') then
    Self.AdvPicture1.Picture.LoadFromFile(ExeDir + 'Splash.jpg');
end;

procedure TfrmSplash.FormDestroy(Sender: TObject);
begin
  //inherited;
end;

function TfrmSplash.ignorelogInuseform: boolean;
begin
  REsult := True;
end;

end.
