unit AppScreenResUnit;

interface

uses
  Windows, Messages, Dialogs;

type
  TAppResolution = class
    FOriginalWidth,
    FOriginalHeight,
    FWidth,
    FHeight,
    FOriginalPitsPerPel: DWORD;
    FEnabled: boolean;
    function Change(XResolution, YResolution, Depth: DWORD): BOOL;
  public
    constructor Create(Width, Height: DWORD); virtual;
    destructor Destroy; override;
    procedure SetResolution(Sender: TObject);
    procedure Restore(Sender: TObject);
  end;

implementation

uses Forms, CommonLib, SysUtils;

constructor TAppResolution.Create(Width, Height: DWORD);
var
  f: TForm;
begin
  inherited Create;
  FEnabled := false;
  f := TForm.Create(nil);
  try
    FWidth          := Width;
    FHeight         := Height;
    FOriginalWidth  := Screen.Width;
    FOriginalHeight := Screen.Height;
    FOriginalPitsPerPel :=
      GetDeviceCaps(f.Canvas.Handle, BITSPIXEL) * GetDeviceCaps(f.Canvas.Handle, PLANES);
    if FOriginalWidth < Width then begin
      FEnabled := true;
    end;
  finally
    FreeandNil(f);
  end;
end;//Create

destructor TAppResolution.Destroy;
begin
  Restore(nil);
  Application.OnActivate := nil;
  Application.OnDeactivate := nil;
  inherited;
end;

function TAppResolution.Change(XResolution, YResolution, Depth: DWORD): BOOL;
var
  DevMode: TDeviceMode;
  i: integer;
begin
  Result := false;
  i := 0;
  while EnumDisplaySettings(nil, i, DevMode) do with DevMode do begin
    if (dmPelsWidth = XResolution) and
      (dmPelsHeight = YResolution) and
      (dmBitsPerPel = Depth) then if ChangeDisplaySettings(DevMode, CDS_UPDATEREGISTRY) =
        DISP_CHANGE_SUCCESSFUL then begin
        Result := true;
        SendMessage(HWND_BROADCAST, WM_DISPLAYCHANGE, SPI_SETNONCLIENTMETRICS, 0);
        Break;
      end;
    Inc(i);
  end;
end;

procedure TAppResolution.SetResolution(Sender: TObject);
  // try the best the video card has to offer...
begin
  if FEnabled then begin
    if not Change(FWidth, FHeight, 32) then if not Change(FWidth, FHeight, 24) then
        if not Change(FWidth, FHeight, 16) then if not Change(FWidth, FHeight, 8) then begin
            CommonLib.MessageDlgXP_Vista('Could not change resolution', mtInformation , [mbOK], 0);
            Exit;
          end;   
            
    Application.OnActivate   := SetResolution;
    Application.OnDeactivate := Restore;
  end;
end;

{ TAppResolution.Restore-------------------------------------------------------}
procedure TAppResolution.Restore(Sender: TObject);
begin
  if FEnabled then if not Change(FOriginalWidth, FOriginalHeight, FOriginalPitsPerPel) then
      CommonLib.MessageDlgXP_Vista('Could not change resolution', mtInformation , [mbOK], 0);
end;

end.
