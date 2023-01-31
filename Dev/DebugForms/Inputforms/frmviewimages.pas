unit frmviewimages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, ExtCtrls, DNMPanel, StdCtrls, ActnList, DNMAction,
  SelectionDialog, Menus;

type
  Tfmviewimages = class(TBaseForm)
    ActionList1: TActionList;
    acttest: TDNMAction;
    sbButtons: TScrollBox;
    pnlButtons1: TDNMPanel;
    pnlmain: TDNMPanel;
    cmdExport: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmviewimages: Tfmviewimages;

implementation

uses MainSwitchFrm2, dmMainGUI, CommonLib, tcConst;

{$R *.dfm}

procedure Tfmviewimages.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure Tfmviewimages.FormCreate(Sender: TObject);
var
  ctr:Integer;
  Button : TDNMSpeedButton;
  itop, ileft:Integer;
  actNew: TDNMAction;
  i:Integer;
  r:Integer;
begin
  inherited;
  iTop:= 1;
  ileft := 1;
  i :=1 ;
  r:=1;
  for ctr:= 606 to 666 do begin
          actNew:= TDNMAction.Create(ActionList1);
          actNew.ClassExecute:= Self.ClassName;
          actNew.Caption:= 'Image : ' + inttostr(ctr);
          actNew.Checked:= true;
          actNew.Enabled:= true;
          actNew.ImageIndex := ctr;
          //actNew.GroupIndex:= actSrc.GroupIndex;
          actNew.OnExecute:= dtmMainGUI.AnyActionExecute;
          actNew.Name:= 'devmodeimagetestbtn'+inttostr(ctr);
          actNew.ActionList:= ActionList1;


      Button := TDNMSpeedButton.Create(self);
      Button.Parent := pnlMain;
      Button.MaxTextDisplay := False;
      Button.ParentFont := false;
      Button.ParentColor := false;
      Button.Color := MENU_BUTTON_COLOR;
      Button.Font.Style := Button.Font.Style - [fsBold];
      Button.Font.Size := 8;
      Button.Top := itop;
      Button.Left := ileft;
      Button.Height := BUTTON_HEIGHT;
      Button.Width := BUTTON_WIDTH;
      Button.Name   := 'btndevmode' + inttostr(ctr);
      Button.Alignment := taCenter;
      Button.Layout := DNMSpeedButton.blGlyphTop;
      Button.SlowDecease := true;
      Button.HotTrackColor := BUTTON_HOT_TRACK_COLOR;
      Button.Style := bsModern;
      Button.Visible := true;
      Button.BringToFront;
      Button.WordWrap := true;
      Button.Action := actnew;
      if i =1 then button.Color := $0080FF80
      else if i = 2 then button.Color := $0080FFFF
      else if i = 3 then button.Color := $00FFFF80
      else if i = 4 then button.Color := $00FFB7FF;

      if r =1 then button.Style := TDNMSpeedButtonStyle(bsNormal)
      else if r = 2 then button.Style := TDNMSpeedButtonStyle(bsEncarta)
      else if r = 3 then button.Style := TDNMSpeedButtonStyle(bsModern)
      else if r = 4 then button.Style := TDNMSpeedButtonStyle(bsOld);



      i:= i+1;
      if i>=5 then i:= 1;
      ileft := ileft  +button.Width + 5;
      if iLeft > Self.Width - button.Width then begin
        ileft := 1;
        iTop := itop  +button.Height + 5;
        r:= r+1;
      end;
  end;
end;

initialization
  RegisterClassOnce(Tfmviewimages);
end.

