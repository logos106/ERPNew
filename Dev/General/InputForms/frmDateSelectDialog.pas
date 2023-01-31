unit frmDateSelectDialog;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/01/06  1.00.01  AL  Initial Version
 15/03/06  1.00.02  DSP Made form for general use.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, ExtCtrls, ComCtrls,AdvOfficeStatusBar, StdCtrls, Buttons, DNMSpeedButton, BaseInputForm, DNMPanel,
  Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, ProgressDialog, MemDS, ImgList;

type
  TfmDateSelectDialog = class(TBaseInputGUI)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Panel1: TPanel;
    Calendar: TMonthCalendar;
    procedure FormCreate(Sender: TObject);
    procedure CalendarDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    fbshowAtcursor: Boolean;
  public
    Class Function SelectDateAtCursor(const ACaption: string; var Value: TDateTime;AOwner:Tcomponent; backcolour :TColor = 0 ): Boolean;

    Property ShowAtCursor:Boolean read fbshowAtcursor write fbShowAtCursor;
  end;

implementation

uses
  Forms, CommonLib, MAIN;

{$R *.dfm}

procedure TfmDateSelectDialog.FormActivate(Sender: TObject);
begin
  inherited;
  if ShowAtCursor then begin
    Top :=Mouse.CursorPos.Y- trunc(Self.height/2)(*Tform(Owner).top - Mainform.MainToolBar.Height-Calendar.top-30*);
    Left :=Mouse.CursorPos.X- trunc(Self.Width/2)(*Tform(Owner).LEft-Calendar.left -10*);
  end;
end;

procedure TfmDateSelectDialog.FormCreate(Sender: TObject);
begin
  inherited;
  Calendar.Date := Now;
  showAtcursor:= False;
end;

class function TfmDateSelectDialog.SelectDateAtCursor(const ACaption: string; var Value: TDateTime;AOwner:Tcomponent; backcolour :TColor = 0 ): Boolean;
var
  form: TfmDateSelectDialog;
begin
  form := TfmDateSelectDialog.Create(AOwner);
  try
    form.IgnoreAccessLevels := true;
    form.Caption := ACaption;
    form.Calendar.Date := Value;
    form.ShowAtCursor:= True;
    if backcolour <> 0 then form.color := backcolour;
    result := form.ShowModal = mrOk;
    if result then
      Value := form.Calendar.Date;
  finally
    form.Free;
  end;

end;

procedure TfmDateSelectDialog.CalendarDblClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOK;
end;

initialization
  RegisterClassOnce(TfmDateSelectDialog);
end.
