unit frmActivePopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frmBase;

type
  TfrmActiveWindows = class(TfrmBaseGUI)
    lbActiveWindows: TListBox;
    procedure lbActiveWindowsClick(Sender: TObject);
    function GetTaskBarHeight:integer;
  private
    { Private declarations }
  Protected
    function ignorelogInuseform:boolean;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

function TFrmActiveWindows.GetTaskBarHeight:integer;
var
  hTaskBarWindow : HWnd;
  Rect : TRect;
  Height : Integer;
begin
  hTaskBarWindow:=FindWindow('Shell_TrayWnd',nil);
  GetWindowRect( hTaskBarWindow, Rect );
  Height := Rect.Bottom - Rect.Top;
  result:= height;
end;

function TfrmActiveWindows.ignorelogInuseform: boolean;
begin
  REsult := True;
end;

procedure TfrmActiveWindows.lbActiveWindowsClick(Sender: TObject);
var
  O: TObject;
begin
  // bring up the active window
  if lbActiveWindows.ItemIndex <> -1 then begin
    O := lbActiveWindows.Items.Objects[lbActiveWindows.ItemIndex];

    if Assigned(O) and (O is TForm) then begin
      O := FindExistingComponent(TForm(O).ClassName);

      if Assigned(O) and (O is TForm) then begin
        if TForm(O).WindowState = wsMinimized then begin
          TForm(O).WindowState := wsNormal; // to do
        end;

        TForm(O).BringToFront;
        Hide;
      end;  
    end;
  end;
end;
initialization
  RegisterClassOnce(TFrmActiveWindows);
end.
