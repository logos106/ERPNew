unit frmVideoPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer, ExtCtrls;

type
  TfmVideo = class(TForm)
    pnlMain: TPanel;
    pnlBottom: TPanel;
    MediaPlayer: TMediaPlayer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Videofilename:String;
  public
    procedure PlayVideo(const aFileName: string);
  end;


  Procedure PlayERPVideo(const aFileName: string);
  Procedure CloseERPVideo;
  function FindExistingComponent(Const ComponentClassName: string): TComponent;

implementation

{$R *.dfm}

{ TfmVideo }
function FindExistingComponent(Const ComponentClassName: string): TComponent; 
var
  X: integer;
begin
  Result := nil;
  for x := 0 to Application.ComponentCount - 1 do begin
    if uppercase(Application.Components[x].ClassName) = uppercase(ComponentClassName) Then Begin
        Result := Application.Components[x];
        Exit;
    end;
  end;
end;
Procedure CloseERPVideo;
var
  form :TComponent;
begin
  form:= FindExistingComponent('TfmVideo');
  if Assigned(form) then  TfmVideo(form).Close;
end;

Procedure PlayERPVideo(const aFileName: string);
var
  fmVideo: TfmVideo;
  form :TComponent;
  Function ISMdiParentvisible:Boolean;
  begin
      Result := False;
      if Assigned(Application.mainform) then
        if Application.mainform.visible then
          if not(fsShowing in Application.mainform.FormState) then
            if Application.mainform.FormStyle = fsMDIForm then
              Result := True;

  end;
begin
  if not(FileExists(aFileName)) then exit;
    form:= FindExistingComponent('TfmVideo');
    if Assigned(form) then  begin
      fmVideo :=  TfmVideo(form);
      if (fmvideo.Videofilename = afilename) and (fmvideo.visible) then begin
        fmVideo.bringtofront;
        exit;
      end;
    end else fmVideo := TfmVideo.create(Application);
    if fmVideo.visible =False then begin
      if (screen.activeform<> nil ) and (fsmodal in screen.activeform.formstate) then begin
        fmVideo.Show;
        fmVideo.Width:= (fmVideo.Width-fmVideo.ClientWidth) + 640;
        fmVideo.Height:= (fmVideo.Height-fmVideo.ClientHeight) + fmVideo.pnlBottom.Height + 480;
        if Application.MainForm.FormStyle = fsMDIForm then begin
          fmVideo.top := 0;
          fmVideo.Left :=Application.mainform.Width -fmVideo.Width;
        end else begin
          fmVideo.Top:= screen.activeform.Top;
          fmVideo.Left:= screen.activeform.Left + screen.activeform.Width;
        end;
      end else if ISMdiParentvisible then begin
        fmVideo.formstyle := fsMdichild;
        fmVideo.bringTofront;
        fmVideo.Width:= (fmVideo.Width-fmVideo.ClientWidth) + 640;
        fmVideo.Height:= (fmVideo.Height-fmVideo.ClientHeight) + fmVideo.pnlBottom.Height + 480;
        fmVideo.top := 0;
        fmVideo.Left :=Application.mainform.Width -fmVideo.Width;
      end else if (Application.mainform.formstyle = fsMDIForm	) then begin
        fmVideo.Show;
        fmVideo.Width:= (fmVideo.Width-fmVideo.ClientWidth) + 640;
        fmVideo.Height:= (fmVideo.Height-fmVideo.ClientHeight) + fmVideo.pnlBottom.Height + 480;
        fmVideo.Top:= Application.mainform.Top;
        fmVideo.Left :=Application.mainform.Width -fmVideo.Width;
      end else begin
        fmVideo.Show;
        fmVideo.Width:= (fmVideo.Width-fmVideo.ClientWidth) + 640;
        fmVideo.Height:= (fmVideo.Height-fmVideo.ClientHeight) + fmVideo.pnlBottom.Height + 480;
        fmVideo.Top:= Application.mainform.Top;
        fmVideo.Left:= Application.mainform.Left + Application.mainform.Width;
      end;
    end;
    fmVideo.PlayVideo(aFileName);
    fmvideo.Videofilename := afilename;
  
end;

procedure TfmVideo.PlayVideo(const aFileName: string);
begin
  if not(FileExists(aFileName)) then exit;
  MediaPlayer.FileName:= aFileName;
  MediaPlayer.Open;
  MediaPlayer.Play;
end;

procedure TfmVideo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    MediaPlayer.Stop;
    MediaPlayer.Close;
  except
  end;
  Action := caFree;
end;

procedure TfmVideo.FormCreate(Sender: TObject);
begin
  Width:= (Width-ClientWidth) + 640;
  Height:= (Height-ClientHeight) + pnlBottom.Height + 480;
  MediaPlayer.AutoOpen:= false;
  MediaPlayer.Display:= pnlMain;
  Videofilename:= '';
end;

procedure TfmVideo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then Begin
    Key := 0;
    Self.Close;
end;
end;

end.
