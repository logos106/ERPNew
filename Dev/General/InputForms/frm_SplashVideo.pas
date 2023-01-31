unit frm_SplashVideo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, OleCtrls, WallPaper, AdvPicture,
  frmBase, StdCtrls, Menus, MPlayer, tcConst;

type
  TfrmSplashVideo = class(TfrmBaseGUI)
    Timer1: TTimer;
    Label1: TLabel;
    MediaPlayer1: TMediaPlayer;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //procedure FormPaint(Sender: TObject);

  private
    fDone: boolean;
    property Done : boolean read fDone write fDone;
  Protected
    function ignorelogInuseform:boolean;Override;
    procedure Loaded; override;
  public
    constructor create(AOwner:Tcomponent);Override;
  end;

var
  frmSplashVideo: TfrmSplashVideo;

implementation

uses
  IniFiles, DNMLib,systemlib;

{$R *.DFM}

constructor TfrmSplashVideo.create(AOwner: Tcomponent);
begin
  inherited;
//
end;

procedure TfrmSplashVideo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmSplashVideo.Timer1Timer(Sender: TObject);
begin
  if Done then
  begin
    if MediaPlayer1.Mode = mpStopped then
      self.Close;
  end
  else begin
    Done := MediaPlayer1.Mode = mpPlaying;
  end;
end;

procedure TfrmSplashVideo.FormCreate(Sender: TObject);
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
  Done := false;
  AppNameChange;
  (*
  If FileExists(ExeDir + 'Splash.jpg') then
    Self.AdvPicture1.Picture.LoadFromFile(ExeDir + 'Splash.jpg');
    *)
end;

procedure TfrmSplashVideo.FormDestroy(Sender: TObject);
begin
  //inherited;
end;

procedure TfrmSplashVideo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then Begin
    Key := 0;
    Self.Close;
  End;
end;

procedure TfrmSplashVideo.FormShow(Sender: TObject);
var
  lRatio : double;
begin
  inherited;
  MediaPlayer1.Open;
  // Recalc form sizes to keep the video ratio. Note that we keep the width of the original form, which is
  // to be changed at design time if needed
  lRatio := MediaPlayer1.DisplayRect.Bottom / MediaPlayer1.DisplayRect.Right;
  Self.Height := round(Self.Width * lRatio);
  // DisplayRect is to be changed after the call to Open, since Open sets it to the video frame sizes
  MediaPlayer1.DisplayRect := Panel1.ClientRect;
//  MediaPlayer1.Notify := true;
  MediaPlayer1.Play;
end;

function TfrmSplashVideo.ignorelogInuseform: boolean;
begin
  REsult := True;
end;


procedure TfrmSplashVideo.Loaded;
begin
  MediaPlayer1.FileName := ExtractFilePath(Application.ExeName) + csSplashScreenVideoFile;
  inherited;

end;

end.
